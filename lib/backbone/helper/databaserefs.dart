import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

class Databaserefs {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final FirebaseStorage _storage = FirebaseStorage.instance;

  // Collections
  static final usersCollection = _firestore.collection("users");
  static final socialRecoveryCollection =
      _firestore.collection("socialRecovery");
  static final emailRecoveryCollection = _firestore.collection("emailRecovery");
  static final protocolCollection = _firestore.collection("protocols");
  static final transactionCollection = _firestore.collection("transactions");
  static final issueCollection = _firestore.collection("issues");
  static final codesCollection = _firestore.collection("codes");
  static final settingsCollection = _firestore.collection("settings");
  static final followersRef = _firestore.collection("followers");
  static final followingRef = _firestore.collection("following");
  static final activityFeedRef = _firestore.collection("activityFeed");
  static final postsCollection = _firestore.collection("posts");
  static final usersCountRef = _firestore.collection("usersCount");
  static final btcSendsRef = _firestore.collection("send_receipts");
  // final btcReceiveRef = _firestore.collection("receive_receipts");
  static final btcAddressesRef = _firestore.collection("bitcoin_addresses");
  static final backendRef = _firestore.collection('backend');
  static final commentsRef = _firestore.collection('comments');
  static final timelineRef = _firestore.collection('timeline');
  static final appsRef = _firestore.collection('mini_apps');
  static final appApplicationsRef =
      _firestore.collection('mini_app_applications');

  // Storage
  static final storageRef = _storage.ref();

  // Helper methods to check if we're in web mode
  static bool get isWebMode => kIsWeb;
}

// // Legacy direct references - keeping for backward compatibility
// // These references now use the web-safe versions from Databaserefs class
final usersCollection = Databaserefs.usersCollection;
final socialRecoveryCollection = Databaserefs.socialRecoveryCollection;
final emailRecoveryCollection = Databaserefs.emailRecoveryCollection;
final protocolCollection = Databaserefs.protocolCollection;
final transactionCollection = Databaserefs.transactionCollection;
final issueCollection = Databaserefs.issueCollection;
final codesCollection = Databaserefs.codesCollection;
final settingsCollection = Databaserefs.settingsCollection;
final followersRef = Databaserefs.followersRef;
final followingRef = Databaserefs.followingRef;
final activityFeedRef = Databaserefs.activityFeedRef;
final postsCollection = Databaserefs.postsCollection;
final usersCountRef = Databaserefs.usersCountRef;
final btcSendsRef = Databaserefs.btcSendsRef;
final btcAddressesRef = Databaserefs.btcAddressesRef;
final backendRef = Databaserefs.backendRef;
final storageRef = Databaserefs.storageRef;
final commentsRef = Databaserefs.commentsRef;
final timelineRef = Databaserefs.timelineRef;
final appApplicationsRef = Databaserefs.appApplicationsRef;
