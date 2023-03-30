import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nexus_wallet/backbone/auth/auth.dart';
import 'package:nexus_wallet/models/userwallet.dart';

void main() {
  group('Auth', () {
    late Auth auth;

    setUp(() {
      auth = Auth();
    });

    test('currentUser should be null if user is not authenticated', () {
      expect(auth.currentUser, isNull);
    });

    test('authStateChanges should return a stream of User objects', () {
      expect(auth.authStateChanges, isA<Stream<User?>>());
    });

    test('userWalletStreamForAuthChanges should return a stream of UserWallet objects', () {
      expect(auth.userWalletStreamForAuthChanges, isA<Stream<UserWallet?>>());
    });

    test('userWalletStream should return a stream of UserWallet objects', () {
      expect(auth.userWalletStream, isA<Stream<UserWallet?>>());
    });

    test('signInWithEmailAndPassword should return a UserWallet object for the signed-in user', () async {
      final user = UserWallet(
        useruid: 'testuserid',
        email: 'test@test.com',
        walletAddress: 'none',
        walletType: 'none',
        walletBalance: '0.01',
        privateKey: 'none',
      );
      final newUser = await auth.createUserWithEmailAndPassword(
        user: user,
        password: 'testpassword',
      );
      final signedInUser = await auth.signInWithEmailAndPassword(
        email: 'test@test.com',
        password: 'testpassword',
      );
      expect(signedInUser, equals(newUser));
    });

    test('signOut should sign out the currently logged in user', () async {
      final user = UserWallet(
        useruid: 'testuserid',
        email: 'test@test.com',
        walletAddress: 'none',
        walletType: 'none',
        walletBalance: '0.01',
        privateKey: 'none',
      );
      await auth.createUserWithEmailAndPassword(
        user: user,
        password: 'testpassword',
      );
      await auth.signInWithEmailAndPassword(
        email: 'test@test.com',
        password: 'testpassword',
      );
      expect(auth.currentUser, isNotNull);
      await auth.signOut();
      expect(auth.currentUser, isNull);
    });
  });
}