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
              vsync: Navigator.of(context),
            )..forward(),
            curve: Curves.easeOut,
          ),
        ),
        child: Material(
          elevation: 10.0,
          child: Container(
            padding: EdgeInsets.all(10),
            color: Colors.green,
            child: Text(
              message ?? 'Transaction received!',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    ),
  );

  // Add the overlay entry to the overlay
  Overlay.of(context)?.insert(overlayEntry);

  // Remove the overlay entry after duration
  Future.delayed(Duration(seconds: 3), () {
    overlayEntry.remove();
  });
}