import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/buttons/glassbutton.dart';
import 'package:bitnet/components/container/imagewithtext.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart'; // Stellen Sie sicher, dass Sie das Lottie-Paket haben
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart'; // Stellen Sie sicher, dass Sie das Lottie-Paket haben
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/buttons/glassbutton.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';

class CustomCard extends StatelessWidget {
  final String lottieAssetPath;
  final String mainTitle;
  final String subTitle;
  final String buttonText;
  final VoidCallback onButtonTap;

  CustomCard({
    required this.lottieAssetPath,
    required this.mainTitle,
    required this.subTitle,
    required this.buttonText,
    required this.onButtonTap,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return GlassContainer(
      borderThickness: 1.5,
      blur: 50,
      opacity: 0.1,
      borderRadius: AppTheme.cardRadiusBigger,
      child: Container(
        height: height * 0.5,
        width: width * 0.17,
        padding: EdgeInsets.all(AppTheme.cardPadding),
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  height: height * 0.15,
                  width: width * 0.15,
                  child: Lottie.asset(lottieAssetPath),
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
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: AppTheme.cardPadding),
                child: ColorfulGradientButton(
                  iconData: FontAwesomeIcons.circleArrowRight,
                  text: buttonText,
                  onTap: onButtonTap,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
