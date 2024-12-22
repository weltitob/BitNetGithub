import 'dart:io';
import 'package:bitnet/backbone/cloudfunctions/aws/litd_controller.dart';
import 'package:bitnet/backbone/helper/http_no_ssl.dart';
import 'package:bitnet/backbone/helper/loadmacaroon.dart';
import 'package:bitnet/backbone/helper/theme/remoteconfig_controller.dart';
import 'package:bitnet/backbone/services/base_controller/dio/dio_service.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:bitnet/models/firebase/restresponse.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

enum WalletState {
  nonExisting,
  locked,
  unlocked,
  rpcActive,
  serverActive,
  waitingToStart,
  unknown, // For any unexpected state
}

extension WalletStateExtension on WalletState {
  /// Converts a string to a WalletState enum.
  static WalletState fromString(String state) {
    switch (state.toUpperCase()) {
      case 'NON_EXISTING':
        return WalletState.nonExisting;
      case 'LOCKED':
        return WalletState.locked;
      case 'UNLOCKED':
        return WalletState.unlocked;
      case 'RPC_ACTIVE':
        return WalletState.rpcActive;
      case 'SERVER_ACTIVE':
        return WalletState.serverActive;
      case 'WAITING_TO_START':
        return WalletState.waitingToStart;
      default:
        return WalletState.unknown;
    }
  }

  /// Provides a user-friendly description for each WalletState.
  String get description {
    switch (this) {
      case WalletState.nonExisting:
        return 'Wallet has not been initialized.';
      case WalletState.locked:
        return 'Wallet is locked and requires a password to unlock.';
      case WalletState.unlocked:
        return 'Wallet is unlocked, but RPC server isn\'t ready.';
      case WalletState.rpcActive:
        return 'RPC server is active and ready for wallet initialization.';
      case WalletState.serverActive:
        return 'LND server is ready to accept calls.';
      case WalletState.waitingToStart:
        return 'Node is waiting to become the leader in a cluster.';
      case WalletState.unknown:
      default:
        return 'Unknown wallet state.';
    }
  }
}

Future<WalletState> requestState() async {
  final logger = Get.find<LoggerService>();
  final litdController = Get.find<LitdController>();
  final String restHost = litdController.litd_baseurl.value;

  String url = 'https://$restHost/v1/state';

  // Read the macaroon file and convert it to a hexadecimal string
  final RemoteConfigController remoteConfigController = Get.find<RemoteConfigController>();

  ByteData byteData = await remoteConfigController.loadAdminMacaroonAsset();
  List<int> bytes = byteData.buffer.asUint8List();
  String macaroon = bytesToHex(bytes);

  Map<String, String> headers = {
    'Grpc-Metadata-macaroon': macaroon,
  };

  HttpOverrides.global = MyHttpOverrides();

  try {
    final DioClient dioClient = Get.find<DioClient>();
    // Use GET request instead of POST
    var response = await dioClient.get(url: url, headers: headers);
    // Print raw response for debugging
    logger.i('Raw Response: ${response.data}');

    if (response.statusCode == 200) {
      String stateStr = response.data['state'] ?? 'UNKNOWN';
      WalletState walletState = WalletStateExtension.fromString(stateStr);
      logger.i('Parsed Wallet State: ${walletState.description}');
      return walletState;
    } else {
      logger.e('Failed to load data: ${response.statusCode}, ${response.data}');
      return WalletState.unknown;
    }
  } catch (e) {
    logger.e('Error: $e');
    return WalletState.unknown;
  }
}
