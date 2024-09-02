import 'package:bitnet/backbone/cloudfunctions/stripe/createstripeaccount.dart';
import 'package:bitnet/backbone/cloudfunctions/stripe/requestclientsecret.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:bitnet/components/amountwidget.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/appstandards/buildroundedbox.dart';
import 'package:bitnet/components/appstandards/informationwidget.dart';
import 'package:bitnet/components/appstandards/optioncontainer.dart';
import 'package:bitnet/components/buttons/bottom_buybuttons.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/chart/chart.dart';
import 'package:bitnet/components/dialogsandsheets/bottom_sheets/bit_net_bottom_sheet.dart';
import 'package:bitnet/pages/secondpages/mempool/controller/bitcoin_screen_controller.dart';
import 'package:bitnet/pages/secondpages/mempool/controller/purchase_sheet_controller.dart';
import 'package:bitnet/pages/wallet/controllers/wallet_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

class BitcoinScreen extends GetWidget<BitcoinScreenController> {
  const BitcoinScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return bitnetScaffold(
      context: context,
      extendBodyBehindAppBar: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
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
              const SingleChildScrollView(
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
              const SizedBox(
                height: AppTheme.cardPadding * 2,
              ),
              InformationWidget(
                title: L10n.of(context)!.about,
                description: L10n.of(context)!.bitcoinDescription,
              ),
              const SizedBox(
                height: AppTheme.cardPadding * 2,
              ),
              RoundedContainer(
                  child: Column(
                children: [
                  Text(
                    L10n.of(context)!.quickLinks,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: AppTheme.cardPadding,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      BitNetImageWithTextContainer(
                        L10n.of(context)!.bitcoin,
                        customColor: Theme.of(context).brightness == Brightness.light ?  Colors.white.withAlpha(50) : null,
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
                        customColor: Theme.of(context).brightness == Brightness.light ?  Colors.white.withAlpha(50) : null,

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
                        customColor: Theme.of(context).brightness == Brightness.light ?  Colors.white.withAlpha(50) : null,

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
                  const SizedBox(
                    height: AppTheme.cardPadding * 1,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [],
                  ),
                  const SizedBox(
                    height: AppTheme.cardPadding * 2,
                  ),
                ],
              )),
              const SizedBox(
                height: AppTheme.cardPadding * 2,
              ),
            ],
          ),
          const SizedBox(
            height: AppTheme.cardPadding * 1,
          ),
          BottomButtons(
            leftButtonTitle: L10n.of(context)!.buy,
            rightButtonTitle: L10n.of(context)!.sell,
            onLeftButtonTap: () {
              Get.delete<PurchaseSheetController>();
              Get.put<PurchaseSheetController>(PurchaseSheetController());
              BitNetBottomSheet(
                  height: MediaQuery.of(context).size.height * 0.85,
                  context: context,
                  child: const PurchaseSheet());
            },
            onRightButtonTap: () {
                            Get.delete<SellSheetController>();
              Get.put<SellSheetController>(SellSheetController());

              BitNetBottomSheet(
                  height: MediaQuery.of(context).size.height * 0.85,
                  context: context,
                  child: const SellSheet());
            },
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
        hasBackButton: false,
        text: L10n.of(context)!.purchaseBitcoin,
        context: context,
      ),
      body: Stack(
        children: [
          Column(
            children: [
              const SizedBox(
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
              const SizedBox(
                height: AppTheme.cardPadding * 2,
              ),
              const SizedBox(height: AppTheme.cardPadding),

            ],
          ),
          Obx(() {
            // Use Obx to reactively display the button state
              return BottomCenterButton(
                  buttonTitle: "Secure my Bitcoin",
                  buttonState: controller.buttonState.value,
                onButtonTap: () async {
                  // Set the button to loading state
                  controller.setButtonState(ButtonState.loading);
              
                  // Wait for the UI to update
                  await Future.delayed(const Duration(milliseconds: 100));
              
                  try {
                    final String clientSecret = await requestClientSecret("100000", "usd");
                    await _initializePaymentSheet(clientSecret, context);
                    await _presentPaymentSheet();
                  } catch (e) {
                    print('Error during payment process: $e');
                  }
              
                  // Reset the button state to idle after operations
                  controller.setButtonState(ButtonState.idle);
                },);
            }
          )
        ],
      ),
    );
  }
}

Future<void> _initializePaymentSheet(String clientSecret, BuildContext context) async {
  await Stripe.instance.initPaymentSheet(
    paymentSheetParameters: SetupPaymentSheetParameters(
      paymentIntentClientSecret: clientSecret,
      style: Theme.of(context).brightness == Brightness.light ? ThemeMode.light : ThemeMode.dark,
      customFlow: false,
      paymentMethodOrder: [
        'apple_pay', 'google_pay', 'paypal', 'klarna', 'card',
      ],
      googlePay: const PaymentSheetGooglePay(
        merchantCountryCode: 'US',
        currencyCode: 'usd',
        amount: '100000',
        label: 'BitNet GmbH',
        testEnv: true,
        buttonType: PlatformButtonType.pay,
      ),
      merchantDisplayName: 'BitNet GmbH',
    ),
  );
}

Future<void> _presentPaymentSheet() async {
  try {
    await Stripe.instance.presentPaymentSheet();
  } catch (e) {
    // Handle errors
    print('Error presenting payment sheet: $e');
  }
}

class SellSheet extends GetWidget<SellSheetController> {
  const SellSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final logger = Get.find<LoggerService>();
    return bitnetScaffold(
      extendBodyBehindAppBar: true,
      context: context,
      appBar: bitnetAppBar(
        hasBackButton: false,
        text: L10n.of(context)!.sell,
        context: context,
      ),
      body: Stack(
        children: [
          Column(
            children: [
              const SizedBox(
                height: AppTheme.cardPadding * 4,
              ),
              AmountWidget(
                  swapped: Get.find<WalletsController>().reversed.value,
                  enabled: () => true,
                  satController: controller.satCtrlBuy,
                  btcController: controller.btcCtrlBuy,
                  currController: controller.currCtrlBuy,
                  focusNode: controller.nodeSell,
                  autoConvert: true,
                  context: context),
              const SizedBox(
                height: AppTheme.cardPadding * 2,
              ),
              const SizedBox(height: AppTheme.cardPadding),
            ],
          ),
          Obx(() {
            // Use Obx to reactively display the button state
              return BottomCenterButton(
                  buttonTitle: "Sell my Bitcoin",
                  buttonState: controller.buttonState.value,
                  onButtonTap: () async {
                    controller.buttonState.value = ButtonState.loading;
                    bool hasStripeAccount = false;
                    if(!hasStripeAccount){
                      logger.i("Creating a new stripe account for the user...");
                      //get the link for the user
                      String accountlink = await createStripeAccount("USERIDNEW", "DE");
                      //launch the link for the user
                      logger.i("Opening the link now... $accountlink");
                      //convert the link to a url
                      final uri = Uri.parse(accountlink);
                      //launch the link
                      await launchUrl(uri);
                      //we need to redirect to the app
              
                      //then we proceed with the payment
              
              
                    } else {
                      //use the stripe account that already exists for the user to pay him out
                      logger.i("Using the existing stripe account for the user...");
              
              
                    }
                    controller.buttonState.value = ButtonState.idle;
                  });
            }
          )
        ],
      ),
    );
  }
}
//
// class NewPaymentCardHorizontalWidget extends StatelessWidget {
//   NewPaymentCardHorizontalWidget({
//     super.key,
//   });
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: LongButtonWidget(
//           customWidth:
//               MediaQuery.of(context).size.width - AppTheme.cardPadding * 1,
//           buttonType: ButtonType.solid,
//           leadingIcon: Icon(Icons.add),
//           title: L10n.of(context)!.addNewCard,
//           onTap: () {
//             // controller.animateTo(2);
//           }),
//     );
//   }
// }
//
// class PaymentCardHorizontalWidget extends StatelessWidget {
//   const PaymentCardHorizontalWidget(
//       {super.key, this.check = false, this.forward = true});
//
//   final bool check;
//   final bool forward;
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: AppTheme.elementSpacing),
//       child: GlassContainer(
//         child: Container(
//             height: 60,
//             width: double.infinity,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Row(
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: AppTheme.elementSpacing),
//                       child: Image.asset("assets/images/paypal.png",
//                           height: AppTheme.cardPadding * 1.5),
//                     ),
//                     SizedBox(
//                       width: AppTheme.elementSpacing,
//                     ),
//                     Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text("**** **** **** 4531"),
//                         Text('03/2030'),
//                       ],
//                     ),
//                   ],
//                 ),
//                 SizedBox(width: AppTheme.cardPadding),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                   child: check
//                       ? Icon(Icons.check,
//                           color: Theme.of(context).colorScheme.primary)
//                       : forward
//                           ? IconButton(
//                               icon: Icon(
//                                 Icons.arrow_forward_ios,
//                               ),
//                               onPressed: () {
//                                 // controller.animateTo(1);
//                               },
//                             )
//                           : SizedBox(
//                               width: 32,
//                             ),
//                 )
//               ],
//             )),
//       ),
//     );
//   }
// }
