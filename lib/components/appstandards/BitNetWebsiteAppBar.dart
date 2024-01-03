import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/loaders/loaders.dart';
import 'package:bitnet/models/user/userdata.dart';
import 'package:bitnet/pages/website/website_landingpage/website_landingpage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vrouter/vrouter.dart';

class bitnetWebsiteAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final Widget? centerWidget;

  const bitnetWebsiteAppBar({
    super.key,
    this.centerWidget,
  });

  @override
  Widget build(BuildContext context) {
    return bitnetAppBar(
        customLeading: null,
        hasBackButton: false,
        customTitle: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            // Check if the screen width is less than 600 pixels.
            bool isSmallScreen = constraints.maxWidth < AppTheme.isSmallScreen;
            bool isMidScreen = constraints.maxWidth < AppTheme.isMidScreen;
            bool isSuperSmallScreen = constraints.maxWidth < AppTheme.isSuperSmallScreen;

            double bigtextWidth = isMidScreen ? isSmallScreen ? isSuperSmallScreen ? AppTheme.cardPadding * 20 : AppTheme.cardPadding * 24 : AppTheme.cardPadding * 28 : AppTheme.cardPadding * 30;
            double textWidth = isMidScreen ? isSmallScreen ? isSuperSmallScreen ? AppTheme.cardPadding * 12 : AppTheme.cardPadding * 16 : AppTheme.cardPadding * 22 : AppTheme.cardPadding * 24;
            double subtitleWidth = isMidScreen ? isSmallScreen ? AppTheme.cardPadding * 14 : AppTheme.cardPadding * 18 : AppTheme.cardPadding * 22;
            double spacingMultiplier = isMidScreen ? isSmallScreen ? isSuperSmallScreen ? 0.25 : 0.5 : 0.75 : 1;
            double centerSpacing = isMidScreen ? isSmallScreen ? isSuperSmallScreen ? AppTheme.columnWidth * 0.05 : AppTheme.columnWidth * 0.15 : AppTheme.columnWidth * 0.65 : AppTheme.columnWidth;

            return Container(
              margin: EdgeInsets.symmetric(horizontal: centerSpacing),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: AppTheme.cardPadding *
                                (isSmallScreen ? 1.2 : 1.25),
                            width: AppTheme.cardPadding *
                                (isSmallScreen ? 1.2 : 1.25),
                            child: Image.asset(
                              "assets/images/logoclean.png",
                            ),
                          ),
                          SizedBox(
                            width: AppTheme.elementSpacing *
                                (isSmallScreen ? 0.75 : 1),
                          ),
                          Text(
                            "BitNet",
                            style: TextStyle(
                              fontSize: isSmallScreen
                                  ? 20
                                  : 20, // Adjust font size for small screen
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  centerWidget ??
                  Container(
                    alignment: Alignment.center,
                          width: AppTheme.cardPadding * 17,
                          child: centerWidget,
                        ),
                  Container(
                    //color: Colors.green,
                    child: LongButtonWidget(
                      buttonType: ButtonType.transparent,
                      customWidth: isSmallScreen
                          ? AppTheme.cardPadding * 5.25
                          : AppTheme.cardPadding * 6.5,
                      customHeight: isSmallScreen
                          ? AppTheme.cardPadding * 1.5
                          : AppTheme.cardPadding * 1.6,
                      title: "Get started",
                      leadingIcon: Icon(
                        FontAwesomeIcons.circleArrowRight,
                        size: AppTheme.cardPadding * 0.75,
                        color: AppTheme.white90,
                      ),
                      onTap: () {
                        VRouter.of(context).to('/authhome');
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        context: context);
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
