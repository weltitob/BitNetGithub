import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moonpay_flutter/moonpay_flutter_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelMoonpayFlutter platform = MethodChannelMoonpayFlutter();
  const MethodChannel channel = MethodChannel('moonpay_flutter');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        return '42';
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });
}
