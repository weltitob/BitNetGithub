import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vibration/vibration.dart';
import 'package:bitnet/components/items/transactionitem.dart';
import 'package:bitnet/models/bitcoin/transactiondata.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';

class OverlayController extends GetxController {
  // Rx-Variablen zur Verwaltung des Overlay-Zustands
  Rx<OverlayEntry?> overlayEntry = Rx<OverlayEntry?>(null);

  // Methode zum Anzeigen eines einfachen Text-Overlays
  void showOverlay(BuildContext context, String? message, {Color color = AppTheme.successColor}) async {
    // Trigger vibration
    if (await Vibration.hasVibrator() ?? false) {
      Vibration.vibrate();
    }

    final overlay = OverlayEntry(
      builder: (context) => Positioned(
        top: 0,
        left: 0,
        right: 0,
        child: SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, -1),
            end: Offset.zero,
          ).animate(CurvedAnimation(
            parent: AnimationController(
              duration: const Duration(milliseconds: 300),
              vsync: Navigator.of(context),
            )..forward(),
            curve: Curves.easeOut,
          )),
          child: Material(
            elevation: 10.0,
            child: Container(
              padding: const EdgeInsets.all(AppTheme.elementSpacing),
              decoration: BoxDecoration(
                color: color,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(AppTheme.borderRadiusBig),
                  bottomRight: Radius.circular(AppTheme.borderRadiusBig),
                ),
              ),
              child: Center(
                child: Text(
                  message ?? 'Transaction received!',
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ),
        ),
      ),
    );

    // Add overlay entry to the overlay
    Overlay.of(context)?.insert(overlay);
    overlayEntry.value = overlay;

    // Remove the overlay entry after a duration
    Future.delayed(const Duration(seconds: 3), () {
      overlay.remove();
    });
  }

  // Methode zum Anzeigen eines Internet-Verbindungs-Overlays
  void showOverlayInternet(BuildContext context, String? message, {Color color = AppTheme.successColor}) async {
    // Trigger vibration
    if (await Vibration.hasVibrator() ?? false) {
      Vibration.vibrate();
    }

    final overlay = OverlayEntry(
      builder: (context) => Positioned(
        top: 0,
        left: 0,
        right: 0,
        child: SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, -1),
            end: Offset.zero,
          ).animate(CurvedAnimation(
            parent: AnimationController(
              duration: const Duration(milliseconds: 300),
              vsync: Navigator.of(context),
            )..forward(),
            curve: Curves.easeOut,
          )),
          child: Material(
            elevation: 10.0,
            child: Container(
              padding: const EdgeInsets.all(AppTheme.elementSpacing),
              decoration: BoxDecoration(
                color: color,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(AppTheme.borderRadiusBig),
                  bottomRight: Radius.circular(AppTheme.borderRadiusBig),
                ),
              ),
              child: Center(
                child: Text(
                  message ?? 'Transaction received!',
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ),
        ),
      ),
    );

    // Add overlay entry to the overlay
    Overlay.of(context)?.insert(overlay);
    overlayEntry.value = overlay;

    // Connectivity check to remove the overlay after 2 seconds if internet is available
    Timer.periodic(const Duration(seconds: 2), (timer) async {
      var connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult != ConnectivityResult.none) {
        overlay.remove();
        timer.cancel();
      }
    });
  }

  // Methode zum Anzeigen eines Transaktions-Overlays
  void showOverlayTransaction(BuildContext context, String? message, TransactionItemData itemData) async {
    // Trigger vibration
    if (await Vibration.hasVibrator() ?? false) {
      Vibration.vibrate();
    }

    final overlay = OverlayEntry(
      builder: (context) => Positioned(
        top: 0,
        left: 0,
        right: 0,
        child: SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, -1),
            end: Offset.zero,
          ).animate(CurvedAnimation(
            parent: AnimationController(
              duration: const Duration(milliseconds: 300),
              vsync: Navigator.of(context),
            )..forward(),
            curve: Curves.easeOut,
          )),
          child: Material(
            elevation: 10.0,
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.check_circle_outline_rounded,
                        size: AppTheme.cardPadding * 1.25,
                      ),
                      const SizedBox(width: AppTheme.elementSpacing / 2),
                      Text(
                        message ?? 'Transaction received!',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ],
                  ),
                  const SizedBox(height: AppTheme.elementSpacing),
                  TransactionItem(
                    data: itemData,
                    context: context,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );

    // Insert overlay into the overlay stack
    Overlay.of(context)?.insert(overlay);
    overlayEntry.value = overlay;

    // Remove overlay after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      overlay.remove();
    });
  }

  // Methode zum Entfernen des Overlays
  void removeOverlay() {
    overlayEntry.value?.remove();
    overlayEntry.value = null;
  }
}
