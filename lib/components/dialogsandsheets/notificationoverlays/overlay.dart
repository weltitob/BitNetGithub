import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:flutter/material.dart';

void showOverlay(BuildContext context, String? message) {
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
            height: 200, // Set the height to 200
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(AppTheme.borderRadiusBig),
                bottomRight: Radius.circular(AppTheme.borderRadiusBig),
              ),
            ),
            child: Center(
              child: Text(
                message ?? 'Transaction received!',
                style: TextStyle(color: Colors.white, fontSize: 16), // Optional: Adjust font size as needed
              ),
            ),
          ),
        ),
      ),
    ),
  );

  // Add the overlay entry to the overlay
  Overlay.of(context)?.insert(overlayEntry);

  // Remove the overlay entry after a duration
  Future.delayed(Duration(seconds: 3), () {
    overlayEntry.remove();
  });
}
