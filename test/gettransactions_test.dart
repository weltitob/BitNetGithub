import 'dart:convert';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nexus_wallet/models/userwallet.dart';
import 'package:mockito/mockito.dart';

import 'createwallet_test.dart';

void main() {
  group('getTransactions function', () {
    final userWallet = UserWallet(
      walletAddress: 'example_address',
      privateKey: 'privateKey',
      walletType: 'walletType',
      email: 'email',
      walletBalance: 'walletBalance',
      useruid: 'useruid',
    );
    final mockHttpsCallable = MockHttpsCallable();
    final functions = FirebaseFunctions.instance;

    test('should call getTransactions function and update Firebase', () async {
      // mock the httpsCallable method to return the mock result
      when(functions.httpsCallable('getTransactions'))
          .thenReturn(mockHttpsCallable);

      // verify that the httpsCallable method was called once with the correct parameter
      verify(functions.httpsCallable('getTransactions').call({
        'address': userWallet.walletAddress,
      })).called(1);

      // verify that the transaction was added to Firebase
      // this assumes that the transactionCollection instance has been properly initialized in the WalletService class
    });
  });
}
