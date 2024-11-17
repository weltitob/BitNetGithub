import 'dart:convert';

import 'package:bitnet/backbone/auth/auth.dart';
import 'package:bitnet/backbone/helper/deepmapcast.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:bitnet/models/keys/userchallenge.dart';
import 'package:bitnet/models/firebase/restresponse.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


//signmessage


Future<UserChallengeResponse?> create_challenge(String did) async {
  HttpsCallable callable = FirebaseFunctions.instance.httpsCallable('create_user_challenge');
  final logger = Get.find<LoggerService>();
  logger.i("CREATE CHALLENGE CALLED...");

  try {
    final HttpsCallableResult<dynamic> response =
    await callable.call(<String, dynamic>{
      'did': did,
    });

    logger.i("Response: ${response.data}");

    // Ensure response.data is not null and is a Map
    if (response.data != null && response.data is Map) {
      final Map<String, dynamic> responseData =
      Map<String, dynamic>.from(response.data as Map);

      final userChallengeResponse = UserChallengeResponse.fromJson(responseData);

      logger.i("UserChallengeResponse: ${userChallengeResponse.toJson()}");

      return userChallengeResponse;
    } else {
      logger.i("Response data is null or not a Map.");
      return null;
    }
  } catch (e, stackTrace) {
    logger.e("Error during create challenge: $e",);
    return null;
  }
}
