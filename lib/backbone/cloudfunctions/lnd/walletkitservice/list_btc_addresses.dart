import 'dart:collection';
import 'dart:io';

import 'package:bitnet/backbone/auth/auth.dart';
import 'package:bitnet/backbone/cloudfunctions/aws/litd_controller.dart';
import 'package:bitnet/backbone/helper/databaserefs.dart';
import 'package:bitnet/backbone/helper/http_no_ssl.dart';
import 'package:bitnet/backbone/helper/loadmacaroon.dart';
import 'package:bitnet/backbone/services/base_controller/dio/dio_service.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:bitnet/models/firebase/restresponse.dart';
import 'package:bitnet/pages/wallet/controllers/wallet_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

Future<LinkedHashMap<String, int>> listBtcAddresses() async {
  DocumentSnapshot<Map<String, dynamic>> doc =
      await btcAddressesRef.doc(Auth().currentUser!.uid).get();
  if (doc.data() != null && doc.data()!.isNotEmpty) {
    Map<String, dynamic> data = doc.data()!;
    List<dynamic> addresses = data['addresses'];
    LinkedHashMap<String, int> finalMap = LinkedHashMap();
    for (int i = 0; i < addresses.length; i++) {
      int balance = (await Get.find<WalletsController>()
              .getOnchainAddressBalance(addresses[i] as String))
          .toInt();
      finalMap[addresses[i] as String] = balance;
    }
    var sortedEntries = finalMap.entries.toList()
      ..sort((a, b) => a.value.compareTo(b.value));

    finalMap = LinkedHashMap.fromEntries(sortedEntries);
    return finalMap;
  } else {
    return LinkedHashMap();
  }
}
//this function has been made redundant, going forward with the new onchain system.
// Future<RestResponse> listBtcAddresses() async {
//   LoggerService logger = Get.find();
//   final litdController = Get.find<LitdController>();
//   final String restHost = litdController.litd_baseurl.value;

//   // const String macaroonPath = 'assets/keys/lnd_admin.macaroon';
//   String url = 'https://$restHost/v2/wallet/addresses';

//   ByteData byteData = await loadAdminMacaroonAsset();
//   List<int> bytes = byteData.buffer.asUint8List();
//   String macaroon = bytesToHex(bytes);

//   Map<String, String> headers = {
//     'Grpc-Metadata-macaroon': macaroon,
//   };
//   final Map<String, dynamic> data = {
//     'account_name': '' //maybe it will default like the other functions do?
//   };

//   HttpOverrides.global = MyHttpOverrides();

//   try {
//     final DioClient dioClient = Get.find<DioClient>();

//     var response = await dioClient.get(url: url, headers: headers, data: data);
//     logger.i('Raw Response list addresses: ${response.data}');

//     if (response.statusCode == 200) {
//       print(response.data);
//       return RestResponse(statusCode: "${response.statusCode}", message: "Successfully listed Adresses", data: response.data);
//     } else {
//       logger.e('Failed to load data: ${response.statusCode}, ${response.data}');
//       return RestResponse(statusCode: "error", message: "Failed to load data: ${response.statusCode}, ${response.data}", data: {});
//     }
//   } catch (e) {
//     logger.e('Error trying to list addresses: $e');
//     return RestResponse(statusCode: "error", message: "Failed to load data: Could not get response from Lightning node!", data: {});
//   }
// }
