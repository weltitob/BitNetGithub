import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:get/get.dart';

/// Register an individual Lightning node for a user
///
/// This replaces the old genLitdAccount function for the one-user-one-node architecture.
/// Each user gets their own Lightning node via Caddy routing.
Future<bool> registerIndividualLightningNode({
  required String did,
  required String nodeId,
  required String adminMacaroon,
  required String lightningPubkey,
  required String caddyEndpoint,
}) async {
  final logger = Get.find<LoggerService>();

  logger.i("🚀 === REGISTER INDIVIDUAL LIGHTNING NODE ===");
  logger.i("🚀 DID: $did");
  logger.i("🚀 Node ID: $nodeId");
  logger.i("🚀 Lightning Pubkey: ${lightningPubkey.substring(0, 20)}...");
  logger.i("🚀 Caddy Endpoint: $caddyEndpoint");
  logger.i("🚀 Admin Macaroon: ${adminMacaroon.substring(0, 20)}...");

  try {
    // Call the Firebase Cloud Function
    HttpsCallable callable = FirebaseFunctions.instance.httpsCallable(
      'register_individual_node_func',
      options: HttpsCallableOptions(
        timeout: const Duration(seconds: 30),
      ),
    );

    final Map<String, dynamic> requestData = {
      'did': did,
      'node_id': nodeId,
      'admin_macaroon': adminMacaroon,
      'lightning_pubkey': lightningPubkey,
      'caddy_endpoint': caddyEndpoint,
    };

    logger.i("🚀 📤 Calling Firebase function with data: $requestData");

    final HttpsCallableResult<dynamic> response =
        await callable.call(requestData);

    logger.i("🚀 📥 Response received: ${response.data}");

    // Check if registration was successful
    if (response.data != null && response.data['success'] == true) {
      logger.i("✅ Individual Lightning node registered successfully");
      logger.i("✅ Node ID: ${response.data['data']['node_id']}");
      logger.i(
          "✅ Lightning Pubkey: ${response.data['data']['lightning_pubkey']}");
      return true;
    } else {
      logger.e("❌ Failed to register individual Lightning node");
      logger.e("❌ Response: ${response.data}");
      return false;
    }
  } catch (e, stackTrace) {
    logger.e("❌ Error registering individual Lightning node: $e");
    logger.e("❌ Stack trace: $stackTrace");
    return false;
  }
}

/// Get available node for new user assignment
///
/// This function determines which Lightning node to assign to a new user
/// based on current load and availability.
Future<String> assignAvailableNode() async {
  final logger = Get.find<LoggerService>();

  logger.i("🔍 === FINDING AVAILABLE NODE FOR USER ===");

  // For now, use a simple round-robin approach
  // In production, this should query node statistics and find the least loaded node

  // Available nodes
  final List<String> availableNodes = [
    'node4',
    'node5',
    'node6',
    'node7',
    'node8'
  ];

  try {
    // TODO: Implement proper load balancing logic
    // For now, randomly select a node from available nodes
    final randomIndex =
        DateTime.now().millisecondsSinceEpoch % availableNodes.length;
    final selectedNode = availableNodes[randomIndex];

    logger.i("✅ Selected node for new user: $selectedNode");
    return selectedNode;
  } catch (e) {
    logger.e("❌ Error selecting node: $e");
    // Fallback to default node
    return 'node6';
  }
}
