import 'package:bitnet/backbone/services/base_controller/base_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WalletFilterController extends BaseController {
  Rx<DateTime> startDate = DateTime(2024).obs;
  Rx<DateTime> endDate = DateTime.now().obs;
  RxList<String> selectedFilters = [''].obs;
  RxBool change = true.obs;
  RxList<dynamic> filterList = [].obs;
  int start = 0, end = 0;

  void toggleFilter(String filter) {
    if (selectedFilters.contains(filter)) {
      selectedFilters.remove(filter);
    } else {
      selectedFilters.add(filter);
    }
    change.value = true;
  }

  @override
  void onInit() async {
    super.onInit();
    start = startDate.value.millisecondsSinceEpoch ~/ 1000;
    end = endDate.value.millisecondsSinceEpoch ~/ 1000;
  }

  initialDate(int time) {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(time * 1000);
    startDate.value = date;
  }

  initialLoopDate(int nanoseconds) {
    int microseconds = nanoseconds ~/ 1000;
    DateTime date = DateTime.fromMicrosecondsSinceEpoch(microseconds);
    startDate.value = date;
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
