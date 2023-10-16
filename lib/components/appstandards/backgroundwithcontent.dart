import 'dart:async';
import 'package:bitnet/backbone/futures/openai.dart';
import 'package:bitnet/backbone/helper/helpers.dart';
import 'package:bitnet/components/container/futurelottie.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:http/http.dart' as http;

enum BackgroundType { image, lottie, asset }

class BackgroundWithContent extends StatefulWidget {
  final Widget child;
  final double opacity;
  final BackgroundType backgroundType;
  final bool withGradientBottomBig; // Add this line
  final bool withGradientBottomMedium; // Add this line
  final bool withGradientBottomSmall; // Add this line
  final bool withGradientTopBig; // Add this line
  final bool withGradientTopMedium; // Add this line
  final bool withGradientTopSmall;
  final bool withGradientLeftBig;
  final bool withGradientLeftMedium;
  final bool withGradientLeftSmall;
  final bool withGradientRightBig;
  final bool withGradientRightMedium;
  final bool withGradientRightSmall;
  final String assetPath;
  final String lottieassetPath;
  const BackgroundWithContent({
    Key? key,
    required this.child,
    required this.opacity,
    required this.backgroundType,
    this.withGradientBottomBig = false,
    this.withGradientBottomMedium = false,
    this.withGradientBottomSmall = false,
    this.withGradientTopBig = false,
    this.withGradientTopMedium = false,
    this.withGradientTopSmall = false,
    this.withGradientLeftBig = false,
    this.withGradientLeftMedium = false,
    this.withGradientLeftSmall = false,
    this.withGradientRightBig = false,
    this.withGradientRightMedium = false,
    this.withGradientRightSmall = false,
    this.assetPath = 'assets/images/metaverse_fb.png',
    this.lottieassetPath = 'assets/lottiefiles/background.json',

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
      composition = loadComposition(widget.lottieassetPath);
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
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          widget.backgroundType == BackgroundType.asset
              ? Container(
                  height: screenHeight,
                  width: double.infinity,
                  child: Image(
                      fit: BoxFit.cover,
                      image: AssetImage(widget.assetPath)))
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
                                fit: BoxFit.cover,
                                child:
                                    Image(image: NetworkImage(snapshot.data!)),
                              ) // Replace this with your actual Lottie file path
                              );
                        }
                      },
                    )
                  : widget.backgroundType == BackgroundType.lottie ? buildFutureLottie(composition, true) : Container(),
          Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.black.withOpacity(widget.opacity),
          ),
          //this is bottom gradient
          if (widget.withGradientBottomBig)
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
          if (widget.withGradientBottomMedium)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 750,
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
          if (widget.withGradientBottomSmall)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 500,
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
          //------------TOP---------------
          if (widget.withGradientTopBig)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 1000,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    stops: [0.0, 0.25, 0.5, 0.75, 1.0],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.transparent,
                      Theme.of(context).colorScheme.background.withOpacity(0.25),
                      Theme.of(context).colorScheme.background.withOpacity(0.5),
                      Theme.of(context).colorScheme.background.withOpacity(0.75),
                      Theme.of(context).colorScheme.background,
                    ],
                  ),
                ),
              ),
            ),
          if (widget.withGradientTopMedium)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 750,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    stops: [0.0, 0.25, 0.5, 0.75, 1.0],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.transparent,
                      Theme.of(context).colorScheme.background.withOpacity(0.25),
                      Theme.of(context).colorScheme.background.withOpacity(0.5),
                      Theme.of(context).colorScheme.background.withOpacity(0.75),
                      Theme.of(context).colorScheme.background,
                    ],
                  ),
                ),
              ),
            ),
          if (widget.withGradientTopSmall)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 500,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    stops: [0.0, 0.25, 0.5, 0.75, 1.0],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.transparent,
                      Theme.of(context).colorScheme.background.withOpacity(0.25),
                      Theme.of(context).colorScheme.background.withOpacity(0.5),
                      Theme.of(context).colorScheme.background.withOpacity(0.75),
                      Theme.of(context).colorScheme.background,
                    ],
                  ),
                ),
              ),
            ),
          //------------LEFT---------------
          if (widget.withGradientLeftBig)
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  stops: [0.0, 0.25, 0.5, 0.75, 1.0],
                  begin: Alignment.centerRight,
                  end: Alignment.centerLeft,
                  colors: [
                    Colors.transparent,
                    Theme.of(context).colorScheme.background.withOpacity(0.25),
                    Theme.of(context).colorScheme.background.withOpacity(0.5),
                    Theme.of(context).colorScheme.background.withOpacity(0.75),
                    Theme.of(context).colorScheme.background,
                  ],
                ),
              ),
            ),
          if (widget.withGradientLeftMedium)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    stops: [0.0, 0.25, 0.5, 0.75, 1.0],
                    begin: Alignment.centerRight,
                    end: Alignment.centerLeft,
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
          if (widget.withGradientLeftSmall)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    stops: [0.0, 0.25, 0.5, 0.75, 1.0],
                    begin: Alignment.centerRight,
                    end: Alignment.centerLeft,
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
          //------------RIGHT---------------
          if (widget.withGradientRightBig)
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  stops: [0.0, 0.25, 0.5, 0.75, 1.0],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Colors.transparent,
                    Theme.of(context).colorScheme.background.withOpacity(0.25),
                    Theme.of(context).colorScheme.background.withOpacity(0.5),
                    Theme.of(context).colorScheme.background.withOpacity(0.75),
                    Theme.of(context).colorScheme.background,
                  ],
                ),
              ),
            ),
          if (widget.withGradientRightMedium)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    stops: [0.0, 0.25, 0.5, 0.75, 1.0],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
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
          if (widget.withGradientRightSmall)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    stops: [0.0, 0.25, 0.5, 0.75, 1.0],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
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
