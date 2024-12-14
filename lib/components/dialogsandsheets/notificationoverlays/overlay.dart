import 'dart:async';

import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/items/transactionitem.dart';
import 'package:bitnet/models/bitcoin/transactiondata.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vibration/vibration.dart';

void showOverlayInternet(BuildContext context, String? message, {Color color = AppTheme.successColor}) async {
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
          begin: const Offset(0, -1),
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
            padding: const EdgeInsets.all(AppTheme.elementSpacing),
            decoration: BoxDecoration(
              color: color ?? AppTheme.successColor,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(AppTheme.borderRadiusBig),
                bottomRight: Radius.circular(AppTheme.borderRadiusBig),
              ),
            ),
            child: Center(
              child: Text(
                message ?? 'Transaction received!',
                style: const TextStyle(color: Colors.white, fontSize: 16), // Optional: Adjust font size as needed
              ),
            ),
          ),
        ),
      ),
    ),
  );

  // Add the overlay entry to the overlay
  Overlay.of(context).insert(overlayEntry);

  final timer = Timer.periodic(const Duration(seconds: 2), (timer) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult != ConnectivityResult.none) {
      print('inside connectivity overlay');
      // If there is an internet connection, remove the overlay and cancel the timer
      overlayEntry.remove();

      timer.cancel();
    }
  });
}



class OverlayTransactionWidget extends StatefulWidget {
  final String? message;
  final TransactionItemData itemData;

  const OverlayTransactionWidget({
    Key? key,
    this.message,
    required this.itemData,
  }) : super(key: key);

  @override
  _OverlayTransactionWidgetState createState() => _OverlayTransactionWidgetState();

  static Future<void> showOverlayTransaction(
      BuildContext context,
      String? message,
      TransactionItemData itemData,
      ) async {
    if (await Vibration.hasVibrator() ?? false) {
      Vibration.vibrate();
    }

    if (!context.mounted) return;

    // Create the overlay entry
    final overlayEntry = OverlayEntry(
      builder: (overlayContext) {
        return OverlayTransactionWidget(
          message: message,
          itemData: itemData,
        );
      },
    );

    // Insert into the overlay
    Overlay.of(context)?.insert(overlayEntry);

    // Remove after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      overlayEntry.remove();
    });
  }
}

class _OverlayTransactionWidgetState extends State<OverlayTransactionWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0, -1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    // Start the animation after the first frame is rendered
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: SlideTransition(
        position: _offsetAnimation,
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
                      widget.message ?? 'Transaction received!',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
                const SizedBox(height: AppTheme.elementSpacing),
                TransactionItem(
                  data: widget.itemData,
                  context: context,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


void showOverlay(BuildContext context, String? message, {Color color = AppTheme.successColor}) async {
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
          begin: const Offset(0, -1),
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
          shadowColor: Colors.transparent,
          color: Colors.transparent,
          elevation: 10.0,
          child: Container(
            height: 100, // Set the height to 200
            padding: const EdgeInsets.all(AppTheme.elementSpacing),
            decoration: BoxDecoration(
              color: color ?? AppTheme.successColor,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(AppTheme.borderRadiusBig),
                bottomRight: Radius.circular(AppTheme.borderRadiusBig),
              ),
            ),
            child: Center(
              child: Text(
                message ?? 'Transaction received!',
                style: const TextStyle(color: Colors.white, fontSize: 16), // Optional: Adjust font size as needed
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
  Future.delayed(const Duration(seconds: 3), () {
    overlayEntry.remove();
  });
}

void showOverlayTransaction(BuildContext context, String? message, TransactionItemData itemData) async {
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
          begin: const Offset(0, -1),
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
                    const SizedBox(
                      width: AppTheme.elementSpacing / 2,
                    ),
                    Text(
                      message ?? 'Transaction received!',
                      style: Theme.of(context).textTheme.titleLarge, // Optional: Adjust font size as needed
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

  // Add the overlay entry to the overlay
  Overlay.of(context).insert(overlayEntry);

  // Remove the overlay entry after a duration
  Future.delayed(const Duration(seconds: 3), () {
    overlayEntry.remove();
  });
}
