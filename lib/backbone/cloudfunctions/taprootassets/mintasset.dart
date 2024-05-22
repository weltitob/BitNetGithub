import 'dart:convert';
import 'dart:io';

import 'package:bitnet/backbone/helper/http_no_ssl.dart';
import 'package:bitnet/backbone/helper/loadmacaroon.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:bitnet/models/tapd/minassetresponse.dart';
import 'package:blockchain_utils/hex/hex.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';


mintAsset(String assetDataBase64) async {
  HttpOverrides.global = MyHttpOverrides();
  LoggerService logger = Get.find();

  String restHost = AppTheme.baseUrlLightningTerminal;

  dynamic byteData = await loadTapdMacaroonAsset();
  List<int> bytes = byteData.buffer.asUint8List();
  String macaroon = bytesToHex(bytes);

  // Prepare the headers
  Map<String, String> headers = {
    'Grpc-Metadata-macaroon': macaroon,
  };

  // Prepare the data to be sent in the request
  Map<String, dynamic> data = {
    'asset': {
      // Type of asset: can be 'COLLECTIBLE' for NFTs or other types
      'asset_type': 'COLLECTIBLE',
      // Indicates if a new group key will be issued for the asset
      'new_grouped_asset': true,
      // Name of the asset
      'name': 'Fieber Traum (Skit)',
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

  String url = 'https://$restHost/v1/taproot-assets/assets';

  try {
    Dio dio = Dio();
    var response = await dio.post(
      url,
      data: json.encode(data),
      options: Options(
        headers: headers,
        contentType: Headers.jsonContentType,
      ),
    );

    logger.i("Raw Response: ${response.data}");

    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = response.data;
      MintAssetResponse mintAssetResponse = MintAssetResponse.fromJson(responseData);
      return mintAssetResponse;
    } else {
      logger.e('Failed to load Taproot asset data: ${response.statusCode}, ${response.data}');
    }
  } catch (e) {
    logger.e('Error requesting taproot assets: $e');
  }
}