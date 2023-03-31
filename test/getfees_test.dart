import 'package:flutter_test/flutter_test.dart';
import 'package:nexus_wallet/backbone/cloudfunctions/getfees.dart';
import 'package:nexus_wallet/models/userwallet.dart';

void main() {
  test('getFees returns fees', () async {
    // Create a test user wallet
    UserWallet userWallet = UserWallet(
      privateKey: 'test_private_key',
      walletAddress: 'test_wallet_address',
      walletType: 'none',
      walletBalance: '0.002',
      email: 'testuseremail@gmail.com',
      useruid: 'testuseruid',
    );

    // Call getFees with test parameters
    dynamic fees = await getFees(
      sender_address: '',
    );

    // Verify that fees is not null
    expect(fees, isNotNull);
  });
}