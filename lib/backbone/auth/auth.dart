import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:BitNet/backbone/auth/storeIONdata.dart';
import 'package:BitNet/backbone/auth/uniqueloginmessage.dart';
import 'package:BitNet/backbone/auth/verificationcodes.dart';
import 'package:BitNet/backbone/cloudfunctions/createdid.dart';
import 'package:BitNet/backbone/cloudfunctions/loginion.dart';
import 'package:BitNet/backbone/cloudfunctions/signmessage.dart';
import 'package:BitNet/backbone/helper/helpers.dart';
import 'package:BitNet/models/authION.dart';
import 'package:BitNet/models/userdata.dart';
import 'package:BitNet/models/verificationcode.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:BitNet/backbone/helper/databaserefs.dart';
import 'package:BitNet/models/userwallet.dart';
import 'package:jose/jose.dart';
import 'package:pointycastle/pointycastle.dart';
import 'package:pointycastle/random/fortuna_random.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'dart:convert';
import 'dart:typed_data';
import 'package:pointycastle/api.dart';

/*
The class Auth manages user authentication and user wallet management using Firebase
Authentication and Cloud Firestore.
 */
class Auth {
  // initialzie FirebaseAuth instance
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // currentUser getter returns the current authentical user
  User? get currentUser => _firebaseAuth.currentUser;

  // authSateChanges getter returns a stream of authentication state changes
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  /*
  The userWalletStreamForAuthChanges getter returns a stream of the authenticated user's wallet data.
  The authStateChanges stream is used as the source stream, and the asyncMap operator is used to map the stream of User objects to UserWallet objects.
   */
  Stream<UserData?> get userWalletStreamForAuthChanges =>
      authStateChanges.asyncMap<UserData?>((firebaseUser) async {
        if (firebaseUser == null) {
          return null;
        }
        final snapshot = await usersCollection.doc(firebaseUser.uid).get();
        if (!snapshot.exists) {
          return null;
        }
        final data = snapshot.data()!;
        final UserData user = UserData.fromMap(data);
        return user;
      });

  /*
  The userWalletStream getter returns a stream of the current user's wallet data.
  The snapshots() method is used to listen to changes in the document, and the map
  operator is used to transform the DocumentSnapshot to a UserWallet object.
   */
  Stream<UserData?> get userWalletStream => usersCollection
          .doc(_firebaseAuth.currentUser?.uid)
          .snapshots()
          .map<UserData?>((snapshot) {
        if (_firebaseAuth.currentUser?.uid == null) {
          return null;
        }
        if (!snapshot.exists) {
          print("Hier ist ein error aufgetreten (auth.dart)!");
          return null;
        }
        final data = snapshot.data()!;
        final UserData user = UserData.fromMap(data);
        return user;
      });

  /*
  The _createUserDocument method is used to update the user's wallet data in the Firestore database.
   */
  Future<void> updateUserData(UserData userData) async {
    await usersCollection.doc(userData.did).update(userData.toMap());
  }

  /*
  The sendPasswordResetEmail method sends a password reset email to the given email address.
   */
  Future<void> sendPasswordResetEmail({
    required String email,
  }) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  /*
  The signInWithEmailAndPassword method signs in the user with the given email address and password.
  The method returns a UserWallet object for the signed-in user.
   */
  Future<UserCredential?> signInWithToken({
    required String customToken,
  }) async {
    UserCredential user =
        await _firebaseAuth.signInWithCustomToken(customToken);
    return user;
  }

  Future<UserData> createUser({
    required UserData user,
    required VerificationCode code,
  }) async {
    print('Calling Cloudfunction with Microsoft ION now...');
    final IONData iondata = await createDID(user.did);
    print("IONDATA RECEIVED: $iondata");

    // Call the function to store ION data in secure storage
    await storeIonData(iondata);

    final currentuser = await signInWithToken(customToken: iondata.customToken);

    final newUser = user.copyWith(did: currentuser?.user!.uid);
    await usersCollection.doc(currentuser?.user!.uid).set(newUser.toMap());
    print('Successfully created wallet/user in database: ${newUser.toMap()}');

    // Call the function to generate and store verification codes
    await generateAndStoreVerificationCodes(
      numCodes: 4,
      codeLength: 5,
      issuer: user.did,
      codesCollection: codesCollection,
    );

    // Call the function to mark the verification code as used
    await markVerificationCodeAsUsed(
      code: code,
      receiver: iondata.did,
      codesCollection: codesCollection,
    );

    return newUser;
  }

  Future<void> signIn(String username) async {
    // Retrieve the user's DID, private key, and public key from the local storage or any other secure storage
    // Replace "shared_preferences" with your preferred storage method
    final prefs = await SharedPreferences.getInstance();
    final did = prefs.getString('did')!;
    final privateKey = json.decode(prefs.getString('privateKey')!);
    final publicKey = json.decode(prefs.getString('publicKey')!);

    Map<String, dynamic> privateKeyJwk = {'your': privateKey};

    // Sign a message using the user's private key (you can use the signMessage function provided earlier)
    // You may need to create a Dart version of the signMessage function
    final message = generateUniqueLoginMessage(did);
    final signedMessage =
        await signMessageFunction(did, privateKeyJwk, message);

    //signed message gets verified from loginION function which logs in the user if successful
    final IONData? data = await loginION(username, did, signedMessage, message);
    final currentuser = await signInWithToken(customToken: data!.customToken);
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
