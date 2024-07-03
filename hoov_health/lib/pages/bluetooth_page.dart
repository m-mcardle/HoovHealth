import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../backend/state.dart';
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
      body: Consumer<StateModel>(
        builder: (context, stateModel, child) {
          BluetoothData bluetoothData = stateModel.bluetoothData!;
          List<BluetoothDevice> devices = bluetoothData.connectedDevices;
          List<BluetoothDevice> disconnectedDevices = bluetoothData.disconnectedDevices;
          ControllerProperties? controllerProperties = bluetoothData.controllerProperties!;

          return SingleChildScrollView(
            child: Container(
              height: 900,
              child: Column(
                children: [
                  const Text("Connected Devices", style: TextStyle(fontSize: 16)),
                  const ListTile(
                    leading: Text("Address"),
                    title: Text("Name"),
                    subtitle: Text("Type"),
                    trailing: Text("Battery Level / Firmware Version / Vendor ID / Product ID / Services"),
                  ),
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
                          trailing: Container(
                            width: 300,
                            child: Row(
                              children: [
                                Text(devices[index].device_batteryLevelMain ?? "Battery Unknown"),
                                Spacer(),
                                Text(devices[index].device_firmwareVersion),
                                Spacer(),
                                Text(devices[index].device_vendorID),
                                Spacer(),
                                Text(devices[index].device_productID),
                                Spacer(),
                                Text(devices[index].device_services ?? "Unknown Device Services"),
                              ],
                            ),
                          ),
                          onTap: () { },
                        );
                      }
                    ),
                  ),
                  const Text("Disconnected Devices", style: TextStyle(fontSize: 16)),
                  const ListTile(
                    leading: Text("Address"),
                    title: Text("Name"),
                    subtitle: Text("Type"),
                    trailing: Text("Battery Level / Firmware Version / Vendor ID / Product ID / Services"),
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
                          onTap: () {},
                        );
                      }
                    ),
                  ),
                  const Text("Bluetooth Controller Properties", style: TextStyle(fontSize: 16)),
                  Container(
                    height: 200,
                    color: Theme.of(context).colorScheme.secondary,
                    child: ListView(
                      children: [
                        Text("Controller Properties"),
                        Text("Chipset: " + controllerProperties.controller_chipset),
                        Text("Discoverable: " + controllerProperties.controller_discoverable),
                        Text("Product ID: " + controllerProperties.controller_productID),
                        Text("State: " + controllerProperties.controller_state),
                        Text("Transport: " + controllerProperties.controller_transport),
                        Text("Vendor ID: " + controllerProperties.controller_vendorID),
                        Text("Firmware Version: " + controllerProperties.controller_firmwareVersion),
                        Text("Address: " + controllerProperties.controller_address),
                        Text("Supported Services: " + controllerProperties.controller_supportedServices),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      ),
    );
  }
}
