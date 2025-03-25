import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/pages/website/emailfetcher.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';


class bitnetWebsiteAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final Widget? centerWidget;

  const bitnetWebsiteAppBar({
    super.key,
    this.centerWidget,
  });

  // Static cache to share values across instances
  static final Map<String, Map<String, dynamic>> _cache = {};
  
  // Get cached responsive values based on constraints
  Map<String, dynamic> _getResponsiveValues(BoxConstraints constraints) {
    final String key = constraints.maxWidth.toStringAsFixed(0);
    
    // Check static cache for better performance across instances
    if (_cache.containsKey(key)) {
      return _cache[key]!;
    }
    
    // Calculate values only once for this width
    bool isSmallScreen = constraints.maxWidth < AppTheme.isSmallScreen;
    bool isMidScreen = constraints.maxWidth < AppTheme.isMidScreen;
    bool isSuperSmallScreen = constraints.maxWidth < AppTheme.isSuperSmallScreen;
    bool isIntermediateScreen = constraints.maxWidth < AppTheme.isIntermediateScreen;

    double bigtextWidth = isMidScreen 
        ? (isSmallScreen 
          ? (isSuperSmallScreen ? AppTheme.cardPadding * 20 : AppTheme.cardPadding * 24) 
          : AppTheme.cardPadding * 28) 
        : AppTheme.cardPadding * 30;
        
    double textWidth = isMidScreen 
        ? (isSmallScreen 
          ? (isSuperSmallScreen ? AppTheme.cardPadding * 12 : AppTheme.cardPadding * 16) 
          : AppTheme.cardPadding * 22) 
        : AppTheme.cardPadding * 24;
        
    double subtitleWidth = isMidScreen 
        ? (isSmallScreen ? AppTheme.cardPadding * 14 : AppTheme.cardPadding * 18) 
        : AppTheme.cardPadding * 22;
        
    double spacingMultiplier = isMidScreen 
        ? (isSmallScreen 
          ? (isSuperSmallScreen ? 0.25 : 0.5) 
          : 0.75) 
        : 1;

    double centerSpacing = isMidScreen 
        ? (isIntermediateScreen
          ? (isSmallScreen
            ? (isSuperSmallScreen ? AppTheme.columnWidth * 0.075 : AppTheme.columnWidth * 0.15)
            : AppTheme.columnWidth * 0.35)
          : AppTheme.columnWidth * 0.65)
        : AppTheme.columnWidth;
        
    // Create result map and cache it
    final Map<String, dynamic> resultMap = <String, dynamic>{
      'isSmallScreen': isSmallScreen,
      'isMidScreen': isMidScreen,
      'isSuperSmallScreen': isSuperSmallScreen,
      'isIntermediateScreen': isIntermediateScreen,
      'bigtextWidth': bigtextWidth,
      'textWidth': textWidth,
      'subtitleWidth': subtitleWidth,
      'spacingMultiplier': spacingMultiplier,
      'centerSpacing': centerSpacing,
    };
    
    // Cache the results in the static cache only
    _cache[key] = resultMap;
    
    return resultMap;
  }

  @override
  Widget build(BuildContext context) {
    return bitnetAppBar(
        customLeading: null,
        hasBackButton: false,
        customTitle: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            // Get cached responsive values
            final responsive = _getResponsiveValues(constraints);
            final bool isSmallScreen = responsive['isSmallScreen'];
            final double centerSpacing = responsive['centerSpacing'];

            return Container(
              margin: isSmallScreen ? EdgeInsets.zero : EdgeInsets.symmetric(horizontal: centerSpacing),
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
                                  if(centerWidget != null) centerWidget!,

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
                        // Navigate to early bird page
                        context.go('/website/earlybird');
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
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
