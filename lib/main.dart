import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:window_manager/window_manager.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'l10n/app_localizations.dart'; // Ensure this import is correct
import 'views/LoginForm.dart'; // Your login form widget

// GlobalKey for NavigatorState to access context for dialogs outside the widget tree
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

// Global variable to hold the initially loaded locale preference
Locale? savedLocale;

void main() async {
  // Ensure Flutter widgets binding is initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Ensure window_manager is initialized for desktop applications
  await windowManager.ensureInitialized();

  // Initialize sqflite FFI if needed for desktop platforms (Windows, Linux, macOS)
  if (defaultTargetPlatform == TargetPlatform.windows ||
      defaultTargetPlatform == TargetPlatform.linux ||
      defaultTargetPlatform == TargetPlatform.macOS) {
    sqfliteFfiInit();
  }

  // Load saved locale from SharedPreferences
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? localeCode = prefs.getString('selectedLocale');
  if (localeCode != null) {
    savedLocale = Locale(localeCode);
  }

  // To localize the window title, we need to load AppLocalizations before runApp.
  // We'll use the savedLocale if available, otherwise default to English for the initial title.
  final Locale initialWindowLocale = savedLocale ?? const Locale('en');
  // Wait for the delegate to load the localizations for the initial locale
  final AppLocalizations tempLocalizations = await AppLocalizations.delegate
      .load(initialWindowLocale);

  // Define window options, using the localized app title
  WindowOptions windowOptions = WindowOptions(
    center: true,
    backgroundColor: Colors.transparent,
    skipTaskbar: false,
    title: tempLocalizations
        .appTitle, // Use localized app title for initial window creation
    minimumSize: const Size(800, 600),
  );

  // Wait until the window is ready to show, then apply settings
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.setTitle(
      tempLocalizations.appTitle,
    ); // Set localized window title after ready
    await windowManager.maximize(); // Maximize the window for desktop
    await windowManager.setResizable(false); // Make window non-resizable
    await windowManager.show(); // Show the window
    await windowManager.focus(); // Focus the window
  });

  // Prevent the window from closing without confirmation
  await windowManager.setPreventClose(true);
  // Add an event listener for window events, specifically for closing
  windowManager.addListener(AppWindowListener());

  // Run the main Flutter application
  runApp(const MainApp());
}

/// A listener class for window events, specifically handling the window close event.
class AppWindowListener with WindowListener {
  @override
  void onWindowClose() async {
    // Check if navigatorKey.currentContext is null before using it
    if (navigatorKey.currentContext == null) {
      // If context is not available (e.g., app is shutting down or not fully initialized),
      // allow closing immediately to prevent a crash.
      await windowManager.destroy();
      return;
    }

    final shouldClose = await showDialog<bool>(
      context:
          navigatorKey.currentContext!, // Use the global navigator key context
      builder: (context) {
        // Get the AppLocalizations instance within the dialog's context for proper localization
        final localizer = AppLocalizations.of(context)!;
        return AlertDialog(
          title: Text(localizer.confirmExit), // Localized "Confirm Exit"
          content: Text(
            localizer.areYouSureToClose,
          ), // Localized "Are you sure..."
          actions: [
            TextButton(
              onPressed: () =>
                  Navigator.of(context).pop(false), // User cancels close
              child: Text(localizer.cancelButton), // Localized "Cancel" button
            ),
            TextButton(
              onPressed: () =>
                  Navigator.of(context).pop(true), // User confirms close
              child: Text(localizer.closeButton), // Localized "Close" button
            ),
          ],
        );
      },
    );

    // If the user confirms, destroy the window
    if (shouldClose == true) {
      await windowManager.destroy();
    }
  }
}

/// The root widget of your application, managing the locale state dynamically.
class MainApp extends StatefulWidget {
  const MainApp({super.key});

  /// Static method to set the application's locale from any part of the app.
  /// It finds the `_MainAppState` and calls its `setLocale` method.
  static void setLocale(BuildContext context, Locale newLocale) async {
    _MainAppState? state = context.findAncestorStateOfType<_MainAppState>();
    state?.setLocale(newLocale);

    // Save the newly selected locale to SharedPreferences for persistence
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedLocale', newLocale.languageCode);
  }

  @override
  State<MainApp> createState() => _MainAppState();
}

/// The state class for MainApp, holding and updating the current application locale.
class _MainAppState extends State<MainApp> {
  Locale? _locale;

  @override
  void initState() {
    super.initState();
    _locale =
        savedLocale; // Initialize locale with the saved locale loaded in main()
  }

  /// Updates the application's locale and triggers a rebuild of the widget tree.
  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    // IMPORTANT CHANGE: Removed the AppLocalizations.of(context)! here
    // as it can be called too early during MaterialApp's build cycle.
    // The MaterialApp's 'title' property is mainly for the app switcher/browser tab.
    // The actual desktop window title is set via windowManager.setTitle in main().

    return MaterialApp(
      navigatorKey: navigatorKey, // Assign the global navigator key for dialogs
      title: 'Car Management System', // Use a default string literal here
      debugShowCheckedModeBanner: false, // Hide the debug banner

      theme: ThemeData(
        primarySwatch: Colors.deepPurple, // Define the primary color scheme
        textTheme: const TextTheme(
          bodyMedium: TextStyle(fontSize: 16, color: Colors.black),
          bodyLarge: TextStyle(fontSize: 18, color: Colors.black),
        ),
      ),

      // Configure localization delegates
      localizationsDelegates: const [
        AppLocalizations
            .delegate, // Your app's localizations delegate (generated from .arb files)
        GlobalMaterialLocalizations.delegate, // Material widgets localizations
        GlobalWidgetsLocalizations
            .delegate, // Basic widget localizations (e.g., text direction)
        GlobalCupertinoLocalizations
            .delegate, // Cupertino widgets localizations (for iOS-style widgets)
      ],

      // Define supported locales using AppLocalizations.supportedLocales (from generated code)
      supportedLocales: AppLocalizations.supportedLocales,

      // Callback to resolve the locale based on user preference or system locale
      locale:
          _locale, // The currently selected locale (managed by _MainAppState)
      localeResolutionCallback: (locale, supportedLocales) {
        if (_locale != null) {
          return _locale; // If a specific locale is set by the user, use it
        }
        // Otherwise, try to match the system locale or fallback to the first supported one
        for (final supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale?.languageCode) {
            return supportedLocale;
          }
        }
        return supportedLocales
            .first; // Fallback to the first supported locale (e.g., English)
      },

      home: const Scaffold(body: LoginFormWidget()), // Your initial app content
    );
  }
}
