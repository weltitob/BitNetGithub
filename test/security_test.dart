import 'package:flutter_test/flutter_test.dart';
import 'package:nexus_wallet/backbone/security/security.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mockito/mockito.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  group('SharedPrefSecurityCheck', () {
    test('returns true if isSecurityChecked is true', () async {
      final mockSharedPreferences = MockSharedPreferences();
      when(mockSharedPreferences.getBool('isSecurityChecked')).thenReturn(true);
      final result = await SharedPrefSecurityCheck();
      expect(result, true);
    });

    test('returns false if isSecurityChecked is false', () async {
      final mockSharedPreferences = MockSharedPreferences();
      when(mockSharedPreferences.getBool('isSecurityChecked')).thenReturn(false);
      final result = await SharedPrefSecurityCheck();
      expect(result, false);
    });

    test('returns false if isSecurityChecked is null', () async {
      final mockSharedPreferences = MockSharedPreferences();
      when(mockSharedPreferences.getBool('isSecurityChecked')).thenReturn(null);
      final result = await SharedPrefSecurityCheck();
      expect(result, false);
    });
  });
}