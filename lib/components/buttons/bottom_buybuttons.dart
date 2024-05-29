import 'package:bitnet/backbone/helper/marketplace_helpers/sampledata.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/bottomnavgradient.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/marketplace_widgets/NftProductHorizontal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BottomBuyButtons extends StatefulWidget {
  const BottomBuyButtons({super.key});

  @override
  State<BottomBuyButtons> createState() => _BottomBuyButtonsState();
}

class _BottomBuyButtonsState extends State<BottomBuyButtons> {
  _buildBuySlidingPanel() {
    showGeneralDialog(
        barrierDismissible: true,
        barrierLabel: "buy_dialog",
        context: context,
        pageBuilder: (context, a1, a2) {
          return AlertDialog(
            insetPadding: EdgeInsets.zero,
            backgroundColor: Colors.transparent,
            content: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: AppTheme.colorBackground,
                  border: Border.all(color: AppTheme.colorBitcoin, width: 2)),
              height: 600,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Buy",
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(color: Colors.white)),
                    Divider(
                      color: AppTheme.colorBitcoin,
                      thickness: 2,
                    ),
                    _buildHorizontalProductWithId(),
                    Spacer(),
                    Container(
                      width: AppTheme.cardPadding * 10,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Subtotal",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(color: Colors.white),
                              ),
                              Text(
                                "0.024",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(color: Colors.white),
                              )
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Network Fee",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(color: Colors.white),
                              ),
                              Text(
                                "0.024",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(color: Colors.white),
                              )
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Market Fee",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(color: Colors.white),
                              ),
                              Text(
                                "0.024",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(color: Colors.white),
                              )
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Total Price",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(color: Colors.white),
                              ),
                              Text(
                                "0.024",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(color: Colors.white),
                              )
                            ],
                          ),
                          SizedBox(height: 10),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          LongButtonWidget(
                            title: "Cancel",
                            onTap: () {
                              Navigator.pop(context);
                            },
                            buttonType: ButtonType.transparent,
                            customWidth: 15 * 10,
                            customHeight: 15 * 2.5,
                          ),
                          LongButtonWidget(
                            title: "Buy Now",
                            onTap: () {},
                            customWidth: 15 * 10,
                            customHeight: 15 * 2.5,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  _buildHorizontalProductWithId() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: NftProductHorizontal(
        cryptoImage: gridListData[0].cryptoImage,
        nftImage: gridListData[0].nftImage,
        nftMainName: gridListData[0].nftMainName,
        nftName: gridListData[0].nftName,
        cryptoText: gridListData[0].cryptoText,
        rank: gridListData[0].rank,
        columnMargin: gridListData[0].columnMargin,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter ,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          BottomNavGradient(),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).brightness == Brightness.dark
                ? darken(Theme.of(context).colorScheme.primaryContainer, 70)
                .withOpacity(0.0001)
                : lighten(Theme.of(context).colorScheme.primaryContainer, 40),
              //boxShadow: [AppTheme.boxShadowProfile],
            ),
            child: Padding(
              padding: EdgeInsets.only(
                  left: AppTheme.elementSpacing,
                right: AppTheme.elementSpacing,
                bottom: AppTheme.elementSpacing,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  //if post owner put a list for sale and view offers
                  // LongButtonWidget(title: title, onTap: onTap)
                  LongButtonWidget(
                      customWidth: AppTheme.cardPadding * 5,
                      customHeight: AppTheme.cardPadding * 2.5,
                      title: "Buy",
                      onTap: _buildBuySlidingPanel),
                  LongButtonWidget(
                      customWidth: AppTheme.cardPadding * 5,
                      customHeight: AppTheme.cardPadding * 2.5,
                      buttonType: ButtonType.transparent,
                      title: "Make Offer",
                      onTap: () {}),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
