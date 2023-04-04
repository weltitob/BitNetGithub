import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:local_auth/local_auth.dart';
import 'package:BitNet/backbone/security/biometrics/biometric_helper.dart';

void main() {
  group('BiometricHelper', () {
    late BiometricHelper biometricHelper;

    setUp(() {
      biometricHelper = BiometricHelper();
    });

    test('hasEnrolledBiometrics should return true if biometrics are available', () async {
      // Mock the LocalAuthentication class to return a non-empty list of available biometrics
      final localAuth = LocalAuthentication();
      final availableBiometrics = [BiometricType.face];
      final methodChannel = MethodChannel('plugins.flutter.io/local_auth');
      methodChannel.setMockMethodCallHandler((MethodCall methodCall) async {
        if (methodCall.method == 'getAvailableBiometrics') {
          return availableBiometrics.map((type) => type.toString()).toList();
        }
        return null;
      });

      // Call the hasEnrolledBiometrics method and expect it to return true
      final hasEnrolled = await biometricHelper.hasEnrolledBiometrics();
      expect(hasEnrolled, true);
    });

    test('hasEnrolledBiometrics should return false if biometrics are not available', () async {
      // Mock the LocalAuthentication class to return an empty list of available biometrics
      final localAuth = LocalAuthentication();
      final availableBiometrics = <BiometricType>[];
      final methodChannel = MethodChannel('plugins.flutter.io/local_auth');
      methodChannel.setMockMethodCallHandler((MethodCall methodCall) async {
        if (methodCall.method == 'getAvailableBiometrics') {
          return availableBiometrics.map((type) => type.toString()).toList();
        }
        return null;
      });

      // Call the hasEnrolledBiometrics method and expect it to return false
      final hasEnrolled = await biometricHelper.hasEnrolledBiometrics();
      expect(hasEnrolled, false);
    });

    test('authenticate should return true if authentication is successful', () async {
      // Mock the LocalAuthentication class to return true when authenticate is called
      final localAuth = LocalAuthentication();
      final methodChannel = MethodChannel('plugins.flutter.io/local_auth');
      methodChannel.setMockMethodCallHandler((MethodCall methodCall) async {
        if (methodCall.method == 'authenticate') {
          return true;
        }
        return null;
      });

      // Call the authenticate method and expect it to return true
      final authenticated = await biometricHelper.authenticate();
      expect(authenticated, true);
    });

    test('authenticate should return false if authentication fails', () async {
      // Mock the LocalAuthentication class to return false when authenticate is called
      final localAuth = LocalAuthentication();
      final methodChannel = MethodChannel('plugins.flutter.io/local_auth');
      methodChannel.setMockMethodCallHandler((MethodCall methodCall) async {
        if (methodCall.method == 'authenticate') {
          return false;
        }
        return null;
      });

      // Call the authenticate method and expect it to return false
      final authenticated = await biometricHelper.authenticate();
      expect(authenticated, false);
    });
  });
}