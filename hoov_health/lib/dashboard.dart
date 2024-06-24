import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:network_info_plus/network_info_plus.dart'; // Import network_info_plus package

import 'dashboard/overall_health_widget.dart';
import 'dashboard/metric_health_widget.dart';
import 'backend/load_data.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  bool isScanningWifi = false;
  bool isScanningSystem = false;
  Map<String, String> wifiScanResult = {};
  Map<String, String> systemScanResult = {};
  String? lastScanType; // Variable to track the last scan type initiated

  Future<void> _startScan(String type) async {
    try {
      setState(() {
        if (type == 'wifi') {
          isScanningWifi = true;
          wifiScanResult = {};
          lastScanType = 'wifi'; // Update lastScanType
        } else if (type == 'system') {
          isScanningSystem = true;
          systemScanResult = {};
          lastScanType = 'system'; // Update lastScanType
        }
      });

      // Perform different scans based on 'type'
      if (type == 'wifi') {
        wifiScanResult = await getWifiInfo();
      } else if (type == 'system') {
        systemScanResult = await getSystemInfo();
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Scan completed successfully')),
      );
    } catch (e) {
      setState(() {
        if (type == 'wifi') {
          wifiScanResult = {'Error': e.toString()};
        } else if (type == 'system') {
          systemScanResult = {'Error': e.toString()};
        }
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Scan failed: $e')),
      );
    } finally {
      setState(() {
        if (type == 'wifi') {
          isScanningWifi = false;
        } else if (type == 'system') {
          isScanningSystem = false;
        }
      });
    }
  }

  Future<Map<String, String>> getWifiInfo() async {
    final info = NetworkInfo();
    String ssid = await info.getWifiName() ?? 'Not connected';
    String ip = await info.getWifiIP() ?? 'Unknown';
    String bssid = await info.getWifiBSSID() ?? 'Unknown';
    String ipv6 = await info.getWifiIPv6() ?? 'Unknown';
    String wifiSubmask = await info.getWifiSubmask() ?? 'Unknown';
    String wifiBroadcast = await info.getWifiBroadcast() ?? 'Unknown';
    String wifiGateway = await info.getWifiGatewayIP() ?? 'Unknown';

    return {
      'SSID': ssid,
      'IP': ip,
      'BSSID': bssid,
      'IPv6': ipv6,
      'Submask': wifiSubmask,
      'Broadcast': wifiBroadcast,
      'Gateway': wifiGateway,
    };
  }

  Future<Map<String, String>> getSystemInfo() async {
    // Replace with actual implementation to retrieve system info for Mac
    return {
      'OS': 'macOS',
      'Version': 'Big Sur',
      'Hostname': 'MyMac',
      'Serial Number': 'ABCDEFG123456',
    };
  }

  @override
  Widget build(BuildContext context) {
    final List<ChartData> chartData = [
      ChartData(1, 35),
      ChartData(2, 23),
      ChartData(3, 34),
      ChartData(4, 25),
      ChartData(5, 40),
    ];

    return Consumer<MetricsModel>(
      builder: (context, metricsModel, child) {
        var metricsMap = metricsModel.metricsMap;

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: 200,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Theme.of(context).colorScheme.secondary,
                                ),
                                child: Column(
                                  children: [
                                    const Text(
                                      "Summary",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    Flexible(
                                      child: SfCartesianChart(
                                        enableSideBySideSeriesPlacement: false,
                                        series: <CartesianSeries<ChartData, int>>[
                                          ColumnSeries<ChartData, int>(
                                            dataSource: chartData,
                                            xValueMapper: (ChartData data, _) => data.x,
                                            yValueMapper: (ChartData data, _) => data.y,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 32),
                            Expanded(
                              child: OverallHealthWidget(
                                score: 69,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 32),
                        Row(
                          children: [
                            for (var entry in metricsMap.entries) ...[
                              Expanded(
                                child: MetricHealthWidget(
                                  title: entry.value.title,
                                  icon: entry.value.icon,
                                  color: entry.value.mainColor,
                                  score: entry.value.score,
                                  page_url: entry.value.page_url,
                                ),
                              ),
                              const SizedBox(width: 32),
                            ],
                          ],
                        ),
                        const SizedBox(height: 32),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () => _startScan('wifi'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: isScanningWifi ? Colors.grey : Colors.pink,
                                ),
                                child: Text(
                                  isScanningWifi ? 'Scanning...' : 'WiFi Scan',
                                  style: TextStyle(color: Colors.white), // Optional: Text color
                                ),
                              ),
                            ),
                            const SizedBox(width: 32),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () => _startScan('system'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: isScanningSystem ? Colors.grey : Colors.pink,
                                ),
                                child: Text(
                                  isScanningSystem ? 'Scanning...' : 'System Scan',
                                  style: TextStyle(color: Colors.white), // Optional: Text color
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              if (lastScanType == 'wifi' && wifiScanResult.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'WiFi Scan Results:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ListView(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      children: wifiScanResult.entries
                          .map((entry) => ListTile(
                                title: Text('${entry.key}: ${entry.value}'),
                              ))
                          .toList(),
                    ),
                  ],
                ),
              if (lastScanType == 'system' && systemScanResult.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'System Scan Results:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ListView(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      children: systemScanResult.entries
                          .map((entry) => ListTile(
                                title: Text('${entry.key}: ${entry.value}'),
                              ))
                          .toList(),
                    ),
                  ],
                ),
            ],
          ),
        );
      },
    );
  }
}

class ChartData {
  final int x;
  final double y;

  ChartData(this.x, this.y);
}
