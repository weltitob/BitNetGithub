import 'package:flutter/services.dart';

import 'moonpay_flutter_platform_interface.dart';

class MoonpayFlutter {
  static const MethodChannel _channel = MethodChannel('moonpay_flutter');

  // Singleton instance
  static final MoonpayFlutter _instance = MoonpayFlutter._internal();

  // Factory constructor to return the same instance
  factory MoonpayFlutter() {
    return _instance;
  }

  Function(String)? onUrlGenerated;

  // Private constructor for singleton
  MoonpayFlutter._internal() {
    _channel.setMethodCallHandler(_handleMethodCall);
    print("MoonpayFlutter initialized with channel handler");
  }

  Future<void> _handleMethodCall(MethodCall call) async {
    switch (call.method) {
      case 'onUrlForSigningGenerated':
        final String url = call.arguments;
        print("url generated is null ? ${onUrlGenerated == null}");
        if (onUrlGenerated != null) {
          print("Calling onUrlGenerated with URL: $url");
          onUrlGenerated!(url);
        } else {
          print("WARNING: onUrlGenerated callback is null when receiving URL");
        }
        break;
      default:
        throw MissingPluginException();
    }
  }

  //possible payment methods: credit_debit_card, apple_pay, google_pay, paypal
  Future<void> showMoonPay(
      String walletAddress,
      double btcAmount,
      String language,
      String baseCurrencyCode,
      double baseCurrencyAmount,
      String paymentMethod) async {
    print(
        "ShowMoonPay called, onUrlGenerated is ${onUrlGenerated == null ? 'null' : 'set'}");
    await MoonpayFlutterPlatform.instance.showMoonPay(walletAddress, btcAmount,
        language, baseCurrencyCode, baseCurrencyAmount, paymentMethod);
  }

  Future<void> sendSignature(String signature) async {
    MoonpayFlutterPlatform.instance.sendSignature(signature);
  }

  void setOnUrlGenerated(Function(String) func) {
    print("Setting onUrlGenerated callback");
    onUrlGenerated = func;
  }
}
