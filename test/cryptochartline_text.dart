import 'package:flutter_test/flutter_test.dart';
import 'package:nexus_wallet/backbone/streams/cryptochartline.dart';
import 'package:nexus_wallet/components/chart.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

void main() {
  group('CryptoChartLine', () {
    test('fetches chart data successfully', () async {
      final chartLine = CryptoChartLine(
        crypto: 'bitcoin',
        interval: 'daily',
        days: '30',
        currency: 'usd',
      );

      // Define the mock response data
      final mockResponse = '{"prices": [[1, 10], [2, 20], [3, 30]]}';

      // Create a mock client that returns the mock response
      final mockClient = MockClient((request) async {
        return http.Response(mockResponse, 200);
      });

      // Use the mock client to fetch the chart data
      await chartLine.getChartData();

      // Verify that the chart line is populated with the correct data
      expect(chartLine.chartLine.length, 3);
      expect(chartLine.chartLine[0].time, 1.0);
      expect(chartLine.chartLine[0].price, 10.0);
      expect(chartLine.chartLine[1].time, 2.0);
      expect(chartLine.chartLine[1].price, 20.0);
      expect(chartLine.chartLine[2].time, 3.0);
      expect(chartLine.chartLine[2].price, 30.0);
    });

    test('throws an error when unable to fetch chart data', () async {
      final chartLine = CryptoChartLine(
        crypto: 'invalid_crypto',
        interval: 'daily',
        days: '30',
        currency: 'usd',
      );

      // Create a mock client that returns a 404 error
      final mockClient = MockClient((request) async {
        return http.Response('Not found', 404);
      });

      // Expect an error to be thrown when attempting to fetch the chart data
      expect(() async => chartLine.getChartData(), throwsA(isA<String>()));
    });
  });
}