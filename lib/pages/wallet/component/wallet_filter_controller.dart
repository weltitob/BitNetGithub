import 'package:bitnet/backbone/services/base_controller/base_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WalletFilterController extends BaseController {
  Rx<DateTime> startDate = DateTime.now().obs;
  Rx<DateTime> endDate = DateTime.now().obs;

  Future<DateTime> selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (picked == null) {}
    return picked!;
  }

}
