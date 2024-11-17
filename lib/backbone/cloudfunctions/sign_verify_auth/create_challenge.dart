import 'dart:convert';

import 'package:bitnet/backbone/auth/auth.dart';
import 'package:bitnet/backbone/helper/deepmapcast.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:bitnet/models/firebase/restresponse.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

//signmessage


Future<UserChallengeResponse?> create_challenge() async {
  HttpsCallable callable = FirebaseFunctions.instance.httpsCallable('create_user_challenge');
  final logger = Get.find<LoggerService>();
  logger.i("CREATE CHALLENGE CALLED...");

  try {
    final HttpsCallableResult<dynamic> response =
    await callable.call(<String, dynamic>{
      'did': "example_did_327892",
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

class UserChallengeResponse {
  final String userId;
  final Challenge challenge;

  UserChallengeResponse({
    required this.userId,
    required this.challenge,
  });

  factory UserChallengeResponse.fromJson(Map<String, dynamic> json) {
    return UserChallengeResponse(
      userId: json['user_id'],
      challenge: Challenge.fromJson(Map<String, dynamic>.from(json['challenge'])),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'challenge': challenge.toJson(),
    };
  }
}

class Challenge {
  final String challengeId;
  final String description;
  final String createdAt;
  final String title;
  final String deadline;
  final String status;

  Challenge({
    required this.challengeId,
    required this.description,
    required this.createdAt,
    required this.title,
    required this.deadline,
    required this.status,
  });

  factory Challenge.fromJson(Map<String, dynamic> json) {
    return Challenge(
      challengeId: json['challenge_id'],
      description: json['description'],
      createdAt: json['created_at'],
      title: json['title'],
      deadline: json['deadline'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'challenge_id': challengeId,
      'description': description,
      'created_at': createdAt,
      'title': title,
      'deadline': deadline,
      'status': status,
    };
  }
}
