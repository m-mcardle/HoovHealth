import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/material.dart';
import 'package:hoov_health/backend/os.dart';
import 'package:path_provider/path_provider.dart';

import 'bluetooth.dart';
import 'db/db.dart';

class StateModel extends ChangeNotifier {
  DatabaseHelper databaseHelper = DatabaseHelper.instance;
  BluetoothData? bluetoothData;
  OperatingSystemData? osVersion;

  Metric overallHealth = Metric(
    type: MetricType.overallHealth,
    title: 'Overall Health',
    icon: Icons.favorite,
    mainColor: Colors.red,
    secondaryColor: Colors.red[200]!,
    score: 69,
    page_url: '/overallHealth',
  );
  Map<MetricType, Metric> metricsMap = {
    MetricType.bluetoothHealth: Metric(
      type: MetricType.bluetoothHealth,
      title: 'Bluetooth Health',
      icon: Icons.bluetooth,
      mainColor: Color.fromARGB(255, 123, 212, 234),
      secondaryColor: Color.fromARGB(255, 123, 212, 234),
      score: 69,
      page_url: '/bluetoothHealth',
    ),
    MetricType.wifiHealth: Metric(
      type: MetricType.wifiHealth,
      title: 'Wifi Health',
      icon: Icons.wifi,
      mainColor: Color.fromARGB(255, 161, 238, 189),
      secondaryColor: Color.fromARGB(255, 161, 238, 189),
      score: 69,
      page_url: '/wifiHealth',
    ),
    MetricType.systemHealth: Metric(
      type: MetricType.systemHealth,
      title: 'System Health',
      icon: Icons.computer,
      mainColor: Color.fromARGB(255, 255, 208, 150),
      secondaryColor: Color.fromARGB(255, 255, 208, 150),
      score: 69,
      page_url: '/systemHealth',
    ),
    MetricType.otherHealth: Metric(
      type: MetricType.otherHealth,
      title: 'Other Health',
      icon: Icons.devices_other,
      mainColor: Color.fromARGB(255, 190, 173, 250),
      secondaryColor: Color.fromARGB(255, 190, 173, 250),
      score: 69,
      page_url: '/otherHealth',
    ),
  };

  // void updateMetric(Metric metric) {
  //   metricsMap[metric.type] = metric;
  //   notifyListeners();

  //   var filename = 'unknown.json';
  //   switch (metric.type) {
  //     case MetricType.bluetoothHealth:
  //       filename = 'bluetooth.json';
  //       break;
  //     case MetricType.wifiHealth:
  //       filename = 'wifi_info.json';
  //       break;
  //     case MetricType.systemHealth:
  //       filename = 'system_info.json';
  //       break;
  //     case MetricType.otherHealth:
  //       filename = 'running_apps.json';
  //       break;
  //     default:
  //       break;
  //   }

  //   _saveMetricAsset(json.encode(toJson()), filename);
  // }

  StateModel({
    required this.bluetoothData,
  });

  Map<String, dynamic> toJson() {
    return {
      'metrics': metricsMap.values.map((metric) => {
        'type': metric.type,
        'title': metric.title,
        'mainColor': metric.mainColor,
        'secondaryColor': metric.secondaryColor,
        'score': metric.score,
      }).toList(),
    };
  }

  StateModel.fromJson(Map<String, dynamic> json) {
    var metricsList = (json['metrics'] as List).map<Metric>((metric) => Metric(
      type: metric['type'],
      title: metric['title'],
      icon: metricIcons[metric['type']]!,
      mainColor: metric['mainColor'],
      secondaryColor: metric['secondaryColor'],
      score: metric['score'],
      page_url: metricPageUrls[metric['type']]!,
    )).toList();

    metricsMap = Map.fromIterable(
      metricsList,
      key: (metric) => MetricType.values.firstWhere((type) => type == metric.type),
      value: (metric) => metric,
    );
  }
}

Future<List<String>> _loadMetricAssets() async {
  final directory = await getApplicationDocumentsDirectory();
  final bluetoothFile = File('${directory.path}/bluetooth.json');
  final osVersionFile = File('${directory.path}/os_version.json');
  final portInfoFile = File('${directory.path}/port_info.json');
  final runningAppsFile = File('${directory.path}/running_apps.json');
  final systemInfoFile = File('${directory.path}/systemInfoFile.json');
  final wifiInfoFile = File('${directory.path}/wifi_info.json');

  if (await bluetoothFile.exists() &&
      await osVersionFile.exists() &&
      await portInfoFile.exists() &&
      await runningAppsFile.exists() &&
      await systemInfoFile.exists() &&
      await wifiInfoFile.exists()) {
    return [
      await bluetoothFile.readAsString(),
      await osVersionFile.readAsString(),
      await portInfoFile.readAsString(),
      await runningAppsFile.readAsString(),
      await systemInfoFile.readAsString(),
      await wifiInfoFile.readAsString(),
    ];
  }

  return await Future.wait([
    rootBundle.loadString('assets/bluetooth.json'),
    rootBundle.loadString('assets/os_version.json'),
    rootBundle.loadString('assets/port_info.json'),
    rootBundle.loadString('assets/running_apps.json'),
    rootBundle.loadString('assets/system_info.json'),
    rootBundle.loadString('assets/wifi_info.json'),
  ]);
}

// Future<File> _saveMetricAsset(String jsonString, String filename) async {
//   // save the string into the recipe_list.json file
//   final directory = await getApplicationDocumentsDirectory();
//   final file = File('${directory.path}/$filename');

//   // create file if it doesn't exist
//   if (!await file.exists()) {
//     await file.create(recursive: true);
//   }

//   return file.writeAsString(jsonString);
// }

Future<List<Map<String, dynamic>>> loadMetricJsons() async {
  final jsonStringList = await _loadMetricAssets();
  return jsonStringList.map((jsonString) => json.decode(jsonString)).toList() as List<Map<String, dynamic>>;
}

enum MetricType {
  overallHealth,
  bluetoothHealth,
  wifiHealth,
  systemHealth,
  otherHealth,
}

const Map<MetricType, IconData> metricIcons = {
  MetricType.overallHealth: Icons.favorite,
  MetricType.bluetoothHealth: Icons.bluetooth,
  MetricType.wifiHealth: Icons.wifi,
  MetricType.systemHealth: Icons.computer,
  MetricType.otherHealth: Icons.devices_other,
};

const Map<MetricType, String> metricPageUrls = {
  MetricType.overallHealth: '/overallHealth',
  MetricType.bluetoothHealth: '/bluetoothHealth',
  MetricType.wifiHealth: '/wifiHealth',
  MetricType.systemHealth: '/systemHealth',
  MetricType.otherHealth: '/otherHealth',
};

class Metric {
  final MetricType type;
  final String title;
  final IconData icon;
  final Color mainColor;
  final Color secondaryColor;
  final int score;
  final String page_url;

  Metric({
    required this.type,
    required this.title,
    required this.icon,
    required this.mainColor,
    required this.secondaryColor,
    required this.score,
    required this.page_url
  });
}