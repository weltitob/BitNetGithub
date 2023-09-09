import 'dart:async';
import 'package:bitnet/backbone/futures/openai.dart';
import 'package:bitnet/backbone/helper/helpers.dart';
import 'package:bitnet/components/container/futurelottie.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:http/http.dart' as http;

enum BackgroundType { image, lottie }

class BackgroundWithContent extends StatefulWidget {
  final Widget child;
  final double opacity;
  final BackgroundType backgroundType;
  const BackgroundWithContent(
      {Key? key,
        required this.child,
        required this.opacity,
        required this.backgroundType})
      : super(key: key);

  @override
  State<BackgroundWithContent> createState() => _BackgroundWithContentState();
}

class _BackgroundWithContentState extends State<BackgroundWithContent> {
  bool _visible = false;
  late Future<dynamic> _networkImage;
  late final Future<LottieComposition> composition;


  @override
  void initState() {
    super.initState();
    if(widget.backgroundType == BackgroundType.image){
      _networkImage = callOpenAiApiPicture(); // Replace this with your actual API call
      updateVisibility();
    } else {
      composition = loadComposition('assets/lottiefiles/line.json');
    }
  }

  void updateVisibility() async {
    await _networkImage;
    setState(() {
      _visible = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          widget.backgroundType == BackgroundType.image ? FutureBuilder<dynamic>(
            future: _networkImage,
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Container(color: Colors.black);
              } else if (snapshot.hasError) {
                return Container(color: Colors.black);
              } else {
                return AnimatedOpacity(
                  opacity: _visible ? 1.0 : 0.0,
                  duration: Duration(milliseconds: 3000),
                  child: FittedBox(
                    fit: BoxFit.fitHeight,
                    child: Image(image: NetworkImage(snapshot.data!)),
                  ) // Replace this with your actual Lottie file path
                );
              }
            },
          ) :  buildFutureLottie(composition, true),
          Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.black.withOpacity(widget.opacity),
          ),
          widget.child,
        ],
      ),
    );
  }
}
