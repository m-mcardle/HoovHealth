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
  TextEditingController queryController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Set the default query
    queryController.text = 'SELECT * FROM NetworkScan';
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

          Future<void> fetchLatestNetworkScan(String query) async {
            final result = await db.getLatestNetworkScan(query);
            setState(() {
              wifiInfo = result;
            });
            print(result);
          }

          if (wifiInfo.isEmpty) {
            fetchLatestNetworkScan(queryController.text); // Fetch initially with default query
          }

          return Container(
            color: Colors.black,
            padding: EdgeInsets.all(40.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Row(
                  children: [
                    Text(
                      'Wi-Fi Info:',
                      style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: TextField(
                        controller: queryController,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: 'Enter SQL query',
                          hintStyle: TextStyle(color: Colors.grey),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          filled: true,
                          fillColor: Colors.grey[800],
                        ),
                        onSubmitted: (query) {
                          fetchLatestNetworkScan(query); // Update query on submission
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: fetchWifiInfo,
                    child: Icon(Icons.wifi, color: Colors.white),
                    style: ElevatedButton.styleFrom(
                      shape: CircleBorder(),
                      padding: EdgeInsets.all(40),
                      backgroundColor: Colors.lightBlue,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Results:',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                SizedBox(height: 40),
                Expanded(
                  child: Center(
                    child: GridView.count(
                      crossAxisCount: 3,
                      childAspectRatio: 4,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 20,
                      children: wifiInfo.entries.map((entry) {
                        return ElevatedButton(
                          onPressed: () {
                            // Action when button is pressed (optional)
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                entry.key,
                                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 12),
                              ),
                              Text(
                                entry.value.toString(),
                                style: TextStyle(color: Colors.white, fontSize: 12),
                              ),
                            ],
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.pink,
                            padding: EdgeInsets.all(8),
                          ),
                        );
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
