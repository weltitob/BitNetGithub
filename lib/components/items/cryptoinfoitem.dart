import 'package:bitnet/backbone/helper/currency/getcurrency.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/container/imagewithtext.dart';
import 'package:bitnet/components/items/cryptoitem.dart';
import 'package:bitnet/models/currency/bitcoinunitmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CryptoInfoItem extends StatefulWidget {
  final Currency currency;
  final BuildContext context;
  final VoidCallback onTap;
  final String balance;
  final BitcoinUnits defaultUnit;

  const CryptoInfoItem({
    Key? key,
    required this.currency,
    required this.context,
    required this.onTap,
    required this.balance,
    required this.defaultUnit,
  }) : super(key: key);

  @override
  State<CryptoInfoItem> createState() => _CryptoInfoItemState();
}

class _CryptoInfoItemState extends State<CryptoInfoItem> {
  @override
  Widget build(BuildContext context) {
    final icon = getCurrencyIcon(widget.defaultUnit.name);

    return GlassContainer(
      borderThickness: 1,
      height: AppTheme.cardPadding * 2.75,
      borderRadius: AppTheme.cardRadiusBig,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppTheme.elementSpacing,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Icon and Currency Name
                Row(
                  children: [
                    Container(
                      height: AppTheme.cardPadding * 1.75,
                      width: AppTheme.cardPadding * 1.75,
                      child: ClipOval(child: widget.currency.icon),
                    ),
                    SizedBox(width: AppTheme.elementSpacing.w / 1.5),
                    Text(
                      widget.currency.name,
                      style: Theme.of(widget.context)
                          .textTheme
                          .titleSmall!
                          .copyWith(
                        color: AppTheme.white90,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                // Main Balance with Icon
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Text(
                          widget.balance,
                          style: Theme.of(widget.context)
                              .textTheme
                              .titleLarge!
                              .copyWith(color: AppTheme.white90),
                        ),
                        SizedBox(width: AppTheme.elementSpacing / 4),
                        Icon(
                          icon,
                          size: 20.w,
                          color: AppTheme.white90,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Tap Interaction
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: widget.onTap,
            ),
          ),
        ],
      ),
    );
  }
}
