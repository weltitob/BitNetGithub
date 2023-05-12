import 'dart:async';
import 'dart:convert';
import 'package:BitNet/backbone/auth/storeIONdata.dart';
import 'package:BitNet/backbone/auth/uniqueloginmessage.dart';
import 'package:BitNet/backbone/auth/verificationcodes.dart';
import 'package:BitNet/backbone/cloudfunctions/createdid.dart';
import 'package:BitNet/backbone/cloudfunctions/loginion.dart';
import 'package:BitNet/backbone/cloudfunctions/signmessage.dart';
import 'package:BitNet/models/IONdata.dart';
import 'package:BitNet/models/userdata.dart';
import 'package:BitNet/models/verificationcode.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:BitNet/backbone/helper/databaserefs.dart';

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
    final IONData iondata = await createDID(user.username);
    print("IONDATA RECEIVED: $iondata");

    // Call the function to store ION data in secure storage
    await storeIonData(iondata);

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

  Future<void> signIn(String did, dynamic publicIONKey, dynamic privateIONKey, String username) async {

    // Sign a message using the user's private key (you can use the signMessage function provided earlier)
    // You may need to create a Dart version of the signMessage function
    final message = generateUniqueLoginMessage(did);

    final signedMessage =  await signMessageFunction(
        did,
        publicIONKey,
        privateIONKey,  // Convert the private key object to a JSON string
        message
    );

    //signed message gets verified from loginION function which logs in the user if successful
    if (signedMessage == null) {
      print("Failed to sign the message");
      return;
    }

    print("Message signed... $signedMessage");

    final String customToken = await loginION(
        username.toString(),
        did.toString(),
        signedMessage.toString(),
        message.toString()
    );

    final currentuser = await signInWithToken(customToken: customToken);
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

}
