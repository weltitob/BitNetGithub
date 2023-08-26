import 'dart:async';
import 'package:BitNet/backbone/auth/storePrivateData.dart';
import 'package:BitNet/backbone/auth/uniqueloginmessage.dart';
import 'package:BitNet/backbone/auth/verificationcodes.dart';
import 'package:BitNet/backbone/cloudfunctions/createdid.dart';
import 'package:BitNet/backbone/cloudfunctions/loginion.dart';
import 'package:BitNet/backbone/cloudfunctions/signmessage.dart';
import 'package:BitNet/models/IONdata.dart';
import 'package:BitNet/models/keys/privatedata.dart';
import 'package:BitNet/models/user/userdata.dart';
import 'package:BitNet/models/verificationcode.dart';
import 'package:BitNet/backbone/helper/localized_exception_extension.dart';
import 'package:BitNet/pages/matrix/utils/other/platform_infos.dart';
import 'package:BitNet/pages/routetrees/authroutes.dart';
import 'package:BitNet/pages/routetrees/matrix.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart' as fbAuth;
import 'package:BitNet/backbone/helper/databaserefs.dart';
import 'package:flutter/cupertino.dart';
import 'package:future_loading_dialog/future_loading_dialog.dart';
import 'package:vrouter/vrouter.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:matrix/matrix.dart';

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

  Future<UserData> createUser({
    required UserData user,
    required VerificationCode code,
  }) async {
    print('Calling Cloudfunction with Microsoft ION now...');

    final String challange = generateChallenge(user.did);

    final IONData iondata = await createDID(user.username, challange);

    final PrivateData privateData = PrivateData(
        did: iondata.did, privateKey: iondata.privateIONKey, mnemonic: iondata.mnemonic);
    print("IONDATA RECEIVED: $iondata");

    // Call the function to store Private data in secure storage
    await storePrivateData(privateData);

    final currentuser = await signInWithToken(customToken: iondata.customToken);

    final newUser = user.copyWith(did: iondata.did);
    await usersCollection.doc(currentuser?.user!.uid).set(newUser.toMap());

    print('Successfully created wallet/user in database: ${newUser.toMap()}');

    // Call the function to generate and store verification codes
    await generateAndStoreVerificationCodes(
      numCodes: 4,
      codeLength: 5,
      issuer: newUser.did,
      codesCollection: codesCollection,
    );


    // Call the function to mark the verification code as used
    await markVerificationCodeAsUsed(
      code: code,
      receiver: newUser.did,
      codesCollection: codesCollection,
    );

    return newUser;
  }


  signMessageAuth(did, privateIONKey) async{
    try{
      final message = generateChallenge(did);

      final signedMessage =  await signMessageFunction(
          did,
          privateIONKey,  // Convert the private key object to a JSON string
          message
      );

      //signed message gets verified from loginION function which logs in the user if successful
      if (signedMessage == null) {
        throw Exception("Failed to sign message for Auth");
      }

      print("Message signed... $signedMessage");
      return signedMessage;
    } catch(e){
      throw Exception("Error signing message: $e");
    }
  }


  Future<void> signIn(String did, dynamic signedAuthMessage, BuildContext context) async {
    // Sign a message using the user's private key (you can use the signMessage function provided earlier)
    // You may need to create a Dart version of the signMessage function

    try{
      //showLoadingScreen
      VRouter.of(context).to('/ionloading');

      final String customToken = await loginION(
        did.toString(),
        signedAuthMessage.toString(),
      );

      final currentuser = await signInWithToken(customToken: customToken);

      if(currentuser == null){
        // Remove the loading screen
        Navigator.pop(context);
        throw Exception("User couldnt be signed in with custom Token!");
      } else {
        //if successfull push back to homescreen
        VRouter.of(context).to("/");
      }

    } catch(e){
      // Also pop the loading screen when an error occurs
      Navigator.pop(context);
      throw Exception("signIn user failed $e");
    }
  }

  //-----------------------------FIREBASE HELPERS---------------------------

  Future<String> getUserDID(String username) async {
    QuerySnapshot snapshot = await usersCollection
        .where('username', isEqualTo: username)
        .get();

    if (snapshot.docs.isEmpty) {
      throw Exception('No user found with the provided username');
    } else {
      // assuming that 'did' is the field name that holds the DID in the document
      return snapshot.docs.first.get('did');
    }
  }

  Future<String> getUserUsername(String did) async {
    QuerySnapshot snapshot = await usersCollection
        .where('did', isEqualTo: did)
        .get();

    if (snapshot.docs.isEmpty) {
      throw Exception('No user found with the provided username');
    } else {
      // assuming that 'username' is the field name that holds the DID in the document
      return snapshot.docs.first.get('username');
    }
  }

  Future<bool> doesUsernameExist(String username) async {
    final QuerySnapshot snapshot = await usersCollection
        .where('username', isEqualTo: username)
        .get();
    return snapshot.docs.isNotEmpty;
  }


  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  //-----------------------------FIREBASE HELPERS---------------------------

  //-----------------------------MATRIX-------------------------------------

  Future<void> restoreBackupMatrix(BuildContext context) async {
    final picked = await FilePicker.platform.pickFiles(withData: true);
    final file = picked?.files.firstOrNull;
    if (file == null) return;
    await showFutureLoadingDialog(
      context: context,
      future: () async {
        try {
          final client = Matrix.of(context).getLoginClient();
          await client.importDump(String.fromCharCodes(file.bytes!));
          Matrix.of(context).initMatrix();
        } catch (e, s) {
          print("Auth.dart: This line somehow importet matrix and it messed with the User line $e");
          //This line somehow importet matrix and it messed with the User line
          //Logs().e('Future error:', e, s);
        }
      },
    );
  }

  void loginMatrix(BuildContext context, String username, String password) async {
    final matrix = Matrix.of(context);

    try {
      AuthenticationIdentifier identifier;
      if (username.isEmail) {
        identifier = AuthenticationThirdPartyIdentifier(
          medium: 'email',
          address: username,
        );
      } else if (username.isPhoneNumber) {
        identifier = AuthenticationThirdPartyIdentifier(
          medium: 'msisdn',
          address: username,
        );
      } else {
        identifier = AuthenticationUserIdentifier(user: username);
      }
      await matrix.getLoginClient().login(
        LoginType.mLoginPassword,
        identifier: identifier,
        // To stay compatible with older server versions
        // ignore: deprecated_member_use
        user: identifier.type == AuthenticationIdentifierTypes.userId
            ? username
            : null,
        password: password,
        initialDeviceDisplayName: PlatformInfos.clientName,
      );
    } on MatrixException catch (exception) {
      throw Exception("Exception occured with signin Matrix itself: $exception");
    } catch (exception) {
      throw Exception("Exception occured with signin Matrix thats not Matrix: ${exception.toString()}");
    }
  }


  void signUpMatrixFirst(BuildContext context, String username) async {
    try {
      try {
        await Matrix.of(context).getLoginClient().register(username: username);
      } on MatrixException catch (e) {
        if (!e.requireAdditionalAuthentication) rethrow;
      }
      Matrix.of(context).loginUsername = username;
      VRouter.of(context).to('signup');
    } catch (e, s) {
      Logs().d('Sign up failed', e, s);
    }
  }

  void signupMatrix(BuildContext context, String email, String password) async {
    try {
      final client = Matrix.of(context).getLoginClient();

      if (email.isNotEmpty) {
        Matrix.of(context).currentClientSecret =
            DateTime.now().millisecondsSinceEpoch.toString();
        Matrix.of(context).currentThreepidCreds =
        await client.requestTokenToRegisterEmail(
          Matrix.of(context).currentClientSecret,
          email,
          0,
        );
      }

      final displayname = Matrix.of(context).loginUsername!;
      final localPart = displayname.toLowerCase().replaceAll(' ', '_');

      await client.uiaRequestBackground(
            (auth) => client.register(
          username: localPart,
          password: password,
          initialDeviceDisplayName: PlatformInfos.clientName,
          auth: auth,
        ),
      );
      // Set displayname
      if (displayname != localPart) {
        await client.setDisplayName(
          client.userID!,
          displayname,
        );
      }
    } catch (e) {
      final error = (e).toLocalizedString(context);
      print(error);
    }
  }

  //-----------------------------MATRIX-------------------------------------


}

extension on String {
  static final RegExp _phoneRegex =
  RegExp(r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$');
  static final RegExp _emailRegex = RegExp(r'(.+)@(.+)\.(.+)');

  bool get isEmail => _emailRegex.hasMatch(this);

  bool get isPhoneNumber => _phoneRegex.hasMatch(this);
}