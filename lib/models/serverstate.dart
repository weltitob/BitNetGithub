// Model to store server state for the user
class ServerStateModel {
  final String publicIp;
  final bool isActive;
  final Map<String, dynamic>? subServers; // from SubServersStatus
  final DateTime lastUpdated;
  final String? mnemonicSeed; // Optional: store mnemonic if you want
  final String? macaroonRootKey; // Optional: store macaroon root key if you want

  ServerStateModel({
    required this.publicIp,
    required this.isActive,
    required this.lastUpdated,
    this.subServers,
    this.mnemonicSeed,
    this.macaroonRootKey,
  });

  Map<String, dynamic> toMap() {
    return {
      'publicIp': publicIp,
      'isActive': isActive,
      'lastUpdated': lastUpdated.toIso8601String(),
      'subServers': subServers,
      'mnemonicSeed': mnemonicSeed,
      'macaroonRootKey': macaroonRootKey,
    };
  }

  factory ServerStateModel.fromMap(Map<String, dynamic> map) {
    return ServerStateModel(
      publicIp: map['publicIp'] ?? '',
      isActive: map['isActive'] ?? false,
      lastUpdated: DateTime.tryParse(map['lastUpdated'] ?? '') ?? DateTime.now(),
      subServers: map['subServers'] as Map<String, dynamic>?,
      mnemonicSeed: map['mnemonicSeed'],
      macaroonRootKey: map['macaroonRootKey'],
    );
  }
}