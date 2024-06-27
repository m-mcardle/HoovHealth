import 'package:network_info_plus/network_info_plus.dart';

Future<Map<String, String>> getWifiInfo() async {
  final info = NetworkInfo();
  String ssid = await info.getWifiName() ?? 'Not connected';
  String ip = await info.getWifiIP() ?? 'Unknown';
  String bssid = await info.getWifiBSSID() ?? 'Unknown';
  String ipv6 = await info.getWifiIPv6() ?? "Unknown";
  String wifiSubmask = await info.getWifiSubmask() ?? "Unknown";
  String wifiBroadcast = await info.getWifiBroadcast() ?? "Unknown";
  String wifiGateway = await info.getWifiGatewayIP() ?? "Unknown";
  
  return {
    'SSID': ssid,
    'IP': ip,
    'BSSID': bssid,
    'IPv6': ipv6,
    'Submask': wifiSubmask,
    'Broadcast': wifiBroadcast,
    'Gateway': wifiGateway
  };
}
