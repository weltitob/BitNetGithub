import 'package:bitnet/backbone/helper/currency/currency_converter.dart';
import 'package:bitnet/backbone/helper/currency/getcurrency.dart';
import 'package:bitnet/backbone/streams/card_provider.dart';
import 'package:bitnet/backbone/streams/currency_provider.dart';
import 'package:bitnet/backbone/streams/currency_type_provider.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/appstandards/optioncontainer.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/buttons/roundedbutton.dart';
import 'package:bitnet/components/container/avatar.dart';
import 'package:bitnet/components/dialogsandsheets/bottom_sheets/bit_net_bottom_sheet.dart';
import 'package:bitnet/components/resultlist/transactions.dart';
import 'package:bitnet/models/bitcoin/chartline.dart';
import 'package:bitnet/pages/wallet/component/wallet_filter_screen.dart';
import 'package:bitnet/pages/wallet/provider/balance_hide_provider.dart';
import 'package:bitnet/models/currency/bitcoinunitmodel.dart';
import 'package:bitnet/pages/wallet/wallet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:bitnet/components/items/balancecard.dart';
import 'package:bitnet/components/items/cryptoitem.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class WalletScreen extends StatefulWidget {
  final WalletController controller;
  const WalletScreen({Key? key, required this.controller}) : super(key: key);

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  @override
  Widget build(BuildContext context) {
    final chartLine = Provider.of<ChartLine?>(context, listen: true);
    String? currency =
        Provider.of<CurrencyChangeProvider>(context).selectedCurrency;
    currency = currency ?? "USD";
    final bitcoinPrice = chartLine?.price;
    final coin = Provider.of<CurrencyTypeProvider>(context, listen: true);

    String? card = Provider.of<CardChangeProvider>(context).selectedCard;
    print(card);
    final currencyEquivalent = bitcoinPrice != null
        ? (widget.controller.totalBalanceSAT / 100000000 * bitcoinPrice)
            .toStringAsFixed(2)
        : "0.00";
    final BitcoinUnitModel unitModel = CurrencyConverter.convertToBitcoinUnit(
        double.parse(widget.controller.onchainBalance.confirmedBalance),
        BitcoinUnits.SAT);

    List<Container> cards = [
      Container(
        child: GestureDetector(
            onTap: () {
              context.go('/wallet/lightningcard');
            },
            child: BalanceCardLightning(controller: widget.controller)),
      ),
      Container(
          child: GestureDetector(
              onTap: () {
                context.go('/wallet/bitcoincard');
              },
              child: BalanceCardBtc(controller: widget.controller))),
    ];
    var sampleTheme = Theme.of(context).textTheme;
    return bitnetScaffold(
      context: context,
      body: ListView(
        children: [
          Column(
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
                            Row(
                              children: [
                                Consumer<BalanceHideProvider>(
                                    builder: (context, balanceHideProvider, _) {
                                  return balanceHideProvider.hideBalance!
                                      ? Text(
                                          '*****',
                                          style: Theme.of(context)
                                              .textTheme
                                              .displaySmall,
                                        )
                                      : GestureDetector(
                                          onTap: () => coin.setCurrencyType(
                                              coin.coin != null
                                                  ? !coin.coin!
                                                  : false),
                                          child: Container(
                                            child: (coin.coin ?? true)
                                                ? Row(
                                                    children: [
                                                      Text(
                                                        widget.controller
                                                            .totalBalanceSAT
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
                                                    "${currencyEquivalent}${getCurrency(currency!)}",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .displaySmall,
                                                  ),
                                          ));
                                }),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    Consumer<BalanceHideProvider>(
                        builder: (context, balanceHideProvider, _) {
                      return RoundedButtonWidget(
                          size: AppTheme.cardPadding * 1.25,
                          buttonType: ButtonType.transparent,
                          iconData: balanceHideProvider.hideBalance == false
                              ? FontAwesomeIcons.eyeSlash
                              : FontAwesomeIcons.eye,
                          onTap: () {
                            Provider.of<BalanceHideProvider>(context,
                                    listen: false)
                                .setHideBalance();
                          });
                    }),
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
                      initialIndex: card == 'lightning' ? 0 : 1,
                      cardsCount: cards.length,
                      onSwipe: (int index, int? previousIndex,
                          CardSwiperDirection direction) {
                        Provider.of<CardChangeProvider>(context, listen: false)
                            .setCardInDatabase(
                                card == 'onChain' ? 'lightning' : 'onChain');
                        return true;
                      },
                      cardBuilder: (context, index, percentThresholdX,
                              percentThresholdY) =>
                          cards[index],
                    )
                  ],
                ),
              ),
              const SizedBox(height: AppTheme.cardPadding * 1.5),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppTheme.cardPadding),
                child: Text(
                  "Actions",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              const SizedBox(height: AppTheme.cardPadding),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppTheme.cardPadding),
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
                padding: const EdgeInsets.symmetric(
                    horizontal: AppTheme.cardPadding),
                child: Text(
                  "Buy & Sell",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              const SizedBox(height: AppTheme.cardPadding),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppTheme.cardPadding),
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
                padding: const EdgeInsets.symmetric(
                    horizontal: AppTheme.cardPadding),
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
                                  context: context,
                                  child: WalletFilterScreen());
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
        ],
      ),
    );
  }

  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
