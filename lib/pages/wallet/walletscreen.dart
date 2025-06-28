import 'dart:async';
import 'dart:io';

import 'package:bitnet/backbone/auth/auth.dart';
import 'package:bitnet/backbone/cloudfunctions/lnd/walletkitservice/nextaddr.dart';
import 'package:bitnet/backbone/cloudfunctions/moonpay/moonpay_quote_price.dart';
import 'package:bitnet/backbone/helper/currency/getcurrency.dart';
import 'package:bitnet/backbone/helper/helpers.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:bitnet/backbone/services/bitcoin_controller.dart';
import 'package:bitnet/backbone/services/local_storage.dart';
import 'package:bitnet/backbone/streams/currency_provider.dart';
import 'package:bitnet/backbone/streams/currency_type_provider.dart';
import 'package:bitnet/backbone/streams/locale_provider.dart';
import 'package:bitnet/components/amountwidget.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetListTile.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/appstandards/optioncontainer.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/buttons/roundedbutton.dart';
import 'package:bitnet/components/container/avatar.dart';
import 'package:bitnet/components/appstandards/glasscontainer.dart';
import 'package:bitnet/components/items/colored_price_widget.dart';
import 'package:bitnet/components/items/cryptoinfoitem.dart';
import 'package:bitnet/components/items/cryptoitem.dart';
import 'package:bitnet/components/loaders/loaders.dart';
import 'package:bitnet/components/resultlist/transactions.dart';
import 'package:bitnet/models/bitcoin/chartline.dart';
import 'package:bitnet/models/bitcoin/lnd/subserverinfo.dart';
import 'package:bitnet/models/bitcoin/walletkit/addressmodel.dart';
import 'package:bitnet/models/currency/bitcoinunitmodel.dart';
import 'package:bitnet/pages/bottomnav.dart';
import 'package:bitnet/pages/profile/profile_controller.dart';
import 'package:bitnet/pages/wallet/actions/send/controllers/send_controller.dart';
import 'package:bitnet/pages/wallet/controllers/wallet_controller.dart';
import 'package:bitnet/pages/wallet/loop/loop_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:bitnet/intl/generated/l10n.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:bitnet/services/moonpay.dart'
    if (dart.library.html) 'package:bitnet/services/moonpay_web.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class WalletScreen extends GetWidget<WalletsController> {
  WalletScreen({Key? key}) : super(key: key);

  // Moved outside build method for better performance
  bool _isPriceChangePositive(BitcoinController controller) {
    // Get the price difference
    double lastPrice = controller.pbNew_lastpricerounded.value;
    double firstPrice = controller.pbNew_firstpriceexact;
    double diff = lastPrice - firstPrice;

    // Always consider zero or very small differences as positive
    bool isZeroOrPositive = diff >= 0 || diff.abs() < 0.001;

    // Added safeguard: If the percentChange is "-0%" or "0%", always return true
    String percentChange = controller.pbOverallPriceChange.value;
    if (percentChange.trim() == "-0%" || percentChange.trim() == "0%") {
      return true;
    }

    return isZeroOrPositive;
  }

  @override
  Widget build(BuildContext context) {
    // Cache MediaQuery to avoid multiple expensive calls
    final screenSize = MediaQuery.of(context).size;
    WalletsController walletController = Get.find<WalletsController>();
    ProfileController profileController = Get.find<ProfileController>();
    String? currency =
        Provider.of<CurrencyChangeProvider>(context).selectedCurrency;
    currency = currency ?? "USD";

    if (!Get.isRegistered<BitcoinController>()) {
      return dotProgress(context);
    }
    BitcoinController bitcoinController = Get.find<BitcoinController>();

    return bitnetScaffold(
      context: context,
      body: StatefulBuilder(
        builder: (context, setState) {
          // Create PageController inline to avoid missing method issues
          final pageController = PageController(
            initialPage: controller.selectedCard.value == 'onchain' ? 1 : 0,
            viewportFraction: 0.8885,
          );
          SubServersStatus?
              subServersStatus; // local variable to store fetched data

          return CustomScrollView(
            controller: controller.scrollController,
            slivers: [
              SliverToBoxAdapter(
                child: Stack(
                  children: [
                    Obx(() => Container(
                          height: 250,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              stops: const [
                                0.0, // Start of the gradient
                                0.75,
                                1.0, // End of the gradient
                              ],
                              colors: [
                                // Force green (positive) color if price change is 0 or very small
                                (_isPriceChangePositive(bitcoinController) ||
                                        bitcoinController
                                            .pbOverallPriceChange.value
                                            .contains("0%"))
                                    ? AppTheme.successColor.withOpacity(0.15)
                                    : AppTheme.errorColor.withOpacity(0.1),
                                (_isPriceChangePositive(bitcoinController) ||
                                        bitcoinController
                                            .pbOverallPriceChange.value
                                            .contains("0%"))
                                    ? AppTheme.successColor.withOpacity(0.04)
                                    : AppTheme.errorColor.withOpacity(0.03),
                                Colors
                                    .transparent, // Ensure the bottom remains fully transparent
                              ],
                            ),
                          ),
                        )),
                    Opacity(
                      opacity: 0.1,
                      child: WalletChartWidget(
                          bitcoinController: bitcoinController),
                    ),
                    Column(
                      children: [
                        Obx(
                          () {
                            controller.chartLines.value;
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: AppTheme.cardPadding * 1.h),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: AppTheme.cardPadding * 1,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      profileController.isUserLoading.value ||
                                              profileController.userData.value
                                                  .profileImageUrl.isEmpty
                                          ? Avatar(
                                              onTap: () async {
                                                // context.go(
                                                //     '/profile/${Auth().currentUser?.uid}');
                                                bottomNavKey.currentState
                                                    ?.onItemTapped(
                                                        2,
                                                        Get.find<
                                                                ProfileController>()
                                                            .scrollController);
                                              },
                                              isNft: false,
                                            )
                                          : Avatar(
                                              onTap: () async {
                                                final profileId =
                                                    Auth().currentUser?.uid;
                                                // context.go('/profile/$profileId');
                                                bottomNavKey.currentState
                                                    ?.onItemTapped(
                                                        2,
                                                        Get.find<
                                                                ProfileController>()
                                                            .scrollController);
                                              },
                                              size: AppTheme.cardPadding * 1.5,
                                              mxContent: Uri.parse(
                                                profileController.userData.value
                                                    .profileImageUrl,
                                              ),
                                              type:
                                                  profilePictureType.lightning,
                                              isNft: profileController
                                                  .userData
                                                  .value
                                                  .nft_profile_id
                                                  .isNotEmpty,
                                            ),
                                      Row(
                                        children: [
                                          Obx(
                                            () => LongButtonWidget(
                                              title: bitcoinController
                                                  .pbSelectedtimespan.value,
                                              buttonType:
                                                  ButtonType.transparent,
                                              onTap: () {
                                                _showTimeframeBottomSheet(
                                                    context,
                                                    bitcoinController,
                                                    controller);
                                              },
                                              customHeight:
                                                  AppTheme.cardPadding * 1.25,
                                              customWidth: AppTheme
                                                      .cardPadding *
                                                  3, // Width that balances visibility and compactness
                                              leadingIcon: Icon(Icons
                                                  .arrow_drop_down_rounded),
                                            ),
                                          ),
                                          SizedBox(
                                            width: AppTheme.elementSpacing *
                                                0.75.w,
                                          ),
                                          Obx(
                                            () => RoundedButtonWidget(
                                              size: AppTheme.cardPadding * 1.25,
                                              buttonType:
                                                  ButtonType.transparent,
                                              iconData: controller
                                                          .hideBalance.value ==
                                                      false
                                                  ? FontAwesomeIcons.eyeSlash
                                                  : FontAwesomeIcons.eye,
                                              onTap: () {
                                                controller.setHideBalance(
                                                  hide: !controller
                                                      .hideBalance.value,
                                                );
                                              },
                                            ),
                                          ),
                                          // RoundedButtonWidget(
                                          //   size: AppTheme.cardPadding * 1.25,
                                          //   buttonType: ButtonType.transparent,
                                          //   iconData: Icons.settings,
                                          //   onTap: () {
                                          //     BitNetBottomSheet(
                                          //       width: double.infinity,
                                          //       context: context,
                                          //       borderRadius:
                                          //           AppTheme.borderRadiusBig,
                                          //       child: Container(
                                          //         decoration: BoxDecoration(
                                          //           color: Theme.of(context)
                                          //               .canvasColor,
                                          //           borderRadius: BorderRadius.only(
                                          //             topLeft:
                                          //                 AppTheme.cornerRadiusBig,
                                          //             topRight:
                                          //                 AppTheme.cornerRadiusBig,
                                          //           ),
                                          //         ),
                                          //         child: ClipRRect(
                                          //           borderRadius: BorderRadius.only(
                                          //             topLeft:
                                          //                 AppTheme.cornerRadiusBig,
                                          //             topRight:
                                          //                 AppTheme.cornerRadiusBig,
                                          //           ),
                                          //           child: Settings(),
                                          //         ),
                                          //       ),
                                          //     );
                                          //   },
                                          // ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: AppTheme.cardPadding * 1.5.h),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: AppTheme.cardPadding * 1,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      // Text(
                                      //   L10n.of(context)!.totalWalletBal,
                                      //   style: Theme.of(context)
                                      //       .textTheme
                                      //       .bodyMedium,
                                      // ),
                                      // const SizedBox(
                                      //     height:
                                      //         AppTheme.elementSpacing * 0.25),
                                      Obx(
                                        () => Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            controller.hideBalance.value
                                                ? Text(
                                                    '******',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .displayLarge,
                                                  )
                                                : Obx(() {
                                                    final chartLine = controller
                                                        .chartLines.value;
                                                    final bitcoinPrice =
                                                        chartLine?.price;
                                                    final currencyEquivalent =
                                                        bitcoinPrice != null
                                                            ? (controller
                                                                        .totalBalanceSAT
                                                                        .value /
                                                                    100000000 *
                                                                    bitcoinPrice)
                                                                .toStringAsFixed(
                                                                    2)
                                                            : "0.00";

                                                    final coin = Provider.of<
                                                            CurrencyTypeProvider>(
                                                        context,
                                                        listen: true);
                                                    final currency = Provider
                                                        .of<CurrencyChangeProvider>(
                                                            context,
                                                            listen: true);
                                                    controller.coin.value = coin
                                                            .coin ??
                                                        controller.coin.value;
                                                    controller.selectedCurrency
                                                        ?.value = currency
                                                            .selectedCurrency ??
                                                        controller
                                                            .selectedCurrency!
                                                            .value;

                                                    // Consider timeframe price changes for display
                                                    double currentPrice =
                                                        bitcoinController
                                                            .pbNew_lastpriceexact;
                                                    double historicalPrice =
                                                        bitcoinController
                                                            .pbNew_firstpriceexact;
                                                    double displayValue =
                                                        currencyEquivalent !=
                                                                null
                                                            ? double.parse(
                                                                currencyEquivalent)
                                                            : 0.0;

                                                    // If showing in fiat and not in day view, adjust the displayed amount
                                                    if (!controller
                                                            .coin.value &&
                                                        bitcoinController
                                                                .pbSelectedtimespan
                                                                .value !=
                                                            "1D" &&
                                                        historicalPrice > 0) {
                                                      // Calculate the ratio between historical and current price
                                                      double ratio =
                                                          currentPrice /
                                                              historicalPrice;
                                                      // Apply the ratio to get the current equivalent value
                                                      if (ratio != 1.0) {
                                                        displayValue =
                                                            displayValue /
                                                                ratio;
                                                      }
                                                    }

                                                    return Obx(() {
                                                      // Force rebuild on timeframe change
                                                      controller
                                                          .timeframeChangeCounter
                                                          .value;

                                                      return GestureDetector(
                                                        onTap: () {
                                                          controller
                                                              .setCurrencyType(
                                                            !controller
                                                                .coin.value,
                                                            updateDatabase:
                                                                false,
                                                          );
                                                          coin.setCurrencyType(
                                                            controller
                                                                .coin.value,
                                                          );
                                                        },
                                                        child:
                                                            (controller
                                                                    .coin.value)
                                                                ? Row(
                                                                    children: [
                                                                      Text(
                                                                        controller
                                                                            .totalBalance
                                                                            .value
                                                                            .amount
                                                                            .toString(),
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                        style: Theme.of(context)
                                                                            .textTheme
                                                                            .displayLarge,
                                                                      ),
                                                                      Icon(
                                                                        getCurrencyIcon(
                                                                          controller
                                                                              .totalBalance
                                                                              .value
                                                                              .bitcoinUnitAsString,
                                                                        ),
                                                                        size: AppTheme.iconSize *
                                                                            2.25,
                                                                      ),
                                                                    ],
                                                                  )
                                                                : Text(
                                                                    "${displayValue.toStringAsFixed(2)}${getCurrency(controller.selectedCurrency == null ? '' : controller.selectedCurrency!.value)}",
                                                                    style: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .displayLarge,
                                                                  ),
                                                      );
                                                    });
                                                  }),
                                          ],
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          // Use a dedicated widget for price change to reduce rebuild scope
                                          WalletPriceChangeWidget(
                                            controller: controller,
                                            bitcoinController:
                                                bitcoinController,
                                            currency: currency!,
                                          ),
                                          SizedBox(
                                              width: AppTheme.elementSpacing *
                                                  1), // Add some spacing
                                          // Use a dedicated widget for percentage display
                                          WalletPercentageWidget(
                                            bitcoinController:
                                                bitcoinController,
                                          ),
                                        ],
                                      ),
                                      Container(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                                height: AppTheme.cardPadding.h *
                                                    1.5),
                                            // Text(
                                            //   L10n.of(context)!.actions,
                                            //   style: Theme.of(context).textTheme.titleLarge,
                                            // ),
                                            // SizedBox(height: AppTheme.cardPadding.h),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Flexible(
                                                  child:
                                                      BitNetImageWithTextButton(
                                                    L10n.of(context)!.send,
                                                    () {
                                                      context
                                                          .go('/wallet/send');
                                                      WidgetsBinding.instance
                                                          .addPostFrameCallback(
                                                              (_) {
                                                        Get.find<
                                                                SendsController>()
                                                            .getClipboardData();
                                                      });
                                                    },
                                                    // image: "assets/images/send_image.png",
                                                    width:
                                                        AppTheme.cardPadding *
                                                            2.5.h,
                                                    height:
                                                        AppTheme.cardPadding *
                                                            2.5.h,
                                                    fallbackIcon: Icons
                                                        .arrow_upward_rounded,
                                                  ),
                                                ),
                                                Flexible(
                                                  child:
                                                      BitNetImageWithTextButton(
                                                    L10n.of(context)!.receive,
                                                    () {
                                                      context.go(
                                                        '/wallet/receive/${controller.selectedCard.value}',
                                                      );
                                                    },
                                                    // image: "assets/images/receive_image.png",
                                                    width:
                                                        AppTheme.cardPadding *
                                                            2.5.h,
                                                    height:
                                                        AppTheme.cardPadding *
                                                            2.5.h,
                                                    fallbackIcon: Icons
                                                        .arrow_downward_rounded,
                                                  ),
                                                ),
                                                Flexible(
                                                  child:
                                                      BitNetImageWithTextButton(
                                                    "Swap",
                                                    () {
                                                      Get.put(
                                                          LoopsController());
                                                      context.go(
                                                          "/wallet/loop_screen");
                                                    },
                                                    // image: "assets/images/rebalance_image.png",
                                                    width:
                                                        AppTheme.cardPadding *
                                                            2.5.h,
                                                    height:
                                                        AppTheme.cardPadding *
                                                            2.5.h,
                                                    fallbackIcon:
                                                        Icons.sync_rounded,
                                                  ),
                                                ),
                                                Flexible(
                                                  child:
                                                      BitNetImageWithTextButton(
                                                    "Buy",
                                                    () {
                                                      // Use pushNamed to maintain the navigation stack properly
                                                      context
                                                          .push("/wallet/buy");
                                                    },
                                                    // image: "assets/images/send_image.png",
                                                    width:
                                                        AppTheme.cardPadding *
                                                            2.5.h,
                                                    height:
                                                        AppTheme.cardPadding *
                                                            2.5.h,
                                                    fallbackIcon:
                                                        FontAwesomeIcons.btc,
                                                    fallbackIconSize:
                                                        AppTheme.iconSize * 1.5,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // -------------------------------------------
                                // PageView with partial peeking & spacing

                                // -------------------------------------------
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // All other SliverToBoxAdapters remain the same

              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppTheme.cardPadding,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: AppTheme.cardPadding.h * 1.75),
                      Text(
                        "Cryptos",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      SizedBox(height: AppTheme.cardPadding.h),
                      Obx(
                        () {
                          final logger = Get.find<LoggerService>();
                          final confirmedBalanceStr = walletController
                              .onchainBalance.value.confirmedBalance.obs;
                          final unconfirmedBalanceStr = walletController
                              .onchainBalance.value.unconfirmedBalance.obs;

                          logger.i(
                            "Confirmed Balance onchain: $confirmedBalanceStr",
                          );
                          logger.i(
                            "Unconfirmed Balance onchain: $unconfirmedBalanceStr",
                          );

                          return CryptoInfoItem(
                            balance: confirmedBalanceStr.value,
                            // confirmedBalance: confirmedBalanceStr.value,
                            // unconfirmedBalance: unconfirmedBalanceStr.value,
                            defaultUnit: BitcoinUnits.SAT,
                            currency: Currency(
                              code: 'BTC',
                              name: 'Bitcoin (Onchain)',
                              icon: Image.asset("assets/images/bitcoin.png"),
                            ),
                            context: context,
                            onTap: () {
                              // Use push to maintain navigation history
                              context.push('/wallet/bitcoinscreen');
                            },
                          );
                        },
                      ),
                      SizedBox(height: AppTheme.elementSpacing.h),
                      Obx(() {
                        final confirmedBalanceStr =
                            walletController.lightningBalance.value.balance.obs;

                        return CryptoInfoItem(
                          balance: confirmedBalanceStr.value,
                          // confirmedBalance: confirmedBalanceStr.value,
                          defaultUnit: BitcoinUnits.SAT,
                          currency: Currency(
                            code: 'BTC',
                            name: 'Bitcoin (Lightning)',
                            icon: Image.asset("assets/images/lightning.png"),
                          ),
                          context: context,
                          onTap: () {
                            // Use push to maintain navigation history
                            context.push('/wallet/bitcoinscreen');
                          },
                          // unconfirmedBalance: '',
                        );
                      }),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: StatefulBuilder(builder: (context, setStateInner) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppTheme.cardPadding,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: AppTheme.cardPadding.h * 1.75),
                        Text(
                          L10n.of(context)!.activity,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        SizedBox(height: AppTheme.elementSpacing.h),
                      ],
                    ),
                  );
                }),
              ),
              Transactions(
                scrollController: controller.scrollController,
              ),
            ],
          );
        },
      ),
    );
  }
}

