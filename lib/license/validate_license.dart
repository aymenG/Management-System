import 'dart:io';
import 'dart:convert';
import 'package:crypto/crypto.dart';

import 'machine_id.dart' as MachineId;

class LicenseValidator {
  static Future<bool> isLicenseValid() async {
    try {
      final machineId = await MachineId.getMachineId();
      final licenseFile = File('license.key');
      if (!await licenseFile.exists()) return false;

      final storedLicense = await licenseFile.readAsString();
      final hashed = sha256.convert(utf8.encode(machineId)).toString();

      return hashed == storedLicense.trim();
    } catch (e) {
      return false;
    }
  }
}
