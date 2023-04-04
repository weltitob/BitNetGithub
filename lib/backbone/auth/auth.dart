import 'dart:async';
import 'package:BitNet/backbone/helper/helpers.dart';
import 'package:BitNet/models/verificationcode.dart';
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
  Stream<UserWallet?> get userWalletStreamForAuthChanges =>
      authStateChanges.asyncMap<UserWallet?>((firebaseUser) async {
        if (firebaseUser == null) {
          return null;
        }
        final snapshot =
        await usersCollection.doc(firebaseUser.uid).get();
        if (!snapshot.exists) {
          return null;
        }
        final data = snapshot.data()!;
        final UserWallet user = UserWallet.fromMap(data);
        return user;
      }
      );

  /*
  The userWalletStream getter returns a stream of the current user's wallet data.
  The snapshots() method is used to listen to changes in the document, and the map
  operator is used to transform the DocumentSnapshot to a UserWallet object.
   */
  Stream<UserWallet?> get userWalletStream =>
      usersCollection.doc(_firebaseAuth.currentUser?.uid).snapshots().map<
          UserWallet?>((snapshot) {
        if (_firebaseAuth.currentUser?.uid == null) {
          return null;
        }
        if (!snapshot.exists) {
          print("Hier ist ein error aufgetreten (auth.dart)!");
          return null;
        }
        final data = snapshot.data()!;
        final UserWallet user = UserWallet.fromMap(data);
        return user;
      });

  /*
  The _createUserDocument method is used to update the user's wallet data in the Firestore database.
   */
  Future<void> _createUserDocument(UserWallet userWallet) async {
    await usersCollection.doc(userWallet.useruid).update(userWallet.toMap());
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
  Future<UserWallet?> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  /*
  createUserWithEmailAndPassword creates a new user with the specified email and password, and creates a new document in the users collection with the user's information. It takes two required parameters: user (a UserWallet object) and password. It returns a Future that completes with the newly created UserWallet object.
   */
  Future<UserWallet> createUserWithEmailAndPassword({
    required UserWallet user,
    required String password,
    required VerificationCode code,
  }) async {

    //check and validate data the user put in
    //final validate = formKey.currentState?.validate();
    //final iondata = await authION();

    // Set desired number of codes and code length
    const numCodes = 4;
    const codeLength = 5;

    // Generate list of codes
    List<String> codes = [];
    for (var i = 0; i < numCodes; i++) {
      String code = getRandomString(codeLength);
      codes.add(code);
    }

    codes.forEach((element) async {
      final code = VerificationCode(
        used: false,
        code: element,
        issuer: "",
        receiver: '',
      );
      await codesCollection.doc(element).set(code.toJson());
    });

    final currentuser = await _firebaseAuth.createUserWithEmailAndPassword(
      email: user.email,
      password: password,
    );
    final newUser = user.copyWith(useruid: currentuser.user!.uid);
    await usersCollection.doc(currentuser.user!.uid).set(newUser.toMap());
    print('Successfully created wallet/user in database: ${newUser.toMap()}');



    return newUser;
  }

  /*
  This method signs out the currently logged in user. It returns a Future that completes with no value when the user is signed out.
   */
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}