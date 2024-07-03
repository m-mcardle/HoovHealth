import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';
import 'dart:convert';

import 'state.dart';
import 'tips.dart';

class BluetoothDevice {
  String name = "";
  String device_address = "";
  String device_firmwareVersion = "";
  String? device_batteryLevelMain = "";
  String device_vendorID = "";
  String device_minorType = "";
  String device_productID = "";
  String? device_services = "";

  BluetoothDevice({
    required this.name,
    required String device_address,
    required String device_firmwareVersion,
    String? device_batteryLevelMain = null,
    required String device_vendorID,
    required String device_minorType,
    required String device_productID,
    String? device_services = null,
  });

  BluetoothDevice.fromJson(Map<String, dynamic> json) {
    final key = json.keys.first;
    final value = json[key];
    name = key;
    device_address = value['device_address'];
    device_firmwareVersion = value['device_firmwareVersion'];
    device_batteryLevelMain = value['device_batteryLevelMain'];
    device_vendorID = value['device_vendorID'];
    device_minorType = value['device_minorType'];
    device_productID = value['device_productID'];
    device_services = value['device_services'];
  }
}

class ControllerProperties {
  String controller_chipset = "";
  String controller_discoverable = "";
  String controller_productID = "";
  String controller_state = "";
  String controller_transport = "";
  String controller_vendorID = "";
  String controller_firmwareVersion = "";
  String controller_address = "";
  String controller_supportedServices = "";

  ControllerProperties({
    required this.controller_chipset,
    required this.controller_discoverable,
    required this.controller_productID,
    required this.controller_state,
    required this.controller_transport,
    required this.controller_vendorID,
    required this.controller_firmwareVersion,
    required this.controller_address,
    required this.controller_supportedServices,
  });

  ControllerProperties.fromJson(Map<String, dynamic> json) {
    controller_chipset = json['controller_chipset'];
    controller_discoverable = json['controller_discoverable'];
    controller_productID = json['controller_productID'];
    controller_state = json['controller_state'];
    controller_transport = json['controller_transport'];
    controller_vendorID = json['controller_vendorID'];
    controller_firmwareVersion = json['controller_firmwareVersion'];
    controller_address = json['controller_address'];
    controller_supportedServices = json['controller_supportedServices'];
  }
}

class BluetoothData {
  List<BluetoothDevice> connectedDevices = [];
  List<BluetoothDevice> disconnectedDevices = [];
  ControllerProperties? controllerProperties;

  List<String> approvedDeviceIDs = [];

  BluetoothData({
    required this.connectedDevices,
    required this.disconnectedDevices,
    required this.controllerProperties,
  });

  BluetoothData.fromJson(Map<String, dynamic> json) {
    connectedDevices = (json['device_connected'] as List).map((e) => BluetoothDevice.fromJson(e)).toList();
    disconnectedDevices = (json['device_not_connected'] as List).map((e) => BluetoothDevice.fromJson(e)).toList();
    controllerProperties = ControllerProperties.fromJson(json['controller_properties']);
  }

  List<Tip> generateTips() {
    final tips = <Tip>[];
    if (controllerProperties != null) {
      if (controllerProperties!.controller_state == "attrib_off") {
        tips.add(Tip(MetricType.bluetoothHealth, "Turn on Bluetooth", Severity.Low));
      }
      if (controllerProperties!.controller_discoverable == "attrib_on") {
        tips.add(Tip(MetricType.bluetoothHealth, "Make device discoverable", Severity.Low));
      }
    }
    if (connectedDevices.isNotEmpty) {
      final lowBatteryDevices = connectedDevices.where((device) {
        if (device.device_batteryLevelMain == null) {
          return false;
        }
        int batteryLevel = int.parse(device.device_batteryLevelMain!.substring(0, device.device_batteryLevelMain!.length - 1));
        return batteryLevel < 20;
      });
      for (var device in lowBatteryDevices) {
        tips.add(Tip(MetricType.bluetoothHealth, "Low battery on Bluetooth device named '${device.name}'", Severity.Medium));
      }
    }
    final unapprovedDevices = connectedDevices.where((BluetoothDevice element) => !approvedDeviceIDs.contains(element.device_productID));
    for (var device in unapprovedDevices) {
      tips.add(Tip(MetricType.bluetoothHealth, "Unapproved device connected: ${device.name}", Severity.High));
    }
    return tips;
  }
}

Future<Map<String, dynamic>> loadBluetoothJson() async {
  return json.decode(await _loadBluetoothAsset());
}

Future<String> _loadBluetoothAsset() async {
  final directory = await getApplicationDocumentsDirectory();
  final bluetoothFile = File('${directory.path}/$bluetoothFilename');
  if (await bluetoothFile.exists()) {
    return await bluetoothFile.readAsString();
  }
  return await rootBundle.loadString('data/$bluetoothFilename');
}

const bluetoothFilename = 'bluetooth.json';
