import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/buttons/glassbutton.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/buttons/roundedbutton.dart';
import 'package:bitnet/components/container/imagewithtext.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart'; // Ensure you have the Lottie package

class CustomCard extends StatelessWidget {
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
    this.customWidth = AppTheme.cardPadding * 12,
    this.customHeight = AppTheme.cardPadding * 20,
  });

  final ValueNotifier<bool> _isHovered = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => _isHovered.value = true, // When mouse enters the region
      onExit: (_) => _isHovered.value = false, // When mouse exits the region
      // onHover: (event) {
      //   _isHovered.value = event.kind == PointerDeviceKind.mouse;
      // },
      child: ValueListenableBuilder<bool>(
        valueListenable: _isHovered,
        builder: (context, isHovered, child) {
          return AnimatedScale(
            duration: Duration(milliseconds: 200), // you can adjust the duration
            scale: isHovered ? 1.0 : 0.95, // Scale by 5% when hovered
            child: GlassContainer(
              borderThickness: 1.5,
              blur: 50,
              opacity: 0.1,
              borderRadius: AppTheme.cardRadiusBigger,
              child: Container(
                height: height * 0.5,
                width: width * 0.125 + 100,
                padding: EdgeInsets.all(AppTheme.cardPadding),
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: customHeight * 0.3,
                          width: customWidth,
                          child: Lottie.asset(

                              lottieAssetPath),
                        ),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        Text(
                          mainTitle,
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                        SizedBox(
                          height: height * 0.01,
                        ),
                        Text(
                          subTitle,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        SizedBox(
                          height: height * 0.05,
                        ),
                      ],
                    ),
                    Positioned(
                      right: 0,
                      left: 0,
                      bottom: AppTheme.cardPadding,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          LongButtonWidget(
                            leadingIcon: Icon(
                                FontAwesomeIcons.circleArrowRight,
                            size: AppTheme.cardPadding * 0.8,
                            color: AppTheme.white90,),
                            customWidth: customWidth * 0.5 + AppTheme.cardPadding * 2,
                            customHeight: AppTheme.cardPadding * 1 + customHeight * 0.04,
                            title: buttonText,
                            onTap: onButtonTap,
                          ),
                        ],
                      ),

                      // ColorfulGradientButton(
                      //   iconData: FontAwesomeIcons.circleArrowRight,
                      //   text: buttonText,
                      //   onTap: onButtonTap,
                      // ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
