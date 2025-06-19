import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:bitnet/backbone/helper/helpers.dart';

/// Unit tests for string utility functions
/// 
/// These tests verify string manipulation and utility functions
/// including random string generation, percentage formatting,
/// color generation, and numeric validation.
/// 
/// Test categories:
/// 1. Random string generation
/// 2. Percentage formatting
/// 3. Random color generation
/// 4. Six-digit validation
/// 5. Average calculation
void main() {
  group('String Utils - Random String Generation', () {
    test('should generate string of correct length', () {
      expect(getRandomString(0).length, equals(0));
      expect(getRandomString(1).length, equals(1));
      expect(getRandomString(10).length, equals(10));
      expect(getRandomString(100).length, equals(100));
    });

    test('should generate alphanumeric strings only', () {
      final randomString = getRandomString(100);
      // Check that string contains only letters and numbers
      expect(
        RegExp(r'^[a-zA-Z0-9]+$').hasMatch(randomString),
        isTrue,
      );
    });

    test('should generate different strings on consecutive calls', () {
      final string1 = getRandomString(20);
      final string2 = getRandomString(20);
      final string3 = getRandomString(20);
      
      // While theoretically they could be the same, it's extremely unlikely
      expect(string1 == string2 && string2 == string3, isFalse);
    });

    test('should handle edge cases', () {
      // Zero length
      expect(getRandomString(0), equals(''));
      
      // Negative length (typically returns empty string in most implementations)
      final negativeResult = getRandomString(-1);
      expect(negativeResult.isEmpty, isTrue);
    });

    test('should contain mix of letters and numbers', () {
      // Generate a longer string to ensure mix
      final randomString = getRandomString(1000);
      
      // Check for at least one letter
      expect(RegExp(r'[a-zA-Z]').hasMatch(randomString), isTrue);
      
      // Check for at least one number
      expect(RegExp(r'[0-9]').hasMatch(randomString), isTrue);
    });
  });

  group('String Utils - Percentage Formatting', () {
    test('should format whole numbers correctly', () {
      expect(toPercent(0.0), equals('+0%'));
      expect(toPercent(0.01), equals('+1%'));
      expect(toPercent(0.5), equals('+50%'));
      expect(toPercent(1.0), equals('+100%'));
    });

    test('should format decimal numbers correctly', () {
      expect(toPercent(0.005), equals('+0.5%'));
      expect(toPercent(0.015), equals('+1.5%'));
      expect(toPercent(0.999), equals('+99.9%'));
      expect(toPercent(0.00123), equals('+0.12%'));
    });

    test('should handle negative percentages', () {
      expect(toPercent(-0.05), equals(' -5%'));
      expect(toPercent(-0.005), equals(' -0.5%'));
      expect(toPercent(-1.0), equals(' -100%'));
    });

    test('should handle very large percentages', () {
      expect(toPercent(10.0), equals('+1000%'));
      expect(toPercent(9999.99), equals('+999999%'));
    });

    test('should handle very small percentages', () {
      expect(toPercent(0.00001), equals('+0%'));
      expect(toPercent(0.000001), equals('+0%'));
    });

    test('should remove trailing zeros after decimal', () {
      expect(toPercent(0.01), equals('+1%')); // Not '1.0%'
      expect(toPercent(0.5), equals('+50%')); // Not '50.0%'
      
      // But keep significant decimals
      expect(toPercent(0.015), equals('+1.5%'));
      expect(toPercent(0.0150), equals('+1.5%')); // Remove trailing zero
    });
  });

  group('String Utils - Random Color Generation', () {
    test('should generate valid Color objects', () {
      final color = getRandomColor();
      expect(color, isA<Color>());
    });

    test('should generate different colors on consecutive calls', () {
      final colors = List.generate(10, (_) => getRandomColor());
      final uniqueColors = colors.toSet();
      
      // While not guaranteed, 10 random colors should likely have
      // at least 5 different ones
      expect(uniqueColors.length, greaterThanOrEqualTo(5));
    });

    test('should generate colors with full opacity', () {
      final color = getRandomColor();
      // Full opacity means alpha channel is 255 (0xFF)
      expect(color.alpha, equals(255));
    });

    test('should generate colors within valid RGB range', () {
      // Generate multiple colors to test
      for (int i = 0; i < 100; i++) {
        final color = getRandomColor();
        expect(color.red, inInclusiveRange(0, 255));
        expect(color.green, inInclusiveRange(0, 255));
        expect(color.blue, inInclusiveRange(0, 255));
      }
    });
  });

  group('String Utils - Six Integer Validation', () {
    test('should validate strings with exactly 6 consecutive digits', () {
      expect(containsSixIntegers('123456'), isTrue);
      expect(containsSixIntegers('000000'), isTrue);
      expect(containsSixIntegers('999999'), isTrue);
    });

    test('should find 6 digits within larger strings', () {
      expect(containsSixIntegers('abc123456xyz'), isTrue);
      expect(containsSixIntegers('prefix123456'), isTrue);
      expect(containsSixIntegers('123456suffix'), isTrue);
      expect(containsSixIntegers('text123456more999999text'), isTrue);
    });

    test('should reject strings with less than 6 digits', () {
      expect(containsSixIntegers('12345'), isFalse);
      expect(containsSixIntegers('1'), isFalse);
      expect(containsSixIntegers('abc12345xyz'), isFalse);
    });

    test('should reject strings with more than 6 consecutive digits', () {
      expect(containsSixIntegers('1234567'), isFalse);
      expect(containsSixIntegers('12345678'), isFalse);
      expect(containsSixIntegers('abc1234567xyz'), isFalse);
    });

    test('should reject strings with separated digits', () {
      expect(containsSixIntegers('123 456'), isFalse);
      expect(containsSixIntegers('123-456'), isFalse);
      expect(containsSixIntegers('123.456'), isFalse);
      expect(containsSixIntegers('123a456'), isFalse);
    });

    test('should handle edge cases', () {
      expect(containsSixIntegers(''), isFalse);
      expect(containsSixIntegers('abcdef'), isFalse);
      expect(containsSixIntegers('......'), isFalse);
      expect(containsSixIntegers('      '), isFalse); // 6 spaces
    });

    test('should handle multiple sets of 6 digits separated by non-digits', () {
      // Should find exactly 6 digits when separated by non-digits
      expect(containsSixIntegers('123456abc789012'), isTrue); // Has exactly 6 digits followed by letters
      expect(containsSixIntegers('abc123456def789012'), isTrue); // Has exactly 6 digits between letters
      expect(containsSixIntegers('123456 789012'), isTrue); // Has exactly 6 digits followed by space
    });
  });

  group('String Utils - Average Calculation', () {
    test('should calculate average of price list correctly', () {
      // Test with simple list
      expect(getaverage([1.0, 2.0, 3.0]), equals(2.0));
      expect(getaverage([10.0, 20.0, 30.0]), equals(20.0));
      expect(getaverage([5.0, 5.0, 5.0]), equals(5.0));
    });

    test('should handle single value', () {
      expect(getaverage([42.0]), equals(42.0));
      expect(getaverage([0.0]), equals(0.0));
      expect(getaverage([-10.0]), equals(-10.0));
    });

    test('should handle negative values', () {
      expect(getaverage([-1.0, -2.0, -3.0]), equals(-2.0));
      expect(getaverage([1.0, -1.0]), equals(0.0));
      expect(getaverage([-10.0, 10.0, 0.0]), equals(0.0));
    });

    test('should handle decimal values', () {
      expect(getaverage([1.5, 2.5, 3.5]), equals(2.5));
      expect(getaverage([0.1, 0.2, 0.3]), closeTo(0.2, 0.0001));
    });

    test('should handle large lists', () {
      final largeList = List.generate(100, (i) => i.toDouble());
      expect(getaverage(largeList), equals(49.5)); // 0 to 99 average
    });

    test('should handle empty list', () {
      // This might throw or return 0/NaN depending on implementation
      // Test the actual behavior based on the implementation
      try {
        final result = getaverage([]);
        // If it doesn't throw, check the result
        expect(result.isNaN || result == 0.0, isTrue);
      } catch (e) {
        // If it throws, that's also valid
        expect(e, isA<Error>());
      }
    });

    test('should handle mixed integer and double values', () {
      // If the function accepts dynamic, test mixed types
      expect(getaverage([1, 2.0, 3]), equals(2.0));
      expect(getaverage([10, 20.5, 30]), equals(20.166666666666668));
    });
  });

  group('String Utils - Standardized UI Measurements', () {
    test('should return consistent viewport fraction', () {
      final fraction = getStandardizedViewportFraction();
      expect(fraction, equals(0.7));
      
      // Should always return the same value
      expect(getStandardizedViewportFraction(), equals(fraction));
    });

    test('should return consistent enlarge factor', () {
      final factor = getStandardizedEnlargeFactor();
      expect(factor, equals(0.25));
      
      // Should always return the same value
      expect(getStandardizedEnlargeFactor(), equals(factor));
    });

    test('should calculate carousel height based on screen dimensions', () {
      // These tests would need MediaQuery context in real implementation
      // For now, test that the function returns reasonable values
      final height = getStandardizedCarouselHeight();
      expect(height, greaterThan(0));
      expect(height, lessThan(1000)); // Reasonable upper bound
    });

    test('should calculate card width based on screen dimensions', () {
      final width = getStandardizedCardWidth();
      expect(width, greaterThan(0));
      expect(width, lessThan(1000)); // Reasonable upper bound
    });

    test('should calculate card margin consistently', () {
      final margin = getStandardizedCardMargin();
      expect(margin, greaterThanOrEqualTo(0));
      expect(margin, lessThan(100)); // Reasonable margin size
    });
  });
}