import 'dart:convert';
import 'dart:io';

import 'package:bitnet/backbone/helper/http_no_ssl.dart';
import 'package:bitnet/backbone/helper/loadmacaroon.dart';
import 'package:bitnet/backbone/helper/theme/remoteconfig_controller.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:bitnet/models/tapd/minassetresponse.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

Future<MintAssetResponse?> mintAsset(String assetName, String assetDataBase64, bool isGrouped) async {
  HttpOverrides.global = MyHttpOverrides();
  LoggerService logger = Get.find();

  final RemoteConfigController remoteConfigController = Get.find<RemoteConfigController>();

  String restHost = remoteConfigController.baseUrlLightningTerminal.value;

  dynamic byteData = await loadTapdMacaroonAsset();
  List<int> bytes = byteData.buffer.asUint8List();
  String macaroon = bytesToHex(bytes);

  // Prepare the headers
  Map<String, String> headers = {
    'Grpc-Metadata-macaroon': macaroon,
    'Content-Type': 'application/json',
  };

  logger.i("Minting asset: $assetName !");
  // Prepare the data to be sent in the request
  Map<String, dynamic> data = {
    'asset': {
      // Type of asset: can be 'COLLECTIBLE' for NFTs or other types
      'asset_type': 'COLLECTIBLE',
      // Indicates if a new group key will be issued for the asset
      'new_grouped_asset': isGrouped,
      // Name of the asset
      'name': assetName,
      // Amount of the asset
      'amount': 1,
      // Metadata associated with the asset
      'asset_meta': {
        // Base64 encoded JSON data of the asset
        'data': assetDataBase64,
        // Type of asset metadata, 1 for JSON format
        'type': 1,
      },
    },
    // Request a detailed response
    'short_response': false,
  };

  String url = 
  // kDebugMode
  //     ? ''
  //     :
        'https://$restHost/v1/taproot-assets/assets';

  try {
    var response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: json.encode(data),
    );

    logger.i("Raw Response: ${response.body}");

    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = json.decode(response.body);
      MintAssetResponse mintAssetResponse = MintAssetResponse.fromJson(responseData);
      return mintAssetResponse;
    } else if (response.statusCode == 500) {
      logger.e("Failed to mint asset (name probably is already in another item in the batch): ${response.statusCode}");
      return null;
    } else {
      logger.e('Failed to load Taproot asset data: ${response.statusCode}, ${response.body}');
    }
  } catch (e) {
    logger.e('Error requesting taproot assets: $e');
  }
  return null;
}