class BuyBtcSheet extends StatefulWidget {
  const BuyBtcSheet({
    super.key,
  });

  @override
  State<BuyBtcSheet> createState() => _BuyBtcSheetState();
}

class _BuyBtcSheetState extends State<BuyBtcSheet> {
  late TextEditingController btcController;
  late TextEditingController satController;
  late TextEditingController currController;
  late FocusNode focusNode;
  late PageController pageController;
  String providerName = "Stripe";
  String paymentMethodName = "Credit or Debit Card";
  String paymentMethodId = "credit_debit_card";
  String providerId = "stripe";
  double? moonpayQuoteCurrPrice;
  double? moonpayBaseCurrPrice;
  late Timer timer;
  int time = 0;
  int page = 0;
  @override
  void initState() {
    super.initState();
    btcController = TextEditingController();
    satController = TextEditingController();
    currController = TextEditingController();
    focusNode = FocusNode();
    pageController = PageController();
    timer = Timer.periodic(Duration(seconds: 1), (_) async {
      String? currency =
          Provider.of<CurrencyChangeProvider>(context, listen: false)
              .selectedCurrency;
      currency = currency ?? "USD";
      currency = currency.toLowerCase();

      if (time == 0) {
        time = 20;
        double btcAmount = double.tryParse(btcController.text) ?? 0.0;
        btcAmount = double.tryParse(btcAmount
                .toStringAsFixed(5)
                .replaceFirst(RegExp(r'\.?0+$'), '')) ??
            0.0;
        if (btcAmount > 0) {
          var quotePrice = await moonpayQuotePrice(btcAmount, currency);
          if (quotePrice != null) {
            moonpayBaseCurrPrice = quotePrice[0];
            moonpayQuoteCurrPrice = quotePrice[1];
          }
        } else {
          moonpayBaseCurrPrice = 0;
          moonpayQuoteCurrPrice = 0;
        }
      } else {
        time--;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    btcController.dispose();
    satController.dispose();
    currController.dispose();
    focusNode.dispose();
    pageController.dispose();
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    String? currency =
        Provider.of<CurrencyChangeProvider>(context).selectedCurrency;
    currency = currency ?? "USD";

    return bitnetScaffold(
      context: context,
      appBar: page == 1
          ? bitnetAppBar(
              context: context,
              hasBackButton: true,
              text: "Providers",
              buttonType: ButtonType.transparent,
              onTap: () {
                pageController.animateToPage(0,
                    duration: Duration(milliseconds: 200),
                    curve: Curves.easeIn);
                page = 0;
                setState(() {});
              },
              actions: [Text("Next quote: $time   ")],
            )
          : null,
      body: PageView(controller: pageController, children: [
        Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(
                    height: AppTheme.cardPadding * 2,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: AppTheme.cardPadding.w),
                    child: AmountWidget(
                        enabled: () => true,
                        btcController: btcController,
                        satController: satController,
                        currController: currController,
                        focusNode: focusNode,
                        context: context,
                        autoConvert: true),
                  ),
                  SizedBox(
                    height: 30,
                  )
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  LongButtonWidget(
                      customWidth: MediaQuery.of(context).size.width * 0.9,
                      title: "$paymentMethodName: $providerName",
                      buttonType: ButtonType.transparent,
                      onTap: () {
                        pageController.nextPage(
                            duration: Duration(milliseconds: 200),
                            curve: Curves.easeIn);
                        page = 1;
                        setState(() {});
                      }),
                  SizedBox(
                    height: 8,
                  ),
                  LongButtonWidget(
                      customWidth: MediaQuery.of(context).size.width * 0.9,
                      title: "Buy",
                      onTap: () async {
                        if (providerId == "stripe") {
                        } else {
                          String lang =
                              Provider.of<LocalProvider>(context, listen: false)
                                  .locale
                                  .languageCode;
                          double btcAmount =
                              double.tryParse(btcController.text) ?? 0.0;
                          btcAmount = double.tryParse(btcAmount
                                  .toStringAsFixed(5)
                                  .replaceFirst(RegExp(r'\.?0+$'), '')) ??
                              0.0;

                          MoonpayFlutter().showMoonPay(await getBtcAddress(),
                              btcAmount, lang, "btc", 0.0, paymentMethodId);
                          print(
                              "url generated is null ? ${MoonpayFlutter().onUrlGenerated == null} ");
                        }
                      })
                ],
              ),
            )
          ],
        ),
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 60,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 32.0),
                child: Text(
                  "Pay With",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GlassContainer(
                    opacity: 0.05,
                    child: BitNetListTile(
                      contentPadding: EdgeInsets.only(
                          left: 16.0, right: 16.0, bottom: 16.0),
                      text: "Credit or Debit Card",
                      onTap: () {
                        pageController.animateToPage(0,
                            duration: Duration(milliseconds: 200),
                            curve: Curves.easeIn);
                        page = 0;
                        paymentMethodName = "Credit or Debit Card";
                        paymentMethodId = "credit_debit_card";
                        setState(() {});
                      },
                      leading: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Icon(Icons.wallet_rounded)),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GlassContainer(
                    opacity: 0.05,
                    child: BitNetListTile(
                      contentPadding: EdgeInsets.only(
                          left: 16.0, right: 16.0, bottom: 16.0),
                      text: "Google Pay",
                      onTap: () {
                        pageController.animateToPage(0,
                            duration: Duration(milliseconds: 200),
                            curve: Curves.easeIn);
                        page = 0;
                        paymentMethodName = "Google Pay";
                        paymentMethodId = "google_play";
                        setState(() {});
                      },
                      leading: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Icon(FontAwesomeIcons.google)),
                    )),
              ),
              if (Platform.isIOS)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GlassContainer(
                      opacity: 0.05,
                      child: BitNetListTile(
                        contentPadding: EdgeInsets.only(
                            left: 16.0, right: 16.0, bottom: 16.0),
                        text: "Apple Pay",
                        onTap: () {
                          pageController.animateToPage(0,
                              duration: Duration(milliseconds: 200),
                              curve: Curves.easeIn);
                          paymentMethodName = "Apple Pay";
                          paymentMethodId = "apple_play";
                          page = 0;
                          setState(() {});
                        },
                        leading: Icon(
                          FontAwesomeIcons.applePay,
                          size: 32,
                        ),
                      )),
                ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GlassContainer(
                    opacity: 0.05,
                    child: BitNetListTile(
                      contentPadding: EdgeInsets.only(
                          left: 16.0, right: 16.0, bottom: 16.0),
                      text: "Paypal",
                      onTap: () {
                        pageController.animateToPage(0,
                            duration: Duration(milliseconds: 200),
                            curve: Curves.easeIn);
                        paymentMethodName = "Paypal";
                        paymentMethodId = "paypal";
                        page = 0;
                        setState(() {});
                      },
                      leading: Icon(
                        FontAwesomeIcons.paypal,
                        size: 32,
                      ),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 32.0),
                child: Text(
                  "Select Provider",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GlassContainer(
                    opacity: 0.05,
                    child: BitNetListTile(
                      onTap: () {
                        pageController.animateToPage(0,
                            duration: Duration(milliseconds: 200),
                            curve: Curves.easeIn);
                        page = 0;
                        providerName = "Stripe";
                        providerId = "stripe";
                        setState(() {});
                      },
                      contentPadding: EdgeInsets.only(
                          left: 16.0, right: 16.0, bottom: 16.0),
                      text: "Stripe",
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          'assets/images/stripe.png',
                          width: 32,
                          height: 32,
                        ),
                      ),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GlassContainer(
                    opacity: 0.05,
                    child: BitNetListTile(
                      onTap: () {
                        pageController.animateToPage(0,
                            duration: Duration(milliseconds: 200),
                            curve: Curves.easeIn);
                        page = 0;
                        providerName = "MoonPay";
                        providerId = "moonpay";
                        setState(() {});
                      },
                      contentPadding: EdgeInsets.only(
                          left: 16.0, right: 16.0, bottom: 16.0),
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          'assets/images/moonpay.png',
                          width: 32,
                          height: 32,
                        ),
                      ),
                      text: "MoonPay",
                      trailing: moonpayQuoteCurrPrice != null
                          ? Column(
                              children: [
                                Row(
                                  children: [
                                    Text(moonpayQuoteCurrPrice!.toString()),
                                    Icon(getCurrencyIcon(BitcoinUnits.BTC.name))
                                  ],
                                ),
                                Text(
                                    "= ${moonpayBaseCurrPrice!.toStringAsFixed(2)} ${getCurrency(currency)}")
                              ],
                            )
                          : null,
                    )),
              ),
            ],
          ),
        )
      ]),
    );
  }

  Future<String> getBtcAddress() async {
    String? addr = await nextAddr(Auth().currentUser!.uid);
    if (addr == null) {
      throw Exception("Failed to generate Bitcoin address");
    }
    BitcoinAddress address = BitcoinAddress.fromJson({'addr': addr});
    Get.find<WalletsController>().btcAddresses.add(address.addr);
    LocalStorage.instance.setStringList(
        Get.find<WalletsController>().btcAddresses,
        "btc_addresses:${FirebaseAuth.instance.currentUser!.uid}");
    return address.addr;
  }
}

