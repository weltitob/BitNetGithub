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
      expect(CurrencyConverter.convertBitcoinToSats(0.123456789), equals(12345678.9));
      expect(CurrencyConverter.convertBitcoinToSats(0.00000123), equals(123));
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

  group('CurrencyConverter - Edge Cases and Error Handling', () {
    test('should handle extremely small amounts', () {
      // Test with amounts smaller than 1 satoshi
      expect(
        CurrencyConverter.convertBitcoinToSats(0.000000001), // 0.1 satoshi
        equals(0.1),
      );
    });

    test('should handle extremely large amounts', () {
      // Test with amounts larger than total bitcoin supply
      expect(
        CurrencyConverter.convertBitcoinToSats(100000000), // 100M BTC
        equals(10000000000000000), // 10 quadrillion sats
      );
    });

    test('should handle special float values', () {
      // The implementation doesn't throw errors for special values
      // It returns the mathematical result
      expect(
        CurrencyConverter.convertBitcoinToSats(double.infinity),
        equals(double.infinity),
      );
      
      expect(
        CurrencyConverter.convertBitcoinToSats(double.nan).isNaN,
        isTrue,
      );
    });
  });
}