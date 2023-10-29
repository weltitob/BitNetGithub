import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/appstandards/backgroundwithcontent.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/pages/website/aboutus/aboutus.dart';
import 'package:flutter/material.dart';
import 'package:vrouter/vrouter.dart';

class AboutUsView extends StatelessWidget {
  final AboutUsController controller;

  const AboutUsView({super.key, required this.controller});

    @override
    Widget build(BuildContext context) {
      return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          // Check if the screen width is less than 600 pixels.
          bool isSmallScreen = constraints.maxWidth < AppTheme.isSmallScreen;
          bool isMidScreen = constraints.maxWidth < AppTheme.isMidScreen;

          double bigtextWidth = isMidScreen ? isSmallScreen ? AppTheme.cardPadding * 24 : AppTheme.cardPadding * 28 : AppTheme.cardPadding * 30;
          double textWidth = isMidScreen ? isSmallScreen ? AppTheme.cardPadding * 16 : AppTheme.cardPadding * 22 : AppTheme.cardPadding * 24;
          double subtitleWidth = isMidScreen ? isSmallScreen ? AppTheme.cardPadding * 14 : AppTheme.cardPadding * 18 : AppTheme.cardPadding * 22;
          double spacingMultiplier = isMidScreen ? isSmallScreen ? 0.5 : 0.75 : 1;
          double centerSpacing = isMidScreen ? isSmallScreen ? AppTheme.columnWidth * 0.15 : AppTheme.columnWidth * 0.65 : AppTheme.columnWidth;

          return BackgroundWithContent(
            backgroundType: BackgroundType.asset,
            withGradientBottomBig: true,
            opacity: 0.7,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: centerSpacing),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: AppTheme.cardPadding * 4 * spacingMultiplier,
                  ),
                  Container(
                    width: bigtextWidth,
                    child: Text(
                      "About us",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                  ),
                  SizedBox(
                    height: AppTheme.cardPadding * spacingMultiplier,
                  ),
                  Container(
                    width: subtitleWidth,
                    child: Text(
                      "Hi, we're BitNet. But its all of us. Bringing together...!",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                  SizedBox(
                    height: AppTheme.cardPadding * 2 * spacingMultiplier,
                  ),
                  Row(
                    children: [
                      Container()
                    ],
                  )
                ],
              ),
            ),
          );
        },
      );
    }
}
