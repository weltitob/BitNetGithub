import 'dart:convert';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:BitNet/backbone/cloudfunctions/createwallet.dart';
import 'package:BitNet/models/cloudfunction_callback.dart';
import 'package:BitNet/models/userwallet.dart';
import 'package:mockito/mockito.dart';

class MockHttpsCallable extends Mock implements HttpsCallable {}

void main() {
  group('createWallet', () {
    late HttpsCallable callable;
    final email = 'example@example.com';

    setUp(() {
      callable = MockHttpsCallable();
    });

    test('should return a new wallet on success', () async {
      final data = {
        'status': 'success',
        'message': jsonEncode({
          'address': 'example_address',
          'privateKey': 'example_private_key',
        }),
      };

      final result = await createWallet(email: email);

      expect(result, isA<UserWallet>());
      expect(result.address, 'example_address');
      expect(result.privateKey, 'example_private_key');
    });

    test('should handle errors correctly', () async {
      final data = {
        'status': 'error',
        'message': 'An error occurred.',
      };
      final result = await createWallet(email: email);

      expect(result, isNull);
      // Add more expectations as needed
    });
  });
}