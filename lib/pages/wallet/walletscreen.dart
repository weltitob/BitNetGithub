import 'package:bitnet/backbone/helper/currency/currency_converter.dart';
import 'package:bitnet/backbone/helper/currency/getcurrency.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/appstandards/optioncontainer.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/buttons/roundedbutton.dart';
import 'package:bitnet/components/container/avatar.dart';
import 'package:bitnet/components/dialogsandsheets/bottom_sheets/bit_net_bottom_sheet.dart';
import 'package:bitnet/components/items/balancecard.dart';
import 'package:bitnet/components/items/cryptoitem.dart';
import 'package:bitnet/components/resultlist/transactions.dart';
import 'package:bitnet/models/bitcoin/chartline.dart';
import 'package:bitnet/models/currency/bitcoinunitmodel.dart';
import 'package:bitnet/pages/wallet/actions/send/controllers/send_controller.dart';
import 'package:bitnet/pages/wallet/component/wallet_filter_screen.dart';
import 'package:bitnet/pages/wallet/controllers/wallet_controller.dart';
import 'package:bitnet/pages/wallet/loop/loop_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class WalletScreen extends GetWidget<WalletsController> {
  const WalletScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put(SendsController(context: context));
    final chartLine = Provider.of<ChartLine?>(context, listen: true);

    final bitcoinPrice = chartLine?.price;

    final currencyEquivalent = bitcoinPrice != null
        ? (controller.totalBalanceSAT.value / 100000000 * bitcoinPrice)
            .toStringAsFixed(2)
        : "0.00";
    final BitcoinUnitModel unitModel = CurrencyConverter.convertToBitcoinUnit(
        double.parse(controller.onchainBalance.confirmedBalance),
        BitcoinUnits.SAT);

    List<Container> cards = [
      Container(
        child: GestureDetector(
            onTap: () {
              context.go('/wallet/lightningcard');
            },
            child: BalanceCardLightning()),
      ),
      Container(
        child: GestureDetector(
          onTap: () {
            context.go('/wallet/bitcoincard');
          },
          child: BalanceCardBtc(),
        ),
      ),
    ];
    // var sampleTheme = Theme.of(context).textTheme;

    return bitnetScaffold(
      context: context,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: AppTheme.cardPadding * 1.5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppTheme.cardPadding * 1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Avatar(
                        size: AppTheme.cardPadding * 3,
                      ),
                      SizedBox(
                        width: AppTheme.elementSpacing * 1.5,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Total Wallet Balance",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          SizedBox(
                            height: AppTheme.elementSpacing * 0.25,
                          ),
                          Obx(
                            () => Row(
                              children: [
                                controller.hideBalance.value
                                    ? Text(
                                        '*****',
                                        style: Theme.of(context)
                                            .textTheme
                                            .displaySmall,
                                      )
                                    : GestureDetector(
                                        onTap: () => controller.setCurrencyType(
                                            controller.coin!.value != null
                                                ? !controller.coin!.value
                                                : false),
                                        child: Container(
                                          child: (controller.coin?.value ??
                                                  true)
                                              ? Row(
                                                  children: [
                                                    Text(
                                                      controller
                                                          .totalBalanceSAT.value
                                                          .toString(),
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .displaySmall,
                                                    ),
                                                    // const SizedBox(
                                                    //   width: AppTheme.elementSpacing / 2, // Replace with your AppTheme.elementSpacing if needed
                                                    // ),
                                                    Icon(
                                                      getCurrencyIcon(unitModel
                                                          .bitcoinUnitAsString),
                                                    ),
                                                  ],
                                                )
                                              : Text(
                                                  "${currencyEquivalent}${getCurrency(controller.selectedCurrency!.value)}",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .displaySmall,
                                                ),
                                        ))
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Obx(
                    () => RoundedButtonWidget(
                        size: AppTheme.cardPadding * 1.25,
                        buttonType: ButtonType.transparent,
                        iconData: controller.hideBalance.value == false
                            ? FontAwesomeIcons.eyeSlash
                            : FontAwesomeIcons.eye,
                        onTap: () {
                          controller.setHideBalance(
                              hide: !controller.hideBalance.value);
                        }),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: AppTheme.cardPadding * 1.5,
            ),
            Container(
              height: AppTheme.cardPadding * 9,
              child: Stack(
                children: [
                  CardSwiper(
                    backCardOffset: const Offset(0, -AppTheme.cardPadding),
                    // maxAngle: 0.0,
                    // threshold: 10,
                    padding: const EdgeInsets.only(
                        left: AppTheme.cardPadding,
                        right: AppTheme.cardPadding,
                        top: AppTheme.cardPadding),
                    scale: 1.0,
                    initialIndex:
                        controller.selectedCard?.value == 'lightning' ? 0 : 1,
                    cardsCount: cards.length,
                    onSwipe: (int index, int? previousIndex,
                        CardSwiperDirection direction) {
                      controller.setCardInDatabase(
                          controller.selectedCard?.value == 'onChain'
                              ? 'lightning'
                              : 'onChain');
                      return true;
                    },
                    cardBuilder: (context, index, percentThresholdX,
                            percentThresholdY) =>
                        cards[index],
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppTheme.cardPadding * 1.5),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: AppTheme.cardPadding),
              child: Text(
                "Actions",
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            const SizedBox(height: AppTheme.cardPadding),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: AppTheme.cardPadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  BitNetImageWithTextContainer(
                    "Send",
                    () {
                      context.push('/wallet/send');
                    },
                    //image: "assets/images/friends.png",
                    width: AppTheme.cardPadding * 3.85,
                    height: AppTheme.cardPadding * 3.85,
                    fallbackIcon: Icons.arrow_upward_rounded,
                  ),
                  BitNetImageWithTextContainer(
                    "Receive",
                    () {
                      context.go('/wallet/receive');
                    },
                    //image: "assets/images/key_removed_bck.png",
                    width: AppTheme.cardPadding * 3.85,
                    height: AppTheme.cardPadding * 3.85,
                    fallbackIcon: Icons.arrow_downward_rounded,
                  ),
                  BitNetImageWithTextContainer(
                    "Rebalance",
                    () {
                      Get.put(LoopsController());
                      context.go("/wallet/loop_screen");
                    },
                    //image: "assets/images/key_removed_bck.png",
                    width: AppTheme.cardPadding * 3.85,
                    height: AppTheme.cardPadding * 3.85,
                    fallbackIcon: Icons.sync_rounded,
                  ),
                  // LongButtonWidget(
                  //     buttonType: ButtonType.solid,
                  //     title: "Send",
                  //     customWidth: AppTheme.cardPadding * 6.5,
                  //     leadingIcon: Icon(FontAwesomeIcons.circleUp),
                  //     onTap: () {
                  //       context.go('/wallet/send');
                  //     }),
                  // LongButtonWidget(
                  //     buttonType: ButtonType.transparent,
                  //     title: "Receive",
                  //     customWidth: AppTheme.cardPadding * 6.5,
                  //     leadingIcon: Icon(FontAwesomeIcons.circleDown),
                  //     onTap: () {
                  //       context.go('/wallet/receive');
                  //     }),
                ],
              ),
            ),
            const SizedBox(height: AppTheme.cardPadding * 1.5),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: AppTheme.cardPadding),
              child: Text(
                "Buy & Sell",
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            const SizedBox(
              height: AppTheme.cardPadding,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: AppTheme.cardPadding),
              child: CryptoItem(
                currency: Currency(
                  code: 'BTC',
                  name: 'Bitcoin',
                  icon: Image.asset('assets/images/bitcoin.png'),
                ),
                context: context,
              ),
            ),
            const SizedBox(height: AppTheme.cardPadding * 1.5),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: AppTheme.cardPadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Activity",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Row(
                    children: [
                      RoundedButtonWidget(
                          size: AppTheme.cardPadding * 1.25,
                          buttonType: ButtonType.transparent,
                          iconData: FontAwesomeIcons.filter,
                          onTap: () {
                            BitNetBottomSheet(
                                context: context, child: WalletFilterScreen());
                          }),
                      SizedBox(
                        width: AppTheme.elementSpacing,
                      ),
                      LongButtonWidget(
                          title: "All",
                          buttonType: ButtonType.transparent,
                          customWidth: AppTheme.cardPadding * 2.5,
                          customHeight: AppTheme.cardPadding * 1.25,
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        Transactions(fullList: true)));
                          }),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: AppTheme.elementSpacing,
            ),
            const SizedBox(height: AppTheme.elementSpacing),
            Transactions(),
          ],
        ),
      ),
    );
  }
}
