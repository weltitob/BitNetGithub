import 'package:flutter/material.dart';


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
