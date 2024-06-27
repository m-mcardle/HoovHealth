import 'dart:convert';
import 'package:device_info_plus/device_info_plus.dart';

Future<void> _startScan() async {
  final info = await DeviceInfoPlugin().iosInfo; // Assuming iOS for now
  final systemInfo = {
    'platform': 'ios',
    'platform_like': 'ios',
    'hostname': info.localizedModel, // Replace with appropriate method call
    'uptime': null, // Not easily available on iOS
    'processor_type': info.utsname.machine,
  };

  // Convert systemInfo to JSON
  final jsonData = jsonEncode(systemInfo);

  print(jsonData);

  // (Optional) Write JSON data to a file
  // final jsonFilePath = 'data/system_info.json';
  // final file = await File(jsonFilePath).writeAsString(jsonData);
}