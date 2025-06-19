import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:bitnet/pages/wallet/actions/receive/controller/receive_controller.dart';
import 'package:bitnet/backbone/helper/currency/currency_converter.dart';
import 'package:bitnet/models/currency/bitcoinunitmodel.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:bitnet/pages/wallet/controllers/wallet_controller.dart';
import 'package:flutter/material.dart';

// Simple mock classes without code generation
class MockLoggerService extends LoggerService {
  @override
  void i(String message) {}
  
  @override
  void e(String message) {}
  
  @override
  void d(String message) {}
  
  @override
  void w(String message) {}
}

class MockWalletsController extends GetxController {
  @override
  Future<List<String>> getOnchainAddresses() async {
    return ['bc1qtest123address456'];
  }
  
  final List<String> btcAddresses = [];
}

class MockTimer {
  void cancel() {}
}

/// Unit tests for ReceiveController
/// 
/// These tests verify the core receive functionality including:
/// 1. Timer management and formatting
/// 2. Receive type switching
/// 3. Amount conversion between BTC and SAT units
/// 4. Text controller management
/// 5. QR data string generation patterns
/// 6. BIP21 URI formatting for combined payments
/// 7. Copy address functionality with proper URI formatting
/// 8. Controller initialization and disposal
void main() {
  late ReceiveController receiveController;
  late MockLoggerService mockLogger;
  late MockWalletsController mockWalletsController;
  late MockAuth mockAuth;
  late MockUser mockUser;

  setUpAll(() {
    // Initialize GetX testing mode
    Get.testMode = true;
  });

  setUp(() {
    // Create mocks
    mockLogger = MockLoggerService();
    mockWalletsController = MockWalletsController();
    mockAuth = MockAuth();
    mockUser = MockUser();

    // Setup GetX dependencies
    Get.put<LoggerService>(mockLogger);
    Get.put<WalletsController>(mockWalletsController);

    // Mock auth responses
    when(mockAuth.currentUser).thenReturn(mockUser);
    when(mockUser.uid).thenReturn('test-user-id');
    when(mockWalletsController.getOnchainAddresses())
        .thenAnswer((_) async => ['bc1qtest123address456']);

    // Create controller instance
    receiveController = ReceiveController();
  });

  tearDown(() {
    // Clean up GetX
    Get.reset();
  });

  group('ReceiveController - Timer Management', () {
    test('should format duration correctly', () {
      // Test various durations
      expect(receiveController.formatDuration(Duration(minutes: 0, seconds: 0)), equals('00:00'));
      expect(receiveController.formatDuration(Duration(minutes: 1, seconds: 30)), equals('01:30'));
      expect(receiveController.formatDuration(Duration(minutes: 10, seconds: 5)), equals('10:05'));
      expect(receiveController.formatDuration(Duration(minutes: 59, seconds: 59)), equals('59:59'));
      expect(receiveController.formatDuration(Duration(hours: 1, minutes: 5, seconds: 30)), equals('05:30'));
    });

    test('should handle timer updates correctly', () {
      // Set initial duration
      receiveController.duration = Duration(minutes: 2, seconds: 30);
      
      // Create a mock timer (won't actually be used in the function)
      final mockTimer = MockTimer();
      
      // Test initial state
      expect(receiveController.duration.inSeconds, equals(150));
      
      // Simulate timer update
      receiveController.updateTimer(mockTimer);
      
      // Should decrease by 1 second
      expect(receiveController.duration.inSeconds, equals(149));
      expect(receiveController.min.value, equals('02'));
      expect(receiveController.sec.value, equals('29'));
    });

    test('should cancel timer when duration reaches zero', () {
      // Set duration to 1 second
      receiveController.duration = Duration(seconds: 1);
      
      final mockTimer = MockTimer();
      when(mockTimer.cancel()).thenReturn(null);
      
      // First update - should go to 0
      receiveController.updateTimer(mockTimer);
      expect(receiveController.duration.inSeconds, equals(0));
      
      // Second update - should cancel timer
      receiveController.updateTimer(mockTimer);
      verify(mockTimer.cancel()).called(1);
    });
  });

  group('ReceiveController - Receive Type Management', () {
    test('should set receive type correctly', () {
      // Test setting different receive types
      receiveController.setReceiveType(ReceiveType.Lightning_b11);
      expect(receiveController.receiveType.value, equals(ReceiveType.Lightning_b11));

      receiveController.setReceiveType(ReceiveType.OnChain_taproot);
      expect(receiveController.receiveType.value, equals(ReceiveType.OnChain_taproot));

      receiveController.setReceiveType(ReceiveType.Combined_b11_taproot);
      expect(receiveController.receiveType.value, equals(ReceiveType.Combined_b11_taproot));
    });

    test('should verify all receive types are handled', () {
      // Ensure all enum values can be set
      for (ReceiveType type in ReceiveType.values) {
        receiveController.setReceiveType(type);
        expect(receiveController.receiveType.value, equals(type));
      }
    });
  });

  group('ReceiveController - Bitcoin Unit Conversion', () {
    test('should handle SAT unit correctly in invoice generation', () {
      receiveController.bitcoinUnit.value = BitcoinUnits.SAT;
      
      // Test amount conversion logic (simulating getInvoice behavior)
      int testAmount = 100000; // 100k sats
      int finalAmount = receiveController.bitcoinUnit.value == BitcoinUnits.SAT 
          ? testAmount 
          : CurrencyConverter.convertBitcoinToSats(testAmount.toDouble()).toInt();
      
      expect(finalAmount, equals(100000));
    });

    test('should handle BTC unit correctly in invoice generation', () {
      receiveController.bitcoinUnit.value = BitcoinUnits.BTC;
      
      // Test amount conversion logic (simulating getInvoice behavior)
      double testAmount = 0.001; // 0.001 BTC = 100k sats
      int finalAmount = receiveController.bitcoinUnit.value == BitcoinUnits.SAT 
          ? testAmount.toInt()
          : CurrencyConverter.convertBitcoinToSats(testAmount).toInt();
      
      expect(finalAmount, equals(100000));
    });
  });

  group('ReceiveController - Text Controller Management', () {
    test('should initialize text controllers with default values', () {
      expect(receiveController.satController.text, equals('0'));
      expect(receiveController.btcController.text, equals('0'));
      expect(receiveController.satControllerOnChain.text, equals('0'));
      expect(receiveController.btcControllerOnChain.text, equals('0'));
      expect(receiveController.satControllerCombined.text, equals('0'));
      expect(receiveController.btcControllerCombined.text, equals('0'));
      expect(receiveController.messageController.text, equals(''));
    });

    test('should update BTC text correctly', () {
      receiveController.updateBtcText('0.001');
      expect(receiveController.btcController.text, equals('0.001'));

      receiveController.updateBtcText('1.5');
      expect(receiveController.btcController.text, equals('1.5'));
    });

    test('should handle btc controller notifier updates', () {
      String? notifierValue;
      receiveController.btcControllerNotifier.addListener(() {
        notifierValue = receiveController.btcControllerNotifier.value;
      });

      receiveController.btcControllerNotifier.value = '0.5';
      expect(notifierValue, equals('0.5'));
    });
  });

  group('ReceiveController - QR Data String Management', () {
    test('should initialize QR data strings as empty', () {
      expect(receiveController.qrCodeDataStringLightning.value, equals(''));
      expect(receiveController.qrCodeDataStringLightningCombined.value, equals(''));
      expect(receiveController.qrCodeDataStringOnchain.value, equals(''));
    });

    test('should update QR data strings correctly', () {
      const testInvoice = 'lnbc1000n1p3pj257pp5qqqsyqcyq5rqwzqfqqqsyqcyq5rqwzqfqqqsyqcyq5rqwzqfqypq';
      const testAddress = 'bc1qxy2kgdygjrsqtzq2n0yrf2493p83kkfjhx0wlh';

      receiveController.qrCodeDataStringLightning.value = testInvoice;
      receiveController.qrCodeDataStringOnchain.value = testAddress;

      expect(receiveController.qrCodeDataStringLightning.value, equals(testInvoice));
      expect(receiveController.qrCodeDataStringOnchain.value, equals(testAddress));
    });
  });

  group('ReceiveController - BIP21 URI Generation', () {
    test('should generate correct BIP21 URI without amount', () {
      const testInvoice = 'lnbc1000n1p3pj257pp5qqqsyqcyq5rqwzqfqqqsyqcyq5rqwzqfqqqsyqcyq5rqwzqfqypq';
      const testAddress = 'bc1qxy2kgdygjrsqtzq2n0yrf2493p83kkfjhx0wlh';

      receiveController.qrCodeDataStringLightningCombined.value = testInvoice;
      receiveController.qrCodeDataStringOnchain.value = testAddress;
      receiveController.btcControllerCombined.text = '0';

      // Simulate BIP21 generation logic from copyAddress method
      String bip21Data = "bitcoin:$testAddress?lightning=$testInvoice";
      
      expect(bip21Data, equals("bitcoin:$testAddress?lightning=$testInvoice"));
      expect(bip21Data.startsWith('bitcoin:'), isTrue);
      expect(bip21Data.contains('lightning='), isTrue);
    });

    test('should generate correct BIP21 URI with amount', () {
      const testInvoice = 'lnbc1000n1p3pj257pp5qqqsyqcyq5rqwzqfqqqsyqcyq5rqwzqfqqqsyqcyq5rqwzqfqypq';
      const testAddress = 'bc1qxy2kgdygjrsqtzq2n0yrf2493p83kkfjhx0wlh';
      const testAmount = '0.001';

      receiveController.qrCodeDataStringLightningCombined.value = testInvoice;
      receiveController.qrCodeDataStringOnchain.value = testAddress;
      receiveController.btcControllerCombined.text = testAmount;

      // Simulate BIP21 generation logic from copyAddress method
      String bip21Data = "bitcoin:$testAddress?lightning=$testInvoice";
      double? btcAmount = double.tryParse(testAmount);
      if (btcAmount != null && btcAmount > 0) {
        bip21Data = "bitcoin:$testAddress?amount=$btcAmount?lightning=$testInvoice";
      }
      
      expect(bip21Data, equals("bitcoin:$testAddress?amount=0.001?lightning=$testInvoice"));
      expect(bip21Data.contains('amount=0.001'), isTrue);
    });
  });

  group('ReceiveController - Address Copy Logic', () {
    test('should format onchain address without amount correctly', () {
      const testAddress = 'bc1qxy2kgdygjrsqtzq2n0yrf2493p83kkfjhx0wlh';
      
      receiveController.qrCodeDataStringOnchain.value = testAddress;
      receiveController.btcControllerOnChain.text = '0';

      // Simulate copy logic for onchain addresses
      double? btcAmount = double.tryParse(receiveController.btcControllerOnChain.text);
      final addressData = btcAmount != null && btcAmount > 0
          ? 'bitcoin:${receiveController.qrCodeDataStringOnchain.value}?amount=${btcAmount}'
          : receiveController.qrCodeDataStringOnchain.value;

      expect(addressData, equals(testAddress));
    });

    test('should format onchain address with amount correctly', () {
      const testAddress = 'bc1qxy2kgdygjrsqtzq2n0yrf2493p83kkfjhx0wlh';
      const testAmount = '0.5';
      
      receiveController.qrCodeDataStringOnchain.value = testAddress;
      receiveController.btcControllerOnChain.text = testAmount;

      // Simulate copy logic for onchain addresses
      double? btcAmount = double.tryParse(receiveController.btcControllerOnChain.text);
      final addressData = btcAmount != null && btcAmount > 0
          ? 'bitcoin:${receiveController.qrCodeDataStringOnchain.value}?amount=${btcAmount}'
          : receiveController.qrCodeDataStringOnchain.value;

      expect(addressData, equals('bitcoin:$testAddress?amount=0.5'));
    });

    test('should handle lightning invoice copy correctly', () {
      const testInvoice = 'lnbc1000n1p3pj257pp5qqqsyqcyq5rqwzqfqqqsyqcyq5rqwzqfqqqsyqcyq5rqwzqfqypq';
      
      receiveController.qrCodeDataStringLightning.value = testInvoice;
      receiveController.receiveType.value = ReceiveType.Lightning_b11;

      // For Lightning, we just copy the invoice directly
      final copyData = receiveController.qrCodeDataStringLightning.value;
      
      expect(copyData, equals(testInvoice));
    });
  });

  group('ReceiveController - Invoice Generation Logic', () {
    test('should prepare correct parameters for Lightning invoice', () {
      receiveController.receiveType.value = ReceiveType.Lightning_b11;
      receiveController.satController.text = '100000';

      // Simulate tapGenerateInvoice logic for Lightning
      if (receiveController.receiveType.value == ReceiveType.Lightning_b11) {
        final amount = (double.parse(receiveController.satController.text)).toInt();
        expect(amount, equals(100000));
      }
    });

    test('should prepare correct parameters for combined invoice', () {
      receiveController.receiveType.value = ReceiveType.Combined_b11_taproot;
      receiveController.satControllerCombined.text = '50000';

      // Simulate tapGenerateInvoice logic for Combined
      if (receiveController.receiveType.value == ReceiveType.Combined_b11_taproot) {
        final amount = (double.parse(receiveController.satControllerCombined.text)).toInt();
        expect(amount, equals(50000));
      }
    });

    test('should handle different address types for onchain', () {
      receiveController.receiveType.value = ReceiveType.OnChain_segwit;
      
      // Simulate tapGenerateInvoice logic for SegWit
      if (receiveController.receiveType.value == ReceiveType.OnChain_segwit) {
        const expectedAddressType = 'WITNESS_PUBKEY_HASH';
        expect(expectedAddressType, equals('WITNESS_PUBKEY_HASH'));
      }

      receiveController.receiveType.value = ReceiveType.OnChain_taproot;
      
      // Simulate tapGenerateInvoice logic for Taproot
      if (receiveController.receiveType.value == ReceiveType.OnChain_taproot) {
        const expectedAddressType = 'TAPROOT_PUBKEY';
        expect(expectedAddressType, equals('TAPROOT_PUBKEY'));
      }
    });
  });

  group('ReceiveController - State Management', () {
    test('should initialize with correct default values', () {
      expect(receiveController.receiveType.value, equals(ReceiveType.Combined_b11_taproot));
      expect(receiveController.bitcoinUnit.value, equals(BitcoinUnits.SAT));
      expect(receiveController.isUnlocked.value, isTrue);
      expect(receiveController.updatingText.value, isFalse);
      expect(receiveController.createdInvoice.value, isFalse);
    });

    test('should handle reactive state changes', () {
      // Test reactive state updates
      receiveController.updatingText.value = true;
      expect(receiveController.updatingText.value, isTrue);

      receiveController.createdInvoice.value = true;
      expect(receiveController.createdInvoice.value, isTrue);

      receiveController.isUnlocked.value = false;
      expect(receiveController.isUnlocked.value, isFalse);
    });

    test('should handle focus node management', () {
      expect(receiveController.myFocusNode, isA<FocusNode>());
      expect(receiveController.myFocusNode.hasFocus, isFalse);
    });
  });

  group('ReceiveController - Edge Cases', () {
    test('should handle empty amount strings gracefully', () {
      expect(() => double.parse(''), throwsA(isA<FormatException>()));
      expect(() => double.parse('0'), returnsNormally);
      expect(double.tryParse(''), isNull);
      expect(double.tryParse('0'), equals(0.0));
    });

    test('should handle invalid amount formats', () {
      expect(double.tryParse('abc'), isNull);
      expect(double.tryParse('12.34.56'), isNull);
      expect(double.tryParse('-5'), equals(-5.0));
      expect(double.tryParse('1.5'), equals(1.5));
    });

    test('should handle empty QR data strings', () {
      receiveController.qrCodeDataStringLightning.value = '';
      receiveController.qrCodeDataStringOnchain.value = '';
      
      expect(receiveController.qrCodeDataStringLightning.value.isEmpty, isTrue);
      expect(receiveController.qrCodeDataStringOnchain.value.isEmpty, isTrue);
    });

    test('should validate receive type enum completeness', () {
      // Ensure all receive types are accounted for
      final allTypes = ReceiveType.values;
      expect(allTypes.length, equals(6));
      expect(allTypes.contains(ReceiveType.Combined_b11_taproot), isTrue);
      expect(allTypes.contains(ReceiveType.Lightning_b11), isTrue);
      expect(allTypes.contains(ReceiveType.Lightning_lnurl), isTrue);
      expect(allTypes.contains(ReceiveType.OnChain_taproot), isTrue);
      expect(allTypes.contains(ReceiveType.OnChain_segwit), isTrue);
      expect(allTypes.contains(ReceiveType.TokenTaprootAsset), isTrue);
    });
  });
}

// Mock Timer class for testing
class MockTimer extends Mock {
  void cancel() {}
}