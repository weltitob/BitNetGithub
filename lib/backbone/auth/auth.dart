import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nexus_wallet/backbone/databaserefs.dart';
import 'package:nexus_wallet/models/userwallet.dart';

class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  //  final User? currentuser = Auth().currentUser;
  User? get currentUser => _firebaseAuth.currentUser;
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  //  final UserWallet? currentuserwallet = Auth().currentUserNotifier.value;
  ValueNotifier<UserWallet?> currentUserNotifier = ValueNotifier<UserWallet?>(null);
  StreamSubscription<DocumentSnapshot<Map<String, dynamic>>>? _userStreamSubscriptions;
  StreamSubscription? _authStreamSubscription;

  Future<UserWallet?> getCurrentUserWallet(String uid) async {
    print('Auth().getCurrentUserWallet has been called');
    try {
      final userSnapshot = await usersCollection.doc(uid).get();
      if (userSnapshot.exists) {
        final data = userSnapshot.data() as Map<String, dynamic>;
        final UserWallet user = UserWallet.fromMap(data);
        setCurrentUser = user;
        listenToCurrentUser(user.useruid);
        return user;
      } else {
        print('Error user doesnt exist in database');
      }
    } catch (e) {
      print('message: ${e.toString()}');
    }
  }

  set setCurrentUser(UserWallet? user) {
    print('Auth().setCurrentUser has been called');
    currentUserNotifier.value = user;
    currentUserNotifier.notifyListeners();
  }

  Stream<UserWallet?> listenToCurrentUser(String uid) async* {
    print('Auth().listenToCurrentUser has been called');
    try {
      final snapshots = usersCollection.doc(uid).snapshots();
      _userStreamSubscriptions?.cancel();
      _userStreamSubscriptions = null;
      _userStreamSubscriptions = snapshots.listen((document) {
        if (document.exists) {
          final data = document.data() as Map<String, dynamic>;
          final user = UserWallet.fromMap(data);
          setCurrentUser = user;
        }
      });
    } catch (e) {
      print(e);
    }
    yield currentUserNotifier.value;
  }
  //hier die daten des aktuell users kriegen....

  //selnsz
  Stream<User?> authStates() {
    return _firebaseAuth.authStateChanges();
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
    final getCurrentUserData = await getCurrentUserWallet(_firebaseAuth.currentUser!.uid);
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
    await getCurrentUserWallet(currentuser.user!.uid);
    return newUser;
  }


  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}