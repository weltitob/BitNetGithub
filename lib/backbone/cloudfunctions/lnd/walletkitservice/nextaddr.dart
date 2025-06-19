import 'dart:io';

import 'package:bitnet/backbone/auth/auth.dart';
import 'package:bitnet/backbone/cloudfunctions/aws/litd_controller.dart';
import 'package:bitnet/backbone/helper/databaserefs.dart';
import 'package:bitnet/backbone/helper/http_no_ssl.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/services/base_controller/dio/dio_service.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:bitnet/backbone/services/node_mapping_service.dart';
import 'package:bitnet/models/firebase/restresponse.dart';
import 'package:bitnet/pages/wallet/controllers/wallet_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// Future<RestResponse> a(String account) async {
//   //this obviously doesnt work because it's not for one user would be for all

//   LoggerService logger = Get.find();
//   final litdController = Get.find<LitdController>();
//   final String restHost = litdController.litd_baseurl.value;
//   // const String macaroonPath = 'assets/keys/lnd_admin.macaroon';
//   String url = 'https://$restHost/v2/wallet/address/next';

//   ByteData byteData = await loadAdminMacaroonAsset();
//   List<int> bytes = byteData.buffer.asUint8List();
//   String macaroon = bytesToHex(bytes);

//   Map<String, String> headers = {
//     'Grpc-Metadata-macaroon': macaroon,
//   };
//   final Map<String, dynamic> data = {
//     'account': account, //If empty, the default wallet account is used.
//     'type': 'TAPROOT_PUBKEY', //4 stands for taproot pubkey
//     'change': true,
//   };

//   HttpOverrides.global = MyHttpOverrides();

//   try {
//     final DioClient dioClient = Get.find<DioClient>();

//     var response = await dioClient.post(url: url, headers: headers, data: data);
//     logger.i('Raw Response Next Addr: ${response.data}');

//     if (response.statusCode == 200) {
//       print(response.data);
//       return RestResponse(
//           statusCode: "${response.statusCode}",
//           message: "Successfully generated next addr",
//           data: response.data);
//     } else {
//       logger.e(
//           'Failed to get next addr: ${response.statusCode}, ${response.data}');
//       return RestResponse(
//           statusCode: "error",
//           message:
//               "Failed to get next addr: ${response.statusCode}, ${response.data}",
//           data: {});
//     }
//   } catch (e) {
//     logger.e('Error trying to get next addr: $e');
//     return RestResponse(
//         statusCode: "error",
//         message:
//             "Failed to load data: Could not get response from Lightning node!",
//         data: {});
//   }
// }

// DEPRECATED: Old Firebase function approach - DO NOT USE
// This function is deprecated as it relies on Firebase Cloud Functions
// and doesn't work with the new one-user-one-node architecture.
// Use nextAddrDirect() instead which fetches addresses directly from the user's LND node.
/*
dynamic nextAddr(String account, {bool change = false}) async {
  final logger = Get.put(LoggerService());
  try {
    // Attempt to retrieve App Check tokens for additional security.
    try {
      final appCheckToken =
          await FirebaseAppCheck.instance.getLimitedUseToken();
      final newAppCheckToken = await FirebaseAppCheck.instance.getToken(false);
      logger.i("App Check Token: $appCheckToken");
      logger.i("New App Check Token: $newAppCheckToken");
    } catch (e) {
      logger.e("Fehler beim Abrufen des App Check Tokens: $e");
    }

    // Initialize FirebaseFunctions and call the Cloud Function
    final functions = FirebaseFunctions.instance;
    final callable = functions.httpsCallable(
      'next_address_http',
      options: HttpsCallableOptions(
        timeout: const Duration(minutes: 10),
        limitedUseAppCheckToken: true,
      ),
    );

    // Send request
    final dynamic response = await callable.call(<String, dynamic>{
      'account': account,
      'address_type': 'WITNESS_PUBKEY_HASH',
      'change': change
    });

    logger.i("Response nextAddr Server: ${response.data}");
    Map<String, dynamic> responseData;

    if (response.data is Map) {
      responseData = Map<String, dynamic>.from(response.data as Map);
    } else {
      // If data is not a Map, wrap it in a map
      responseData = {'message': response.data};
    }

    try {
      final message = responseData['addr'] ?? {};

      return message;
    } catch (e) {
      logger.e("error generating address: $e");
      return null;
    }
  } catch (e) {
    final logger = Get.find<LoggerService>();
    logger.e("Failed to generate address: $e");
    return null;
  }
}
*/

// NEW: One user one node approach - Get next address directly from user's LND node
Future<String?> nextAddrDirect(String userId, {bool change = false, String addressType = 'WITNESS_PUBKEY_HASH'}) async {
  final logger = Get.find<LoggerService>();
  logger.i("nextAddrDirect: Getting next address for user $userId");
  
  try {
    // Get user's node mapping - userId is the recovery DID
    final nodeMapping = await NodeMappingService.getUserNodeMapping(userId);
    
    if (nodeMapping == null) {
      logger.e("No node mapping found for user: $userId");
      return null;
    }
    
    final nodeId = nodeMapping.nodeId;
    logger.i("Using node: $nodeId for address generation");
    
    // Get the admin macaroon from node mapping
    final macaroon = nodeMapping.adminMacaroon;
    if (macaroon.isEmpty) {
      logger.e("No macaroon found in node mapping for node: $nodeId");
      return null;
    }
    
    // Get Caddy URL for the user's node
    final litdController = Get.find<LitdController>();
    final baseUrl = litdController.litd_baseurl.value;
    final url = 'https://$baseUrl/$nodeId/v2/wallet/address/next';
    
    logger.i("Getting next address from: $url");
    
    // Prepare request data
    final Map<String, dynamic> data = {
      'account': '', // Empty string uses default wallet account
      'type': addressType, // WITNESS_PUBKEY_HASH for SegWit, TAPROOT_PUBKEY for Taproot
      'change': change,
    };
    
    // Set up headers
    final headers = {
      'Grpc-Metadata-macaroon': macaroon,
      'Content-Type': 'application/json',
    };
    
    // Set up HTTP override for SSL
    HttpOverrides.global = MyHttpOverrides();
    
    // Make the request
    final response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: jsonEncode(data),
    );
    
    logger.i("Response status: ${response.statusCode}");
    
    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      final address = decoded['addr'];
      
      logger.i("Generated new address: $address");
      
      // Store address in Firestore for tracking (optional)
      try {
        final userDoc = btcAddressesRef.doc(userId);
        await userDoc.set({
          change ? 'change_addresses' : 'non_change_addresses': FieldValue.arrayUnion([address]),
          'addresses': FieldValue.arrayUnion([address]),
          'last_updated': FieldValue.serverTimestamp(),
        }, SetOptions(merge: true));
        
        // Also update local wallet controller
        final walletController = Get.find<WalletsController>();
        walletController.btcAddresses.add(address);
      } catch (e) {
        logger.e("Failed to store address in Firestore: $e");
        // Continue anyway, address generation was successful
      }
      
      return address;
    } else {
      final error = jsonDecode(response.body);
      logger.e("Failed to generate address: ${error['message'] ?? error['error'] ?? 'Unknown error'}");
      return null;
    }
  } catch (e) {
    logger.e("Error generating address: $e");
    return null;
  }
}

// Export as nextAddr for backward compatibility
Future<String?> nextAddr(String userId, {bool change = false, String addressType = 'WITNESS_PUBKEY_HASH'}) =>
    nextAddrDirect(userId, change: change, addressType: addressType);
