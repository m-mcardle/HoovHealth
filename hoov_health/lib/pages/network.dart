import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';

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
  }

  Future<void> fetchWifiInfo() async {
    try {
      final result = await platform.invokeMethod<Map<dynamic, dynamic>>('getWifiInfo');
      final val = result?.cast<String, dynamic>() ?? {};

      // open the database
      Database database = await openDatabase('hoov_health.db', version: 1,
          onCreate: (Database db, int version) async {
            await db.execute('''
              CREATE TABLE NetworkScan (
                id INTEGER PRIMARY KEY,
                channel_band INT,
                channel_width INT,
                channel INT,
                security TEXT,
                transmit_rate REAL,
                noise_level INT,
                rssi INT,
                timestamp INTEGER
              )
            ''');
          },
      );

      int currentTimestamp = DateTime.now().millisecondsSinceEpoch ~/ 1000; // Unix timestamp in seconds

      await database.transaction((txn) async {
        int id = await txn.rawInsert(
            'INSERT INTO NetworkScan(channel_band, channel_width, channel, security, transmit_rate, noise_level, rssi, timestamp) VALUES(?, ?, ?, ?, ?, ?, ?, ?)',
            [val['Channel_Band'], val['Channel_Width'], val['Channel'], val['Security'], val['Transmit_Rate'], val['Noise_Level'], val['RSSI'], currentTimestamp]);
        print('inserted: $id');
      });

      List<Map> list = await database.rawQuery('SELECT * FROM NetworkScan');
      print(list);

      setState(() {
        wifiInfo = val;
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
