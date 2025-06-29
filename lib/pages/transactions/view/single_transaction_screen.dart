import 'dart:async';

import 'package:bitnet/backbone/helper/currency/currency_converter.dart';
import 'package:bitnet/backbone/helper/currency/getcurrency.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/services/timezone_provider.dart';
import 'package:bitnet/backbone/streams/currency_provider.dart';
import 'package:bitnet/backbone/streams/currency_type_provider.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetListTile.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/appstandards/glasscontainer.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/container/avatar.dart';
import 'package:bitnet/components/dialogsandsheets/bottom_sheets/bit_net_bottom_sheet.dart';
import 'package:bitnet/components/dialogsandsheets/notificationoverlays/overlay.dart';
import 'package:bitnet/components/fields/searchfield/searchfield.dart';
import 'package:bitnet/components/items/transactionitem.dart';
import 'package:bitnet/components/loaders/loaders.dart';
import 'package:bitnet/models/currency/bitcoinunitmodel.dart';
import 'package:bitnet/pages/secondpages/mempool/controller/home_controller.dart';
import 'package:bitnet/pages/transactions/controller/transaction_controller.dart';
import 'package:bitnet/pages/transactions/view/address_component.dart';
import 'package:bitnet/pages/wallet/controllers/wallet_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:bitnet/intl/generated/l10n.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:timezone/timezone.dart';

// BlinkingDot for transaction status indication
class BlinkingDot extends StatefulWidget {
  final Color color;
  final double size;

  const BlinkingDot({
    Key? key,
    required this.color,
    this.size = 10.0,
  }) : super(key: key);

  @override
  _BlinkingDotState createState() => _BlinkingDotState();
}

