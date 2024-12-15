import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

final usersCollection = FirebaseFirestore.instance.collection("users");
final socialRecoveryCollection =
    FirebaseFirestore.instance.collection("socialRecovery");
final protocolCollection = FirebaseFirestore.instance.collection("protocols");
final transactionCollection =
    FirebaseFirestore.instance.collection("transactions");
final issueCollection = FirebaseFirestore.instance.collection("issues");
final codesCollection = FirebaseFirestore.instance.collection("codes");
final settingsCollection = FirebaseFirestore.instance.collection("settings");
final followersRef = FirebaseFirestore.instance.collection("followers");
final followingRef = FirebaseFirestore.instance.collection("following");
final activityFeedRef = FirebaseFirestore.instance.collection("activityFeed");
final postsCollection = FirebaseFirestore.instance.collection("posts");
final usersCountRef = FirebaseFirestore.instance.collection("usersCount");
final btcSendsRef = FirebaseFirestore.instance.collection("send_receipts");
final btcReceiveRef = FirebaseFirestore.instance.collection("receive_receipts");
final btcAddressesRef =
    FirebaseFirestore.instance.collection("bitcoin_addresses");
//after bitnetold posts has been added
final storageRef = FirebaseStorage.instance.ref();
final commentsRef = FirebaseFirestore.instance.collection('comments');
final timelineRef = FirebaseFirestore.instance.collection('timeline');
//auth verification codes