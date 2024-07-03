import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hoov_health/backend/state.dart';
import 'package:provider/provider.dart';

class System extends StatefulWidget {
  const System({Key? key}) : super(key: key);

  @override
  _SystemState createState() => _SystemState();
}

class _SystemState extends State<System> {
  static const platform = MethodChannel('com.example.system_info');

  Map<String, dynamic> systemInfo = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('System Information'),
        backgroundColor: Colors.blue,
      ),
      body: Consumer<StateModel>(
        builder: (context, stateModel, child) {
          var db = stateModel.databaseHelper;


          Future<void> fetchSystemInfo() async {
            try {
              final result = await platform.invokeMethod<Map<dynamic, dynamic>>('getSystemInfo');
              final val = result?.cast<String, dynamic>() ?? {};

              await db.insertSystemScan(
                minor: val['Minor'] ?? -1,
                major: val['Major'] ?? -1,
                build: val['Build'] ?? -1,
                processor_type: val['Processor_Type'] ?? 'Unknown',
                arch: val['Arch'] ?? 'Unknown',
                hostname: val['Hostname'] ?? 'Unknown',
                platform_like: val['Platform_Like'] ?? 'Unknown',
                platform: val['Platform'] ?? 'Unknown',
                name: val['Name'] ?? 'Unknown',
                physical_memory: val['Physical_Memory'] ?? -1,
                version: val['Version'] ?? -1.0,
                uptime: val['Uptime'] ?? -1.0,
              );

              setState(() {
                systemInfo = val;
              });
            } on PlatformException catch (e) {
              print("Failed to get System info: '${e.message}'.");
            }
          }
          
          Future<void> fetchLatestSystemScan() async {
            final result = await db.getLatestSystemScan();
            setState(() {
              systemInfo = result;
            });
          }

          if (systemInfo.isEmpty) {
            fetchLatestSystemScan();
          }
          
          return Container(
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
            );
        },
      ),
    );
  }
}
