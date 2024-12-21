import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:bitnet/components/amountwidget.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/buttons/bottom_buybuttons.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/buttons/roundedbutton.dart';
import 'package:bitnet/components/items/balancecard.dart';
import 'package:bitnet/models/currency/bitcoinunitmodel.dart';
import 'package:bitnet/pages/wallet/controllers/wallet_controller.dart';
import 'package:bitnet/pages/wallet/loop/controller/loop_controller.dart';
import 'package:bitnet/pages/wallet/loop/loop.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class LoopScreen extends StatefulWidget {
  const LoopScreen({
    super.key,
  });

  @override
  State<LoopScreen> createState() => _LoopScreenState();
}

class _LoopScreenState extends State<LoopScreen> {
  final loopGetController = Get.put(LoopGetxController());

  WalletsController walletController = Get.find<WalletsController>();

  @override
  void initState() {
    super.initState();
    WalletsController walletController = Get.find<WalletsController>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      walletController.predictedLightningBalance.value =
          walletController.lightningBalance.value.balance;

      walletController.predictedBtcBalance.value =
          walletController.onchainBalance.value.confirmedBalance;

      setState(() {});
      // Add listener to FocusNode
    });


    loopGetController.amtNode.addListener(() {
      if (loopGetController.amtNode.hasFocus) {
        loopGetController.scrollToBottom();
        print('Keyboard is open');
      }
    });
  }

  @override
  void dispose() {
    loopGetController.satController.clear();
    loopGetController.btcController.clear();
    loopGetController.currencyController.clear();
    loopGetController.amtNode.removeListener(() {
      if (loopGetController.amtNode.hasFocus) {
        loopGetController.scrollToBottom();
      }
    });
    //loopGetController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (bool bool) {
        if (bool) {
          context.go('/feed');
        }
      },
      child: bitnetScaffold(
        extendBodyBehindAppBar: true,
        context: context,
        resizeToAvoidBottomInset: true,
        appBar: bitnetAppBar(
          text: "Swap Screen",
          context: context,
          onTap: () {
            context.go('/feed');
          },
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              controller: loopGetController.scrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: AppTheme.cardPadding * 3.5),
                  Container(
                    height: AppTheme.cardPadding * (7.5 * 2 + 1),
                    child: Stack(
                      children: [
                        Column(
                          children: [
                            Container(
                                height: AppTheme.cardPadding * 7.5,
                                margin: const EdgeInsets.symmetric(
                                    horizontal: AppTheme.cardPadding),
                                child:
                                Obx(() {
                                  final logger = Get.find<LoggerService>();
                                  // Extracting reactive variables from the controller
                                  final predictedBtcBalanceStr = walletController.predictedBtcBalance.value;
                                  final confirmedBalanceStr = walletController.onchainBalance.value.confirmedBalance;

                                  final unconfirmedBalanceStr = walletController.onchainBalance.value.unconfirmedBalance;

                                  // Safely parse the string balances to doubles
                                  final predictedBtcBalance = double.tryParse(predictedBtcBalanceStr) ?? 0.0;
                                  final confirmedBalance = double.tryParse(confirmedBalanceStr) ?? 0.0;
                                  final unconfirmedBalance = double.tryParse(unconfirmedBalanceStr) ?? 0.0;

                                  logger.i('predictedBtcBalance: $predictedBtcBalance');
                                  logger.i('confirmedBalance: $confirmedBalance');
                                  logger.i('unconfirmedBalance: $unconfirmedBalance');

                                  // Determine text color based on balance comparison
                                  Color? textColor;
                                  if (confirmedBalance < predictedBtcBalance) {
                                    textColor = AppTheme.successColor;
                                  } else if (confirmedBalance > predictedBtcBalance) {
                                    textColor = AppTheme.errorColor;
                                  } else {
                                    textColor = null;
                                  }

                                  // Format the predicted balance to 8 decimal places
                                  final formattedBalance = predictedBtcBalance.toStringAsFixed(8);

                                  return BalanceCardBtc(
                                    balance: formattedBalance,
                                    confirmedBalance: confirmedBalanceStr,
                                    unconfirmedBalance: unconfirmedBalanceStr,
                                    defaultUnit: BitcoinUnits.SAT,
                                    textColor: textColor,
                                  );
                                }),

                            ),
                            Container(
                              height: AppTheme.cardPadding * 1,
                            ),
                            Container(
                              height: AppTheme.cardPadding * 7.5,
                              margin: const EdgeInsets.symmetric(
                                horizontal: AppTheme.cardPadding,
                              ),
                              child: Obx(() {
                                final logger = Get.find<LoggerService>();
                                // Extracting reactive variables from the controller
                                final predictedBalanceStr = walletController.predictedLightningBalance.value;
                                final confirmedBalanceStr = walletController.lightningBalance.value.balance;

                                // Safely parse the string balances to doubles
                                final predictedBalance = double.tryParse(predictedBalanceStr) ?? 0.0;
                                final confirmedBalance = double.tryParse(confirmedBalanceStr) ?? 0.0;

                                logger.i('predictedBalance: $predictedBalance');
                                logger.i('confirmedBalance: $confirmedBalance');

                                // Determine text color based on balance comparison
                                Color? textColor;
                                if (confirmedBalance < predictedBalance) {
                                  textColor = AppTheme.successColor;
                                } else if (confirmedBalance > predictedBalance) {
                                  textColor = AppTheme.errorColor;
                                } else {
                                  textColor = null;
                                }

                                // Format the predicted balance to 8 decimal places
                                final formattedBalance = predictedBalance.toStringAsFixed(8);

                                return BalanceCardLightning(
                                  balance: formattedBalance,
                                  confirmedBalance: confirmedBalanceStr,
                                  defaultUnit: BitcoinUnits.SAT, // You can adjust this as needed
                                  textColor: textColor,
                                );
                              }),


                            ),

                          ],
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Obx(() => AnimatedRotation(
                                turns: loopGetController.animate.value
                                    ? 1 / 2
                                    : 3 / 2,
                                duration: const Duration(milliseconds: 400),
                                child: RotatedBox(
                                  quarterTurns:
                                      loopGetController.animate.value ? 1 : 3,
                                  child: RoundedButtonWidget(
                                      buttonType: ButtonType.transparent,
                                      iconData: Icons.arrow_back,
                                      onTap: () {
                                        loopGetController.changeAnimate();
                                        double lightningBalance = double.parse(
                                            walletController
                                                .predictedLightningBalance
                                                .value);
                                        double normalLightningBalance =
                                            double.parse(walletController
                                                .lightningBalance
                                                .value
                                                .balance);
                                        double difference =
                                            normalLightningBalance -
                                                lightningBalance;
                                        walletController
                                                .predictedBtcBalance.value =
                                            (double.parse(walletController
                                                        .onchainBalance
                                                        .value
                                                        .confirmedBalance) -
                                                    difference)
                                                .toString();
                                        walletController
                                            .predictedLightningBalance
                                            .value = (double.parse(
                                                    walletController
                                                        .lightningBalance
                                                        .value
                                                        .balance) +
                                                difference)
                                            .toString();
                                        setState(() {});
                                      }),
                                ),
                              )),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppTheme.cardPadding * 1),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: AppTheme.cardPadding),
                    child: Obx(
                      () => AmountWidget(
                        enabled: () => true,
                        bitcoinUnit: BitcoinUnits.SAT,
                        btcController: loopGetController.btcController,
                        currController: loopGetController.currencyController,
                        satController: loopGetController.satController,
                        lowerBound: 0,
                        upperBound: loopGetController.animate.value
                            ? int.parse(walletController
                                .onchainBalance.value.confirmedBalance)
                            : int.parse(walletController
                                .lightningBalance.value.balance),
                        boundType: BitcoinUnits.SAT,
                        focusNode: loopGetController.amtNode,
                        onAmountChange: (type, currency) {
                          // Handle amount change
                          loopGetController
                              .scrollToBottom(); // Scroll to bottom when amount changes
                        },
                        context: context,
                        autoConvert: true,
                        swapped: Get.find<WalletsController>().reversed.value,
                      ),
                    ),
                  ),
                  const SizedBox(height: AppTheme.cardPadding * 5.5),
                ],
              ),
            ),
            Obx(
              () => BottomCenterButton(
                buttonTitle: loopGetController.animate.value
                    ? L10n.of(context)!.onChainLightning
                    : L10n.of(context)!.lightningOnChain,
                onButtonTap: () {
                  loopGetController.animate.value
                      ? loopGetController.loopInQuote(context)
                      : loopGetController.loopOutQuote(context);
                },
                buttonState: loopGetController.loadingState.value
                    ? ButtonState.loading
                    : ButtonState.idle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
