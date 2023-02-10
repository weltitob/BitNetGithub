import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';

class BackgroundAuth extends StatefulWidget {
  const BackgroundAuth({Key? key}) : super(key: key);

  @override
  State<BackgroundAuth> createState() => _BackgroundAuthState();
}

class _BackgroundAuthState extends State<BackgroundAuth> {

  bool _visible = false;
  late final Future<LottieComposition> _composition;

  @override
  void initState() {
    super.initState();
    _composition = _loadComposition();
    updatevisibility();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void updatevisibility() async {
    await _composition;
    var timer = Timer(Duration(seconds: 1),
            () {
          setState(() {
            _visible = true;
          });
        }
    );
  }

  Future<LottieComposition> _loadComposition() async {
    var assetData = await rootBundle.load('assets/lottiefiles/background.json');
    dynamic mycomposition = await LottieComposition.fromByteData(assetData);
    return mycomposition;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: Colors.black,
      child: FutureBuilder(
        future: _composition,
        builder: (context, snapshot) {
          var composition = snapshot.data;
          if (composition != null) {
            return FittedBox(
              fit: BoxFit.fitHeight,
              child: AnimatedOpacity(
                opacity: _visible ? 1.0 : 0.0,
                duration: Duration(milliseconds: 3000),
                child: Lottie(composition: composition),
              ),
            );
          } else {
            return Container(
              color: Colors.black,
            );
          }
        },
      ),
    );
  }
}
