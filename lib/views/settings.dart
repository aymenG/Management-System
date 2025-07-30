import 'package:flutter/material.dart';
import 'package:management_system/controllers/database_helper.dart';
import 'package:management_system/views/custom_button.dart'; // Assuming CustomActionButton is here
import 'package:management_system/l10n/app_localizations.dart'; // Import AppLocalizations
import '../../controllers/my_scripts.dart'; // For hashPassword

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _currentPasswordController =
      TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();

  String? _currentUsername;
  final DatabaseHelper _dbHelper = DatabaseHelper();

  @override
  void initState() {
    super.initState();
    _loadAdminData();
  }

  Future<void> _loadAdminData() async {
    final admin = await _dbHelper.getAdmin();
    if (admin != null) {
      setState(() {
        _currentUsername = admin['username'];
        _usernameController.text = admin['username'];
      });
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    super.dispose();
  }

  Future<void> _handleUpdate() async {
    final AppLocalizations localizations = AppLocalizations.of(
      context,
    )!; // Get localizations
    final username = _usernameController.text.trim();
    final currentPassword = _currentPasswordController.text;
    final newPassword = _newPasswordController.text;

    if (username.isEmpty || currentPassword.isEmpty) {
      _showSnackBar(localizations.settingsFillRequiredFields); // Localized
      return;
    }

    final admin = await _dbHelper.getAdmin();
    if (admin == null) {
      _showSnackBar(localizations.settingsAdminNotFound); // Localized
      return;
    }

    // ✅ Verify the password manually by hashing and comparing
    final hashedInput = hashPassword(currentPassword);
    final storedHashedPassword = admin['hashed_password'];

    if (hashedInput != storedHashedPassword) {
      _showSnackBar(
        localizations.settingsCurrentPasswordIncorrect,
      ); // Localized
      return;
    }

    final db = await _dbHelper.database;
    final updateData = <String, dynamic>{'username': username};

    if (newPassword.isNotEmpty) {
      updateData['hashed_password'] = hashPassword(newPassword);
    }

    await db.update(
      'users',
      updateData,
      where: 'id = ?',
      whereArgs: [admin['id']],
    );

    _showSnackBar(localizations.settingsCredentialsUpdatedSuccess); // Localized
    _currentPasswordController.clear();
    _newPasswordController.clear();
    _loadAdminData(); // refresh displayed username
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations localizations = AppLocalizations.of(
      context,
    )!; // Get localizations

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            localizations.settingsPageTitle, // Localized
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          SettingsCard(
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.deepPurple,
                  child: Icon(
                    Icons.admin_panel_settings,
                    size: 40,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _currentUsername ??
                          localizations
                              .settingsAdminDefaultUsername, // Localized fallback
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      localizations.settingsAdminRole, // Localized
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          SettingsCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  localizations.settingsUpdateCredentialsTitle, // Localized
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    labelText: localizations.settingsUsernameLabel, // Localized
                    border: const OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _currentPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText:
                        localizations.settingsCurrentPasswordLabel, // Localized
                    border: const OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _newPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText:
                        localizations.settingsNewPasswordLabel, // Localized
                    border: const OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                Center(
                  child: CustomActionButton(
                    onPressed: _handleUpdate,
                    icon: Icons.save,
                    label: localizations.settingsSaveChangesButton, // Localized
                    color: Colors.deepPurple,
                  ),
                ),
              ],
            ),
          ),
        ],
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
