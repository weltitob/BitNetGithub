import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/bottomnavgradient.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BottomCenterButton extends StatelessWidget {
  final String buttonTitle;
  final VoidCallback onButtonTap;
  final VoidCallback? onButtonTapDisabled;
  final ButtonState buttonState;

  const BottomCenterButton({
    Key? key,
    required this.buttonTitle,
    required this.buttonState,
    required this.onButtonTap,
    this.onButtonTapDisabled,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Debugging: Log the current button state
    // LoggerService logger = Get.find<LoggerService>();
    // logger.i("BottomCenterButton build with state: $buttonState");

    return Align(
      alignment: Alignment.bottomCenter,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const BottomNavGradient(),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).brightness == Brightness.dark
                  ? darken(Theme.of(context).colorScheme.primaryContainer, 80)
                  : lighten(Theme.of(context).colorScheme.primaryContainer, 50),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                left: AppTheme.elementSpacing,
                right: AppTheme.elementSpacing,
                bottom: AppTheme.elementSpacing,
              ),
              child: Center(
                child: LongButtonWidget(
                  state: buttonState,
                  buttonType: buttonState == ButtonState.disabled
                      ? ButtonType.transparent
                      : ButtonType.solid,
                  customWidth: AppTheme.cardPadding * 13.w,
                  customHeight: AppTheme.cardPadding * 2.5,
                  title: buttonTitle,
                  onTap: buttonState == ButtonState.disabled
                      ? onButtonTapDisabled
                      : onButtonTap,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BottomButtons extends StatefulWidget {
  final String leftButtonTitle;
  final String rightButtonTitle;
  final VoidCallback onLeftButtonTap;
  final VoidCallback onRightButtonTap;

  const BottomButtons({
    Key? key,
    required this.leftButtonTitle,
    required this.rightButtonTitle,
    required this.onLeftButtonTap,
    required this.onRightButtonTap,
  }) : super(key: key);

  @override
  State<BottomButtons> createState() => _BottomButtonsState();
}

class _BottomButtonsState extends State<BottomButtons> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const BottomNavGradient(),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).brightness == Brightness.dark
                  ? darken(Theme.of(context).colorScheme.primaryContainer, 80)
                  : lighten(Theme.of(context).colorScheme.primaryContainer, 50),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                left: AppTheme.elementSpacing,
                right: AppTheme.elementSpacing,
                bottom: AppTheme.elementSpacing,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  LongButtonWidget(
                    buttonType: ButtonType.transparent,
                    customWidth: AppTheme.cardPadding * 6.75.w,
                    customHeight: AppTheme.cardPadding * 2.5,
                    title: widget.leftButtonTitle,
                    onTap: widget.onLeftButtonTap,
                  ),
                  LongButtonWidget(
                    buttonType: ButtonType.solid,
                    customWidth: AppTheme.cardPadding * 6.75.w,
                    customHeight: AppTheme.cardPadding * 2.5,
                    title: widget.rightButtonTitle,
                    onTap: widget.onRightButtonTap,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
