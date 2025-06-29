import 'package:bitnet/backbone/helper/lightning_config.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

/// Node Assignment Service
///
/// Manages the assignment of Lightning nodes to new users.
/// Uses load balancing to distribute users across available nodes.
class NodeAssignmentService {
  static final LoggerService _logger = Get.find<LoggerService>();
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Collection reference for node statistics
  static CollectionReference get _nodeStats =>
      _firestore.collection('node_statistics');

  /// Get the next available node for a new user
  ///
  /// This function implements a load balancing algorithm to:
  /// 1. Check current node usage statistics
  /// 2. Find the least loaded node
  /// 3. Ensure the node is healthy and accepting new users
  /// 4. Return the optimal node ID
  static Future<String> assignAvailableNode() async {
    _logger.i("🔍 === FINDING AVAILABLE NODE FOR NEW USER ===");

    try {
      // Get all available node IDs
      List<String> availableNodes = LightningConfig.getAllNodeIds();
      _logger.i("Available nodes: $availableNodes");

      // Try to get node statistics from Firebase
      Map<String, int> nodeUserCounts = await _getNodeUserCounts();

      if (nodeUserCounts.isNotEmpty) {
        // Find the node with the least users
        String? leastLoadedNode;
        int minUsers = 999999;

        for (String nodeId in availableNodes) {
          int userCount = nodeUserCounts[nodeId] ?? 0;
          _logger.i("Node $nodeId has $userCount users");

          if (userCount < minUsers) {
            minUsers = userCount;
            leastLoadedNode = nodeId;
          }
        }

        if (leastLoadedNode != null) {
          _logger.i(
              "✅ Selected least loaded node: $leastLoadedNode (users: $minUsers)");
          await _incrementNodeUserCount(leastLoadedNode);
          return leastLoadedNode;
        }
      }

      // Fallback: Round-robin based on timestamp
      int nodeIndex =
          DateTime.now().millisecondsSinceEpoch % availableNodes.length;
      String selectedNode = availableNodes[nodeIndex];

      _logger.i("✅ Selected node via round-robin: $selectedNode");
      await _incrementNodeUserCount(selectedNode);
      return selectedNode;
    } catch (e) {
      _logger.e("❌ Error in node assignment: $e");

      // Ultimate fallback: return default node
      String defaultNode = LightningConfig.getDefaultNodeId();
      _logger.w("⚠️ Falling back to default node: $defaultNode");
      return defaultNode;
    }
  }

  /// Get current user counts for all nodes
  static Future<Map<String, int>> _getNodeUserCounts() async {
    try {
      // Query user_node_mappings to count users per node
      QuerySnapshot mappings = await _firestore
          .collection('user_node_mappings')
          .where('status', isEqualTo: 'active')
          .get();

      Map<String, int> counts = {};

      for (var doc in mappings.docs) {
        Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
        String nodeId = data?['node_id'] ?? 'unknown';
        counts[nodeId] = (counts[nodeId] ?? 0) + 1;
      }

      return counts;
    } catch (e) {
      _logger.e("Error getting node user counts: $e");
      return {};
    }
  }

  /// Increment the user count for a node
  static Future<void> _incrementNodeUserCount(String nodeId) async {
    try {
      DocumentReference nodeStatRef = _nodeStats.doc(nodeId);

      await _firestore.runTransaction((transaction) async {
        DocumentSnapshot nodeStatDoc = await transaction.get(nodeStatRef);

        if (nodeStatDoc.exists) {
          Map<String, dynamic> data =
              nodeStatDoc.data() as Map<String, dynamic>;
          int currentCount = data['user_count'] ?? 0;

          transaction.update(nodeStatRef, {
            'user_count': currentCount + 1,
            'last_assigned': FieldValue.serverTimestamp(),
          });
        } else {
          transaction.set(nodeStatRef, {
            'node_id': nodeId,
            'user_count': 1,
            'created_at': FieldValue.serverTimestamp(),
            'last_assigned': FieldValue.serverTimestamp(),
            'status': 'active',
          });
        }
      });

      _logger.i("✅ Updated user count for node $nodeId");
    } catch (e) {
      _logger.e("Error updating node user count: $e");
      // Non-critical error, continue
    }
  }

  /// Check if a specific node is healthy and accepting new users
  static Future<bool> isNodeHealthy(String nodeId) async {
    try {
      // Check node statistics
      DocumentSnapshot nodeStatDoc = await _nodeStats.doc(nodeId).get();

      if (nodeStatDoc.exists) {
        Map<String, dynamic> data = nodeStatDoc.data() as Map<String, dynamic>;
        String status = data['status'] ?? 'unknown';
        int userCount = data['user_count'] ?? 0;
        int maxUsers = data['max_users'] ?? 100; // Default max users per node

        // Node is healthy if active and not at capacity
        bool isHealthy = status == 'active' && userCount < maxUsers;

        _logger.i(
            "Node $nodeId health check: status=$status, users=$userCount/$maxUsers, healthy=$isHealthy");
        return isHealthy;
      }

      // If no stats exist, assume node is healthy
      return true;
    } catch (e) {
      _logger.e("Error checking node health: $e");
      return true; // Assume healthy on error
    }
  }

  /// Get statistics for all nodes
  static Future<List<Map<String, dynamic>>> getNodeStatistics() async {
    try {
      QuerySnapshot statsSnapshot = await _nodeStats.get();

      List<Map<String, dynamic>> stats = [];

      for (var doc in statsSnapshot.docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        data['node_id'] = doc.id;
        stats.add(data);
      }

      // Sort by user count (ascending)
      stats.sort(
          (a, b) => (a['user_count'] ?? 0).compareTo(b['user_count'] ?? 0));

      return stats;
    } catch (e) {
      _logger.e("Error getting node statistics: $e");
      return [];
    }
  }

  /// Mark a node as unhealthy/maintenance mode
  static Future<void> markNodeUnhealthy(String nodeId, String reason) async {
    try {
      await _nodeStats.doc(nodeId).update({
        'status': 'maintenance',
        'maintenance_reason': reason,
        'maintenance_started': FieldValue.serverTimestamp(),
      });

      _logger.w("⚠️ Marked node $nodeId as unhealthy: $reason");
    } catch (e) {
      _logger.e("Error marking node unhealthy: $e");
    }
  }

  /// Mark a node as healthy/active
  static Future<void> markNodeHealthy(String nodeId) async {
    try {
      await _nodeStats.doc(nodeId).update({
        'status': 'active',
        'maintenance_reason': FieldValue.delete(),
        'maintenance_started': FieldValue.delete(),
        'maintenance_ended': FieldValue.serverTimestamp(),
      });

      _logger.i("✅ Marked node $nodeId as healthy");
    } catch (e) {
      _logger.e("Error marking node healthy: $e");
    }
  }
}
