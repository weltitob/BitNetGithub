import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:moonpay_flutter/moonpay_flutter.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final String _platformVersion = 'Unknown';
  final _moonpayFlutterPlugin = MoonpayFlutter();

  @override
  void initState() {
    super.initState();
    _moonpayFlutterPlugin.setOnUrlGenerated((url) async {
      await _moonpayFlutterPlugin.sendSignature("signature");
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
            child: GestureDetector(
          onTap: () async {
            await _moonpayFlutterPlugin.showMoonPay(
                "walletAddress", 0.005, "en", "USD", 500, "google_pay");
          },
          child: Container(
            color: Colors.black,
            width: 200,
            height: 200,
          ),
        )),
      ),
    );
  }
}
