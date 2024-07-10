
class ProcessInfo {
  final String bundleIdentifier;
  final String launchDate;
  final String iconPath;
  final String localizedName;
  final double cpuUsage;
  final String executablePath;
  final bool isActive;
  final int pid;

  ProcessInfo({
    required this.bundleIdentifier,
    required this.launchDate,
    required this.iconPath,
    required this.localizedName,
    required this.cpuUsage,
    required this.executablePath,
    required this.isActive,
    required this.pid,
  });

  factory ProcessInfo.fromJson(Map<String, dynamic> json) {
    return ProcessInfo(
      bundleIdentifier: json['bundle_identifier'],
      launchDate: json['launch_date'],
      iconPath: json['icon_path'],
      localizedName: json['localized_name'],
      cpuUsage: json['cpu_usage'],
      executablePath: json['executable_path'],
      isActive: json['is_active'],
      pid: json['pid'],
    );
  }
}
