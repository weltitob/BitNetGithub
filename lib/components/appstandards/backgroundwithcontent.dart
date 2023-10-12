import 'dart:async';
import 'package:bitnet/backbone/futures/openai.dart';
import 'package:bitnet/backbone/helper/helpers.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/container/futurelottie.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:http/http.dart' as http;

enum BackgroundType { image, lottie, asset }

class BackgroundWithContent extends StatefulWidget {
  final Widget child;
  final double opacity;
  final BackgroundType backgroundType;
  final bool withGradient; // Add this line
  const BackgroundWithContent({
    Key? key,
    required this.child,
    required this.opacity,
    required this.backgroundType,
    this.withGradient = false, // default value
  }) : super(key: key);

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
    if (widget.backgroundType == BackgroundType.image) {
      _networkImage = callOpenAiApiPicture();
      updateVisibility();
    } else if (widget.backgroundType == BackgroundType.asset) {
      // This is optional, just a dummy delay to simulate loading
      Future.delayed(Duration(milliseconds: 300)).then((_) {
        setState(() {
          _visible = true;
        });
      });
    } else {
      composition = loadComposition('assets/lottiefiles/background.json');
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
          widget.backgroundType == BackgroundType.asset
              ? Image(
                fit: BoxFit.cover,
                  image: AssetImage('assets/images/metaverse_fb.png'))
              : widget.backgroundType == BackgroundType.image
                  ? FutureBuilder<dynamic>(
                      future: _networkImage,
                      builder: (BuildContext context,
                          AsyncSnapshot<dynamic> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Container(color: Colors.black);
                        } else if (snapshot.hasError) {
                          return Container(color: Colors.black);
                        } else {
                          return AnimatedOpacity(
                              opacity: _visible ? 1.0 : 0.0,
                              duration: Duration(milliseconds: 3000),
                              child: FittedBox(
                                fit: BoxFit.fitHeight,
                                child:
                                    Image(
                                        image: NetworkImage(snapshot.data!)),
                              ) // Replace this with your actual Lottie file path
                              );
                        }
                      },
                    )
                  : buildFutureLottie(composition, true),
          Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.black.withOpacity(widget.opacity),
          ),
          if (widget.withGradient)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 1000,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    stops: [0.0, 0.25, 0.5, 0.75, 1.0],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.transparent,
                      Theme.of(context).colorScheme.background.withOpacity(0.5),
                      Theme.of(context).colorScheme.background,
                      Theme.of(context).colorScheme.background,
                    ],
                  ),
                ),
              ),
            ),
          widget.child,

        ],
      ),
    );
  }
}
