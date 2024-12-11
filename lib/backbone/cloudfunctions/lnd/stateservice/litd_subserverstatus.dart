import 'dart:convert';
import 'dart:io';
import 'package:bitnet/backbone/cloudfunctions/aws/litd_controller.dart';
import 'package:bitnet/backbone/helper/http_no_ssl.dart';
import 'package:bitnet/backbone/helper/loadmacaroon.dart';
import 'package:bitnet/backbone/services/base_controller/dio/dio_service.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:bitnet/models/bitcoin/lnd/subserverinfo.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

// Ensure all necessary imports are included

Future<void> waitForWalletReady() async {
  final logger = Get.find<LoggerService>();

  // Create a Completer to handle asynchronous completion
  Completer<void> completer = Completer<void>();

  // Initialize the Timer.periodic
  Timer.periodic(Duration(seconds: 10), (Timer timer) async {
    logger.i("Checking sub server status...");

    try {
      SubServersStatus? status = await fetchSubServerStatus();

      if (status != null) {
        // Access the 'lnd' subserver's customStatus
        SubServerInfo? lndStatus = status.subServers['lnd'];

        if (lndStatus != null) {
          logger.i("LND Custom Status: ${lndStatus.customStatus}");

          if (lndStatus.customStatus == "Wallet Ready") {
            logger.i("Wallet is ready!");
            timer.cancel(); // Stop the timer
            completer.complete(); // Complete the future
          } else {
            logger.i("Wallet not ready yet.");
          }
        } else {
          logger.e("LND subserver information not found.");
        }
      } else {
        logger.e("Failed to fetch sub server status.");
      }
    } catch (e) {
      logger.e("Error while checking wallet status: $e");
      timer.cancel(); // Stop the timer on error
      completer.completeError(e); // Complete with error
    }
  });

  // Optional: Add a timeout to prevent infinite waiting
  Future.delayed(Duration(minutes: 5)).then((_) {
    if (!completer.isCompleted) {
      completer.completeError("Timeout waiting for wallet to be ready.");
    }
  });

  // Await the completer's future
  return completer.future;
}

/// Modify the request function to return the SubServersStatus model directly
Future<SubServersStatus?> fetchSubServerStatus() async {
  final logger = Get.find<LoggerService>();
  final litdController = Get.find<LitdController>();
  final String restHost = litdController.litd_baseurl.value;

  String url = 'https://$restHost/v1/status';

  // Load the macaroon from assets
  try {
    ByteData byteData = await loadMacaroonAsset();
    List<int> bytes = byteData.buffer.asUint8List();
    String macaroon = bytesToHex(bytes);

    Map<String, String> headers = {
      'Grpc-Metadata-macaroon': macaroon,
    };

    HttpOverrides.global = MyHttpOverrides();

    final uri = Uri.parse(url);
    final response = await http.get(uri, headers: headers);

    if (response.statusCode == 200) {
      logger.i("RESPONSE SUCCESS: ${response.body}");
      return SubServersStatus.fromJson(jsonDecode(response.body));
    } else {
      logger.e(
          'Failed to load data. Status Code: ${response.statusCode}, Body: ${response.body}');
      return null;
    }
  } on SocketException {
    logger.e('Network error: Unable to reach the server');
    return null;
  } on FormatException catch (e) {
    logger.e('Data format error: $e');
    return null;
  } on HttpException catch (e) {
    logger.e('HTTP error: $e');
    return null;
  } on Exception catch (e) {
    logger.e('Unexpected error: $e');
    return null;
  }
}