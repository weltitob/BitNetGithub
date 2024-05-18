// global_user_count.dart
import 'dart:async';
import 'package:bitnet/backbone/helper/databaserefs.dart'; // Adjust the import to your project structure
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';


Stream<int> userCountStream() {
  LoggerService logger = Get.find();
  logger.i("usercountstream called");
  return usersCountRef.doc("usersCount").snapshots().map((DocumentSnapshot<Map<String, dynamic>> snapshot) {
    if (snapshot.exists && snapshot.data() != null) {
      logger.i("Success: usercountstream called and snapshot exists: ${snapshot.data()!['count']}");
      return snapshot.data()!['count'] as int;
    }
    logger.e("Error: usercountstream called but snapshot is null");
    return 0;
  });
}
