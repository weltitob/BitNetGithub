import 'dart:developer';

import 'package:bitnet/backbone/cloudfunctions/lnd/pool/get_loopin_quote.dart';
import 'package:bitnet/backbone/cloudfunctions/lnd/pool/get_loopout_quote.dart';
import 'package:bitnet/models/loop/loop_quote_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoopGetxController extends GetxController {
  //Animate value true is onchain to lightning
  //false is lightning to onchain
  RxBool animate = false.obs;
  RxBool loadingState = false.obs;

  void changeAnimate() {
    animate.value = !animate.value;
    log('Animate Value: ${animate.value}');
  }

  void updateLoadingState(bool value) {
    loadingState.value = value;
  }

  void loopInQuote(BuildContext context) async {
    updateLoadingState(true);
    final response = await getLoopinQuote('20000');
    if (response.statusCode == 'error') {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(response.message)));
    } else {
      final loop = LoopQuoteModel.fromJson(response.data);
      log('This is the swap fee in sat ${loop.swapFeeSat}');
    }
    updateLoadingState(false);
  }
}
