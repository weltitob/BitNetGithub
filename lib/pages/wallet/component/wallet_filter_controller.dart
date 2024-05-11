import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WalletFilterController extends GetxController {
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
