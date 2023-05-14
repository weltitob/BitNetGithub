import 'dart:async';
import 'dart:convert';
import 'package:BitNet/backbone/futures/openai.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:http/http.dart' as http;
import 'package:BitNet/models/openai_image.dart';

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
  late final Future<LottieComposition> _composition;
  late final Future<dynamic> _networkimage;// Future to hold the Lottie animation

  @override
  void initState() {
    super.initState();
    _networkimage = callOpenAiApiPicture();
    setState(() {});
    //_composition = _loadComposition(); // Load the Lottie animation
    updatevisibility();
  }

  @override
  void dispose() {
    super.dispose();
  }

  // Update the visibility of the animation after a delay
  void updatevisibility() async {
    await _networkimage;
    setState(() {});
    //await _composition; // Wait for the animation to load
    Timer(Duration(seconds: 3), () {
      setState(() {
        _visible = true; // Set visibility to true
      });
    });
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
            future: _networkimage,
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container(
                    color: Colors.black,
                  );
                } else if (snapshot.hasError) {
                  return Container(
                    color: Colors.black,
                  );
                } else {
                  return FittedBox(
                    fit: BoxFit.fitHeight,
                    child: AnimatedOpacity(
                      opacity: _visible ? 1.0 : 0.0, // Set opacity based on visibility
                      duration: Duration(milliseconds: 3000),
                      child: Image(
                        image: snapshot.data!,
                      ),
                      //Lottie(composition: composition)
                    ),
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
