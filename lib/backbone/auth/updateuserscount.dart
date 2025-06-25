import 'package:bitnet/backbone/helper/databaserefs.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Funktion, um einen Benutzer hinzuzufügen
Future<void> addUserCount() async {
  final doc = usersCountRef.doc('usersCount');
  FirebaseFirestore.instance.runTransaction((transaction) async {
    DocumentSnapshot snapshot = await transaction.get(doc);

    if (!snapshot.exists) {
      throw Exception("User count document does not exist!");
    }

    int currentCount = snapshot.get('count');
    transaction.update(doc, {'count': currentCount + 1});
  });
}

// Funktion, um einen Benutzer zu entfernen
Future<void> removeUserCount() async {
  final doc = usersCountRef.doc('usersCount');
  FirebaseFirestore.instance.runTransaction((transaction) async {
    DocumentSnapshot snapshot = await transaction.get(doc);

    if (!snapshot.exists) {
      throw Exception("User count document does not exist!");
    }

    int currentCount = snapshot.get('count');
    transaction.update(doc, {'count': currentCount - 1});
  });
}
