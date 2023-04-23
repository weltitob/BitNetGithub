import 'package:cloud_firestore/cloud_firestore.dart';

final usersCollection = FirebaseFirestore.instance.collection("users");
final transactionCollection = FirebaseFirestore.instance.collection("transactions");
final issueCollection = FirebaseFirestore.instance.collection("issues");
final codesCollection = FirebaseFirestore.instance.collection("codes");
final settingsCollection = FirebaseFirestore.instance.collection("settings");
final followersRef = FirebaseFirestore.instance.collection("followers");
final followingRef = FirebaseFirestore.instance.collection("following");
final activityFeedRef = FirebaseFirestore.instance.collection("activityFeed");