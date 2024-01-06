import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/container/imagewithtext.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';

class CustomCard extends StatefulWidget {
  final String lottieAssetPath;
  final String mainTitle;
  final String subTitle;
  final String buttonText;
  final VoidCallback onButtonTap;
  final double customWidth;
  final double customHeight;
  final bool isBiggerOnHover; // New parameter

  CustomCard({
    required this.lottieAssetPath,
    required this.mainTitle,
    required this.subTitle,
    required this.buttonText,
    required this.onButtonTap,
    this.customWidth = AppTheme.cardPadding * 12,
    this.customHeight = AppTheme.cardPadding * 15,
    this.isBiggerOnHover = true, // Default value
  });

  @override
  _CustomCardState createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _lottieController;
  bool isHovered = false;

  @override
  void initState() {
    super.initState();
    _lottieController = AnimationController(vsync: this);

    // Set the initial frame (e.g., half-way through the animation)
    _lottieController.value = 0.66;
  }

  @override
  void dispose() {
    _lottieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    BorderRadius borderRadius = BorderRadius.circular(widget.customWidth / 3.5);

    return InkWell(
      borderRadius: borderRadius,
      onHover: (isHovering) {
        if (isHovering != isHovered) {
          setState(() {
            isHovered = isHovering;
          });

          if (isHovered) {
            // Start a repeating animation when hovered
            _lottieController.repeat();
          } else {
            // Stop/pause the animation when not hovered
            _lottieController.stop();
          }
        }
      },
      onTap: widget.onButtonTap,
      child: AnimatedScale(
        duration: Duration(milliseconds: 200),
        scale: isHovered
            ? 1.0
            : widget.isBiggerOnHover
                ? 0.9
                : 1.0,
        child: GlassContainer(
          borderThickness: 1.5,
          blur: 50,
          opacity: 0.1,
          borderRadius: borderRadius,
          child: Container(
            height: height * 0.08 + widget.customHeight,
            width: width * 0.01 + widget.customWidth,
            padding: EdgeInsets.only(
                top: AppTheme.cardPadding,
                bottom: AppTheme.cardPadding,
                left: AppTheme.cardPadding,
                right: AppTheme.cardPadding),
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: height * 0.01,
                        ),
                        Container(
                          height: width * 0.01 + widget.customHeight * 0.4,
                          width: widget.customWidth * 0.8,
                          child: Lottie.asset(
                            widget.lottieAssetPath,
                            controller: _lottieController,
                            animate:
                                false, // Animation is now controlled by the _lottieController
                            onLoaded: (composition) {
// Set the duration
                              _lottieController.duration = composition.duration;
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: AppTheme.elementSpacing),
                      child: Text(
                        widget.mainTitle,
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                    ),
                    SizedBox(
                      height: height * 0.015,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: AppTheme.elementSpacing),
                      child: Text(
                        widget.subTitle,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ],
                ),
                Positioned(
                  right: 0,
                  left: 0,
                  bottom: widget.customHeight * 0.05,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: AppTheme.elementSpacing),
                        child: LongButtonWidget(
                          buttonType: ButtonType.solid,
                          leadingIcon: Icon(
                            FontAwesomeIcons.circleArrowRight,
                            size: AppTheme.cardPadding * 0.8,
                            color: AppTheme.white90,
                          ),
                          customWidth: widget.customWidth * 0.25 +
                              AppTheme.cardPadding * 3.5,
                          customHeight: AppTheme.cardPadding * 0.85 +
                              widget.customHeight * 0.04,
                          title: widget.buttonText,
                          onTap: widget.onButtonTap,
                        ),
                      ),
                    ],
                  ),
                ),
                // Your widget tree
              ],
            ),
          ),
        ),
      ),
    );
  }
}
