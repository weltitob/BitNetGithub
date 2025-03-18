import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'moonpay_flutter_platform_interface.dart';

/// An implementation of [MoonpayFlutterPlatform] that uses method channels.
class MethodChannelMoonpayFlutter extends MoonpayFlutterPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('moonpay_flutter');

  @override
  Future<void> showMoonPay(
      String walletAddress,
      double btcAmount,
      String language,
      String baseCurrencyCode,
      double baseCurrencyAmount,
      String paymentMethod) async {
    try {
      await methodChannel.invokeMethod("show_moon_pay", [
        walletAddress,
        btcAmount,
        language,
        baseCurrencyCode,
        baseCurrencyAmount,
        paymentMethod
      ]);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> sendSignature(String signature) async {
    try {
      await methodChannel.invokeMethod("send_signature", [signature]);
    } catch (e) {
      rethrow;
    }
  }

  @override
  void setOnUrlGenerated(Function(String) func) async {}
}
