import 'package:bitnet/components/amountwidget.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/appstandards/optioncontainer.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/dialogsandsheets/bottom_sheets/bit_net_bottom_sheet.dart';
import 'package:bitnet/pages/secondpages/mempool/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:bitnet/components/chart/chart.dart';
import 'package:bitnet/components/appstandards/buildroundedbox.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class BitcoinScreen extends StatefulWidget {
  const BitcoinScreen({
    Key? key,
  }) : super(key: key);

  @override
  _BitcoinScreenState createState() => _BitcoinScreenState();
}

class _BitcoinScreenState extends State<BitcoinScreen>
    with SingleTickerProviderStateMixin {

  final _controller = ScrollController();
    late TextEditingController btcCtrlSell;
  late TextEditingController currCtrlSell;
  FocusNode nodeSell = FocusNode();

  @override
  void initState() {
    btcCtrlSell = TextEditingController();
    currCtrlSell = TextEditingController();
    
    super.initState();
  }

  @override
  void dispose() {
    btcCtrlSell.dispose();
    currCtrlSell.dispose();
    nodeSell.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    return bitnetScaffold(
      context: context,
      extendBodyBehindAppBar: true,
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: bitnetAppBar(
          text: "Bitcoin chart",
          context: context,
          onTap: () {
            Navigator.of(context).pop();
          }),
      body: ListView(
        scrollDirection: Axis.vertical,
        controller: _controller,
        children: [
          SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: Column(
              children: [
                SizedBox(
                  height: AppTheme.cardPadding * 2,
                ),
                ChartWidget(),
                SizedBox(
                  height: AppTheme.elementSpacing * 4,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    LongButtonWidget(
                        customWidth: AppTheme.cardPadding * 7.5,
                        customHeight: AppTheme.cardPadding * 2.5,
                        title: "Buy",
                        onTap: () {
                          BitNetBottomSheet(
                              context: context, child: PurchaseSheet());
                        }),
                    SizedBox(
                      width: AppTheme.elementSpacing,
                    ),
                    LongButtonWidget(
                        buttonType: ButtonType.transparent,
                        customWidth: AppTheme.cardPadding * 7.5,
                        customHeight: AppTheme.cardPadding * 2.5,
                        title: "Sell",
                        onTap: () {
                          BitNetBottomSheet(
                              context: context,
                              child: Column(
                                children: [
                                  AmountWidget(
                                      enabled: true,
                                      btcController: btcCtrlSell,
                                      currController: currCtrlSell,
                                      focusNode: nodeSell,
                                      context: context),
                                ],
                              ));
                        }),
                  ],
                )
              ],
            ),
          ),
          SizedBox(height: AppTheme.cardPadding * 4,),
          RoundedContainer(
              child: Column(
            children: [
              Text(
                "Quick Links",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SizedBox(height: AppTheme.cardPadding,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  BitNetImageWithTextContainer(
                    "Key Metrics",
                        () {
                          context.push('/wallet/bitcoinscreen/keymetrics');
                        },
                    fallbackIcon: FontAwesomeIcons.key,
                    width: AppTheme.cardPadding * 4,
                    height: AppTheme.cardPadding * 4,
                  ),
                  BitNetImageWithTextContainer(
                      "Mempool",
                          () {
                            context.push('/wallet/bitcoinscreen/mempool');
                          }, //mempoolhome
                    fallbackIcon: FontAwesomeIcons.bitcoinSign,
                    width: AppTheme.cardPadding * 4,
                    height: AppTheme.cardPadding * 4,
                  ),
                  BitNetImageWithTextContainer(
                    "Hashrate & Difficulty",
                        () {
                          context.push('/wallet/bitcoinscreen/hashrate');
                          //context.go(Uri(path: '/hashrate', queryParameters: {}).toString());
                        },
                    fallbackIcon: FontAwesomeIcons.computer,
                    width: AppTheme.cardPadding * 4,
                    height: AppTheme.cardPadding * 4,
                  )
                ],
              ),
              SizedBox(height: AppTheme.cardPadding * 1,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  BitNetImageWithTextContainer(
                    "Transactions",
                        () {
                          context.push('/wallet/bitcoinscreen/transactions');
                          //context.go(Uri(path: '/transactions', queryParameters: {}).toString());
                        },
                    fallbackIcon: FontAwesomeIcons.addressCard,
                    width: AppTheme.cardPadding * 4,
                    height: AppTheme.cardPadding * 4,
                  ),
                  BitNetImageWithTextContainer(
                    "Whales",
                        () => context.push('/wallet/bitcoinscreen/whales'),
                    fallbackIcon: FontAwesomeIcons.fish,
                    width: AppTheme.cardPadding * 4,
                    height: AppTheme.cardPadding * 4,
                  ),
                  BitNetImageWithTextContainer(
                    "News",
                        () => context.push('/wallet/bitcoinscreen/news'),
                    fallbackIcon: FontAwesomeIcons.newspaper,
                    width: AppTheme.cardPadding * 4,
                    height: AppTheme.cardPadding * 4,
                  ),
                ],
              ),
              SizedBox(height: AppTheme.cardPadding * 1,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  BitNetImageWithTextContainer(
                    "Fear and Greed",
                        () {
                      context.push('/wallet/bitcoinscreen/fearandgreed');
                    },
                    fallbackIcon: Icons.speed_rounded,
                    width: AppTheme.cardPadding * 4,
                    height: AppTheme.cardPadding * 4,
                  ),
                  BitNetImageWithTextContainer(
                    "No info",
                        () => context.push('/wallet/bitcoinscreen/whales'),
                    fallbackIcon: FontAwesomeIcons.fish,
                    width: AppTheme.cardPadding * 4,
                    height: AppTheme.cardPadding * 4,
                  ),
                  BitNetImageWithTextContainer(
                    "No info",
                        () => context.push('/wallet/bitcoinscreen/news'),
                    fallbackIcon: FontAwesomeIcons.newspaper,
                    width: AppTheme.cardPadding * 4,
                    height: AppTheme.cardPadding * 4,
                  ),
                ],
              ),
              SizedBox(height: AppTheme.cardPadding * 2,),
            ],
          )),
        ],
      ),
    );
  }
}

