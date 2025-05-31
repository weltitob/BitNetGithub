/// Centralized Lightning Node Configuration
/// 
/// This file contains all Lightning node configuration settings
/// to avoid hardcoding node IDs throughout the application.
class LightningConfig {
  // CADDY CONFIGURATION
  static const String caddyBaseUrl = 'http://[2a02:8070:880:1e60:da3a:ddff:fee8:5b94]';
  
  // NODE CONFIGURATION - Change this to switch nodes application-wide
  static const String defaultNodeId = 'node9'; // ← CHANGE THIS TO SWITCH NODES
  
  // FALLBACK NODES - Try these if default node fails
  static const List<String> fallbackNodeIds = ['node2', 'node4', 'node5', 'node6', 'node7'];
  
  // DERIVED CONFIGURATIONS
  static String get defaultCaddyEndpoint => '$caddyBaseUrl/$defaultNodeId';
  
  // WALLET CONFIGURATION
  static const String walletPassword = 'development_password_dj83zb';
  
  // TIMEOUT CONFIGURATION
  static const int defaultTimeoutSeconds = 30;
  static const int statusCheckTimeoutSeconds = 10;
  static const int lightningReadyMaxWaitSeconds = 120;
  static const int lightningReadyCheckIntervalSeconds = 3;
  static const int postInitializationWaitSeconds = 10;
  
  // HELPER METHODS
  
  /// Get the full Caddy endpoint URL for a specific node
  static String getCaddyEndpoint(String nodeId) {
    return '$caddyBaseUrl/$nodeId';
  }
  
  /// Get the Lightning REST API URL for a specific endpoint
  static String getLightningUrl(String endpoint, {String? nodeId}) {
    final selectedNode = nodeId ?? defaultNodeId;
    return '$caddyBaseUrl/$selectedNode/$endpoint';
  }
  
  /// Get the default node ID (can be overridden for testing)
  static String getDefaultNodeId() {
    return defaultNodeId;
  }
  
  /// Validate node ID format
  static bool isValidNodeId(String nodeId) {
    return RegExp(r'^node\d+$').hasMatch(nodeId);
  }
  
  /// Get all possible node IDs (default + fallbacks)
  static List<String> getAllNodeIds() {
    return [defaultNodeId, ...fallbackNodeIds];
  }
  
  /// Get configuration summary for debugging
  static Map<String, dynamic> getConfigSummary() {
    return {
      'caddy_base_url': caddyBaseUrl,
      'default_node_id': defaultNodeId,
      'fallback_nodes': fallbackNodeIds,
      'default_endpoint': defaultCaddyEndpoint,
      'wallet_password': walletPassword,
      'timeouts': {
        'default': defaultTimeoutSeconds,
        'status_check': statusCheckTimeoutSeconds,
        'lightning_ready_max_wait': lightningReadyMaxWaitSeconds,
        'lightning_ready_check_interval': lightningReadyCheckIntervalSeconds,
        'post_initialization_wait': postInitializationWaitSeconds,
      }
    };
  }
}