import 'package:get/get.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';


class RemoteConfigController extends GetxController {
  // Instance of Firebase Remote Config
  final FirebaseRemoteConfig _remoteConfig = FirebaseRemoteConfig.instance;

  // Observables for remote config values
  var adminMacaroon = ''.obs; // Admin macaroon in hex format
  ByteData? adminMacaroonByteData; // Admin macaroon in ByteData format

  // Observables for each remote config value
  var baseUrlCoinGecko = ''.obs;
  var baseUrlCoinGeckoApiPro = ''.obs;
  var baseUrlLightningTerminal = ''.obs;
  var baseUrlLightningTerminalWithPort = ''.obs;
  var baseUrlMemPoolSpaceApi = ''.obs;
  var coinGeckoApiKey = ''.obs;
  var exchangeRatesBaseUrl = ''.obs;
  var exchangeRatesMyKey = ''.obs;
  var exchangeRatesRatesUrl = ''.obs;
  var stripeLiveKey = ''.obs;
  var stripeTestKey = ''.obs;

  // Method to fetch and initialize all config values
  Future<void> fetchRemoteConfigData() async {
    try {
      // Fetch and activate the Remote Config values
      await _remoteConfig.fetchAndActivate();

      // Assign values to observables
      baseUrlCoinGecko.value = _remoteConfig.getString('baseUrlCoinGecko');
      baseUrlCoinGeckoApiPro.value = _remoteConfig.getString('baseUrlCoinGeckoApiPro');
      baseUrlLightningTerminal.value = _remoteConfig.getString('baseUrlLightningTerminal');
      baseUrlLightningTerminalWithPort.value = _remoteConfig.getString('baseUrlLightningTerminalWithPort');
      baseUrlMemPoolSpaceApi.value = _remoteConfig.getString('baseUrlMemPoolSpaceApi');
      coinGeckoApiKey.value = _remoteConfig.getString('coinGeckoApiKey');
      exchangeRatesBaseUrl.value = _remoteConfig.getString('exchangerates_baseUrl');
      exchangeRatesMyKey.value = _remoteConfig.getString('exchangerates_mykey');
      exchangeRatesRatesUrl.value = _remoteConfig.getString('exchangerates_ratesUrl');
      stripeLiveKey.value = _remoteConfig.getString('stripeLiveKey');
      stripeTestKey.value = _remoteConfig.getString('stripeTestKey');

      adminMacaroon.value = _remoteConfig.getString('adminMacaroon');
      // Decode the admin macaroon (hex -> bytes -> ByteData)
      adminMacaroonByteData = decodeAdminMacaroonHex(adminMacaroon.value);

      print("Remote Config values successfully fetched and initialized!");
    } catch (e) {
      print("Error fetching remote config data: $e");
    }
  }

  // Decode admin_macaroon from hex to ByteData
  ByteData decodeAdminMacaroonHex(String hex) {
    try {
      // Convert hex to bytes
      final macaroonBytes = hexToBytes(hex);

      // Convert to ByteData
      return ByteData.view(Uint8List.fromList(macaroonBytes).buffer);
    } catch (e) {
      throw Exception('Error decoding admin_macaroon: $e');
    }
  }

  // Fetch admin_macaroon in ByteData format (getter method)
  Future<ByteData> loadAdminMacaroonAsset() async {
    if (adminMacaroonByteData == null) {
      throw Exception('Admin macaroon is not initialized.');
    }
    return adminMacaroonByteData!;
  }

  // Utility function to convert a hex string to bytes
  List<int> hexToBytes(String hex) {
    return List.generate(hex.length ~/ 2, (i) {
      return int.parse(hex.substring(i * 2, i * 2 + 2), radix: 16);
    });
  }


  @override
  void onInit() {
    super.onInit();
    // Automatically fetch the Remote Config data when the controller is initialized
    fetchRemoteConfigData();
  }
}
