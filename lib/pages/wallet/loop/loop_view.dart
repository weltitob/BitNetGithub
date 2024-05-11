import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/amountwidget.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/buttons/roundedbutton.dart';
import 'package:bitnet/components/items/balancecard.dart';
import 'package:bitnet/pages/wallet/loop/loop_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class LoopScreen extends GetWidget<LoopsController> {
  const LoopScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return bitnetScaffold(
      extendBodyBehindAppBar: true,
      context: context,
      resizeToAvoidBottomInset: false,
      // backgroundColor: AppTheme.colorBackground,
      appBar: bitnetAppBar(
        text: 'Loop Screen',
        context: context,
        onTap: () {
          context.go('/feed');
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
                          child: BalanceCardBtc()),
                      Container(
                        height: AppTheme.cardPadding * 1,
                      ),
                      Container(
                          height: AppTheme.cardPadding * 8,
                          margin: EdgeInsets.symmetric(
                            horizontal: AppTheme.cardPadding,
                          ),
                          child: BalanceCardLightning()),
                    ],
                  ),
                  Obx(
                    () => Align(
                      alignment: Alignment.center,
                      child: AnimatedRotation(
                        turns: controller.animate.value ? 1 / 2 : 3 / 2,
                        duration: Duration(milliseconds: 400),
                        child: RotatedBox(
                          quarterTurns: controller.animate.value ? 1 : 3,
                          child: RoundedButtonWidget(
                              buttonType: ButtonType.transparent,
                              iconData: Icons.arrow_back,
                              onTap: () {
                                controller.changeAnimate();
                              }),
                        ),
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
                btcController: controller.btcController,
                currController: controller.currController,
                focusNode: controller.node,
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
