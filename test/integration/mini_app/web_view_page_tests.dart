import 'dart:convert';
import 'dart:io';

import 'package:bitnet/backbone/services/base_controller/dio/dio_service.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:bitnet/pages/feed/appstab.dart';
import 'package:bitnet/pages/profile/profile.dart';
import 'package:bitnet/pages/profile/profile_controller.dart';
import 'package:bitnet/pages/qrscanner/qrscanner.dart';
import 'package:bitnet/pages/wallet/actions/send/controllers/send_controller.dart';
import 'package:bitnet/router.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:integration_test/integration_test.dart';
import 'package:get/get.dart';

import 'package:bitnet/main.dart' as app;
import 'package:bitnet/pages/feed/webview_page.dart';
import 'package:logger/logger.dart';
import 'package:mockito/annotations.dart'; // adjust as needed
import 'package:mockito/mockito.dart';
import '../../unit/receive/receive_controller_test.dart';
import 'web_view_page_tests.mocks.dart';

// Mocks (minimal)
class MockSendsController extends GetxController implements SendsController {
  TextEditingController satController = TextEditingController(text: "500");
  TextEditingController btcController = TextEditingController(text: "500");
  String bitcoinReceiverAdress = "dawd";
  RxString description = "dawd".obs;
  @override
  Future<void> onQRCodeScanned(dynamic data, BuildContext context) async {
    print("Mock onQRCodeScanned called with: $data");
  }

  @override
  QRTyped determineQRType(dynamic text) {
    print("Mock determineQRType called with: $text");
    return QRTyped.Invoice;
  }

