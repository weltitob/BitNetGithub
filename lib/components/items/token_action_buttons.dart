import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/optioncontainer.dart';
import 'package:bitnet/components/appstandards/glasscontainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

/// A reusable widget for token buy/sell action buttons
/// Used consistently across bitcoin screen and token marketplace screen
class TokenActionButtons extends StatelessWidget {
  final VoidCallback onBuyTap;
  final VoidCallback onSellTap;
  final String? buyLabel;
  final String? sellLabel;

  const TokenActionButtons({
    Key? key,
    required this.onBuyTap,
    required this.onSellTap,
    this.buyLabel,
    this.sellLabel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        BitNetImageWithTextButton(
          buyLabel ?? "Buy",
          onBuyTap,
          width: AppTheme.cardPadding * 2.5.h,
          height: AppTheme.cardPadding * 2.5.h,
          fallbackIcon: FontAwesomeIcons.btc,
          fallbackIconSize: AppTheme.iconSize * 1.5,
        ),
        BitNetImageWithTextButton(
          sellLabel ?? "Sell",
          onSellTap,
          width: AppTheme.cardPadding * 2.5.h,
          height: AppTheme.cardPadding * 2.5.h,
          fallbackIcon: Icons.sell_outlined,
          fallbackIconSize: AppTheme.iconSize * 1.5,
        ),
      ],
    );
  }
}
