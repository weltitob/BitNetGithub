import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/amountwidget.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/appstandards/buildroundedbox.dart';
import 'package:bitnet/components/appstandards/optioncontainer.dart';
import 'package:bitnet/components/buttons/bottom_buybuttons.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/chart/chart.dart';
import 'package:bitnet/pages/secondpages/mempool/controller/bitcoin_screen_controller.dart';
import 'package:bitnet/pages/secondpages/mempool/controller/purchase_sheet_controller.dart';
import 'package:bitnet/pages/wallet/controllers/wallet_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';


class BitcoinScreen extends GetWidget<BitcoinScreenController> {
  const BitcoinScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return bitnetScaffold(
      context: context,
      extendBodyBehindAppBar: true,
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: bitnetAppBar(
        text: L10n.of(context)!.bitcoinChart,
        context: context,
        onTap: () {
          Navigator.of(context).pop();
        },
      ),
      body: Stack(
        children: [
          ListView(
            scrollDirection: Axis.vertical,
            controller: controller.controller,
            children: [
              SingleChildScrollView(
                physics: NeverScrollableScrollPhysics(),
                child: Column(
                  children: [
                    SizedBox(
                      height: AppTheme.cardPadding * 2,
                    ),
                    ChartWidget(),
                    // SizedBox(
                    //   height: AppTheme.elementSpacing * 4,
                    // ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   crossAxisAlignment: CrossAxisAlignment.center,
                    //   children: [
                    //     LongButtonWidget(
                    //         customWidth: AppTheme.cardPadding * 7.w,
                    //         customHeight: AppTheme.cardPadding * 2.5,
                    //         title: L10n.of(context)!.buy,
                    //         onTap: () {
                    //           BitNetBottomSheet(
                    //               context: context, child: PurchaseSheet());
                    //         }),
                    //     SizedBox(
                    //       width: AppTheme.elementSpacing,
                    //     ),
                    //     LongButtonWidget(
                    //         buttonType: ButtonType.transparent,
                    //         customWidth: AppTheme.cardPadding * 7.w,
                    //         customHeight: AppTheme.cardPadding * 2.5,
                    //         title: L10n.of(context)!.sell,
                    //         onTap: () {
                    //           BitNetBottomSheet(
                    //               context: context,
                    //               child: Column(
                    //                 children: [
                    //                   AmountWidget(
                    //                       enabled: () => true,
                    //                       satController: controller.satCtrlSell,
                    //                       btcController: controller.btcCtrlSell,
                    //                       currController: controller.currCtrlSell,
                    //                       focusNode: controller.nodeSell,
                    //                       autoConvert: true,
                    //                       context: context),
                    //                 ],
                    //               ));
                    //         }),
                    //   ],
                    // )
                  ],
                ),
              ),
              SizedBox(
                height: AppTheme.cardPadding * 2,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: AppTheme.cardPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      L10n.of(context)!.about,
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                    SizedBox(
                      height: AppTheme.elementSpacing * 1,
                    ),
                    Text(
                        L10n.of(context)!.bitcoinDescription),
                  ],
                ),
              ),
              SizedBox(
                height: AppTheme.cardPadding * 2,
              ),
              RoundedContainer(
                  child: Column(
                    children: [
                      Text(
                        L10n.of(context)!.quickLinks,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      SizedBox(
                        height: AppTheme.cardPadding,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          BitNetImageWithTextContainer(
                            L10n.of(context)!.bitcoin,
                                () {
                              context.push('/wallet/bitcoinscreen/mempool');
                            },
                            image: "assets/images/blockchain.png",
                            fallbackIcon: FontAwesomeIcons.bitcoinSign,
                            width: AppTheme.cardPadding * 4,
                            height: AppTheme.cardPadding * 4,
                          ),
                          BitNetImageWithTextContainer(
                            L10n.of(context)!.hashrateDifficulty,
                                () {
                              context.push('/wallet/bitcoinscreen/hashrate');
                            },
                            image: "assets/images/hashrate.png",
                            fallbackIcon: FontAwesomeIcons.computer,
                            width: AppTheme.cardPadding * 4,
                            height: AppTheme.cardPadding * 4,
                          ),
                          BitNetImageWithTextContainer(
                            L10n.of(context)!.fearAndGreed,
                                () {
                              context.push('/wallet/bitcoinscreen/fearandgreed');
                            },
                            fallbackIcon: Icons.speed_rounded,
                            image: "assets/images/fagi.png",
                            width: AppTheme.cardPadding * 4,
                            height: AppTheme.cardPadding * 4,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: AppTheme.cardPadding * 1,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [],
                      ),
                      SizedBox(
                        height: AppTheme.cardPadding * 2,
                      ),
                ],
              )),
            ],
          ),
          BottomButtons(
              leftButtonTitle: L10n.of(context)!.buy,
              rightButtonTitle: L10n.of(context)!.sell,
              onLeftButtonTap: (){},
              onRightButtonTap: (){},),
        ],
      ),
    );
  }
}

