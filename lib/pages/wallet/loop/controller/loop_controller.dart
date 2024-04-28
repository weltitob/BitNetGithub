import 'dart:developer';

import 'package:bitnet/backbone/cloudfunctions/lnd/pool/get_loopin_quote.dart';
import 'package:bitnet/backbone/cloudfunctions/lnd/pool/get_loopout_quote.dart';
import 'package:bitnet/components/dialogsandsheets/notificationoverlays/overlay.dart';
import 'package:bitnet/models/loop/loop_quote_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoopGetxController extends GetxController {
  //Animate value true is onchain to lightning
  //false is lightning to onchain
  RxBool animate = false.obs;
  RxBool loadingState = false.obs;

  TextEditingController btcController = TextEditingController();
  TextEditingController currencyController = TextEditingController();

  void changeAnimate() {
    animate.value = !animate.value;
    log('Animate Value: ${animate.value}');
  }

  void updateLoadingState(bool value) {
    loadingState.value = value;
  }

  void loopInQuote(BuildContext context, String price) async {
    log('this is the loopin amount ${btcController.text}');
    if (btcController.text != '0.00') {
      updateLoadingState(true);
      final response = await getLoopinQuote(price);
      if (response.statusCode == 'error') {
        showOverlay(context, response.message);
      } else {
        final loop = LoopQuoteModel.fromJson(response.data);
        log('This is the loop in swap fee in sat ${loop.swapFeeSat}');
      }
      updateLoadingState(false);
    } else {
      showOverlay(context, 'Please enter an amount');
    }
  }

  void loopOutQuote(BuildContext context, String price) async {
    if (btcController.text != '0.00') {
      log('this is the loopout amount ${btcController.text}');
      updateLoadingState(true);
      final response = await getLoopOutQuote(price);
      if (response.statusCode == 'error') {
        showOverlay(context, response.message);
      } else {
        final loop = LoopQuoteModel.fromJson(response.data);
        log('This is the loop out swap fee in sat ${loop.swapFeeSat}');
      }
      updateLoadingState(false);
    } else {
      showOverlay(context, 'Please enter an amount');
    }
  }
}