class _BlinkingDotState extends State<BlinkingDot>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat(reverse: true);

    _opacityAnimation =
        Tween<double>(begin: 0.3, end: 1.0).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacityAnimation,
      child: Container(
        width: widget.size,
        height: widget.size,
        decoration: BoxDecoration(
          color: widget.color,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}

class SingleTransactionScreen extends StatefulWidget {
  const SingleTransactionScreen({Key? key}) : super(key: key);

  @override
  State<SingleTransactionScreen> createState() =>
      _SingleTransactionScreenState();
}

class _SingleTransactionScreenState extends State<SingleTransactionScreen> {
  final TextEditingController inputCtrl = TextEditingController();
  final TextEditingController outputCtrl = TextEditingController();
  late final StreamSubscription sub;
  @override
  void initState() {
    super.initState();
    final controller = Get.put(TransactionController());
    sub = controller.isLoading.listen((b) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    sub.cancel();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TransactionController());
    Location loc =
        Provider.of<TimezoneProvider>(context, listen: false).timeZone;
    if (!Get.isRegistered<WalletsController>()) {
      Get.put(WalletsController());
    }
    final controllerWallet = Get.find<WalletsController>();
    final controllerHome = Get.put(HomeController());

    String? currency =
        Provider.of<CurrencyChangeProvider>(context).selectedCurrency;
    final coin = Provider.of<CurrencyTypeProvider>(context, listen: true);
    currency = currency ?? "USD";
    int amount = 0;
    String amountPredefined = controller.amount;
    num outputTotal = 0;

    if (controller.transactionModel != null) {
      // Initialize variables for amounts and addresses
      num totalReceived = 0;
      num totalSent = 0;

      for (var vin in controller.transactionModel!.vin!) {
        if (vin.prevout != null && vin.prevout!.value != null) {
          // Check if the input is from our address
          if (controller.currentOwnedAddresses
              .contains(vin.prevout?.scriptpubkeyAddress)) {
            totalSent += vin.prevout!.value!;
          }
        }
      }

      for (var vout in controller.transactionModel!.vout!) {
        if (vout.value != null) {
          // Check if the output is to our address
          if (controller.currentOwnedAddresses
              .contains(vout.scriptpubkeyAddress)) {
            totalReceived += vout.value!;
          }
          outputTotal += vout.value!;
        }
      }

// Determine the net amount and direction

      amount = (totalReceived - totalSent).toInt();
    }
    final chartLine = controllerWallet.chartLines.value;
    final bitcoinPrice = chartLine?.price;

    String currencyAmount = CurrencyConverter.convertCurrency(
        'SAT', amount.toDouble(), currency, bitcoinPrice ?? 0);
    String currSymbol = getCurrency(currency);

    final overlayController = Get.find<OverlayController>();

    return bitnetScaffold(
      context: context,
      extendBodyBehindAppBar: true,
      appBar: bitnetAppBar(
        text: "OnChain Transaction",
        context: context,
        onTap: () {
          controller.homeController
              .sendWebSocketMessage('{"track-rbf-summary":true}');
          controller.homeController.sendWebSocketMessage('{"track-tx":"stop"}');
          controller.homeController.sendWebSocketMessage(
              '{"action":"want","data":["blocks","mempool-blocks"]}');
          Navigator.pop(context);
          controller.homeController.isRbfTransaction.value = false;
        },
      ),
      body: PopScope(
        canPop: true,
        onPopInvoked: (bool didPop) {
          controller.homeController
              .sendWebSocketMessage('{"track-rbf-summary":true}');
          controller.homeController.sendWebSocketMessage('{"track-tx":"stop"}');
          controller.homeController.sendWebSocketMessage(
              '{"action":"want","data":["blocks","mempool-blocks"]}');
          controller.homeController.isRbfTransaction.value = false;
        },
        child: Obx(() {
          return controller.isLoading.isTrue
              ? Center(
                  child: dotProgress(context),
                )
              : controller.transactionModel == null
                  ? const Center(child: Text('Something went wrong'))
                  : SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: AppTheme.cardPadding * 3),
                        child: Container(
                          child: Column(
                            children: [
                              controller.homeController.isRbfTransaction.value
                                  ? Container(
                                      decoration: BoxDecoration(
                                        color: Colors.purple.shade400,
                                        borderRadius:
                                            AppTheme.cardRadiusCircular,
                                      ),
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              L10n.of(context)!
                                                  .transactionReplaced,
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () async {
                                                await Clipboard.setData(
                                                    ClipboardData(
                                                  text: controllerHome
                                                      .replacedTx.value,
                                                ));
                                                overlayController.showOverlay(
                                                    L10n.of(context)!
                                                        .copiedToClipboard);
                                              },
                                              child: Row(
                                                children: [
                                                  SizedBox(
                                                    width: 300,
                                                    child: Text(
                                                      controllerHome
                                                          .replacedTx.value,
                                                      style: const TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          // decoration:
                                                          //     TextDecoration.underline,
                                                          decorationColor:
                                                              Colors.white,
                                                          decorationThickness:
                                                              2),
                                                    ),
                                                  ),
                                                  const Icon(
                                                    Icons.copy,
                                                    color: Colors.white,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ]),
                                    )
                                  : const SizedBox(),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: AppTheme.elementSpacing,
                                ),
                                child: GlassContainer(
                                  borderRadius: AppTheme.cardRadiusBig,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: AppTheme.elementSpacing,
                                      horizontal: AppTheme.elementSpacing,
                                    ),
                                    child: Column(
                                      children: [
                                        // Transaction header with sender and receiver
                                        Container(
                                          margin: const EdgeInsets.symmetric(
                                            vertical:
                                                AppTheme.cardPadding * 0.75,
                                          ),
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Column(
                                                    children: [
                                                      Avatar(
                                                        size: AppTheme
                                                                .cardPadding *
                                                            4,
                                                        onTap: () {
                                                          LeftAvatarBitNetBottomSheet(
                                                              controller);
                                                        },
                                                        isNft: false,
                                                      ),
                                                      const SizedBox(
                                                        height: AppTheme
                                                                .elementSpacing *
                                                            0.5,
                                                      ),
                                                      Text(
                                                          "Sender (${controller.transactionModel?.vin?.where((test) => test.prevout != null).length})"),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    width:
                                                        AppTheme.cardPadding *
                                                            0.75,
                                                  ),
                                                  Icon(
                                                    Icons.double_arrow_rounded,
                                                    size: AppTheme.cardPadding *
                                                        2.5,
                                                    color: Theme.of(context)
                                                                .brightness ==
                                                            Brightness.dark
                                                        ? AppTheme.white80
                                                        : AppTheme.black60,
                                                  ),
                                                  const SizedBox(
                                                    width:
                                                        AppTheme.cardPadding *
                                                            0.75,
                                                  ),
                                                  Column(
                                                    children: [
                                                      Avatar(
                                                        size: AppTheme
                                                                .cardPadding *
                                                            4,
                                                        isNft: false,
                                                        onTap: () {
                                                          RightAvatarBitnetBottomSheet(
                                                              controller);
                                                        },
                                                      ),
                                                      const SizedBox(
                                                        height: AppTheme
                                                                .elementSpacing *
                                                            0.5,
                                                      ),
                                                      Text(
                                                          "Receiver (${controller.transactionModel?.vout?.length})"),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                  height: AppTheme.cardPadding *
                                                      0.75),
                                              // Amount display
                                              if (controller
                                                  .currentOwnedAddresses
                                                  .isNotEmpty) ...[
                                                controllerWallet
                                                        .hideBalance.value
                                                    ? Text(
                                                        '*****',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .titleMedium,
                                                      )
                                                    : Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          GestureDetector(
                                                            onTap: () {
                                                              coin.setCurrencyType(
                                                                  coin.coin !=
                                                                          null
                                                                      ? !coin
                                                                          .coin!
                                                                      : false);
                                                            },
                                                            child: Text(
                                                              coin.coin ?? true
                                                                  ? '${controller.transactionModel == null ? '' : amount > 0 ? '+${controller.formatPrice(amount.toString())}' : controller.formatPrice(amount.toString())}'
                                                                  : amount > 0
                                                                      ? "+${currencyAmount} ${currSymbol}"
                                                                      : "${currencyAmount} ${currSymbol}",
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .displayMedium!
                                                                  .copyWith(
                                                                      color: amount >
                                                                              0
                                                                          ? AppTheme
                                                                              .successColor
                                                                          : amount < 0
                                                                              ? AppTheme.errorColor
                                                                              : null),
                                                            ),
                                                          ),
                                                          coin.coin ?? true
                                                              ? Icon(
                                                                  AppTheme
                                                                      .satoshiIcon,
                                                                  color: amount >
                                                                          0
                                                                      ? AppTheme
                                                                          .successColor
                                                                      : amount <
                                                                              0
                                                                          ? AppTheme
                                                                              .errorColor
                                                                          : null)
                                                              : const SizedBox
                                                                  .shrink(),
                                                        ],
                                                      ),
                                              ],
                                            ],
                                          ),
                                        ),

                                        // Nested details container with all information
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal:
                                                  AppTheme.elementSpacing * 0.5,
                                              vertical:
                                                  AppTheme.elementSpacing),
                                          child: GlassContainer(
                                            opacity: 0.05,
                                            borderRadius:
                                                AppTheme.cardRadiusSmall,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                vertical:
                                                    AppTheme.elementSpacing,
                                              ),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  // Transaction Volume
                                                  BitNetListTile(
                                                    contentPadding:
                                                        const EdgeInsets
                                                            .symmetric(
                                                      horizontal: AppTheme
                                                              .elementSpacing *
                                                          0.75,
                                                      vertical: AppTheme
                                                              .elementSpacing *
                                                          0.5,
                                                    ),
                                                    text: 'Transaction Volume',
                                                    trailing: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        GestureDetector(
                                                          onTap: () {
                                                            coin.setCurrencyType(
                                                                coin.coin !=
                                                                        null
                                                                    ? !coin
                                                                        .coin!
                                                                    : false);
                                                          },
                                                          child: Text(
                                                            coin.coin ?? true
                                                                ? '$outputTotal'
                                                                : '${CurrencyConverter.convertCurrency(BitcoinUnits.SAT.name, outputTotal.toDouble(), currency!, bitcoinPrice)} ${getCurrency(currency)}',
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .titleMedium,
                                                          ),
                                                        ),
                                                        coin.coin ?? true
                                                            ? Icon(AppTheme
                                                                .satoshiIcon)
                                                            : const SizedBox
                                                                .shrink(),
                                                      ],
                                                    ),
                                                  ),

                                                  // Transaction ID
                                                  BitNetListTile(
                                                    contentPadding:
                                                        const EdgeInsets
                                                            .symmetric(
                                                      horizontal: AppTheme
                                                              .elementSpacing *
                                                          0.75,
                                                      vertical: AppTheme
                                                              .elementSpacing *
                                                          0.5,
                                                    ),
                                                    text: 'TransactionID',
                                                    trailing: GestureDetector(
                                                      onTap: () async {
                                                        await Clipboard.setData(
                                                            ClipboardData(
                                                          text:
                                                              controller.txID!,
                                                        ));
                                                        overlayController
                                                            .showOverlay(L10n.of(
                                                                    context)!
                                                                .copiedToClipboard);
                                                      },
                                                      child: Row(
                                                        children: [
                                                          Icon(
                                                            Icons.copy,
                                                            color: AppTheme
                                                                .white60,
                                                            size: AppTheme
                                                                    .cardPadding *
                                                                0.75,
                                                          ),
                                                          const SizedBox(
                                                              width: AppTheme
                                                                      .elementSpacing /
                                                                  2),
                                                          Container(
                                                            width: AppTheme
                                                                    .cardPadding *
                                                                5.w,
                                                            child: Text(
                                                              controller.txID!,
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodyMedium,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),

                                                  // Block information
                                                  BitNetListTile(
                                                    contentPadding:
                                                        const EdgeInsets
                                                            .symmetric(
                                                      horizontal: AppTheme
                                                              .elementSpacing *
                                                          0.75,
                                                      vertical: AppTheme
                                                              .elementSpacing *
                                                          0.5,
                                                    ),
                                                    onTap: () {
                                                      if (controller
                                                              .transactionModel!
                                                              .status!
                                                              .blockHeight !=
                                                          null)
                                                        controllerHome
                                                                .blockHeight =
                                                            controller
                                                                .transactionModel!
                                                                .status!
                                                                .blockHeight!;
                                                      context.push(
                                                          '/wallet/bitcoinscreen/mempool');
                                                    },
                                                    text:
                                                        L10n.of(context)!.block,
                                                    trailing: Row(
                                                      children: [
                                                        Text(
                                                          "${controller.transactionModel!.status!.blockHeight ?? "--"}",
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .titleMedium!
                                                              .copyWith(
                                                                  color: Theme.of(
                                                                          context)
                                                                      .colorScheme
                                                                      .primary),
                                                        ),
                                                        const SizedBox(
                                                            width: AppTheme
                                                                    .elementSpacing /
                                                                2),
                                                        Icon(
                                                          Icons
                                                              .arrow_forward_ios,
                                                          size: AppTheme
                                                                  .cardPadding *
                                                              0.75,
                                                          color:
                                                              Theme.of(context)
                                                                  .colorScheme
                                                                  .primary,
                                                        ),
                                                      ],
                                                    ),
                                                  ),

                                                  // Status
                                                  BitNetListTile(
                                                    contentPadding:
                                                        const EdgeInsets
                                                            .symmetric(
                                                      horizontal: AppTheme
                                                              .elementSpacing *
                                                          0.75,
                                                      vertical: AppTheme
                                                              .elementSpacing *
                                                          0.5,
                                                    ),
                                                    text: L10n.of(context)!
                                                        .status,
                                                    trailing: Row(
                                                      children: [
                                                        // Added Blinking Dot animation
                                                        BlinkingDot(
                                                          color: controller
                                                                      .transactionModel ==
                                                                  null
                                                              ? AppTheme
                                                                  .errorColor
                                                              : controller
                                                                      .transactionModel!
                                                                      .status!
                                                                      .confirmed!
                                                                  ? AppTheme
                                                                      .successColor
                                                                  : controllerHome
                                                                              .isRbfTransaction
                                                                              .value ==
                                                                          true
                                                                      ? AppTheme
                                                                          .colorBitcoin
                                                                      : AppTheme
                                                                          .errorColor,
                                                        ),
                                                        const SizedBox(
                                                            width: 8),
                                                        Text(
                                                          controllerHome
                                                                      .isRbfTransaction
                                                                      .value ==
                                                                  true
                                                              ? L10n.of(
                                                                      context)!
                                                                  .replaced
                                                              : '${controller.confirmations == 0 ? '' : controller.confirmations} ' +
                                                                  controller
                                                                      .statusTransaction
                                                                      .value,
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .titleMedium!
                                                                  .copyWith(
                                                                    color: controller.transactionModel ==
                                                                            null
                                                                        ? AppTheme
                                                                            .errorColor
                                                                        : controller.transactionModel!.status!.confirmed!
                                                                            ? AppTheme.successColor
                                                                            : controllerHome.isRbfTransaction.value == true
                                                                                ? AppTheme.colorBitcoin
                                                                                : AppTheme.errorColor,
                                                                  ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),

                                                  // Payment Network
                                                  BitNetListTile(
                                                    contentPadding:
                                                        const EdgeInsets
                                                            .symmetric(
                                                      horizontal: AppTheme
                                                              .elementSpacing *
                                                          0.75,
                                                      vertical: AppTheme
                                                              .elementSpacing *
                                                          0.5,
                                                    ),
                                                    text: L10n.of(context)!
                                                        .paymentNetwork,
                                                    trailing: Row(
                                                      children: [
                                                        Image.asset(
                                                            "assets/images/bitcoin.png",
                                                            width: AppTheme
                                                                    .cardPadding *
                                                                1,
                                                            height: AppTheme
                                                                    .cardPadding *
                                                                1),
                                                        const SizedBox(
                                                            width: AppTheme
                                                                    .elementSpacing /
                                                                2),
                                                        Text(
                                                          'Onchain',
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .titleMedium,
                                                        ),
                                                      ],
                                                    ),
                                                  ),

                                                  // Time with clock icon
                                                  BitNetListTile(
                                                    contentPadding:
                                                        const EdgeInsets
                                                            .symmetric(
                                                      horizontal: AppTheme
                                                              .elementSpacing *
                                                          0.75,
                                                      vertical: AppTheme
                                                              .elementSpacing *
                                                          0.5,
                                                    ),
                                                    text:
                                                        L10n.of(context)!.time,
                                                    leading: Icon(
                                                      Icons.access_time,
                                                      size:
                                                          AppTheme.cardPadding *
                                                              0.75,
                                                      color: Theme.of(context)
                                                                  .brightness ==
                                                              Brightness.dark
                                                          ? AppTheme.white60
                                                          : AppTheme.black60,
                                                    ),
                                                    trailing: controller
                                                            .transactionModel!
                                                            .status!
                                                            .confirmed!
                                                        ? Container(
                                                            width: AppTheme
                                                                    .cardPadding *
                                                                7.w,
                                                            child: Text(
                                                              '${DateFormat('yyyy-MM-dd HH:mm').format(DateTime.fromMillisecondsSinceEpoch(controller.transactionModel!.status!.blockTime! * 1000).toUtc().add(Duration(milliseconds: loc.currentTimeZone.offset)))}'
                                                              ' (${controller.formatTimeAgo(DateTime.fromMillisecondsSinceEpoch(controller.transactionModel!.status!.blockTime! * 1000).toUtc().add(Duration(milliseconds: loc.currentTimeZone.offset)))})',
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              maxLines: 2,
                                                              textAlign:
                                                                  TextAlign.end,
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodyMedium,
                                                            ),
                                                          )
                                                        : Obx(
                                                            () => Text(
                                                              controller
                                                                  .timeST.value,
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodyMedium,
                                                            ),
                                                          ),
                                                  ),

                                                  // ETA for pending transactions
                                                  if (!controller
                                                      .transactionModel!
                                                      .status!
                                                      .confirmed!)
                                                    BitNetListTile(
                                                      contentPadding:
                                                          const EdgeInsets
                                                              .symmetric(
                                                        horizontal: AppTheme
                                                                .elementSpacing *
                                                            0.75,
                                                        vertical: AppTheme
                                                                .elementSpacing *
                                                            0.5,
                                                      ),
                                                      text: 'ETA',
                                                      trailing: Row(
                                                        children: [
                                                          SizedBox(
                                                            width: 170.w,
                                                            child: Text(
                                                              controllerHome
                                                                          .txPosition
                                                                          .value >=
                                                                      7
                                                                  ? L10n.of(
                                                                          context)!
                                                                      .inSeveralHours
                                                                  : 'In ~ ${controllerHome.txPosition.value + 1 * 10}${L10n.of(context)!.minutesTx}',
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodyLarge,
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                              width: 5),
                                                          Container(
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        4),
                                                            decoration:
                                                                BoxDecoration(
                                                              color:
                                                                  Colors.purple,
                                                              borderRadius: AppTheme
                                                                  .cardRadiusCircular,
                                                            ),
                                                            child: Center(
                                                              child: Text(
                                                                L10n.of(context)!
                                                                    .accelerate,
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .bodyMedium,
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),

                                                  // Fee
                                                  BitNetListTile(
                                                    contentPadding:
                                                        const EdgeInsets
                                                            .symmetric(
                                                      horizontal: AppTheme
                                                              .elementSpacing *
                                                          0.75,
                                                      vertical: AppTheme
                                                              .elementSpacing *
                                                          0.5,
                                                    ),
                                                    text: 'Fee',
                                                    trailing: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        GestureDetector(
                                                          onTap: () {
                                                            coin.setCurrencyType(
                                                                coin.coin !=
                                                                        null
                                                                    ? !coin
                                                                        .coin!
                                                                    : false);
                                                          },
                                                          child: Text(
                                                            coin.coin ?? true
                                                                ? '${controller.transactionModel == null ? '' : controller.formatPrice(controller.transactionModel!.fee.toString())}'
                                                                : controller.transactionModel ==
                                                                        null
                                                                    ? ''
                                                                    : '${CurrencyConverter.convertCurrency(BitcoinUnits.SAT.name, controller.transactionModel!.fee?.toDouble() ?? 0, currency!, bitcoinPrice)} ${getCurrency(currency)}',
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .titleMedium,
                                                          ),
                                                        ),
                                                        coin.coin ?? true
                                                            ? Icon(AppTheme
                                                                .satoshiIcon)
                                                            : const SizedBox
                                                                .shrink(),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
        }),
      ),
    );
  }

  Future<dynamic> RightAvatarBitnetBottomSheet(dynamic controller) {
    return BitNetBottomSheet(
        context: context,
        height: MediaQuery.of(context).size.height * 0.6,
        child: bitnetScaffold(
          extendBodyBehindAppBar: true,
          context: context,
          appBar: bitnetAppBar(
            context: context,
            hasBackButton: false,
            text: L10n.of(context)!.outputTx,
            actions: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppTheme.elementSpacing),
                child: Obx(
                  () => LongButtonWidget(
                      customWidth: AppTheme.cardPadding * 4.75,
                      customHeight: AppTheme.cardPadding * 1.25,
                      buttonType: ButtonType.transparent,
                      title: !controller.showDetail.value
                          ? L10n.of(context)!.showDetails
                          : L10n.of(context)!.hideDetails,
                      onTap: () {
                        controller.toggleExpansion();
                        setState(() {});
                      }),
                ),
              )
            ],
          ),
          body: StatefulBuilder(
            builder: (context, setState) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppTheme.cardPadding),
                child: SingleChildScrollView(
                  physics: NeverScrollableScrollPhysics(),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.6 -
                        AppTheme.cardPadding * 1.25,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: AppTheme.cardPadding * 2.5,
                        ),
                        SearchFieldWidget(
                          // controller: searchCtrl,
                          hintText: L10n.of(context)!.search,
                          handleSearch: (v) {
                            setState(() {
                              outputCtrl.text = v;
                            });
                          },
                          isSearchEnabled: true,
                        ),
                        const SizedBox(
                          height: AppTheme.elementSpacing,
                        ),
                        Expanded(
                          child: MediaQuery.removePadding(
                            context: context,
                            removeTop: true,
                            child: SingleChildScrollView(
                              child: Padding(
                                padding: EdgeInsets.only(top: 16),
                                child: GlassContainer(
                                  child: ListView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: controller
                                        .transactionModel?.vout?.length,
                                    itemBuilder: (context, index) {
                                      double value = (controller
                                              .transactionModel!
                                              .vout![index]
                                              .value!) /
                                          100000000;

                                      controller.output.value = double.parse(
                                        value.toStringAsFixed(8),
                                      );
                                      String address = '';
                                      if (controller
                                              .transactionModel!
                                              .vout?[index]
                                              .scriptpubkeyAddress !=
                                          null)
                                        address = controller
                                                .transactionModel!
                                                .vout?[index]
                                                .scriptpubkeyAddress ??
                                            '';
                                      return address.contains(outputCtrl.text)
                                          ? Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: AppTheme
                                                          .elementSpacing),
                                              child: Obx(
                                                () => AddressItem(
                                                  unitModel: BitcoinUnitModel(
                                                      amount: value,
                                                      bitcoinUnit:
                                                          BitcoinUnits.BTC),
                                                  address: address,
                                                  direction:
                                                      TransactionDirection
                                                          .received,
                                                  isOwned: controller
                                                      .currentOwnedAddresses
                                                      .contains(address),
                                                  showDetails: controller
                                                      .showDetail.value,
                                                  hex: controller
                                                          .transactionModel!
                                                          .vout?[index]
                                                          .scriptpubkey ??
                                                      '',
                                                  asm: controller
                                                          .transactionModel!
                                                          .vout?[index]
                                                          .scriptpubkeyAsm ??
                                                      '',
                                                  type: controller
                                                          .transactionModel!
                                                          .vout?[index]
                                                          .scriptpubkeyType ??
                                                      '',
                                                  isVin: false,
                                                ),
                                              ))
                                          : const SizedBox();
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ));
  }

  Future<dynamic> LeftAvatarBitNetBottomSheet(
      TransactionController controller) {
    return BitNetBottomSheet(
      context: context,
      height: MediaQuery.of(context).size.height * 0.6,
      child: bitnetScaffold(
        extendBodyBehindAppBar: true,
        context: context,
        appBar: bitnetAppBar(
          context: context,
          hasBackButton: false,
          text: L10n.of(context)!.inputTx,
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppTheme.elementSpacing),
              child: Obx(
                () => LongButtonWidget(
                    customWidth: AppTheme.cardPadding * 4.75,
                    customHeight: AppTheme.cardPadding * 1.25,
                    buttonType: ButtonType.transparent,
                    title: !controller.showDetail.value
                        ? L10n.of(context)!.showDetails
                        : L10n.of(context)!.hideDetails,
                    onTap: () {
                      controller.toggleExpansion();
                      setState(() {});
                    }),
              ),
            )
          ],
        ),
        body: StatefulBuilder(builder: (context, setState) {
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppTheme.cardPadding,
            ),
            child: SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.6 -
                    AppTheme.cardPadding * 1.25,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: AppTheme.cardPadding * 2.5),
                    SearchFieldWidget(
                      // controller: searchCtrl,
                      hintText: L10n.of(context)!.search,
                      handleSearch: (v) {
                        setState(() {
                          inputCtrl.text = v;
                        });
                      },
                      isSearchEnabled: true,
                    ),
                    Expanded(
                      child: MediaQuery.removePadding(
                        context: context,
                        removeTop: true,
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: EdgeInsets.only(top: 16),
                            child: GlassContainer(
                              child: Obx(() {
                                controller.showDetail.value;
                                return ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: controller.transactionModel?.vin
                                      ?.where((test) => test.prevout != null)
                                      .length,
                                  itemBuilder: (context, index) {
                                    double value = (controller.transactionModel!
                                            .vin![index].prevout!.value!) /
                                        100000000;
                                    controller.input.value =
                                        double.parse(value.toStringAsFixed(8));
                                    String address = '';
                                    if (controller.transactionModel!.vin?[index]
                                            .prevout!.scriptpubkeyAddress !=
                                        null)
                                      address = controller
                                              .transactionModel!
                                              .vin?[index]
                                              .prevout!
                                              .scriptpubkeyAddress ??
                                          '';
                                    return address.contains(inputCtrl.text)
                                        ? Obx(
                                            () => AddressItem(
                                              unitModel: BitcoinUnitModel(
                                                  amount: value,
                                                  bitcoinUnit:
                                                      BitcoinUnits.BTC),
                                              address: address,
                                              isOwned: controller
                                                  .currentOwnedAddresses
                                                  .contains(address),
                                              direction:
                                                  TransactionDirection.sent,
                                              showDetails:
                                                  controller.showDetail.value,
                                              hex: '',
                                              asm: controller
                                                      .transactionModel!
                                                      .vin![index]
                                                      .prevout
                                                      ?.scriptpubkeyAsm ??
                                                  '',
                                              type: controller
                                                      .transactionModel!
                                                      .vin![index]
                                                      .prevout
                                                      ?.scriptpubkeyType ??
                                                  '',
                                              isVin: true,
                                              witnesses: controller
                                                  .transactionModel!
                                                  .vin![index]
                                                  .witness,
                                              sequence: controller
                                                  .transactionModel!
                                                  .vin![index]
                                                  .sequence,
                                            ),
                                          )
                                        : const SizedBox();
                                  },
                                );
                              }),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

class AddressItem extends StatefulWidget {
  const AddressItem(
      {super.key,
      required this.unitModel,
      required this.address,
      required this.isOwned,
      required this.direction,
      required this.showDetails,
      required this.hex,
      required this.asm,
      required this.type,
      required this.isVin,
      this.witnesses,
      this.sequence});
  final BitcoinUnitModel unitModel;
  final String address;
  final bool isOwned;
  final TransactionDirection direction;
  final bool showDetails;
  final String hex;
  final String asm;
  final String type;
  final bool isVin;
  final List<String>? witnesses;
  final int? sequence;
  @override
  State<AddressItem> createState() => _AddressItemState();
}

class _AddressItemState extends State<AddressItem> {
  bool isTapped = false;

  bool showInfo = false;
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<WalletsController>();
    final transactionController = Get.find<TransactionController>();
    // Use DateFormat for formatting the timestamp
    final chartLine = controller.chartLines.value;
    String? currency =
        Provider.of<CurrencyChangeProvider>(context).selectedCurrency;
    final coin = Provider.of<CurrencyTypeProvider>(context, listen: true);
    currency = currency ?? "USD";
    final bitcoinPrice = chartLine?.price;

    final currencyEquivalent = bitcoinPrice != null
        ? CurrencyConverter.convertCurrency(
            widget.unitModel.bitcoinUnitAsString,
            widget.unitModel.amount.toDouble(),
            currency,
            bitcoinPrice)
        : "0.00";
    return Material(
      color: Colors.transparent,
      child: InkWell(
        //splashColor: Colors.grey,
        onTap: () async {
          if (!isTapped) {
            isTapped = true;
            setState(() {});
          } else {
            return;
          }
          await Future.delayed(const Duration(milliseconds: 100));
          transactionController.getAddressComponent(widget.address);
          transactionController.addressId = widget.address;
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddressComponent(),
            ),
          );
          isTapped = false;
          setState(() {});
        },
        child: Container(
          padding:
              const EdgeInsets.symmetric(vertical: AppTheme.elementSpacing),
          child: Padding(
            padding: const EdgeInsets.only(
              left: AppTheme.elementSpacing * 0.75,
              right: AppTheme.elementSpacing * 1,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            child: const Avatar(
                                size: AppTheme.cardPadding * 2, isNft: false)),
                        const SizedBox(width: AppTheme.elementSpacing * 0.75),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Row(
                                children: [
                                  if (widget.isOwned) ...[
                                    SizedBox(
                                        width: AppTheme.cardPadding * 1.5.w,
                                        child: Text('You ~ ',
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleLarge))
                                  ],
                                  SizedBox(
                                    width: widget.showDetails
                                        ? AppTheme.cardPadding * 9.w
                                        : AppTheme.cardPadding * 5.w,
                                    child: Text(
                                      '${widget.address}',
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium,
                                      softWrap: widget.showDetails,
                                      maxLines: widget.showDetails ? 3 : 1,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: AppTheme.elementSpacing,
                            ),
                            if (!widget.showDetails)
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: AppTheme.elementSpacing / 2,
                                      ),
                                      child: Image.asset(
                                        "assets/images/bitcoin.png",
                                        width: AppTheme.cardPadding * 0.75,
                                        height: AppTheme.cardPadding * 0.75,
                                        fit: BoxFit.contain,
                                      )),
                                  Text(
                                    'Onchain',
                                    overflow: TextOverflow.ellipsis,
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ],
                    ),
                    if (!widget.showDetails)
                      Obx(
                        () => Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            controller.hideBalance.value
                                ? Text(
                                    '*****',
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  )
                                : Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          coin.setCurrencyType(coin.coin != null
                                              ? !coin.coin!
                                              : false);
                                        },
                                        child: Text(
                                          coin.coin ?? true
                                              ? widget.unitModel.amount
                                                  .toString()
                                              : "${double.parse(currencyEquivalent).toStringAsFixed(2)}${getCurrency(currency!)}",
                                          overflow: TextOverflow.ellipsis,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium!
                                              .copyWith(
                                                  color: widget.direction ==
                                                          TransactionDirection
                                                              .received
                                                      ? AppTheme.successColor
                                                      : AppTheme.errorColor),
                                        ),
                                      ),
                                      coin.coin ?? true
                                          ? Icon(
                                              getCurrencyIcon(widget.unitModel
                                                  .bitcoinUnitAsString),
                                              color: widget.direction ==
                                                      TransactionDirection
                                                          .received
                                                  ? AppTheme.successColor
                                                  : AppTheme.errorColor,
                                            )
                                          : const SizedBox.shrink(),
                                    ],
                                  ),
                            const SizedBox(
                              height: AppTheme.elementSpacing,
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
                if (widget.showDetails) ...[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppTheme.elementSpacing / 2,
                          ),
                          child: Image.asset(
                            "assets/images/bitcoin.png",
                            width: AppTheme.cardPadding * 0.75,
                            height: AppTheme.cardPadding * 0.75,
                            fit: BoxFit.contain,
                          )),
                      Text(
                        'Onchain',
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  if (widget.isVin) ...[
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(L10n.of(context)!.witness,
                                style: AppTheme.textTheme.bodyMedium!
                                    .copyWith(color: Colors.white)),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: widget.witnesses!.length,
                                  itemBuilder: (context, ind) {
                                    return Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 10),
                                      child: Text('${widget.witnesses![ind]}',
                                          style: AppTheme.textTheme.bodyMedium!
                                              .copyWith(color: Colors.white)),
                                    );
                                  },
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('nSequence',
                            style: AppTheme.textTheme.bodyMedium!
                                .copyWith(color: Colors.white)),
                        Text('0x${widget.sequence?.toRadixString(16)}',
                            style: AppTheme.textTheme.bodyMedium!
                                .copyWith(color: Colors.white))
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          widget.isVin
                              ? L10n.of(context)!.previousOutputScripts
                              : 'ScriptPubKey (ASM)	',
                          style: AppTheme.textTheme.bodyMedium!
                              .copyWith(color: Colors.white)),
                      const SizedBox(
                        width: 10,
                      ),
                      Flexible(
                        child: Text(
                          '${widget.asm}',
                          style: AppTheme.textTheme.bodyMedium!
                              .copyWith(color: Colors.white),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  if (!widget.isVin)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('ScriptPubKey (HEX)	',
                            style: AppTheme.textTheme.bodyMedium!
                                .copyWith(color: Colors.white)),
                        const SizedBox(
                          width: 10,
                        ),
                        Flexible(
                          child: Text(
                            '${widget.hex}',
                            style: AppTheme.textTheme.bodyMedium!
                                .copyWith(color: Colors.white),
                          ),
                        )
                      ],
                    ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          widget.isVin
                              ? 'Previous output type'
                              : L10n.of(context)!.typeBehavior,
                          style: AppTheme.textTheme.bodyMedium!
                              .copyWith(color: Colors.white)),
                      const SizedBox(
                        width: 10,
                      ),
                      Flexible(
                        child: Text(
                          '${widget.type}',
                          style: AppTheme.textTheme.bodyMedium!
                              .copyWith(color: Colors.white),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 16),
                  Obx(
                    () => Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        controller.hideBalance.value
                            ? Text(
                                '*****',
                                style: Theme.of(context).textTheme.titleMedium,
                              )
                            : Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      coin.setCurrencyType(coin.coin != null
                                          ? !coin.coin!
                                          : false);
                                    },
                                    child: Text(
                                      coin.coin ?? true
                                          ? widget.unitModel.amount.toString()
                                          : "${double.parse(currencyEquivalent).toStringAsFixed(2)}${getCurrency(currency!)}",
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium!
                                          .copyWith(
                                              color: widget.direction ==
                                                      TransactionDirection
                                                          .received
                                                  ? AppTheme.successColor
                                                  : AppTheme.errorColor),
                                    ),
                                  ),
                                  coin.coin ?? true
                                      ? Icon(
                                          getCurrencyIcon(widget
                                              .unitModel.bitcoinUnitAsString),
                                          color: widget.direction ==
                                                  TransactionDirection.received
                                              ? AppTheme.successColor
                                              : AppTheme.errorColor,
                                        )
                                      : const SizedBox.shrink(),
                                ],
                              ),
                      ],
                    ),
                  ),
                ]
              ],
            ),
          ),
        ),
      ),
    );
  }
}
