import 'package:bitnet/backbone/helper/currency/currency_converter.dart';
import 'package:bitnet/backbone/helper/currency/getcurrency.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/streams/currency_provider.dart';
import 'package:bitnet/backbone/streams/currency_type_provider.dart';
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
import 'package:bitnet/pages/wallet/actions/receive/controller/receive_controller.dart';
import 'package:bitnet/pages/wallet/actions/send/controllers/send_controller.dart';
import 'package:bitnet/pages/wallet/component/wallet_filter_screen.dart';
import 'package:bitnet/pages/wallet/controllers/wallet_controller.dart';
import 'package:bitnet/pages/wallet/loop/loop_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class WalletScreen extends GetWidget<WalletsController> {
  const WalletScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => ReceiveController(), fenix: true);
    Get.lazyPut(() => SendsController(context: context), fenix: true);
    final ChartLine? chartLine = controller.chartLines.value;
    if (controller.queueErrorOvelay) {
      controller.queueErrorOvelay = false;
      WidgetsBinding.instance.addPostFrameCallback(
        (timeStamp) {
          controller.handleFuturesCompleted(context);
        },
      );
    }
    final bitcoinPrice = chartLine?.price;

    final currencyEquivalent = bitcoinPrice != null
        ? (controller.totalBalanceSAT.value / 100000000 * bitcoinPrice)
            .toStringAsFixed(2)
        : "0.00";
    final BitcoinUnitModel unitModel = CurrencyConverter.convertToBitcoinUnit(
        double.parse(controller.onchainBalance.confirmedBalance),
        BitcoinUnits.SAT);
    final coin = Provider.of<CurrencyTypeProvider>(context, listen: true);
    final currency = Provider.of<CurrencyChangeProvider>(context, listen: true);
    controller.coin.value = coin.coin ?? controller.coin.value;
    controller.selectedCurrency!.value =
        currency.selectedCurrency ?? controller.selectedCurrency!.value;
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
        body: ListView(
          children: [
            Obx(() {
              controller.chartLines.value;
              return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: AppTheme.cardPadding * 1.5),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: AppTheme.cardPadding * 1),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Avatar(
                                size: AppTheme.cardPadding * 3.h,
                              ),
                              SizedBox(
                                width: AppTheme.elementSpacing * 1.5,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    L10n.of(context)!.totalWalletBal,
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
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
                                            : Obx(() {
                                                return GestureDetector(
                                                  onTap: () {
                                                    controller.setCurrencyType(
                                                        !controller.coin.value,
                                                        updateDatabase: false);
                                                    coin.setCurrencyType(
                                                        controller.coin.value);
                                                  },
                                                  child: Container(
                                                    child:
                                                        (controller.coin.value)
                                                            ? Row(
                                                                children: [
                                                                  Text(
                                                                    controller
                                                                        .totalBalance
                                                                        .value
                                                                        .amount
                                                                        .toString(),
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    style: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .displaySmall,
                                                                  ),
                                                                  Icon(
                                                                    getCurrencyIcon(controller
                                                                        .totalBalance
                                                                        .value
                                                                        .bitcoinUnitAsString),
                                                                  ),
                                                                ],
                                                              )
                                                            : Text(
                                                                "${currencyEquivalent}${getCurrency(controller.selectedCurrency!.value)}",
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .displaySmall,
                                                              ),
                                                  ),
                                                );
                                              }),
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
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: AppTheme.cardPadding * 1.h,
                    ),
                    Container(
                      height: AppTheme.cardPadding * 7.75.h,
                      child: Stack(
                        children: [
                          CardSwiper(
                            backCardOffset:
                                const Offset(0, -AppTheme.cardPadding),
                            // maxAngle: 0.0,
                            // threshold: 10,
                            padding: const EdgeInsets.only(
                                left: AppTheme.cardPadding,
                                right: AppTheme.cardPadding,
                                top: AppTheme.cardPadding),
                            scale: 1.0,
                            initialIndex: cards == 'lightning' ? 0 : 1,
                            cardsCount: cards.length,
                            onSwipe: (int index, int? previousIndex,
                                CardSwiperDirection direction) {
                              controller.setCardInDatabase(
                                  cards == 'onChain' ? 'lightning' : 'onChain');
                              return true;
                            },
                            cardBuilder: (context, index, percentThresholdX,
                                    percentThresholdY) =>
                                cards[index],
                          )
                        ],
                      ),
                    ),
                  ]);
            }),
            const SizedBox(height: AppTheme.cardPadding * 1.5),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: AppTheme.cardPadding),
              child: Text(
                L10n.of(context)!.actions,
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
                    L10n.of(context)!.send,
                    () {
                      context.go('/wallet/send');
                    },
                    image: "assets/images/send_image.png",
                    width: AppTheme.cardPadding * 3.75,
                    height: AppTheme.cardPadding * 3.75,
                    fallbackIcon: Icons.arrow_upward_rounded,
                  ),
                  BitNetImageWithTextContainer(
                    L10n.of(context)!.receive,
                    () {
                      context.go('/wallet/receive');
                    },
                    image: "assets/images/receive_image.png",
                    //image: "assets/images/key_removed_bck.png",
                    width: AppTheme.cardPadding * 3.75,
                    height: AppTheme.cardPadding * 3.75,
                    fallbackIcon: Icons.arrow_downward_rounded,
                  ),
                  BitNetImageWithTextContainer(
                    L10n.of(context)!.rebalance,
                    () {
                      Get.put(LoopsController());
                      context.go("/wallet/loop_screen");
                    },
                    image: "assets/images/rebalance_image.png",
                    width: AppTheme.cardPadding * 3.75,
                    height: AppTheme.cardPadding * 3.75,
                    fallbackIcon: Icons.sync_rounded,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: AppTheme.cardPadding * 1.5,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: AppTheme.cardPadding),
              child: Text(
                L10n.of(context)!.buySell,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            SizedBox(
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
            StatefulBuilder(builder: (context, setState) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppTheme.cardPadding),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          L10n.of(context)!.activity,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        Row(
                          children: [
                            RoundedButtonWidget(
                                size: AppTheme.cardPadding * 1.25,
                                buttonType: ButtonType.transparent,
                                iconData: FontAwesomeIcons.filter,
                                onTap: () async {
                                  await BitNetBottomSheet(
                                      context: context,
                                      child: WalletFilterScreen());
                                  setState(() {});
                                }),
                            SizedBox(
                              width: AppTheme.elementSpacing,
                            ),
                            LongButtonWidget(
                              title: L10n.of(context)!.all,
                              buttonType: ButtonType.transparent,
                              customWidth: AppTheme.cardPadding * 2.5,
                              customHeight: AppTheme.cardPadding * 1.25,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        Transactions(fullList: true),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: AppTheme.elementSpacing,
                  ),
                  const SizedBox(height: AppTheme.elementSpacing),
                  Transactions(),
                ],
              );
            }),
          ],
        ));
  }
}
