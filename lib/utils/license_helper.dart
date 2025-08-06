import 'dart:convert';
import 'package:system_info2/system_info2.dart';
import 'package:crypto/crypto.dart';

Future<String> getHashedMachineId() async {
  final core = SysInfo.cores.first;
  final cpu = '${core.vendor}-${core.name}';
  final ram = SysInfo.getTotalPhysicalMemory();

  final raw = '$cpu-$ram';
  final hash = sha256.convert(utf8.encode(raw));

  return hash.toString().substring(0, 8); // e.g. "1234abcd"
}
