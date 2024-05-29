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

  @override
  void onInit() {
    super.onInit();

    controller = TabController(length: 3, vsync: this);
    satCtrlBuy = TextEditingController();
    btcCtrlBuy = TextEditingController();
    currCtrlBuy = TextEditingController();
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
