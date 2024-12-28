import 'package:bitnet/backbone/auth/auth.dart';
import 'package:bitnet/backbone/helper/currency/getcurrency.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:bitnet/backbone/streams/currency_provider.dart';
import 'package:bitnet/backbone/streams/currency_type_provider.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/appstandards/optioncontainer.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/buttons/roundedbutton.dart';
import 'package:bitnet/components/container/avatar.dart';
import 'package:bitnet/components/dialogsandsheets/bottom_sheets/bit_net_bottom_sheet.dart';
import 'package:bitnet/components/dialogsandsheets/notificationoverlays/overlay.dart';
import 'package:bitnet/components/indicators/smoothpageindicator.dart';  // <--- NEW import
import 'package:bitnet/components/items/balancecard.dart';
import 'package:bitnet/components/items/cryptoitem.dart';
import 'package:bitnet/components/resultlist/transactions.dart';
import 'package:bitnet/models/bitcoin/lnd/subserverinfo.dart';
import 'package:bitnet/models/currency/bitcoinunitmodel.dart';
import 'package:bitnet/pages/profile/profile_controller.dart';
import 'package:bitnet/pages/settings/bottomsheet/settings.dart';
import 'package:bitnet/pages/wallet/controllers/wallet_controller.dart';
import 'package:bitnet/pages/wallet/loop/loop_controller.dart';

