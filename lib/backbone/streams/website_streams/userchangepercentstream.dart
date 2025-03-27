// global_percentage_change.dart
import 'dart:async';
import 'dart:math';
import 'package:bitnet/backbone/helper/databaserefs.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:bitnet/backbone/streams/website_streams/usercountstream.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
  // Adjust the import to your project structure

Future<int> _userCountFrom7DaysAgo() async {
  LoggerService logger = Get.find();
  
  // For web preview, return mock data
  if (kIsWeb) {
    logger.i("Web mode: returning mock data for _userCountFrom7DaysAgo");
    return 10000; // Mock value for web preview
  }
  
  logger.i("usercount 7 days ago called");
  try {
    DateTime sevenDaysAgo = DateTime.now().subtract(const Duration(days: 7));
    var snapshot = await usersCollection.where('createdAt', isLessThanOrEqualTo: sevenDaysAgo).get();
    logger.e("Error: usercount 7 days ago cant work now because of deleted users // createdAt is not there yet");
    return snapshot.size;
  } catch (e) {
    logger.e("Error in _userCountFrom7DaysAgo: $e");
    return 0;
  }
}

Future<int> _getCurrentUserCount() async {
  // For web preview, return mock data
  if (kIsWeb) {
    return 12345; // Mock value for web preview
  }
  
  try {
    var snapshot = await usersCollection.get();
    return snapshot.size;
  } catch (e) {
    LoggerService logger = Get.find();
    logger.e("Error in _getCurrentUserCount: $e");
    return 0;
  }
}

Stream<double> percentageChangeInUserCountStream() {
  LoggerService logger = Get.find();
  
  // For web preview, return a mock percentage
  if (kIsWeb) {
    logger.i("Web mode: returning mock data for percentageChangeInUserCountStream");
    return Stream.value(15.7); // A fixed growth percentage for web preview
  }
  
  // Use a StreamController for better error handling
  StreamController<double> controller = StreamController<double>();
  
  // Start the stream processing
  void startStream() async {
    try {
      await for (int currentUserCount in userCountStream()) {
        try {
          int initialUserCount = await _userCountFrom7DaysAgo();
          // Calculate percentage change when user count updates
          if (initialUserCount == 0) {
            controller.add((currentUserCount > 0) ? 100.0 : 0.0);
          } else {
            double percentageChange = ((currentUserCount - initialUserCount) / initialUserCount) * 100;
            controller.add(percentageChange);
          }
        } catch (e) {
          logger.e("Error processing user count: $e");
          // Don't add to stream on error, or add a default value
          controller.add(0.0);
        }
      }
    } catch (e) {
      logger.e("Critical error in percentageChangeInUserCountStream: $e");
      controller.add(0.0);
    }
  }
  
  // Start the stream and handle cleanup
  startStream();
  return controller.stream;
}