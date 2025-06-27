import 'dart:async';

import 'package:bitnet/backbone/cloudfunctions/moonpay/moonpay_quote_price.dart';
import 'package:bitnet/backbone/streams/currency_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class BuyController extends GetxController {
  // Form controllers
  late TextEditingController btcController;
  late TextEditingController satController;
  late TextEditingController currController;
  late FocusNode focusNode;

  // State variables
  RxString paymentMethodName = "Credit or Debit Card".obs;
  RxString paymentMethodId = "credit_debit_card".obs;
  RxString providerName = "MoonPay".obs;
  RxString providerId = "moonpay".obs;

  // MoonPay quote variables
  RxDouble moonpayQuoteCurrPrice = RxDouble(0);
  RxDouble moonpayBaseCurrPrice = RxDouble(0);

  // Timer variables
  RxInt quoteTimer = 20.obs;
  late Timer _timer;

  @override
  void onInit() {
    super.onInit();
    btcController = TextEditingController();
    satController = TextEditingController();
    currController = TextEditingController();
    focusNode = FocusNode();

    // Start quote timer
    _startQuoteTimer();
  }

  void _startQuoteTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (_) async {
      // Get context to access provider
      final context = Get.context;
      if (context == null) return;

      String? currency =
          Provider.of<CurrencyChangeProvider>(context, listen: false)
              .selectedCurrency;
      currency = currency ?? "USD";
      currency = currency.toLowerCase();

      if (quoteTimer.value == 0) {
        quoteTimer.value = 20;
        double btcAmount = double.tryParse(btcController.text) ?? 0.0;
        btcAmount = double.tryParse(btcAmount
                .toStringAsFixed(5)
                .replaceFirst(RegExp(r'\.?0+$'), '')) ??
            0.0;

        if (btcAmount > 0) {
          try {
            var quotePrice = await moonpayQuotePrice(btcAmount, currency);
            if (quotePrice != null) {
              moonpayBaseCurrPrice.value = quotePrice[0];
              moonpayQuoteCurrPrice.value = quotePrice[1];
              update(); // Add this to trigger rebuild
            }
          } catch (e) {
            // Handle error silently
            print("Failed to get MoonPay quote: $e");
          }
        } else {
          moonpayBaseCurrPrice.value = 0;
          moonpayQuoteCurrPrice.value = 0;
          update(); // Add this to trigger rebuild
        }
      } else {
        quoteTimer.value--;
        update(); // Add this to trigger rebuild
      }
    });
  }

  void setPaymentMethod({required String name, required String id}) {
    paymentMethodName.value = name;
    paymentMethodId.value = id;
    update(); // Add this to trigger rebuild
  }

  void setProvider({required String name, required String id}) {
    providerName.value = name;
    providerId.value = id;
    update(); // Add this to trigger rebuild
  }

  @override
  void onClose() {
    btcController.dispose();
    satController.dispose();
    currController.dispose();
    focusNode.dispose();
    _timer.cancel();
    super.onClose();
  }
}
