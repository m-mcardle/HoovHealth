import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Network extends StatefulWidget {
  const Network({Key? key}) : super(key: key);

  @override
  _NetworkState createState() => _NetworkState();
}

class _NetworkState extends State<Network> {
  static const platform = MethodChannel('com.example.wifi_info');

  Map<String, dynamic> wifiInfo = {};

  @override
  void initState() {
    super.initState();
    fetchWifiInfo();
  }

  Future<void> fetchWifiInfo() async {
    try {
      final result = await platform.invokeMethod<Map<dynamic, dynamic>>('getWifiInfo');
      setState(() {
        wifiInfo = result?.cast<String, dynamic>() ?? {}; // Explicit cast to Map<String, dynamic>
      });
    } on PlatformException catch (e) {
      print("Failed to get Wi-Fi info: '${e.message}'.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Network Information'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Container(
        color: Colors.black,
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ElevatedButton(
              onPressed: fetchWifiInfo,
              child: Text('Fetch Wi-Fi Info'),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink,
                ),
            ),
            SizedBox(height: 20),
            Text(
              'Wi-Fi Info:',
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
                  rows: wifiInfo.entries.map((entry) {
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
