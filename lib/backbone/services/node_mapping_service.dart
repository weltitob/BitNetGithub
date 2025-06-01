import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bitnet/backbone/helper/databaserefs.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:bitnet/models/recovery/user_node_mapping.dart';
import 'package:bitnet/backbone/helper/recovery_identity.dart';
import 'package:get/get.dart';

/// Node Mapping Service
/// 
/// Handles storage and retrieval of user→Lightning node mappings.
/// This is critical for account recovery - allows users to find their
/// Lightning node using only their mnemonic phrase.
class NodeMappingService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static LoggerService get _logger => Get.find<LoggerService>();

  /// Collection references
  static CollectionReference get _userNodeMappings => 
      _firestore.collection('user_node_mappings');
  
  static CollectionReference get _mnemonicRecoveryIndex => 
      _firestore.collection('mnemonic_recovery_index');

  /// Store a new user→node mapping
  /// 
  /// This creates the critical link between a recovery DID (derived from mnemonic)
  /// and the specific Lightning node assigned to that user.
  static Future<void> storeUserNodeMapping(UserNodeMapping mapping) async {
    try {
      _logger.i("Storing user node mapping for ${mapping.recoveryDid}");
      _logger.d("Node ID: ${mapping.nodeId}, Lightning pubkey: ${mapping.shortLightningPubkey}");

      // Validate mapping before storing
      if (!mapping.isValid) {
        throw Exception("Invalid UserNodeMapping: missing required fields");
      }

      // Store the main mapping document
      await _userNodeMappings
          .doc(mapping.recoveryDid)
          .set(mapping.toFirestore());

      _logger.i("✅ User node mapping stored successfully");
      
    } catch (e) {
      _logger.e("❌ Error storing user node mapping: $e");
      throw Exception("Failed to store user node mapping: $e");
    }
  }

  /// Store mnemonic recovery index entry
  /// 
  /// Creates a searchable index that maps mnemonic hashes to recovery DIDs
  /// without exposing the actual mnemonic.
  static Future<void> storeMnemonicRecoveryIndex(String mnemonic, String recoveryDid) async {
    try {
      String mnemonicHash = RecoveryIdentity.generateMnemonicHash(mnemonic);
      
      _logger.d("Storing mnemonic recovery index");
      _logger.d("Mnemonic hash: ${mnemonicHash.substring(0, 16)}... (truncated)");
      _logger.d("Recovery DID: $recoveryDid");

      await _mnemonicRecoveryIndex
          .doc(mnemonicHash)
          .set({
            'recovery_did': recoveryDid,
            'created_at': FieldValue.serverTimestamp(),
          });

      _logger.i("✅ Mnemonic recovery index stored");
      
    } catch (e) {
      _logger.e("❌ Error storing mnemonic recovery index: $e");
      throw Exception("Failed to store mnemonic recovery index: $e");
    }
  }

  /// Get user node mapping by recovery DID
  /// 
  /// Primary method for finding a user's Lightning node during recovery.
  static Future<UserNodeMapping?> getUserNodeMapping(String recoveryDid) async {
    _logger.i("🗺️ ✅ GETUSERNMAPPING FUNCTION CALLED");
    
    try {
      _logger.i("Looking up node mapping for recovery DID: $recoveryDid");

      DocumentSnapshot doc = await _userNodeMappings
          .doc(recoveryDid)
          .get();

      if (!doc.exists) {
        _logger.w("No node mapping found for recovery DID: $recoveryDid");
        return null;
      }

      UserNodeMapping mapping = UserNodeMapping.fromFirestore(doc);
      _logger.i("✅ Found node mapping: ${mapping.nodeId} → ${mapping.shortLightningPubkey}");
      
      // Update last accessed timestamp
      await _updateLastAccessed(recoveryDid);
      
      return mapping;
      
    } catch (e) {
      _logger.e("❌ Error retrieving user node mapping: $e");
      throw Exception("Failed to retrieve user node mapping: $e");
    }
  }

  /// Get user node mapping by mnemonic
  /// 
  /// Convenience method that generates recovery DID from mnemonic
  /// and then looks up the node mapping.
  static Future<UserNodeMapping?> getUserNodeMappingByMnemonic(String mnemonic) async {
    try {
      String recoveryDid = RecoveryIdentity.generateRecoveryDid(mnemonic);
      return await getUserNodeMapping(recoveryDid);
    } catch (e) {
      _logger.e("❌ Error retrieving node mapping by mnemonic: $e");
      throw Exception("Failed to retrieve node mapping by mnemonic: $e");
    }
  }

  /// Check if a user exists by recovery DID
  static Future<bool> userExists(String recoveryDid) async {
    try {
      DocumentSnapshot doc = await _userNodeMappings
          .doc(recoveryDid)
          .get();
      
      return doc.exists;
    } catch (e) {
      _logger.e("❌ Error checking if user exists: $e");
      return false;
    }
  }

  /// Check if a user exists by mnemonic
  static Future<bool> userExistsByMnemonic(String mnemonic) async {
    try {
      String recoveryDid = RecoveryIdentity.generateRecoveryDid(mnemonic);
      return await userExists(recoveryDid);
    } catch (e) {
      _logger.e("❌ Error checking if user exists by mnemonic: $e");
      return false;
    }
  }

  /// Update user node mapping
  static Future<void> updateUserNodeMapping(String recoveryDid, UserNodeMapping updatedMapping) async {
    try {
      _logger.i("Updating node mapping for $recoveryDid");

      await _userNodeMappings
          .doc(recoveryDid)
          .update(updatedMapping.toFirestore());

      _logger.i("✅ Node mapping updated successfully");
      
    } catch (e) {
      _logger.e("❌ Error updating user node mapping: $e");
      throw Exception("Failed to update user node mapping: $e");
    }
  }

  /// Update the last accessed timestamp for a mapping
  static Future<void> _updateLastAccessed(String recoveryDid) async {
    try {
      await _userNodeMappings
          .doc(recoveryDid)
          .update({
            'last_accessed': FieldValue.serverTimestamp(),
          });
    } catch (e) {
      _logger.w("Failed to update last accessed timestamp: $e");
      // Don't throw - this is not critical
    }
  }

  /// Get all node mappings for a specific node ID
  /// 
  /// Useful for node management and migration.
  static Future<List<UserNodeMapping>> getMappingsForNode(String nodeId) async {
    try {
      _logger.i("Getting all mappings for node: $nodeId");

      QuerySnapshot query = await _userNodeMappings
          .where('node_id', isEqualTo: nodeId)
          .get();

      List<UserNodeMapping> mappings = query.docs
          .map((doc) => UserNodeMapping.fromFirestore(doc))
          .toList();

      _logger.i("Found ${mappings.length} mappings for node $nodeId");
      return mappings;
      
    } catch (e) {
      _logger.e("❌ Error getting mappings for node: $e");
      throw Exception("Failed to get mappings for node: $e");
    }
  }

  /// Deactivate a node mapping
  static Future<void> deactivateMapping(String recoveryDid, {String reason = 'deactivated'}) async {
    try {
      _logger.i("Deactivating mapping for $recoveryDid: $reason");

      await _userNodeMappings
          .doc(recoveryDid)
          .update({
            'status': 'inactive',
            'deactivated_at': FieldValue.serverTimestamp(),
            'deactivation_reason': reason,
          });

      _logger.i("✅ Mapping deactivated");
      
    } catch (e) {
      _logger.e("❌ Error deactivating mapping: $e");
      throw Exception("Failed to deactivate mapping: $e");
    }
  }

  /// Get node mapping statistics
  static Future<Map<String, int>> getNodeMappingStats() async {
    try {
      // Get total mappings
      QuerySnapshot allMappings = await _userNodeMappings.get();
      
      // Get active mappings
      QuerySnapshot activeMappings = await _userNodeMappings
          .where('status', isEqualTo: 'active')
          .get();

      // Count mappings per node
      Map<String, int> nodeStats = {};
      for (var doc in allMappings.docs) {
        Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
        String nodeId = data?['node_id'] ?? 'unknown';
        nodeStats[nodeId] = (nodeStats[nodeId] ?? 0) + 1;
      }

      return {
        'total_mappings': allMappings.docs.length,
        'active_mappings': activeMappings.docs.length,
        'inactive_mappings': allMappings.docs.length - activeMappings.docs.length,
        ...nodeStats.map((key, value) => MapEntry('node_$key', value)),
      };
      
    } catch (e) {
      _logger.e("❌ Error getting node mapping stats: $e");
      return {'error': 1};
    }
  }

  /// Migrate user from one node to another
  /// 
  /// Useful for load balancing or node maintenance.
  static Future<void> migrateUserToNode({
    required String recoveryDid,
    required String newNodeId,
    required String newLightningPubkey,
    required String newCaddyEndpoint,
    required String newAdminMacaroon,
  }) async {
    try {
      _logger.i("Migrating user $recoveryDid to node $newNodeId");

      // Get current mapping
      UserNodeMapping? currentMapping = await getUserNodeMapping(recoveryDid);
      if (currentMapping == null) {
        throw Exception("User mapping not found for migration");
      }

      // Create updated mapping
      UserNodeMapping updatedMapping = currentMapping.copyWith(
        nodeId: newNodeId,
        lightningPubkey: newLightningPubkey,
        caddyEndpoint: newCaddyEndpoint,
        adminMacaroon: newAdminMacaroon,
        status: 'active',
        lastAccessed: DateTime.now(),
        metadata: {
          ...?currentMapping.metadata,
          'migrated_from': currentMapping.nodeId,
          'migrated_at': DateTime.now().toIso8601String(),
        },
      );

      // Update the mapping
      await updateUserNodeMapping(recoveryDid, updatedMapping);
      
      _logger.i("✅ User migrated successfully to node $newNodeId");
      
    } catch (e) {
      _logger.e("❌ Error migrating user to new node: $e");
      throw Exception("Failed to migrate user to new node: $e");
    }
  }

  /// Alias for getMappingsForNode for compatibility
  static Future<List<UserNodeMapping>> getUsersForNode(String nodeId) async {
    return await getMappingsForNode(nodeId);
  }
}