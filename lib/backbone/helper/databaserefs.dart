import 'package:cloud_firestore/cloud_firestore.dart';

final usersCollection = FirebaseFirestore.instance.collection("users");
final transactionCollection = FirebaseFirestore.instance.collection("transactions");
final issueCollection = FirebaseFirestore.instance.collection("issues");
final codesCollection = FirebaseFirestore.instance.collection("codes");