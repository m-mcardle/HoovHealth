import 'package:flutter/material.dart';

class Apps extends StatefulWidget {
  const Apps({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<Apps> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Applications'),
        backgroundColor: Colors.pink
      ),
      body: GridView.builder(
        itemCount: 66,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 6), 
        itemBuilder: (context, index) => Container(
          color: Colors.deepPurple,
          margin: EdgeInsets.all(2)
        ),
      ),
    );
  }
}
