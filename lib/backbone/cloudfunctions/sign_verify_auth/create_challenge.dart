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

enum ChallengeType {
  default_registration,
  mnemonic_login,
  qrcode_login,
  privkey_login,
  securestorage_login,
  litd_account_creation,
  send_btc_or_internal_account_rebalance,
}

Future<UserChallengeResponse?> create_challenge(
    String did, ChallengeType challengeType) async {
  final logger = Get.find<LoggerService>();
  logger.i("🚀 ✅ CREATE_CHALLENGE FUNCTION CALLED");

  HttpsCallable callable =
      FirebaseFunctions.instance.httpsCallable('create_user_challenge');

  logger.i("🚀 === CREATE_CHALLENGE FUNCTION START ===");
  logger.i("🚀 Input DID: '$did'");
  logger.i("🚀 Input Challenge Type: $challengeType");
  logger.i(
      "🚀 Challenge Type String: '${challengeType.toString().split('.').last}'");

  try {
    final Map<String, dynamic> requestData = {
      'did': did,
      'challengeType': challengeType.toString().split('.').last,
    };

    logger.i("🚀 📤 === CALLING FIREBASE CLOUD FUNCTION ===");
    logger.i("🚀 📤 Function name: 'create_user_challenge'");
    logger.i("🚀 📤 Request data: $requestData");
    logger.i("🚀 📤 About to call Firebase function...");

    final HttpsCallableResult<dynamic> response =
        await callable.call(requestData);

    logger.i("🚀 📥 === FIREBASE CLOUD FUNCTION RESPONSE ===");
    logger.i(
        "🚀 📥 Response received: ${response != null ? 'NOT NULL' : 'NULL'}");
    logger.i("🚀 📥 Response data type: ${response.data?.runtimeType}");
    logger.i("🚀 📥 Response data: ${response.data}");

    // Ensure response.data is not null and is a Map
    if (response.data != null && response.data is Map) {
      logger.i("🚀 📥 Response data is valid Map, converting...");

      final Map<String, dynamic> responseData =
          Map<String, dynamic>.from(response.data as Map);
      logger.i("🚀 📥 Converted response data: $responseData");

      logger.i("🚀 📥 About to call UserChallengeResponse.fromJson()...");
      final userChallengeResponse =
          UserChallengeResponse.fromJson(responseData);

      logger.i("🚀 📥 UserChallengeResponse created successfully");
      logger
          .i("🚀 📥 UserChallengeResponse: ${userChallengeResponse.toJson()}");

      return userChallengeResponse;
    } else {
      logger.e("🚀 ❌ Response data is null or not a Map");
      logger.e("🚀 ❌ Response data type: ${response.data?.runtimeType}");
      logger.e("🚀 ❌ Response data value: ${response.data}");
      return null;
    }
  } catch (e, stackTrace) {
    logger.e("🚀 ❌ Error during create challenge: $e");
    logger.e("🚀 ❌ Error type: ${e.runtimeType}");
    logger.e("🚀 ❌ Stack trace: $stackTrace");
    if (e is StateError) {
      logger.e(
          "🚀 ❌ 🚨 THIS IS A STATE ERROR in create_challenge - likely the 'Bad state: No element'!");
    }
    return null;
  }
}
