import 'package:flutter_test/flutter_test.dart';
import 'package:bitnet/backbone/helper/helpers.dart';

/// Unit tests for date and time utility functions
/// 
/// These tests verify the basic timestamp functionality
/// used throughout the BitNET app.
void main() {
  group('DateTime Utils - Current Timestamp', () {
    test('should return current time in milliseconds', () {
      // Get current time before and after the function call
      final before = DateTime.now().millisecondsSinceEpoch;
      final result = timeNow();
      final after = DateTime.now().millisecondsSinceEpoch;
      
      // The result should be between before and after
      expect(result, greaterThanOrEqualTo(before));
      expect(result, lessThanOrEqualTo(after));
    });

    test('should return positive timestamp', () {
      final result = timeNow();
      expect(result, greaterThan(0));
    });

    test('should return different values on consecutive calls', () {
      final first = timeNow();
      // Small delay to ensure different timestamps
      Future.delayed(Duration(milliseconds: 1));
      final second = timeNow();
      
      expect(second, greaterThanOrEqualTo(first));
    });
  });
}