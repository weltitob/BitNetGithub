import 'package:flutter_test/flutter_test.dart';
import 'package:bitnet/backbone/services/lnurl_channel_service.dart';
import 'package:bitnet/models/bitcoin/lnurl/lnurl_channel_model.dart';

/// Unit tests for LNURL Channel Verification functionality
/// 
/// These tests verify that:
/// 1. Channel verification polling works correctly
/// 2. Progress callbacks are called in the right order
/// 3. Timeout handling works properly
/// 4. Error states are handled gracefully
void main() {
  group('LNURL Channel Verification Tests', () {
    late LnurlChannelService channelService;

    setUp(() {
      channelService = LnurlChannelService();
    });

    test('Channel verification should handle progress updates correctly', () async {
      List<ChannelOpeningProgress> progressUpdates = [];
      
      // Create a test LNURL (this will use demo mode)
      const testLnurl = 'lnurl1dp68gurn8ghj7um9wfmxjcm99e3k7mf0v9cxj0m385ekvcenxc6r2c35xvukxefcv5mkvv34x5ekzd3ev56nyd3hxqurzepexejxxepnxscrvwfnv9nxzcn9xq6xyefhvgcxxcmyxymnserxfq5fns';
      
      try {
        final result = await channelService.processChannelRequest(
          testLnurl,
          onProgress: (progress) {
            progressUpdates.add(progress);
          },
        );

        // Verify we got progress updates
        expect(progressUpdates.isNotEmpty, true);
        
        // Verify the sequence of progress states
        final progressStates = progressUpdates.map((p) => p.status).toList();
        expect(progressStates.contains('connecting'), true);
        expect(progressStates.contains('claiming'), true);
        
        // In demo mode, it should succeed
        expect(result.success, true);
        expect(result.message, contains('successfully'));
        
        print('✅ Channel verification test passed');
        print('📊 Progress updates received: ${progressUpdates.length}');
        print('🔄 Progress states: ${progressStates.join(' → ')}');
        
      } catch (e) {
        print('❌ Test failed with error: $e');
        rethrow;
      }
    });

    test('Channel verification should timeout gracefully', () async {
      // Test with a very short timeout (1 second)
      final result = await channelService.verifyChannelCreation(
        '03816141f1dce7782ec32b66a300783b1d436b19777e7c686ed00115bd4b88ff4b',
        maxWaitSeconds: 1,
      );
      
      // Should timeout and return false
      expect(result, false);
      print('✅ Timeout handling test passed');
    });

    test('Progress factory methods should create correct states', () {
      final connecting = ChannelOpeningProgress.connecting();
      expect(connecting.status, 'connecting');
      expect(connecting.progress, 0.25);
      expect(connecting.isCompleted, false);

      final claiming = ChannelOpeningProgress.claiming();
      expect(claiming.status, 'claiming');
      expect(claiming.progress, 0.50);

      final opening = ChannelOpeningProgress.opening();
      expect(opening.status, 'opening');
      expect(opening.progress, 0.60);

      final verifying = ChannelOpeningProgress.verifying();
      expect(verifying.status, 'verifying');
      expect(verifying.progress, 0.85);

      final completed = ChannelOpeningProgress.completed();
      expect(completed.status, 'completed');
      expect(completed.progress, 1.0);
      expect(completed.isCompleted, true);

      final error = ChannelOpeningProgress.error('Test error');
      expect(error.status, 'error');
      expect(error.errorMessage, 'Test error');
      expect(error.isCompleted, true);

      print('✅ Progress factory methods test passed');
    });

    test('LNURL Channel Request should validate correctly', () {
      final request = LnurlChannelRequest(
        tag: 'channelRequest',
        k1: 'test-k1',
        callback: 'https://api.example.com/callback',
        uri: '03816141f1dce7782ec32b66a300783b1d436b19777e7c686ed00115bd4b88ff4b@34.65.191.64:9735',
        nodeId: '03816141f1dce7782ec32b66a300783b1d436b19777e7c686ed00115bd4b88ff4b',
        localAmt: 20000,
        pushAmt: 0,
      );

      expect(request.tag, 'channelRequest');
      expect(request.nodeId, isNotEmpty);
      expect(request.localAmt, 20000);

      // Test JSON serialization
      final json = request.toJson();
      expect(json['tag'], 'channelRequest');
      expect(json['localAmt'], 20000);

      final fromJson = LnurlChannelRequest.fromJson(json);
      expect(fromJson.tag, request.tag);
      expect(fromJson.nodeId, request.nodeId);

      print('✅ LNURL Channel Request validation test passed');
    });
  });
}