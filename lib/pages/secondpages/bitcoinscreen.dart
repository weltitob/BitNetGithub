import 'package:bitnet/backbone/cloudfunctions/stripe/requestclientsecret.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/amountwidget.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/appstandards/InformationWIdget.dart';
import 'package:bitnet/components/appstandards/buildroundedbox.dart';
import 'package:bitnet/components/appstandards/optioncontainer.dart';
import 'package:bitnet/components/buttons/bottom_buybuttons.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/chart/chart.dart';
import 'package:bitnet/components/container/imagewithtext.dart';
import 'package:bitnet/components/dialogsandsheets/bottom_sheets/bit_net_bottom_sheet.dart';
import 'package:bitnet/pages/secondpages/mempool/controller/bitcoin_screen_controller.dart';
import 'package:bitnet/pages/secondpages/mempool/controller/purchase_sheet_controller.dart';
import 'package:bitnet/pages/wallet/controllers/wallet_controller.dart';
import 'package:bitnet/pages/settings/paymentmethods/paymentmethos.dart';
import 'package:bitnet/pages/settings/paymentmethods/addpaymentmethod.dart';
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
              InformationWidget(
                title: L10n.of(context)!.about,
                description: L10n.of(context)!.bitcoinDescription,
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
              SizedBox(
                height: AppTheme.cardPadding * 2,
              ),
            ],
          ),
          SizedBox(
            height: AppTheme.cardPadding * 1,
          ),
          BottomButtons(
            leftButtonTitle: L10n.of(context)!.buy,
            rightButtonTitle: L10n.of(context)!.sell,
            onLeftButtonTap: () {
              requestClientSecret("1000", "eur");
              BitNetBottomSheet(
                  context: context,
                  // height: MediaQuery.of(context).size.height * 0.5,

                  child: PurchaseSheet());
            },
            onRightButtonTap: () {},
          ),
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
    return bitnetScaffold(
      extendBodyBehindAppBar: true,
      context: context,
      appBar: bitnetAppBar(
        text: L10n.of(context)!.purchaseBitcoin,
        context: context,
      ),
      body: Stack(
        children: [
          TabBarView(
              physics: NeverScrollableScrollPhysics(),
              controller: controller.controller,
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: AppTheme.cardPadding * 4,
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
                    // Padding(
                    //   padding: EdgeInsets.symmetric(horizontal: 16),
                    //   child: Row(
                    //     children: [
                    //       Text(
                    //         L10n.of(context)!.payemntMethod,
                    //         style: Theme.of(context).textTheme.titleSmall,
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    SizedBox(height: AppTheme.cardPadding),
                    // PaymentCardHorizontalWidget(),
                    // SizedBox(height: AppTheme.cardPadding * 2),
                    // Padding(
                    //     padding: EdgeInsets.symmetric(horizontal: 16),
                    //     child: LongButtonWidget(
                    //       title: L10n.of(context)!.buyBitcoin,
                    //       onTap: () {},
                    //       customWidth: double.infinity,
                    //     ))
                  ],
                ),
                // PaymentMethods(),
                // AddPaymentMethod(),
              ]),
          BottomCenterButton(
              buttonTitle: "Secure my Bitcoin",
              buttonState: controller.buttonState,
              onButtonTap: () async {
                //change button state to loading
                //disable the amount widget for changes afterwards

                controller.buttonState = ButtonState.loading;
                try{
                final String clientSecret =
                    await requestClientSecret("1000", "usd");
                print("Opening the payment sheet now...");
                await Stripe.instance.initPaymentSheet(
                  paymentSheetParameters: SetupPaymentSheetParameters(
                    paymentIntentClientSecret: clientSecret,
                    style: Theme.of(context).brightness == Brightness.light ? ThemeMode.light : ThemeMode.dark,
                    customFlow: false,
                    // applePay: PaymentSheetApplePay(
                    //     merchantCountryCode: 'DE',
                    // ),
                    paymentMethodOrder: [
                      'apple_pay', 'google_pay', 'paypal', 'klarna', 'card',

                    ],
                    googlePay: PaymentSheetGooglePay(
                      merchantCountryCode: 'US',
                      currencyCode: 'usd',
                      amount: '1000',
                      label: 'BitNet GmbH',
                      testEnv: true,
                      buttonType: PlatformButtonType.pay,
                    ),
                    merchantDisplayName: 'BitNet GmbH',
                  ),
                );
                try {
                  await Stripe.instance.presentPaymentSheet();
                } catch (e) {
                  // Handle errors
                  print('Error presenting payment sheet: $e');
                }
                } catch (e) {
                  print(e);
                }
                controller.buttonState = ButtonState.idle;
              })
        ],
      ),
    );
  }
}

class NewPaymentCardHorizontalWidget extends StatelessWidget {
  NewPaymentCardHorizontalWidget({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Center(
      child: LongButtonWidget(
          customWidth:
              MediaQuery.of(context).size.width - AppTheme.cardPadding * 1,
          buttonType: ButtonType.solid,
          leadingIcon: Icon(Icons.add),
          title: L10n.of(context)!.addNewCard,
          onTap: () {
            // controller.animateTo(2);
          }),
    );
  }
}

class PaymentCardHorizontalWidget extends StatelessWidget {
  const PaymentCardHorizontalWidget(
      {super.key, this.check = false, this.forward = true});

  final bool check;
  final bool forward;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppTheme.elementSpacing),
      child: GlassContainer(
        child: Container(
            height: 60,
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: AppTheme.elementSpacing),
                      child: Image.asset("assets/images/paypal.png",
                          height: AppTheme.cardPadding * 1.5),
                    ),
                    SizedBox(
                      width: AppTheme.elementSpacing,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("**** **** **** 4531"),
                        Text('03/2030'),
                      ],
                    ),
                  ],
                ),
                SizedBox(width: AppTheme.cardPadding),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: check
                      ? Icon(Icons.check,
                          color: Theme.of(context).colorScheme.primary)
                      : forward
                          ? IconButton(
                              icon: Icon(
                                Icons.arrow_forward_ios,
                              ),
                              onPressed: () {
                                // controller.animateTo(1);
                              },
                            )
                          : SizedBox(
                              width: 32,
                            ),
                )
              ],
            )),
      ),
    );
  }
}
