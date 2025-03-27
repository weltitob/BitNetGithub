// global_user_count.dart
import 'dart:async';
import 'dart:math';
import 'package:bitnet/backbone/helper/databaserefs.dart'; // Adjust the import to your project structure
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

Stream<int> userCountStream() {
  LoggerService logger = Get.find();
  logger.i("usercountstream called");
  
  // For web preview, return mock data
  if (kIsWeb) {
    logger.i("Web mode: returning mock data for userCountStream");
    // Return a fixed value for web preview
    return Stream.value(12345);
  }
  
  // For non-web, use real Firebase data
  try {
    return usersCountRef.doc("usersCount").snapshots().map((DocumentSnapshot<Map<String, dynamic>> snapshot) {
      if (snapshot.exists && snapshot.data() != null) {
        logger.i("Success: usercountstream called and snapshot exists: ${snapshot.data()!['count']}");
        return snapshot.data()!['count'] as int;
      }
      logger.e("Error: usercountstream called but snapshot is null");
      return 0;
    });
  } catch (e) {
    logger.e("Critical error in userCountStream: $e");
    // Return a default value for any critical errors
    return Stream.value(0);
  }
}
