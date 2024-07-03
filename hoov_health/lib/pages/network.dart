import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hoov_health/backend/state.dart';
import 'package:provider/provider.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Network Information'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Consumer<StateModel>(
        builder: (context, stateModel, child) {
          var db = stateModel.databaseHelper;

          Future<void> fetchWifiInfo() async {
            try {
              final result = await platform.invokeMethod<Map<dynamic, dynamic>>('getWifiInfo');
              final val = result?.cast<String, dynamic>() ?? {};

              await db.insertNetworkScan(
                channel_band: val['Channel_Band'] ?? -1,
                channel_width: val['Channel_Width'] ?? -1,
                channel: val['Channel'] ?? -1,
                security: val['Security'] ?? 'Unknown',
                transmit_rate: val['Transmit_Rate'] ?? -1.0,
                noise_level: val['Noise_Level'] ?? -1,
                rssi: val['RSSI'] ?? -1,
              );

              setState(() {
                wifiInfo = val;
              });
            } on PlatformException catch (e) {
              print("Failed to get Wi-Fi info: '${e.message}'.");
            }
          }

          Future<void> fetchLatestNetworkScan() async {
            final result = await db.getLatestNetworkScan();
            setState(() {
              wifiInfo = result;
            });
            print(result);
          }

          if (wifiInfo.isEmpty) {
            fetchLatestNetworkScan();
          }

          return Container(
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
          );
        },
      ),
    );
  }
}
