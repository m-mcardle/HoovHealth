import 'package:flutter/material.dart';
import 'package:hoov_health/bluetooth/bluetooth_page.dart';
import 'package:provider/provider.dart';

import 'dashboard_sidebar.dart';
import 'dashboard.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: 1200,
          child: const Row(
            children: [
              DashboardSidebar(),
              SizedBox(width: 16),
              Expanded(
                child: Dashboard(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
