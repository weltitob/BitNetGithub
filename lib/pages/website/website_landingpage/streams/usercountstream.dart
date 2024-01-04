// global_user_count.dart
import 'dart:async';
import 'package:bitnet/backbone/helper/databaserefs.dart'; // Adjust the import to your project structure
import 'package:cloud_firestore/cloud_firestore.dart';

int latestUserCount = 0;
StreamSubscription<int>? userCountSubscription;

void startListeningToUserCountStream() {
  userCountSubscription = userCountStream().listen((count) {
    latestUserCount = count;
    // Optionally notify listeners or perform other actions if necessary
  });
}

void stopListeningToUserCountStream() {
  userCountSubscription?.cancel();
}

Stream<int> userCountStream() {
  return usersCountRef.doc("usersCount").snapshots().map((DocumentSnapshot<Map<String, dynamic>> snapshot) {
    if (snapshot.exists && snapshot.data() != null) {
      return snapshot.data()!['count'] as int;
    }
    return 0;
  });
}
