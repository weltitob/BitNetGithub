import 'dart:developer';

import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/amountwidget.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/buttons/roundedbutton.dart';
import 'package:bitnet/components/items/balancecard.dart';
import 'package:bitnet/models/currency/bitcoinunitmodel.dart';
import 'package:bitnet/pages/wallet/loop/controller/loop_controller.dart';
import 'package:bitnet/pages/wallet/loop/loop.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class LoopScreen extends StatefulWidget {
  final LoopController controller;
  const LoopScreen({
    super.key,
    required this.controller,
  });

  @override
  State<LoopScreen> createState() => _LoopScreenState();
}

class _LoopScreenState extends State<LoopScreen> {
  final loopGetController = Get.put(LoopGetxController());

  @override
  void dispose() {
    loopGetController.btcController.clear();
    loopGetController.currencyController.clear();
    loopGetController.dispose();
    log('Loop controller disposed');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return bitnetScaffold(
      extendBodyBehindAppBar: true,
      context: context,
      resizeToAvoidBottomInset: true,
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
                          child: BalanceCardLightning(
                              )),
                    ],
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Obx(() => AnimatedRotation(
                          turns:
                              loopGetController.animate.value ? 1 / 2 : 3 / 2,
                          duration: Duration(milliseconds: 400),
                          child: RotatedBox(
                            quarterTurns:
                                loopGetController.animate.value ? 1 : 3,
                            child: RoundedButtonWidget(
                                buttonType: ButtonType.transparent,
                                iconData: Icons.arrow_back,
                                onTap: () {
                                  loopGetController.changeAnimate();
                                }),
                          ),
                        )),
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
                bitcoinUnit: BitcoinUnits.SAT,
                btcController: loopGetController.btcController,
                currController: loopGetController.currencyController,
                focusNode: FocusNode(),
                onAmountChange: (type, currency) {
                  log('This is the currencyController ${loopGetController.currencyController.text}');
                  log('This is the btcController ${loopGetController.btcController.text}');
                },
                context: context,
              ),
            ),
            SizedBox(
              height: AppTheme.cardPadding * 1,
            ),
            Align(
              child: Obx(() => loopGetController.loadingState.value
                  ? Center(
                      child: CircularProgressIndicator.adaptive(),
                    )
                  : LongButtonWidget(
                      title: loopGetController.animate.value
                          ? 'Onchain to Lightning'
                          : 'Lightning to Onchain',
                      onTap: () {
                        loopGetController.animate.value
                            ? loopGetController.loopInQuote(context)
                            : loopGetController.loopOutQuote(context);
                      },
                      customWidth: AppTheme.cardPadding * 12,
                    )),
            )
          ],
        ),
      ),
    );
  }
}
