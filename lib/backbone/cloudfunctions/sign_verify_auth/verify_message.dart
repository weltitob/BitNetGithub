import 'dart:convert';

import 'package:bitnet/backbone/auth/auth.dart';
import 'package:bitnet/backbone/helper/deepmapcast.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:bitnet/models/firebase/restresponse.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

//verifymessage

verify_message() async {
  final logger = Get.find<LoggerService>();
  HttpsCallable callable =
  FirebaseFunctions.instance.httpsCallable('verify_signature');
  logger.i("FAKE LOGIN WHILE ION IS BROKEN..");

  try {
    final HttpsCallableResult<dynamic> response =
    await callable.call(<String, dynamic>{
      'did': "example_did_327892",
    });

    logger.i("Response VERIFY MESSAGE: ${response.data}");

    // Assuming response.data is a Map, cast it appropriately
    final Map<String, dynamic> responseData =
    deepMapCast(response.data as Map<Object?, Object?>);
    final RestResponse callback = RestResponse.fromJson(responseData);

    logger.i("CloudfunctionCallback: ${callback.toString()}");
    logger.i("Message: ${callback.message}");

    // Parse the message string to a Map
    final Map<String, dynamic> messageData =
    jsonDecode(callback.message) as Map<String, dynamic>;

    // Extract the 'data' field
    if (messageData.containsKey('data')) {
      final Map<String, dynamic> data =
      messageData['data'] as Map<String, dynamic>;

      // Safely extract the customToken from the data
      if (data.containsKey('customToken')) {
        String customToken = data['customToken'] as String;
        logger.i("Custom Token: $customToken");
        return customToken;
      } else {
        logger.i("Custom Token not found in message data.");
        return null;
      }
    } else {
      logger.e("Data field not found in message.");
      return null;
    }
  } catch (e) {
    logger.e("Error during fake login: $e");
    return null;
  }
}
