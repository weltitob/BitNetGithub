class SubServerInfo {
  final bool disabled;
  final bool running;
  final String error;
  final String customStatus;

  SubServerInfo({
    required this.disabled,
    required this.running,
    required this.error,
    required this.customStatus,
  });

  /// Factory constructor with error handling
  factory SubServerInfo.fromJson(Map<String, dynamic>? json) {
    try {
      if (json == null) {
        throw FormatException("SubServerInfo JSON is null.");
      }
      return SubServerInfo(
        disabled: json['disabled'] ?? false,
        running: json['running'] ?? false,
        error: json['error'] ?? '',
        customStatus: json['custom_status'] ?? '',
      );
    } catch (e) {
      // Log or handle the error
      print('Error parsing SubServerInfo: $e');
      return SubServerInfo(
        disabled: false,
        running: false,
        error: 'Error parsing data',
        customStatus: '',
      );
    }
  }
}

class SubServersStatus {
  final Map<String, SubServerInfo> subServers;

  SubServersStatus({required this.subServers});

  /// Factory constructor with error handling
  factory SubServersStatus.fromJson(Map<String, dynamic>? json) {
    try {
      if (json == null) {
        throw FormatException("SubServersStatus JSON is null.");
      }
      final subServersMap = json['sub_servers'] as Map<String, dynamic>? ?? {};
      final subServers = <String, SubServerInfo>{};

      subServersMap.forEach((key, value) {
        try {
          subServers[key] = SubServerInfo.fromJson(value);
        } catch (e) {
          // Log or handle the error for individual sub-servers
          print('Error parsing SubServerInfo for key $key: $e');
          subServers[key] = SubServerInfo(
            disabled: false,
            running: false,
            error: 'Error parsing sub-server data',
            customStatus: '',
          );
        }
      });

      return SubServersStatus(subServers: subServers);
    } catch (e) {
      // Log or handle the error
      print('Error parsing SubServersStatus: $e');
      return SubServersStatus(subServers: {});
    }
  }
}
