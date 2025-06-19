import 'package:flutter_test/flutter_test.dart';
import 'package:bitnet/backbone/helper/currency/currency_converter.dart';
import 'package:bitnet/models/currency/bitcoinunitmodel.dart';

/// Unit tests for currency conversion functions
/// 
/// These tests verify the accuracy of Bitcoin unit conversions and
/// currency exchange calculations used throughout the BitNET app.
/// 
/// Test categories:
/// 1. Bitcoin to Satoshi conversion
/// 2. Satoshi to Bitcoin conversion
/// 3. Currency exchange rate conversions
/// 4. Smart unit selection based on amount
void main() {
  group('CurrencyConverter - Bitcoin to Satoshi Conversion', () {
    test('should convert whole bitcoins correctly', () {
      // Test standard whole bitcoin amounts
      expect(CurrencyConverter.convertBitcoinToSats(1.0), equals(100000000));
      expect(CurrencyConverter.convertBitcoinToSats(2.0), equals(200000000));
      expect(CurrencyConverter.convertBitcoinToSats(0.5), equals(50000000));
    });

    test('should handle the smallest bitcoin unit (1 satoshi)', () {
      // 1 satoshi = 0.00000001 BTC
      expect(CurrencyConverter.convertBitcoinToSats(0.00000001), equals(1));
    });

    test('should handle zero correctly', () {
      expect(CurrencyConverter.convertBitcoinToSats(0.0), equals(0));
    });

    test('should handle maximum bitcoin supply', () {
      // Maximum bitcoin supply is 21 million
      expect(CurrencyConverter.convertBitcoinToSats(21000000), equals(2100000000000000));
    });

    test('should handle decimal precision correctly', () {
      // Test various decimal places
      // Note: Results are rounded since satoshis are indivisible
      expect(CurrencyConverter.convertBitcoinToSats(0.123456789), equals(12345679.0));
      expect(CurrencyConverter.convertBitcoinToSats(0.00000123), equals(123.0));
    });

    test('should handle negative values', () {
      // Negative values might occur in fee calculations
      expect(CurrencyConverter.convertBitcoinToSats(-1.0), equals(-100000000));
      expect(CurrencyConverter.convertBitcoinToSats(-0.00000001), equals(-1));
    });
  });

  group('CurrencyConverter - Satoshi to Bitcoin Conversion', () {
    test('should convert satoshis to bitcoin correctly', () {
      // Test standard satoshi amounts
      expect(CurrencyConverter.convertSatoshiToBTC(100000000), equals(1.0));
      expect(CurrencyConverter.convertSatoshiToBTC(50000000), equals(0.5));
      expect(CurrencyConverter.convertSatoshiToBTC(1), equals(0.00000001));
    });

    test('should handle zero correctly', () {
      expect(CurrencyConverter.convertSatoshiToBTC(0), equals(0.0));
    });

    test('should handle maximum satoshi amount', () {
      // 21 million BTC in satoshis
      expect(CurrencyConverter.convertSatoshiToBTC(2100000000000000), equals(21000000.0));
    });

    test('should maintain precision for small amounts', () {
      // Test precision for micropayments
      expect(CurrencyConverter.convertSatoshiToBTC(123), equals(0.00000123));
      expect(CurrencyConverter.convertSatoshiToBTC(12345678), equals(0.12345678));
    });

    test('should handle negative satoshi values', () {
      expect(CurrencyConverter.convertSatoshiToBTC(-100000000), equals(-1.0));
      expect(CurrencyConverter.convertSatoshiToBTC(-1), equals(-0.00000001));
    });
  });

  group('CurrencyConverter - Currency Exchange Conversions', () {
    test('should convert BTC to USD correctly', () {
      // Test with a known bitcoin price
      final btcPrice = 50000.0; // $50,000 per BTC
      
      // Based on the implementation, BTC to other currency multiplies by bitcoin price
      final result1 = CurrencyConverter.convertCurrency('BTC', 1.0, 'USD', btcPrice);
      expect(double.parse(result1), equals(50000.0));
      
      final result2 = CurrencyConverter.convertCurrency('BTC', 0.1, 'USD', btcPrice);
      expect(double.parse(result2), closeTo(5000.0, 0.00000001));
    });

    test('should convert USD to BTC correctly', () {
      final btcPrice = 50000.0;
      
      // USD to BTC divides by bitcoin price
      final result1 = CurrencyConverter.convertCurrency('USD', 50000.0, 'BTC', btcPrice);
      expect(double.parse(result1), equals(1.0));
      
      final result2 = CurrencyConverter.convertCurrency('USD', 100.0, 'BTC', btcPrice);
      expect(double.parse(result2), equals(0.002));
    });

    test('should handle same currency conversion', () {
      // Converting same currency returns amount with 2 decimal places
      final result1 = CurrencyConverter.convertCurrency('BTC', 1.5, 'BTC', 50000.0);
      expect(result1, equals('1.50'));
      
      final result2 = CurrencyConverter.convertCurrency('USD', 100.0, 'USD', 50000.0);
      expect(result2, equals('100.00'));
    });

    test('should handle null bitcoin price gracefully', () {
      // When bitcoin price is null, conversions involving BTC should throw exception
      expect(
        () => CurrencyConverter.convertCurrency('BTC', 1.0, 'USD', null),
        throwsException,
      );
    });

    test('should convert to SAT correctly', () {
      final btcPrice = 50000.0;
      
      // USD to SAT: (amount / bitcoinPrice * 100000000)
      final result = CurrencyConverter.convertCurrency('USD', 50.0, 'SAT', btcPrice);
      expect(double.parse(result), equals(100000.0)); // 50 USD = 0.001 BTC = 100,000 sats
    });
  });

  group('CurrencyConverter - Unit Tests', () {
    test('should handle BTC unit correctly', () {
      // Since only BTC and SAT units exist, test basic conversions
      expect(BitcoinUnits.BTC.toString(), contains('BTC'));
      expect(BitcoinUnits.SAT.toString(), contains('SAT'));
    });

    test('should convert between BTC and SAT units', () {
      // Test BTC to SAT conversion
      final btcAmount = 1.0; // 1 BTC
      final satsAmount = CurrencyConverter.convertBitcoinToSats(btcAmount);
      expect(satsAmount, equals(100000000)); // 1 BTC = 100M sats
      
      // Test SAT to BTC conversion
      final satsInput = 100000000.0; // 100M sats
      final btcResult = CurrencyConverter.convertSatoshiToBTC(satsInput);
      expect(btcResult, equals(1.0)); // 100M sats = 1 BTC
    });

    test('should handle very small BTC amounts', () {
      // 1 satoshi in BTC
      final oneSatInBTC = 0.00000001;
      final result = CurrencyConverter.convertBitcoinToSats(oneSatInBTC);
      expect(result, equals(1));
    });

    test('should handle large SAT amounts', () {
      // 21 million BTC in sats (max supply)
      final maxSupplyInSats = 2100000000000000.0;
      final result = CurrencyConverter.convertSatoshiToBTC(maxSupplyInSats);
      expect(result, equals(21000000.0));
    });
    
    test('should handle convertToBitcoinUnit method', () {
      // Test conversion from SAT to BTC when amount > 100k sats
      final result1 = CurrencyConverter.convertToBitcoinUnit(150000, BitcoinUnits.SAT);
      expect(result1.bitcoinUnit, equals(BitcoinUnits.BTC));
      expect(result1.amount, closeTo(0.0015, 0.00000001));
      
      // Test conversion from BTC to SAT when amount < 0.001
      final result2 = CurrencyConverter.convertToBitcoinUnit(0.0005, BitcoinUnits.BTC);
      expect(result2.bitcoinUnit, equals(BitcoinUnits.SAT));
      expect(result2.amount, equals(50000));
      
      // Test no conversion when conditions aren't met
      final result3 = CurrencyConverter.convertToBitcoinUnit(50000, BitcoinUnits.SAT);
      expect(result3.bitcoinUnit, equals(BitcoinUnits.SAT));
      expect(result3.amount, equals(50000));
    });
  });

  group('CurrencyConverter - Real-World Transaction Amounts', () {
    test('should handle typical Lightning micropayments', () {
      // Lightning Network micropayments (1-1000 sats)
      expect(CurrencyConverter.convertBitcoinToSats(0.00000001), equals(1)); // 1 sat
      expect(CurrencyConverter.convertBitcoinToSats(0.00000021), equals(21)); // 21 sats
      expect(CurrencyConverter.convertBitcoinToSats(0.00001000), equals(1000)); // 1000 sats
      
      // Round trip verification
      expect(CurrencyConverter.convertSatoshiToBTC(CurrencyConverter.convertBitcoinToSats(0.00000021)), equals(0.00000021));
    });

    test('should handle typical onchain transaction amounts', () {
      // Common onchain amounts (0.001 - 1 BTC)
      expect(CurrencyConverter.convertBitcoinToSats(0.001), equals(100000)); // 100k sats
      expect(CurrencyConverter.convertBitcoinToSats(0.01), equals(1000000)); // 1M sats
      expect(CurrencyConverter.convertBitcoinToSats(0.1), equals(10000000)); // 10M sats
      expect(CurrencyConverter.convertBitcoinToSats(1.0), equals(100000000)); // 100M sats
      
      // Round trip verification
      expect(CurrencyConverter.convertSatoshiToBTC(CurrencyConverter.convertBitcoinToSats(0.123)), equals(0.123));
    });

    test('should handle dust limit calculations', () {
      // Bitcoin dust limit (~546 sats for P2PKH)
      expect(CurrencyConverter.convertBitcoinToSats(0.00000546), equals(546));
      expect(CurrencyConverter.convertSatoshiToBTC(546), equals(0.00000546));
      
      // Lightning dust limit (~1000 sats)
      expect(CurrencyConverter.convertBitcoinToSats(0.00001000), equals(1000));
      expect(CurrencyConverter.convertSatoshiToBTC(1000), equals(0.00001000));
    });

    test('should handle fee calculations accurately', () {
      // Typical transaction fees (1-100 sats/vB)
      final feePerByte = 10; // 10 sats/vB
      final txSize = 250; // 250 vB transaction
      final totalFeeInSats = feePerByte * txSize; // 2500 sats
      final totalFeeInBTC = 0.000025; // 2500 sats in BTC
      
      expect(CurrencyConverter.convertBitcoinToSats(totalFeeInBTC), equals(2500));
      expect(CurrencyConverter.convertSatoshiToBTC(totalFeeInSats.toDouble()), equals(totalFeeInBTC));
    });
  });

  group('CurrencyConverter - Precision and Rounding Tests', () {
    test('should handle 8 decimal places precision correctly', () {
      // Bitcoin supports up to 8 decimal places (1 satoshi precision)
      expect(CurrencyConverter.convertBitcoinToSats(1.12345678), equals(112345678));
      expect(CurrencyConverter.convertBitcoinToSats(0.12345678), equals(12345678));
      expect(CurrencyConverter.convertBitcoinToSats(0.01234567), equals(1234567));
      expect(CurrencyConverter.convertBitcoinToSats(0.00123456), equals(123456));
      expect(CurrencyConverter.convertBitcoinToSats(0.00012345), equals(12345));
      expect(CurrencyConverter.convertBitcoinToSats(0.00001234), equals(1234));
      expect(CurrencyConverter.convertBitcoinToSats(0.00000123), equals(123));
      expect(CurrencyConverter.convertBitcoinToSats(0.00000012), equals(12));
      expect(CurrencyConverter.convertBitcoinToSats(0.00000001), equals(1));
    });

    test('should round correctly when precision exceeds 8 decimal places', () {
      // More than 8 decimal places should be rounded to nearest satoshi
      expect(CurrencyConverter.convertBitcoinToSats(0.123456789), equals(12345679)); // rounds up
      expect(CurrencyConverter.convertBitcoinToSats(0.123456781), equals(12345678)); // rounds down
      expect(CurrencyConverter.convertBitcoinToSats(0.000000015), equals(1)); // 1.5 sats rounds to 1 (banker's rounding)
      expect(CurrencyConverter.convertBitcoinToSats(0.000000014), equals(1)); // 1.4 sats rounds to 1
    });

    test('should handle floating point precision issues', () {
      // These are the types of values that caused the original floating point errors
      expect(CurrencyConverter.convertBitcoinToSats(0.1 + 0.2), equals(30000000)); // Should be exactly 30M sats
      expect(CurrencyConverter.convertBitcoinToSats(1.1), equals(110000000)); // Should be exactly 110M sats
      expect(CurrencyConverter.convertBitcoinToSats(2.1), equals(210000000)); // Should be exactly 210M sats
      
      // Test the specific case that was failing in the original test
      expect(CurrencyConverter.convertBitcoinToSats(1.23456789), equals(123456789)); // Should be whole number
    });

    test('should maintain precision in round-trip conversions', () {
      final testValues = [
        0.00000001, // 1 sat
        0.00000123, // 123 sats
        0.00012345, // 12345 sats
        0.01234567, // 1234567 sats
        0.12345678, // 12345678 sats
        1.23456789, // 123456789 sats (will be rounded)
        0.5, // 50M sats
        1.0, // 100M sats
        21.0, // 2.1B sats
      ];
      
      for (final btcValue in testValues) {
        final sats = CurrencyConverter.convertBitcoinToSats(btcValue);
        final backToBtc = CurrencyConverter.convertSatoshiToBTC(sats);
        
        // Allow for rounding when original has more than 8 decimal places
        if (btcValue.toString().split('.').length > 1 && 
            btcValue.toString().split('.')[1].length > 8) {
          expect(backToBtc, closeTo(btcValue, 0.00000001));
        } else {
          expect(backToBtc, equals(btcValue));
        }
      }
    });
  });

  group('CurrencyConverter - Boundary Value Testing', () {
    test('should handle boundary values correctly', () {
      // Test values at conversion boundaries used in convertToBitcoinUnit
      
      // 100k sats boundary (SAT to BTC conversion threshold)
      expect(CurrencyConverter.convertBitcoinToSats(0.001), equals(100000)); // Exactly 100k sats
      expect(CurrencyConverter.convertSatoshiToBTC(100000), equals(0.001));
      expect(CurrencyConverter.convertBitcoinToSats(0.0009999), equals(99990)); // Just under 100k
      expect(CurrencyConverter.convertBitcoinToSats(0.0010001), equals(100010)); // Just over 100k
      
      // 0.001 BTC boundary (BTC to SAT conversion threshold)
      expect(CurrencyConverter.convertSatoshiToBTC(99999), equals(0.00099999)); // Just under 0.001 BTC
      expect(CurrencyConverter.convertSatoshiToBTC(100001), equals(0.00100001)); // Just over 0.001 BTC
    });

    test('should handle maximum theoretical bitcoin values', () {
      // Maximum possible bitcoin supply (21 million BTC)
      final maxSupply = 21000000.0;
      final maxSupplyInSats = 2100000000000000.0; // 21M * 100M
      
      expect(CurrencyConverter.convertBitcoinToSats(maxSupply), equals(maxSupplyInSats));
      expect(CurrencyConverter.convertSatoshiToBTC(maxSupplyInSats), equals(maxSupply));
      
      // Slightly over max supply (should still work mathematically)
      expect(CurrencyConverter.convertBitcoinToSats(25000000.0), equals(2500000000000000.0));
    });

    test('should handle minimum and maximum safe integer values', () {
      // Test near JavaScript/Dart safe integer limits
      final nearMaxSafeInt = 9007199254740990.0; // Close to 2^53 - 2
      final correspondingBTC = nearMaxSafeInt / 100000000;
      
      expect(CurrencyConverter.convertBitcoinToSats(correspondingBTC), closeTo(nearMaxSafeInt, 1.0));
      expect(CurrencyConverter.convertSatoshiToBTC(nearMaxSafeInt), equals(correspondingBTC));
    });
  });

  group('CurrencyConverter - Common App Usage Scenarios', () {
    test('should handle invoice generation amounts', () {
      // Common Lightning invoice amounts
      final invoiceAmounts = [
        0.00001000, // 1000 sats (coffee)
        0.00010000, // 10k sats (small purchase)
        0.00100000, // 100k sats (medium purchase)
        0.01000000, // 1M sats (large purchase)
      ];
      
      for (final amount in invoiceAmounts) {
        final sats = CurrencyConverter.convertBitcoinToSats(amount);
        final backToBtc = CurrencyConverter.convertSatoshiToBTC(sats);
        expect(backToBtc, equals(amount));
        expect(sats % 1, equals(0)); // Should be whole satoshis
      }
    });

    test('should handle balance display conversions', () {
      // Wallet balance scenarios
      final balances = [
        0.00000547, // Just above dust
        0.00001000, // 1k sats
        0.00100000, // 100k sats
        0.01000000, // 1M sats
        0.10000000, // 10M sats
        1.00000000, // 100M sats
      ];
      
      for (final balance in balances) {
        final sats = CurrencyConverter.convertBitcoinToSats(balance);
        final displayBalance = CurrencyConverter.convertSatoshiToBTC(sats);
        
        expect(displayBalance, equals(balance));
        expect(sats, greaterThan(0));
        expect(sats % 1, equals(0)); // Should be whole satoshis
      }
    });

    test('should handle payment amount calculations', () {
      // Payment scenarios with fees
      final baseAmount = 0.001; // 100k sats
      final feeRate = 0.00000010; // 10 sats per vB
      final estimatedSize = 250; // vB
      final estimatedFee = feeRate * estimatedSize; // 25 sats
      final totalAmount = baseAmount + estimatedFee;
      
      final baseAmountSats = CurrencyConverter.convertBitcoinToSats(baseAmount);
      final estimatedFeeSats = CurrencyConverter.convertBitcoinToSats(estimatedFee);
      final totalAmountSats = CurrencyConverter.convertBitcoinToSats(totalAmount);
      
      expect(baseAmountSats, equals(100000));
      expect(estimatedFeeSats, equals(2500));
      expect(totalAmountSats, equals(102500));
      
      // Verify round trip
      expect(CurrencyConverter.convertSatoshiToBTC(totalAmountSats), equals(totalAmount));
    });
  });

  group('CurrencyConverter - Edge Cases and Error Handling', () {
    test('should handle extremely small amounts', () {
      // Test with amounts smaller than 1 satoshi
      expect(
        CurrencyConverter.convertBitcoinToSats(0.000000001), // 0.1 satoshi
        equals(0.0), // Should round to 0
      );
      
      expect(
        CurrencyConverter.convertBitcoinToSats(0.000000005), // 0.5 satoshi
        equals(1.0), // Should round to 1
      );
      
      expect(
        CurrencyConverter.convertBitcoinToSats(0.000000004), // 0.4 satoshi
        equals(0.0), // Should round to 0
      );
    });

    test('should handle extremely large amounts', () {
      // Test with amounts larger than total bitcoin supply
      expect(
        CurrencyConverter.convertBitcoinToSats(100000000), // 100M BTC
        equals(10000000000000000), // 10 quadrillion sats
      );
      
      // Test with very large amounts
      expect(
        CurrencyConverter.convertBitcoinToSats(1000000000), // 1B BTC
        equals(100000000000000000), // 100 quadrillion sats
      );
    });

    test('should handle negative values consistently', () {
      // Test negative conversions (for fee calculations, etc.)
      final testCases = [
        -0.00000001, // -1 sat
        -0.00000123, // -123 sats
        -0.001, // -100k sats
        -1.0, // -100M sats
        -21.0, // -21 BTC
      ];
      
      for (final btcValue in testCases) {
        final sats = CurrencyConverter.convertBitcoinToSats(btcValue);
        final backToBtc = CurrencyConverter.convertSatoshiToBTC(sats);
        
        expect(sats, lessThan(0));
        expect(backToBtc, equals(btcValue));
      }
    });

    test('should handle special float values', () {
      // The implementation doesn't throw errors for special values
      // It returns the mathematical result
      expect(
        CurrencyConverter.convertBitcoinToSats(double.infinity),
        equals(double.infinity),
      );
      
      expect(
        CurrencyConverter.convertBitcoinToSats(double.negativeInfinity),
        equals(double.negativeInfinity),
      );
      
      expect(
        CurrencyConverter.convertBitcoinToSats(double.nan).isNaN,
        isTrue,
      );
      
      // Test with very small denormal numbers
      expect(
        CurrencyConverter.convertBitcoinToSats(double.minPositive),
        equals(0.0), // Should round to 0
      );
    });

    test('should handle conversion consistency across all decimal places', () {
      // Test all possible decimal place combinations
      for (int i = 1; i <= 8; i++) {
        final factor = 1.0 / (10.0 * i);
        final testValue = 1.23456789 * factor;
        
        final sats = CurrencyConverter.convertBitcoinToSats(testValue);
        final backToBtc = CurrencyConverter.convertSatoshiToBTC(sats);
        
        // Should maintain precision within satoshi accuracy
        expect((backToBtc - testValue).abs(), lessThanOrEqualTo(0.00000001));
      }
    });
  });
}