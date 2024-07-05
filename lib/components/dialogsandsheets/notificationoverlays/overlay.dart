import 'dart:async';

import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/items/transactionitem.dart';
import 'package:bitnet/models/bitcoin/transactiondata.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';


void showOverlayInternet(
    BuildContext context, String? message,
    {Color color = AppTheme.successColor}) async {
  // Trigger a simple vibration
  if (await Vibration.hasVibrator() ?? false) {
    Vibration.vibrate();
  }

  var overlayEntry = OverlayEntry(
    builder: (context) => Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: Offset(0, -1),
          end: Offset.zero,
        ).animate(
          CurvedAnimation(
            parent: AnimationController(
              duration: const Duration(milliseconds: 300),
              vsync: Navigator.of(context), // This needs a TickerProvider
            )..forward(),
            curve: Curves.easeOut,
          ),
        ),
        child: Material(
          elevation: 10.0,
          child: Container(
            height: 100, // Set the height to 200
            padding: EdgeInsets.all(AppTheme.elementSpacing),
            decoration: BoxDecoration(
              color: color ?? AppTheme.successColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(AppTheme.borderRadiusBig),
                bottomRight: Radius.circular(AppTheme.borderRadiusBig),
              ),
            ),
            child: Center(
              child: Text(
                message ?? 'Transaction received!',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16), // Optional: Adjust font size as needed
              ),
            ),
          ),
        ),
      ),
    ),
  );

  // Add the overlay entry to the overlay
  Overlay.of(context).insert(overlayEntry);

  
  final timer = Timer.periodic(Duration(seconds: 2), (timer) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult != ConnectivityResult.none) {
      print('inside connectivity overlay');
      // If there is an internet connection, remove the overlay and cancel the timer
      overlayEntry.remove();

       timer.cancel();
    }
  });
}
void showOverlay(BuildContext context, String? message,
    {Color color = AppTheme.successColor}) async {
  // Trigger a simple vibration
  if (await Vibration.hasVibrator() ?? false) {
    Vibration.vibrate();
  }

  var overlayEntry = OverlayEntry(
    builder: (context) => Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: Offset(0, -1),
          end: Offset.zero,
        ).animate(
          CurvedAnimation(
            parent: AnimationController(
              duration: const Duration(milliseconds: 300),
              vsync: Navigator.of(context), // This needs a TickerProvider
            )..forward(),
            curve: Curves.easeOut,
          ),
        ),
        child: Material(
          elevation: 10.0,
          child: Container(
            height: 100, // Set the height to 200
            padding: EdgeInsets.all(AppTheme.elementSpacing),
            decoration: BoxDecoration(
              color: color ?? AppTheme.successColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(AppTheme.borderRadiusBig),
                bottomRight: Radius.circular(AppTheme.borderRadiusBig),
              ),
            ),
            child: Center(
              child: Text(
                message ?? 'Transaction received!',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16), // Optional: Adjust font size as needed
              ),
            ),
          ),
        ),
      ),
    ),
  );

  // Add the overlay entry to the overlay
  Overlay.of(context).insert(overlayEntry);

  // Remove the overlay entry after a duration
  Future.delayed(Duration(seconds: 3), () {
    overlayEntry.remove();
  });
}

void showOverlayTransaction(
    BuildContext context, String? message, TransactionItemData itemData) async {
  // Trigger a simple vibration
  if (await Vibration.hasVibrator() ?? false) {
    Vibration.vibrate();
  }

  var overlayEntry = OverlayEntry(
    builder: (context) => Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: Offset(0, -1),
          end: Offset.zero,
        ).animate(
          CurvedAnimation(
            parent: AnimationController(
              duration: const Duration(milliseconds: 200),
              vsync: Navigator.of(context), // This needs a TickerProvider
            )..forward(),
            curve: Curves.easeOut,
          ),
        ),
        child: Material(
          elevation: 10.0,
          child: Container(
            height: AppTheme.cardPadding * 8, // Set the height to 200
            decoration: BoxDecoration(
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
                SizedBox(height: AppTheme.cardPadding),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.check_circle_outline_rounded,
                      size: AppTheme.cardPadding * 1.25,
                    ),
                    SizedBox(
                      width: AppTheme.elementSpacing / 2,
                    ),
                    Text(
                      message ?? 'Transaction received!',
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge, // Optional: Adjust font size as needed
                    ),
                  ],
                ),
                SizedBox(height: AppTheme.elementSpacing),
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

  // Add the overlay entry to the overlay
  Overlay.of(context).insert(overlayEntry);

  // Remove the overlay entry after a duration
  Future.delayed(Duration(seconds: 3), () {
    overlayEntry.remove();
  });
}