import 'package:flutter/material.dart';
// Removed: import 'package:flutter_card_swiper/flutter_card_swiper.dart';
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
            viewportFraction: 0.875, // see some of the next/prev card
          );

          SubServersStatus? subServersStatus; // local variable to store fetched data

          return CustomScrollView(
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
                        const SizedBox(height: AppTheme.cardPadding * 1.5),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppTheme.cardPadding * 1,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  profileController.isUserLoading == true.obs
                                      ? Avatar(
                                    onTap: () {
                                      // context.go('/profile/$profileId');
                                    },
                                    isNft: false,
                                  )
                                      : Avatar(
                                    onTap: () {
                                      final profileId =
                                          Auth().currentUser?.uid;
                                      // context.go('/profile/$profileId');
                                    },
                                    size: AppTheme.cardPadding * 2.5.h,
                                    mxContent: Uri.parse(
                                      profileController.userData.value
                                          .profileImageUrl,
                                    ),
                                    type: profilePictureType.lightning,
                                    isNft: profileController.userData.value
                                        .nft_profile_id.isNotEmpty,
                                  ),
                                  SizedBox(
                                    width: AppTheme.elementSpacing * 1.25.w,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        L10n.of(context)!.totalWalletBal,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                      ),
                                      const SizedBox(
                                          height:
                                          AppTheme.elementSpacing * 0.25),
                                      Obx(
                                            () => Row(
                                          children: [
                                            controller.hideBalance.value
                                                ? Text(
                                              '******',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .displaySmall,
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
                                              final currency = Provider.of<
                                                  CurrencyChangeProvider>(
                                                  context,
                                                  listen: true);
                                              controller.coin.value =
                                                  coin.coin ??
                                                      controller
                                                          .coin.value;
                                              controller.selectedCurrency
                                                  ?.value =
                                                  currency
                                                      .selectedCurrency ??
                                                      controller
                                                          .selectedCurrency!
                                                          .value;

                                              return GestureDetector(
                                                onTap: () {
                                                  controller
                                                      .setCurrencyType(
                                                    !controller
                                                        .coin.value,
                                                    updateDatabase: false,
                                                  );
                                                  coin.setCurrencyType(
                                                    controller
                                                        .coin.value,
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
                                                          .displaySmall,
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
                                                  style: Theme.of(
                                                      context)
                                                      .textTheme
                                                      .displaySmall,
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
                              Row(
                                children: [
                                  Obx(
                                        () => RoundedButtonWidget(
                                      size: AppTheme.cardPadding * 1.25,
                                      buttonType: ButtonType.transparent,
                                      iconData:
                                      controller.hideBalance.value == false
                                          ? FontAwesomeIcons.eyeSlash
                                          : FontAwesomeIcons.eye,
                                      onTap: () {
                                        controller.setHideBalance(
                                          hide: !controller.hideBalance.value,
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
                                        borderRadius: AppTheme.borderRadiusBig,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Theme.of(context)
                                                .canvasColor,
                                            borderRadius:
                                             BorderRadius.only(
                                              topLeft: AppTheme.cornerRadiusBig,
                                              topRight: AppTheme.cornerRadiusBig,
                                            ),
                                          ),
                                          child: ClipRRect(
                                            borderRadius:
                                             BorderRadius.only(
                                              topLeft: AppTheme.cornerRadiusBig,
                                              topRight: AppTheme.cornerRadiusBig,
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
                        SizedBox(
                          height: AppTheme.cardPadding.h * 1.5,
                        ),
                        // -------------------------------------------
                        // PageView with partial peeking & spacing
                        Container(
                          height: AppTheme.cardPadding * 7.75.h,
                          clipBehavior: Clip.none,
                          child: Column(
                            children: [
                              Expanded(
                                child: PageView.builder(
                                  controller: pageController,
                                  onPageChanged: (index) {
                                    if (index == 1) {
                                      controller.setSelectedCard('onchain');
                                    } else {
                                      controller.setSelectedCard('lightning');
                                    }
                                  },
                                  itemCount: 2, // only 2 cards
                                  itemBuilder: (context, index) {
                                    // Add margin so there's a gap between cards
                                    return Container(
                                      margin: const EdgeInsets.symmetric(
                                        horizontal: AppTheme.elementSpacing / 2,
                                      ),
                                      child: (index == 0)
                                          ? GestureDetector(
                                        onTap: () {
                                          context.go(
                                              '/wallet/lightningcard');
                                        },
                                        child: Obx(() {
                                          final confirmedBalanceStr =
                                              walletController
                                                  .lightningBalance
                                                  .value
                                                  .balance
                                                  .obs;

                                          return BalanceCardLightning(
                                            balance:
                                            confirmedBalanceStr.value,
                                            confirmedBalance:
                                            confirmedBalanceStr.value,
                                            defaultUnit:
                                            BitcoinUnits.SAT,
                                          );
                                        }),
                                      )
                                          : GestureDetector(
                                        onTap: () {
                                          context
                                              .go('/wallet/bitcoincard');
                                        },
                                        child: Obx(() {
                                          final logger =
                                          Get.find<LoggerService>();
                                          final confirmedBalanceStr =
                                              walletController
                                                  .onchainBalance
                                                  .value
                                                  .confirmedBalance
                                                  .obs;
                                          final unconfirmedBalanceStr =
                                              walletController
                                                  .onchainBalance
                                                  .value
                                                  .unconfirmedBalance
                                                  .obs;

                                          logger.i(
                                            "Confirmed Balance onchain: $confirmedBalanceStr",
                                          );
                                          logger.i(
                                            "Unconfirmed Balance onchain: $unconfirmedBalanceStr",
                                          );

                                          return BalanceCardBtc(
                                            balance:
                                            confirmedBalanceStr.value,
                                            confirmedBalance:
                                            confirmedBalanceStr.value,
                                            unconfirmedBalance:
                                            unconfirmedBalanceStr
                                                .value,
                                            defaultUnit:
                                            BitcoinUnits.SAT,
                                          );
                                        }),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              SizedBox(height: AppTheme.cardPadding * 0.75),
                              Center(
                                child: CustomIndicator(
                                  pageController: pageController,
                                  count: 2,
                                ),
                              ),
                            ],
                          ),
                        ),
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
                      Text(
                        L10n.of(context)!.actions,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      SizedBox(height: AppTheme.cardPadding.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          BitNetImageWithTextButton(
                            L10n.of(context)!.send,
                                () {
                              context.go('/wallet/send');
                            },
                            image: "assets/images/send_image.png",
                            width: AppTheme.cardPadding * 3.5.w,
                            height: AppTheme.cardPadding * 3.5.w,
                            fallbackIcon: Icons.arrow_upward_rounded,
                          ),
                          BitNetImageWithTextButton(
                            L10n.of(context)!.receive,
                                () {
                              context.go(
                                '/wallet/receive/${controller.selectedCard.value}',
                              );
                            },
                            image: "assets/images/receive_image.png",
                            width: AppTheme.cardPadding * 3.5.w,
                            height: AppTheme.cardPadding * 3.5.w,
                            fallbackIcon: Icons.arrow_downward_rounded,
                          ),
                          BitNetImageWithTextButton(
                            "Swap",
                                () {
                              Get.put(LoopsController());
                              context.go("/wallet/loop_screen");
                            },
                            image: "assets/images/rebalance_image.png",
                            width: AppTheme.cardPadding * 3.5.w,
                            height: AppTheme.cardPadding * 3.5.w,
                            fallbackIcon: Icons.sync_rounded,
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
                        L10n.of(context)!.buySell,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      SizedBox(height: AppTheme.cardPadding.h),
                      CryptoItem(
                        currency: Currency(
                          code: 'BTC',
                          name: 'Bitcoin',
                          icon: Image.asset("assets/images/bitcoin.png"),
                        ),
                        context: context,
                      ),
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
