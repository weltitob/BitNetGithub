import 'dart:io';

import 'package:bitnet/backbone/helper/http_no_ssl.dart';
import 'package:bitnet/backbone/helper/loadmacaroon.dart';
import 'package:bitnet/backbone/helper/theme/remoteconfig_controller.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/models/firebase/restresponse.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:bitnet/backbone/helper/isCompleteJSON.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

Stream<RestResponse> mintAssetStream(bool shortResponse) async* {
  final RemoteConfigController remoteConfigController = Get.find<RemoteConfigController>();
  String restHost = remoteConfigController.baseUrlLightningTerminal.value;

  ByteData byteData = await loadTapdMacaroonAsset();
  List<int> bytes = byteData.buffer.asUint8List();
  String macaroon = bytesToHex(bytes);

  Map<String, String> headers = {
    'Grpc-Metadata-macaroon': macaroon,
  };

  String url =
  //  kDebugMode
  //     ? ''
  //     : 
      'https://$restHost/v1/taproot-assets/events/asset-mint';

  Map<String, dynamic> data = {
    'short_response': shortResponse,
  };

  HttpOverrides.global = MyHttpOverrides();

  try {
    var request = http.Request('POST', Uri.parse(url))
      ..headers.addAll(headers)
      ..body = json.encode(data);

    var streamedResponse = await request.send();
    var accumulatedData = StringBuffer();

    await for (var chunk in streamedResponse.stream.transform(utf8.decoder)) {
      accumulatedData.write(chunk);

      if (isCompleteJson(accumulatedData.toString())) {
        try {
          var jsonResponse = json.decode(accumulatedData.toString());
          accumulatedData.clear();

          yield RestResponse(statusCode: "success", message: "Asset minted", data: jsonResponse);
        } catch (e) {
          yield RestResponse(statusCode: "error", message: "Error during JSON processing: $e", data: {});
        }
      }
    }
  } catch (e) {
    yield RestResponse(statusCode: "error", message: "Error during network call: $e", data: {});
  }
}