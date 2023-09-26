import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/buttons/glassbutton.dart';
import 'package:bitnet/components/container/imagewithtext.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart'; // Stellen Sie sicher, dass Sie das Lottie-Paket haben
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart'; // Stellen Sie sicher, dass Sie das Lottie-Paket haben

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
    return GlassContainer(
      borderThickness: 1.5, // remove border if not active
      blur: 50,
      opacity: 0.1,
      borderRadius: AppTheme.cardRadiusBigger,
      child: Container(
        height: AppTheme.cardPadding * 18,
        width: AppTheme.cardPadding * 12,
        padding: EdgeInsets.all(AppTheme.cardPadding),
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  height: AppTheme.cardPadding * 6,
                  width: AppTheme.cardPadding * 9,
                  child: Lottie.asset(lottieAssetPath),
                ),
                SizedBox(
                  height: AppTheme.cardPadding * 1,
                ),
                Text(
                  mainTitle,
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                SizedBox(
                  height: AppTheme.elementSpacing,
                ),
                Text(
                  subTitle,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                SizedBox(
                  height: AppTheme.cardPadding * 3,
                ),
              ],
            ),
            Positioned(
              right: 0,
              left: 0,
              bottom: AppTheme.cardPadding * 1,
              child:
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppTheme.cardPadding * 1),
              child: ColorfulGradientButton(
                  iconData: FontAwesomeIcons.circleArrowRight,
                  text: buttonText,
                  onTap: onButtonTap),
            ),)
          ],
        ),
      ),
    );
  }
}
