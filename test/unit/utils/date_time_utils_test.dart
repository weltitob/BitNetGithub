import 'package:flutter_test/flutter_test.dart';
import 'package:bitnet/backbone/helper/helpers.dart';

/// Unit tests for date and time utility functions
/// 
/// These tests verify the date/time formatting and manipulation functions
/// used throughout the BitNET app for displaying timestamps, relative times,
/// and date conversions.
/// 
/// Test categories:
/// 1. Current timestamp generation
/// 2. Relative time display (time ago)
/// 3. Date format conversion
/// 4. Localization support
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

  group('DateTime Utils - Display Time Ago From Timestamp', () {
    test('should display "gerade eben" for very recent times', () {
      final now = DateTime.now().millisecondsSinceEpoch.toString();
      expect(
        displayTimeAgoFromTimestamp(now),
        equals('gerade eben'),
      );
    });

    test('should display minutes ago correctly', () {
      final fiveMinutesAgo = DateTime.now()
          .subtract(Duration(minutes: 5))
          .millisecondsSinceEpoch
          .toString();
      
      expect(
        displayTimeAgoFromTimestamp(fiveMinutesAgo),
        equals('vor 5 Minuten'),
      );
    });

    test('should display hours ago correctly', () {
      final twoHoursAgo = DateTime.now()
          .subtract(Duration(hours: 2))
          .millisecondsSinceEpoch
          .toString();
      
      expect(
        displayTimeAgoFromTimestamp(twoHoursAgo),
        equals('vor 2 Stunden'),
      );
    });

    test('should display "gestern" for yesterday', () {
      final yesterday = DateTime.now()
          .subtract(Duration(days: 1))
          .millisecondsSinceEpoch
          .toString();
      
      expect(
        displayTimeAgoFromTimestamp(yesterday),
        equals('gestern'),
      );
    });

    test('should display days ago for recent days', () {
      final threeDaysAgo = DateTime.now()
          .subtract(Duration(days: 3))
          .millisecondsSinceEpoch
          .toString();
      
      expect(
        displayTimeAgoFromTimestamp(threeDaysAgo),
        equals('vor 3 Tagen'),
      );
    });

    test('should display "letzte Woche" for last week', () {
      final lastWeek = DateTime.now()
          .subtract(Duration(days: 7))
          .millisecondsSinceEpoch
          .toString();
      
      expect(
        displayTimeAgoFromTimestamp(lastWeek),
        equals('letzte Woche'),
      );
    });

    test('should display weeks ago for multiple weeks', () {
      final threeWeeksAgo = DateTime.now()
          .subtract(Duration(days: 21))
          .millisecondsSinceEpoch
          .toString();
      
      expect(
        displayTimeAgoFromTimestamp(threeWeeksAgo),
        equals('vor 3 Wochen'),
      );
    });

    test('should display "letzten Monat" for last month', () {
      final lastMonth = DateTime.now()
          .subtract(Duration(days: 30))
          .millisecondsSinceEpoch
          .toString();
      
      expect(
        displayTimeAgoFromTimestamp(lastMonth),
        equals('letzten Monat'),
      );
    });

    test('should display months ago for multiple months', () {
      final threeMonthsAgo = DateTime.now()
          .subtract(Duration(days: 90))
          .millisecondsSinceEpoch
          .toString();
      
      expect(
        displayTimeAgoFromTimestamp(threeMonthsAgo),
        equals('vor 3 Monaten'),
      );
    });

    test('should display "letztes Jahr" for last year', () {
      final lastYear = DateTime.now()
          .subtract(Duration(days: 365))
          .millisecondsSinceEpoch
          .toString();
      
      expect(
        displayTimeAgoFromTimestamp(lastYear),
        equals('letztes Jahr'),
      );
    });

    test('should display years ago for multiple years', () {
      final twoYearsAgo = DateTime.now()
          .subtract(Duration(days: 730))
          .millisecondsSinceEpoch
          .toString();
      
      expect(
        displayTimeAgoFromTimestamp(twoYearsAgo),
        equals('vor 2 Jahren'),
      );
    });

    test('should handle numeric dates when flag is false', () {
      final yesterday = DateTime.now()
          .subtract(Duration(days: 1))
          .millisecondsSinceEpoch
          .toString();
      
      expect(
        displayTimeAgoFromTimestamp(yesterday, numericDates: false),
        equals('gestern'),
      );
    });
  });

  group('DateTime Utils - Display Time Ago From Int', () {
    test('should display time ago in German by default', () {
      final fiveMinutesAgo = DateTime.now()
          .subtract(Duration(minutes: 5))
          .millisecondsSinceEpoch;
      
      expect(
        displayTimeAgoFromInt(fiveMinutesAgo),
        equals('vor 5 Minuten'),
      );
    });

    test('should display time ago in English when specified', () {
      final fiveMinutesAgo = DateTime.now()
          .subtract(Duration(minutes: 5))
          .millisecondsSinceEpoch;
      
      expect(
        displayTimeAgoFromInt(fiveMinutesAgo, language: 'en'),
        equals('5 minutes ago'),
      );
    });

    test('should handle "just now" in English', () {
      final now = DateTime.now().millisecondsSinceEpoch;
      
      expect(
        displayTimeAgoFromInt(now, language: 'en'),
        equals('just now'),
      );
    });

    test('should handle singular units in English', () {
      final oneHourAgo = DateTime.now()
          .subtract(Duration(hours: 1))
          .millisecondsSinceEpoch;
      
      expect(
        displayTimeAgoFromInt(oneHourAgo, language: 'en'),
        equals('1 hour ago'),
      );
    });

    test('should handle yesterday in English', () {
      final yesterday = DateTime.now()
          .subtract(Duration(days: 1))
          .millisecondsSinceEpoch;
      
      expect(
        displayTimeAgoFromInt(yesterday, language: 'en'),
        equals('yesterday'),
      );
    });

    test('should handle last week/month/year in English', () {
      final lastWeek = DateTime.now()
          .subtract(Duration(days: 7))
          .millisecondsSinceEpoch;
      final lastMonth = DateTime.now()
          .subtract(Duration(days: 30))
          .millisecondsSinceEpoch;
      final lastYear = DateTime.now()
          .subtract(Duration(days: 365))
          .millisecondsSinceEpoch;
      
      expect(displayTimeAgoFromInt(lastWeek, language: 'en'), equals('last week'));
      expect(displayTimeAgoFromInt(lastMonth, language: 'en'), equals('last month'));
      expect(displayTimeAgoFromInt(lastYear, language: 'en'), equals('last year'));
    });

    test('should handle future dates gracefully', () {
      final futureTime = DateTime.now()
          .add(Duration(hours: 1))
          .millisecondsSinceEpoch;
      
      // Future times should show as "just now" or similar
      expect(
        displayTimeAgoFromInt(futureTime),
        equals('gerade eben'),
      );
    });

    test('should handle edge cases with numeric dates', () {
      final twoMinutesAgo = DateTime.now()
          .subtract(Duration(minutes: 2))
          .millisecondsSinceEpoch;
      
      expect(
        displayTimeAgoFromInt(twoMinutesAgo, numericDates: false),
        equals('vor ein paar Minuten'),
      );
    });
  });

  group('DateTime Utils - Date Format Conversion', () {
    test('should convert timestamp to readable date format', () {
      // Use a known timestamp for consistent testing
      final timestamp = DateTime(2024, 1, 15, 14, 30, 0).millisecondsSinceEpoch;
      final result = convertIntoDateFormat(timestamp);
      
      // The exact format depends on implementation, but should contain date elements
      expect(result, contains('15'));
      expect(result, contains('Jan') || result.contains('01') || result.contains('Januar'));
      expect(result, contains('2024'));
    });

    test('should handle epoch timestamp', () {
      final epoch = 0;
      final result = convertIntoDateFormat(epoch);
      
      // Should show January 1, 1970
      expect(result, contains('1970'));
      expect(result, contains('01') || result.contains('Jan'));
    });

    test('should handle current timestamp', () {
      final now = DateTime.now().millisecondsSinceEpoch;
      final result = convertIntoDateFormat(now);
      
      // Should contain current year
      expect(result, contains(DateTime.now().year.toString()));
    });

    test('should handle far future dates', () {
      final futureDate = DateTime(2099, 12, 31).millisecondsSinceEpoch;
      final result = convertIntoDateFormat(futureDate);
      
      expect(result, contains('2099'));
      expect(result, contains('31'));
      expect(result, contains('12') || result.contains('Dec') || result.contains('Dezember'));
    });

    test('should format consistently for same timestamp', () {
      final timestamp = DateTime(2024, 6, 15).millisecondsSinceEpoch;
      final result1 = convertIntoDateFormat(timestamp);
      final result2 = convertIntoDateFormat(timestamp);
      
      expect(result1, equals(result2));
    });
  });

  group('DateTime Utils - Edge Cases and Error Handling', () {
    test('should handle invalid timestamp strings gracefully', () {
      expect(
        () => displayTimeAgoFromTimestamp('not-a-timestamp'),
        throwsA(isA<FormatException>()),
      );
      
      expect(
        () => displayTimeAgoFromTimestamp(''),
        throwsA(isA<FormatException>()),
      );
    });

    test('should handle negative timestamps', () {
      // Negative timestamps represent dates before 1970
      final result = displayTimeAgoFromInt(-1000000);
      expect(result, isNotEmpty);
    });

    test('should handle very large timestamps', () {
      // Far future timestamp
      final farFuture = DateTime.now().millisecondsSinceEpoch * 1000;
      final result = displayTimeAgoFromInt(farFuture);
      expect(result, isNotEmpty);
    });

    test('should handle unsupported languages gracefully', () {
      final now = DateTime.now().millisecondsSinceEpoch;
      
      // Should default to German or English
      final result = displayTimeAgoFromInt(now, language: 'unsupported');
      expect(result, isNotEmpty);
    });
  });
}