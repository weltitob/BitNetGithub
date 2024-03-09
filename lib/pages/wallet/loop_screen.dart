import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/amountwidget.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/buttons/roundedbutton.dart';
import 'package:bitnet/components/items/balancecard.dart';
import 'package:bitnet/pages/wallet/wallet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoopScreen extends StatefulWidget {
  const LoopScreen({super.key});

  @override
  State<LoopScreen> createState() => _LoopScreenState();
}

class _LoopScreenState extends State<LoopScreen> {
  bool animate = false;

  List<Container> cards = [
    Container(
        height: AppTheme.cardPadding * 8,
        margin: EdgeInsets.symmetric(horizontal: AppTheme.cardPadding),
        child: BalanceCardBtc(controller: WalletController())),
    Container(
        height: AppTheme.cardPadding * 8,
        margin: EdgeInsets.symmetric(
          horizontal: AppTheme.cardPadding,
        ),
        child: BalanceCardLightning(controller: WalletController())),
  ];

  @override
  Widget build(BuildContext context) {
    return bitnetScaffold(
      extendBodyBehindAppBar: true,
      context: context,
      resizeToAvoidBottomInset: false,
      backgroundColor: AppTheme.colorBackground,
      appBar: bitnetAppBar(
        text: 'Loop Screen',
        context: context,
        onTap: () {
          Navigator.pop(context);
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: AppTheme.cardPadding * 3.5,
            ),
            Container(
              height: AppTheme.cardPadding * (8 * 2 + 1),
              child: Stack(
                children: [
                  Column(
                    children: [
                      Container(
                          height: AppTheme.cardPadding * 8,
                          margin: EdgeInsets.symmetric(
                              horizontal: AppTheme.cardPadding),
                          child:
                              BalanceCardBtc(controller: WalletController())),
                      Container(height: AppTheme.cardPadding * 1,),
                      Container(
                          height: AppTheme.cardPadding * 8,
                          margin: EdgeInsets.symmetric(
                            horizontal: AppTheme.cardPadding,
                          ),
                          child: BalanceCardLightning(
                              controller: WalletController())),
                    ],
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: AnimatedRotation(
                      turns: animate ? 1 / 2 : 3 / 2,
                      duration: Duration(milliseconds: 400),
                      child: RotatedBox(
                        quarterTurns: animate ? 1 : 3,
                        child: RoundedButtonWidget(
                            buttonType: ButtonType.transparent,
                            iconData: Icons.arrow_back,
                            onTap: () {
                              setState(() {
                                animate = !animate;
                              });
                            }),
                      ),
                    ),
                  ),
                ],

              ),
            ),
            SizedBox(
              height: AppTheme.cardPadding * 1,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: AppTheme.cardPadding),
              child: AmountWidget(
                enabled: true,
                amountController: TextEditingController(text: '123'),
                focusNode: FocusNode(),
                context: context,
              ),
            ),
            SizedBox(
              height: AppTheme.cardPadding * 16,
            ),
          ],
        ),
      ),
    );
  }
}
