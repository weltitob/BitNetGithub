import 'dart:async';
import 'dart:math';
import 'package:bitnet/backbone/auth/storePrivateData.dart';
import 'package:bitnet/backbone/auth/uniqueloginmessage.dart';
import 'package:bitnet/backbone/auth/updateuserscount.dart';
import 'package:bitnet/backbone/auth/verificationcodes.dart';
import 'package:bitnet/backbone/cloudfunctions/createdid.dart';
import 'package:bitnet/backbone/cloudfunctions/fakelogin.dart';
import 'package:bitnet/backbone/cloudfunctions/signmessage.dart';
import 'package:bitnet/backbone/helper/logs/logs.dart';
import 'package:bitnet/models/IONdata.dart';
import 'package:bitnet/models/firebase/verificationcode.dart';
import 'package:bitnet/models/keys/privatedata.dart';
import 'package:bitnet/models/user/userdata.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as fbAuth;
import 'package:bitnet/backbone/helper/databaserefs.dart';
import 'package:flutter/cupertino.dart';
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
}) async {
    Logs().w("Calling Cloudfunction with Microsoft ION now...");

    Logs().w("Generating challenge...");
    //does it make sense to call user.did before even having a challenge? wtf something wrong here!!
    final String challange = generateChallenge(user.username);
    final String randomstring = generateRandomString(20); // length 20
    final String customToken = await fakeLoginION(
      randomstring,
    );
    final IONData iondata = IONData(did: "did", username: user.username, customToken: customToken, publicIONKey: "publicIONKey", privateIONKey: "privateIONKey", mnemonic: "mnemonic");
    final PrivateData privateData = PrivateData(
        did: iondata.did, privateKey: iondata.privateIONKey, mnemonic: iondata.mnemonic);
    // Call the function to store Private data in secure storage
    await storePrivateData(privateData);

    final currentuser = await signInWithToken(customToken: iondata.customToken);
    final newUser = user.copyWith(did: iondata.did);

    Logs().w("User signed in with token. Creating user in database now...");

    await usersCollection.doc(currentuser?.user!.uid).set(newUser.toMap());
    Logs().w('Successfully created wallet/user in database: ${newUser.toMap()}');
    // Call the function to generate and store verification codes
    Logs().w("Generating and storing verification codes for friends of the new user now...");
    await generateAndStoreVerificationCodes(
      numCodes: 4,
      codeLength: 5,
      issuer: newUser.did,
      codesCollection: codesCollection,
    );
    Logs().w("Marking the verification code as used now...");
    // Call the function to mark the verification code as used
    await markVerificationCodeAsUsed(
      code: code,
      receiver: newUser.did,
      codesCollection: codesCollection,
    );
    Logs().w("Verification code marked as used.");
    Logs().w("Adding user to userscount");
    addUserCount();
    Logs().w("Returning new user now...");
    return newUser;
  }

  Future<UserData> createUser({
    required UserData user,
    required VerificationCode code,
  }) async {
    Logs().w("Calling Cloudfunction with Microsoft ION now...");

    Logs().w("Generating challenge...");
    //does it make sense to call user.did before even having a challenge? wtf something wrong here!!
    final String challange = generateChallenge(user.username);
    Logs().w("Challenge created: $challange. Creating user now...");
    final IONData iondata = await createDID(user.username, challange);
    Logs().w("User created: IONDATA RECEIVED: $iondata.");
    Logs().w("Storing private data now...");
    final PrivateData privateData = PrivateData(
        did: iondata.did, privateKey: iondata.privateIONKey, mnemonic: iondata.mnemonic);
    // Call the function to store Private data in secure storage
    await storePrivateData(privateData);
    Logs().w("Private data stored. Signing in with token now...");
    final currentuser = await signInWithToken(customToken: iondata.customToken);
    final newUser = user.copyWith(did: iondata.did);
    Logs().w("User signed in with token. Creating user in database now...");
    await usersCollection.doc(currentuser?.user!.uid).set(newUser.toMap());
    Logs().w('Successfully created wallet/user in database: ${newUser.toMap()}');
    // Call the function to generate and store verification codes
    Logs().w("Generating and storing verification codes for friends of the new user now...");
    await generateAndStoreVerificationCodes(
      numCodes: 4,
      codeLength: 5,
      issuer: newUser.did,
      codesCollection: codesCollection,
    );
    Logs().w("Marking the verification code as used now...");
    // Call the function to mark the verification code as used
    await markVerificationCodeAsUsed(
      code: code,
      receiver: newUser.did,
      codesCollection: codesCollection,
    );
    Logs().w("Verification code marked as used.");
    Logs().w("Adding user to userscount");
    addUserCount();
    Logs().w("Returning new user now...");
    return newUser;
  }


  signMessageAuth(did, privateIONKey) async{
    try{
      Logs().w("Signing Message in auth.dart ...");
      Logs().w("did: $did, privateIONKey: $privateIONKey");

      final message = generateChallenge(did);

      Logs().w("Message: $message");

      Logs().w("signMessage function called now...");

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


  Future<void> signIn(String did, dynamic signedAuthMessage, BuildContext context) async {
    // Sign a message using the user's private key (you can use the signMessage function provided earlier)
    // You may need to create a Dart version of the signMessage function

    try{
      //showLoadingScreen
      //context.go('/ionloading');
      final String randomstring = generateRandomString(20); // length 20

      Logs().w("For now simply login in own matrix client until own sever is setup and can register there somehow.");

      //dieser call leitet uns iwie bereits weiter zur matrix page da das muss verhindert werden

      // await loginMatrix(context, "weltitob@proton.me", "Bear123Fliederbaum");

      final String customToken = await fakeLoginION(
          randomstring,
      );

      // final String customToken = await loginION(
      //   did.toString(),
      //   signedAuthMessage.toString(),
      // );

      final currentuser = await signInWithToken(customToken: customToken);

      if(currentuser == null){
        // Remove the loading screen
        context.pop();
        throw Exception("User couldnt be signed in with custom Token!");
      } else {
        //if successfull push back to homescreen
        context.go("/");
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

  /// Starts an analysis of the given homeserver. It uses the current domain and
  /// makes sure that it is prefixed with https. Then it searches for the
  /// well-known information and forwards to the login page depending on the
  /// login type.

  //coming from old homeserverpicker
  // Future<void> checkHomeserverAction(BuildContext context, String homeservertext) async {
  //   try {
  //     var homeserver = Uri.parse(homeservertext);
  //     if (homeserver.scheme.isEmpty) {
  //       homeserver = Uri.https(homeservertext, '');
  //     }
  //     final matrix = Matrix.of(context);
  //     matrix.loginHomeserverSummary =
  //     await matrix.getLoginClient().checkHomeserver(homeserver);
  //     final ssoSupported = matrix.loginHomeserverSummary!.loginFlows
  //         .any((flow) => flow.type == 'm.login.sso');

  //     try {
  //       await Matrix.of(context).getLoginClient().register();
  //       matrix.loginRegistrationSupported = true;
  //     } on MatrixException catch (e) {
  //       matrix.loginRegistrationSupported = e.requireAdditionalAuthentication;
  //     }

  //     if (!ssoSupported && matrix.loginRegistrationSupported == false) {
  //       // Server does not support SSO or registration. We can skip to login page:
  //       context.go('/authhome/login');
  //     } else {import 'package:matrix/matrix.dart';

  //       context.go('/authhome/connect');
  //     }
  //   } catch (e) {
  //     Logs().e('Error in checkHomeserverAction', (e).toLocalizedString(context));
  //   }
  // }

  // Future<void> restoreBackupMatrix(BuildContext context) async {
  //   final picked = await FilePicker.platform.pickFiles(withData: true);
  //   final file = picked?.files.firstOrNull;
  //   if (file == null) return;
  //   await showFutureLoadingDialog(
  //     context: context,
  //     future: () async {
  //       try {
  //         final client = Matrix.of(context).getLoginClient();
  //         await client.importDump(String.fromCharCodes(file.bytes!));
  //         Matrix.of(context).initMatrix();
  //       } catch (e) {
  //         print("Auth.dart: This line somehow importet matrix and it messed with the User line $e");
  //         //This line somehow importet matrix and it messed with the User line
  //         //Logs().e('Future error:', e, s);
  //       }
  //     },
  //   );
  // }

  // loginMatrix(BuildContext context, String username, String password) async {

  //   //this stuff kind of comes from somehwere else...
  //   final matrix = Matrix.of(context);
  //   Uri homeserver = Uri.parse("http://matrix.org");
  //   matrix.loginHomeserverSummary = await matrix.getLoginClient().checkHomeserver(homeserver);

  //   //also throws error that some pushtoken is missing
  //   //this somehow still automtically causes a push to the chats screen which we dont want

  //   try {
  //     AuthenticationIdentifier identifier;
  //     if (username.isEmail) {
  //       identifier = AuthenticationThirdPartyIdentifier(
  //         medium: 'email',
  //         address: username,
  //       );
  //     } else if (username.isPhoneNumber) {
  //       identifier = AuthenticationThirdPartyIdentifier(
  //         medium: 'msisdn',
  //         address: username,
  //       );
  //     } else {
  //       identifier = AuthenticationUserIdentifier(user: username);
  //     }
  //     await matrix.getLoginClient().login(
  //       LoginType.mLoginPassword,
  //       identifier: identifier,
  //       // To stay compatible with older server versions
  //       // ignore: deprecated_member_use
  //       user: identifier.type == AuthenticationIdentifierTypes.userId
  //           ? username
  //           : null,
  //       password: password,
  //       initialDeviceDisplayName: PlatformInfos.clientName,
  //     );

  //   } on MatrixException catch (exception) {
  //     throw Exception("Exception occured with signin Matrix itself: $exception");
  //   } catch (exception) {
  //     throw Exception("Exception occured with signin Matrix thats not Matrix: ${exception.toString()}");
  //   }
  // }


  // bool isDefaultPlatform =
  // (PlatformInfos.isMobile || PlatformInfos.isWeb || PlatformInfos.isMacOS);

  //
  // void ssoLoginAction(BuildContext context, String id) async {
  //   final redirectUrl = kIsWeb
  //       ? '${html.window.origin!}/web/auth.html'
  //       : isDefaultPlatform
  //       ? '${AppTheme.appOpenUrlScheme.toLowerCase()}://login'
  //       : 'http://localhost:3001//login';
  //   final url =
  //       '${Matrix.of(context).getLoginClient().homeserver?.toString()}/_matrix/client/r0/login/sso/redirect/${Uri.encodeComponent(id)}?redirectUrl=${Uri.encodeQueryComponent(redirectUrl)}';
  //   final urlScheme = isDefaultPlatform
  //       ? Uri.parse(redirectUrl).scheme
  //       : "http://localhost:3001";
  //   final result = await FlutterWebAuth2.authenticate(
  //     url: url,
  //     callbackUrlScheme: urlScheme,
  //   );
  //   final token = Uri.parse(result).queryParameters['loginToken'];
  //   if (token?.isEmpty ?? false) return;
  //
  //   await showFutureLoadingDialog(
  //     context: context,
  //     future: () => Matrix.of(context).getLoginClient().login(
  //       LoginType.mLoginToken,
  //       token: token,
  //       initialDeviceDisplayName: PlatformInfos.clientName,
  //     ),
  //   );
  // }

  //
  // bool get supportsPasswordLogin => _supportsFlow('m.login.password');
  //



  // void signUpMatrixFirst(BuildContext context, String username) async {
  //   try {
  //     try {
  //       Logs().w("Trying to register username $username on client");

  //       Client client = Matrix.of(context).getLoginClient();
  //       print(client.database);
  //       print(client.clientName);
  //       print(client.accountData);
  //       print(client.deviceID); //this is null already so the client bullshit def is some issue

  //       if(client != null){
  //         client.register(username: username, password: "testjklskhajkd", initialDeviceDisplayName: "test");
  //         Logs().w("To here it needs to come...");
  //       }
  //       else {
  //         Logs().e("Client is null");
  //       }
  //     } on MatrixException catch (e) {
  //       Logs().e("signUpMatrixFirst error: $e");
  //       if (!e.requireAdditionalAuthentication) rethrow;
  //     }
  //     Matrix.of(context).loginUsername = username;

  //     //context.go('signup');

  //   } catch (e, s) {
  //     final signupError = e.toLocalizedString(context);
  //     Logs().e('Sign up failed: $signupError, in signUpMatrixFirst', e, s);
  //   }
  // }

  // void signupMatrix(BuildContext context, String email, String password) async {
  //   try {
  //     final client = Matrix.of(context).getLoginClient();

  //     if (email.isNotEmpty) {
  //       Matrix.of(context).currentClientSecret =
  //           DateTime.now().millisecondsSinceEpoch.toString();
  //       Matrix.of(context).currentThreepidCreds =
  //       await client.requestTokenToRegisterEmail(
  //         Matrix.of(context).currentClientSecret,
  //         email,
  //         0,
  //       );
  //     }

  //     //the Matrix loginUsername setting is missing for sure!!

  //     final displayname = Matrix.of(context).loginUsername!;
  //     final localPart = displayname.toLowerCase().replaceAll(' ', '_');

  //     await client.uiaRequestBackground(
  //           (auth) => client.register(
  //         username: localPart,
  //         password: password,
  //         initialDeviceDisplayName: PlatformInfos.clientName,
  //         auth: auth,
  //       ),
  //     );
  //     // Set displayname
  //     if (displayname != localPart) {
  //       await client.setDisplayName(
  //         client.userID!,
  //         displayname,
  //       );
  //     }
  //   } catch (e) {
  //     final error = (e).toLocalizedString(context);
  //     Logs().e(error);
  //   }
  // }

  //-----------------------------MATRIX-------------------------------------


}

extension on String {
  static final RegExp _phoneRegex =
  RegExp(r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$');
  static final RegExp _emailRegex = RegExp(r'(.+)@(.+)\.(.+)');

  bool get isEmail => _emailRegex.hasMatch(this);

  bool get isPhoneNumber => _phoneRegex.hasMatch(this);
}