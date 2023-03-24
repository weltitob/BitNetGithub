// mock HttpsCallableResult object with success response
import 'dart:convert';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nexus_wallet/backbone/cloudfunctions/createwallet.dart';
import 'package:nexus_wallet/models/userwallet.dart';
import 'package:mockito/mockito.dart';

void main() {
  group('createWallet', () {
    test('should return a new UserWallet object on success', () async {
      // arrange
      final email = 'test@example.com';
      final expected = UserWallet(
        walletAddress: 'example_address',
        privateKey: 'privateKey',
        walletType: 'walletType',
        email: 'email',
        walletBalance: 'walletBalance',
        useruid: 'useruid',
      );

      // act
      final result = await createWallet(email: email);

      // assert
      expect(result, expected);
    });

    test('should print an error message on function error', () async {
      // arrange
      final email = 'test@example.com';

      // act
      await createWallet(email: email);

      // assert
      expect(
        logOutput,
        'Die Antwortnachricht der Cloudfunktion war ein Error.',
      );
    });

    test('should print an error message on function call error', () async {
      // arrange
      final email = 'test@example.com';
      final error = 'example error message';

      when(FirebaseFunctions.instance.httpsCallable('createWallet').call(any))
          .thenThrow(error);

      // act
      await createWallet(email: email);

      // assert
      expect(
        logOutput,
        'Wir konnten keine neue Wallet für dich erstellen: $error',
      );
    });
  });
}

String logOutput = '';

void _testLogger(String log) => logOutput = log;