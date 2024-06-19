import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../backend/load_data.dart';
import '../backend/bluetooth.dart';


class BluetoothPage extends StatefulWidget {
  const BluetoothPage({super.key});

  @override
  State<BluetoothPage> createState() => _BluetoothPageState();
}

// this page accesses the bluetooth data and displays it from the model, it should use a listview to display each bluetooth device
class _BluetoothPageState extends State<BluetoothPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text("Bluetooth Devices"),
      ),
      body: Consumer<MetricsModel>(
        builder: (context, metricsModel, child) {
          BluetoothData bluetoothData = metricsModel.bluetoothData!;
          List<BluetoothDevice> devices = bluetoothData.connectedDevices;
          List<BluetoothDevice> disconnectedDevices = bluetoothData.disconnectedDevices;

          return Column(
            children: [
              Container(
                height: 200,
                color: Theme.of(context).colorScheme.secondary,
                child: ListView.builder(
                  itemCount: devices.length,
                  itemBuilder: (context, index) {
                    // each favourite has a small image on the left of the row, followed by the name of the recipe over top of the author
                    return ListTile(
                      leading: Text(devices[index].device_address),
                      title: Text(devices[index].name),
                      subtitle: Text(devices[index].device_minorType),
                      onTap: () {
                      },
                    );
                  }
                ),
              ),
              Container(
                height: 200,
                color: Theme.of(context).colorScheme.secondary,
                child: ListView.builder(
                  itemCount: disconnectedDevices.length,
                  itemBuilder: (context, index) {
                    // each favourite has a small image on the left of the row, followed by the name of the recipe over top of the author
                    return ListTile(
                      leading: Text(disconnectedDevices[index].device_address),
                      title: Text(disconnectedDevices[index].name),
                      subtitle: Text(disconnectedDevices[index].device_minorType),
                      onTap: () {
                      },
                    );
                  }
                ),
              ),
            ],
          );
        }
      ),
    );
  }
}
