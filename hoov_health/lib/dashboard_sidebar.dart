import 'package:flutter/material.dart';
import 'pages/network.dart';

class DashboardSidebar extends StatelessWidget {
  const DashboardSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.secondary,
      child: Padding(
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
                color: Color.fromARGB(255, 41, 46, 61),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Row(
                children: [
                  Icon(Icons.dashboard, color: Colors.white),
                  Expanded(child: Text('Dashboard', textAlign: TextAlign.center, style: TextStyle(fontSize: 12, color: Colors.white))),
                ],
              )
            ),
            SizedBox(height: 8),
            Container(
              width: 180,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Row(
                children: [
                  Icon(Icons.bluetooth, color: Colors.grey),
                  Expanded(child: Text('Bluetooth Health', textAlign: TextAlign.center, style: TextStyle(fontSize: 12, color: Colors.grey))),
                ],
              )
            ),
            SizedBox(height: 8),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Network()),
                );
              },
              child: Container(
                width: 180,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.wifi, color: Colors.grey),
                    Expanded(child: Text('Network Scan', textAlign: TextAlign.center, style: TextStyle(fontSize: 12, color: Colors.grey))),
                  ],
                ),
              ),
            ),
            SizedBox(height: 8),
            Container(
              width: 180,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Row(
                children: [
                  Icon(Icons.settings, color: Colors.grey),
                  Expanded(child: Text('System Health', textAlign: TextAlign.center, style: TextStyle(fontSize: 12, color: Colors.grey))),
                ],
              )
            ),
            SizedBox(height: 8),
            Container(
              width: 180,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Row(
                children: [
                  Icon(Icons.android, color: Colors.grey),
                  Expanded(child: Text('OS Health', textAlign: TextAlign.center, style: TextStyle(fontSize: 12, color: Colors.grey))),
                ],
              )
            ),
          ],
        )
      )
    );
  }
}