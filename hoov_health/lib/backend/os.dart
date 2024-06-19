class OperatingSystemData {
  final String name;
  final int major;
  final int minor;
  final String version;
  final String build;
  final String platform;
  final String platformLike;
  final String arch;

  OperatingSystemData({
    required this.name,
    required this.major,
    required this.minor,
    required this.version,
    required this.build,
    required this.platform,
    required this.platformLike,
    required this.arch,
  });

  factory OperatingSystemData.fromJson(Map<String, dynamic> json) {
    return OperatingSystemData(
      name: json['name'],
      major: json['major'],
      minor: json['minor'],
      version: json['version'],
      build: json['build'],
      platform: json['platform'],
      platformLike: json['platform_like'],
      arch: json['arch'],
    );
  }
}
