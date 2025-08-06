import 'package:shared_preferences/shared_preferences.dart';

class LicenseValidator {
  static const List<String> validKeys = [
    "8ZPD-WX27-MQK3",
    "T5XK-JH29-QWLM",
    // Add more keys here
  ];

  static Future<bool> validateAndStoreLicense(String inputKey) async {
    final key = inputKey.trim().toUpperCase();
    if (validKeys.contains(key)) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('license', key);
      return true;
    }
    return false;
  }

  static Future<bool> validateStoredLicense() async {
    final prefs = await SharedPreferences.getInstance();
    final storedKey = prefs.getString('license');
    if (storedKey == null) return false;
    return validKeys.contains(storedKey.toUpperCase());
  }
}
