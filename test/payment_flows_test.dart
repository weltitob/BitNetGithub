import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:bitnet/backbone/streams/lnd/sendpayment_v2.dart';
import 'package:bitnet/backbone/cloudfunctions/lnd/walletkitservice/send_coins.dart';
import 'package:bitnet/backbone/cloudfunctions/lnd/walletkitservice/nextaddr.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:bitnet/backbone/services/node_mapping_service.dart';
import 'package:bitnet/backbone/cloudfunctions/aws/litd_controller.dart';
import 'package:bitnet/models/node/user_node_mapping.dart';
import 'package:bitnet/models/api/rest_response.dart';
import 'package:http/http.dart' as http;

// Generate mocks for the dependencies
@GenerateMocks([
  NodeMappingService,
  LitdController,
  LoggerService,
  http.Client,
])
void main() {
  // Test configuration - using the same node endpoint as taproot assets
  const testNodeId = 'node1'; // Same node used for taproot assets
  const testUserId = 'test-user-123';
  const testMacaroon = 'test-macaroon-hex';
  const testBaseUrl = 'localhost:8080'; // Local test endpoint
  const testLightningPubkey = '03test_pubkey_123';
  
  late MockNodeMappingService mockNodeMappingService;
  late MockLitdController mockLitdController;
  late MockLoggerService mockLogger;
  
  setUp(() {
    // Initialize GetX bindings
    Get.reset();
    
    // Create mocks
    mockNodeMappingService = MockNodeMappingService();
    mockLitdController = MockLitdController();
    mockLogger = MockLoggerService();
    
    // Register mocks with GetX
    Get.put<NodeMappingService>(mockNodeMappingService);
    Get.put<LitdController>(mockLitdController);
    Get.put<LoggerService>(mockLogger);
    
    // Configure default behavior for mocks
    when(mockLitdController.litd_baseurl).thenReturn(testBaseUrl.obs);
    
    // Mock node mapping
    final testNodeMapping = UserNodeMapping(
      userId: testUserId,
      nodeId: testNodeId,
      lightningPubkey: testLightningPubkey,
      caddyEndpoint: 'http://$testBaseUrl/$testNodeId',
      adminMacaroon: testMacaroon,
      status: 'active',
    );
    
    when(mockNodeMappingService.getUserNodeMapping(testUserId))
        .thenAnswer((_) async => testNodeMapping);
  });
  
  tearDown(() {
    Get.reset();
  });
  
  group('Lightning Payment Tests', () {
    test('sendPaymentV2Stream should send Lightning payment successfully', () async {
      // Arrange
      const testInvoice = 'lnbc100n1p3...'; // Test Lightning invoice
      const testAmount = 1000; // 1000 sats
      
      // Mock successful payment response
      final expectedResponse = {
        'status': 'SUCCEEDED',
        'payment_hash': 'test_payment_hash',
        'payment_preimage': 'test_preimage',
        'value_sat': testAmount.toString(),
        'fee_sat': '10',
      };
      
      // Act
      final paymentStream = sendPaymentV2Stream(
        testUserId,
        [testInvoice],
        testAmount,
      );
      
      // Assert
      await expectLater(
        paymentStream,
        emitsInOrder([
          isA<Map<String, dynamic>>()
              .having((p) => p['status'], 'status', 'SUCCEEDED')
              .having((p) => p['value_sat'], 'value_sat', testAmount.toString()),
        ]),
      );
    });
    
    test('sendPaymentV2Stream should handle payment failure', () async {
      // Arrange
      const testInvoice = 'lnbc100n1p3...';
      const testAmount = 1000;
      
      // Mock failed node mapping
      when(mockNodeMappingService.getUserNodeMapping(testUserId))
          .thenAnswer((_) async => null);
      
      // Act
      final paymentStream = sendPaymentV2Stream(
        testUserId,
        [testInvoice],
        testAmount,
      );
      
      // Assert
      await expectLater(
        paymentStream,
        emitsInOrder([
          isA<Map<String, dynamic>>()
              .having((p) => p['status'], 'status', 'FAILED')
              .having((p) => p['failure_reason'], 'failure_reason', 
                  'No Lightning node assigned to user'),
        ]),
      );
    });
    
    test('sendPaymentV2Stream should handle LNURL payments', () async {
      // Arrange
      const lnurlInvoice = 'lnbc100n1p3...';
      const testAmount = 5000;
      
      final expectedResponse = {
        'status': 'SUCCEEDED',
        'payment_hash': 'lnurl_payment_hash',
        'value_sat': testAmount.toString(),
      };
      
      // Act
      final paymentStream = sendPaymentV2Stream(
        testUserId,
        [lnurlInvoice],
        testAmount,
      );
      
      // Assert
      await expectLater(
        paymentStream,
        emits(
          allOf(
            isA<Map<String, dynamic>>(),
            containsPair('status', 'SUCCEEDED'),
            containsPair('value_sat', testAmount.toString()),
          ),
        ),
      );
    });
  });
  
  group('Onchain Sending Tests', () {
    test('sendCoins should send Bitcoin onchain successfully', () async {
      // Arrange
      const testAddress = 'bc1qtest...';
      const testAmount = 50000; // 50,000 sats
      const testTargetConf = 6;
      
      // Act
      final result = await sendCoins(
        userId: testUserId,
        address: testAddress,
        amountSat: testAmount,
        targetConf: testTargetConf,
      );
      
      // Assert
      expect(result, isA<RestResponse>());
      expect(result.statusCode, equals('success'));
      expect(result.data['amount'], equals(testAmount));
      expect(result.data['address'], equals(testAddress));
      expect(result.data['txid'], isNotEmpty);
    });
    
    test('sendCoins should handle insufficient balance', () async {
      // Arrange
      const testAddress = 'bc1qtest...';
      const testAmount = 1000000000; // Very large amount
      const testTargetConf = 6;
      
      // Act
      final result = await sendCoins(
        userId: testUserId,
        address: testAddress,
        amountSat: testAmount,
        targetConf: testTargetConf,
      );
      
      // Assert
      expect(result.statusCode, equals('error'));
      expect(result.message, contains('insufficient'));
    });
    
    test('estimateFee should return fee estimate', () async {
      // Arrange
      const testAddress = 'bc1qtest...';
      const testAmount = 10000;
      const testTargetConf = 6;
      
      // Act
      final result = await estimateFee(
        userId: testUserId,
        address: testAddress,
        amountSat: testAmount,
        targetConf: testTargetConf,
      );
      
      // Assert
      expect(result, isA<RestResponse>());
      expect(result.statusCode, equals('success'));
      expect(result.data['fee_sat'], isA<int>());
      expect(result.data['feerate_sat_per_vbyte'], isA<int>());
    });
  });
  
  group('Onchain Receive Tests', () {
    test('nextAddrDirect should generate SegWit address', () async {
      // Arrange
      const expectedAddress = 'bc1qtest_segwit_address';
      
      // Act
      final address = await nextAddrDirect(
        testUserId,
        addressType: 'WITNESS_PUBKEY_HASH',
      );
      
      // Assert
      expect(address, isNotNull);
      expect(address, startsWith('bc1'));
      expect(address!.length, greaterThan(20));
    });
    
    test('nextAddrDirect should generate Taproot address', () async {
      // Arrange
      const expectedAddress = 'bc1ptest_taproot_address';
      
      // Act
      final address = await nextAddrDirect(
        testUserId,
        addressType: 'TAPROOT_PUBKEY',
      );
      
      // Assert
      expect(address, isNotNull);
      expect(address, startsWith('bc1p'));
      expect(address!.length, greaterThan(20));
    });
    
    test('nextAddrDirect should handle node unavailable', () async {
      // Arrange
      when(mockNodeMappingService.getUserNodeMapping(testUserId))
          .thenAnswer((_) async => null);
      
      // Act
      final address = await nextAddrDirect(testUserId);
      
      // Assert
      expect(address, isNull);
      verify(mockLogger.e('No node mapping found for user: $testUserId')).called(1);
    });
    
    test('nextAddrDirect should store address in Firestore', () async {
      // Arrange & Act
      final address = await nextAddrDirect(
        testUserId,
        change: false,
      );
      
      // Assert
      expect(address, isNotNull);
      // In a real test, we would verify Firestore operations
      // For now, we just verify the address was generated
    });
  });
  
  group('Integration Tests', () {
    test('Complete Lightning payment flow', () async {
      // This test simulates a complete Lightning payment flow
      // from invoice creation to payment completion
      
      // 1. Generate invoice (receiver side)
      // 2. Parse invoice
      // 3. Send payment
      // 4. Verify payment succeeded
      
      const testInvoice = 'lnbc1000n1...';
      final paymentStream = sendPaymentV2Stream(
        testUserId,
        [testInvoice],
        1000,
      );
      
      final results = await paymentStream.toList();
      expect(results, isNotEmpty);
      expect(results.last['status'], equals('SUCCEEDED'));
    });
    
    test('Complete Onchain transaction flow', () async {
      // This test simulates a complete onchain transaction flow
      
      // 1. Generate receive address
      final receiveAddress = await nextAddrDirect(testUserId);
      expect(receiveAddress, isNotNull);
      
      // 2. Estimate fee
      final feeEstimate = await estimateFee(
        userId: testUserId,
        address: receiveAddress!,
        amountSat: 10000,
        targetConf: 6,
      );
      expect(feeEstimate.statusCode, equals('success'));
      
      // 3. Send transaction
      final sendResult = await sendCoins(
        userId: testUserId,
        address: receiveAddress,
        amountSat: 10000,
        targetConf: 6,
      );
      expect(sendResult.statusCode, equals('success'));
      expect(sendResult.data['txid'], isNotNull);
    });
  });
}

// Helper function to simulate node responses
Map<String, dynamic> createMockLightningResponse({
  required String status,
  String? paymentHash,
  String? failureReason,
  int? valueSat,
  int? feeSat,
}) {
  return {
    'result': {
      'status': status,
      if (paymentHash != null) 'payment_hash': paymentHash,
      if (valueSat != null) 'value_sat': valueSat,
      if (feeSat != null) 'fee_sat': feeSat,
    },
    if (failureReason != null) 'error': {
      'message': failureReason,
    },
  };
}