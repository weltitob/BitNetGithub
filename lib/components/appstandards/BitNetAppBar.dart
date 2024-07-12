import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/animations/animatedtext.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/buttons/roundedbutton.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class bitnetAppBar extends StatefulWidget implements PreferredSizeWidget {
  //
  final BuildContext context;
  final Function()? onTap;
  final bool hasBackButton;
  final List<Widget>? actions;
  final String? text;
  final Widget? customTitle;
  final Widget? customLeading;
  final IconData? customIcon;
  final ButtonType? buttonType;

  bitnetAppBar(
      {required this.context,
      this.onTap,
      this.hasBackButton = true,
      this.actions,
      this.text = "",
      this.customTitle,
      this.customLeading,
      this.customIcon,
      this.buttonType = ButtonType.solid});

  @override
  _BitnetAppBarState createState() => _BitnetAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _BitnetAppBarState extends State<bitnetAppBar> {
  bool animateText = false;
  final GlobalKey _textKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => _checkOverflow());

    double width = MediaQuery.of(context).size.width;

    // Define breakpoint values for responsive layout.
    bool isSuperSmallScreen = width < AppTheme.isSuperSmallScreen;
    bool isSmallScreen =
        width < AppTheme.isSmallScreen; // Example breakpoint for small screens
    bool isMidScreen = width < AppTheme.isMidScreen;
    bool isIntermediateScreen = width < AppTheme.isIntermediateScreen;

    double centerSpacing = kIsWeb
        ? AppTheme.columnWidth * 0.075
        : isMidScreen
            ? isIntermediateScreen
                ? isSmallScreen
                    ? isSuperSmallScreen
                        ? AppTheme.columnWidth * 0.075
                        : AppTheme.columnWidth * 0.15
                    : AppTheme.columnWidth * 0.35
                : AppTheme.columnWidth * 0.65
            : AppTheme.columnWidth;

    return AppBar(
      automaticallyImplyLeading: false,
      scrolledUnderElevation: 0,
      shadowColor: Colors.transparent,
      bottomOpacity: 0,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: Theme.of(context).textTheme.titleLarge,
      backgroundColor: Colors.transparent,
      title: widget.customTitle ??
          (widget.text != null
              ? animateText
                  ? Container(
                      width: AppTheme.cardPadding * 10,
                      height: AppTheme.cardPadding,
                      child: AnimatedText(text: widget.text!))
                  : Container(
                      key: _textKey,
                      padding: EdgeInsets.symmetric(horizontal: centerSpacing),
                      child: Text(
                        widget.text!,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    )
              : Container()),
      leading: widget.hasBackButton
          ? widget.customLeading ??
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: widget.onTap,
                  child: Container(
                    margin: const EdgeInsets.only(
                      left: AppTheme.elementSpacing * 1.5,
                      right: AppTheme.elementSpacing * 0.5,
                      top: AppTheme.elementSpacing,
                      bottom: AppTheme.elementSpacing,
                    ),
                    child: RoundedButtonWidget(
                        buttonType: widget.buttonType ?? ButtonType.solid,
                        iconData: widget.customIcon ?? Icons.arrow_back,
                        iconColor:
                            Theme.of(context).brightness == Brightness.light
                                ? AppTheme.black60
                                : AppTheme.white60,
                        onTap: widget.onTap),
                  ),
                ),
              )
          : null,
      actions: widget.actions,
    );
  }

  void _checkOverflow() {
    final RenderBox? renderBox =
        _textKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox != null && renderBox.hasSize) {
      final double textWidth = renderBox.size.width;

      final TextPainter textPainter = TextPainter(
        text: TextSpan(
          text: widget.text,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        maxLines: 1,
        textDirection: TextDirection.ltr,
      )..layout(minWidth: 0, maxWidth: double.infinity);

      if (textPainter.size.width > textWidth) {
        if (!animateText) {
          setState(() {
            animateText = true;
          });
        }
      } else {
        if (animateText) {
          setState(() {
            animateText = false;
          });
        }
      }
    }
  }
}
