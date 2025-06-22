import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:bitnet/backbone/auth/auth.dart';
import 'package:bitnet/backbone/helper/http_no_ssl.dart';
import 'package:bitnet/backbone/helper/lightning_config.dart';
import 'package:bitnet/backbone/helper/theme/remoteconfig_controller.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/services/base_controller/dio/dio_service.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:bitnet/backbone/services/node_mapping_service.dart';
import 'package:bitnet/models/firebase/restresponse.dart';
import 'package:blockchain_utils/base58/base58_base.dart';
import 'package:get/get.dart';

Future<RestResponse> loopOut(String userId, Map<String, dynamic> data) async {
  final RemoteConfigController remoteConfigController = Get.find<RemoteConfigController>();
  final logger = Get.find<LoggerService>();

  // Get user's node mapping
  final nodeMapping = await NodeMappingService.getUserNodeMapping(userId);
  if (nodeMapping == null) {
    logger.e("No node mapping found for user: $userId");
    return RestResponse(
      statusCode: "error",
      message: "No Lightning node assigned to user",
      data: {}
    );
  }

  final nodeId = nodeMapping.nodeId;
  logger.i("Using node: $nodeId for user: $userId");

  // Get the admin macaroon from node mapping (stored as base64)
  final macaroonBase64 = nodeMapping.adminMacaroon;
  if (macaroonBase64.isEmpty) {
    logger.e("No macaroon found in node mapping for node: $nodeId");
    return RestResponse(
      statusCode: "error",
      message: "Failed to load node credentials",
      data: {}
    );
  }
  
  // Convert base64 macaroon to hex format
  final macaroonBytes = base64Decode(macaroonBase64);
  final macaroon = bytesToHex(macaroonBytes);
  
  // Build URL using Caddy endpoint
  String url = '${LightningConfig.caddyBaseUrl}/$nodeId/v1/loop/out';
  logger.i("Loop Out URL: $url");

  Map<String, String> headers = {
    'Grpc-Metadata-macaroon': macaroon,
  };

  HttpOverrides.global = MyHttpOverrides();

  // Extract the input string
  String inputString = data['dest'];

  //String inputString = "bc1pxm3sjkyshzyvwvl0pwrckpd3znfp2mgfjczhhmx4k5ravsgv8ynqwjsnhl";

  //Check and remove any prefix before '/'
  // if (inputString.contains('/')) {
  //   inputString = inputString.split('/')[1];
  // }

  // Convert input string to Uint8List using base64.decode
  Uint8List inputBytes = base64.decode(inputString);



  // Encode the Uint8List to a Base58 string using the provided encoder with checksum
  String base58EncodedString = Base58Encoder.encode(inputBytes);
  String checkedBase58EncodedString = Base58Encoder.checkEncode(inputBytes);

  print("Base58 Encoded String: $checkedBase58EncodedString");

  logger.i("Amount: ${data['amt']}");
  logger.i("Swap Fee: ${data['swapFee']}");
  logger.i("Miner Fee: ${data['minerFee']}");
  logger.i("Max Prepay: ${data['maxPrepay']}");
  logger.i("Not used: Destination: $inputString");

  //onchain addr bc1pxm3sjkyshzyvwvl0pwrckpd3znfp2mgfjczhhmx4k5ravsgv8ynqwjsnhl
  // Prepare the data with the Base58 encoded string
  //try to use a bitcoin address for loopout
  data = {
    //use a account as loopout

    //"account": base58EncodedString,
    'account': "default",
    "account_addr_type": "TAPROOT_PUBKEY",
    'amt': "260000", //data['amt'],
    'max_swap_fee': "1000", //data['swapFee'],
    'max_swap_routing_fee': "10000", //data['minerFee'], //THIS IS NEW
    'max_miner_fee': data['minerFee'],
    //'dest': checkedBase58EncodedString, //base58Encode(),
    'max_prepay_amt': data['maxPrepay'],
  };

  try {
      final DioClient dioClient = Get.find<DioClient>();

    var response =
        await dioClient.post(url:url, headers: headers, data: data);
    print('Raw Response: ${response.data}');

    if (response.statusCode == 200) {
      print(response.data);
      return RestResponse(
          statusCode: "${response.statusCode}",
          message: "Successfully retrieved Loop out",
          data: response.data);
    } else {
      print('Failed to load data: ${response.statusCode}, ${response.data}');
      Map<String, dynamic> decodedBody = response.data;
      return RestResponse(
          statusCode: "error", message: decodedBody['message'], data: {});
    }
  } catch (e) {
    print('Error: $e');
    return RestResponse(
        statusCode: "error",
        message: "Failed to load data: Could not get response from server!",
        data: {});
  }
}



//  {
//     "swap_fee_sat": <int64>,
//     "prepay_amt_sat": <int64>,
//     "htlc_sweep_fee_sat": <int64>,
//     "swap_payment_dest": <bytes>,
//     "cltv_delta": <int32>,
//     "conf_target": <int32>,
// }