/// Widget for displaying price change in the wallet
/// Extracted to reduce rebuild scope and improve performance
class WalletPriceChangeWidget extends StatelessWidget {
  final WalletsController controller;
  final BitcoinController bitcoinController;
  final String currency;

  const WalletPriceChangeWidget({
    Key? key,
    required this.controller,
    required this.bitcoinController,
    required this.currency,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // Force rebuild when timeframe changes
      controller.timeframeChangeCounter.value;

      // Use values pre-calculated in the controller where possible
      bool isPositive = bitcoinController.isPriceChangePositive.value;

      // Get current wallet value to calculate the absolute change if needed
      final chartLine = controller.chartLines.value;
      if (chartLine != null && !controller.coin.value) {
        // Calculate adjusted value difference (in currency) using pre-calculated percentage
        String formattedDiff = bitcoinController.formattedPriceChange.value;

        return ColoredPriceWidget(
          shouldHideAmount: true,
          price: formattedDiff,
          isPositive: isPositive,
          currencySymbol: getCurrency(currency),
        );
      } else {
        // Use pre-calculated price change
        String formattedDiff = bitcoinController.formattedPriceChange.value;

        return ColoredPriceWidget(
          shouldHideAmount: true,
          price: formattedDiff,
          isPositive: isPositive,
          currencySymbol: getCurrency(currency),
        );
      }
    });
  }
}

