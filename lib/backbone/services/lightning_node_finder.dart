/// Lightning Node Finder Service
/// 
/// Finds available Lightning nodes by testing connectivity
import 'package:bitnet/backbone/helper/lightning_config.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class LightningNodeFinder {
  static final LoggerService _logger = Get.find<LoggerService>();

  /// Find the first working Lightning node from available options
  static Future<String?> findWorkingNode({
    int timeoutSeconds = 5,
    bool includeDefaultNode = true,
  }) async {
    _logger.i("🔍 Searching for available Lightning nodes...");
    
    List<String> nodesToTry = [];
    
    if (includeDefaultNode) {
      nodesToTry.add(LightningConfig.getDefaultNodeId());
    }
    
    nodesToTry.addAll(LightningConfig.fallbackNodeIds);
    
    _logger.i("Nodes to test: $nodesToTry");
    
    for (String nodeId in nodesToTry) {
      _logger.i("Testing node: $nodeId");
      
      bool isWorking = await _testNodeConnectivity(nodeId, timeoutSeconds);
      
      if (isWorking) {
        _logger.i("✅ Found working node: $nodeId");
        return nodeId;
      } else {
        _logger.w("❌ Node $nodeId is not responding");
      }
    }
    
    _logger.e("💔 No working Lightning nodes found!");
    return null;
  }

  /// Test if a specific node is responsive
  static Future<bool> _testNodeConnectivity(String nodeId, int timeoutSeconds) async {
    try {
      // Test basic connectivity with a simple endpoint
      String testUrl = LightningConfig.getLightningUrl('v1/state', nodeId: nodeId);
      
      _logger.d("Testing connectivity: $testUrl");
      
      var response = await http.get(
        Uri.parse(testUrl),
        headers: {
          'Content-Type': 'application/json',
        },
      ).timeout(Duration(seconds: timeoutSeconds));
      
      // Accept any response that's not a connection error
      // Even auth errors (401/403) mean the node is running
      bool isResponding = response.statusCode < 500;
      
      _logger.d("Node $nodeId response: ${response.statusCode} (responding: $isResponding)");
      
      return isResponding;
      
    } catch (e) {
      _logger.d("Node $nodeId connectivity test failed: $e");
      return false;
    }
  }

  /// Get connectivity status for all nodes
  static Future<Map<String, bool>> getAllNodeStatus({
    int timeoutSeconds = 5,
  }) async {
    _logger.i("🔍 Testing all Lightning nodes...");
    
    Map<String, bool> nodeStatus = {};
    List<String> allNodes = LightningConfig.getAllNodeIds();
    
    for (String nodeId in allNodes) {
      bool isWorking = await _testNodeConnectivity(nodeId, timeoutSeconds);
      nodeStatus[nodeId] = isWorking;
      
      _logger.i("Node $nodeId: ${isWorking ? '✅ UP' : '❌ DOWN'}");
    }
    
    return nodeStatus;
  }

  /// Find multiple working nodes (for load balancing)
  static Future<List<String>> findMultipleWorkingNodes({
    int maxNodes = 3,
    int timeoutSeconds = 5,
  }) async {
    _logger.i("🔍 Finding $maxNodes working Lightning nodes...");
    
    List<String> workingNodes = [];
    List<String> allNodes = LightningConfig.getAllNodeIds();
    
    for (String nodeId in allNodes) {
      if (workingNodes.length >= maxNodes) break;
      
      bool isWorking = await _testNodeConnectivity(nodeId, timeoutSeconds);
      
      if (isWorking) {
        workingNodes.add(nodeId);
        _logger.i("✅ Added working node: $nodeId (${workingNodes.length}/$maxNodes)");
      }
    }
    
    _logger.i("Found ${workingNodes.length} working nodes: $workingNodes");
    
    return workingNodes;
  }
}