import 'package:ClinicManagementSystem/views/LoginForm.dart';
import 'package:ClinicManagementSystem/views/custom_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:path/path.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],

      appBar: AppBar(
        title: const Text('Dashboard'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomCard(
                svgPath: 'assets/images/browse.svg',
                label: 'Browse Users',
                onTap: () {
                  print('Browse Users tapped!');
                },
              ),
              SizedBox(width: 16),
              CustomCard(
                svgPath: 'assets/images/edit.svg',
                label: 'Edit User',
                onTap: () {
                  print('Edit User tapped!');
                },
              ),
              SizedBox(width: 16),

              CustomCard(
                svgPath: 'assets/images/add.svg',
                label: 'Add User',
                onTap: () {
                  print('Add User tapped!');
                },
              ),
              SizedBox(width: 16),
              CustomCard(
                svgPath: 'assets/images/delete.svg',
                label: 'Delete User',
                onTap: () {
                  print('Delete User tapped!');
                },
              ),
            ],
          ),

          const WelcomeDashboard(),
        ],
      ),
    );
  }
}

class WelcomeDashboard extends StatelessWidget {
  const WelcomeDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
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
    );
  }
}
