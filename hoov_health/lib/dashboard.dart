import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'dashboard/overall_health_widget.dart';
import 'dashboard/metric_health_widget.dart';

import 'backend/load_data.dart';

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
          var metricsMap = metricsModel.metricsMap;

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
                    Expanded(
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
                    Expanded(
                      child: Container(
                        height: 100,
                        color: Colors.greenAccent[100],
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Primary Recommendation',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Touch Grass',
                              style: TextStyle(
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
                    Expanded(
                      child: Container(
                        height: 100,
                        color: Colors.grey[300],
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Secondary Recommendation',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Speak with a humanoid',
                              style: TextStyle(
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
                    Expanded(
                      child: Container(
                        height: 100,
                        color: Colors.grey[300],
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'IDK, something else',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Gamble?',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
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
