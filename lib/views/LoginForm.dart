import 'package:management_system/views/crs_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../controllers/database_helper.dart';
import '../controllers/my_scripts.dart';

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
    final username = _usernameController.text.trim();
    final rawPassword = _passwordController.text;
    if (username.isEmpty || rawPassword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter both username and password.'),
        ),
      );
      return;
    }

    final hashedPassword = hashPassword(rawPassword);

    final user = await _dbHelper.getUserByUsername(username);

    if (user == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('User not found.')));

      return;
    }

    if (user['hashed_password'] == hashedPassword) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Welcome, $username!')));
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => CRSDashboard()),
      );
      // Navigate to another screen or update the state
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Incorrect password.')));
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get screen width to make decisions
    final screenWidth = MediaQuery.of(context).size.width;
    // Define a breakpoint for when to switch from Row to Column layout
    const double breakpoint = 600.0; // Example breakpoint (you can adjust this)

    return Container(
      padding: const EdgeInsets.all(16),
      alignment: Alignment.center,
      child: screenWidth > breakpoint
          ? Row(
              // Desktop/Tablet Layout
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Image on the left
                Expanded(
                  flex: 1, // Takes 1 part of available space
                  child: Center(
                    // Center the SVG within its expanded space
                    child: SvgPicture.asset(
                      'assets/images/login.svg',
                      height:
                          MediaQuery.of(context).size.height *
                          0.5, // Make SVG height responsive
                      width:
                          MediaQuery.of(context).size.width *
                          0.3, // Make SVG width responsive
                      fit: BoxFit
                          .contain, // Ensures the SVG fits without clipping
                    ),
                  ),
                ),
                SizedBox(
                  width: 50,
                ), // Fixed gap (you might want this to be responsive too)
                // Login Form on the right
                Expanded(
                  flex: 1, // Takes 1 part of available space
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min, // Use min to wrap content
                    children: [
                      const Text(
                        'Login to your account',
                        style: TextStyle(fontSize: 24),
                      ),
                      const SizedBox(height: 30),

                      // Username field
                      SizedBox(
                        width:
                            300, // You can keep a max width, or make this responsive too
                        child: TextField(
                          controller: _usernameController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Enter your username',
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Password field
                      SizedBox(
                        width: 300, // You can keep a max width
                        child: TextField(
                          controller: _passwordController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Enter your password',
                          ),
                          obscureText: true,
                          enableSuggestions: false,
                          autocorrect: false,
                        ),
                      ),

                      const SizedBox(height: 30),

                      SizedBox(
                        width: 200, // Fixed width
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
                          child: const Text('Login'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          : SingleChildScrollView(
              // Mobile Layout (Image and form stacked vertically)
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment:
                    CrossAxisAlignment.center, // Center items horizontally
                children: [
                  // Image at the top for mobile
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: SvgPicture.asset(
                      'assets/images/login.svg',
                      height:
                          MediaQuery.of(context).size.height *
                          0.3, // Smaller SVG for mobile
                      fit: BoxFit.contain,
                    ),
                  ),
                  const Text(
                    'Login to your account',
                    style: TextStyle(fontSize: 24),
                  ),
                  const SizedBox(height: 30),

                  // Username field (full width on small screens)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                    ), // Add horizontal padding
                    child: TextField(
                      controller: _usernameController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Enter your username',
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Password field (full width on small screens)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                    ), // Add horizontal padding
                    child: TextField(
                      controller: _passwordController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Enter your password',
                      ),
                      obscureText: true,
                      enableSuggestions: false,
                      autocorrect: false,
                    ),
                  ),

                  const SizedBox(height: 30),

                  SizedBox(
                    width:
                        200, // You can adjust this for mobile if needed, or make it flexible
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
                      child: const Text('Login'),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
