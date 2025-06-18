import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';

class loginFormWidget extends StatelessWidget {
  const loginFormWidget({
    super.key,
    required TextEditingController passwordController,
  }) : _passwordController = passwordController;

  final TextEditingController _passwordController;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text('Login to your account', style: TextStyle(fontSize: 36)),

          const SizedBox(height: 50),
          SizedBox(
            width: 300,
            child: TextField(
              controller: _passwordController,
              decoration: InputDecoration(
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
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            ),
            onPressed: () async {
              String rawPassword = _passwordController.text;

              if (rawPassword.isEmpty) {
                print('Password field is empty. Not hashing.');
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Please enter a password.')),
                );
                return;
              }

              // Convert the password string to a list of bytes
              var bytes = utf8.encode(rawPassword); // data being hashed

              // Hash the bytes using SHA-256
              var digest = sha256.convert(bytes);

              // Get the hash as a hexadecimal string
              String hashedPassword = digest.toString();

              // Print the hashed password to the console
              print('Original password (not printed directly): [Hidden]');
              print('Hashed password (SHA-256): $hashedPassword');

              // Optionally, show a SnackBar to confirm action to the user (without revealing password)
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Password hashed and logged to console.'),
                ),
              );
            },
            child: const Text('Login'),
          ),
        ],
      ),
    );
  }
}
