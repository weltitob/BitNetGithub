import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';

// Create a StatefulWidget for the background animation
class BackgroundWithContent extends StatefulWidget {
  final Widget child;
  final double opacity;
  const BackgroundWithContent({Key? key, required this.child, required this.opacity}) : super(key: key);

  @override
  State<BackgroundWithContent> createState() => _BackgroundWithContentState();
}

// Create a State class for the background animation
class _BackgroundWithContentState extends State<BackgroundWithContent> {
  bool _visible = false; // Set initial visibility to false
  late final Future<LottieComposition> _composition; // Future to hold the Lottie animation

  @override
  void initState() {
    super.initState();
    _composition = _loadComposition(); // Load the Lottie animation
    updatevisibility(); // Update visibility
  }

  @override
  void dispose() {
    super.dispose();
  }

  // Update the visibility of the animation after a delay
  void updatevisibility() async {
    await _composition; // Wait for the animation to load
    Timer(Duration(seconds: 1), () {
      setState(() {
        _visible = true; // Set visibility to true
      });
    });
  }

  // Load the Lottie animation from the asset file
  Future<LottieComposition> _loadComposition() async {
    var assetData = await rootBundle.load('assets/lottiefiles/background.json');
    dynamic mycomposition = await LottieComposition.fromByteData(assetData);
    return mycomposition;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: double.infinity,
          width: double.infinity,
          color: Colors.black,
          child: FutureBuilder(
            future: _composition,
            builder: (context, snapshot) {
              var composition = snapshot.data;
              if (composition != null) {
                // If the composition has loaded, display the animation with an opacity animation
                return FittedBox(
                  fit: BoxFit.fitHeight,
                  child: AnimatedOpacity(
                    opacity: _visible ? 1.0 : 0.0, // Set opacity based on visibility
                    duration: Duration(milliseconds: 3000),
                    child: Image.network("https://as1.ftcdn.net/v2/jpg/05/62/07/96/1000_F_562079606_kgNe47wru5YKpyrGW9ErWTcjXOOaLhc1.jpg"),
                    //Lottie(composition: composition)
                  ),
                );
              } else {
                // If the composition has not yet loaded, display a black container
                return Container(
                  color: Colors.black,
                );
              }
            },
          ),
        ),
        Container(
          height: double.infinity,
          width: double.infinity,
          color: Colors.black.withOpacity(widget.opacity),
        ),
        widget.child,
      ],
    );
  }
}
