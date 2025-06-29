import 'dart:convert';
import 'dart:math' as math;
import 'dart:typed_data';
import 'package:bitnet/backbone/auth/auth.dart';
import 'package:bitnet/backbone/helper/lightning_config.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:bitnet/backbone/services/node_mapping_service.dart';
import 'package:bitnet/models/bitcoin/channel/channel_operation.dart';
import 'package:bitnet/models/bitcoin/lnurl/lnurl_channel_model.dart';
import 'package:bitnet/models/recovery/user_node_mapping.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bech32/bech32.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class LnurlChannelService {
  final LoggerService _logger = Get.find<LoggerService>();

  /// Fetches LNURL channel request
  Future<LnurlChannelRequest> fetchChannelRequest(String lnurlString) async {
    try {
      _logger.i("Processing LNURL channel request: $lnurlString");

      String url;

      // Check if it's already a URL (for testing purposes)
      if (lnurlString.startsWith('http://') ||
          lnurlString.startsWith('https://')) {
        url = lnurlString;
      } else if (lnurlString.toLowerCase().startsWith('lnurl')) {
        // Try to decode LNURL
        try {
          url = await decodeLnurlToUrl(lnurlString);
        } catch (e) {
          // If decoding fails, throw an error - no more demo fallback
          throw Exception(
              "Failed to decode LNURL: $e. Please ensure you have a valid LNURL from your Lightning Service Provider.");
        }
      } else {
        throw Exception("Invalid LNURL or URL format");
      }

      final response = await http.get(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode != 200) {
        throw Exception(
            "Failed to fetch LNURL metadata: ${response.statusCode}");
      }

      final data = jsonDecode(response.body);
      _logger.i("Received LNURL metadata: $data");

      if (data['tag'] != 'channelRequest') {
        throw Exception("Not a channel request LNURL");
      }

      // Check for Blocktank order state
      if (url.contains('blocktank.to')) {
        await _validateBlocktankOrderState(data['k1']);
      }

      return LnurlChannelRequest(
        tag: data['tag'],
        k1: data['k1'],
        callback: data['callback'],
        uri: data['uri'],
        nodeId: _extractNodeIdFromUri(data['uri']),
        localAmt: data['localAmt'],
        pushAmt: data['pushAmt'],
      );
    } catch (e) {
      _logger.e("Failed to fetch channel request: $e");
      throw Exception("Failed to fetch channel request: $e");
    }
  }

  /// Creates a proper Blocktank channel order
  Future<LnurlChannelRequest> createBlocktankChannelOrder({
    int localAmount = 20000,
    int pushAmount = 0,
    bool isPrivate = true,
  }) async {
    try {
      _logger.i("Creating Blocktank channel order for $localAmount sats");

      // Get our node ID for the order
      final ourNodeId = await getNodeId();

      // Create channel order with Blocktank
      final orderResponse = await _createBlocktankOrder(
        localAmount: localAmount,
        pushAmount: pushAmount,
        remoteNodeId: ourNodeId,
        isPrivate: isPrivate,
      );

      if (orderResponse == null) {
        throw Exception("Failed to create Blocktank channel order");
      }

      // Extract order details - Blocktank returns the channel details directly
      final orderId = orderResponse['id'] as String;
      final callbackUrl = orderResponse['open_lnurl'] as String?;
      final k1 = orderId; // Use order ID as k1
      final lspNodeId = orderResponse['lsp_node_id'] as String?;
      final lspNodeHost = orderResponse['lsp_node_host'] as String?;
      final lspNodePort = orderResponse['lsp_node_port'] as int?;

      if (callbackUrl == null || lspNodeId == null || lspNodeHost == null) {
        throw Exception("Incomplete channel order response from Blocktank");
      }

      _logger.i("✅ Blocktank order created: $orderId");
      _logger.i("Callback URL: $callbackUrl");
      _logger.i("LSP Node: $lspNodeId@$lspNodeHost:${lspNodePort ?? 9735}");

      // Create the channel request from Blocktank response
      return LnurlChannelRequest(
        tag: 'channelRequest',
        k1: k1,
        callback: callbackUrl,
        uri: '$lspNodeId@$lspNodeHost:${lspNodePort ?? 9735}',
        nodeId: lspNodeId,
        localAmt: localAmount,
        pushAmt: pushAmount,
      );
    } catch (e) {
      _logger.e("Failed to create Blocktank channel order: $e");
      throw Exception("Failed to create Blocktank channel order: $e");
    }
  }

  /// Creates a channel order with Blocktank API
  Future<Map<String, dynamic>?> _createBlocktankOrder({
    required int localAmount,
    required int pushAmount,
    required String remoteNodeId,
    bool isPrivate = true,
  }) async {
    try {
      _logger.i(
          "Creating Blocktank order: $localAmount sats, push: $pushAmount sats");

      final url = 'https://api1.blocktank.to/api/channels';

      final requestBody = {
        'localBalance': localAmount,
        'remoteBalance': 0, // LSP provides the remote balance
        'pushSat': pushAmount,
        'private': isPrivate,
        'remoteid': remoteNodeId, // Our node ID
      };

      _logger.i("Blocktank order request: $requestBody");

      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'User-Agent': 'BitNET/1.0',
        },
        body: jsonEncode(requestBody),
      );

      _logger.i("Blocktank order response status: ${response.statusCode}");
      _logger.i("Blocktank order response body: ${response.body}");

      if (response.statusCode == 201 || response.statusCode == 200) {
        final data = jsonDecode(response.body);
        _logger.i("✅ Blocktank order created successfully");
        return data;
      } else {
        _logger.e(
            "Failed to create Blocktank order: ${response.statusCode} - ${response.body}");
        return null;
      }
    } catch (e) {
      _logger.e("Error creating Blocktank order: $e");
      return null;
    }
  }

  /// Decodes LNURL string to URL using bech32 decoding
  Future<String> decodeLnurlToUrl(String lnurlString) async {
    try {
      final cleanLnurl = lnurlString.trim().toLowerCase();
      if (!cleanLnurl.startsWith('lnurl')) {
        throw Exception("Invalid LNURL format");
      }

      // Use dart_lnurl's built-in decoding
      try {
        // dart_lnurl can decode the URL from LNURL
        final decoded = bech32.decode(cleanLnurl, 2000);
        final data = Uint8List.fromList(convertBits(decoded.data, 5, 8, false));
        final url = utf8.decode(data);

        _logger.i("Successfully decoded LNURL to: $url");
        return url;
      } catch (e) {
        _logger.e("Bech32 decode failed: $e");

        // Alternative: Try the lnurl package's approach
        try {
          // Remove 'lnurl' prefix and decode
          final withoutPrefix = cleanLnurl.substring(5);
          final decoded = bech32.decode('lnurl$withoutPrefix', 2000);
          final data =
              Uint8List.fromList(convertBits(decoded.data, 5, 8, false));
          final url = utf8.decode(data);

          _logger.i("Successfully decoded LNURL (alternative method) to: $url");
          return url;
        } catch (e2) {
          _logger.e("Alternative decode also failed: $e2");
          throw Exception("Failed to decode LNURL. Please check the format.");
        }
      }
    } catch (e) {
      _logger.e("Failed to decode LNURL: $e");
      rethrow;
    }
  }

  List<int> convertBits(List<int> data, int from, int to, bool pad) {
    var acc = 0;
    var bits = 0;
    final result = <int>[];
    final maxv = (1 << to) - 1;

    for (final value in data) {
      if (value < 0 || (value >> from) != 0) {
        throw Exception('Invalid value: $value');
      }
      acc = (acc << from) | value;
      bits += from;
      while (bits >= to) {
        bits -= to;
        result.add((acc >> bits) & maxv);
      }
    }

    if (pad) {
      if (bits > 0) {
        result.add((acc << (to - bits)) & maxv);
      }
    } else if (bits >= from || ((acc << (to - bits)) & maxv) != 0) {
      throw Exception('Invalid bits');
    }

    return result;
  }

  /// Extracts node ID from URI
  String _extractNodeIdFromUri(String uri) {
    final parts = uri.split('@');
    return parts.isNotEmpty ? parts[0] : '';
  }

  /// Validates Blocktank order state before attempting to claim
  Future<void> _validateBlocktankOrderState(String orderId) async {
    try {
      _logger.i("Validating Blocktank order state for: $orderId");

      final url = 'https://api1.blocktank.to/api/channels/$orderId';

      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'User-Agent': 'BitNET/1.0',
        },
      );

      if (response.statusCode == 200) {
        final orderData = jsonDecode(response.body);
        final state = orderData['state'] as String?;
        final capacity = orderData['localBalance'] as int?;
        final isZeroConf = orderData['zeroConf'] as bool? ?? false;

        _logger.i("Blocktank order details:");
        _logger.i("  State: $state");
        _logger.i("  Capacity: $capacity sats");
        _logger.i("  Zero-conf: $isZeroConf");

        switch (state) {
          case 'paid':
            _logger.i("✅ Order is paid and ready to be executed");
            break;
          case 'open':
            _logger.i(
                "✅ Channel order shows as 'open' - channel may already exist");
            // Don't throw error - let the process continue to check for existing channels
            break;
          case 'created':
            throw Exception(
                "💳 Order needs to be paid first.\n\nThis LNURL is for a Blocktank channel order that hasn't been paid yet. Please complete the payment (usually via Lightning invoice) before scanning this LNURL again.");
          case 'expired':
            throw Exception(
                "⏰ Channel order has expired.\n\nThis LNURL is no longer valid. Please create a new channel order on Blocktank's website.");
          case 'executed':
            throw Exception(
                "✅ Channel order already executed.\n\nThis LNURL was already used to open a channel. Check your active channels - the channel may already exist.");
          case 'refunded':
            throw Exception(
                "💸 Channel order was refunded.\n\nThis LNURL cannot be used because the order was refunded. Create a new order if you want to open a channel.");
          default:
            _logger.w("Unknown order state: $state");
            throw Exception(
                "Channel order is in an unknown state: $state. Cannot proceed.");
        }
      } else if (response.statusCode == 404) {
        throw Exception(
            "Channel order not found. This LNURL may be invalid or expired.");
      } else {
        _logger.w(
            "Failed to validate order state: ${response.statusCode} - ${response.body}");
        // Don't block the process for validation API issues
        _logger.w("Proceeding without order validation due to API error");
      }
    } catch (e) {
      _logger.e("Order validation failed: $e");
      rethrow; // Re-throw to prevent processing invalid orders
    }
  }

  /// Connects to a Lightning peer using LND REST API
  Future<bool> connectToPeer(String nodeId, String host) async {
    try {
      _logger.i("Ensuring peer connection to: $nodeId@$host");

      // First check if we're already connected as peers
      final isConnected = await isPeerConnected(nodeId);
      if (isConnected) {
        _logger.i("✅ Already connected as peers with node $nodeId");
        return true;
      }

      _logger.i("Not connected as peers yet, establishing peer connection...");

      final baseUrl = await _getLndBaseUrl();
      final url = '$baseUrl/v1/peers';

      _logger.i("Using LND endpoint: $url");

      // Get user's macaroon for authentication
      final macaroon = await _getUserMacaroon();

      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Grpc-Metadata-macaroon': macaroon,
        },
        body: jsonEncode({
          'addr': {
            'pubkey': nodeId,
            'host': host,
          },
          'perm': true,
        }),
      );

      if (response.statusCode == 200) {
        _logger.i("✅ Successfully established peer connection");
        return true;
      } else {
        // Check if the error is "already connected"
        final responseBody = response.body.toLowerCase();
        if (responseBody.contains('already connected')) {
          _logger.i(
              "✅ Peer connection already exists (confirmed via error response)");
          return true;
        }

        _logger.e(
            "Failed to establish peer connection: ${response.statusCode} - ${response.body}");
        return false;
      }
    } catch (e) {
      _logger.e("Error establishing peer connection: $e");
      return false;
    }
  }

  /// Checks if a peer is already connected
  Future<bool> isPeerConnected(String nodeId) async {
    try {
      final baseUrl = await _getLndBaseUrl();
      final url = '$baseUrl/v1/peers';

      _logger.i("Checking connected peers");

      // Get user's macaroon for authentication
      final macaroon = await _getUserMacaroon();

      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Grpc-Metadata-macaroon': macaroon,
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final peers = data['peers'] as List<dynamic>? ?? [];

        // Check if the node is in the connected peers list
        for (final peer in peers) {
          if (peer['pub_key'] == nodeId) {
            _logger.i("Found peer $nodeId in connected peers list");
            return true;
          }
        }

        _logger.i("Peer $nodeId not found in connected peers list");
        return false;
      } else {
        _logger.w("Failed to check connected peers: ${response.statusCode}");
        return false;
      }
    } catch (e) {
      _logger.e("Error checking connected peers: $e");
      return false;
    }
  }

  /// Claims a channel by calling the LNURL callback
  Future<LnurlChannelResponse> claimChannel(
    String callbackUrl,
    String k1,
    String remoteId, {
    bool isPrivate = true,
  }) async {
    try {
      _logger.i("Claiming channel with callback: $callbackUrl");
      _logger.i("Remote ID (our node): $remoteId");
      _logger.i("K1: $k1");

      final params = {
        'k1': k1,
        'remoteid': remoteId,
        'private': isPrivate ? '1' : '0',
      };

      final uri = Uri.parse(callbackUrl).replace(queryParameters: params);
      _logger.i("Full callback URL: $uri");

      final response = await http.get(
        uri,
        headers: {
          'Accept': 'application/json',
          'User-Agent': 'BitNET/1.0',
        },
      );

      _logger.i("Claim response status: ${response.statusCode}");
      _logger.i("Claim response body: ${response.body}");

      if (response.statusCode != 200) {
        throw Exception(
            "Failed to claim channel: ${response.statusCode} - ${response.body}");
      }

      final data = jsonDecode(response.body);
      _logger.i("Parsed channel claim response: $data");

      // Check if Blocktank returns additional info
      if (data['status'] == 'OK' || data['status'] == 'ok') {
        _logger.i("✅ Channel claim accepted by service provider");

        // Blocktank might return additional info about the channel
        if (data['event'] != null) {
          _logger.i("Channel event: ${data['event']}");
        }
        if (data['channelId'] != null) {
          _logger.i("Channel ID from provider: ${data['channelId']}");
        }
      }

      return LnurlChannelResponse.fromJson(data);
    } catch (e) {
      _logger.e("Failed to claim channel: $e");
      throw Exception("Failed to claim channel: $e");
    }
  }

  /// Gets the current node's public key
  Future<String> getNodeId() async {
    try {
      final baseUrl = await _getLndBaseUrl();
      final url = '$baseUrl/v1/getinfo';

      _logger.i("Getting node info from: $url");

      // Get user's macaroon for authentication
      final macaroon = await _getUserMacaroon();

      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Grpc-Metadata-macaroon': macaroon,
        },
      );

      _logger.i("Node info response status: ${response.statusCode}");
      _logger.i(
          "Node info response body: ${response.body.substring(0, math.min(100, response.body.length))}...");

      if (response.statusCode == 200) {
        // Check if response body looks like JSON
        if (response.body.trim().startsWith('{')) {
          final data = jsonDecode(response.body);
          final nodeId = data['identity_pubkey'];
          _logger.i("Retrieved node ID: $nodeId");
          return nodeId;
        } else {
          // Response is not JSON, likely an HTML error page
          _logger
              .e("Expected JSON but got HTML/text response: ${response.body}");
          throw Exception(
              "LND API returned HTML instead of JSON. Check if the endpoint URL is correct and the service is running properly.");
        }
      } else {
        throw Exception(
            "Failed to get node info: ${response.statusCode} - ${response.body}");
      }
    } catch (e) {
      _logger.e("Failed to get node ID: $e");
      throw Exception("Failed to get node ID: $e");
    }
  }

  /// Gets the user's macaroon for LND authentication (properly hex-encoded)
  Future<String> _getUserMacaroon() async {
    try {
      final currentUser = Auth().currentUser;
      if (currentUser == null) {
        throw Exception("No authenticated user");
      }

      // Get user's node mapping which contains the macaroon
      final UserNodeMapping? nodeMapping =
          await NodeMappingService.getUserNodeMapping(currentUser.uid);

      if (nodeMapping != null && nodeMapping.adminMacaroon.isNotEmpty) {
        _logger.i("Using user-specific macaroon for ${nodeMapping.nodeId}");

        // Check if macaroon is already in hex format or needs conversion from base64
        try {
          final macaroon = nodeMapping.adminMacaroon;
          _logger.i(
              "Raw macaroon from Firebase: ${macaroon.substring(0, 20)}... (length: ${macaroon.length})");

          // Check if macaroon is already in hex format (even length, only hex chars)
          if (macaroon.length % 2 == 0 &&
              RegExp(r'^[0-9a-fA-F]+$').hasMatch(macaroon)) {
            _logger.i("Macaroon is already in hex format, using directly");
            return macaroon;
          }

          // Try to convert from base64 to hex
          final macaroonBytes = base64.decode(macaroon);
          final hexMacaroon = macaroonBytes
              .map((byte) => byte.toRadixString(16).padLeft(2, '0'))
              .join();

          _logger.i(
              "Converted macaroon from base64 to hex (${macaroon.length} -> ${hexMacaroon.length} chars)");
          return hexMacaroon;
        } catch (e) {
          _logger.e("Failed to process macaroon: $e");
          _logger.w("Attempting to use macaroon as-is");
          return nodeMapping.adminMacaroon;
        }
      } else {
        throw Exception(
            "No user-specific macaroon found for user: ${currentUser.uid}");
      }
    } catch (e) {
      _logger.e("Failed to get user macaroon: $e");
      throw Exception("Failed to get user macaroon: $e");
    }
  }

  /// Checks if the LNURL string is a channel request
  bool isChannelRequest(String lnurlString) {
    try {
      // Check if it's a valid LNURL format first
      if (!lnurlString.toLowerCase().startsWith('lnurl')) {
        return false;
      }

      // For a more thorough check, we'd need to call getParams
      // but for performance, we'll do a heuristic check first
      return true; // Assume it might be a channel request
    } catch (e) {
      return false;
    }
  }

  /// Gets the LND base URL for the current user's node
  Future<String> _getLndBaseUrl() async {
    try {
      final currentUser = Auth().currentUser;
      if (currentUser == null) {
        throw Exception("No authenticated user");
      }

      // Get user's node mapping
      final UserNodeMapping? nodeMapping =
          await NodeMappingService.getUserNodeMapping(currentUser.uid);

      if (nodeMapping != null) {
        // Use user's specific node
        final url = LightningConfig.getCaddyEndpoint(nodeMapping.nodeId);
        _logger.i("Using user's node: ${nodeMapping.nodeId} at $url");
        return url;
      } else {
        // Fallback to default node
        final url = LightningConfig.defaultCaddyEndpoint;
        _logger.i("Using default node: $url");
        return url;
      }
    } catch (e) {
      _logger.e("Failed to get LND base URL: $e");
      // Fallback to default
      return LightningConfig.defaultCaddyEndpoint;
    }
  }

  /// Lists all channels for the current node
  Future<List<Map<String, dynamic>>> listChannels() async {
    try {
      final baseUrl = await _getLndBaseUrl();
      final url = '$baseUrl/v1/channels';

      _logger.i("Listing channels from: $url");

      // Get user's macaroon for authentication
      final macaroon = await _getUserMacaroon();

      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Grpc-Metadata-macaroon': macaroon,
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final channels = data['channels'] as List<dynamic>? ?? [];
        _logger.i("Found ${channels.length} channels");
        return channels.cast<Map<String, dynamic>>();
      } else {
        _logger.e(
            "Failed to list channels: ${response.statusCode} - ${response.body}");
        return [];
      }
    } catch (e) {
      _logger.e("Error listing channels: $e");
      return [];
    }
  }

  /// Verifies that a channel with the specified remote node exists and is active
  Future<bool> verifyChannelCreation(
    String remoteNodeId, {
    int maxWaitSeconds = 60,
    bool checkPendingChannels = false,
  }) async {
    try {
      _logger.i("Verifying channel creation with remote node: $remoteNodeId");
      _logger.i(
          "Max wait time: ${maxWaitSeconds}s, Check pending: $checkPendingChannels");

      final startTime = DateTime.now();
      const checkInterval =
          Duration(seconds: 5); // Increased interval for Blocktank

      while (DateTime.now().difference(startTime).inSeconds < maxWaitSeconds) {
        // Check active channels
        final channels = await listChannels();

        for (final channel in channels) {
          final remotePubkey = channel['remote_pubkey'] as String?;
          final channelActive = channel['active'] as bool? ?? false;
          final channelPoint = channel['channel_point'] as String?;

          if (remotePubkey == remoteNodeId) {
            _logger.i(
                "Found channel with remote node $remoteNodeId: $channelPoint");

            if (channelActive) {
              _logger.i("✅ Channel is active and ready");
              return true;
            } else {
              _logger
                  .i("Channel found but not yet active, continuing to poll...");
            }
          }
        }

        // Check pending channels if requested
        if (checkPendingChannels) {
          final pendingChannel = await findPendingChannel(remoteNodeId);
          if (pendingChannel != null) {
            _logger.i(
                "Found pending channel with $remoteNodeId - waiting for confirmation");
          }
        }

        final elapsed = DateTime.now().difference(startTime).inSeconds;
        _logger.i(
            "No active channel yet after ${elapsed}s, waiting ${checkInterval.inSeconds}s...");
        await Future.delayed(checkInterval);
      }

      _logger.w("Channel verification timed out after ${maxWaitSeconds}s");
      return false;
    } catch (e) {
      _logger.e("Error verifying channel creation: $e");
      return false;
    }
  }

  /// Checks if a channel already exists with the specified remote node
  Future<Map<String, dynamic>?> findExistingChannel(String remoteNodeId) async {
    try {
      _logger
          .i("Checking for existing channel with remote node: $remoteNodeId");

      final channels = await listChannels();

      for (final channel in channels) {
        final remotePubkey = channel['remote_pubkey'] as String?;
        if (remotePubkey == remoteNodeId) {
          final channelActive = channel['active'] as bool? ?? false;
          final channelPoint = channel['channel_point'] as String?;
          final capacity = channel['capacity'] as String?;
          final localBalance = channel['local_balance'] as String?;
          final remoteBalance = channel['remote_balance'] as String?;

          _logger.i("Found existing channel with $remoteNodeId:");
          _logger.i("  Channel Point: $channelPoint");
          _logger.i("  Active: $channelActive");
          _logger.i("  Capacity: $capacity sats");
          _logger.i("  Local Balance: $localBalance sats");
          _logger.i("  Remote Balance: $remoteBalance sats");

          return channel;
        }
      }

      _logger.i("No existing channel found with remote node $remoteNodeId");
      return null;
    } catch (e) {
      _logger.e("Error checking for existing channel: $e");
      return null;
    }
  }

  /// Gets detailed information about a specific channel
  Future<Map<String, dynamic>?> getChannelInfo(String channelPoint) async {
    try {
      final baseUrl = await _getLndBaseUrl();
      final url = '$baseUrl/v1/graph/edge/$channelPoint';

      _logger.i("Getting channel info for: $channelPoint");

      // Get user's macaroon for authentication
      final macaroon = await _getUserMacaroon();

      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Grpc-Metadata-macaroon': macaroon,
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        _logger.i("Retrieved channel info successfully");
        return data;
      } else {
        _logger.e(
            "Failed to get channel info: ${response.statusCode} - ${response.body}");
        return null;
      }
    } catch (e) {
      _logger.e("Error getting channel info: $e");
      return null;
    }
  }

  /// Finds a pending channel with the specified remote node
  Future<Map<String, dynamic>?> findPendingChannel(String remoteNodeId) async {
    try {
      final baseUrl = await _getLndBaseUrl();
      final url = '$baseUrl/v1/channels/pending';

      _logger.i("Checking pending channels for remote node: $remoteNodeId");

      // Get user's macaroon for authentication
      final macaroon = await _getUserMacaroon();

      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Grpc-Metadata-macaroon': macaroon,
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        // Check pending open channels
        final pendingOpen =
            data['pending_open_channels'] as List<dynamic>? ?? [];
        for (final channel in pendingOpen) {
          final channelData = channel['channel'] as Map<String, dynamic>?;
          if (channelData != null &&
              channelData['remote_node_pub'] == remoteNodeId) {
            _logger.i("Found pending open channel with $remoteNodeId");
            _logger.i("  Capacity: ${channelData['capacity']} sats");
            _logger.i("  Local Balance: ${channelData['local_balance']} sats");
            _logger.i(
                "  Confirmation Height: ${channel['confirmation_height'] ?? 'unconfirmed'}");
            return channel;
          }
        }

        // Check other pending states (waiting close, force close)
        final waitingClose =
            data['waiting_close_channels'] as List<dynamic>? ?? [];
        final forcedClose =
            data['pending_force_closing_channels'] as List<dynamic>? ?? [];

        _logger.i("No pending channels found with remote node $remoteNodeId");
        _logger.i(
            "Total pending channels: ${pendingOpen.length} open, ${waitingClose.length} waiting close, ${forcedClose.length} force closing");
        return null;
      } else {
        _logger.e("Failed to check pending channels: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      _logger.e("Error checking pending channels: $e");
      return null;
    }
  }

  /// Creates a new Blocktank channel order and processes it
  ///
  /// Use this method when you want to create a completely new channel order with Blocktank.
  /// If you already have an LNURL from Blocktank, use processChannelRequest() instead.
  Future<LnurlChannelResult> createAndProcessBlocktankChannel({
    int localAmount = 20000,
    int pushAmount = 0,
    bool isPrivate = true,
    Function(ChannelOpeningProgress)? onProgress,
  }) async {
    try {
      _logger.i("Creating and processing Blocktank channel: $localAmount sats");

      // Step 1: Create Blocktank channel order
      onProgress?.call(ChannelOpeningProgress.checkingConnection());
      final channelRequest = await createBlocktankChannelOrder(
        localAmount: localAmount,
        pushAmount: pushAmount,
        isPrivate: isPrivate,
      );

      // Step 2: Process the channel request
      return await processChannelRequest(
        channelRequest: channelRequest,
        onProgress: onProgress,
      );
    } catch (e) {
      _logger.e("Failed to create and process Blocktank channel: $e");
      onProgress?.call(ChannelOpeningProgress.error(e.toString()));
      return LnurlChannelResult(
        success: false,
        message: e.toString(),
        channelRequest: null,
        channelResponse: null,
      );
    }
  }

  /// Complete flow for processing an LNURL channel request with verification
  ///
  /// Use this method when you have an existing LNURL (e.g., from QR code, deep link, or manual entry).
  /// For creating new Blocktank orders, use createAndProcessBlocktankChannel() instead.
  Future<LnurlChannelResult> processChannelRequest({
    String? lnurlString,
    LnurlChannelRequest? channelRequest,
    Function(ChannelOpeningProgress)? onProgress,
  }) async {
    String? operationId;

    try {
      if (lnurlString == null && channelRequest == null) {
        throw Exception(
            "Either lnurlString or channelRequest must be provided");
      }

      LnurlChannelRequest request;
      if (channelRequest != null) {
        request = channelRequest;
        _logger.i("Processing provided channel request");
      } else {
        _logger.i("Processing channel request: $lnurlString");
        // Step 1: Fetch channel request metadata using dart_lnurl
        request = await fetchChannelRequest(lnurlString!);
      }

      // Step 1a: ALWAYS create activity item first - before any checks
      // This ensures user sees activity even if process fails
      operationId = await _createOrUpdateChannelActivity(
        channelRequest: request,
        status: ChannelOperationStatus.pending,
        message: "Analyzing channel request...",
        lnurlString: lnurlString,
      );

      // Step 2: Extract node info from URI
      final uriParts = request.uri.split('@');
      if (uriParts.length != 2) {
        throw Exception("Invalid node URI format");
      }
      final nodeId = uriParts[0];
      final hostPort = uriParts[1];

      // Step 3: Comprehensive pre-flight checks (like your manual process)
      await _updateChannelActivity(operationId, ChannelOperationStatus.pending,
          "Performing pre-flight checks...");
      onProgress?.call(ChannelOpeningProgress.checkingConnection());

      // 3a. Check peer connection status
      final peerConnected = await isPeerConnected(nodeId);
      if (peerConnected) {
        _logger.i("✅ Already connected as peers with node $nodeId");
        await _updateChannelActivity(operationId,
            ChannelOperationStatus.pending, "Peer connection: ✅ Connected");
      } else {
        _logger.i("⚠️ Not connected as peers with node $nodeId");
        await _updateChannelActivity(
            operationId,
            ChannelOperationStatus.pending,
            "Peer connection: ⚠️ Not connected, will establish");
      }

      // 3b. Check for existing active channels
      final existingChannel = await findExistingChannel(nodeId);
      if (existingChannel != null) {
        final isActive = existingChannel['active'] as bool? ?? false;
        final capacity = existingChannel['capacity'];
        final channelPoint = existingChannel['channel_point'];

        if (isActive) {
          _logger.i(
              "✅ Active channel already exists: $channelPoint ($capacity sats)");
          await _updateChannelActivity(
              operationId,
              ChannelOperationStatus.active,
              "✅ Active channel already exists ($capacity sats)",
              existingChannel);

          // Save the final channel operation result to Firebase
          await _saveChannelOperationToFirebase(
            channelRequest: request,
            status: ChannelOperationStatus.active,
            nodeId: nodeId,
            existingChannel: existingChannel,
          );

          onProgress?.call(ChannelOpeningProgress.completed());
          return LnurlChannelResult(
            success: true,
            message: 'Active channel already exists with this peer',
            channelRequest: request,
            channelResponse: LnurlChannelResponse(
                status: 'OK', reason: 'Channel already exists and is active'),
          );
        } else {
          _logger.i("⚠️ Inactive channel exists: $channelPoint");
          await _updateChannelActivity(
              operationId,
              ChannelOperationStatus.pending,
              "Inactive channel exists, will open new channel");
        }
      } else {
        _logger.i("ℹ️ No existing channel found with this peer");
        await _updateChannelActivity(operationId,
            ChannelOperationStatus.pending, "No existing channel found");
      }

      // 3c. Check for pending channels
      final pendingChannel = await findPendingChannel(nodeId);
      if (pendingChannel != null) {
        _logger.i("⏳ Pending channel found with this peer");
        // Create a safe copy of pendingChannel without null values
        final safePendingChannel = Map<String, dynamic>.from(pendingChannel)
          ..removeWhere((key, value) => value == null);
        await _updateChannelActivity(
            operationId,
            ChannelOperationStatus.opening,
            "Channel already opening on-chain",
            safePendingChannel);

        onProgress?.call(ChannelOpeningProgress.completed());
        return LnurlChannelResult(
          success: true,
          message: 'Channel is already being opened with this peer',
          channelRequest: request,
          channelResponse: LnurlChannelResponse(
              status: 'OK', reason: 'Channel is already pending confirmation'),
        );
      } else {
        _logger.i("ℹ️ No pending channel found with this peer");
        await _updateChannelActivity(
            operationId,
            ChannelOperationStatus.pending,
            "No pending channel found, ready to proceed");
      }

      // Step 4: Ensure we're connected as peers (required before opening channel)
      await _updateChannelActivity(operationId, ChannelOperationStatus.pending,
          "Establishing peer connection...");
      onProgress?.call(ChannelOpeningProgress.connecting());

      if (!peerConnected) {
        final connected = await connectToPeer(nodeId, hostPort);
        if (!connected) {
          await _updateChannelActivity(
              operationId,
              ChannelOperationStatus.failed,
              "❌ Failed to connect to LSP node as peer");
          throw Exception("Failed to connect to LSP node as peer");
        }
        await _updateChannelActivity(operationId,
            ChannelOperationStatus.pending, "✅ Peer connection established");
      }

      // Step 5: Get our node ID
      final myNodeId = await getNodeId();

      // Step 6: Claim the channel
      await _updateChannelActivity(operationId, ChannelOperationStatus.pending,
          "Claiming channel with LSP...");
      onProgress?.call(ChannelOpeningProgress.claiming());
      final channelResponse = await claimChannel(
        request.callback,
        request.k1,
        myNodeId,
        isPrivate:
            true, // Default to private channel (based on working implementation)
      );

      if (channelResponse.status != 'OK') {
        final errorMessage = channelResponse.reason ?? 'Channel claim failed';
        _logger.w("Channel claim failed: $errorMessage");

        // Update activity with error details
        await _updateChannelActivity(operationId, ChannelOperationStatus.failed,
            "❌ Channel claim failed: $errorMessage");

        // Check if the error is due to order state issues
        if (errorMessage.toLowerCase().contains('not in the right state')) {
          // Specific handling for Blocktank order state errors
          if (errorMessage.toLowerCase().contains('paid')) {
            await _updateChannelActivity(
                operationId,
                ChannelOperationStatus.failed,
                "💳 Order needs to be paid first");
            throw Exception(
                "💳 This channel order needs to be paid first.\n\nPlease complete the payment (usually via Lightning invoice) before scanning this LNURL again.");
          } else if (errorMessage.toLowerCase().contains('executed') ||
              errorMessage.toLowerCase().contains('already')) {
            _logger.i(
                "Order appears to be already claimed, checking for existing channel...");

            // Check if we actually have an active channel with this peer
            final existingChannel = await findExistingChannel(nodeId);
            if (existingChannel != null) {
              final isActive = existingChannel['active'] as bool? ?? false;
              if (isActive) {
                _logger.i(
                    "✅ Found active channel despite claim error - order was already executed");

                // Log this as a successful existing channel detection
                await _saveChannelOperationToFirebase(
                  channelRequest: request,
                  status: ChannelOperationStatus.active,
                  nodeId: nodeId,
                  existingChannel: existingChannel,
                  errorMessage:
                      'Channel order was already executed, but channel is active',
                );

                onProgress?.call(ChannelOpeningProgress.completed());
                return LnurlChannelResult(
                  success: true,
                  message:
                      'Channel order was already executed, but channel is active and ready',
                  channelRequest: request,
                  channelResponse: LnurlChannelResponse(
                      status: 'OK',
                      reason: 'Channel already exists and is active'),
                );
              }
            }
          } else {
            // Handle other "not in right state" errors
            throw Exception("❌ Channel order error: $errorMessage");
          }
        }

        // If we get here, it's a real error
        final errorProgress = ChannelOpeningProgress.error(errorMessage);
        onProgress?.call(errorProgress);

        // Still log the failed attempt to Firebase for user visibility
        await _saveChannelOperationToFirebase(
          channelRequest: request,
          status: ChannelOperationStatus.failed,
          nodeId: nodeId,
          existingChannel: null,
          errorMessage: errorMessage,
        );

        return LnurlChannelResult(
          success: false,
          message: errorMessage,
          channelRequest: request,
          channelResponse: channelResponse,
        );
      }

      // Step 7: Opening channel
      onProgress?.call(ChannelOpeningProgress.opening());
      await Future.delayed(
          Duration(seconds: 2)); // Allow some time for channel opening to begin

      // Step 8: Verify the channel was actually created
      onProgress?.call(ChannelOpeningProgress.verifying());
      _logger.i("Channel claimed successfully, verifying channel creation...");

      // Blocktank channels can take 2-5 minutes to open
      final channelVerified = await verifyChannelCreation(
        nodeId,
        maxWaitSeconds: 180, // 3 minutes timeout
        checkPendingChannels: true,
      );

      if (!channelVerified) {
        _logger
            .w("Channel verification timed out - channel may still be opening");

        // Check if there's at least a pending channel
        final pendingChannel = await findPendingChannel(nodeId);
        if (pendingChannel != null) {
          _logger.i("Found pending channel - it's being opened on-chain");

          // Update Firebase status to opening
          await _saveChannelOperationToFirebase(
            channelRequest: request,
            status: ChannelOperationStatus.opening,
            nodeId: nodeId,
            existingChannel: pendingChannel,
          );

          onProgress?.call(ChannelOpeningProgress.completed());
          return LnurlChannelResult(
            success: true,
            message:
                'Channel is being opened on-chain. It will be active after confirmation.',
            channelRequest: request,
            channelResponse: channelResponse,
          );
        }

        final errorProgress = ChannelOpeningProgress.error(
            'Channel was claimed but could not be verified. Please check your channels later.');
        onProgress?.call(errorProgress);
        return LnurlChannelResult(
          success: false,
          message:
              'Channel was claimed but could not be verified. Please check your channels later.',
          channelRequest: request,
          channelResponse: channelResponse,
        );
      }

      // Step 9: Success - Save to Firebase
      onProgress?.call(ChannelOpeningProgress.completed());
      _logger.i("✅ Channel successfully created and verified");

      // Save channel operation to Firebase
      await _saveChannelOperationToFirebase(
        channelRequest: request,
        status: ChannelOperationStatus.active,
        nodeId: nodeId,
        existingChannel: existingChannel,
      );

      return LnurlChannelResult(
        success: true,
        message: 'Channel created and verified successfully',
        channelRequest: request,
        channelResponse: channelResponse,
      );
    } catch (e) {
      _logger.e("Failed to process channel request: $e");

      // Update activity with final error if we have an operation ID
      if (operationId != null) {
        // Clean up the error message to avoid UI errors being saved
        String cleanErrorMessage = e.toString();
        if (cleanErrorMessage.contains('setState() called after dispose()')) {
          cleanErrorMessage = "Process was cancelled";
        } else if (cleanErrorMessage.length > 200) {
          cleanErrorMessage = cleanErrorMessage.substring(0, 200) + "...";
        }
        await _updateChannelActivity(operationId, ChannelOperationStatus.failed,
            "❌ Process failed: $cleanErrorMessage");
      }

      onProgress?.call(ChannelOpeningProgress.error(e.toString()));
      return LnurlChannelResult(
        success: false,
        message: e.toString(),
        channelRequest: null,
        channelResponse: null,
      );
    }
  }

  /// Saves channel operation to Firebase
  Future<void> _saveChannelOperationToFirebase({
    required LnurlChannelRequest channelRequest,
    required ChannelOperationStatus status,
    required String nodeId,
    Map<String, dynamic>? existingChannel,
    String? errorMessage,
  }) async {
    try {
      final userId = Auth().currentUser?.uid;
      if (userId == null) {
        _logger.e("No authenticated user to save channel operation");
        return;
      }

      // Extract provider name from callback URL
      String providerName = 'Lightning Service Provider';
      try {
        final uri = Uri.parse(channelRequest.callback);
        if (uri.host.contains('blocktank'))
          providerName = 'Blocktank';
        else if (uri.host.contains('lnbits'))
          providerName = 'LNbits';
        else
          providerName = uri.host;
      } catch (e) {
        _logger.w("Could not extract provider name from callback URL");
      }

      // Generate a unique ID for this channel operation
      final channelId = '${nodeId}_${DateTime.now().millisecondsSinceEpoch}';

      // Use actual channel data if available, otherwise fall back to request data
      int actualCapacity = channelRequest.localAmt ?? 0;
      int actualLocalBalance = channelRequest.localAmt ?? 0;
      String? actualChannelPoint = existingChannel?['channel_point'];
      bool actualIsPrivate =
          true; // Default to private based on working implementation

      // If we have existing channel data, use real values
      if (existingChannel != null) {
        actualCapacity =
            int.tryParse(existingChannel['capacity']?.toString() ?? '0') ?? 0;
        actualLocalBalance =
            int.tryParse(existingChannel['local_balance']?.toString() ?? '0') ??
                0;
        actualChannelPoint = existingChannel['channel_point'];
        actualIsPrivate = existingChannel['private'] ?? true;
      }

      final channelOperation = ChannelOperation(
        channelId: channelId,
        remoteNodeId: nodeId,
        remoteNodeAlias: providerName,
        capacity: actualCapacity,
        localBalance: actualLocalBalance,
        pushAmount: channelRequest.pushAmt ?? 0,
        timestamp: DateTime.now().millisecondsSinceEpoch,
        status: status,
        type: status == ChannelOperationStatus.active && existingChannel != null
            ? ChannelOperationType
                .existing // Mark as existing if we found an active channel
            : ChannelOperationType.open,
        txHash: channelRequest.k1, // Use k1 as a reference
        channelPoint: actualChannelPoint,
        isPrivate: actualIsPrivate,
        errorMessage: errorMessage,
        metadata: {
          'callback': channelRequest.callback,
          'uri': channelRequest.uri,
          'detection_method': existingChannel != null
              ? 'existing_channel_found'
              : 'new_channel_created',
          if (existingChannel != null) 'channel_details': existingChannel,
        },
      );

      // Save to Firestore
      await FirebaseFirestore.instance
          .collection('backend')
          .doc(userId)
          .collection('channel_operations')
          .doc(channelId)
          .set(channelOperation.toFirestore());

      _logger.i("✅ Channel operation saved to Firebase: $channelId");
    } catch (e) {
      _logger.e("Failed to save channel operation to Firebase: $e");
      // Don't throw - this is not critical for the channel opening process
    }
  }

  /// Saves pending channel operation when starting the process
  Future<void> _savePendingChannelOperation({
    required LnurlChannelRequest channelRequest,
    required String nodeId,
  }) async {
    await _saveChannelOperationToFirebase(
      channelRequest: channelRequest,
      status: ChannelOperationStatus.pending,
      nodeId: nodeId,
      existingChannel: null,
    );
  }

  /// Creates a simplified activity log for user awareness
  Future<void> logChannelActivity({
    required String nodeId,
    required String providerName,
    required String activityType,
    required String message,
    Map<String, dynamic>? metadata,
  }) async {
    try {
      final userId = Auth().currentUser?.uid;
      if (userId == null) return;

      final activityId =
          '${nodeId}_${activityType}_${DateTime.now().millisecondsSinceEpoch}';

      await FirebaseFirestore.instance
          .collection('backend')
          .doc(userId)
          .collection('channel_activities')
          .doc(activityId)
          .set({
        'activity_id': activityId,
        'node_id': nodeId,
        'provider_name': providerName,
        'activity_type': activityType,
        'message': message,
        'timestamp': DateTime.now().millisecondsSinceEpoch,
        'metadata': metadata ?? {},
        'created_at': FieldValue.serverTimestamp(),
      });

      _logger.i("✅ Channel activity logged: $activityType for $providerName");
    } catch (e) {
      _logger.e("Failed to log channel activity: $e");
    }
  }

  /// Creates or updates a channel activity item for tracking retries of same LNURL/order
  Future<String> _createOrUpdateChannelActivity({
    required LnurlChannelRequest channelRequest,
    required ChannelOperationStatus status,
    required String message,
    String? lnurlString,
    Map<String, dynamic>? existingChannel,
  }) async {
    try {
      final userId = Auth().currentUser?.uid;
      if (userId == null) {
        throw Exception("No authenticated user");
      }

      final nodeId = _extractNodeIdFromUri(channelRequest.uri);
      final orderId = channelRequest.k1;

      // Create a consistent ID based on order ID or LNURL for retries
      final operationId = 'order_${orderId}_${userId}';

      // Extract provider name
      String providerName = 'Lightning Service Provider';
      try {
        final uri = Uri.parse(channelRequest.callback);
        if (uri.host.contains('blocktank'))
          providerName = 'Blocktank';
        else if (uri.host.contains('lnbits'))
          providerName = 'LNbits';
        else
          providerName = uri.host;
      } catch (e) {
        _logger.w("Could not extract provider name from callback URL");
      }

      // Use actual channel data if available
      int actualCapacity = channelRequest.localAmt ?? 0;
      int actualLocalBalance = channelRequest.localAmt ?? 0;
      String? actualChannelPoint = existingChannel?['channel_point'];
      bool actualIsPrivate = true;

      if (existingChannel != null) {
        actualCapacity =
            int.tryParse(existingChannel['capacity']?.toString() ?? '0') ?? 0;
        actualLocalBalance =
            int.tryParse(existingChannel['local_balance']?.toString() ?? '0') ??
                0;
        actualChannelPoint = existingChannel['channel_point'];
        actualIsPrivate = existingChannel['private'] ?? true;
      }

      final channelOperation = ChannelOperation(
        channelId: operationId,
        remoteNodeId: nodeId,
        remoteNodeAlias: providerName,
        capacity: actualCapacity,
        localBalance: actualLocalBalance,
        pushAmount: channelRequest.pushAmt ?? 0,
        timestamp: DateTime.now().millisecondsSinceEpoch,
        status: status,
        type: existingChannel != null && status == ChannelOperationStatus.active
            ? ChannelOperationType.existing
            : ChannelOperationType.open,
        txHash: orderId,
        channelPoint: actualChannelPoint,
        isPrivate: actualIsPrivate,
        errorMessage: status == ChannelOperationStatus.failed ? message : null,
        metadata: {
          'callback': channelRequest.callback,
          'uri': channelRequest.uri,
          'current_message': message,
          'last_updated': DateTime.now().millisecondsSinceEpoch,
          if (lnurlString != null) 'lnurl': lnurlString,
          if (existingChannel != null) 'channel_details': existingChannel,
        },
      );

      // Save/update to Firestore with consistent ID for retries
      await FirebaseFirestore.instance
          .collection('backend')
          .doc(userId)
          .collection('channel_operations')
          .doc(operationId)
          .set(channelOperation.toFirestore(), SetOptions(merge: true));

      _logger.i("✅ Channel activity created/updated: $operationId - $message");
      return operationId;
    } catch (e) {
      _logger.e("Failed to create/update channel activity: $e");
      return 'fallback_${DateTime.now().millisecondsSinceEpoch}';
    }
  }

  /// Updates an existing channel activity with new status and message
  Future<void> _updateChannelActivity(
    String operationId,
    ChannelOperationStatus status,
    String message, [
    Map<String, dynamic>? existingChannel,
  ]) async {
    try {
      final userId = Auth().currentUser?.uid;
      if (userId == null) return;

      final updateData = <String, dynamic>{
        'status': status.value,
        'metadata.current_message': message,
        'metadata.last_updated': DateTime.now().millisecondsSinceEpoch,
        'updated_at': FieldValue.serverTimestamp(),
      };

      if (status == ChannelOperationStatus.failed) {
        updateData['error_message'] = message;
      }

      if (existingChannel != null && existingChannel.isNotEmpty) {
        updateData['capacity'] =
            int.tryParse(existingChannel['capacity']?.toString() ?? '0') ?? 0;
        updateData['local_balance'] =
            int.tryParse(existingChannel['local_balance']?.toString() ?? '0') ??
                0;
        updateData['channel_point'] = existingChannel['channel_point'] ?? '';

        // Clean the existingChannel data to avoid null values
        final cleanChannelDetails = <String, dynamic>{};
        existingChannel.forEach((key, value) {
          if (value != null) {
            cleanChannelDetails[key] = value;
          }
        });
        updateData['metadata.channel_details'] = cleanChannelDetails;

        updateData['type'] = status == ChannelOperationStatus.active
            ? ChannelOperationType.existing.value
            : ChannelOperationType.open.value;
      }

      await FirebaseFirestore.instance
          .collection('backend')
          .doc(userId)
          .collection('channel_operations')
          .doc(operationId)
          .update(updateData);

      _logger.i("✅ Channel activity updated: $operationId - $message");
    } catch (e) {
      _logger.e("Failed to update channel activity: $e");
    }
  }
}
