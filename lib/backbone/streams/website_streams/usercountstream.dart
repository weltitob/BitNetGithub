// global_user_count.dart
import 'dart:async';
import 'package:bitnet/backbone/helper/databaserefs.dart'; // Adjust the import to your project structure
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:matrix/matrix.dart';

Stream<int> userCountStream() {
  Logs().i("usercountstream called");
  return usersCountRef.doc("usersCount").snapshots().map((DocumentSnapshot<Map<String, dynamic>> snapshot) {
    if (snapshot.exists && snapshot.data() != null) {
      Logs().i("Success: usercountstream called and snapshot exists: ${snapshot.data()!['count']}");
      return snapshot.data()!['count'] as int;
    }
    Logs().e("Error: usercountstream called but snapshot is null");
    return 0;
  });
}
