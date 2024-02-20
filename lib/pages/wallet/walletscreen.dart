import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/buttons/roundedbutton.dart';
import 'package:bitnet/components/container/avatar.dart';
import 'package:bitnet/components/container/imagewithtext.dart';
import 'package:bitnet/components/resultlist/transactions.dart';
import 'package:bitnet/pages/wallet/wallet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:bitnet/components/items/balancecard.dart';
import 'package:bitnet/components/items/cryptoitem.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vrouter/vrouter.dart';

class WalletScreen extends StatelessWidget {
  final WalletController controller;
  const WalletScreen({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final UserData userData = Provider.of<UserData>(context);

    List<Container> cards = [
      Container(child: BalanceCardLightning(controller: controller)),
      Container(child: BalanceCardBtc(controller: controller)),
    ];

    return bitnetScaffold(
      context: context,
      backgroundColor: Theme.of(context).colorScheme.background,
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
                              //image: controller.user.image,
                            ),
                            const SizedBox(width: AppTheme.elementSpacing),
                            Text(
                              "${controller.totalBalanceStr} SATS",
                              style: Theme.of(context).textTheme.titleLarge,
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
                  // Padding(
                  //   padding: EdgeInsets.symmetric(horizontal: AppTheme.cardPadding * 1),
                  //   child: GlassContainer(child: Container(
                  //     height: AppTheme.cardPadding * 4,
                  //   )),
                  // ),
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
                          cardBuilder:
                              (context, index, percentThresholdX, percentThresholdY) =>
                                  cards[index],
                        ),
                        // Align(
                        //   alignment: Alignment.centerRight,
                        //   child: RoundedButtonWidget(
                        //       buttonType: ButtonType.transparent,
                        //       size: AppTheme.cardPadding * 2.25,
                        //       iconData: FontAwesomeIcons.exchange, onTap: (){}),
                        // ),
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for (final currency in MockFavorites.data) ...[
                          CryptoItem(
                            currency: currency,
                            context: context,
                          ),
                        ],
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
                        // circButtonWidget(
                        //     context,
                        //     "Erhalten",
                        //     controller.compositionReceive,
                        //     const BackgroundGradientOrange()),

                        // circButtonWidget(
                        //     context, "Senden", controller.compositionSend,
                        //     const BackgroundGradientPurple()),
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
                              VRouter.of(context).to('/wallet/receive');
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
