import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';

class LicenseValidator {
  static final String licenseFilePath =
      File(Platform.resolvedExecutable).parent.path +
      Platform.pathSeparator +
      'license_keys.txt';

  // Load all license keys from the file
  static Future<List<String>> loadValidKeys() async {
    try {
      final file = File(licenseFilePath);
      if (await file.exists()) {
        final lines = await file.readAsLines();
        return lines
            .map((e) => e.trim().toUpperCase())
            .where((e) => e.isNotEmpty)
            .toList();
      }
    } catch (e) {
      print("Error loading license file: $e");
    }
    return [];
  }

  static Future<bool> validateAndStoreLicense(String inputKey) async {
    final key = inputKey.trim().toUpperCase();
    final validKeys = await loadValidKeys();

    if (validKeys.contains(key)) {
      await _removeUsedKey(key);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('license', key);
      return true;
    }
    return false;
  }

  static Future<bool> validateStoredLicense() async {
    final prefs = await SharedPreferences.getInstance();
    final key = prefs.getString('license');
    return key != null && key.isNotEmpty;
  }

  static Future<void> _removeUsedKey(String usedKey) async {
    try {
      final file = File(licenseFilePath);
      if (await file.exists()) {
        final lines = await file.readAsLines();
        final updatedLines = lines
            .where((line) => line.trim().toUpperCase() != usedKey)
            .toList();
        await file.writeAsString(updatedLines.join('\n'));
      }
    } catch (e) {
      print("Error removing used key: $e");
    }
  }
}
