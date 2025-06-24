import 'package:ClinicManagementSystem/views/LoginForm.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Text(
              'Welcome to the Dashboard',
              style: TextStyle(fontSize: 36, color: Colors.deepPurple),
            ),
          ),
          SizedBox(
            width: 200, // Fixed width
            height: 60,
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
                textStyle: const TextStyle(
                  fontSize: 22.0, // Larger font size
                ),
              ),

              onPressed: () {
                Navigator.pop(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        LoginFormWidget(), // Navigate back to the LoginForm
                  ),
                );
              },
              child: const Text('Back'),
            ),
          ),
        ],
      ),
    );
  }
}
