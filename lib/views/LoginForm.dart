import 'package:management_system/views/crs_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../controllers/database_helper.dart';
import '../controllers/my_scripts.dart';
import 'package:management_system/l10n/app_localizations.dart'; // Import AppLocalizations

class LoginFormWidget extends StatefulWidget {
  const LoginFormWidget({super.key});

  @override
  State<LoginFormWidget> createState() => _LoginFormWidgetState();
}

class _LoginFormWidgetState extends State<LoginFormWidget> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _dbHelper = DatabaseHelper();

  void _handleLogin() async {
    // Get the localized strings
    final AppLocalizations localizations = AppLocalizations.of(context)!;

    final username = _usernameController.text.trim();
    final rawPassword = _passwordController.text;
    if (username.isEmpty || rawPassword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            localizations.loginEnterCredentials,
          ), // Localized string
        ),
      );
      return;
    }

    final hashedPassword = hashPassword(rawPassword);

    final user = await _dbHelper.getUserByUsername(username);

    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(localizations.loginUserNotFound)),
      ); // Localized string

      return;
    }

    if (user['hashed_password'] == hashedPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(localizations.loginWelcome(username))),
      ); // Localized string with placeholder
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => CRSDashboard()),
      );
      // Navigate to another screen or update the state
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(localizations.loginIncorrectPassword)),
      ); // Localized string
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get the localized strings
    final AppLocalizations localizations = AppLocalizations.of(context)!;

    final screenWidth = MediaQuery.of(context).size.width;
    const double breakpoint = 600.0;

    return Container(
      padding: const EdgeInsets.all(16),
      alignment: Alignment.center,
      child: screenWidth > breakpoint
          ? Row(
              // Desktop/Tablet Layout
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: Center(
                    child: SvgPicture.asset(
                      'assets/images/login.svg',
                      height: MediaQuery.of(context).size.height * 0.5,
                      width: MediaQuery.of(context).size.width * 0.3,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                const SizedBox(width: 50),
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        localizations.loginTitle, // Localized string
                        style: const TextStyle(fontSize: 24),
                      ),
                      const SizedBox(height: 30),

                      SizedBox(
                        width: 300,
                        child: TextField(
                          controller: _usernameController,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            labelText: localizations
                                .loginUsernameLabel, // Localized string
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      SizedBox(
                        width: 300,
                        child: TextField(
                          controller: _passwordController,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            labelText: localizations
                                .loginPasswordLabel, // Localized string
                          ),
                          obscureText: true,
                          enableSuggestions: false,
                          autocorrect: false,
                        ),
                      ),

                      const SizedBox(height: 30),

                      SizedBox(
                        width: 200,
                        height: 60,
                        child: TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.deepPurple,
                            foregroundColor: Colors.white,
                            textStyle: const TextStyle(fontSize: 22.0),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 32,
                              vertical: 16,
                            ),
                          ),
                          onPressed: _handleLogin,
                          child: Text(
                            localizations.loginButton,
                          ), // Localized string
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          : SingleChildScrollView(
              // Mobile Layout
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: SvgPicture.asset(
                      'assets/images/login.svg',
                      height: MediaQuery.of(context).size.height * 0.3,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Text(
                    localizations.loginTitle, // Localized string
                    style: const TextStyle(fontSize: 24),
                  ),
                  const SizedBox(height: 30),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: TextField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: localizations
                            .loginUsernameLabel, // Localized string
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: TextField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: localizations
                            .loginPasswordLabel, // Localized string
                      ),
                      obscureText: true,
                      enableSuggestions: false,
                      autocorrect: false,
                    ),
                  ),

                  const SizedBox(height: 30),

                  SizedBox(
                    width: 200,
                    height: 60,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        foregroundColor: Colors.white,
                        textStyle: const TextStyle(fontSize: 22.0),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 16,
                        ),
                      ),
                      onPressed: _handleLogin,
                      child: Text(
                        localizations.loginButton,
                      ), // Localized string
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
