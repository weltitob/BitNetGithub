import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nexus_wallet/backbone/databaserefs.dart';
import 'package:nexus_wallet/models/userwallet.dart';

class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  //  final User? currentuser = Auth().currentUser;
  User? get currentUser => _firebaseAuth.currentUser;
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  //  final UserWallet? currentuserwallet = Auth().currentUserNotifier.value;

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

  Stream<UserWallet?> get userWalletStream =>
      usersCollection.doc(_firebaseAuth.currentUser!.uid).snapshots().map<UserWallet?>((snapshot) {
        if (!snapshot.exists) {
          print("Hier ist ein error aufgetreten (auth.dart)!");
          return null;
        }
        final data = snapshot.data()!;
        final UserWallet user = UserWallet.fromMap(data);
        return user;
      });

  Future<void> _createUserDocument(UserWallet userWallet) async {
    //just can use
    await usersCollection.doc(userWallet.useruid).update(userWallet.toMap());
  }

  Future<void> sendPasswordResetEmail({
    required String email,
  }) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  Future<UserWallet?> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    //selbst hinzugefügt
  }

  Future<UserWallet> createUserWithEmailAndPassword({
    required UserWallet user,
    required String password,
  }) async {
    final currentuser = await _firebaseAuth.createUserWithEmailAndPassword(
      email: user.email,
      password: password,
    );
    final newUser = user.copyWith(useruid: currentuser.user!.uid);
    await usersCollection.doc(currentuser.user!.uid).set(newUser.toMap());
    print('Successfully created wallet/user in database: ${newUser.toMap()}');
    return newUser;
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}