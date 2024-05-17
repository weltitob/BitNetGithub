import 'dart:async';
import 'package:bitnet/models/user/userdata.dart';
import 'package:bitnet/backbone/helper/databaserefs.dart';
 // Adjust the import to your project structure

Stream<List<UserData>> lastUsersStream() {
  Logs().i("lastUsersStream called");

  return usersCollection
      .orderBy('createdAt', descending: true)
      .limitToLast(100)
      .snapshots()
      .handleError((error) {
    // Handle any errors that occur in the stream
    Logs().e("Error in lastUsersStream: $error");
  })
      .map((snapshot) {
    // Check if snapshot is valid
    if (snapshot.docs.isEmpty) {
      Logs().i("No users found in lastUsersStream");
      return [];
    } else {
      return snapshot.docs.map((doc) => UserData.fromDocument(doc)).toList();
    }
  });
}
