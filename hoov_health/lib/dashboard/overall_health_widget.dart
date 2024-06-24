import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class OverallHealthWidget extends StatelessWidget {
  const OverallHealthWidget({super.key, required this.score});

  final int score;

  @override
  Widget build(BuildContext context) {
    const Color mainColor = Colors.red;
    final Color secondaryColor = Colors.red[200]!;

    return Container(
      height: 200,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).colorScheme.secondary,
      ),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: const Text(
              "Total Health Score",
              textAlign: TextAlign.left,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Row(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                child: const Text(
                  "2024-01-01",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
              ),
              const Spacer(),
              Row(
                children: [
                  const Chip(
                    label: Text('Today', style: TextStyle(color: Colors.white)),
                    backgroundColor: Color.fromARGB(255, 255, 179, 87),
                  ),
                  const SizedBox(width: 8),
                  Chip(
                    label: const Text('7 Days'),
                    backgroundColor: Colors.grey[800],
                  ),
                  const SizedBox(width: 8),
                  Chip(
                    label: const Text('30 Days'),
                    backgroundColor: Colors.grey[800],
                  ),
                ]
              ),
            ]
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
                  axisLineStyle: const AxisLineStyle(
                    thickness: 0,
                  ),
                  ranges: <GaugeRange>[
                    GaugeRange(startValue: score.toDouble(), endValue: 100, color: secondaryColor, startWidth: 20, endWidth: 20,),
                    GaugeRange(startValue: 0, endValue: score.toDouble(), color: mainColor, startWidth: 20, endWidth: 20,),
                  ],
                  annotations: <GaugeAnnotation>[
                    GaugeAnnotation(
                      widget: Container(
                        child: Text(
                          '${score.toString()}%',
                          style: const TextStyle(fontSize: 32,fontWeight: FontWeight.w900, color: mainColor)
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
