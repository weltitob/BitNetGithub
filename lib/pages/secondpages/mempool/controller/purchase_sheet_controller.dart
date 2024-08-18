import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bitnet/backbone/services/base_controller/base_controller.dart';
class PurchaseSheetController extends BaseController
    with GetTickerProviderStateMixin {
  late TabController controller;
  late TextEditingController satCtrlBuy;
  late TextEditingController btcCtrlBuy;
  late TextEditingController currCtrlBuy;
  FocusNode nodeBuy = FocusNode();
  Rx<ButtonState> buttonState = ButtonState.idle.obs;

  void setButtonState(ButtonState state) {
    buttonState.value = state;
  }

  @override
  void onInit() {
    super.onInit();

    controller = TabController(length: 3, vsync: this);
    satCtrlBuy = TextEditingController();
    btcCtrlBuy = TextEditingController();
    currCtrlBuy = TextEditingController();

    // Request focus on the nodeBuy as soon as the controller is initialized
    nodeBuy.requestFocus();
  }

  @override
  void dispose() {
    satCtrlBuy.dispose();
    btcCtrlBuy.dispose();
    currCtrlBuy.dispose();
    nodeBuy.dispose();
    controller.dispose();
    super.dispose();
  }
}

class SellSheetController extends BaseController
    with GetTickerProviderStateMixin {
  late TabController controller;
  late TextEditingController satCtrlBuy;
  late TextEditingController btcCtrlBuy;
  late TextEditingController currCtrlBuy;
  FocusNode nodeSell = FocusNode();
  Rx<ButtonState> buttonState = ButtonState.idle.obs;

  @override
  void onInit() {
    super.onInit();
    controller = TabController(length: 3, vsync: this);
    satCtrlBuy = TextEditingController();
    btcCtrlBuy = TextEditingController();
    currCtrlBuy = TextEditingController();

    // Request focus on the nodeBuy as soon as the controller is initialized
    nodeSell.requestFocus();
  }

  @override
  void dispose() {
    satCtrlBuy.dispose();
    btcCtrlBuy.dispose();
    currCtrlBuy.dispose();
    nodeSell.dispose();
    controller.dispose();
    super.dispose();
  }
}
