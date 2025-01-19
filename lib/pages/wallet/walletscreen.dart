import 'package:bitnet/backbone/auth/auth.dart';
import 'package:bitnet/backbone/auth/storePrivateData.dart';
import 'package:bitnet/backbone/helper/currency/getcurrency.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:bitnet/backbone/streams/currency_provider.dart';
import 'package:bitnet/backbone/streams/currency_type_provider.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/appstandards/optioncontainer.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/buttons/roundedbutton.dart';
import 'package:bitnet/components/chart/chart.dart';
import 'package:bitnet/components/container/avatar.dart';
import 'package:bitnet/components/dialogsandsheets/bottom_sheets/bit_net_bottom_sheet.dart';
import 'package:bitnet/components/indicators/smoothpageindicator.dart';
import 'package:bitnet/components/items/balancecard.dart';
import 'package:bitnet/components/items/cryptoinfoitem.dart';
import 'package:bitnet/components/items/cryptoitem.dart';
import 'package:bitnet/components/resultlist/transactions.dart';
import 'package:bitnet/models/bitcoin/chartline.dart';
import 'package:bitnet/models/bitcoin/lnd/subserverinfo.dart';
import 'package:bitnet/models/currency/bitcoinunitmodel.dart';
import 'package:bitnet/pages/profile/profile_controller.dart';
import 'package:bitnet/pages/settings/bottomsheet/settings.dart';
import 'package:bitnet/pages/wallet/controllers/wallet_controller.dart';
import 'package:bitnet/pages/wallet/loop/loop_controller.dart';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class WalletScreen extends GetWidget<WalletsController> {
  WalletScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WalletsController walletController = Get.find<WalletsController>();
    ProfileController profileController = Get.find<ProfileController>();

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

          return Stack(
            children: [
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [
                      0.0, // Start of the gradient
                      0.3, // 20% mark
                      1.0, // End of the gradient
                    ],
                    colors: [
                      AppTheme.successColor
                          .withOpacity(0.15), // Strong color at the top
                      AppTheme.successColor
                          .withOpacity(0.0), // Fully transparent by 20%
                      Colors
                          .transparent, // Ensure the bottom remains fully transparent
                    ],
                  ),
                ),
              ),
              Container(
                height: 300,
                child: SfCartesianChart(
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
                      dataSource: [
                        ChartLine(time: 1, price: 12),
                        ChartLine(time: 4, price: 20),
                        ChartLine(time: 14, price: 20),
                        ChartLine(time: 19, price: 29),
                        ChartLine(time: 20, price: 31),
                        ChartLine(time: 34, price: 33),
                        ChartLine(time: 35, price: 32),
                        ChartLine(time: 40, price: 25),
                        ChartLine(time: 41, price: 24),
                        ChartLine(time: 42, price: 23),
                      ],
                      animationDuration: 0,
                      xValueMapper: (ChartLine crypto, _) => crypto.time,
                      yValueMapper: (ChartLine crypto, _) => crypto.price,
                      color:
                          AppTheme.successColor, // Softer line color with glow
                      width: 4, // Increased line width for a softer curve
                      // Adding the glow effect underneath
                      splineType:
                          SplineType.cardinal, // Smooth line with a curve
                      // Create a glow effect by adding an area beneath the line
                      opacity:
                          0.1, // Slightly more transparent to create a smoother glow effect
                      // Adding a fill below the curve for a "rounded" look
                    ),
                  ],
                ),
              ),
              CustomScrollView(
                controller: controller.scrollController,
                slivers: [
                  SliverToBoxAdapter(
                    child: Obx(
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
                                  profileController.isUserLoading == true.obs
                                      ? Avatar(
                                          onTap: () async {
                                            // context.go('/profile/$profileId');
                                          },
                                          isNft: false,
                                        )
                                      : Avatar(
                                          onTap: () async {
                                            final profileId =
                                                Auth().currentUser?.uid;
                                            // context.go('/profile/$profileId');
                                          },
                                          size: AppTheme.cardPadding * 1.5,
                                          mxContent: Uri.parse(
                                            profileController
                                                .userData.value.profileImageUrl,
                                          ),
                                          type: profilePictureType.lightning,
                                          isNft: profileController.userData
                                              .value.nft_profile_id.isNotEmpty,
                                        ),
                                  Row(
                                    children: [
                                      LongButtonWidget(
                                        title: "1D",
                                        buttonType: ButtonType.transparent,
                                        onTap: () {},
                                        customHeight:
                                            AppTheme.cardPadding * 1.25,
                                        customWidth: AppTheme.cardPadding * 2,
                                        // leadingIcon:
                                        //     Icon(Icons.arrow_drop_down_rounded),
                                      ),
                                      SizedBox(
                                        width: AppTheme.elementSpacing * 0.75.w,
                                      ),
                                      Obx(
                                        () => RoundedButtonWidget(
                                          size: AppTheme.cardPadding * 1.25,
                                          buttonType: ButtonType.transparent,
                                          iconData:
                                              controller.hideBalance.value ==
                                                      false
                                                  ? FontAwesomeIcons.eyeSlash
                                                  : FontAwesomeIcons.eye,
                                          onTap: () {
                                            controller.setHideBalance(
                                              hide:
                                                  !controller.hideBalance.value,
                                            );
                                          },
                                        ),
                                      ),
                                      SizedBox(
                                        width: AppTheme.elementSpacing * 0.75.w,
                                      ),
                                      RoundedButtonWidget(
                                        size: AppTheme.cardPadding * 1.25,
                                        buttonType: ButtonType.transparent,
                                        iconData: Icons.settings,
                                        onTap: () {
                                          BitNetBottomSheet(
                                            width: double.infinity,
                                            context: context,
                                            borderRadius:
                                                AppTheme.borderRadiusBig,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Theme.of(context)
                                                    .canvasColor,
                                                borderRadius: BorderRadius.only(
                                                  topLeft:
                                                      AppTheme.cornerRadiusBig,
                                                  topRight:
                                                      AppTheme.cornerRadiusBig,
                                                ),
                                              ),
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.only(
                                                  topLeft:
                                                      AppTheme.cornerRadiusBig,
                                                  topRight:
                                                      AppTheme.cornerRadiusBig,
                                                ),
                                                child: Settings(),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
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
                                crossAxisAlignment: CrossAxisAlignment.center,
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
                                                final chartLine =
                                                    controller.chartLines.value;
                                                final bitcoinPrice =
                                                    chartLine?.price;
                                                final currencyEquivalent =
                                                    bitcoinPrice != null
                                                        ? (controller
                                                                    .totalBalanceSAT
                                                                    .value /
                                                                100000000 *
                                                                bitcoinPrice)
                                                            .toStringAsFixed(2)
                                                        : "0.00";

                                                final coin = Provider.of<
                                                        CurrencyTypeProvider>(
                                                    context,
                                                    listen: true);
                                                final currency = Provider.of<
                                                        CurrencyChangeProvider>(
                                                    context,
                                                    listen: true);
                                                controller.coin.value =
                                                    coin.coin ??
                                                        controller.coin.value;
                                                controller.selectedCurrency
                                                        ?.value =
                                                    currency.selectedCurrency ??
                                                        controller
                                                            .selectedCurrency!
                                                            .value;

                                                return GestureDetector(
                                                  onTap: () {
                                                    controller.setCurrencyType(
                                                      !controller.coin.value,
                                                      updateDatabase: false,
                                                    );
                                                    coin.setCurrencyType(
                                                      controller.coin.value,
                                                    );
                                                  },
                                                  child: (controller.coin.value)
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
                                                            ),
                                                          ],
                                                        )
                                                      : Text(
                                                          "$currencyEquivalent${getCurrency(controller.selectedCurrency == null ? '' : controller.selectedCurrency!.value)}",
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .displayLarge,
                                                        ),
                                                );
                                              }),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.arrow_drop_up_rounded,
                                            color: AppTheme.successColor,
                                            size: AppTheme.iconSize * 1,
                                          ),
                                          Text(
                                            "1,848.13\$",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge!
                                                .copyWith(
                                                  color: AppTheme.successColor,
                                                ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                          width: AppTheme.elementSpacing *
                                              0.5), // Add some spacing
                                      Transform.scale(
                                          child: BitNetPercentWidget(
                                              priceChange: "+0.83%"),
                                          scale: 0.85),
                                    ],
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
                          // (All your other sections, etc.)
                        ],
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppTheme.cardPadding,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: AppTheme.cardPadding.h * 1.5),
                          // Text(
                          //   L10n.of(context)!.actions,
                          //   style: Theme.of(context).textTheme.titleLarge,
                          // ),
                          // SizedBox(height: AppTheme.cardPadding.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              BitNetImageWithTextButton(
                                L10n.of(context)!.send,
                                () {
                                  context.go('/wallet/send');
                                },
                                // image: "assets/images/send_image.png",
                                width: AppTheme.cardPadding * 2.5.w,
                                height: AppTheme.cardPadding * 2.5.w,
                                fallbackIcon: Icons.arrow_upward_rounded,
                              ),
                              BitNetImageWithTextButton(
                                L10n.of(context)!.receive,
                                () {
                                  context.go(
                                    '/wallet/receive/${controller.selectedCard.value}',
                                  );
                                },
                                // image: "assets/images/receive_image.png",
                                width: AppTheme.cardPadding * 2.5.w,
                                height: AppTheme.cardPadding * 2.5.w,
                                fallbackIcon: Icons.arrow_downward_rounded,
                              ),
                              BitNetImageWithTextButton(
                                "Swap",
                                () {
                                  Get.put(LoopsController());
                                  context.go("/wallet/loop_screen");
                                },
                                // image: "assets/images/rebalance_image.png",
                                width: AppTheme.cardPadding * 2.5.w,
                                height: AppTheme.cardPadding * 2.5.w,
                                fallbackIcon: Icons.sync_rounded,
                              ),
                              BitNetImageWithTextButton(
                                "Buy",
                                () {
                                  Get.put(LoopsController());
                                  context.go("/wallet/loop_screen");
                                },
                                // image: "assets/images/send_image.png",
                                width: AppTheme.cardPadding * 2.5.w,
                                height: AppTheme.cardPadding * 2.5.w,
                                fallbackIcon: FontAwesomeIcons.bitcoin,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
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
                                  icon:
                                      Image.asset("assets/images/bitcoin.png"),
                                ),
                                context: context,
                                onTap: () {
                                  context.go('/wallet/bitcoincard');
                                },
                              );
                            },
                          ),
                          SizedBox(height: AppTheme.elementSpacing.h),
                          Obx(() {
                            final confirmedBalanceStr = walletController
                                .lightningBalance.value.balance.obs;

                            return CryptoInfoItem(
                              balance: confirmedBalanceStr.value,
                              // confirmedBalance: confirmedBalanceStr.value,
                              defaultUnit: BitcoinUnits.SAT,
                              currency: Currency(
                                code: 'BTC',
                                name: 'Bitcoin (Lightning)',
                                icon:
                                    Image.asset("assets/images/lightning.png"),
                              ),
                              context: context,
                              onTap: () {
                                context.go('/wallet/lightningcard');
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
              ),
            ],
          );
        },
      ),
    );
  }
}