/// Widget for displaying percentage change in the wallet
/// Extracted to reduce rebuild scope and improve performance
class WalletPercentageWidget extends StatelessWidget {
  final BitcoinController bitcoinController;

  const WalletPercentageWidget({
    Key? key,
    required this.bitcoinController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => BitNetPercentWidget(
          shouldHideAmount: true,
          priceChange: bitcoinController.pbOverallPriceChange.value,
        ));
  }
}

/// Widget for displaying the price chart in the wallet
/// Extracted to reduce rebuild scope and improve performance
class WalletChartWidget extends StatelessWidget {
  final BitcoinController bitcoinController;

  const WalletChartWidget({
    Key? key,
    required this.bitcoinController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      child: Obx(() {
        bitcoinController.pbChartPing.value;
        // Ensure we have data to display
        if (bitcoinController.pbCurrentline.value.isEmpty) {
          // If no data is available, create a dummy chart line
          double now = DateTime.now().millisecondsSinceEpoch.toDouble();
          bitcoinController.pbCurrentline.value = [
            ChartLine(
                price: 0,
                time: now - Duration(hours: 24).inMilliseconds.toDouble()),
            ChartLine(price: 0, time: now),
          ];
        }

        // Use pre-calculated values from the controller
        bool isPositive = bitcoinController.isPriceChangePositive.value;

        return SfCartesianChart(
          enableAxisAnimation: true,
          plotAreaBorderWidth: 0,
          primaryXAxis: CategoryAxis(
            labelPlacement: LabelPlacement.onTicks,
            edgeLabelPlacement: EdgeLabelPlacement.none,
            isVisible: false,
            majorGridLines: const MajorGridLines(width: 0),
            majorTickLines: const MajorTickLines(width: 0),
          ),
          primaryYAxis: NumericAxis(
            plotOffset: 0,
            edgeLabelPlacement: EdgeLabelPlacement.none,
            isVisible: false,
            majorGridLines: const MajorGridLines(width: 0),
            majorTickLines: const MajorTickLines(width: 0),
          ),
          series: <CartesianSeries>[
            // SplineSeries with a glowing effect
            SplineSeries<ChartLine, double>(
              dataSource: bitcoinController.pbCurrentline.value,
              animationDuration: 0,
              xValueMapper: (ChartLine crypto, _) => crypto.time,
              yValueMapper: (ChartLine crypto, _) => crypto.price,
              color: isPositive ? AppTheme.successColor : AppTheme.errorColor,
              width: 3,
              splineType: SplineType.natural,
            ),
          ],
        );
      }),
    );
  }
}

