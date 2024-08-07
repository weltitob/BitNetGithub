import 'dart:async';
import 'dart:math';

import 'package:bitnet/backbone/auth/storePrivateData.dart';
import 'package:bitnet/backbone/auth/uniqueloginmessage.dart';
import 'package:bitnet/backbone/auth/updateuserscount.dart';
import 'package:bitnet/backbone/auth/verificationcodes.dart';
import 'package:bitnet/backbone/cloudfunctions/aws/register_lits_ecs.dart';
import 'package:bitnet/backbone/cloudfunctions/aws/start_ecs_task.dart';
import 'package:bitnet/backbone/cloudfunctions/createdid.dart';
import 'package:bitnet/backbone/cloudfunctions/fakelogin.dart';
import 'package:bitnet/backbone/cloudfunctions/signmessage.dart';
import 'package:bitnet/backbone/helper/databaserefs.dart';
import 'package:bitnet/backbone/helper/theme/theme_builder.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:bitnet/models/IONdata.dart';
import 'package:bitnet/models/firebase/verificationcode.dart';
import 'package:bitnet/models/keys/privatedata.dart';
import 'package:bitnet/models/user/userdata.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as fbAuth;
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

/*
The class Auth manages user authentication and user wallet management using Firebase
Authentication and Cloud Firestore.
 */

class Auth {
  // initialzie FirebaseAuth instance
  final fbAuth.FirebaseAuth _firebaseAuth = fbAuth.FirebaseAuth.instance;

  // currentUser getter returns the current authentical user
  fbAuth.User? get currentUser => _firebaseAuth.currentUser;

  // authSateChanges getter returns a stream of authentication state changes
  Stream<fbAuth.User?> get authStateChanges => _firebaseAuth.authStateChanges();

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
  The signInWithEmailAndPassword method signs in the user with the given email address and password.
  The method returns a UserWallet object for the signed-in user.
   */
  Future<fbAuth.UserCredential?> signInWithToken({
    required String customToken,
  }) async {
    fbAuth.UserCredential user =
        await _firebaseAuth.signInWithCustomToken(customToken);
    return user;
  }

  Future<UserData> createUserFake({
    required UserData user,
    required VerificationCode code,
    required String mnemonic,
  }) async {

    LoggerService logger = Get.find();

    logger.i("Calling registerLitEcs now...");
    final result = await registerLitEcs(user.did);
    logger.i("Result from registerLitEcs: $result");

    logger.i("Calling Cloudfunction with Microsoft ION now...");
    logger.i("Generating challenge...");
    final String challange = generateChallenge(user.username);
    final String randomstring = generateRandomString(20); // length 20
    final String customToken = await fakeLoginION(
      randomstring,
    );
    final IONData iondata = IONData(
        did: user.did,
        username: user.username,
        customToken: customToken,
        publicIONKey: "publicIONKey",
        privateIONKey: "privateIONKey",
        mnemonic: mnemonic);

    final PrivateData privateData = PrivateData(
        did: iondata.did,
        privateKey: iondata.privateIONKey,
        mnemonic: iondata.mnemonic);
    // Call the function to store Private data in secure storage
    await storePrivateData(privateData);

    final currentuser = await signInWithToken(customToken: iondata.customToken);
    final newUser = user.copyWith(did: iondata.did);

    logger.i("User signed in with token. Creating user in database now...");

    await usersCollection.doc(currentuser?.user!.uid).set(newUser.toMap());
    logger.i('Successfully created wallet/user in database: ${newUser.toMap()}');
    await settingsCollection.doc(currentuser?.user!.uid).set(
      {
        "theme_mode": "system",
        "lang": "en",
        "primary_color": 4283657726,
        "selected_currency": "USD",
        "selected_card": "lightning",
        "hide_balance": false,
        "country": "US"
      }
    );
    // Call the function to generate and store verification codes
    logger.i(
        "Generating and storing verification codes for friends of the new user now...");
    await generateAndStoreVerificationCodes(
      numCodes: 4,
      codeLength: 5,
      issuer: newUser.did,
      codesCollection: codesCollection,
    );
    logger.i("Marking the verification code as used now...");
    // Call the function to mark the verification code as used
    await markVerificationCodeAsUsed(
      code: code,
      receiver: newUser.did,
      codesCollection: codesCollection,
    );
    logger.i("Verification code marked as used.");
    logger.i("Adding user to userscount");
    addUserCount();
    //now login new user
    logger.i("logging in user with startEcs now..");
    final loginresult = await startEcsTask(newUser.did);
    logger.i("Result from startEcsTask: $loginresult");

    logger.i("Returning new user now...");
    return newUser;
  }

