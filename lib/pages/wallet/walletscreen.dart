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
import 'package:bitnet/components/container/imagewithtext.dart';
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
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:bitnet/services/moonpay.dart'
  if (dart.library.html) 'package:bitnet/services/moonpay_web.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class WalletScreen extends GetWidget<WalletsController> {
  WalletScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WalletsController walletController = Get.find<WalletsController>();
    ProfileController profileController = Get.find<ProfileController>();
    String? currency =
        Provider.of<CurrencyChangeProvider>(context).selectedCurrency;
    currency = currency ?? "USD";

    if (!Get.isRegistered<BitcoinController>()) {
      return dotProgress(context);
    }
    BitcoinController bitcoinController = Get.find<BitcoinController>();

    bool _isPriceChangePositive(BitcoinController controller) {
      return controller.pbNew_firstpriceexact <=
          controller.pbNew_lastpricerounded.value;
    }

    return bitnetScaffold(
      context: context,
      body: StatefulBuilder(
        builder: (context, setState) {
          // PageController with a viewportFraction < 1.0 so that
          // the next/previous card partially peeks in
          final pageController = PageController(
            initialPage: controller.selectedCard.value == 'onchain' ? 1 : 0,
            viewportFraction: 0.8885, // see some of the next/prev card
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
                          height: 300,
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
                                _isPriceChangePositive(bitcoinController)
                                    ? AppTheme.successColor.withOpacity(0.15)
                                    : AppTheme.errorColor.withOpacity(0.1),
                                _isPriceChangePositive(bitcoinController)
                                    ? AppTheme.successColor.withOpacity(0.04)
                                    : AppTheme.errorColor.withOpacity(0.03),
                                Colors
                                    .transparent, // Ensure the bottom remains fully transparent
                              ],
                            ),
                          ),
                        )),
                    Container(
                      height: 300,
                      child: Obx(() {
                        bitcoinController.pbChartPing.value;
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
                          series: <ChartSeries>[
                            // SplineSeries with a glowing effect
                            SplineSeries<ChartLine, double>(
                              dataSource: bitcoinController.pbCurrentline.value,
                              animationDuration: 0,
                              xValueMapper: (ChartLine crypto, _) =>
                                  crypto.time,
                              yValueMapper: (ChartLine crypto, _) =>
                                  crypto.price,
                              color: !bitcoinController
                                      .pbOverallPriceChange.value
                                      .contains('-')
                                  ? AppTheme.successColor
                                  : AppTheme
                                      .errorColor, // Softer line color with glow
                              width:
                                  3, // Increased line width for a softer curve
                              // Adding the glow effect underneath
                              splineType: SplineType
                                  .natural, // Smooth line with a curve
                              // Create a glow effect by adding an area beneath the line
                              opacity:
                                  0.1, // Slightly more transparent to create a smoother glow effect
                              // Adding a fill below the curve for a "rounded" look
                            ),
                          ],
                        );
                      }),
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
                                      profileController.isUserLoading ==
                                              true.obs
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
                                                int newIndex = bitcoinController
                                                        .timespans
                                                        .indexOf(bitcoinController
                                                            .pbSelectedtimespan
                                                            .value) +
                                                    1;
                                                if (newIndex ==
                                                    bitcoinController
                                                        .timespans.length) {
                                                  newIndex = 0;
                                                }
                                                bitcoinController
                                                        .pbSelectedtimespan
                                                        .value =
                                                    bitcoinController
                                                        .timespans[newIndex];

                                                switch (bitcoinController
                                                    .pbSelectedtimespan.value) {
                                                  case "1D":
                                                    bitcoinController
                                                            .pbCurrentline
                                                            .value =
                                                        bitcoinController
                                                            .pbOnedaychart;
                                                    break;
                                                  case "1W":
                                                    bitcoinController
                                                            .pbCurrentline
                                                            .value =
                                                        bitcoinController
                                                            .pbOneweekchart;
                                                    break;
                                                  case "1M":
                                                    bitcoinController
                                                            .pbCurrentline
                                                            .value =
                                                        bitcoinController
                                                            .pbOnemonthchart;
                                                    break;
                                                  case "1J":
                                                    bitcoinController
                                                            .pbCurrentline
                                                            .value =
                                                        bitcoinController
                                                            .pbOneyearchart;
                                                    break;
                                                  case "Max":
                                                    bitcoinController
                                                            .pbCurrentline
                                                            .value =
                                                        bitcoinController
                                                            .pbMaxchart;
                                                    break;
                                                }
                                                bitcoinController.pbSetValues();
                                                // Update last price
                                                // Update percent
                                                double firstPrice =
                                                    bitcoinController
                                                        .pbNew_firstpriceexact;
                                                double lastPrice =
                                                    bitcoinController
                                                        .pbNew_lastpriceexact;

                                                double priceChange;
                                                if (firstPrice == 0) {
                                                  priceChange =
                                                      (lastPrice - firstPrice) /
                                                          1;
                                                } else {
                                                  priceChange =
                                                      (lastPrice - firstPrice) /
                                                          firstPrice;
                                                }

                                                bitcoinController
                                                        .pbOverallPriceChange
                                                        .value =
                                                    toPercent(priceChange);
                                                    
                                                // Update wallet amount based on timeframe
                                                // Get current BTC value and adjust it based on the timeframe's price change
                                                // This gives us the "value" of our wallet at different points in time
                                                final chartLine = controller.chartLines.value;
                                                if (chartLine != null) {
                                                  // Adjust the Bitcoin value based on the selected timeframe
                                                  double adjustedBtcValue = chartLine.price * (firstPrice / lastPrice);
                                                  
                                                  // Force update the wallet display by updating a reactive variable
                                                  controller.timeframeChangeCounter.value += 1;
                                                }
                                                // Update date
                                              },
                                              customHeight:
                                                  AppTheme.cardPadding * 1.25,
                                              customWidth:
                                                  AppTheme.cardPadding * 2,
                                              // leadingIcon:
                                              //     Icon(Icons.arrow_drop_down_rounded),
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
                                                    double currentPrice = bitcoinController.pbNew_lastpriceexact;
                                                    double historicalPrice = bitcoinController.pbNew_firstpriceexact;
                                                    double displayValue = currencyEquivalent != null 
                                                        ? double.parse(currencyEquivalent)
                                                        : 0.0;
                                                    
                                                    // If showing in fiat and not in day view, adjust the displayed amount
                                                    if (!controller.coin.value && 
                                                        bitcoinController.pbSelectedtimespan.value != "1D" &&
                                                        historicalPrice > 0) {
                                                        
                                                        // Calculate the ratio between historical and current price
                                                        double ratio = currentPrice / historicalPrice;
                                                        // Apply the ratio to get the current equivalent value
                                                        if (ratio != 1.0) {
                                                            displayValue = displayValue / ratio;
                                                        }
                                                    }

                                                    return Obx(() {
                                                      // Force rebuild on timeframe change
                                                      controller.timeframeChangeCounter.value;
                                                      
                                                      return GestureDetector(
                                                        onTap: () {
                                                          controller
                                                              .setCurrencyType(
                                                            !controller
                                                                .coin.value,
                                                            updateDatabase: false,
                                                          );
                                                          coin.setCurrencyType(
                                                            controller.coin.value,
                                                          );
                                                        },
                                                        child: (controller
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
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    style: Theme.of(
                                                                            context)
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
                                                                    size: AppTheme
                                                                            .iconSize *
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
                                          // Use the Obx directly around the ColoredPriceWidget to react to changes
                                          Obx(
                                            () {
                                              // Force rebuild when timeframe changes
                                              controller.timeframeChangeCounter.value;
                                              
                                              // Calculate the difference between current balance and start of timeframe
                                              double firstPrice =
                                                  bitcoinController
                                                      .pbNew_firstpriceexact;
                                              double currentPrice =
                                                  bitcoinController
                                                      .pbNew_lastpricerounded
                                                      .value;
                                              double diff =
                                                  currentPrice - firstPrice;
                                                  
                                              // Calculate wallet value difference based on timeframe
                                              double priceDiffPercentage = firstPrice != 0 ? 
                                                  (currentPrice - firstPrice) / firstPrice : 0;
                                                  
                                              // Get current wallet value to calculate the absolute change
                                              final chartLine = controller.chartLines.value;
                                              if (chartLine != null && !controller.coin.value) {
                                                // Calculate adjusted value difference (in currency)
                                                double walletValueDiff = 
                                                    (controller.totalBalanceSAT.value / 100000000) * 
                                                    chartLine.price * priceDiffPercentage;
                                                
                                                // Format the difference with proper decimal places and limit length
                                                String formattedDiff;
                                                if (walletValueDiff.abs() > 9999) {
                                                  // For large numbers, use K notation
                                                  formattedDiff = (walletValueDiff / 1000)
                                                          .toStringAsFixed(1) +
                                                      'K';
                                                } else {
                                                  formattedDiff =
                                                      walletValueDiff.toStringAsFixed(2);
                                                }
                                                
                                                return ColoredPriceWidget(
                                                  shouldHideAmount: true,
                                                  price: formattedDiff,
                                                  isPositive: walletValueDiff >= 0,
                                                  currencySymbol:
                                                      getCurrency(currency!),
                                                );
                                              } else {
                                                // Format the price difference (not wallet value)
                                                String formattedDiff;
                                                if (diff.abs() > 9999) {
                                                  // For large numbers, use K notation
                                                  formattedDiff = (diff / 1000)
                                                          .toStringAsFixed(1) +
                                                      'K';
                                                } else {
                                                  formattedDiff =
                                                      diff.toStringAsFixed(2);
                                                }
                                                
                                                return ColoredPriceWidget(
                                                  shouldHideAmount: true,
                                                  price: formattedDiff,
                                                  isPositive: diff >= 0,
                                                  currencySymbol:
                                                      getCurrency(currency!),
                                                );
                                              }
                                            },
                                          ),
                                          SizedBox(
                                              width: AppTheme.elementSpacing *
                                                  1), // Add some spacing
                                          Obx(
                                            () => BitNetPercentWidget(
                                              shouldHideAmount: true,
                                              priceChange: bitcoinController
                                                  .pbOverallPriceChange.value,
                                            ),
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
                                                BitNetImageWithTextButton(
                                                  L10n.of(context)!.send,
                                                  () {
                                                    context.go('/wallet/send');
                                                    WidgetsBinding.instance
                                                        .addPostFrameCallback(
                                                            (_) {
                                                      Get.find<
                                                              SendsController>()
                                                          .getClipboardData();
                                                    });
                                                  },
                                                  // image: "assets/images/send_image.png",
                                                  width: AppTheme.cardPadding *
                                                      2.5.h,
                                                  height: AppTheme.cardPadding *
                                                      2.5.h,
                                                  fallbackIcon: Icons
                                                      .arrow_upward_rounded,
                                                ),
                                                BitNetImageWithTextButton(
                                                  L10n.of(context)!.receive,
                                                  () {
                                                    context.go(
                                                      '/wallet/receive/${controller.selectedCard.value}',
                                                    );
                                                  },
                                                  // image: "assets/images/receive_image.png",
                                                  width: AppTheme.cardPadding *
                                                      2.5.h,
                                                  height: AppTheme.cardPadding *
                                                      2.5.h,
                                                  fallbackIcon: Icons
                                                      .arrow_downward_rounded,
                                                ),
                                                BitNetImageWithTextButton(
                                                  "Swap",
                                                  () {
                                                    Get.put(LoopsController());
                                                    context.go(
                                                        "/wallet/loop_screen");
                                                  },
                                                  // image: "assets/images/rebalance_image.png",
                                                  width: AppTheme.cardPadding *
                                                      2.5.h,
                                                  height: AppTheme.cardPadding *
                                                      2.5.h,
                                                  fallbackIcon:
                                                      Icons.sync_rounded,
                                                ),
                                                BitNetImageWithTextButton(
                                                  "Buy",
                                                  () {
                                                    // Use pushNamed to maintain the navigation stack properly
                                                    context.push("/wallet/buy");
                                                  },
                                                  // image: "assets/images/send_image.png",
                                                  width: AppTheme.cardPadding *
                                                      2.5.h,
                                                  height: AppTheme.cardPadding *
                                                      2.5.h,
                                                  fallbackIcon:
                                                      FontAwesomeIcons.btc,
                                                  fallbackIconSize:
                                                      AppTheme.iconSize * 1.5,
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
                              context.go('/wallet/bitcoinscreen');
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
                            context.go('/wallet/bitcoinscreen');
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
                    padding: EdgeInsets.symmetric(horizontal: AppTheme.cardPadding.w),
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
    String addr = await nextAddr(Auth().currentUser!.uid);
    BitcoinAddress address = BitcoinAddress.fromJson({'addr': addr});
    Get.find<WalletsController>().btcAddresses.add(address.addr);
    LocalStorage.instance.setStringList(
        Get.find<WalletsController>().btcAddresses,
        "btc_addresses:${FirebaseAuth.instance.currentUser!.uid}");
    return address.addr;
  }
}
