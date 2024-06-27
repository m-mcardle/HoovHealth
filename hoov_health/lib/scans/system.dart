import 'package:system_info2/system_info2.dart';

Future<Map<String, String>> getSystemInfo() async {
  const int MEGABYTE = 1024 * 1024;

  // Get the processors list and ensure it's safe to access
  //final processors = SysInfo.processors;

  return {
  //  'Kernel Architecture': SysInfo.kernelArchitecture,
    'Kernel Bitness': SysInfo.kernelBitness.toString(),
    'Kernel Name': SysInfo.kernelName,
    'Kernel Version': SysInfo.kernelVersion,
    'Operating System Name': SysInfo.operatingSystemName,
    'Operating System Version': SysInfo.operatingSystemVersion,
    'User Directory': SysInfo.userDirectory,
    'User ID': SysInfo.userId.toString(),
    'User Name': SysInfo.userName,
    'User Space Bitness': SysInfo.userSpaceBitness.toString(),
   // 'Number of Processors': processors.length.toString(),
    // 'Processor Details': processors.map((processor) {
    //   return 'Architecture: ${processor.architecture}, Name: ${processor.name}, '
    //          'Socket: ${processor.socket}, Vendor: ${processor.vendor}';
    // }).join('; '),
    // 'Total Physical Memory': '${SysInfo.getTotalPhysicalMemory() ~/ MEGABYTE} MB',
    // 'Free Physical Memory': '${SysInfo.getFreePhysicalMemory() ~/ MEGABYTE} MB',
    // 'Total Virtual Memory': '${SysInfo.getTotalVirtualMemory() ~/ MEGABYTE} MB',
    // 'Free Virtual Memory': '${SysInfo.getFreeVirtualMemory() ~/ MEGABYTE} MB',
    // 'Virtual Memory Size': '${SysInfo.getVirtualMemorySize() ~/ MEGABYTE} MB',
  };
}
