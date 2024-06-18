import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class MetricHealthWidget extends StatelessWidget {
  const MetricHealthWidget({super.key, required this.title, required this.icon, required this.color, required this.score});

  final String title;
  final IconData icon;
  final Color color;
  final int score;

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Container(
      height: 200,
      color: color,
      child: Column(
        children: [
          Icon(
            icon,
            size: 32,
            color: Colors.white,
          ),
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold
            ),
          ),
          Flexible(
            child: SfRadialGauge(
              // set size to be 200x200
              axes: <RadialAxis>[
                RadialAxis(
                  startAngle: 150,
                  radiusFactor: 0.75,
                  endAngle: 30,
                  minimum: 0,
                  maximum: 100,
                  axisLineStyle: AxisLineStyle(
                    thickness: 0,
                  ),
                  ranges: <GaugeRange>[
                    GaugeRange(startValue: score.toDouble(), endValue: 100, color: Colors.grey[400]),
                    GaugeRange(startValue: 0, endValue: score.toDouble(), color:Colors.white),
                  ],
                  annotations: <GaugeAnnotation>[
                    GaugeAnnotation(
                      widget: Container(
                        child: Text(
                          '${score}%',
                          style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold, color: Colors.white)
                        )
                      ),
                      angle: 90,
                      positionFactor: 0
                    )
                  ],
                  showLabels: false,
                  interval: 100,
                )
              ]
            )
          ),
        ],
      ),
    );
  }
}
