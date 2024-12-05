import 'dart:async';
import 'dart:math';

import 'package:bitnet/backbone/auth/storePrivateData.dart';
import 'package:bitnet/backbone/auth/uniqueloginmessage.dart';
import 'package:bitnet/backbone/auth/updateuserscount.dart';
import 'package:bitnet/backbone/auth/verificationcodes.dart';
import 'package:bitnet/backbone/auth/walletunlock_controller.dart';
import 'package:bitnet/backbone/cloudfunctions/loginion.dart';
import 'package:bitnet/backbone/cloudfunctions/sign_verify_auth/create_challenge.dart';
import 'package:bitnet/backbone/cloudfunctions/sign_verify_auth/verify_message.dart';
import 'package:bitnet/backbone/helper/databaserefs.dart';
import 'package:bitnet/backbone/helper/key_services/sign_challenge.dart';
import 'package:bitnet/backbone/helper/theme/theme_builder.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:bitnet/models/firebase/verificationcode.dart';

import 'package:bitnet/models/keys/privatedata.dart';
import 'package:bitnet/models/user/userdata.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as fbAuth;
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:bitnet/models/keys/userchallenge.dart';
import 'package:bitnet/backbone/helper/key_services/wif_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:bip39/bip39.dart' as bip39;


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
  Stream<UserData?> get userWalletStreamForAuthChanges => authStateChanges.asyncMap<UserData?>((firebaseUser) async {
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
  Stream<UserData?> get userWalletStream => usersCollection.doc(_firebaseAuth.currentUser?.uid).snapshots().map<UserData?>((snapshot) {
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
    fbAuth.UserCredential user = await _firebaseAuth.signInWithCustomToken(customToken);
    return user;
  }

  Future<UserData> createUser({
    required UserData user,
    required VerificationCode code,

  }) async {
    LoggerService logger = Get.find();

    await usersCollection.doc(user.did).set(user.toMap());
    logger.i('Successfully created wallet/user in database: ${user.toMap()}');
    // Call the function to generate and store verification codes
    logger.i("Generating and storing verification codes for friends of the new user now...");

    logger.i("Generating challenge...");
    UserChallengeResponse? userChallengeResponse = await create_challenge(user.did, ChallengeType.default_registration);

    logger.d('Created challenge for user ${user.did}: $userChallengeResponse');

    String challengeId = userChallengeResponse!.challenge.challengeId;
    logger.d('Challenge ID: $challengeId');

    String challengeData = userChallengeResponse.challenge.title;
    logger.d('Challenge Data: $challengeData');

    PrivateData privateData = await getPrivateData(user.did);
    logger.d('Retrieved private data for user ${user.did}');

    final String publicKeyHex = privateData.did;
    logger.d('Public Key Hex: $publicKeyHex');

    final String privateKeyHex = privateData.privateKey;
    logger.d('Private Key Hex: $privateKeyHex');

    String signatureHex = await signChallengeData(privateKeyHex, publicKeyHex, challengeData);
    logger.d('Generated signature hex: $signatureHex');

    // Verify the signature with the server
    dynamic customAuthToken = await verifyMessage(
         publicKeyHex.toString(),
         challengeId.toString(),
         signatureHex.toString(),
    );
    //get the customtoken from the response
    print("Verify message response: ${customAuthToken.toString()}");


    final currentuser = await signInWithToken(customToken: customAuthToken);

    // Initialize user settings in the database
    await settingsCollection.doc(currentuser?.user!.uid).set({
      "theme_mode": "system",
      "lang": "en",
      "primary_color": 4283657726,
      "selected_currency": "USD",
      "selected_card": "lightning",
      "hide_balance": false,
      "country": "US"
    });

    await generateAndStoreVerificationCodes(
      numCodes: 4,
      codeLength: 5,
      issuer: user.did,
      codesCollection: codesCollection,
    );

    logger.i("Marking the verification code as used now...");
    // Call the function to mark the verification code as used
    await markVerificationCodeAsUsed(
      code: code,
       receiver: user.did,
      codesCollection: codesCollection,
    );
    logger.i("Verification code marked as used.");
    logger.i("Adding user to users count");
    addUserCount();
    logger.i("Returning new user now...");

    return user;
  }


  // signMessageWithMnemonicAuth(String mnemonic, String challenge) async {
  //   try {
  //     LoggerService logger = Get.find();
  //
  //     logger.i("Signing Message in auth.dart ...");
  //
  //     // Validate the mnemonic
  //     bool isValid = bip39.validateMnemonic(mnemonic);
  //     print('Mnemonic is valid: $isValid\n');
  //
  //     // Convert mnemonic to seed
  //     String seed = bip39.mnemonicToSeedHex(mnemonic);
  //     print('Seed derived from mnemonic:\n$seed\n');
  //
  //     Uint8List seedUnit = bip39.mnemonicToSeed(mnemonic);
  //
  //     HDWallet hdWallet = HDWallet.fromSeed(seedUnit,);
  //     // Master private key (WIF)
  //     String? masterPrivateKeyWIF = hdWallet.wif;
  //     print('Master Private Key (WIF): $masterPrivateKeyWIF\n');
  //
  //     // Master public key (compressed)
  //     String? masterPublicKey = hdWallet.pubKey;
  //     print('Master Public Key: $masterPublicKey\n');
  //
  //     String? masterPrivateKey = hdWallet.privKey;
  //     print('Master Private Key: $masterPrivateKey\n');
  //
  //     // Set the DID (Decentralized Identifier) as the public key hex
  //     String did = masterPublicKey!;
  //
  //     final message = generateChallenge(did);
  //
  //     logger.i("Message: $message");
  //
  //     logger.i("signMessage function called now...");
  //
  //     //sign the message locally
  //
  //     // final signedMessage = await signMessageFunction(
  //     //     did,
  //     //     privateIONKey, // Convert the private key object to a JSON string
  //     //     message);
  //
  //
  //
  //
  //     print("Message signed... $signedMessage");
  //     return signedMessage;
  //   } catch (e) {
  //     throw Exception("Error signing message: $e");
  //   }
  // }

  String generateRandomString(int length) {
    const characters = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final random = Random();
    return String.fromCharCodes(
      Iterable.generate(
        length,
        (_) => characters.codeUnitAt(random.nextInt(characters.length)),
      ),
    );
  }

  Future<void> signIn(ChallengeType challengeType, PrivateData privateData, String signatureHex, BuildContext context) async {
    // Sign a message using the user's private key (you can use the signMessage function provided earlier)
    // You may need to create a Dart version of the signMessage function
    LoggerService logger = Get.find();

    final String did = privateData.did;

    try {
      //showLoadingScreen
      //context.go('/ionloading');


      // final String customToken = await fakeLoginION(
      //   randomstring,
      // );

      // final String customToken = await loginION(
      //   did.toString(),
      //   signedAuthMessage.toString(),
      // );

      //create challenge for

      logger.i("Generating challenge...");
      UserChallengeResponse? userChallengeResponse = await create_challenge(did, challengeType);

      String challengeId = userChallengeResponse!.challenge.challengeId;

      // Verify the signature with the server
      dynamic customAuthToken = await verifyMessage(
        did.toString(),
        challengeId.toString(),
        signatureHex.toString(),
      );

      print("Verify message response: ${customAuthToken.toString()}");
      final currentuser = await signInWithToken(customToken: customAuthToken);

      if (currentuser == null) {
        // Remove the loading screen
        context.pop();
        throw Exception("User couldnt be signed in with custom Token!");
      } else {

        await storePrivateData(privateData);

        // Begin user registration process
        // final registrationController = Get.find<RegistrationController>();
        // logger.i("AWS ECS: Registering and setting up user...");

        // registrationController.isLoading.value = true;
        //
        // final String shortDid = did.substring(0, 12);
        // final registrationResponse = await registrationController.loginAndStartEcs(shortDid);
        //
        // registrationController.isLoading.value = false;

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
    QuerySnapshot snapshot = await usersCollection.where('username', isEqualTo: username).get();

    if (snapshot.docs.isEmpty) {
      throw Exception('No user found with the provided username');
    } else {
      // assuming that 'did' is the field name that holds the DID in the document
      return snapshot.docs.first.get('did');
    }
  }

  Future<String> getUserUsername(String did) async {
    QuerySnapshot snapshot = await usersCollection.where('did', isEqualTo: did).get();

    if (snapshot.docs.isEmpty) {
      throw Exception('No user found with the provided username');
    } else {
      // assuming that 'username' is the field name that holds the DID in the document
      return snapshot.docs.first.get('username');
    }
  }

  Future<bool> doesUsernameExist(String username) async {
    final QuerySnapshot snapshot = await usersCollection.where('username', isEqualTo: username).get();
    return snapshot.docs.isNotEmpty;
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  //-----------------------------FIREBASE HELPERS---------------------------
}

extension on String {
  static final RegExp _phoneRegex = RegExp(r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$');
  static final RegExp _emailRegex = RegExp(r'(.+)@(.+)\.(.+)');
  bool get isEmail => _emailRegex.hasMatch(this);
  bool get isPhoneNumber => _phoneRegex.hasMatch(this);
}
