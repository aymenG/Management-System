import 'package:flutter/material.dart';
import 'package:management_system/views/LoginForm.dart';
import 'package:management_system/license/license_validator.dart';

class ActivationScreen extends StatefulWidget {
  const ActivationScreen({super.key});

  @override
  State<ActivationScreen> createState() => _ActivationScreenState();
}

class _ActivationScreenState extends State<ActivationScreen> {
  final TextEditingController _licenseController = TextEditingController();
  String message = '';

  Future<void> _validateLicense() async {
    final input = _licenseController.text.trim();
    final isValid = await LicenseValidator.validateAndStoreLicense(input);

    if (isValid) {
      if (!mounted) return;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const Scaffold(body: LoginFormWidget()),
        ),
      );
    } else {
      setState(() {
        message = "Invalid license key. Please try again.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 400,
          child: Card(
            margin: const EdgeInsets.all(16),
            elevation: 8,
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Activate Your App",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _licenseController,
                    decoration: const InputDecoration(
                      labelText: 'Enter your license key',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _validateLicense,
                    child: const Text("Validate"),
                  ),
                  const SizedBox(height: 12),
                  Text(message, style: const TextStyle(color: Colors.red)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
