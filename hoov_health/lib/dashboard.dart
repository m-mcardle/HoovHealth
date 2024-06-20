import 'package:flutter/material.dart';
import 'package:hoov_health/backend/bluetooth.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'dashboard/overall_health_widget.dart';
import 'dashboard/metric_health_widget.dart';

import 'backend/load_data.dart';
import 'backend/tips.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {

    final List<ChartData> chartData = [
      ChartData(1, 35),
      ChartData(2, 23),
      ChartData(3, 34),
      ChartData(4, 25),
      ChartData(5, 40)
    ];

    return Consumer<MetricsModel>(
        builder: (context, metricsModel, child) {
          Map<MetricType, Metric> metricsMap = metricsModel.metricsMap;
          BluetoothData? bluetoothData = metricsModel.bluetoothData;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              // This is the column that contains all the rows
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                // Row containing Summary Timeline and Total Health Score on dial
                Row(
                  children: [
                    // Summary Timeline
                    Expanded(
                      child: Container(
                        height: 320,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                        child: Column(
                          children: [
                            const Text("Summary", style: TextStyle(fontSize: 16)),
                            Flexible(child:
                              SfCartesianChart(
                                // Columns will be rendered back to back
                                enableSideBySideSeriesPlacement: false,
                                series: <CartesianSeries<ChartData, int>>[
                                    ColumnSeries<ChartData, int>(
                                        dataSource: chartData,
                                        xValueMapper: (ChartData data, _) => data.x,
                                        yValueMapper: (ChartData data, _) => data.y
                                    ),
                                ]
                              )
                            )
                          ]
                        ),
                      ),
                    ),
                    const SizedBox(width: 32),
                    const Expanded(
                      child: OverallHealthWidget(
                        score: 69,
                      )
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                // Row with health widgets (BT, WiFi, BT, Other)
                Row(
                  children: [
                    // Iterate through the kvp of metricsMap and create a widget for each
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
                    ]
                  ],
                ),
                const SizedBox(height: 32),
                // Row with recommendations
                Row(
                  children: [
                    for (var tip in bluetoothData!.generateTips().getRange(0, 3)) ...[
                      Expanded(
                        child: Container(
                          height: 100,
                          color: tip.severity == Severity.Low ? Colors.green : tip.severity == Severity.Medium ? Colors.orange : Colors.red,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${tip.severity.toString().split('.').last} Severity",
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                tip.tip,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 32),
                    ]
                  ],
                ),
              ],
            ),
          );
        }
    );
  }
}

class ChartData {
    ChartData(this.x, this.y);
    final int x;
    final double y;
}
