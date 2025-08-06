import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:management_system/license/license_validator.dart';
import 'package:management_system/views/activation_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:window_manager/window_manager.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'l10n/app_localizations.dart';
import 'views/LoginForm.dart';
import 'views/license_error_screen.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
Locale? savedLocale;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await windowManager.ensureInitialized();

  if (defaultTargetPlatform == TargetPlatform.windows ||
      defaultTargetPlatform == TargetPlatform.linux ||
      defaultTargetPlatform == TargetPlatform.macOS) {
    sqfliteFfiInit();
  }

  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? localeCode = prefs.getString('selectedLocale');
  if (localeCode != null) {
    savedLocale = Locale(localeCode);
  }

  final Locale initialWindowLocale = savedLocale ?? const Locale('en');
  final AppLocalizations tempLocalizations = await AppLocalizations.delegate
      .load(initialWindowLocale);

  WindowOptions windowOptions = WindowOptions(
    center: true,
    backgroundColor: Colors.transparent,
    skipTaskbar: false,
    title: tempLocalizations.appTitle,
    minimumSize: const Size(800, 600),
  );

  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.setTitle(tempLocalizations.appTitle);
    await windowManager.maximize();
    await windowManager.setResizable(false);
    await windowManager.show();
    await windowManager.focus();
  });

  await windowManager.setPreventClose(true);
  windowManager.addListener(AppWindowListener());

  final licenseValid = await LicenseValidator.validateStoredLicense();

  runApp(MainApp(licenseValid: licenseValid));
}

class AppWindowListener with WindowListener {
  @override
  void onWindowClose() async {
    if (navigatorKey.currentContext == null) {
      await windowManager.destroy();
      return;
    }

    final shouldClose = await showDialog<bool>(
      context: navigatorKey.currentContext!,
      builder: (context) {
        final localizer = AppLocalizations.of(context)!;
        return AlertDialog(
          title: Text(localizer.confirmExit),
          content: Text(localizer.areYouSureToClose),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(localizer.cancelButton),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text(localizer.closeButton),
            ),
          ],
        );
      },
    );

    if (shouldClose == true) {
      await windowManager.destroy();
    }
  }
}

class MainApp extends StatefulWidget {
  final bool licenseValid;
  const MainApp({super.key, required this.licenseValid});

  static void setLocale(BuildContext context, Locale newLocale) async {
    _MainAppState? state = context.findAncestorStateOfType<_MainAppState>();
    state?.setLocale(newLocale);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedLocale', newLocale.languageCode);
  }

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  Locale? _locale;

  @override
  void initState() {
    super.initState();
    _locale = savedLocale;
  }

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'Car Management System',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        textTheme: const TextTheme(
          bodyMedium: TextStyle(fontSize: 16, color: Colors.black),
          bodyLarge: TextStyle(fontSize: 18, color: Colors.black),
        ),
      ),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      locale: _locale,
      localeResolutionCallback: (locale, supportedLocales) {
        if (_locale != null) return _locale;
        for (final supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale?.languageCode) {
            return supportedLocale;
          }
        }
        return supportedLocales.first;
      },

      // ✅ Load login or blocked screen based on license
      home: widget.licenseValid
          ? const Scaffold(body: LoginFormWidget())
          : const ActivationScreen(),
    );
  }
}
