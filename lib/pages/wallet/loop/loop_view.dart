import 'package:bitnet/backbone/helper/currency/currency_converter.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
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
    loopGetController.satController.clear();
    loopGetController.btcController.clear();
    loopGetController.currencyController.clear();

    //loopGetController.dispose();
    super.dispose();
  }
  @override
  void initState() {
    super.initState();
    WalletsController walletController = Get.find<WalletsController>();
    WidgetsBinding.instance.addPostFrameCallback((_){
    walletController.predictedLightningBalance.value = walletController.lightningBalance.balance;
    walletController.predictedBtcBalance.value = walletController.onchainBalance.confirmedBalance;
    setState((){});
    });
  }
  @override
  Widget build(BuildContext context) {
    WalletsController walletController = Get.find<WalletsController>();
    print('triggered rebuild');
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
          //L10n.of(context)!.loopScreen,
          context: context,
          onTap: () {
            context.go('/feed');
          },
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
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
                                margin: EdgeInsets.symmetric(horizontal: AppTheme.cardPadding),
                                child: Obx(()=> BalanceCardBtc(balance: double.parse(walletController.predictedBtcBalance.value).toStringAsFixed(8),defaultUnit: BitcoinUnits.SAT, textColor: double.parse(walletController.onchainBalance.confirmedBalance) < double.parse(walletController.predictedBtcBalance.value) ? AppTheme.successColor :double.parse(walletController.onchainBalance.confirmedBalance) > double.parse(walletController.predictedBtcBalance.value) ? AppTheme.errorColor : null))),
                            Container(
                              height: AppTheme.cardPadding * 1,
                            ),
                            Container(
                                height: AppTheme.cardPadding * 8,
                                margin: EdgeInsets.symmetric(
                                  horizontal: AppTheme.cardPadding,
                                ),
                                child: Obx((){ 
                                  return BalanceCardLightning(balance: double.parse(walletController.predictedLightningBalance.value).toStringAsFixed(8),textColor: double.parse(walletController.lightningBalance.balance) < double.parse(walletController.predictedLightningBalance.value) ? AppTheme.successColor :double.parse(walletController.lightningBalance.balance) > double.parse(walletController.predictedLightningBalance.value) ? AppTheme.errorColor : null);
                                  })),
                          ],
                        ),
                            Align(
                          alignment: Alignment.center,
                          child: Obx(() => AnimatedRotation(
                                turns: loopGetController.animate.value ? 1 / 2 : 3 / 2,
                                duration: Duration(milliseconds: 400),
                                child: RotatedBox(
                                  quarterTurns: loopGetController.animate.value ? 1 : 3,
                                  child: RoundedButtonWidget(
                                      buttonType: ButtonType.transparent,
                                      iconData: Icons.arrow_back,
                                      onTap: () {
                                        loopGetController.changeAnimate();
                                        double lightningBalance = double.parse(walletController.predictedLightningBalance.value);
                                        double normalLightningBalance = double.parse(walletController.lightningBalance.balance);
                                        double difference = normalLightningBalance - lightningBalance;
                                        walletController.predictedBtcBalance.value = (double.parse(walletController.onchainBalance.confirmedBalance) - difference).toString();
                                        walletController.predictedLightningBalance.value = (double.parse(walletController.lightningBalance.balance) + difference).toString();
                                        setState((){});
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
                    child: Obx(
                      ()=> AmountWidget(
                        enabled: () => true,
                        bitcoinUnit: BitcoinUnits.SAT,
                        btcController: loopGetController.btcController,
                        currController: loopGetController.currencyController,
                        satController: loopGetController.satController,
                        lowerBound: 0,
                        upperBound: loopGetController.animate.value ? int.parse(walletController.onchainBalance.confirmedBalance) : int.parse(walletController.lightningBalance.balance),
                        boundType: BitcoinUnits.SAT,
                        focusNode: loopGetController.amtNode,
                        onAmountChange: (type, currency) {
                          WalletsController walletController = Get.find<WalletsController>();
                          late String sats;
                          if(type == 'BTC') {
                           sats = CurrencyConverter.convertBitcoinToSats(double.parse(currency)).toString();

                          } else {
                             sats = loopGetController.satController.text;
                          }
                                                  print('current amount= $sats');
                      
                          bool toLightning = loopGetController.animate.value;
                          try {
                           walletController.predictedLightningBalance.value = (toLightning ? double.parse(walletController.lightningBalance.balance) + double.parse(sats) : double.parse(walletController.lightningBalance.balance) - double.parse(sats)).toString();
                           walletController.predictedBtcBalance.value = (toLightning ? double.parse(walletController.onchainBalance.confirmedBalance) - double.parse(sats) : double.parse(walletController.onchainBalance.confirmedBalance) + double.parse(sats)).toString();
                           print('predictedlightning ${walletController.predictedLightningBalance.value}');
                                                    print('predictedBtc ${walletController.predictedBtcBalance.value}');
                            setState((){});
                          } catch(e){
                            walletController.predictedLightningBalance.value = walletController.lightningBalance.balance;
                            walletController.predictedBtcBalance.value = walletController.onchainBalance.confirmedBalance;
                          }
                          
                        },
                        context: context,
                        autoConvert: true,
                        swapped: Get.find<WalletsController>().reversed.value,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: AppTheme.cardPadding * 3.5,
                  ),
                ],
              ),
            ),
            Obx(
              ()=> BottomCenterButton(
                //loopGetController.loadingState.value
                buttonTitle: loopGetController.animate.value ? L10n.of(context)!.onChainLightning : L10n.of(context)!.lightningOnChain,
                onButtonTap: () {
                  loopGetController.animate.value ? loopGetController.loopInQuote(context) : loopGetController.loopOutQuote(context);
                },
                buttonState: loopGetController.loadingState.value ? ButtonState.loading : ButtonState.idle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
