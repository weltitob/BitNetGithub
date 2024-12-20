import 'dart:io';

import 'package:bitnet/backbone/helper/http_no_ssl.dart';
import 'package:bitnet/backbone/helper/loadmacaroon.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/services/base_controller/dio/dio_service.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:bitnet/models/firebase/restresponse.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

Future<RestResponse> loadBtcAddresses(String did) async {
  LoggerService logger = Get.find();
  String baseUrl = AppTheme.baseUrlLightningTerminal;

  // const String macaroonPath = 'assets/keys/lnd_admin.macaroon';
  String url = 'https://load-btc-addresses-466393582939.us-central1.run.app';

  ByteData byteData = await loadAdminMacaroonAsset();
  List<int> bytes = byteData.buffer.asUint8List();
  String macaroon = bytesToHex(bytes);

  Map<String, String> headers = {
    'Authorization':
        'Bearer eyJhbGciOiJSUzI1NiIsImtpZCI6ImQ3YjkzOTc3MWE3ODAwYzQxM2Y5MDA1MTAxMmQ5NzU5ODE5MTZkNzEiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJhY2NvdW50cy5nb29nbGUuY29tIiwiYXpwIjoiNjE4MTA0NzA4MDU0LTlyOXMxYzRhbGczNmVybGl1Y2hvOXQ1Mm4zMm42ZGdxLmFwcHMuZ29vZ2xldXNlcmNvbnRlbnQuY29tIiwiYXVkIjoiNjE4MTA0NzA4MDU0LTlyOXMxYzRhbGczNmVybGl1Y2hvOXQ1Mm4zMm42ZGdxLmFwcHMuZ29vZ2xldXNlcmNvbnRlbnQuY29tIiwic3ViIjoiMTA2Mjk1NjEzNzk0MTQ2MjMxMDUyIiwiZW1haWwiOiJhYmR1bGFoLnplaW5AZ21haWwuY29tIiwiZW1haWxfdmVyaWZpZWQiOnRydWUsImF0X2hhc2giOiJybUhVSWM0SVhXUGg3N0hxcTVvbF9nIiwibmJmIjoxNzI1ODA3MDY5LCJpYXQiOjE3MjU4MDczNjksImV4cCI6MTcyNTgxMDk2OSwianRpIjoiNzVhNTQzYzdhYjUyOTQ3YmU5ZjAwMTYxNzRjZTU3MmYzMTU3ZDYxNCJ9.dS0UCaqP7W8gJ9vm3lBH_qpfB0bL9W5sYrPS19-j4lJ67LtPppCqIbV_1rb5Cv5IgCi6lTcixQ6i10d_oJ9_mhsNf3uxtRtXHTaR4HSkzhdsPoKc76mfDm8dqNKFieioo274zCHdMs4RjmiRK2KS8ie01VWfVdLi4YpW0v23vEBM9LFIOq1u32osVobv9h1BnLuUyNmm0LeYlMhQW4i31_Enqc2P96DJs3I-y-DHP1ACBrH370--OPrqcQHq08nqwt2ZuDW73OmSCnYUhgG7t9NcBWRxOCrukNQWQwXcNeR-edaKstaAkjUAk_78gEo0gHSowoweG1t2cZotLoAcfA',
  };
  final Map<String, dynamic> data = {'macaroon': macaroon, 'user_document_id': did};

  HttpOverrides.global = MyHttpOverrides();

  try {
    final DioClient dioClient = Get.find<DioClient>();

    var response = await dioClient.post(url: url, headers: headers, data: data);
    logger.i('Raw Response load addresses: ${response.data}');

    if (response.statusCode == 200) {
      print(response.data);
      return RestResponse(statusCode: "${response.statusCode}", message: "Successfully loaded Adresses", data: response.data);
    } else {
      logger.e('Failed to load data: ${response.statusCode}, ${response.data}');
      return RestResponse(statusCode: "error", message: "Failed to load data: ${response.statusCode}, ${response.data}", data: {});
    }
  } catch (e) {
    logger.e('Error trying to list addresses: $e');
    return RestResponse(statusCode: "error", message: "Failed to load data", data: {});
  }
}
