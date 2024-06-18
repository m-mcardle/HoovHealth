import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class OverallHealthWidget extends StatelessWidget {
  const OverallHealthWidget({super.key, required this.title, required this.mainColor, required this.secondaryColor, required this.score});

  final String title;
  final Color mainColor;
  final Color secondaryColor;
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
      color: Theme.of(context).colorScheme.secondary,
      child: Column(
        children: [
          Text(
            title,
          ),
          Flexible(
            child: SfRadialGauge(
              // set size to be 200x200
              axes: <RadialAxis>[
                RadialAxis(
                  startAngle: 270,
                  radiusFactor: 0.75,
                  endAngle: 270,
                  minimum: 0,
                  maximum: 100,
                  axisLineStyle: AxisLineStyle(
                    thickness: 0,
                  ),
                  ranges: <GaugeRange>[
                    GaugeRange(startValue: score.toDouble(), endValue: 100, color: secondaryColor, startWidth: 20, endWidth: 20,),
                    GaugeRange(startValue: 0, endValue: score.toDouble(), color:mainColor, startWidth: 20, endWidth: 20,),
                  ],
                  annotations: <GaugeAnnotation>[
                    GaugeAnnotation(
                      widget: Container(
                        child: Text(
                          '${score.toString()}%',
                          style: TextStyle(fontSize: 32,fontWeight: FontWeight.w900, color: mainColor)
                        )
                      ),
                      angle: 69,
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
