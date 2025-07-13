import 'package:flutter/material.dart';
import 'package:management_system/views/custom_button.dart'; // Assuming CustomActionButton is defined here
import 'package:uuid/uuid.dart'; // For generating unique IDs for managers

// Define a simple Manager class
class Manager {
  final String id;
  final String username;
  bool isActive; // For enabling/disabling
  bool isArchived; // For archiving

  Manager({
    required this.id,
    required this.username,
    this.isActive = true,
    this.isArchived = false,
  });

  // Helper method to create a copy with updated properties
  Manager copyWith({
    String? id,
    String? username,
    bool? isActive,
    bool? isArchived,
  }) {
    return Manager(
      id: id ?? this.id,
      username: username ?? this.username,
      isActive: isActive ?? this.isActive,
      isArchived: isArchived ?? this.isArchived,
    );
  }
}

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final TextEditingController _currentPasswordController =
      TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();

  // Sample manager accounts (replace with actual data from a database)
  List<Manager> _managers = [
    Manager(id: const Uuid().v4(), username: 'manager1'),
    Manager(id: const Uuid().v4(), username: 'manager2', isActive: false),
    Manager(id: const Uuid().v4(), username: 'manager3', isArchived: true),
  ];

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    super.dispose();
  }

  void _handleChangePassword() {
    final currentPassword = _currentPasswordController.text;
    final newPassword = _newPasswordController.text;

    if (currentPassword.isEmpty || newPassword.isEmpty) {
      _showSnackBar('Please fill out both fields.');
      return;
    }

    // TODO: Implement password change logic (e.g., Firebase Auth update password)
    print('Changing password...');
    print('Current password: $currentPassword');
    print('New password: $newPassword');

    _showSnackBar('Password updated successfully!');

    _currentPasswordController.clear();
    _newPasswordController.clear();
  }

  // --- Manager Management Methods ---

  void _addManager(String username, String password) {
    // In a real app, you would create a user in your authentication system (e.g., Firebase Auth)
    // and then save their details to a database.
    setState(() {
      _managers.add(Manager(id: const Uuid().v4(), username: username));
    });
    _showSnackBar('Manager account "$username" created!');
  }

  void _resetManagerPassword(Manager manager) {
    // In a real app, trigger a password reset for the specific manager (e.g., Firebase Auth)
    _showSnackBar('Password reset initiated for ${manager.username}!');
    print('Resetting password for ${manager.username}');
  }

  void _toggleManagerStatus(Manager manager) {
    setState(() {
      final index = _managers.indexWhere((m) => m.id == manager.id);
      if (index != -1) {
        _managers[index] = manager.copyWith(isActive: !manager.isActive);
      }
    });
    _showSnackBar(
      '${manager.username} is now ${manager.isActive ? 'inactive' : 'active'}.',
    );
  }

  void _archiveManager(Manager manager) {
    setState(() {
      final index = _managers.indexWhere((m) => m.id == manager.id);
      if (index != -1) {
        _managers[index] = manager.copyWith(isArchived: true);
      }
    });
    _showSnackBar('${manager.username} has been archived.');
  }

  // --- Dialogs ---

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _showCreateManagerDialog() async {
    final TextEditingController usernameController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return showDialog<void>(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Create New Manager Account'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextField(
                  controller: usernameController,
                  decoration: const InputDecoration(
                    labelText: 'Username',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(dialogContext).pop();
                usernameController.dispose();
                passwordController.dispose();
              },
            ),
            ElevatedButton(
              child: const Text('Create'),
              onPressed: () {
                if (usernameController.text.isNotEmpty &&
                    passwordController.text.isNotEmpty) {
                  _addManager(usernameController.text, passwordController.text);
                  Navigator.of(dialogContext).pop();
                } else {
                  _showSnackBar('Please enter both username and password.');
                }
                usernameController.dispose();
                passwordController.dispose();
              },
            ),
          ],
        );
      },
    );
  }

  Future<bool?> _showConfirmationDialog(String title, String content) async {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(dialogContext).pop(false);
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
              ),
              child: const Text(
                'Confirm',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                Navigator.of(dialogContext).pop(true);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final activeManagers = _managers.where((m) => !m.isArchived).toList();
    final archivedManagers = _managers.where((m) => m.isArchived).toList();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Settings',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),

          // User Info Card
          SettingsCard(
            child: Row(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.deepPurple,
                  child: const Icon(
                    Icons.person,
                    size: 40,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Admin User',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Role: Administrator',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 30),

          // Change Password Card
          SettingsCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Change Password',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _currentPasswordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Current Password',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _newPasswordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'New Password',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                Center(
                  child: CustomActionButton(
                    onPressed: _handleChangePassword,
                    icon: Icons.lock_open,
                    label: 'Update Password',
                    color: Colors.deepPurple,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 30),

          // Manage Manager Accounts Section
          SettingsCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Manager Accounts',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    CustomActionButton(
                      onPressed: _showCreateManagerDialog,
                      icon: Icons.person_add,
                      label: 'Add New Manager',
                      color: Colors.deepPurple,
                      minWidth: 180,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                if (activeManagers.isEmpty && archivedManagers.isEmpty)
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Text(
                        'No manager accounts found.',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),
                if (activeManagers.isNotEmpty) ...[
                  const Text(
                    'Active Managers',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  ...activeManagers.map(
                    (manager) => _buildManagerCard(manager),
                  ),
                  const SizedBox(height: 20),
                ],
                if (archivedManagers.isNotEmpty) ...[
                  const Text(
                    'Archived Managers',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ...archivedManagers.map(
                    (manager) => _buildManagerCard(manager),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildManagerCard(Manager manager) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Icon(
              manager.isArchived
                  ? Icons.archive
                  : (manager.isActive ? Icons.check_circle : Icons.cancel),
              color: manager.isArchived
                  ? Colors.grey
                  : (manager.isActive ? Colors.green : Colors.red),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    manager.username,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      decoration: manager.isArchived
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                      color: manager.isArchived ? Colors.grey : Colors.black,
                    ),
                  ),
                  Text(
                    manager.isArchived
                        ? 'Status: Archived'
                        : (manager.isActive
                              ? 'Status: Active'
                              : 'Status: Disabled'),
                    style: TextStyle(
                      fontSize: 12,
                      color: manager.isArchived ? Colors.grey : Colors.blueGrey,
                    ),
                  ),
                ],
              ),
            ),
            // Action buttons
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Reset Password Button
                IconButton(
                  icon: const Icon(Icons.vpn_key, color: Colors.deepPurple),
                  tooltip: 'Reset Password',
                  onPressed: manager.isArchived
                      ? null
                      : () async {
                          final confirmed = await _showConfirmationDialog(
                            'Reset Password',
                            'Are you sure you want to reset the password for ${manager.username}?',
                          );
                          if (confirmed == true) {
                            _resetManagerPassword(manager);
                          }
                        },
                ),
                // Toggle Status Button
                IconButton(
                  icon: Icon(
                    manager.isActive ? Icons.person_off : Icons.person,
                    color: manager.isActive ? Colors.red : Colors.green,
                  ),
                  tooltip: manager.isActive
                      ? 'Disable Account'
                      : 'Enable Account',
                  onPressed: manager.isArchived
                      ? null
                      : () async {
                          final action = manager.isActive
                              ? 'disable'
                              : 'enable';
                          final confirmed = await _showConfirmationDialog(
                            'Confirm Action',
                            'Are you sure you want to $action ${manager.username}\'s account?',
                          );
                          if (confirmed == true) {
                            _toggleManagerStatus(manager);
                          }
                        },
                ),
                // Archive Button
                IconButton(
                  icon: Icon(
                    Icons.archive,
                    color: manager.isArchived ? Colors.grey : Colors.purple,
                  ),
                  tooltip: manager.isArchived
                      ? 'Already Archived'
                      : 'Archive Account',
                  onPressed: manager.isArchived
                      ? null
                      : () async {
                          final confirmed = await _showConfirmationDialog(
                            'Archive Account',
                            'Are you sure you want to archive ${manager.username}\'s account? This will hide it from active lists.',
                          );
                          if (confirmed == true) {
                            _archiveManager(manager);
                          }
                        },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class SettingsCard extends StatelessWidget {
  final Widget child;

  const SettingsCard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(padding: const EdgeInsets.all(16.0), child: child),
    );
  }
}
