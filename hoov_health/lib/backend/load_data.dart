import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import 'bluetooth.dart';

class MetricsModel extends ChangeNotifier {
  BluetoothData? bluetoothData;
  Map<MetricType, Metric> _metricsMap = {
    MetricType.overallHealth: Metric(
      type: MetricType.overallHealth,
      title: 'Overall Health',
      mainColor: Colors.red,
      secondaryColor: Colors.red[200]!,
      score: 69,
    ),
    MetricType.bluetoothHealth: Metric(
      type: MetricType.bluetoothHealth,
      title: 'Bluetooth Health',
      mainColor: Colors.blue,
      secondaryColor: Colors.blue[200]!,
      score: 69,
    ),
    MetricType.wifiHealth: Metric(
      type: MetricType.wifiHealth,
      title: 'Wifi Health',
      mainColor: Colors.green,
      secondaryColor: Colors.green[200]!,
      score: 69,
    ),
    MetricType.systemHealth: Metric(
      type: MetricType.systemHealth,
      title: 'System Health',
      mainColor: Colors.orange,
      secondaryColor: Colors.orange[200]!,
      score: 69,
    ),
    MetricType.otherHealth: Metric(
      type: MetricType.otherHealth,
      title: 'Other Health',
      mainColor: Colors.purple,
      secondaryColor: Colors.purple[200]!,
      score: 69,
    ),
  };

  // void updateMetric(Metric metric) {
  //   _metricsMap[metric.type] = metric;
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

  MetricsModel({
    required this.bluetoothData,
  });

  Map<String, dynamic> toJson() {
    return {
      'metrics': _metricsMap.values.map((metric) => {
        'type': metric.type,
        'title': metric.title,
        'mainColor': metric.mainColor,
        'secondaryColor': metric.secondaryColor,
        'score': metric.score,
      }).toList(),
    };
  }

  MetricsModel.fromJson(Map<String, dynamic> json) {
    var metricsList = (json['metrics'] as List).map<Metric>((metric) => Metric(
      type: metric['type'],
      title: metric['title'],
      mainColor: metric['mainColor'],
      secondaryColor: metric['secondaryColor'],
      score: metric['score'],
    )).toList();

    _metricsMap = Map.fromIterable(
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

class Metric {
  final MetricType type;
  final String title;
  final Color mainColor;
  final Color secondaryColor;
  final int score;

  Metric({
    required this.type,
    required this.title,
    required this.mainColor,
    required this.secondaryColor,
    required this.score,
  });
}