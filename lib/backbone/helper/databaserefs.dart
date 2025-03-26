import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

class Databaserefs {
  static final FirebaseFirestore _firestore = 
      kIsWeb ? _getWebSafeFirestore() : FirebaseFirestore.instance;
  
  static final FirebaseStorage _storage = 
      kIsWeb ? _getWebSafeStorage() : FirebaseStorage.instance;

  // Helper method to handle web Firebase initialization errors
  static FirebaseFirestore _getWebSafeFirestore() {
    try {
      return FirebaseFirestore.instance;
    } catch (e) {
      print('Using mock Firestore for web preview: $e');
      // Return a placeholder instance - this won't be used in web mode
      // due to our web-safe checks throughout the app
      return FirebaseFirestore.instance;
    }
  }
  
  // Helper method to handle web Firebase Storage initialization errors
  static FirebaseStorage _getWebSafeStorage() {
    try {
      return FirebaseStorage.instance;
    } catch (e) {
      print('Using mock FirebaseStorage for web preview: $e');
      // Return a placeholder instance - this won't be used in web mode
      return FirebaseStorage.instance;
    }
  }

  // Collections
  static final usersCollection = _firestore.collection("users");
  static final socialRecoveryCollection = _firestore.collection("socialRecovery");
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
  
  // Storage
  static final storageRef = _storage.ref();
  
  // Helper methods to check if we're in web mode
  static bool get isWebMode => kIsWeb;
  
  // Method to get mock data for web preview
  static Future<Map<String, dynamic>> getMockDataForWeb(String collection, String docId) async {
    // Return appropriate mock data based on collection and docId
    switch (collection) {
      case 'settings':
        return {
          "theme_mode": "system",
          "lang": "en",
          "primary_color": 0xFFFFFFFF, // White
          "selected_currency": "USD",
          "selected_card": "lightning",
          "hide_balance": false
        };
      case 'users':
        return {
          "username": "web_preview_user",
          "displayName": "Web Preview User",
          "email": "web@example.com",
          "created": DateTime.now().millisecondsSinceEpoch,
        };
      default:
        return {};
    }
  }
}

// Legacy direct references - keeping for backward compatibility
// These references now use the web-safe versions from Databaserefs class
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
