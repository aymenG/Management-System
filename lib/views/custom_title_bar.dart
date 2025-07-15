import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

class CustomTitleBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomTitleBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: preferredSize.height,
      color: Theme.of(context).primaryColor, // Or any color you prefer
      child: Row(
        children: [
          Spacer(), // Pushes the buttons to the right
          // Minimize Button
          IconButton(
            icon: Icon(Icons.minimize, color: Colors.black),
            onPressed: () async {
              await windowManager.minimize();
            },
          ),
          // Close Button
          IconButton(
            icon: Icon(Icons.close, color: Colors.black),
            onPressed: () async {
              // You can add a confirmation dialog before closing
              bool? doClose = await showDialog<bool>(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Confirm Exit'),
                    content: const Text(
                      'Are you sure you want to close the application?',
                    ),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(true),
                        child: const Text('Exit'),
                      ),
                    ],
                  );
                },
              );

              if (doClose == true) {
                await windowManager.destroy(); // Properly close the app
              }
            },
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight); // Standard AppBar height
}
