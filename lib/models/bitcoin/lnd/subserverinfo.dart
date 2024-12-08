class SubServerInfo {
  final bool disabled;
  final bool running;
  final String error;

  SubServerInfo({required this.disabled, required this.running, required this.error});

  factory SubServerInfo.fromJson(Map<String, dynamic> json) {
    return SubServerInfo(
      disabled: json['disabled'] ?? false,
      running: json['running'] ?? false,
      error: json['error'] ?? '',
    );
  }
}

class SubServersStatus {
  final Map<String, SubServerInfo> subServers;

  SubServersStatus({required this.subServers});

  factory SubServersStatus.fromJson(Map<String, dynamic> json) {
    final subServersMap = json['sub_servers'] as Map<String, dynamic>? ?? {};
    final subServers = <String, SubServerInfo>{};
    subServersMap.forEach((key, value) {
      subServers[key] = SubServerInfo.fromJson(value);
    });
    return SubServersStatus(subServers: subServers);
  }
}
