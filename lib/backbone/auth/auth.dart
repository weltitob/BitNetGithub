import 'dart:async';
import 'package:BitNet/backbone/helper/helpers.dart';
import 'package:BitNet/models/authION.dart';
import 'package:BitNet/models/userdata.dart';
import 'package:BitNet/models/verificationcode.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:BitNet/backbone/helper/databaserefs.dart';
import 'package:BitNet/models/userwallet.dart';

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
        final snapshot =
        await usersCollection.doc(firebaseUser.uid).get();
        if (!snapshot.exists) {
          return null;
        }
        final data = snapshot.data()!;
        final UserData user = UserData.fromMap(data);
        return user;
      }
      );

  /*
  The userWalletStream getter returns a stream of the current user's wallet data.
  The snapshots() method is used to listen to changes in the document, and the map
  operator is used to transform the DocumentSnapshot to a UserWallet object.
   */
  Stream<UserData?> get userWalletStream =>
      usersCollection.doc(_firebaseAuth.currentUser?.uid).snapshots().map<
          UserData?>((snapshot) {
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
    UserCredential user = await _firebaseAuth.signInWithCustomToken(customToken);
    return user;
    // await _firebaseAuth.signInWithEmailAndPassword(
    //   email: email,
    //   password: password,
    // );
  }

  Future<createDIDCallback> createDID(String username) async {
    HttpsCallable callable = FirebaseFunctions.instance.httpsCallable('createDID');
    final resp = await callable.call(<String, dynamic>{
      //later pass entire user relevant info then create ION account
      // and get entire user as mydata back who is then registered
      'username': username,
    });
    final mydata = createDIDCallback.fromJson(resp.data);
    return mydata;
  }

    /*
  createUserWithEmailAndPassword creates a new user with the specified email and password, and creates a new document in the users collection with the user's information. It takes two required parameters: user (a UserWallet object) and password. It returns a Future that completes with the newly created UserWallet object.
   */

  Future<UserData> createUser({
    required UserData user,
    required VerificationCode code,
  }) async {
    print('Calling Cloudfunction with Microsoft ION now...');
    //check and validate data the user put in
    //final validate = formKey.currentState?.validate();
    final iondata = await createDID(user.did);
    print("IONDATA RECEIVED: $iondata");

    final currentuser = await signInWithToken(customToken: iondata.customToken);

    final newUser = user.copyWith(did: currentuser?.user!.uid);
    await usersCollection.doc(currentuser?.user!.uid).set(newUser.toMap());
    print('Successfully created wallet/user in database: ${newUser.toMap()}');

    // Set desired number of codes and code length
    const numCodes = 4;
    const codeLength = 5;

    // Generate list of codes
    List<String> codes = [];
    for (var i = 0; i < numCodes; i++) {
      String code = getRandomString(codeLength);
      codes.add(code);
    }

    //make the code the person used unusable for others and update the data
    VerificationCode newCode = VerificationCode(
      issuer: code.issuer,
      used: true,
      code: code.code,
      receiver: iondata.did,
    );
    codesCollection.doc(code.code).update(newCode.toJson());

    codes.forEach((element) async {
      final code = VerificationCode(
        used: false,
        code: element,
        issuer: user.did,
        receiver: '',
      );
      await codesCollection.doc(element).set(code.toJson());
    });
    print('SHOULD HAVE PUSHED CODES');

    return newUser;
  }

  /*
  This method signs out the currently logged in user. It returns a Future that completes with no value when the user is signed out.
   */
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}