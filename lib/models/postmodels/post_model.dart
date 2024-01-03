import 'dart:convert';

import 'package:bitnet/models/postmodels/media_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

//old model not used anymore new is Post
class PostModel {
  final String? docId;
  final String username;
  final String profileImageUrl;
  final String userId;
  final List<String> likedBy;
  final List<String> rocketBy;
  final List<Media> medias;
  final DateTime timestamp;
  PostModel({
    this.docId,
    required this.username,
    required this.profileImageUrl,
    required this.userId,
    required this.likedBy,
    required this.rocketBy,
    required this.medias,
    required this.timestamp,
  });

  PostModel copyWith({
    String? username,
    String? userId,
    String? profileImageUrl,
    List<String>? likedBy,
    List<String>? rocketBy,
    List<Media>? medias,
    DateTime? timestamp,
  }) {
    return PostModel(
      username: username ?? this.username,
      userId: userId ?? this.userId,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      likedBy: likedBy ?? this.likedBy,
      rocketBy: rocketBy ?? this.rocketBy,
      medias: medias ?? this.medias,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'userId': userId,
      'profileImageUrl': profileImageUrl,
      'likedBy': likedBy,
      'rocketBy': rocketBy,
      'medias': medias.map((x) => x.toMap()).toList(),
      'timestamp': FieldValue.serverTimestamp(),
    };
  }

  factory PostModel.fromMap(Map<String, dynamic> map, String docId) {
    return PostModel(
      docId: docId,
      username: map['username'] ?? '',
      userId: map['userId'] ?? '',
      profileImageUrl: map['profileImageUrl'] ?? '',
      likedBy: List<String>.from(map['likedBy']),
      rocketBy: List<String>.from(map['rocketBy']),
      medias: List<Media>.from(map['medias']?.map((x) => Media.fromMap(x))),
      timestamp: DateTime.fromMillisecondsSinceEpoch(
        (map['timestamp'] as Timestamp).millisecondsSinceEpoch,
      ),
    );
  }

  @override
  String toString() {
    return 'PostModel(username: $username, userId: $userId, profileImageUrl: $profileImageUrl, likedBy: $likedBy, rocketBy: $rocketBy, medias: $medias)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PostModel &&
        other.username == username &&
        other.userId == userId &&
        other.profileImageUrl == profileImageUrl &&
        listEquals(other.likedBy, likedBy) &&
        listEquals(other.rocketBy, rocketBy) &&
        listEquals(other.medias, medias);
  }

  @override
  int get hashCode {
    return username.hashCode ^
        userId.hashCode ^
        profileImageUrl.hashCode ^
        likedBy.hashCode ^
        rocketBy.hashCode ^
        medias.hashCode;
  }
}
