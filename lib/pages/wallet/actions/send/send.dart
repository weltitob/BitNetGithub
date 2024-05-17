import 'package:bitnet/pages/wallet/actions/send/controllers/send_controller.dart';
import 'package:bitnet/pages/wallet/actions/send/search_receiver.dart';
import 'package:bitnet/pages/wallet/actions/send/send_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Send extends GetWidget<SendsController> {
  const Send({super.key});

  @override
  Widget build(BuildContext context) {

    controller.processParameters(context, null);

    return Obx(() =>
        controller.hasReceiver.value ? SendBTCScreen() : SearchReceiver());
  }
}
