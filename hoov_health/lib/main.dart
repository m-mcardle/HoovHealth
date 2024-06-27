import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'dart:async';


import 'dashboard_sidebar.dart';
import 'dashboard.dart';

import 'bluetooth/bluetooth_page.dart';

import 'backend/bluetooth.dart';
import 'backend/load_data.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure the binding is initialized
  Map<String, dynamic> bluetoothJson = await loadBluetoothJson();
  BluetoothData bluetoothData = BluetoothData.fromJson(bluetoothJson);

  runApp(
    ChangeNotifierProvider(
      create: (context) => MetricsModel(bluetoothData: bluetoothData),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color(0x1F2128),
          primary: Color.fromARGB(255, 31, 33, 40),
          secondary: Color.fromARGB(255, 36, 39, 49),
          tertiary: Color.fromARGB(255, 255, 255, 255),
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => MyHomePage(title: 'HoovHealth'),
        '/bluetoothHealth': (context) => BluetoothPage(),
        // TODO
        '/wifiHealth': (context) => MyHomePage(title: 'Wifi Health'),
        '/systemHealth': (context) => MyHomePage(title: 'System Health'),
        '/otherHealth': (context) => MyHomePage(title: 'Other Health'),
        '/overallHealth': (context) => MyHomePage(title: 'Overall Health'),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const platform = MethodChannel('samples.flutter.dev/battery');
  String _batteryLevel = 'Unknown battery level.';

  Future<void> _getBatteryLevel() async {
    String batteryLevel;
    try {
      final result = await platform.invokeMethod<int>('getBatteryLevel');
      batteryLevel = 'Battery level at $result % .';
    } on PlatformException catch (e) {
      batteryLevel = "Failed to get battery level: '${e.message}'.";
    }

    setState(() {
      _batteryLevel = batteryLevel;
    });
  }

  @override
  Widget build(BuildContext context) {
    _getBatteryLevel();
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: 1200,
          child: Row(
            children: [
              Text('Battery Level: $_batteryLevel\n'),
              // DashboardSidebar(),
              // SizedBox(width: 16),
              // Expanded(
              //   child: Dashboard(),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
