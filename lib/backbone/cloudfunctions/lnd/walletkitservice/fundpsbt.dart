import 'dart:io';

import 'package:bitnet/backbone/helper/http_no_ssl.dart';
import 'package:bitnet/backbone/helper/loadmacaroon.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/services/base_controller/dio/dio_service.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:bitnet/models/bitcoin/walletkit/transactiondata.dart';
import 'package:bitnet/models/firebase/restresponse.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';


Future<RestResponse> fundPsbt(TransactionData model) async {
  LoggerService logger = Get.find();
  String restHost = AppTheme.baseUrlLightningTerminal;

  // const String macaroonPath = 'assets/keys/lnd_admin.macaroon';
  String url = 'https://$restHost/v2/wallet/psbt/fund';

  ByteData byteData = await loadMacaroonAsset();
  List<int> bytes = byteData.buffer.asUint8List();
  String macaroon = bytesToHex(bytes);

  Map<String, String> headers = {
    'Grpc-Metadata-macaroon': macaroon,
  };

  final Map<String, dynamic> data = {
    
    //'psbt': base64.b64encode(<bytes>), This stands for Partially Signed Bitcoin Transaction. It's a base64-encoded string representing a transaction that has not been fully signed yet. To generate a PSBT, you would typically use a Bitcoin wallet or library that supports PSBT creation. The library or tool you choose would allow you to specify transaction details such as inputs, outputs, amounts, and more. After creating a PSBT, you would encode it in base64 format to use in this field.
    'raw': model.raw.toJson(),
    'target_conf': model
        .targetConf, //The number of blocks to aim for when confirming the transaction. If the transaction cannot be confirmed in the specified number of blocks, it will be rejected. If this field is not set, the wallet will use the default number of blocks specified in the server configuration.
    //'sat_per_vbyte': sat_per_kw,//sat_per_vbyte, #feerate in sat/vbyte >> will get this from feerate servcie
    'account':
        "", //#The name of the account to fund the PSBT with. If empty, the default wallet account is used.
    'min_confs': model
        .minConfs, //#going for safety and not speed because for speed oyu would use the lightning network
    'spend_unconfirmed': model
        .spendUnconfirmed, //False, #Whether unconfirmed outputs should be used as inputs for the transaction.
    'change_type': model.changeType, //#CHANGE_ADDRESS_TYPE_UNSPECIFIED
  };

  HttpOverrides.global = MyHttpOverrides();

  try {
      final DioClient dioClient = Get.find<DioClient>();

    var response = await dioClient.post(url:url,
        headers: headers, data: data);
    logger.i('Raw Response Publish Transaction: ${response.data}');

    if (response.statusCode == 200) {
      print(response.data);
      return RestResponse(
          statusCode: "${response.statusCode}",
          message: "Successfully added invoice",
          data: response.data);
    } else {
      logger.e('Failed to load data: ${response.statusCode}, ${response.data}');
      return RestResponse(
          statusCode: "error",
          message:
              "Failed to load data: ${response.statusCode}, ${response.data}",
          data: {});
    }
  } catch (e) {
    logger.e('Error trying to publish transaction: $e');
    return RestResponse(
        statusCode: "error",
        message:
            "Failed to load data: Could not get response from Lightning node!",
        data: {});
  }
}
