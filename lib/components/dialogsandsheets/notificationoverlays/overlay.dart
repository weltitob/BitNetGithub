import 'dart:async';
import 'package:bitnet/components/container/imagewithtext.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vibration/vibration.dart';
import 'package:bitnet/components/items/transactionitem.dart';
import 'package:bitnet/models/bitcoin/transactiondata.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';

class OverlayController extends GetxController
    with SingleGetTickerProviderMixin {
  // Rx variable to manage the current overlay entry
  Rx<OverlayEntry?> overlayEntry = Rx<OverlayEntry?>(null);

  // 1) Simple Text Overlay
  Future<void> showOverlay(String? message,
      {Color color = AppTheme.successColor}) async {
    final overlayContext = Get.overlayContext;
    if (overlayContext == null) {
      debugPrint("No overlay context found. Cannot display overlay.");
      return;
    }

    // Trigger vibration
    if (await Vibration.hasVibrator() ?? false) {
      Vibration.vibrate();
    }

    final animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    )..forward();

    final offsetAnimation = Tween<Offset>(
      begin: const Offset(0, -1),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: animationController, curve: Curves.easeOut),
    );

    final overlay = OverlayEntry(
      builder: (_) => Positioned(
        top: 0,
        left: 0,
        right: 0,
        child: SlideTransition(
          position: offsetAnimation,
          child: Material(
            type: MaterialType.transparency,
            child: Container(
              decoration: BoxDecoration(
                color: color,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(AppTheme.borderRadiusBig),
                  bottomRight: Radius.circular(AppTheme.borderRadiusBig),
                ),
              ),
              child: Center(
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: AppTheme.cardPadding * 1, horizontal: AppTheme.cardPadding),
                  child: Text(
                    message ?? 'Success!',
                    style: Theme.of(Get.context!).textTheme.titleMedium!.copyWith(color: darken(color, 70)),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );

    Overlay.of(overlayContext)?.insert(overlay);
    overlayEntry.value = overlay;

    // Remove the overlay after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      overlay.remove();
      animationController.dispose();
    });
  }

  // 2) Internet Connectivity Overlay
  Future<void> showOverlayInternet(String? message,
      {Color color = AppTheme.successColor}) async {
    final overlayContext = Get.overlayContext;
    if (overlayContext == null) {
      debugPrint("No overlay context found. Cannot display overlay.");
      return;
    }

    // Trigger vibration
    if (await Vibration.hasVibrator() ?? false) {
      Vibration.vibrate();
    }

    final animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    )..forward();

    final offsetAnimation = Tween<Offset>(
      begin: const Offset(0, -1),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: animationController, curve: Curves.easeOut),
    );

    final overlay = OverlayEntry(
      builder: (_) => Positioned(
        top: 0,
        left: 0,
        right: 0,
        child: SlideTransition(
          position: offsetAnimation,
          child: Material(
            type: MaterialType.transparency,
            child: Container(
              decoration: BoxDecoration(
                color: color,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(AppTheme.borderRadiusBig),
                  bottomRight: Radius.circular(AppTheme.borderRadiusBig),
                ),
              ),
              padding: const EdgeInsets.all(AppTheme.elementSpacing),
              child: Center(
                child: Text(
                  message ?? 'Transaction received!',
                  style: Theme.of(Get.context!).textTheme.titleMedium!.copyWith(color: darken(color, 70)),
                ),
              ),
            ),
          ),
        ),
      ),
    );

    Overlay.of(overlayContext)?.insert(overlay);
    overlayEntry.value = overlay;

    // Check connectivity every 2 seconds and remove overlay once online
    Timer.periodic(const Duration(seconds: 2), (timer) async {
      final connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult != ConnectivityResult.none) {
        overlay.remove();
        animationController.dispose();
        timer.cancel();
      }
    });
  }

  // 3) Transaction Overlay
  Future<void> showOverlayTransaction(
      String? message, TransactionItemData itemData) async {
    final overlayContext = Get.overlayContext;
    final providerContext = Get.context;
    if (overlayContext == null) {
      debugPrint("No overlay context found. Cannot display overlay.");
      return;
    }

    // Trigger vibration
    if (await Vibration.hasVibrator() ?? false) {
      Vibration.vibrate();
    }

    final animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    )..forward();

    final offsetAnimation = Tween<Offset>(
      begin: const Offset(0, -1),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: animationController, curve: Curves.easeOut),
    );

    final overlay = OverlayEntry(
      builder: (_) => Positioned(
        top: 0,
        left: 0,
        right: 0,
        child: SlideTransition(
          position: offsetAnimation,
          child: Material(
            type: MaterialType.transparency,
            child: Container(
              height: AppTheme.cardPadding * 8,
              decoration: const BoxDecoration(
                color: AppTheme.successColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(AppTheme.borderRadiusBig),
                  bottomRight: Radius.circular(AppTheme.borderRadiusBig),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: AppTheme.cardPadding),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.check_circle_outline_rounded,
                        size: AppTheme.cardPadding * 1.25,
                        color: darken(AppTheme.successColor, 70),
                      ),
                      const SizedBox(width: AppTheme.elementSpacing / 2),
                      Text(
                        message ?? 'Transaction received!',
                        style: Theme.of(Get.context!).textTheme.titleMedium!.copyWith(color: darken(AppTheme.successColor, 70)),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppTheme.elementSpacing),
                  // Transaction Item
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppTheme.cardPadding),
                    child: GlassContainer(
                      customColor: Theme.of(Get.context!).colorScheme.background,
                      child: TransactionItem(
                        data: itemData,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );

    Overlay.of(overlayContext)?.insert(overlay);
    overlayEntry.value = overlay;

    Future.delayed(const Duration(seconds: 3), () {
      overlay.remove();
      animationController.dispose();
    });
  }

  // Method to manually remove any active overlay
  void removeOverlay() {
    overlayEntry.value?.remove();
    overlayEntry.value = null;
  }
}
