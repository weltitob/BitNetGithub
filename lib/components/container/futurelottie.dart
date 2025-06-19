import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class FutureLottieWidget extends StatefulWidget {
  final Future<LottieComposition> future;
  final bool repeat;

  const FutureLottieWidget({
    super.key,
    required this.future,
    required this.repeat,
  });

  @override
  State<FutureLottieWidget> createState() => _FutureLottieWidgetState();
}

class _FutureLottieWidgetState extends State<FutureLottieWidget> {
  late final Future<LottieComposition> _cachedFuture;

  @override
  void initState() {
    super.initState();
    _cachedFuture = widget.future;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _cachedFuture,
      builder: (context, snapshot) {
        var composition = snapshot.data;
        if (composition != null) {
          return FittedBox(
            fit: BoxFit.fitWidth,
            child: Lottie(
              composition: composition,
              repeat: widget.repeat,
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}

// Backwards compatibility function
Widget buildFutureLottie(Future<LottieComposition> future, bool repeat) {
  return FutureLottieWidget(future: future, repeat: repeat);
}