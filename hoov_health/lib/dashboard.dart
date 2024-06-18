import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import 'dashboard/overall_health_widget.dart';
import 'dashboard/metric_health_widget.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
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
                  height: 200,
                  color: Theme.of(context).colorScheme.secondary,
                  child: Column(
                    children: [
                      Text(
                        'Summary Timeline',
                      ),
                      Text(
                        'This is where the summary timeline will go',
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 32),
              Expanded(
                child: OverallHealthWidget(
                  title: 'Total Health Score',
                  mainColor: Colors.red,
                  secondaryColor: Colors.red[200]!,
                  score: 69,
                )
              ),
            ],
          ),
          const SizedBox(height: 32),
          // Row with health widgets (BT, WiFi, BT, Other)
          Row(
            children: [
              // Summary Timeline
              Expanded(
                child: MetricHealthWidget(
                  title: 'Bluetooth Health',
                  icon: Icons.bluetooth,
                  color: Colors.blue[200]!,
                  score: 69,
                )
              ),
              const SizedBox(width: 32),
              Expanded(
                child: MetricHealthWidget(
                  title: 'WiFi Health',
                  icon: Icons.wifi,
                  color: Colors.orange[200]!,
                  score: 13,
                ),
              ),
              const SizedBox(width: 32),
              Expanded(
                child: MetricHealthWidget(
                  title: 'System Health',
                  icon: Icons.computer,
                  color: Colors.green[200]!,
                  score: 20,
                ),
              ),
              const SizedBox(width: 32),
              Expanded(
                child: MetricHealthWidget(
                  title: 'Other Health',
                  icon: Icons.help,
                  color: Colors.purple[200]!,
                  score: 100,
                )
              ),
            ],
          ),
          const SizedBox(height: 32),
          // Row with recommendations
          Row(
            children: [
              // Summary Timeline
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
}
