import 'dart:convert';
import 'dart:io';
import 'package:crypto/crypto.dart';

Future<String> getMachineId() async {
  if (Platform.isWindows) {
    try {
      final result = await Process.run('wmic', [
        'csproduct',
        'get',
        'UUID',
      ], runInShell: true);

      final output = result.stdout.toString();
      final uuid = output.split('\n')[1].trim();

      return sha256.convert(utf8.encode(uuid)).toString();
    } catch (e) {
      print("❌ Failed to get hardware ID: $e");
      return 'unknown';
    }
  }

  return 'unknown'; // fallback for non-Windows (to be improved)
}
