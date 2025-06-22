import 'package:cloud_firestore/cloud_firestore.dart';

/// User Node Mapping Model
/// 
/// Maps recovery DIDs (derived from mnemonics) to specific Lightning nodes.
/// This enables account recovery by allowing users to find their Lightning
/// node using only their mnemonic phrase.
class UserNodeMapping {
  final String recoveryDid;        // did:mnemonic:abc123def456 (from mnemonic hash)
  final String lightningPubkey;    // 03abcdef... (Lightning node identity)
  final String nodeId;             // node4, node5, etc. (physical node identifier)
  final String caddyEndpoint;      // http://[ipv6]/node4 (Caddy routing endpoint)
  final String adminMacaroon;      // Base64 admin macaroon for node access
  final String? invoiceTrackingMacaroon; // Limited macaroon for invoice tracking (backend services)
  final String? loopMacaroon;      // Base64 Loop macaroon for Loop operations
  final DateTime createdAt;        // When the mapping was created
  final DateTime lastAccessed;     // Last time user accessed this node
  final String status;             // active, inactive, migrating
  final Map<String, dynamic>? metadata; // Additional node metadata

  UserNodeMapping({
    required this.recoveryDid,
    required this.lightningPubkey,
    required this.nodeId,
    required this.caddyEndpoint,
    required this.adminMacaroon,
    this.invoiceTrackingMacaroon,
    this.loopMacaroon,
    required this.createdAt,
    required this.lastAccessed,
    this.status = 'active',
    this.metadata,
  });

  /// Create UserNodeMapping from Firestore document
  factory UserNodeMapping.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    
    return UserNodeMapping(
      recoveryDid: data['recovery_did'] ?? '',
      lightningPubkey: data['lightning_pubkey'] ?? '',
      nodeId: data['node_id'] ?? '',
      caddyEndpoint: data['caddy_endpoint'] ?? '',
      adminMacaroon: data['admin_macaroon'] ?? '',
      invoiceTrackingMacaroon: data['invoice_tracking_macaroon'],
      loopMacaroon: data['loop_macaroon'],
      createdAt: (data['created_at'] as Timestamp?)?.toDate() ?? DateTime.now(),
      lastAccessed: (data['last_accessed'] as Timestamp?)?.toDate() ?? DateTime.now(),
      status: data['status'] ?? 'active',
      metadata: data['metadata'] as Map<String, dynamic>?,
    );
  }

  /// Create UserNodeMapping from Map
  factory UserNodeMapping.fromMap(Map<String, dynamic> data) {
    return UserNodeMapping(
      recoveryDid: data['recovery_did'] ?? '',
      lightningPubkey: data['lightning_pubkey'] ?? '',
      nodeId: data['node_id'] ?? '',
      caddyEndpoint: data['caddy_endpoint'] ?? '',
      adminMacaroon: data['admin_macaroon'] ?? '',
      invoiceTrackingMacaroon: data['invoice_tracking_macaroon'],
      loopMacaroon: data['loop_macaroon'],
      createdAt: data['created_at'] is Timestamp 
          ? (data['created_at'] as Timestamp).toDate()
          : DateTime.parse(data['created_at'] ?? DateTime.now().toIso8601String()),
      lastAccessed: data['last_accessed'] is Timestamp
          ? (data['last_accessed'] as Timestamp).toDate()
          : DateTime.parse(data['last_accessed'] ?? DateTime.now().toIso8601String()),
      status: data['status'] ?? 'active',
      metadata: data['metadata'] as Map<String, dynamic>?,
    );
  }

  /// Convert to Firestore document format
  Map<String, dynamic> toFirestore() {
    return {
      'recovery_did': recoveryDid,
      'lightning_pubkey': lightningPubkey,
      'node_id': nodeId,
      'caddy_endpoint': caddyEndpoint,
      'admin_macaroon': adminMacaroon,
      'invoice_tracking_macaroon': invoiceTrackingMacaroon,
      'loop_macaroon': loopMacaroon,
      'created_at': Timestamp.fromDate(createdAt),
      'last_accessed': Timestamp.fromDate(lastAccessed),
      'status': status,
      'metadata': metadata,
    };
  }

  /// Convert to Map
  Map<String, dynamic> toMap() {
    return {
      'recovery_did': recoveryDid,
      'lightning_pubkey': lightningPubkey,
      'node_id': nodeId,
      'caddy_endpoint': caddyEndpoint,
      'admin_macaroon': adminMacaroon,
      'invoice_tracking_macaroon': invoiceTrackingMacaroon,
      'loop_macaroon': loopMacaroon,
      'created_at': createdAt.toIso8601String(),
      'last_accessed': lastAccessed.toIso8601String(),
      'status': status,
      'metadata': metadata,
    };
  }

  /// Create a copy with updated fields
  UserNodeMapping copyWith({
    String? recoveryDid,
    String? lightningPubkey,
    String? nodeId,
    String? caddyEndpoint,
    String? adminMacaroon,
    String? invoiceTrackingMacaroon,
    String? loopMacaroon,
    DateTime? createdAt,
    DateTime? lastAccessed,
    String? status,
    Map<String, dynamic>? metadata,
  }) {
    return UserNodeMapping(
      recoveryDid: recoveryDid ?? this.recoveryDid,
      lightningPubkey: lightningPubkey ?? this.lightningPubkey,
      nodeId: nodeId ?? this.nodeId,
      caddyEndpoint: caddyEndpoint ?? this.caddyEndpoint,
      adminMacaroon: adminMacaroon ?? this.adminMacaroon,
      invoiceTrackingMacaroon: invoiceTrackingMacaroon ?? this.invoiceTrackingMacaroon,
      loopMacaroon: loopMacaroon ?? this.loopMacaroon,
      createdAt: createdAt ?? this.createdAt,
      lastAccessed: lastAccessed ?? this.lastAccessed,
      status: status ?? this.status,
      metadata: metadata ?? this.metadata,
    );
  }

  /// Update last accessed timestamp
  UserNodeMapping updateLastAccessed() {
    return copyWith(lastAccessed: DateTime.now());
  }

  /// Check if the mapping is active
  bool get isActive => status == 'active';

  /// Check if the mapping is valid (has required fields)
  bool get isValid {
    return recoveryDid.isNotEmpty &&
           lightningPubkey.isNotEmpty &&
           nodeId.isNotEmpty &&
           caddyEndpoint.isNotEmpty &&
           adminMacaroon.isNotEmpty;
  }

  /// Get a shortened version of the Lightning pubkey for display
  String get shortLightningPubkey {
    if (lightningPubkey.length < 10) return lightningPubkey;
    return '${lightningPubkey.substring(0, 6)}...${lightningPubkey.substring(lightningPubkey.length - 4)}';
  }

  /// Get a shortened version of the recovery DID for display
  String get shortRecoveryDid {
    if (recoveryDid.length < 20) return recoveryDid;
    return '${recoveryDid.substring(0, 16)}...${recoveryDid.substring(recoveryDid.length - 4)}';
  }

  @override
  String toString() {
    return 'UserNodeMapping(recoveryDid: $shortRecoveryDid, nodeId: $nodeId, lightningPubkey: $shortLightningPubkey, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is UserNodeMapping &&
           other.recoveryDid == recoveryDid &&
           other.lightningPubkey == lightningPubkey &&
           other.nodeId == nodeId;
  }

  @override
  int get hashCode {
    return recoveryDid.hashCode ^ lightningPubkey.hashCode ^ nodeId.hashCode;
  }
}