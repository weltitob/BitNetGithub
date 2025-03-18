import 'dart:io';
import 'dart:typed_data';

import 'package:bitnet/backbone/cloudfunctions/aws/litd_controller.dart';
import 'package:bitnet/backbone/helper/http_no_ssl.dart';
import 'package:bitnet/backbone/helper/loadmacaroon.dart';
import 'package:bitnet/backbone/services/base_controller/dio/dio_service.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:bitnet/models/firebase/restresponse.dart';
import 'package:get/get.dart';

Future<List<double>?> moonpayQuotePrice(
  double quoteCurrencyAmount,
  String baseCurrencyCode,
) async {
  final logger = Get.find<LoggerService>();
  final DioClient dioClient = Get.find<DioClient>();

  // const String macaroonPath = 'assets/keys/lnd_admin.macaroon'; // Update the path to the macaroon file
  String url =
      'https://api.moonpay.com/v3/currencies/btc/buy_quote?baseCurrencyCode=$baseCurrencyCode&quoteCurrencyAmount=$quoteCurrencyAmount&apiKey=pk_test_HInzm5oiHpMjfu7cC2CLzQ31YgH7LaA';

  HttpOverrides.global = MyHttpOverrides();

  try {
    var response = await dioClient.get(url: url, headers: {});

    // Print raw response for debugging
    logger.i('Raw Response getting channel balance: ${response.data}');

    if (response.statusCode == 200) {
      //print(json.decode(response.data));
      return [
        response.data['baseCurrencyAmount'],
        response.data['quoteCurrencyAmount']
      ];
    } else {
      print('Failed to load data: ${response.statusCode}, ${response.data}');
      return null;
    }
  } catch (e) {
    logger.e('Error retriving moonpay quote price: $e');
    return null;
  }
}
