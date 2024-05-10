import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoopsController extends GetxController {
  RxBool animate = false.obs;
  TextEditingController btcController = TextEditingController(text: '123');
  TextEditingController currController = TextEditingController();
  FocusNode node = FocusNode();

  @override
  void dispose() {
    btcController.dispose();
    currController.dispose();
    node.dispose();
    super.dispose();
  }

  void changeAnimate() {
       animate.value = !animate.value;
   }
}
