import 'dart:convert';
import 'dart:io';
import 'package:encrypt/encrypt.dart';
import 'package:management_system/license/machine_id.dart';

class LicenseValidator {
  static const String licenseFilePath = 'license.key'; // next to executable
  static const String secretKey =
      'your-very-secure-key'; // same key as generator

  static Future<bool> validateLicense() async {
    try {
      final licenseFile = File(licenseFilePath);
      if (!licenseFile.existsSync()) return false;

      final encrypted = await licenseFile.readAsString();
      final decrypted = _decryptLicense(encrypted);
      final licenseMap = jsonDecode(decrypted);

      final savedHwId = licenseMap['hardwareId'];
      final expiresAt = DateTime.parse(licenseMap['expiresAt']);
      final currentHwId = await getMachineId();

      final now = DateTime.now();

      return savedHwId == currentHwId && now.isBefore(expiresAt);
    } catch (e) {
      print("🔐 License validation failed: $e");
      return false;
    }
  }

  static String _decryptLicense(String encrypted) {
    final key = Key.fromUtf8(secretKey.padRight(32).substring(0, 32));
    final iv = IV.fromLength(16);
    final encrypter = Encrypter(AES(key));
    return encrypter.decrypt64(encrypted, iv: iv);
  }
}
