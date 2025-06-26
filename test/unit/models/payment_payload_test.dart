import 'package:bitnet/pages/feed/webview_page.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PaymentPayload', () {
    group('fromJson', () {
      test('should parse valid JSON with double amount', () {
        // Arrange
        final json = {
          'origin_app_name': 'TestApp',
          'api_version': '1.0.0',
          'app_id': 'app123',
          'data': {
            'amount': 0.001,
            'currency': 'BTC',
            'target_currency': 'BTC',
            'deposit_address': 'bc1qxy2kgdygjrsqtzq2n0yrf2493p83kkfjhx0wlh',
            'note': 'Test payment',
          },
        };

        // Act
        final payload = PaymentPayload.fromJson(json);

        // Assert
        expect(payload.originAppName, 'TestApp');
        expect(payload.apiVersion, '1.0.0');
        expect(payload.appId, 'app123');
        expect(payload.amount, 0.001);
        expect(payload.currency, 'BTC');
        expect(payload.targetCurrency, 'BTC');
        expect(payload.depositAddress,
            'bc1qxy2kgdygjrsqtzq2n0yrf2493p83kkfjhx0wlh');
        expect(payload.note, 'Test payment');
      });

      test('should parse valid JSON with integer amount', () {
        // Arrange
        final json = {
          'origin_app_name': 'TestApp',
          'api_version': '1.0.0',
          'app_id': 'app123',
          'data': {
            'amount': 100000, // Integer amount (satoshis)
            'currency': 'SAT',
            'target_currency': 'SAT',
            'deposit_address': 'lnbc100u1p3q4vc7pp5...',
            'note': 'Lightning payment',
          },
        };

        // Act
        final payload = PaymentPayload.fromJson(json);

        // Assert
        expect(payload.amount, 100000.0); // Should be converted to double
        expect(payload.currency, 'SAT');
        expect(payload.targetCurrency, 'SAT');
      });

      test('should handle missing optional fields gracefully', () {
        // Arrange
        final json = {
          'origin_app_name': 'TestApp',
          'api_version': '1.0.0',
          'app_id': 'app123',
          'data': {
            'amount': 0.5,
            'currency': 'BTC',
            'target_currency': 'BTC',
            'deposit_address': 'bc1qxy2kgdygjrsqtzq2n0yrf2493p83kkfjhx0wlh',
            'note': '',
          },
        };

        // Act
        final payload = PaymentPayload.fromJson(json);

        // Assert
        expect(payload.note, '');
      });

      test('should handle different currency combinations', () {
        // Arrange
        final json = {
          'origin_app_name': 'TestApp',
          'api_version': '1.0.0',
          'app_id': 'app123',
          'data': {
            'amount': 100.0,
            'currency': 'USD',
            'target_currency': 'BTC',
            'deposit_address': 'bc1qxy2kgdygjrsqtzq2n0yrf2493p83kkfjhx0wlh',
            'note': 'USD to BTC conversion',
          },
        };

        // Act
        final payload = PaymentPayload.fromJson(json);

        // Assert
        expect(payload.amount, 100.0);
        expect(payload.currency, 'USD');
        expect(payload.targetCurrency, 'BTC');
        expect(payload.note, 'USD to BTC conversion');
      });

      test('should handle large amounts correctly', () {
        // Arrange
        final json = {
          'origin_app_name': 'TestApp',
          'api_version': '1.0.0',
          'app_id': 'app123',
          'data': {
            'amount': 21000000, // 21 million sats
            'currency': 'SAT',
            'target_currency': 'BTC',
            'deposit_address': 'bc1qxy2kgdygjrsqtzq2n0yrf2493p83kkfjhx0wlh',
            'note': 'Large amount test',
          },
        };

        // Act
        final payload = PaymentPayload.fromJson(json);

        // Assert
        expect(payload.amount, 21000000.0);
      });

      test('should handle decimal amounts with high precision', () {
        // Arrange
        final json = {
          'origin_app_name': 'TestApp',
          'api_version': '1.0.0',
          'app_id': 'app123',
          'data': {
            'amount': 0.00000001, // 1 satoshi in BTC
            'currency': 'BTC',
            'target_currency': 'SAT',
            'deposit_address': 'bc1qxy2kgdygjrsqtzq2n0yrf2493p83kkfjhx0wlh',
            'note': 'Minimum amount test',
          },
        };

        // Act
        final payload = PaymentPayload.fromJson(json);

        // Assert
        expect(payload.amount, 0.00000001);
      });
    });
  });
}
