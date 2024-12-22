import 'dart:convert';
import 'dart:io';

import 'package:bitnet/backbone/auth/auth.dart';
import 'package:bitnet/backbone/auth/storePrivateData.dart';
import 'package:bitnet/backbone/cloudfunctions/aws/litd_controller.dart';
import 'package:bitnet/backbone/helper/http_no_ssl.dart';
import 'package:bitnet/backbone/helper/key_services/hdwalletfrommnemonic.dart';
import 'package:bitnet/backbone/helper/loadmacaroon.dart';
import 'package:bitnet/backbone/helper/theme/remoteconfig_controller.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/services/base_controller/dio/dio_service.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:bitnet/models/firebase/restresponse.dart';
import 'package:bitnet/models/keys/privatedata.dart';
import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:blockchain_utils/hex/hex.dart';
import 'package:blockchain_utils/signer/signer.dart';
import 'package:bs58/bs58.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pointycastle/export.dart';

Future<RestResponse> finalizePsbt(String funded_psbt, String acc) async {
  LoggerService logger = Get.find();
  final litdController = Get.find<LitdController>();
  final String restHost = litdController.litd_baseurl.value;
  // const String macaroonPath = 'assets/keys/lnd_admin.macaroon';
  String url = 'https://$restHost/v2/wallet/psbt/finalize';

  final RemoteConfigController remoteConfigController = Get.find<RemoteConfigController>();

  ByteData byteData = await remoteConfigController.loadAdminMacaroonAsset();
  List<int> bytes = byteData.buffer.asUint8List();
  String macaroon = bytesToHex(bytes);

  Map<String, String> headers = {
    'Grpc-Metadata-macaroon': macaroon,
  };
  final Map<String, dynamic> data = {
    'funded_psbt': funded_psbt,
    'account': acc, //default wallet account is used if empty
  };

  HttpOverrides.global = MyHttpOverrides();
  try {
    final DioClient dioClient = Get.find<DioClient>();

    var response = await dioClient.post(url: url, headers: headers, data: data);
    logger.i('Raw Response Finazlize PSBT: ${response.data}');

    if (response.statusCode == 200) {
      print(response.data);
      return RestResponse(
          statusCode: "${response.statusCode}",
          message: "Successfully finalized psbt",
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
    logger.e('Error trying to finalizing psbt: $e');
    return RestResponse(
        statusCode: "error",
        message:
            "Failed to load data: Could not get response from Lightning node!",
        data: {});
  }
}

// Future<String> signPsbt(String fundedPsbt) async {
//   PrivateData data = await getPrivateData(Auth().currentUser!.uid);
//   String mnemonic = data.mnemonic;
//   HDWallet wallet = HDWallet.fromMnemonic(mnemonic);
//   BitcoinSigner signer = BitcoinSigner.fromKeyBytes(hex.decode(wallet.privkey));
//   List<int> transaction_bytes =
//       signer.signTransaction(base64.decode(fundedPsbt));
//   String txHex = hex.encode(transaction_bytes);
//   return txHex;
// }
