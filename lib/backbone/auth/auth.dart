import 'package:firebase_auth/firebase_auth.dart';
import 'package:nexus_wallet/backbone/databaserefs.dart';
import 'package:nexus_wallet/models/userwallet.dart';

class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? get currentUser => _firebaseAuth.currentUser;
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  //for custom user model
  //UserWallet? get currentUserWallet => getCurrentUser(currentUser.uid);



  Future<UserWallet?> getCurrentUserWallet(String uid) async {
    try {
      final userSnapshot = await usersCollection.doc(uid).get();
      if (userSnapshot.exists) {
        final data = userSnapshot.data() as Map<String, dynamic>;
        final UserWallet user = UserWallet.fromMap(data);
        // setCurrentUser = user;
        // listenToCurrentUser(user.useruid);
        return user;
      } else {
        print('Error user doesnt exist in database');
      }
    } catch (e) {
      print('message: ${e.toString()}');
    }
  }

  // set setCurrentUser(UserWallet? user) {
  //   currentUserNotifier.value = user;
  //   currentUserNotifier.notifyListeners();
  // }
  //
  // Stream<UserWallet?> listenToCurrentUser(String uid) async* {
  //   try {
  //     final snapshots = usersCollection.doc(uid).snapshots();
  //     _userStreamSubscriptions?.cancel();
  //     _userStreamSubscriptions = null;
  //     _userStreamSubscriptions = snapshots.listen((document) {
  //       if (document.exists) {
  //         final data = document.data() as Map<String, dynamic>;
  //
  //         final user = UserWallet.fromMap(data);
  //         setCurrentUser = user;
  //       }
  //     });
  //   } catch (e) {
  //     print(e);
  //   }
  //   yield currentUserNotifier.value;
  // }
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

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}