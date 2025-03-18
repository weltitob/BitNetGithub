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

Future<String?> moonpaySignUrl(String url) async {
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
      'moonpay_sign_url_http',
      options: HttpsCallableOptions(
        timeout: const Duration(minutes: 10),
        limitedUseAppCheckToken: true,
      ),
    );

    // Send request
    final dynamic response = await callable.call(<String, dynamic>{"url": url});

    Map<String, dynamic> responseData;

    if (response.data is Map) {
      responseData = Map<String, dynamic>.from(response.data as Map);
    } else {
      // If data is not a Map, wrap it in a map
      responseData = {'message': response.data};
    }

    try {
      final signature = responseData['signature'] ?? "";

      return signature;
    } catch (e) {
      logger.e("error returning signature: $e");
      return null;
    }
  } catch (e) {
    final logger = Get.find<LoggerService>();
    logger.e("Failed to return signature: $e");
    return null;
  }
}
