import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.lightBlue,
          primary: Colors.black12,
          secondary: Colors.grey[700],
          tertiary: Colors.grey[900],
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'HoovHealth'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.primary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Padding(
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
                    child: Container(
                      height: 200,
                      color: Theme.of(context).colorScheme.secondary,
                      child: Column(
                        children: [
                          Text(
                            'Total Stink Score',
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
                                    GaugeRange(startValue: 69, endValue: 100, color: Colors.red[200], startWidth: 20, endWidth: 20,),
                                    GaugeRange(startValue: 0, endValue: 69, color:Colors.red, startWidth: 20, endWidth: 20,),
                                  ],
                                  annotations: <GaugeAnnotation>[
                                    GaugeAnnotation(
                                      widget: Container(
                                        child: Text(
                                          '69%',
                                          style: TextStyle(fontSize: 32,fontWeight: FontWeight.w900, color: Colors.red)
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
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              // Row with health widgets (BT, WiFi, BT, Other)
              Row(
                children: [
                  // Summary Timeline
                  Expanded(
                    child: Container(
                      height: 200,
                      color: Colors.lightBlue[300],
                      child: Column(
                        children: [
                          const Icon(
                            Icons.bluetooth_audio_rounded,
                            size: 32,
                            color: Colors.white,
                          ),
                          Text(
                            'Bluetooth Health',
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
                                    GaugeRange(startValue: 45, endValue: 100, color: Colors.grey[400]),
                                    GaugeRange(startValue: 0, endValue: 45, color:Colors.white),
                                  ],
                                  annotations: <GaugeAnnotation>[
                                    GaugeAnnotation(
                                      widget: Container(
                                        child: Text(
                                          '45%',
                                          style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold)
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
                  ),
                  const SizedBox(width: 32),
                  Expanded(
                    child: Container(
                      height: 200,
                      color: Colors.orange[300],
                      child: Column(
                        children: [
                          const Icon(
                            Icons.wifi,
                            size: 32,
                            color: Colors.white,
                          ),
                          Text(
                            'WiFi Health',
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
                                    GaugeRange(startValue: 45, endValue: 100, color: Colors.grey[400]),
                                    GaugeRange(startValue: 0, endValue: 45, color:Colors.white),
                                  ],
                                  annotations: <GaugeAnnotation>[
                                    GaugeAnnotation(
                                      widget: Container(
                                        child: Text(
                                          '45%',
                                          style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold)
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
                  ),
                  const SizedBox(width: 32),
                  Expanded(
                    child: Container(
                      height: 200,
                      color: Colors.green[200],
                      child: Column(
                        children: [
                          const Icon(
                            Icons.computer,
                            size: 32,
                            color: Colors.white,
                          ),
                          Text(
                            'System Health',
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
                                    GaugeRange(startValue: 45, endValue: 100, color: Colors.grey[400]),
                                    GaugeRange(startValue: 0, endValue: 45, color:Colors.white),
                                  ],
                                  annotations: <GaugeAnnotation>[
                                    GaugeAnnotation(
                                      widget: Container(
                                        child: Text(
                                          '45%',
                                          style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold)
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
                  ),
                  const SizedBox(width: 32),
                  Expanded(
                    child: Container(
                      height: 200,
                      color: Colors.purple[200],
                      child: Column(
                        children: [
                          const Icon(
                            Icons.settings_outlined,
                            size: 32,
                            color: Colors.white,
                          ),
                          Text(
                            'Other Health',
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
                                    GaugeRange(startValue: 45, endValue: 100, color: Colors.grey[400]),
                                    GaugeRange(startValue: 0, endValue: 45, color:Colors.white),
                                  ],
                                  annotations: <GaugeAnnotation>[
                                    GaugeAnnotation(
                                      widget: Container(
                                        child: Text(
                                          '45%',
                                          style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold)
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
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
