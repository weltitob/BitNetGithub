import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

Widget buildFutureLottie(Future<LottieComposition> future, bool repeat){
  return FutureBuilder(
    future: future,
    builder: (context, snapshot) {
      var composition = snapshot.data;
      if (composition != null) {
        return FittedBox(
          fit: BoxFit.fitWidth,
          child: Lottie(
            composition: composition,
            repeat: repeat,
          ),
        );
      } else {
        return Container(
          color: Colors.transparent,
        );
      }
    },
  );
}