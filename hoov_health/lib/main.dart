import 'package:flutter/material.dart';
import 'package:hoov_health/pages/bluetooth_page.dart';
import 'package:provider/provider.dart';

import 'pages/dashboard.dart';
import 'pages/network.dart';
import 'pages/applications.dart';
import 'pages/system.dart';

import 'backend/bluetooth.dart';
import 'backend/state.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure the binding is initialized
  Map<String, dynamic> bluetoothJson = await loadBluetoothJson();
  BluetoothData bluetoothData = BluetoothData.fromJson(bluetoothJson);

  runApp(
    ChangeNotifierProvider(
      create: (context) => StateModel(bluetoothData: bluetoothData),
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
        '/dashboard': (context) => Dashboard(),
        '/bluetooth': (context) => BluetoothPage(),
        '/network': (context) => Network(),
        '/applications': (context) => Applications(),
        '/system': (context) => System(),
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
      drawer: Drawer(
        backgroundColor: Color.fromARGB(255, 140, 3, 3),
        child: Column(
          children: [
            DrawerHeader(
              child: Icon(
                Icons.security,
                size: 48,
              )
            ),
            ListTile(
              leading: Icon(
                Icons.wifi,
                size: 40,
              ),
              title: Text("N E T W O R K"),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/network');
              }
            ),
            ListTile(
              leading: Icon(
                Icons.bluetooth,
                size: 40,
              ),
              title: Text("B L U E T O O T H"),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/bluetooth');
              }
            ),
            ListTile(
              leading: Icon(
                Icons.app_shortcut,
                size: 40,
              ),
              title: Text("A P P L I C A T I O N S"),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/applications');
              }
            ),
            ListTile(
              leading: Icon(
                Icons.system_update_rounded,
                size: 40,
              ),
              title: Text("S Y S T E M"),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/system');
              }
            )
          ],
        )
      ),
      body: SingleChildScrollView(
        child: Container(
          height: 1200,
          child: const Row(
            children: [
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