// Helper method to show timeframe bottom sheet
void _showTimeframeBottomSheet(BuildContext context,
    BitcoinController bitcoinController, WalletsController controller) {
  showModalBottomSheet(
    context: context,
    elevation: 0.0,
    backgroundColor: Colors.transparent,
    isDismissible: true,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(AppTheme.borderRadiusBig),
        topRight: Radius.circular(AppTheme.borderRadiusBig),
      ),
    ),
    builder: (context) {
      return Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(AppTheme.borderRadiusBig),
            topRight: Radius.circular(AppTheme.borderRadiusBig),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: AppTheme.elementSpacing),
            Container(
              height: AppTheme.elementSpacing / 1.375,
              width: AppTheme.cardPadding * 2.25,
              decoration: BoxDecoration(
                color: Theme.of(context).brightness == Brightness.light
                    ? Colors.grey.withOpacity(0.3)
                    : Colors.grey.withOpacity(0.7),
                borderRadius:
                    BorderRadius.circular(AppTheme.borderRadiusCircular),
              ),
            ),
            bitnetAppBar(
              context: context,
              text: "Select Timeframe",
              hasBackButton: false,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppTheme.cardPadding,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...bitcoinController.timespans.map((timespan) {
                    bool isSelected =
                        bitcoinController.pbSelectedtimespan.value == timespan;
                    return BitNetListTile(
                      text: timespan,
                      selected: isSelected,
                      titleStyle: isSelected
                          ? Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context).colorScheme.primary,
                              )
                          : Theme.of(context).textTheme.titleMedium,
                      leading: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: isSelected
                              ? Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .withOpacity(0.1)
                              : Theme.of(context)
                                  .colorScheme
                                  .surfaceContainerHighest
                                  .withOpacity(0.5),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(
                          _getTimeframeIcon(timespan),
                          size: 20,
                          color: isSelected
                              ? Theme.of(context).colorScheme.primary
                              : Theme.of(context)
                                  .colorScheme
                                  .onSurface
                                  .withOpacity(0.6),
                        ),
                      ),
                      onTap: () {
                        // Set the selected timespan
                        bitcoinController.pbSelectedtimespan.value = timespan;

                        // Update chart based on selected timespan
                        switch (timespan) {
                          case "1D":
                            bitcoinController.pbCurrentline.value =
                                bitcoinController.pbOnedaychart;
                            break;
                          case "1W":
                            bitcoinController.pbCurrentline.value =
                                bitcoinController.pbOneweekchart;
                            break;
                          case "1M":
                            bitcoinController.pbCurrentline.value =
                                bitcoinController.pbOnemonthchart;
                            break;
                          case "1J":
                            bitcoinController.pbCurrentline.value =
                                bitcoinController.pbOneyearchart;
                            break;
                          case "Max":
                            bitcoinController.pbCurrentline.value =
                                bitcoinController.pbMaxchart;
                            break;
                        }

                        // Update values for display
                        bitcoinController.pbSetValues();

                        // Update price change percentage
                        double firstPrice =
                            bitcoinController.pbNew_firstpriceexact;
                        double lastPrice =
                            bitcoinController.pbNew_lastpriceexact;
                        double priceChange;
                        if (firstPrice == 0) {
                          priceChange = (lastPrice - firstPrice) / 1;
                        } else {
                          priceChange = (lastPrice - firstPrice) / firstPrice;
                        }
                        bitcoinController.pbOverallPriceChange.value =
                            toPercent(priceChange);

                        // Update wallet amount based on timeframe
                        final chartLine = controller.chartLines.value;
                        if (chartLine != null) {
                          // Adjust the Bitcoin value based on the selected timeframe
                          double adjustedBtcValue =
                              chartLine.price * (firstPrice / lastPrice);

                          // Force update the wallet display by updating a reactive variable
                          controller.timeframeChangeCounter.value += 1;
                        }

                        // Close the bottom sheet
                        Navigator.of(context).pop();
                      },
                      trailing: isSelected
                          ? Container(
                              padding: EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              child: Icon(
                                Icons.check,
                                size: 16,
                                color: Theme.of(context).colorScheme.surface,
                              ),
                            )
                          : null,
                    );
                  }).toList(),
                  SizedBox(height: AppTheme.cardPadding),
                ],
              ),
            ),
          ],
        ),
      );
    },
  );
}

IconData _getTimeframeIcon(String timespan) {
  switch (timespan) {
    case "1D":
      return Icons.today;
    case "1W":
      return Icons.date_range;
    case "1M":
      return Icons.calendar_month;
    case "1J":
      return Icons.calendar_today;
    case "Max":
      return Icons.all_inclusive;
    default:
      return Icons.access_time;
  }
}
