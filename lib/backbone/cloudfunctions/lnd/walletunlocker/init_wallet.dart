import 'dart:io';
import 'dart:convert';
import 'dart:typed_data';
import 'package:bitnet/backbone/helper/http_no_ssl.dart';
import 'package:bitnet/backbone/helper/lightning_config.dart';
import 'package:bitnet/backbone/helper/theme/remoteconfig_controller.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:bitnet/models/firebase/restresponse.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
// import 'package:pointycastle/export.dart'; // No longer needed after removing BIP39 derivation

// BIP39-related deriveSeedFromMnemonic function removed - no longer needed for Lightning native aezeed format

Future<RestResponse> initWallet(List<String> mnemonicSeed,
    {String? nodeId}) async {
  LoggerService logger = Get.find();

  // Original litd controller approach (commented out for Caddy MVP)
  // final litdController = Get.find<LitdController>();
  // final String restHost = litdController.litd_baseurl.value;
  // String url = 'https://$restHost/v1/initwallet';

  // Use centralized Lightning configuration
  String selectedNode = nodeId ?? LightningConfig.getDefaultNodeId();
  String url =
      LightningConfig.getLightningUrl('v1/initwallet', nodeId: selectedNode);

  logger.i("=== INIT WALLET DEBUG INFO ===");
  logger.i("Target URL: $url");
  logger.i("Selected Node: $selectedNode");
  logger.i("Caddy Base URL: ${LightningConfig.caddyBaseUrl}");

  logger.i("=== USING GENSEED MNEMONIC FOR WALLET INITIALIZATION ===");
  logger.i("Provided mnemonic from genseed: $mnemonicSeed");
  logger.i("Mnemonic seed count: ${mnemonicSeed.length} words");
  logger.i("Individual words:");
  for (int i = 0; i < mnemonicSeed.length; i++) {
    logger.i("  Word ${i + 1}: '${mnemonicSeed[i]}'");
  }

  String walletPassword = LightningConfig.walletPassword;
  String encodedPassword = base64Encode(utf8.encode(walletPassword));
  logger.i("Wallet password (base64): $encodedPassword");

  Map<String, dynamic> data = {
    'wallet_password': encodedPassword,
    'cipher_seed_mnemonic': mnemonicSeed,
    'recovery_window': 0,
    'channel_backups': null,
    'stateless_init': false,
    // 'macaroon_root_key': macaroonRootKeyBase64, // Removed to match Python working implementation
  };

  logger.i("=== REQUEST PAYLOAD COMPARISON ===");
  logger.i("Our Dart request:");
  logger.i("  wallet_password: $encodedPassword");
  logger.i("  cipher_seed_mnemonic: $mnemonicSeed");
  logger.i("  recovery_window: 0");
  logger.i("  channel_backups: null");
  logger.i("  stateless_init: false");
  logger.i("");
  logger.i("Python working request (for comparison):");
  logger.i(
      "  wallet_password: base64.b64encode(b'development_password_dj83zb').decode('utf-8')");
  logger.i("  cipher_seed_mnemonic: mnemonic_seed (from genseed response)");
  logger.i("  recovery_window: 0");
  logger.i("  channel_backups: None");
  logger.i("  stateless_init: False");
  logger.i("");
  logger.i("Full request data: ${json.encode(data)}");

  // Load and convert the macaroon asset
  final RemoteConfigController remoteConfigController =
      Get.find<RemoteConfigController>();

  ByteData byteData = await remoteConfigController.loadAdminMacaroonAsset();
  List<int> bytes = byteData.buffer.asUint8List();
  String macaroon = bytesToHex(bytes);
  logger
      .i("Admin macaroon loaded: ${macaroon.substring(0, 20)}... (truncated)");

  Map<String, String> headers = {
    'Grpc-Metadata-macaroon': macaroon,
    'Content-Type': 'application/json',
  };

  logger.i("=== REQUEST HEADERS ===");
  headers.forEach((key, value) {
    if (key == 'Grpc-Metadata-macaroon') {
      logger.i("$key: ${value.substring(0, 20)}... (truncated)");
    } else {
      logger.i("$key: $value");
    }
  });

  // Override HTTP settings if necessary
  HttpOverrides.global = MyHttpOverrides();

  logger.i("=== MAKING HTTP REQUEST ===");
  logger.i("About to make POST request to: $url");

  try {
    var response = await http
        .post(
          Uri.parse(url),
          headers: headers,
          body: json.encode(data),
        )
        .timeout(Duration(seconds: LightningConfig.defaultTimeoutSeconds));

    logger.i("=== HTTP RESPONSE RECEIVED ===");
    logger.i("Response Status Code: ${response.statusCode}");
    logger.i("Response Headers: ${response.headers}");
    logger.i("Response Body Length: ${response.body.length}");
    logger.i("Raw Response Body: ${response.body}");

    if (response.statusCode == 200) {
      try {
        Map<String, dynamic> responseData = jsonDecode(response.body);
        logger.i("=== PARSED RESPONSE DATA ===");
        responseData.forEach((key, value) {
          if (key == 'admin_macaroon' && value != null) {
            logger
                .i("$key: ${value.toString().substring(0, 20)}... (truncated)");
          } else {
            logger.i("$key: $value");
          }
        });

        String adminMacaroon =
            responseData['admin_macaroon'] ?? 'Admin macaroon not found';
        logger.i(
            "Admin Macaroon extracted successfully: ${adminMacaroon.isNotEmpty ? 'YES' : 'NO'}");

        return RestResponse(
          statusCode: "${response.statusCode}",
          message: "Wallet initialized successfully",
          data: responseData,
        );
      } catch (jsonError) {
        logger.e("Error parsing JSON response: $jsonError");
        return RestResponse(
          statusCode: "error",
          message: "Failed to parse response: $jsonError",
          data: {"raw_response": response.body},
        );
      }
    } else {
      logger.e("=== HTTP ERROR RESPONSE ===");
      logger.e("Status Code: ${response.statusCode}");
      logger.e("Status Text: ${response.reasonPhrase}");
      logger.e("Response Body: ${response.body}");
      logger.e("Response Headers: ${response.headers}");

      return RestResponse(
        statusCode: "error",
        message:
            "Failed to initialize wallet: ${response.statusCode}, ${response.body}",
        data: {
          "status_code": response.statusCode,
          "raw_response": response.body
        },
      );
    }
  } catch (e, stackTrace) {
    logger.e("=== EXCEPTION CAUGHT ===");
    logger.e("Exception Type: ${e.runtimeType}");
    logger.e("Exception Message: $e");
    logger.e("Stack Trace: $stackTrace");

    if (e.toString().contains('timeout')) {
      logger.e("CONNECTION TIMEOUT - Check if Caddy server is running on $url");
    } else if (e.toString().contains('connection')) {
      logger.e(
          "CONNECTION ERROR - Check network connectivity and server availability");
    }

    return RestResponse(
      statusCode: "error",
      message: "Failed to initialize wallet: $e",
      data: {
        "exception_type": e.runtimeType.toString(),
        "exception_message": e.toString()
      },
    );
  }
}
