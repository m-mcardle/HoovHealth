import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Network extends StatefulWidget {
  const Network({Key? key}) : super(key: key);

  @override
  _NetworkState createState() => _NetworkState();
}

class _NetworkState extends State<Network> {
  List<String> ipAddresses = [];

  @override
  void initState() {
    super.initState();
    fetchIPs();
  }

  Future<void> fetchIPs() async {
    final String apiUrl = 'http://localhost:5001/get_ips';

    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        // Disable SSL verification (for testing only)
        // headers: {'Accept': 'application/json', 'Connection': 'keep-alive'},
        // verify: false,
      );

      if (response.statusCode == 200) {
        final List<dynamic> devices = jsonDecode(response.body);
        setState(() {
          ipAddresses = devices.map((device) => device['ip'] as String).toList();
        });
      } else {
        throw Exception('Failed to load IP addresses');
      }
    } catch (e) {
      print('Error fetching IP addresses: $e');
      // Handle error, such as displaying a message to the user
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Network Information'),
        backgroundColor: Colors.deepPurple,
      ),
      body: ListView.builder(
        itemCount: ipAddresses.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(ipAddresses[index]),
          );
        },
      ),
    );
  }
}
