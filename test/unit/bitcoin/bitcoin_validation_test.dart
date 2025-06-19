import 'package:flutter_test/flutter_test.dart';
import 'package:bitnet/backbone/helper/helpers.dart';

/// Unit tests for Bitcoin validation functions
/// 
/// These tests verify the validation logic for various Bitcoin-related
/// formats including addresses, transaction IDs, public keys, and 
/// Lightning Network invoices.
/// 
/// Test categories:
/// 1. Compressed public key validation
/// 2. Transaction ID validation
/// 3. Bitcoin address hash validation
/// 4. Lightning invoice validation
/// 5. Lightning address (email format) validation
/// 6. BIP21 URI validation
void main() {
  group('Bitcoin Validation - Compressed Public Keys', () {
    test('should validate correct compressed public keys starting with 02', () {
      // Valid compressed public keys are 66 characters (33 bytes in hex)
      // and start with either 02 or 03
      expect(
        isCompressedPublicKey('02b4632d08485ff1df2db55b9dafd23347d1c47a457072a1e87be26896549a8737'),
        isTrue,
      );
    });

    test('should validate correct compressed public keys starting with 03', () {
      expect(
        isCompressedPublicKey('03b4632d08485ff1df2db55b9dafd23347d1c47a457072a1e87be26896549a8737'),
        isTrue,
      );
    });

    test('should reject public keys with incorrect length', () {
      // Too short (65 chars)
      expect(
        isCompressedPublicKey('02b4632d08485ff1df2db55b9dafd23347d1c47a457072a1e87be26896549a873'),
        isFalse,
      );
      
      // Too long (67 chars)
      expect(
        isCompressedPublicKey('02b4632d08485ff1df2db55b9dafd23347d1c47a457072a1e87be26896549a87377'),
        isFalse,
      );
    });

    test('should reject public keys with invalid prefix', () {
      // Invalid prefixes (not 02 or 03)
      expect(
        isCompressedPublicKey('01b4632d08485ff1df2db55b9dafd23347d1c47a457072a1e87be26896549a8737'),
        isFalse,
      );
      
      expect(
        isCompressedPublicKey('04b4632d08485ff1df2db55b9dafd23347d1c47a457072a1e87be26896549a8737'),
        isFalse,
      );
    });

    test('should reject non-hexadecimal characters', () {
      expect(
        isCompressedPublicKey('02g4632d08485ff1df2db55b9dafd23347d1c47a457072a1e87be26896549a8737'),
        isFalse,
      );
      
      expect(
        isCompressedPublicKey('03b4632d08485ff1df2db55b9dafd23347d1c47a457072a1e87be26896549z8737'),
        isFalse,
      );
    });

    test('should handle edge cases', () {
      expect(isCompressedPublicKey(''), isFalse);
      expect(isCompressedPublicKey('02'), isFalse);
      expect(isCompressedPublicKey('not-a-key'), isFalse);
    });
  });

  group('Bitcoin Validation - Transaction IDs', () {
    test('should validate correct transaction IDs', () {
      // Valid transaction IDs are 64 character hexadecimal strings
      expect(
        isValidBitcoinTransactionID('e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855'),
        isTrue,
      );
      
      expect(
        isValidBitcoinTransactionID('0000000000000000000000000000000000000000000000000000000000000000'),
        isTrue,
      );
      
      expect(
        isValidBitcoinTransactionID('ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff'),
        isTrue,
      );
    });

    test('should reject transaction IDs with incorrect length', () {
      // Too short (63 chars)
      expect(
        isValidBitcoinTransactionID('e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b85'),
        isFalse,
      );
      
      // Too long (65 chars)
      expect(
        isValidBitcoinTransactionID('e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b8555'),
        isFalse,
      );
    });

    test('should reject non-hexadecimal characters', () {
      expect(
        isValidBitcoinTransactionID('g3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855'),
        isFalse,
      );
      
      expect(
        isValidBitcoinTransactionID('e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b85z'),
        isFalse,
      );
    });

    test('should handle edge cases', () {
      expect(isValidBitcoinTransactionID(''), isFalse);
      expect(isValidBitcoinTransactionID('not-a-txid'), isFalse);
      expect(isValidBitcoinTransactionID(null), isFalse);
    });

    test('should handle uppercase and lowercase', () {
      // Most implementations accept both cases
      expect(
        isValidBitcoinTransactionID('E3B0C44298FC1C149AFBF4C8996FB92427AE41E4649B934CA495991B7852B855'),
        isTrue,
      );
      
      expect(
        isValidBitcoinTransactionID('E3b0c44298FC1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855'),
        isTrue,
      );
    });
  });

  group('Bitcoin Validation - Lightning Network Invoices', () {
    test('should validate correct Lightning invoices', () {
      // Valid Lightning invoices start with 'lnbc' (mainnet) or 'lntb' (testnet)
      expect(
        isStringALNInvoice('lnbc10u1p3pj257pp5qqqsyqcyq5rqwzqfqqqsyqcyq5rqwzqfqqqsyqcyq5rqwzqfqypqdpl2pkx2ctnv5sxxmmwwd5kgetjypeh2ursdae8g6twvus8g6rfwvs8qun0dfjkxaq8rkx3yf5tcsyz3d73gafnh3cax9rn449d9p5uxz9ezhhypd0elx87sjle52x86fux2ypatgddc6k63n7erqz25le42c4u4ecky03ylcqca784w'),
        isTrue,
      );
    });

    test('should validate testnet Lightning invoices', () {
      expect(
        isStringALNInvoice('lntb10u1p3pj257pp5qqqsyqcyq5rqwzqfqqqsyqcyq5rqwzqfqqqsyqcyq5rqwzqfqypqdpl2pkx2ctnv5sxxmmw'),
        isTrue,
      );
    });

    test('should validate regtest Lightning invoices', () {
      expect(
        isStringALNInvoice('lnbcrt10u1p3pj257pp5qqqsyqcyq5rqwzqfqqqsyqcyq5rqwzqfqqqsyqcyq5rqwzqfqypqdpl2pkx2'),
        isTrue,
      );
    });

    test('should reject invalid Lightning invoice prefixes', () {
      expect(isStringALNInvoice('invalid10u1p3pj257pp5qqqsyqcyq5'), isFalse);
      expect(isStringALNInvoice('btc10u1p3pj257pp5qqqsyqcyq5'), isFalse);
      expect(isStringALNInvoice('lightning:lnbc10u1p3pj257pp5'), isFalse);
    });

    test('should handle edge cases', () {
      expect(isStringALNInvoice(''), isFalse);
      expect(isStringALNInvoice('lnbc'), isFalse); // Too short
      expect(isStringALNInvoice('LNBC10u1p3pj257pp5'), isTrue); // Uppercase should work
    });
  });

  group('Bitcoin Validation - Lightning Address (Email Format)', () {
    test('should validate correct Lightning addresses', () {
      expect(isLightningAdressAsMail('satoshi@bitcoin.org'), isTrue);
      expect(isLightningAdressAsMail('user@getalby.com'), isTrue);
      expect(isLightningAdressAsMail('alice@strike.me'), isTrue);
      expect(isLightningAdressAsMail('bob123@wallet.provider'), isTrue);
    });

    test('should validate addresses with special characters', () {
      expect(isLightningAdressAsMail('user.name@domain.com'), isTrue);
      expect(isLightningAdressAsMail('user+tag@domain.com'), isTrue);
      expect(isLightningAdressAsMail('user_name@domain.com'), isTrue);
      expect(isLightningAdressAsMail('user-name@domain.com'), isTrue);
    });

    test('should reject invalid email formats', () {
      expect(isLightningAdressAsMail('notanemail'), isFalse);
      expect(isLightningAdressAsMail('@domain.com'), isFalse);
      expect(isLightningAdressAsMail('user@'), isFalse);
      expect(isLightningAdressAsMail('user@@domain.com'), isFalse);
      expect(isLightningAdressAsMail('user@domain'), isFalse); // Missing TLD
    });

    test('should handle edge cases', () {
      expect(isLightningAdressAsMail(''), isFalse);
      expect(isLightningAdressAsMail(' '), isFalse);
      expect(isLightningAdressAsMail('user @domain.com'), isFalse); // Space
      expect(isLightningAdressAsMail('user@domain .com'), isFalse); // Space
    });

    test('should validate international domains', () {
      expect(isLightningAdressAsMail('user@domain.co.uk'), isTrue);
      expect(isLightningAdressAsMail('user@subdomain.domain.com'), isTrue);
      expect(isLightningAdressAsMail('user@domain.xyz'), isTrue);
    });
  });

  group('Bitcoin Validation - BIP21 URIs', () {
    test('should validate BIP21 URIs with BOLT11 invoice', () {
      expect(
        isBip21WithBolt11('bitcoin:bc1qxy2kgdygjrsqtzq2n0yrf2493p83kkfjhx0wlh?lightning=lnbc10u1p3pj257pp5'),
        isTrue,
      );
      
      expect(
        isBip21WithBolt11('bitcoin:1A1zP1eP5QGefi2DMPTfTL5SLmv7DivfNa?amount=0.001&lightning=lnbc1000n1p3pj257pp5'),
        isTrue,
      );
    });

    test('should validate BIP21 URIs with BOLT12 offer', () {
      expect(
        isBip21WithBolt12('bitcoin:bc1qxy2kgdygjrsqtzq2n0yrf2493p83kkfjhx0wlh?lightning=lno1pg257pp5'),
        isTrue,
      );
    });

    test('should reject BIP21 URIs without lightning parameter', () {
      expect(
        isBip21WithBolt11('bitcoin:bc1qxy2kgdygjrsqtzq2n0yrf2493p83kkfjhx0wlh'),
        isFalse,
      );
      
      expect(
        isBip21WithBolt11('bitcoin:bc1qxy2kgdygjrsqtzq2n0yrf2493p83kkfjhx0wlh?amount=0.001'),
        isFalse,
      );
    });

    test('should reject invalid URI formats', () {
      expect(isBip21WithBolt11(''), isFalse);
      expect(isBip21WithBolt11('notbitcoin:address'), isFalse);
      expect(isBip21WithBolt11('bitcoin:'), isFalse);
      expect(isBip21WithBolt11('lightning=lnbc10u1p3pj257pp5'), isFalse);
    });

    test('should handle complex URIs with multiple parameters', () {
      expect(
        isBip21WithBolt11('bitcoin:bc1qxy2kgdygjrsqtzq2n0yrf2493p83kkfjhx0wlh?amount=0.001&label=Coffee&message=Thanks&lightning=lnbc1000n1p3pj257pp5'),
        isTrue,
      );
    });

    test('should be case insensitive for scheme', () {
      expect(
        isBip21WithBolt11('BITCOIN:bc1qxy2kgdygjrsqtzq2n0yrf2493p83kkfjhx0wlh?lightning=lnbc10u1p3pj257pp5'),
        isTrue,
      );
      
      expect(
        isBip21WithBolt11('Bitcoin:bc1qxy2kgdygjrsqtzq2n0yrf2493p83kkfjhx0wlh?lightning=lnbc10u1p3pj257pp5'),
        isTrue,
      );
    });
  });

  group('Bitcoin Validation - Additional Helper Functions', () {
    test('should check for exactly six consecutive integers', () {
      expect(containsSixIntegers('123456'), isTrue);
      expect(containsSixIntegers('abc123456xyz'), isTrue);
      expect(containsSixIntegers('12345'), isFalse); // Too few
      expect(containsSixIntegers('1234567'), isFalse); // Too many
      expect(containsSixIntegers('123 456'), isFalse); // Space breaks sequence
      expect(containsSixIntegers(''), isFalse);
    });

    test('should validate Bitcoin address hashes', () {
      // This function would validate various Bitcoin address formats
      // Test P2PKH addresses (start with 1)
      expect(
        isValidBitcoinAddressHash('1A1zP1eP5QGefi2DMPTfTL5SLmv7DivfNa'),
        isTrue,
      );
      
      // Test P2SH addresses (start with 3)
      expect(
        isValidBitcoinAddressHash('3J98t1WpEZ73CNmQviecrnyiWrnqRhWNLy'),
        isTrue,
      );
      
      // Test Bech32 addresses (start with bc1)
      expect(
        isValidBitcoinAddressHash('bc1qxy2kgdygjrsqtzq2n0yrf2493p83kkfjhx0wlh'),
        isTrue,
      );
      
      // Test invalid addresses
      expect(isValidBitcoinAddressHash(''), isFalse);
      expect(isValidBitcoinAddressHash('invalid-address'), isFalse);
      expect(isValidBitcoinAddressHash('0x742d35Cc6634C0532925a3b844Bc9e7595F715a3'), isFalse); // Ethereum address
    });
  });
}