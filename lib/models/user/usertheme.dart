import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

//only for codes push to database

class UserTheme {
  final bool isCustomMode;
  final bool isDarkmode;
  final String customHexCode;
  final String userId;

  UserTheme({
    required this.isCustomMode,
    required this.isDarkmode,
    required this.customHexCode,
    required this.userId,
  });

  factory UserTheme.fromJson(Map<String, dynamic> json) {
    return UserTheme(
      isCustomMode: json["isCustomMode"],
      isDarkmode: json["isDarkmode"],
      customHexCode: json["customHexCode"],
      userId: json["userId"],
    );
  }

  factory UserTheme.fromMap(Map<String, dynamic> map, String docId) {
    return UserTheme(
      isCustomMode: map['isCustomMode'] ?? false,
      isDarkmode: map['isDarkmode'] ?? false,
      customHexCode: map['customHexCode'] ?? '',
      userId: map['userId'] ?? '',
    );
  }

  factory UserTheme.fromDocument(DocumentSnapshot doc) {
    return UserTheme(
      isCustomMode: doc["isCustomMode"],
      isDarkmode: doc['isDarkmode'],
      customHexCode: doc['customHexCode'],
      userId: doc['userId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'isCustomMode': isCustomMode,
      'isDarkmode': isDarkmode,
      'customHexCode': customHexCode,
      'userId': userId,
    };
  }

  static Map<String, dynamic> toMap(UserTheme data) => {
        'used': data.isCustomMode,
        'code': data.isDarkmode,
        'customHexCode': data.customHexCode,
        'userId': data.userId,
      };

  static String encode(List<UserTheme> data) => json.encode(
        data
            .map<Map<String, dynamic>>((music) => UserTheme.toMap(music))
            .toList(),
      );

  static List<UserTheme> decode(String data) =>
      (json.decode(data) as List<dynamic>)
          .map<UserTheme>((item) => UserTheme.fromJson(item))
          .toList();
}
