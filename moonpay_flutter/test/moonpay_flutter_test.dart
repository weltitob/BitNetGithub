import 'package:flutter_test/flutter_test.dart';
import 'package:moonpay_flutter/moonpay_flutter.dart';
import 'package:moonpay_flutter/moonpay_flutter_platform_interface.dart';
import 'package:moonpay_flutter/moonpay_flutter_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockMoonpayFlutterPlatform
    with MockPlatformInterfaceMixin
    implements MoonpayFlutterPlatform {
  @override
  Future<String?> showMoonPay(
      String walletAddress,
      double btcAmount,
      String language,
      String baseCurrencyCode,
      double baseCurrencyAmount,
      String paymentMethod) {
    // TODO: implement showMoonPay
    throw UnimplementedError();
  }

  @override
  Future<void> sendSignature(String signature) {
    // TODO: implement sendSignature
    throw UnimplementedError();
  }

  @override
  void setOnUrlGenerated(Function(String) func) {
    // TODO: implement setOnUrlGenerated
  }
}

void main() {
  final MoonpayFlutterPlatform initialPlatform =
      MoonpayFlutterPlatform.instance;

  test('$MethodChannelMoonpayFlutter is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelMoonpayFlutter>());
  });

  test('getPlatformVersion', () async {
    MoonpayFlutter moonpayFlutterPlugin = MoonpayFlutter();
    MockMoonpayFlutterPlatform fakePlatform = MockMoonpayFlutterPlatform();
    MoonpayFlutterPlatform.instance = fakePlatform;
  });
}
