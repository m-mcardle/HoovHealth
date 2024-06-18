import 'package:flutter/material.dart';

class DashboardSidebar extends StatelessWidget {
  const DashboardSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        // The sidebar elements should be Dashboard (selected), Bluetooth Health, WiFi Health, System Health, OS Health all with icons
        children: [
          Container(
            width: 180,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Row(
              children: [
                Icon(Icons.dashboard, color: Colors.black),
                Expanded(child: Text('Dashboard', textAlign: TextAlign.center, style: TextStyle(fontSize: 12, color: Colors.black))),
              ],
            )
          ),
          SizedBox(height: 8),
          Container(
            width: 180,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.grey[900],
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Row(
              children: [
                Icon(Icons.bluetooth, color: Colors.white),
                Expanded(child: Text('Bluetooth Health', textAlign: TextAlign.center, style: TextStyle(fontSize: 12))),
              ],
            )
          ),
          SizedBox(height: 8),
          Container(
            width: 180,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.grey[900],
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Row(
              children: [
                Icon(Icons.wifi, color: Colors.white),
                Expanded(child: Text('WiFi Health', textAlign: TextAlign.center, style: TextStyle(fontSize: 12))),
              ],
            )
          ),
          SizedBox(height: 8),
          Container(
            width: 180,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.grey[900],
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Row(
              children: [
                Icon(Icons.settings, color: Colors.white),
                Expanded(child: Text('System Health', textAlign: TextAlign.center, style: TextStyle(fontSize: 12))),
              ],
            )
          ),
          SizedBox(height: 8),
          Container(
            width: 180,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.grey[900],
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Row(
              children: [
                Icon(Icons.android, color: Colors.white),
                Expanded(child: Text('OS Health', textAlign: TextAlign.center, style: TextStyle(fontSize: 12))),
              ],
            )
          ),
        ],
      )
    );
  }
}
