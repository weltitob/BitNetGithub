import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

//only for codes push to database

class VerificationCode {
  final String? docId;
  final bool used;
  final String code;
  final String issuer;
  final String receiver;

  VerificationCode(
      {this.docId,
      required this.used,
      required this.code,
      required this.issuer,
      required this.receiver});

  factory VerificationCode.fromJson(Map<String, dynamic> json) {
    return VerificationCode(
      used: json["used"],
      code: json["code"],
      issuer: json["issuer"],
      receiver: json["receiver"],
    );
  }

  VerificationCode copyWith({
    String? docId,
    bool? used,
    String? code,
    String? issuer,
    String? receiver,
  }) {
    return VerificationCode(
      docId: docId ?? this.docId,
      used: used ?? this.used,
      code: code ?? this.code,
      issuer: issuer ?? this.issuer,
      receiver: receiver ?? this.receiver,
    );
  }

  factory VerificationCode.fromMap(Map<String, dynamic> map, String docId) {
    return VerificationCode(
      docId: docId,
      used: map['used'] ?? false,
      code: map['code'] ?? '',
      issuer: map['issuer'] ?? '',
      receiver: map['receiver'] ?? '',
    );
  }

  factory VerificationCode.fromDocument(DocumentSnapshot doc) {
    return VerificationCode(
      used: doc["used"],
      code: doc['code'],
      issuer: doc['issuer'],
      receiver: doc['receiver'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'used': used,
      'code': code,
      'issuer': issuer,
      'receiver': receiver,
    };
  }

  static Map<String, dynamic> toMap(VerificationCode data) => {
        'used': data.used,
        'code': data.code,
        'issuer': data.issuer,
        'receiver': data.receiver,
      };

  static String encode(List<VerificationCode> data) => json.encode(
        data
            .map<Map<String, dynamic>>((music) => VerificationCode.toMap(music))
            .toList(),
      );

  static List<VerificationCode> decode(String data) =>
      (json.decode(data) as List<dynamic>)
          .map<VerificationCode>((item) => VerificationCode.fromJson(item))
          .toList();
}
