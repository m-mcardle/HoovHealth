import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class System extends StatefulWidget {
  const System({Key? key}) : super(key: key);

  @override
  _SystemState createState() => _SystemState();
}

class _SystemState extends State<System> {
  static const platform = MethodChannel('com.example.system_info');

  Map<String, dynamic> systemInfo = {};

  Future<void> fetchSystemInfo() async {
    try {
      final result = await platform.invokeMethod<Map<dynamic, dynamic>>('getSystemInfo');
      setState(() {
        systemInfo = result?.cast<String, dynamic>() ?? {};
      });
    } on PlatformException catch (e) {
      print("Failed to get System info: '${e.message}'.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('System Information'),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        color: Colors.black,
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ElevatedButton(
              onPressed: fetchSystemInfo,
              child: Text('Fetch System Info'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pink,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'System Info:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            SizedBox(height: 10),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columnSpacing: 20,
                  columns: [
                    DataColumn(label: Text('Property', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white))),
                    DataColumn(label: Text('Value', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white))),
                  ],
                  rows: systemInfo.entries.map((entry) {
                    return DataRow(cells: [
                      DataCell(Text(entry.key, style: TextStyle(color: Colors.white))),
                      DataCell(Text(entry.value.toString(), style: TextStyle(color: Colors.white))),
                    ]);
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
