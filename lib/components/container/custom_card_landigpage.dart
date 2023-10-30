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

  CustomCard({
    required this.lottieAssetPath,
    required this.mainTitle,
    required this.subTitle,
    required this.buttonText,
    required this.onButtonTap,
    this.customWidth = AppTheme.cardPadding * 12, // Example value
    this.customHeight = AppTheme.cardPadding * 16, // Example value
  });

  @override
  _CustomCardState createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  bool isHovered = false;

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
        }
      },
      onTap: widget.onButtonTap,
      child: AnimatedScale(
        duration: Duration(milliseconds: 200),
        scale: isHovered ? 1.0 : 0.9,
        child: GlassContainer(
          borderThickness: 1.5,
          blur: 50,
          opacity: 0.1,
          borderRadius: borderRadius,
          child: Container(
            height: height * 0.08 + widget.customHeight,
            width: width * 0.025 + widget.customWidth,
            padding: EdgeInsets.all(AppTheme.cardPadding),
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: widget.customHeight * 0.4,
                          width: widget.customWidth * 0.9,
                          child: Lottie.asset(
                            animate: isHovered,
                              widget.lottieAssetPath),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Text(
                      widget.mainTitle,
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Text(
                      widget.subTitle,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
                Positioned(
                  right: 0,
                  left: 0,
                  bottom: widget.customHeight * 0.05,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      LongButtonWidget(
                        leadingIcon: Icon(
                          FontAwesomeIcons.circleArrowRight,
                          size: AppTheme.cardPadding * 0.8,
                          color: AppTheme.white90,),
                        customWidth: widget.customWidth * 0.3 + AppTheme.cardPadding * 4,
                        customHeight: AppTheme.cardPadding * 1 + widget.customHeight * 0.04,
                        title: widget.buttonText,
                        onTap: widget.onButtonTap,
                      ),
                    ],
                  ),

                  // ColorfulGradientButton(
                  //   iconData: FontAwesomeIcons.circleArrowRight,
                  //   text: buttonText,
                  //   onTap: onButtonTap,
                  // ),
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