  Future<UserData> createUser({
    required UserData user,
    required VerificationCode code,
  }) async {
        LoggerService logger = Get.find();

    logger.i("Calling Cloudfunction with Microsoft ION now...");

    logger.i("Generating challenge...");
    //does it make sense to call user.did before even having a challenge? wtf something wrong here!!
    final String challange = generateChallenge(user.username);
    logger.i("Challenge created: $challange. Creating user now...");
    final IONData iondata = await createDID(user.username, challange);
    logger.i("User created: IONDATA RECEIVED: $iondata.");
    logger.i("Storing private data now...");
    final PrivateData privateData = PrivateData(
        did: iondata.did,
        privateKey: iondata.privateIONKey,
        mnemonic: iondata.mnemonic);
    // Call the function to store Private data in secure storage
    await storePrivateData(privateData);
    logger.i("Private data stored. Signing in with token now...");
    final currentuser = await signInWithToken(customToken: iondata.customToken);
    final newUser = user.copyWith(did: iondata.did);
    logger.i("User signed in with token. Creating user in database now...");
    await usersCollection.doc(currentuser?.user!.uid).set(newUser.toMap());
    logger.i('Successfully created wallet/user in database: ${newUser.toMap()}');
    // Call the function to generate and store verification codes
    logger.i(
        "Generating and storing verification codes for friends of the new user now...");
    await generateAndStoreVerificationCodes(
      numCodes: 4,
      codeLength: 5,
      issuer: newUser.did,
      codesCollection: codesCollection,
    );
    logger.i("Marking the verification code as used now...");
    // Call the function to mark the verification code as used
    await markVerificationCodeAsUsed(
      code: code,
      receiver: newUser.did,
      codesCollection: codesCollection,
    );
    logger.i("Verification code marked as used.");
    logger.i("Adding user to userscount");
    addUserCount();
    logger.i("Returning new user now...");
    return newUser;
  }

  signMessageAuth(did, privateIONKey) async {
    try {
          LoggerService logger = Get.find();

      logger.i("Signing Message in auth.dart ...");
      logger.i("did: $did, privateIONKey: $privateIONKey");

      final message = generateChallenge(did);

      logger.i("Message: $message");

      logger.i("signMessage function called now...");

      final signedMessage = await signMessageFunction(
          did,
          privateIONKey, // Convert the private key object to a JSON string
          message);

      //signed message gets verified from loginION function which logs in the user if successful
      if (signedMessage == null) {
        throw Exception("Failed to sign message for Auth");
      }

      print("Message signed... $signedMessage");
      return signedMessage;
    } catch (e) {
      throw Exception("Error signing message: $e");
    }
  }

  String generateRandomString(int length) {
    const characters =
        'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final random = Random();
    return String.fromCharCodes(
      Iterable.generate(
        length,
        (_) => characters.codeUnitAt(random.nextInt(characters.length)),
      ),
    );
  }

  Future<void> signIn(
      String did, dynamic signedAuthMessage, BuildContext context) async {
    // Sign a message using the user's private key (you can use the signMessage function provided earlier)
    // You may need to create a Dart version of the signMessage function
    LoggerService logger = Get.find();

    try {
      //showLoadingScreen
      //context.go('/ionloading');
      final String randomstring = generateRandomString(20); // length 20


      final String customToken = await fakeLoginION(
        randomstring,
      );

      // final String customToken = await loginION(
      //   did.toString(),
      //   signedAuthMessage.toString(),
      // );

      final currentuser = await signInWithToken(customToken: customToken);

      if (currentuser == null) {
        // Remove the loading screen
        context.pop();
        throw Exception("User couldnt be signed in with custom Token!");
      } else {
        WidgetsBinding.instance.addPostFrameCallback(ThemeController.of(context).loadData);
        //if successfull push back to homescreen
        context.go("/");
      }
    } catch (e) {
      // Also pop the loading screen when an error occurs
      Navigator.pop(context);
      throw Exception("signIn user failed $e");
    }
  }

  //-----------------------------FIREBASE HELPERS---------------------------

  Future<String> getUserDID(String username) async {
    QuerySnapshot snapshot =
        await usersCollection.where('username', isEqualTo: username).get();

    if (snapshot.docs.isEmpty) {
      throw Exception('No user found with the provided username');
    } else {
      // assuming that 'did' is the field name that holds the DID in the document
      return snapshot.docs.first.get('did');
    }
  }

  Future<String> getUserUsername(String did) async {
    QuerySnapshot snapshot =
        await usersCollection.where('did', isEqualTo: did).get();

    if (snapshot.docs.isEmpty) {
      throw Exception('No user found with the provided username');
    } else {
      // assuming that 'username' is the field name that holds the DID in the document
      return snapshot.docs.first.get('username');
    }
  }

  Future<bool> doesUsernameExist(String username) async {
    final QuerySnapshot snapshot =
        await usersCollection.where('username', isEqualTo: username).get();
    return snapshot.docs.isNotEmpty;
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  //-----------------------------FIREBASE HELPERS---------------------------

  
}

extension on String {
  static final RegExp _phoneRegex =
      RegExp(r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$');
  static final RegExp _emailRegex = RegExp(r'(.+)@(.+)\.(.+)');
  bool get isEmail => _emailRegex.hasMatch(this);
  bool get isPhoneNumber => _phoneRegex.hasMatch(this);
}
