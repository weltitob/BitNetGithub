import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

//User dataclass

@immutable
class UserData extends Equatable {
  //use decentralized user identity (dids instead of uids)
  final String did;
  final String displayName;
  final String bio;
  final String customToken;
  final String username;
  final String profileImageUrl;
  final String backgroundImageUrl;
  final bool isPrivate;
  final bool showFollowers;
  // final List<String> codes;
  //maybe ude Timestamp from cloud_firestore instead of Datetime if it causes issues
  final Timestamp createdAt;
  final Timestamp updatedAt;
  final bool isActive;
  final int dob;
  final String nft_profile_id;
  final String nft_background_id;

  const UserData({
    required this.backgroundImageUrl,
    required this.isPrivate,
    required this.showFollowers,
    required this.did,
    required this.displayName,
    required this.bio,
    required this.customToken,
    required this.username,
    required this.profileImageUrl,
    // required this.codes,
    required this.createdAt,
    required this.updatedAt,
    required this.isActive,
    required this.dob,
    this.nft_profile_id ='',
    this.nft_background_id='', 
  });

  @override
  List<Object> get props {
    return [
      isPrivate,
      showFollowers,
      backgroundImageUrl,
      did,
      displayName,
      bio,
      customToken,
      username,
      profileImageUrl,
      // codes,
      createdAt,
      updatedAt,
      isActive,
      dob,
      nft_profile_id,
      nft_background_id
    ];
  }

  UserData copyWith({
    String? did,
    String? customToken,
    String? username,
    String? bio,
    String? displayName,
    String? profileImageUrl,
    String? backgroundImageUrl,
    List<String>? codes,
    Timestamp? createdAt,
    Timestamp? updatedAt,
    bool? isActive,
    bool? isPrivate,
    bool? showFollowers,
    int? dob,
    String? nft_profile_id,
    String? nft_background_id
  }) {
    return UserData(
      did: did ?? this.did,
      customToken: customToken ?? this.customToken,
      username: username ?? this.username,
      displayName: username ?? this.displayName,
      bio: username ?? this.bio,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      backgroundImageUrl: backgroundImageUrl ?? this.backgroundImageUrl,
      isPrivate: isPrivate ?? this.isPrivate,
      showFollowers: showFollowers ?? this.showFollowers,
      // codes: codes ?? this.codes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isActive: isActive ?? this.isActive,
      dob: dob ?? this.dob, 
      nft_profile_id: nft_profile_id ?? this.nft_profile_id, 
      nft_background_id: nft_background_id ?? this.nft_background_id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'did': did,
      'customToken': customToken,
      'username': username,
      'displayName': displayName,
      'bio': bio,
      'profileImageUrl': profileImageUrl,
      'backgroundImageUrl': backgroundImageUrl,
      'isPrivate': isPrivate,
      'showFollowers': showFollowers,
      // 'codes': codes,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'isActive': isActive,
      'dob': dob,
      'nft_profile_id': nft_profile_id,
      'nft_background_id': nft_background_id
    };
  }

  factory UserData.fromMap(Map<String, dynamic> map) {
    return UserData(
      did: map['did'] ?? '',
      customToken: map['customToken'] ?? '',
      username: map['username'] ?? '',
      displayName: map['displayName'] ?? '',
      bio: map['bio'] ?? '',
      profileImageUrl: map['profileImageUrl'] ?? '',
      backgroundImageUrl: map['backgroundImageUrl'] ?? '',
      // codes: List<String>.from(map['codes']),
      createdAt: map['createdAt'] ?? 0,
      updatedAt: map['updatedAt'] ?? 0,
      isActive: map['isActive'] ?? false,
      showFollowers: map['showFollowers'] ?? false,
      isPrivate: map['isPrivate'] ?? false,
      dob: map['dob']?.toInt() ?? 0, 
      nft_profile_id: map['nft_profile_id'] ?? '', 
      nft_background_id: map['nft_background_id'] ?? '',
      // mainWallet: UserWallet.fromMap(map['mainWallet'] ?? {}),
      // wallets: List<UserWallet>.from(
      //     map['wallets']?.map((x) => UserWallet.fromMap(x))),
    );
  }

  factory UserData.fromDocument(DocumentSnapshot doc) {
    return UserData(
      did: doc['did'].toString(),
      username: doc['username'].toString(),
      displayName: doc['displayName'].toString(),
      bio: doc['bio'].toString(),
      customToken: doc['customToken'].toString(),
      profileImageUrl: doc['profileImageUrl'].toString(),
      backgroundImageUrl: doc['backgroundImageUrl'].toString(),
      // codes: List<String>.from(doc['codes']),
      createdAt: doc['createdAt'],
      updatedAt: doc['updatedAt'],
      isActive: doc['isActive'],
      showFollowers: doc['showFollowers'],
      isPrivate: doc['isPrivate'],
      dob: doc['dob'], 
      nft_profile_id: (doc.data() as Map<String,dynamic>).containsKey('nft_profile_id') ? doc['nft_profile_id'] : '',
       nft_background_id: (doc.data() as Map<String,dynamic>).containsKey('nft_background_id') ? doc['nft_background_id'] : '',
      // mainWallet: UserWallet.fromMap(doc['mainWallet'] ?? {}),
      // wallets: List<UserWallet>.from(
      //     doc['wallets'].map((x) => UserWallet.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserData.fromJson(String source) =>
      UserData.fromMap(json.decode(source));

  @override
  String toString() {
    return 'User(did: $did, displayName: $displayName, bio: $bio, backgroundImageUrl: $backgroundImageUrl, customToken: $customToken, username: $username, profileImageUrl: $profileImageUrl, createdAt: $createdAt, updatedAt: $updatedAt, isPrivate: $isPrivate, showFollowers: $showFollowers, isActive: $isActive, dob: $dob)';
  }
}
