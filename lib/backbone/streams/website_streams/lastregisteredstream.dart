import 'dart:async';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:bitnet/models/user/userdata.dart';
import 'package:bitnet/backbone/helper/databaserefs.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
 // Adjust the import to your project structure

Stream<List<UserData>> lastUsersStream() {
  LoggerService logger = Get.find();
  logger.i("lastUsersStream called");

  // For web preview, return mock data
  if (kIsWeb) {
    logger.i("Web mode: returning mock data for lastUsersStream");
    return Stream.value([
      UserData(
        backgroundImageUrl: "",
        isPrivate: false,
        showFollowers: false,
        did: "user1",
        displayName: "Web Preview User 1",
        bio: "Mock user for web preview",
        customToken: "",
        username: "webpreview1",
        profileImageUrl: "pfptest.jpg",
        createdAt: Timestamp.now(),
        updatedAt: Timestamp.now(),
        isActive: true,
        setupQrCodeRecovery: false,
        setupWordRecovery: false,
        dob: 0,
      ),
      UserData(
        backgroundImageUrl: "",
        isPrivate: false,
        showFollowers: false,
        did: "user2",
        displayName: "Web Preview User 2",
        bio: "Mock user for web preview",
        customToken: "",
        username: "webpreview2",
        profileImageUrl: "pfptest.jpg",
        createdAt: Timestamp.fromDate(DateTime.now().subtract(const Duration(days: 5))),
        updatedAt: Timestamp.fromDate(DateTime.now().subtract(const Duration(days: 5))),
        isActive: true,
        setupQrCodeRecovery: false,
        setupWordRecovery: false,
        dob: 0,
      ),
    ]);
  }

  // For non-web, use real Firebase data
  try {
    return usersCollection
        .orderBy('createdAt', descending: true)
        .limitToLast(100)
        .snapshots()
        .handleError((error) {
      // Handle any errors that occur in the stream
      logger.e("Error in lastUsersStream: $error");
      return [];
    })
        .map((snapshot) {
      // Check if snapshot is valid
      if (snapshot.docs.isEmpty) {
        logger.i("No users found in lastUsersStream");
        return [];
      } else {
        return snapshot.docs.map((doc) => UserData.fromDocument(doc)).toList();
      }
    });
  } catch (e) {
    logger.e("Critical error in lastUsersStream: $e");
    // Return empty list for any critical errors
    return Stream.value([]);
  }
}
