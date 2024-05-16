import 'package:bitnet/backbone/services/base_controller/base_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WalletFilterController extends BaseController {
  Rx<DateTime> startDate = DateTime(2024).obs;
  Rx<DateTime> endDate = DateTime.now().obs;
  RxList<String> selectedFilters = [''].obs;
  RxBool change = true.obs;
  RxList<dynamic> filterList = [].obs;



  void toggleFilter(String filter) {
      if (selectedFilters.contains(filter)) {
        selectedFilters.remove(filter);
      } else {
        selectedFilters.add(filter);
      }
      change.value = true;
  }


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
