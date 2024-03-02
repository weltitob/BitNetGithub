import 'package:bitnet/backbone/helper/getcurrency.dart';
import 'package:bitnet/backbone/streams/currency_provider.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/buttons/roundedbutton.dart';
import 'package:bitnet/components/container/avatar.dart';
import 'package:bitnet/components/container/imagewithtext.dart';
import 'package:bitnet/components/resultlist/transactions.dart';
import 'package:bitnet/models/bitcoin/chartline.dart';
import 'package:bitnet/pages/wallet/wallet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:bitnet/components/items/balancecard.dart';
import 'package:bitnet/components/items/cryptoitem.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:vibration/vibration.dart';
import 'package:vrouter/vrouter.dart';
import 'package:another_flushbar/flushbar.dart';


class WalletScreen extends StatelessWidget {
  final WalletController controller;
  const WalletScreen({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final chartLine = Provider.of<ChartLine?>(context, listen: true);
    String? currency = Provider.of<CurrencyChangeProvider>(context).selectedCurrency;
    currency = currency ?? "USD";

    final bitcoinPrice = chartLine?.price;
    final currencyEquivalent = bitcoinPrice != null ? (double.parse(controller.totalBalanceStr) / 100000000 * bitcoinPrice).toStringAsFixed(2) : "0.00";

    List<Container> cards = [
      Container(child: BalanceCardLightning(controller: controller)),
      Container(child: BalanceCardBtc(controller: controller)),
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
                    padding:
                        const EdgeInsets.symmetric(horizontal: AppTheme.cardPadding),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Avatar(
                              size: AppTheme.cardPadding * 2,
                            ),
                            const SizedBox(width: AppTheme.elementSpacing),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${controller.totalBalanceStr} SATS",
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                                Text(
                                  "= ${currencyEquivalent}${getCurrency(currency)}",
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                              ],
                            ),
                          ],
                        ),
                        RoundedButtonWidget(
                            size: AppTheme.cardPadding * 1.25,
                            buttonType: ButtonType.transparent,
                            iconData: FontAwesomeIcons.eye,
                            onTap: () {
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
                          cardsCount: cards.length,
                          onSwipe: (int index, int? previousIndex, CardSwiperDirection direction) {
                            Vibration.vibrate();
                            return true;
                          },
                          cardBuilder:
                              (context, index, percentThresholdX, percentThresholdY) =>
                                  cards[index],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppTheme.cardPadding * 2),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: AppTheme.cardPadding),
                    child: Text(
                      "Chart",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  const SizedBox(height: AppTheme.cardPadding),
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
                        LongButtonWidget(
                            buttonType: ButtonType.solid,
                            title: "Send",
                            customWidth: AppTheme.cardPadding * 6.5,
                            leadingIcon: Icon(Icons.arrow_upward_rounded),
                            onTap: () {
                              VRouter.of(context).to('/wallet/send');
                            }),
                        LongButtonWidget(
                            buttonType: ButtonType.transparent,
                            title: "Receive",
                            customWidth: AppTheme.cardPadding * 6.5,
                            leadingIcon: Icon(Icons.arrow_downward_rounded),
                            onTap: () {
                              VRouter.of(context).to('/wallet/loop_screen');
                            }),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppTheme.cardPadding * 2),
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
                                onTap: () {}),
                            SizedBox(width: AppTheme.elementSpacing,),
                            LongButtonWidget(
                                title: "All",
                                buttonType: ButtonType.transparent,
                                customWidth: AppTheme.cardPadding * 2.5,
                                customHeight: AppTheme.cardPadding * 1.25,
                                onTap: (){}),
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
