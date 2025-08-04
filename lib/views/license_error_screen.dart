import 'dart:io';

import 'package:flutter/material.dart';

class LicenseErrorScreen extends StatelessWidget {
  const LicenseErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red.shade50,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.block, size: 80, color: Colors.red.shade700),
              const SizedBox(height: 20),
              Text(
                'Product Not Activated',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.red.shade700,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'This copy is not licensed for this machine.\nPlease contact the developer.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                icon: const Icon(Icons.exit_to_app),
                label: const Text('Exit'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  exit(0);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
