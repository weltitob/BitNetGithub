import 'package:bitnet/backbone/services/base_controller/base_controller.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BitcoinScreenController extends BaseController
    with GetSingleTickerProviderStateMixin {
  final controller = ScrollController();
  late TextEditingController satCtrlSell;
  late TextEditingController btcCtrlSell;
  late TextEditingController currCtrlSell;

  ButtonState buttonState = ButtonState.idle;
  FocusNode nodeSell = FocusNode();

  @override
  void onInit() {
    super.onInit(); 
    satCtrlSell = TextEditingController();
    btcCtrlSell = TextEditingController();
    currCtrlSell = TextEditingController();
  }

  @override
  void dispose() {
    satCtrlSell.dispose();
    btcCtrlSell.dispose();
    currCtrlSell.dispose();
    nodeSell.dispose();
    super.dispose();
  }
}
