import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class MetricHealthWidget extends StatefulWidget {
  const MetricHealthWidget({super.key, required this.title, required this.icon, required this.color, required this.score});

  final String title;
  final IconData icon;
  final Color color;
  final int score;


  @override
  State<MetricHealthWidget> createState() => _MetricHealthWidgetState();
}

class _MetricHealthWidgetState extends State<MetricHealthWidget> {
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      height: 200,
      color: isHover ? widget.color.withAlpha(200) : widget.color,
      child: InkWell( 
        onTap:(){
          Navigator.pushNamed(context, '/bluetooth');
        },
        
        onHover: (val) {
          setState(() {
            isHover = val;
          });
        },
        child: Column(
          children: [
            Icon(
              widget.icon,
              size: 32,
              color: Colors.white,
            ),
            Text(
              widget.title,
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
                      GaugeRange(startValue: widget.score.toDouble(), endValue: 100, color: Colors.grey[400]),
                      GaugeRange(startValue: 0, endValue: widget.score.toDouble(), color:Colors.white),
                    ],
                    annotations: <GaugeAnnotation>[
                      GaugeAnnotation(
                        widget: Container(
                          child: Text(
                            '${widget.score}%',
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
      ),
    );
  }
}