class PurchaseSheet extends StatefulWidget {
  const PurchaseSheet({
    super.key,
  });

  @override
  State<PurchaseSheet> createState() => _PurchaseSheetState();
}

class _PurchaseSheetState extends State<PurchaseSheet>
    with TickerProviderStateMixin {
  late TabController controller;
  late TextEditingController btcCtrlBuy;
  late TextEditingController currCtrlBuy;
  FocusNode nodeBuy = FocusNode();
  

  @override
 void initState() {
  controller = TabController(length: 3, vsync: this);
  btcCtrlBuy = TextEditingController();
  currCtrlBuy = TextEditingController();

  super.initState();
 }
 @override 
 void dispose() {
  btcCtrlBuy.dispose();
  currCtrlBuy.dispose();
  nodeBuy.dispose();
  controller.dispose();
  super.dispose();
 }
  @override
  Widget build(BuildContext context) {
    return TabBarView(
        physics: NeverScrollableScrollPhysics(),
        controller: controller,
        children: [
          Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    left: AppTheme.cardPadding,
                    right: AppTheme.cardPadding,
                    top: AppTheme.elementSpacing),
                child: Text(
                  "Purchase Bitcoin",
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
              AmountWidget(
                  enabled: true,
                  btcController: btcCtrlBuy,
                  currController: currCtrlBuy,
                  focusNode: nodeBuy,
                  context: context),
              SizedBox(
                height: AppTheme.cardPadding * 2,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Text(
                      'Payment Method',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              PaymentCardHorizontalWidget(controller: controller),
              SizedBox(height: AppTheme.elementSpacing * 8),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: LongButtonWidget(
                    title: "Buy Bitcoin",
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
                        controller.animateTo(0);
                      },
                    ),
                    Text(
                      "Purchase Bitcoin",
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
                        controller: controller, check: true),
                    SizedBox(
                      height: AppTheme.elementSpacing,
                    ),
                    PaymentCardHorizontalWidget(
                      controller: controller,
                      forward: false,
                    ),
                    SizedBox(
                      height: AppTheme.elementSpacing,
                    ),
                    PaymentCardHorizontalWidget(
                      controller: controller,
                      forward: false,
                    ),
                    SizedBox(
                      height: AppTheme.elementSpacing,
                    ),
                    NewPaymentCardHorizontalWidget(controller: controller)
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
                        controller.animateTo(1);
                      },
                    ),
                    Text(
                      "Save Card",
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
                  title: "Save Card",
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
                Text("Add New Card",
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
                              print("controller is moving");
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
