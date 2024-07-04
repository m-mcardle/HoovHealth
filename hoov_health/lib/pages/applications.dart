import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Applications extends StatefulWidget {
  const Applications({Key? key}) : super(key: key);

  @override
  _ApplicationsState createState() => _ApplicationsState();
}

class _ApplicationsState extends State<Applications> {
  static const platform = MethodChannel('com.example.process_info');

  Map<String, dynamic> appInfo = {};

  Future<void> fetchAppInfo() async {
    try {
      final result = await platform.invokeMethod<Map<dynamic, dynamic>>('getProcessInfo');
      setState(() {
        appInfo = result?.cast<String, dynamic>() ?? {};
      });
    } on PlatformException catch (e) {
      print("Failed to get application info: '${e.message}'.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Application Information'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Container(
        color: Colors.black,
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ElevatedButton(
              onPressed: fetchAppInfo,
              child: Text('Fetch App Info'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'App Info:',
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
                  rows: appInfo.entries.map((entry) {
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
