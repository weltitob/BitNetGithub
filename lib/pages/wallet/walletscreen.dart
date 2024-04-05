import 'package:bitnet/backbone/helper/currency/currency_converter.dart';
import 'package:bitnet/backbone/helper/currency/getcurrency.dart';
import 'package:bitnet/backbone/helper/databaserefs.dart';
import 'package:bitnet/backbone/streams/card_provider.dart';
import 'package:bitnet/backbone/streams/currency_provider.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/buttons/roundedbutton.dart';
import 'package:bitnet/components/container/avatar.dart';
import 'package:bitnet/components/container/imagewithtext.dart';
import 'package:bitnet/components/dialogsandsheets/bottom_sheets/bit_net_bottom_sheet.dart';
import 'package:bitnet/components/marketplace_widgets/CommonBtn.dart';
import 'package:bitnet/components/marketplace_widgets/CommonHeading.dart';
import 'package:bitnet/components/marketplace_widgets/FilterPillList.dart';
import 'package:bitnet/components/marketplace_widgets/PillLabel.dart';
import 'package:bitnet/components/resultlist/transactions.dart';
import 'package:bitnet/models/bitcoin/chartline.dart';
import 'package:bitnet/models/marketplace/modals.dart';
import 'package:bitnet/pages/marketplace/FilterScreen.dart';
import 'package:bitnet/pages/wallet/component/wallet_filter_screen.dart';
import 'package:bitnet/pages/wallet/provider/balance_hide_provider.dart';
import 'package:bitnet/pages/wallet/wallet.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:bitnet/components/items/balancecard.dart';
import 'package:bitnet/components/items/cryptoitem.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:vibration/vibration.dart';
import 'package:vrouter/vrouter.dart';
import 'package:another_flushbar/flushbar.dart';

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
    String? card = Provider.of<CardChangeProvider>(context).selectedCard;
    print(card);
    final currencyEquivalent = bitcoinPrice != null
        ? (widget.controller.totalBalanceSAT / 100000000 * bitcoinPrice)
            .toStringAsFixed(2)
        : "0.00";

    List<Container> cards =  [
            Container(
                child: BalanceCardLightning(controller: widget.controller)),
            Container(child: BalanceCardBtc(controller: widget.controller)),
          ];

    return bitnetScaffold(
      context: context,
      body: ListView(
        children: [
          Stack(
            children: [
              GlassContainer(
                  borderThickness: 0,
                  child: Container(
                    height: AppTheme.cardPadding * 12,
                  )),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: AppTheme.cardPadding * 1.5),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppTheme.cardPadding),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Avatar(
                              size: AppTheme.cardPadding * 2,
                            ),
                            const SizedBox(width: AppTheme.elementSpacing),
                            Consumer<BalanceHideProvider>(
                                builder: (context, balanceHideProvider, _) {
                                return balanceHideProvider.hideBalance! ? Text('*****'): Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${widget.controller.totalBalanceStr}",
                                      style: Theme.of(context).textTheme.titleLarge,
                                    ),
                                    Text(
                                      "= ${currencyEquivalent}${getCurrency(currency ?? '')}",
                                      style: Theme.of(context).textTheme.titleSmall,
                                    ),
                                  ],
                                );
                              }
                            ),
                          ],
                        ),
                        RoundedButtonWidget(
                            size: AppTheme.cardPadding * 1.25,
                            buttonType: ButtonType.transparent,
                            iconData: FontAwesomeIcons.eye,
                            onTap: () {
                              Provider.of<BalanceHideProvider>(context, listen: false).setHideBalance();
                            }),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: AppTheme.cardPadding * 10,
                    child: Stack(
                      children: [
                        CardSwiper(
                          padding: const EdgeInsets.symmetric(
                              horizontal: AppTheme.cardPadding,
                              vertical: AppTheme.cardPadding),
                          scale: 1.0,
                          initialIndex: card == 'lightning' ? 0 : 1,
                          cardsCount: cards.length,
                          onSwipe: (int index, int? previousIndex,
                              CardSwiperDirection direction) {
                            Provider.of<CardChangeProvider>(context,
                                    listen: false)
                                .setCardInDatabase(card == 'onChain'
                                    ? 'lightning'
                                    : 'onChain');
                            return true;
                          },
                          cardBuilder: (context, index, percentThresholdX,
                                  percentThresholdY) =>
                              cards[index],
                        )
                      ],
                    ),
                  ),
                  Center(
                    child: LongButtonWidget(
                      title: 'Loop',
                      buttonType: ButtonType.transparent,
                      customWidth: AppTheme.cardPadding * 4.5,
                      customHeight: AppTheme.cardPadding * 1.5,
                      leadingIcon: Icon(Icons.loop_rounded),
                      onTap: () {
                        VRouter.of(context).to("/wallet/loop_screen");
                      },
                    ),
                  ),
                  const SizedBox(height: AppTheme.cardPadding * 1),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppTheme.cardPadding),
                    child: Text(
                      "Chart",
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
                        LongButtonWidget(
                            buttonType: ButtonType.solid,
                            title: "Send",
                            customWidth: AppTheme.cardPadding * 6.5,
                            leadingIcon: Icon(FontAwesomeIcons.circleUp),
                            onTap: () {
                              VRouter.of(context).to('/wallet/send');
                            }),
                        LongButtonWidget(
                            buttonType: ButtonType.transparent,
                            title: "Receive",
                            customWidth: AppTheme.cardPadding * 6.5,
                            leadingIcon: Icon(FontAwesomeIcons.circleDown),
                            onTap: () {
                              VRouter.of(context).to('/wallet/receive');
                            }),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppTheme.cardPadding * 2),
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
                                  BitNetBottomSheet(context: context,
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
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Transactions(fullList: true)));
                                }),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppTheme.elementSpacing),
                  Transactions(),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
