import 'dart:io';
import 'dart:typed_data';

import 'package:bitnet/backbone/cloudfunctions/aws/litd_controller.dart';
import 'package:bitnet/backbone/helper/http_no_ssl.dart';
import 'package:bitnet/backbone/helper/loadmacaroon.dart';
import 'package:bitnet/backbone/services/base_controller/dio/dio_service.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:bitnet/models/firebase/restresponse.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:get/get.dart';
import 'package:bitnet/backbone/helper/http_no_ssl.dart';

dynamic importAccount(String name, String exPubKey, String fingerprint) async {
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
      'import_account_http',
      options: HttpsCallableOptions(
        timeout: const Duration(minutes: 10),
        limitedUseAppCheckToken: true,
      ),
    );

    // Send request
    final dynamic response = await callable.call(<String, dynamic>{
      'name': name,
      'extended_public_key': exPubKey,
      'master_key_fingerprint': fingerprint,
      'address_type': 'WITNESS_PUBKEY_HASH'
    });

    logger.i("Antwort vom Server: ${response.data}");
    Map<String, dynamic> responseData;

    if (response.data is Map) {
      responseData = Map<String, dynamic>.from(response.data as Map);
    } else {
      // If data is not a Map, wrap it in a map
      responseData = {'message': response.data};
    }

    try {
      final message = responseData['account'] ?? {};
      final data = message['name'] ?? {};

      return data;
    } catch (e) {
      logger.e("error importing account: $e");
      return null;
    }
  } catch (e) {
    final logger = Get.find<LoggerService>();
    logger.e("Failed to import pubkey: $e");
    return null;
  }
}

// Future<RestResponse> importAccRest(
//     String name, String expubkey, String fingerprint) async {
//   LoggerService logger = Get.find<LoggerService>();
//   final litdController = Get.find<LitdController>();
//   final String restHost = litdController.litd_baseurl.value;

//   // const String macaroonPath = 'assets/keys/lnd_admin.macaroon';
//   String url = 'https://$restHost/v2/wallet/accounts/import';

//   ByteData byteData = await loadAdminMacaroonAsset();
//   List<int> bytes = byteData.buffer.asUint8List();
//   String macaroon = bytesToHex(bytes);

//   Map<String, String> headers = {
//     'Grpc-Metadata-macaroon': macaroon,
//   };

//   final Map<String, dynamic> data = {
//     'name': name,
//     'extended_public_key': expubkey,
//     'master_key_fingerprint': fingerprint,
//     'address_type': 'TAPROOT_PUBKEY'
//   };

//   HttpOverrides.global = MyHttpOverrides();

//   try {
//     final DioClient dioClient = Get.find<DioClient>();

//     var response = await dioClient.post(url: url, headers: headers, data: data);
//     logger.i('Raw Response Publish Transaction: ${response.data}');

//     if (response.statusCode == 200) {
//       print(response.data);
//       return RestResponse(
//           statusCode: "${response.statusCode}",
//           message: "Successfully added invoice",
//           data: response.data);
//     } else {
//       logger.e('Failed to load data: ${response.statusCode}, ${response.data}');
//       return RestResponse(
//           statusCode: "error",
//           message:
//               "Failed to load data: ${response.statusCode}, ${response.data}",
//           data: {});
//     }
//   } catch (e) {
//     logger.e('Error trying to publish transaction: $e');
//     return RestResponse(
//         statusCode: "error",
//         message:
//             "Failed to load data: Could not get response from Lightning node!",
//         data: {});
//   }
// }
