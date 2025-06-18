import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'database_helper.dart';

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

    final hashedPassword = _hashPassword(rawPassword);

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
      // Navigate to another screen or update the state
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Incorrect password.')));
    }
  }

  String _hashPassword(String password) {
    final bytes = utf8.encode(password);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Login to your account', style: TextStyle(fontSize: 24)),
          const SizedBox(height: 30),

          // Username field
          SizedBox(
            width: 300,
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
            width: 300,
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

          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Colors.deepPurple,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            ),
            onPressed: _handleLogin,
            child: const Text('Login'),
          ),
        ],
      ),
    );
  }
}
