import 'dart:async';

import 'package:bitnet/backbone/services/base_controller/base_controller.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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

/// Optimized SellSheetController with better performance and lifecycle management
class SellSheetController extends BaseController
    with GetTickerProviderStateMixin {
  late TabController controller;
  late TextEditingController satCtrlBuy;
  late TextEditingController btcCtrlBuy;
  late TextEditingController currCtrlBuy;
  FocusNode nodeSell = FocusNode();
  Rx<ButtonState> buttonState = ButtonState.idle.obs;
  
  // Debouncing timer for button actions
  Timer? _debounceTimer;

  @override
  void onInit() {
    super.onInit();
    
    // Initialize controllers
    controller = TabController(length: 3, vsync: this);
    satCtrlBuy = TextEditingController();
    btcCtrlBuy = TextEditingController();
    currCtrlBuy = TextEditingController();

    // Defer focus request to avoid conflicts during initialization
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!isClosed) {
        nodeSell.requestFocus();
      }
    });
  }

  /// Optimized button state setter with debouncing
  void setButtonState(ButtonState state) {
    // Cancel any pending state changes
    _debounceTimer?.cancel();
    
    // Debounce rapid state changes
    _debounceTimer = Timer(const Duration(milliseconds: 100), () {
      if (!isClosed) {
        buttonState.value = state;
      }
    });
  }

  @override
  void dispose() {
    // Cancel any pending timers
    _debounceTimer?.cancel();
    
    // Dispose controllers in reverse order of creation
    controller.dispose();
    nodeSell.dispose();
    currCtrlBuy.dispose();
    btcCtrlBuy.dispose();
    satCtrlBuy.dispose();
    
    super.dispose();
  }
  
  @override
  void onReady() {
    super.onReady();
    // Additional setup can be done here if needed
  }
  
  @override
  void onClose() {
    // Additional cleanup
    _debounceTimer?.cancel();
    super.onClose();
  }
}
