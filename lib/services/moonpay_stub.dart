// Stub implementation of moonpay_flutter for web
// This file provides empty implementations of the MoonpayFlutter class methods
// to allow compiling for web platforms where moonpay_flutter is not available

class MoonpayFlutter {
  static final MoonpayFlutter _instance = MoonpayFlutter._internal();

  // Add onUrlGenerated property that will always be null in stub
  Function(String)? onUrlGenerated;

  factory MoonpayFlutter() {
    return _instance;
  }

  MoonpayFlutter._internal();

  void showMoonPay(String address, double btcAmount, String lang,
      String currency, double fiatAmount, String paymentMethodId) {
    // Empty implementation for web
    print('MoonPay not available on web');
  }

  void setOnUrlGenerated(Function(String url) callback) {
    // Store the callback but never call it in the stub
    onUrlGenerated = callback;
    print('MoonPay URL generation not available on web');
  }

  void sendSignature(String signature) {
    // Empty implementation for web
    print('MoonPay signature not available on web');
  }
}
