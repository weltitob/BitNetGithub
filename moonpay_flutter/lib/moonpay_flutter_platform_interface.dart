import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'moonpay_flutter_method_channel.dart';

abstract class MoonpayFlutterPlatform extends PlatformInterface {
  /// Constructs a MoonpayFlutterPlatform.
  MoonpayFlutterPlatform() : super(token: _token);

  static final Object _token = Object();

  static MoonpayFlutterPlatform _instance = MethodChannelMoonpayFlutter();

  /// The default instance of [MoonpayFlutterPlatform] to use.
  ///
  /// Defaults to [MethodChannelMoonpayFlutter].
  static MoonpayFlutterPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [MoonpayFlutterPlatform] when
  /// they register themselves.
  static set instance(MoonpayFlutterPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<void> showMoonPay(
      String walletAddress,
      double btcAmount,
      String language,
      String baseCurrencyCode,
      double baseCurrencyAmount,
      String paymentMethod) {
    throw UnimplementedError('showMoonPay() has not been implemented');
  }

  Future<void> sendSignature(String signature) {
    throw UnimplementedError("sendSignature has not been implemented");
  }

  void setOnUrlGenerated(Function(String) func) {
    throw UnimplementedError("setOnUrlGenerated has not been implemented");
  }
}
