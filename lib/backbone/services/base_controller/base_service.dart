import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BaseService extends GetxService {
  @override
  void onInit() {
    super.onInit();
    debugPrint('onInit: $runtimeType');
  }

  @override
  void onReady() {
    super.onReady();
    debugPrint('onReady: $runtimeType');
  }

  @override
  void onClose() {
    super.onClose();
    debugPrint('onClose: $runtimeType');
  }
}