class PurchaseSheet extends GetWidget<PurchaseSheetController> {
  const PurchaseSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TabBarView(
        physics: NeverScrollableScrollPhysics(),
        controller: controller.controller,
        children: [
          Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    left: AppTheme.cardPadding,
                    right: AppTheme.cardPadding,
                    top: AppTheme.elementSpacing),
                child: Text(
                  L10n.of(context)!.purchaseBitcoin,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
              AmountWidget(
                swapped: Get.find<WalletsController>().reversed.value,
                  enabled: () => true,
                  satController: controller.satCtrlBuy,
                  btcController: controller.btcCtrlBuy,
                  currController: controller.currCtrlBuy,
                  focusNode: controller.nodeBuy,
                  autoConvert: true,
                  context: context),
              SizedBox(
                height: AppTheme.cardPadding * 2,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Text(
                      L10n.of(context)!.payemntMethod,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              PaymentCardHorizontalWidget(controller: controller.controller),
              SizedBox(height: AppTheme.elementSpacing * 8),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: LongButtonWidget(
                    title: L10n.of(context)!.buyBitcoin,
                    onTap: () {},
                    customWidth: double.infinity,
                  ))
            ],
          ),
          Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    left: AppTheme.cardPadding,
                    right: AppTheme.cardPadding,
                    top: AppTheme.elementSpacing),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: () {
                        controller.controller.animateTo(0);
                      },
                    ),
                    Text(
                      L10n.of(context)!.purchaseBitcoin,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    SizedBox(width: 32)
                  ],
                ),
              ),
              SizedBox(
                height: AppTheme.elementSpacing * 2,
              ),
              Container(
                height: 400,
                child: ListView(
                  children: [
                    PaymentCardHorizontalWidget(
                        controller: controller.controller, check: true),
                    SizedBox(
                      height: AppTheme.elementSpacing,
                    ),
                    PaymentCardHorizontalWidget(
                      controller: controller.controller,
                      forward: false,
                    ),
                    SizedBox(
                      height: AppTheme.elementSpacing,
                    ),
                    PaymentCardHorizontalWidget(
                      controller: controller.controller,
                      forward: false,
                    ),
                    SizedBox(
                      height: AppTheme.elementSpacing,
                    ),
                    NewPaymentCardHorizontalWidget(
                        controller: controller.controller)
                  ],
                ),
              )
            ],
          ),
          Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    left: AppTheme.cardPadding,
                    right: AppTheme.cardPadding,
                    top: AppTheme.elementSpacing),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () {
                        controller.controller.animateTo(1);
                      },
                    ),
                    Text(
                      L10n.of(context)!.saveCard,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    SizedBox(width: 48)
                  ],
                ),
              ),
              SizedBox(height: 15),
              CardFormField(
                  style: CardFormStyle(
                      textColor: Colors.white, placeholderColor: Colors.white)),
              SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: LongButtonWidget(
                  title:  L10n.of(context)!.saveCard,
                  onTap: () {},
                  customWidth: double.infinity,
                ),
              )
            ],
          )
        ]);
  }
}

class NewPaymentCardHorizontalWidget extends StatelessWidget {
  final TabController controller;
  NewPaymentCardHorizontalWidget({required this.controller});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: InkWell(
        onTap: () {
          controller.animateTo(2);
        },
        child: Container(
            height: 60,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.3),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.add),
                SizedBox(width: AppTheme.elementSpacing),
                Text(L10n.of(context)!.addNewCard,
                    style: Theme.of(context).textTheme.titleSmall)
              ],
            )),
      ),
    );
  }
}

class PaymentCardHorizontalWidget extends StatelessWidget {
  const PaymentCardHorizontalWidget(
      {super.key,
      required this.controller,
      this.check = false,
      this.forward = true});

  final TabController controller;
  final bool check;
  final bool forward;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Container(
          height: 60,
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppTheme.primaryColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Image.asset("assets/images/paypal.png", height: 48),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("**** **** **** 4531"),
                  Text('03/2030'),
                ],
              ),
              SizedBox(width: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: check
                    ? Icon(Icons.check, color: Colors.blue)
                    : forward
                        ? IconButton(
                            icon: Icon(
                              Icons.arrow_right,
                            ),
                            onPressed: () {
                              controller.animateTo(1);
                            },
                          )
                        : SizedBox(
                            width: 32,
                          ),
              )
            ],
          )),
    );
  }
}
