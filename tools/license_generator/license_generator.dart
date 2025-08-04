import 'dart:convert';
import 'dart:io';
import 'package:encrypt/encrypt.dart';
import 'package:crypto/crypto.dart';
import 'package:uuid/uuid.dart';

/// Generates a mock hardware ID (in production, you'll extract this per OS)
String getHardwareId() {
  final uuid = Uuid();
  return uuid.v4(); // Replace this with real hardware info if needed
}

/// Encrypt license data
String encryptLicense(String plainText, String secretKey) {
  final key = Key.fromUtf8(secretKey.padRight(32).substring(0, 32));
  final iv = IV.fromLength(16);
  final encrypter = Encrypter(AES(key));
  return encrypter.encrypt(plainText, iv: iv).base64;
}

/// Save the license file to disk
void saveLicenseToFile(String encryptedLicense, String filePath) {
  final file = File(filePath);
  file.writeAsStringSync(encryptedLicense);
  print('✅ License saved to $filePath');
}

void main() {
  final hardwareId = getHardwareId(); // later replaced with real ID
  final expiryDate = DateTime.now().add(Duration(days: 365)).toIso8601String();

  final licenseJson = jsonEncode({
    'hardwareId': hardwareId,
    'issuedAt': DateTime.now().toIso8601String(),
    'expiresAt': expiryDate,
  });

  const secretKey = 'your-very-secure-key'; // Use the same key in Flutter app

  final encrypted = encryptLicense(licenseJson, secretKey);

  final outputPath = 'license.key';
  saveLicenseToFile(encrypted, outputPath);
}
