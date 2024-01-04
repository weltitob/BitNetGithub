// global_user_data.dart
import 'dart:async';
import 'package:bitnet/models/user/userdata.dart';
import 'package:bitnet/backbone/helper/databaserefs.dart';
import 'package:matrix/matrix.dart'; // Adjust the import to your project structure

List<UserData> latestUserData = [];
StreamSubscription<List<UserData>>? userDataSubscription;

void startListeningToLastUsersStream() {
  userDataSubscription = lastUsersStream().listen((data) {
    latestUserData = data;
    // Optionally notify listeners or perform other actions if necessary
  });
}

void stopListeningToLastUsersStream() {
  userDataSubscription?.cancel();
}

Stream<List<UserData>> lastUsersStream() {
  Logs().w("lastUsersStream called");
  return usersCollection
      .orderBy('createdAt', descending: true)
      .limitToLast(100)
      .snapshots()
      .map((snapshot) => snapshot.docs.map((doc) => UserData.fromDocument(doc)).toList());
}