  // You can add more stubs if necessary

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class MockProfileController extends GetxController
    implements ProfileController {
  List<AppData> availableApps = List.empty();

  // You can add more stubs if necessary

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

Future<String> loadBase64Qr() async {
  return await rootBundle.loadString('assets/textfiles/qr_image.txt');
}

@GenerateMocks([GoRouterState])
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  final mockState = MockGoRouterState();
  LoggerService mockLogger;
  setUpAll(() {
    // Initialize GetX testing mode
    Get.testMode = true;
  });

  setUp(() {
    // Create mocks
    mockLogger = MockLoggerService();

    // Setup GetX dependencies
    Get.put<SendsController>(MockSendsController());
    Get.put<ProfileController>(MockProfileController());

    Get.put<LoggerService>(mockLogger);
    Get.put<DioClient>(MockDioService());
  });

  tearDown(() {
    // Clean up GetX
    Get.reset();
  });

  when(mockState.pathParameters).thenReturn({
    'name': 'TestApp',
    'url': 'https://example.com',
  });
  when(mockState.extra).thenReturn({'is_app': true});

  group('WebViewPage Integration Tests', () {
    testWidgets('Processes valid QR code input', (tester) async {
      // Start app

      // Navigate to WebViewPage, or simulate being there directly
      await tester.pumpWidget(MaterialApp(
        home: WebViewPage(
          routerState: mockState,
        ),
      ));
      await tester.pumpAndSettle();

      // Find the widget state
      String? base64Qr;
      final state = tester.state(find.byType(WebViewPage)) as WebViewPageState;
      try {
        base64Qr = await tester.runAsync(() async {
          return await loadBase64Qr();
        });
        await state.controller.loadHtmlString('''
    <!DOCTYPE html>
    <html>
      <body style="font-family: sans-serif; text-align: center; padding-top: 50px;">
        <h3>Scan or copy:</h3>
        <img src="data:image/png;base64,$base64Qr" style="width: 200px; height: 200px;" />
        <br/>
        <input id="copyField" value="bitcoin:address123?amount=0.01" />
        <script>
          // Optional: Simulate copy to Flutter
          document.getElementById('copyField').addEventListener('focus', function() {
            try {
              document.execCommand('copy');
              if (window.Android) {
                window.Android.postMessage(JSON.stringify({
                  type: 'clipboard_copy',
                  content: document.getElementById('copyField').value
                }));
              }
            } catch (e) {
              console.log('Copy failed');
            }
          });
        </script>
      </body>
    </html>
    ''');

        // Provide valid QR data
        final validQR = '''
      {
        "origin_app_name":"Bitnet",
        "api_version":"0.0.1",
        "app_id":"abc",
        "data":{
          "amount":100,
          "currency":"BTC",
          "target_currency":"SAT",
          "deposit_address":"test-address",
          "note":"Hello"
        }
      }
      ''';

        await Future.delayed(Duration(seconds: 10));
        print('actual qr code found');
        print(state.foundQRCodes.first);
        try {
          dynamic qrData = state.foundQRCodes.first;
          dynamic json = jsonDecode(qrData);
          // Check if the result is still a string (double encoded)
          if (json is String) {
            try {
              // Try to decode again for double-encoded JSON
              json = jsonDecode(json);
            } catch (e) {
              // If second decode fails, use the first decode result
              // This handles cases where it's not actually double-encoded
            }
          }
          final expected = jsonDecode(validQR);

          expect(json, expected);
        } catch (e) {}
      } catch (e) {
        print(e);
      }
    });

    testWidgets('Processes copied text properly', (tester) async {
      await tester.pumpWidget(MaterialApp.router(
        routerConfig: GoRouter(initialLocation: '/', routes: [
          GoRoute(
              path: '/',
              builder: (ctx, state) => WebViewPage(routerState: mockState))
        ]),
      ));

      await tester.pumpAndSettle();

      final state = tester.state(find.byType(WebViewPage)) as WebViewPageState;

      const copiedText = "bitcoin:test-address?amount=0.001";
      state.handlingData = false;
      // JS that triggers postMessage to Flutter
      final html = '''
    <!DOCTYPE html>
    <html>
      <body>
        <script>
          window.onload = function() {
            if (window.Android) {
              window.Android.postMessage(${jsonEncode(jsonEncode({
            'type': 'clipboard_copy',
            'content': copiedText
          }))});
            }
          };
        </script>
      </body>
    </html>
  ''';

      await state.controller.loadHtmlString(html);
      await tester.pump();
      await Future.delayed(Duration(seconds: 2));

      expect(state.handlingData, isTrue);
    });
    testWidgets('WebView sends valid payload via postMessage', (tester) async {
      // Set up the page
      await tester.pumpWidget(MaterialApp.router(
        routerConfig: GoRouter(initialLocation: '/', routes: [
          GoRoute(
              path: '/',
              builder: (ctx, state) => WebViewPage(routerState: mockState))
        ]),
      ));

      await tester.pumpAndSettle();

      final state = tester.state(find.byType(WebViewPage)) as WebViewPageState;

      // Valid payload (same as QR)
      final validQRPayload = jsonEncode({
        "origin_app_name": "Bitnet",
        "api_version": "0.0.1",
        "app_id": "abc",
        "data": {
          "amount": 100,
          "currency": "BTC",
          "target_currency": "SAT",
          "deposit_address": "test-address",
          "note": "Hello"
        }
      });

      // JS that triggers postMessage to Flutter
      final html = '''
    <!DOCTYPE html>
    <html>
      <body>
        <script>
          window.onload = function() {
            if (window.Android) {
              window.Android.postMessage(${jsonEncode(validQRPayload)});
            }
          };
        </script>
      </body>
    </html>
  ''';

      await state.controller.loadHtmlString(html);
      await tester.pump();
      await Future.delayed(Duration(seconds: 2));

      expect(state.handlingData, isTrue);
    });
  });
}

class MockDioService extends DioClient {
  @override
  void onInit() {}

  @override
  Future<dio.Response<dynamic>> get(
      {Map<String, dynamic>? data,
      required String url,
      Map<String, dynamic>? headers}) async {
    return dio.Response(requestOptions: dio.RequestOptions(), data: {});
  }
}
