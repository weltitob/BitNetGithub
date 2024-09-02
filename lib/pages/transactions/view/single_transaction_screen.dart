import 'dart:async';

import 'package:bitnet/backbone/helper/currency/currency_converter.dart';
import 'package:bitnet/backbone/helper/currency/getcurrency.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/streams/currency_provider.dart';
import 'package:bitnet/backbone/streams/currency_type_provider.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetListTile.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/container/avatar.dart';
import 'package:bitnet/components/container/imagewithtext.dart';
import 'package:bitnet/components/dialogsandsheets/bottom_sheets/bit_net_bottom_sheet.dart';
import 'package:bitnet/components/dialogsandsheets/notificationoverlays/overlay.dart';
import 'package:bitnet/components/fields/searchfield/searchfield.dart';
import 'package:bitnet/components/loaders/loaders.dart';
import 'package:bitnet/pages/secondpages/mempool/controller/home_controller.dart';
import 'package:bitnet/pages/transactions/controller/transaction_controller.dart';
import 'package:bitnet/pages/transactions/view/address_component.dart';
import 'package:bitnet/pages/wallet/controllers/wallet_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class SingleTransactionScreen extends StatefulWidget {
  const SingleTransactionScreen({Key? key}) : super(key: key);

  @override
  State<SingleTransactionScreen> createState() => _SingleTransactionScreenState();
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
      setState((){});
    });
  }

  @override
  void dispose(){
    super.dispose();
    sub.cancel();
  }
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TransactionController());
    final controllerWallet = Get.put(WalletsController());
    final controllerHome = Get.put(HomeController());

    String? currency = Provider.of<CurrencyChangeProvider>(context).selectedCurrency;
    final coin = Provider.of<CurrencyTypeProvider>(context, listen: true);
    currency = currency ?? "USD";
    int amount = 0;
    String amountPredefined = controller.amount;
    if(controller.transactionModel != null) {
    // Initialize variables for amounts and addresses
    num totalReceived = 0;
    num totalSent = 0;

    for (var vin in controller.transactionModel!.vin!) {
      if (vin.prevout != null && vin.prevout!.value != null) {
        // Check if the input is from our address
        if (vin.prevout?.scriptpubkeyAddress == controller.addressId) {
          totalSent += vin.prevout!.value!;
        }
      }
    }

    for (var vout in controller.transactionModel!.vout!) {
      if (vout.value != null) {
        // Check if the output is to our address
        if (vout.scriptpubkeyAddress == controller.addressId) {
          totalReceived += vout.value!;
        }
      }
    }

// Determine the net amount and direction
    if (controller.addressId.isEmpty) {
      amount = int.parse(amountPredefined);
    } else {
      amount = (totalReceived - totalSent).toInt();
    }
    }
    final chartLine = controllerWallet.chartLines.value;
    final bitcoinPrice = chartLine?.price;

    String currencyAmount = CurrencyConverter.convertCurrency('SAT', amount.toDouble(), currency, bitcoinPrice ?? 0);
    String currSymbol = getCurrency(currency);
    return bitnetScaffold(
      context: context,
      extendBodyBehindAppBar: true,
      appBar: bitnetAppBar(
        text: "OnChain Transaction",
        context: context,
        onTap: () {
          channel.sink.add('{"track-rbf-summary":true}');
          channel.sink.add('{"track-tx":"stop"}');
          channel.sink.add('{"action":"want","data":["blocks","mempool-blocks"]}');
          Navigator.pop(context);
          controller.homeController.isRbfTransaction.value = false;
        },
      ),
      body: PopScope(
        canPop: true,
        onPopInvoked: (bool didPop) {
          channel.sink.add('{"track-rbf-summary":true}');
          channel.sink.add('{"track-tx":"stop"}');
          channel.sink.add(
            '{"action":"want","data":["blocks","mempool-blocks"]}',
          );
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
                        padding: const EdgeInsets.only(top: AppTheme.cardPadding * 3),
                        child: Container(
                          child: Column(
                            children: [
                              controller.homeController.isRbfTransaction.value
                                  ? Container(
                                      decoration: BoxDecoration(
                                        color: Colors.purple.shade400,
                                        borderRadius: AppTheme.cardRadiusCircular,
                                      ),
                                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                        Text(
                                          L10n.of(context)!.transactionReplaced,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () async {
                                            await Clipboard.setData(ClipboardData(
                                              text: controllerHome.replacedTx.value,
                                            ));
                                            showOverlay(context, L10n.of(context)!.copiedToClipboard);
                                          },
                                          child: Row(
                                            children: [
                                              SizedBox(
                                                width: 300,
                                                child: Text(
                                                  controllerHome.replacedTx.value,
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.bold,
                                                      // decoration:
                                                      //     TextDecoration.underline,
                                                      decorationColor: Colors.white,
                                                      decorationThickness: 2),
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
                                  borderRadius: AppTheme.cardRadiusBiggest,
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                      vertical: AppTheme.cardPadding * 1.25,
                                    ),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Column(
                                              children: [
                                                Avatar(
                                                  size: AppTheme.cardPadding * 4,
                                                  onTap: () {
                                                    LeftAvatarBitNetBottomSheet(controller);
                                                  },
                                                  isNft: false,
                                                ),
                                                const SizedBox(
                                                  height: AppTheme.elementSpacing * 0.5,
                                                ),
                                                Text("Sender (${controller.transactionModel?.vin?.length})"),
                                              ],
                                            ),
                                            const SizedBox(
                                              width: AppTheme.cardPadding * 0.75,
                                            ),
                                            Icon(
                                              Icons.double_arrow_rounded,
                                              size: AppTheme.cardPadding * 2.5,
                                              color: Theme.of(context).brightness == Brightness.dark ? AppTheme.white80 : AppTheme.black60,
                                            ),
                                            const SizedBox(
                                              width: AppTheme.cardPadding * 0.75,
                                            ),
                                            Column(
                                              children: [
                                                Avatar(
                                                  size: AppTheme.cardPadding * 4,
                                                  isNft: false,
                                                  onTap: () {
                                                    RightAvatarBitnetBottomSheet(controller);
                                                  },
                                                ),
                                                const SizedBox(
                                                  height: AppTheme.elementSpacing * 0.5,
                                                ),
                                                Text("Receiver (${controller.transactionModel?.vout?.length})"),
                                              ],
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: AppTheme.cardPadding * 0.75),
                                        controllerWallet.hideBalance.value
                                            ? Text(
                                                '*****',
                                                style: Theme.of(context).textTheme.titleMedium,
                                              )
                                            : Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      coin.setCurrencyType(coin.coin != null ? !coin.coin! : false);
                                                    },
                                                    child: Text(
                                                        coin.coin ?? true
                                                            ? '${controller.transactionModel == null ? '' : controller.formatPrice(amount.toString())}'
                                                            : "${currencyAmount} ${currSymbol}",
                                                        overflow: TextOverflow.ellipsis,
                                                        style: Theme.of(context).textTheme.displayMedium!),
                                                  ),
                                                  coin.coin ?? true
                                                      ? Icon(
                                                          AppTheme.satoshiIcon,
                                                        )
                                                      : const SizedBox.shrink(),
                                                ],
                                              ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: AppTheme.elementSpacing * 1,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: AppTheme.elementSpacing),
                                child: Column(
                                  children: [
                                    BitNetListTile(
                                        text: 'TransactionID',
                                        trailing: GestureDetector(
                                          onTap: () async {
                                            await Clipboard.setData(ClipboardData(
                                              text: controller.txID!,
                                            ));
                                            showOverlay(context, L10n.of(context)!.copiedToClipboard);
                                          },
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.copy,
                                                color: AppTheme.white60,
                                                size: AppTheme.cardPadding * 0.75,
                                              ),
                                              const SizedBox(
                                                width: AppTheme.elementSpacing / 2,
                                              ),
                                              Container(
                                                width: AppTheme.cardPadding * 5.w,
                                                child: Text(
                                                  controller.txID!,
                                                  style: Theme.of(context).textTheme.bodyMedium,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ],
                                          ),
                                        )),
                                    BitNetListTile(
                                      onTap: () {
                                        if (controller.transactionModel!.status!.blockHeight != null)
                                          controllerHome.blockHeight = controller.transactionModel!.status!.blockHeight!;
                                        context.push('/wallet/bitcoinscreen/mempool');
                                      },
                                      text: L10n.of(context)!.block,
                                      trailing: Row(
                                        children: [
                                          Text(
                                            "${controller.transactionModel!.status!.blockHeight ?? "--"}",
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleMedium!
                                                .copyWith(color: Theme.of(context).colorScheme.primary),
                                          ),
                                          const SizedBox(
                                            width: AppTheme.elementSpacing / 2,
                                          ),
                                          Icon(
                                            Icons.arrow_forward_ios,
                                            size: AppTheme.cardPadding * 0.75,
                                            color: Theme.of(context).colorScheme.primary,
                                          ),
                                        ],
                                      ),
                                    ),
                                    BitNetListTile(
                                      text: L10n.of(context)!.status,
                                      trailing: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: AppTheme.elementSpacing, vertical: AppTheme.elementSpacing / 2),
                                        decoration: BoxDecoration(
                                          borderRadius: AppTheme.cardRadiusCircular,
                                          color: controller.transactionModel == null
                                              ? AppTheme.errorColor
                                              : controller.transactionModel!.status!.confirmed!
                                                  ? AppTheme.successColor
                                                  : controllerHome.isRbfTransaction.value == true
                                                      ? AppTheme.colorBitcoin
                                                      : AppTheme.errorColor,
                                        ),
                                        child: Center(
                                          child: Text(
                                            controllerHome.isRbfTransaction.value == true
                                                ? L10n.of(context)!.replaced
                                                : '${controller.confirmations == 0 ? '' : controller.confirmations} ' +
                                                    controller.statusTransaction.value,
                                            style: const TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                    BitNetListTile(
                                      text: L10n.of(context)!.paymentNetwork,
                                      trailing: Row(
                                        children: [
                                          Image.asset("assets/images/bitcoin.png",
                                              width: AppTheme.cardPadding * 1, height: AppTheme.cardPadding * 1),
                                          const SizedBox(
                                            width: AppTheme.elementSpacing / 2,
                                          ),
                                          Text(
                                            'Onchain',
                                            style: Theme.of(context).textTheme.titleMedium,
                                          ),
                                        ],
                                      ),
                                    ),
                                    BitNetListTile(
                                      text: L10n.of(context)!.time,
                                      trailing: controller.transactionModel!.status!.confirmed!
                                          ? Container(
                                              child: Column(
                                                children: [
                                                  Text(
                                                    '${DateFormat('yyyy-MM-dd HH:mm').format(DateTime.fromMillisecondsSinceEpoch(controller.transactionModel!.status!.blockTime! * 1000))}'
                                                    ' (${controller.formatTimeAgo(DateTime.fromMillisecondsSinceEpoch(controller.transactionModel!.status!.blockTime! * 1000))})',
                                                    overflow: TextOverflow.ellipsis,
                                                    style: Theme.of(context).textTheme.bodyMedium,
                                                  ),
                                                ],
                                              ),
                                            )
                                          : Obx(
                                              () {
                                                return Text(
                                                  controller.timeST.value,
                                                  style: Theme.of(context).textTheme.bodyMedium,
                                                );
                                              },
                                            ),
                                    ),
                                    controller.transactionModel!.status!.confirmed!
                                        ? const SizedBox()
                                        : BitNetListTile(
                                            text: 'ETA',
                                            trailing: Row(
                                              children: [
                                                SizedBox(
                                                  width: 170.w,
                                                  child: Text(
                                                    controllerHome.txPosition.value >= 7
                                                        ? L10n.of(context)!.inSeveralHours
                                                        : 'In ~ ${controllerHome.txPosition.value + 1 * 10}${L10n.of(context)!.minutesTx}',
                                                    style: Theme.of(context).textTheme.bodyLarge,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 5,
                                                ),
                                                Container(
                                                  padding: const EdgeInsets.symmetric(
                                                    horizontal: 4,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    color: Colors.purple,
                                                    borderRadius: AppTheme.cardRadiusCircular,
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      L10n.of(context)!.accelerate,
                                                      style: Theme.of(context).textTheme.bodyMedium,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            )),
                                    // BitNetListTile(
                                    //   text: L10n.of(context)!.confirmed,
                                    //   trailing: Row(
                                    //     mainAxisAlignment:
                                    //     MainAxisAlignment
                                    //         .spaceEvenly,
                                    //     children: [
                                    //       Text(
                                    //           L10n.of(context)!
                                    //               .confirmed +
                                    //               " ",
                                    //           style: Theme.of(context)
                                    //               .textTheme
                                    //               .bodyMedium),
                                    //       Row(
                                    //         children: [
                                    //           Text(
                                    //             L10n.of(context)!
                                    //                 .afterTx +
                                    //                 DateTime
                                    //                     .fromMillisecondsSinceEpoch(
                                    //                   (controller
                                    //                       .transactionModel!
                                    //                       .status!
                                    //                       .blockTime! *
                                    //                       1000) -
                                    //                       (controller
                                    //                           .txTime *
                                    //                           1000),
                                    //                 )
                                    //                     .minute
                                    //                     .toString() +
                                    //                 L10n.of(context)!
                                    //                     .minutesTx,
                                    //             style: Theme.of(context)
                                    //                 .textTheme
                                    //                 .bodyMedium,
                                    //           ),
                                    //         ],
                                    //       ),
                                    //     ],
                                    //   ),
                                    // ),
                                    // BitNetListTile(
                                    //     text: L10n.of(context)!.features,
                                    //     trailing: Row(
                                    //       mainAxisAlignment:
                                    //       MainAxisAlignment.spaceBetween,
                                    //       children: [
                                    //         if (controller.segwitEnabled.value)
                                    //           Container(
                                    //             padding: const EdgeInsets.symmetric(
                                    //                 horizontal: AppTheme.elementSpacing, vertical: AppTheme.elementSpacing / 2,),
                                    //             margin: const EdgeInsets.symmetric(
                                    //               horizontal: 4,
                                    //             ),
                                    //             decoration: BoxDecoration(
                                    //               color: controller
                                    //                   .realizedSegwitGains !=
                                    //                   0 &&
                                    //                   controller
                                    //                       .potentialSegwitGains !=
                                    //                       0
                                    //                   ? AppTheme.colorBitcoin
                                    //                   : controller.potentialP2shSegwitGains !=
                                    //                   0
                                    //                   ? AppTheme.errorColor
                                    //                   : AppTheme.successColor,
                                    //               borderRadius:
                                    //               AppTheme.cardRadiusCircular,
                                    //             ),
                                    //             child: Text(
                                    //               'SegWit',
                                    //               style: Theme.of(context)
                                    //                   .textTheme
                                    //                   .bodyMedium
                                    //                   ?.copyWith(
                                    //                   color: Colors.white,
                                    //                   decoration: controller
                                    //                       .potentialP2shSegwitGains !=
                                    //                       0
                                    //                       ? TextDecoration
                                    //                       .lineThrough
                                    //                       : TextDecoration.none),
                                    //             ),
                                    //           ),
                                    //         if (controller.taprootEnabled.value)
                                    //           Container(
                                    //             padding: const EdgeInsets.symmetric(
                                    //               horizontal: AppTheme.elementSpacing, vertical: AppTheme.elementSpacing / 2,),
                                    //             margin: EdgeInsets.symmetric(
                                    //                 horizontal: 4,),
                                    //             decoration: BoxDecoration(
                                    //               color: controller.isTaproot.value
                                    //                   ? AppTheme.successColor
                                    //                   : AppTheme.errorColor,
                                    //               borderRadius:
                                    //               AppTheme.cardRadiusCircular,
                                    //             ),
                                    //             child: Text(
                                    //               'Taproot',
                                    //               style: Theme.of(context)
                                    //                   .textTheme
                                    //                   .bodyMedium
                                    //                   ?.copyWith(
                                    //                   color: Colors.white,
                                    //                   decoration: controller
                                    //                       .isTaproot.value
                                    //                       ? TextDecoration.none
                                    //                       : TextDecoration
                                    //                       .lineThrough),
                                    //             ),
                                    //           ),
                                    //         if (controller.rbfEnabled.value)
                                    //           Container(
                                    //               padding: const EdgeInsets.symmetric(
                                    //               horizontal: AppTheme.elementSpacing, vertical: AppTheme.elementSpacing / 2,),
                                    //               margin: EdgeInsets.symmetric(
                                    //                   horizontal: 4,),
                                    //               decoration: BoxDecoration(
                                    //                 color: controller
                                    //                     .isRbfTransaction.value
                                    //                     ? AppTheme.successColor
                                    //                     : AppTheme.errorColor,
                                    //                 borderRadius:
                                    //                 AppTheme.cardRadiusCircular,
                                    //               ),
                                    //               child: Text(
                                    //                 'RBF',
                                    //                 style: Theme.of(context)
                                    //                     .textTheme
                                    //                     .bodyMedium
                                    //                     ?.copyWith(
                                    //                   color: Colors.white,
                                    //                     decoration: controller
                                    //                         .isRbfTransaction
                                    //                         .value
                                    //                         ? TextDecoration.none
                                    //                         : TextDecoration
                                    //                         .lineThrough),
                                    //
                                    //               )
                                    //           ),
                                    //       ],
                                    //     )),
                                    BitNetListTile(
                                        text: 'Fee',
                                        trailing: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                coin.setCurrencyType(coin.coin != null ? !coin.coin! : false);
                                              },
                                              child: Text(
                                                coin.coin ?? true
                                                    ? '${controller.transactionModel == null ? '' : controller.formatPrice(controller.transactionModel!.fee.toString())} sat '
                                                    : '\$ ${controller.usdValue.value.toStringAsFixed(2)}  ',
                                                overflow: TextOverflow.ellipsis,
                                                style: Theme.of(context).textTheme.titleMedium,
                                              ),
                                            ),
                                            coin.coin ?? true ? Icon(AppTheme.satoshiIcon) : const SizedBox.shrink(),
                                          ],
                                        )),
                                    // BitNetListTile(
                                    //     text: L10n.of(context)!.feeRate,
                                    //     trailing: Row(
                                    //       children: [
                                    //         Text(
                                    //           '${(controller.feeRate * 4).toStringAsFixed(1)} sat/vB',
                                    //           style: Theme.of(context)
                                    //               .textTheme
                                    //               .bodyLarge,
                                    //         ),
                                    //         SizedBox(
                                    //           width: 10,
                                    //         ),
                                    //         controller.transactionModel!.status!
                                    //             .confirmed!
                                    //             ? Container(
                                    //           padding: EdgeInsets.symmetric(
                                    //               horizontal: AppTheme.elementSpacing, vertical: AppTheme.elementSpacing / 2),
                                    //           decoration: BoxDecoration(
                                    //             color: controller
                                    //                 .feeRating.value ==
                                    //                 1
                                    //                 ? AppTheme.successColor
                                    //                 : controller.feeRating
                                    //                 .value ==
                                    //                 2
                                    //                 ? AppTheme.colorBitcoin
                                    //                 : AppTheme.errorColor,
                                    //             borderRadius:
                                    //             AppTheme.cardRadiusCircular,
                                    //           ),
                                    //           child: Center(
                                    //             child: Text(
                                    //               controller.feeRating.value ==
                                    //                   1
                                    //                   ? L10n.of(context)!
                                    //                   .optimal
                                    //                   : '${L10n.of(context)!.overpaid} ${controller.overpaidTimes ?? 1}x',
                                    //               style: Theme.of(context)
                                    //                   .textTheme
                                    //                   .bodyMedium!.copyWith(color: Colors.white),
                                    //             ),
                                    //           ),
                                    //         )
                                    //             : SizedBox(),
                                    //       ],
                                    //     )
                                    // ),
                                    const SizedBox(
                                      height: AppTheme.cardPadding,
                                    ),
                                  ],
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
                padding: const EdgeInsets.symmetric(horizontal: AppTheme.elementSpacing),
                child: LongButtonWidget(
                    customWidth: AppTheme.cardPadding * 4.75,
                    customHeight: AppTheme.cardPadding * 1.25,
                    buttonType: ButtonType.transparent,
                    title: !controller.showDetail.value ? L10n.of(context)!.showDetails : L10n.of(context)!.hideDetails,
                    onTap: () {
                      controller.toggleExpansion();
                      setState(() {});
                    }),
              )
            ],
          ),
          body: StatefulBuilder(
            builder: (context, setState) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppTheme.cardPadding),
                child: SingleChildScrollView(
                  physics: NeverScrollableScrollPhysics(),

                  child: SizedBox(
                                                  height: MediaQuery.of(context).size.height * 0.6 - AppTheme.cardPadding * 1.25,

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
                        !controller.showDetail.value
                            ? Expanded(
                                child: MediaQuery.removePadding(
                                    context: context,
                                  removeTop: true,
                                  child: ListView.builder(
                                    physics: const AlwaysScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: controller.transactionModel?.vout?.length,
                                    itemBuilder: (context, index) {
                                      double value = (controller.transactionModel!.vout![index].value!) / 100000000;
                                  
                                      controller.output.value = double.parse(
                                        value.toStringAsFixed(8),
                                      );
                                      String address = '';
                                      if (controller.transactionModel!.vout?[index].scriptpubkeyAddress != null)
                                        address = controller.transactionModel!.vout?[index].scriptpubkeyAddress ?? '';
                                      return address.contains(outputCtrl.text)
                                          ? Padding(
                                              padding: const EdgeInsets.symmetric(vertical: AppTheme.elementSpacing),
                                              child: GlassContainer(
                                                child: Padding(
                                                  padding: const EdgeInsets.all(AppTheme.elementSpacing),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Container(
                                                        height: 20,
                                                        width: 20,
                                                        decoration: BoxDecoration(
                                                          color: controller.dataOutSpents1.data[0][index]['spent'] == false
                                                              ? AppTheme.successColor
                                                              : controller.dataOutSpents1.data[0][index]['spent'] == true
                                                                  ? AppTheme.errorColor
                                                                  : Colors.grey.shade600,
                                                          shape: BoxShape.circle,
                                                        ),
                                                        child: const Center(
                                                          child: Icon(
                                                            Icons.arrow_forward_outlined,
                                                            size: 15,
                                                          ),
                                                        ),
                                                      ),
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        children: [
                                                          Flexible(
                                                            flex: 2,
                                                            child: GestureDetector(
                                                              onTap: () {
                                                                controller.getAddressComponent(
                                                                    controller.transactionModel!.vout?[index].scriptpubkeyAddress.toString());
                                                                controller.addressId =
                                                                    controller.transactionModel!.vout?[index].scriptpubkeyAddress.toString() ??
                                                                        '';
                                                                Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                    builder: (context) => const AddressComponent(),
                                                                  ),
                                                                );
                                                              },
                                                              child: Text(
                                                                controller.transactionModel!.vout?[index].scriptpubkeyAddress == null &&
                                                                        controller.transactionModel!.vout?[index].scriptpubkeyType == "op_return"
                                                                    ? 'OP_RETURN (R)'
                                                                    : controller.transactionModel!.vout?[index].scriptpubkeyAddress.toString() ??
                                                                        '',
                                                                style: AppTheme.textTheme.bodyMedium,
                                                              ),
                                                            ),
                                                          ),
                                                          Flexible(
                                                            flex: 2,
                                                            child: Container(
                                                              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                                                              decoration: BoxDecoration(
                                                                color: Colors.grey,
                                                                borderRadius: AppTheme.cardRadiusCircular,
                                                              ),
                                                              child: controller.isShowBTC.value
                                                                  ? Text(
                                                                      '${controller.isShowBTC.value ? controller.outPutBTC(index) : controller.outPutDollar(index)} BTC',
                                                                      style: AppTheme.textTheme.bodyMedium)
                                                                  : Text(
                                                                      '\$ ${controller.outPutDollar(index)} ',
                                                                      style: AppTheme.textTheme.bodyMedium,
                                                                    ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            )
                                          : const SizedBox();
                                    },
                                  ),
                                ),
                              )
                            : Expanded(
                                child: MediaQuery.removePadding(
                                  context: context,
                                  removeTop: true,
                                  child: ListView.builder(
                                    physics: const AlwaysScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: controller.transactionModel?.vout?.length,
                                    itemBuilder: (context, index) {
                                      double value = (controller.transactionModel!.vout![index].value!) / 100000000;
                                      controller.output.value = double.parse(value.toStringAsFixed(8));
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(vertical: AppTheme.elementSpacing),
                                        child: GlassContainer(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: AppTheme.elementSpacing, vertical: AppTheme.elementSpacing),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  height: 20,
                                                  width: 20,
                                                  decoration: BoxDecoration(
                                                    color: controller.dataOutSpents1.data[0][index]['spent'] == false
                                                        ? AppTheme.successColor
                                                        : controller.dataOutSpents1.data[0][index]['spent'] == true
                                                            ? AppTheme.errorColor
                                                            : Colors.grey.shade600,
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: const Center(
                                                    child: Icon(
                                                      Icons.arrow_forward_outlined,
                                                      size: 15,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    Flexible(
                                                      flex: 3,
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          controller.getAddressComponent(
                                                              controller.transactionModel!.vout?[index].scriptpubkeyAddress.toString());
                                                          controller.addressId =
                                                              controller.transactionModel!.vout?[index].scriptpubkeyAddress.toString() ?? '';
                                                          Navigator.push(context, MaterialPageRoute(builder: (context) => const AddressComponent()));
                                                        },
                                                        child: Text(
                                                          controller.transactionModel!.vout?[index].scriptpubkeyAddress == null &&
                                                                  controller.transactionModel!.vout?[index].scriptpubkeyType == "op_return"
                                                              ? 'OP_RETURN (R)'
                                                              : controller.transactionModel!.vout?[index].scriptpubkeyAddress.toString() ?? '',
                                                          style: AppTheme.textTheme.bodyMedium,
                                                        ),
                                                      ),
                                                    ),
                                                    Flexible(
                                                      flex: 2,
                                                      child: Container(
                                                        padding: const EdgeInsets.all(4),
                                                        decoration: BoxDecoration(
                                                          borderRadius: AppTheme.cardRadiusCircular,
                                                          color: Colors.grey,
                                                        ),
                                                        child: controller.isShowBTC.value
                                                            ? Text(
                                                                '${controller.isShowBTC.value ? controller.outPutBTC(index) : controller.outPutDollar(index)} BTC',
                                                                style: AppTheme.textTheme.bodyMedium)
                                                            : Text(
                                                                '\$ ${controller.outPutDollar(index)} ',
                                                                style: AppTheme.textTheme.bodyMedium,
                                                              ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text('ScriptPubKey (ASM)	', style: AppTheme.textTheme.bodyMedium),
                                                    const SizedBox(
                                                      width: 10,
                                                    ),
                                                    Flexible(
                                                      child: Text(
                                                        '${controller.transactionModel?.vout?[index].scriptpubkeyAsm}',
                                                        style: AppTheme.textTheme.bodyMedium,
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
                                                    Text('ScriptPubKey (HEX)	', style: AppTheme.textTheme.bodyMedium),
                                                    const SizedBox(
                                                      width: 10,
                                                    ),
                                                    Flexible(
                                                      child: Text(
                                                        '${controller.transactionModel?.vout?[index].scriptpubkey}',
                                                        style: AppTheme.textTheme.bodyMedium,
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
                                                    Text(L10n.of(context)!.typeBehavior, style: AppTheme.textTheme.bodyMedium),
                                                    const SizedBox(
                                                      width: 10,
                                                    ),
                                                    Flexible(
                                                      child: Text(
                                                        '${controller.transactionModel?.vout?[index].scriptpubkeyType}',
                                                        style: AppTheme.textTheme.bodyMedium,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ));
  }

  Future<dynamic> LeftAvatarBitNetBottomSheet(dynamic controller) {
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
              padding: const EdgeInsets.symmetric(horizontal: AppTheme.elementSpacing),
              child: LongButtonWidget(
                  customWidth: AppTheme.cardPadding * 4.75,
                  customHeight: AppTheme.cardPadding * 1.25,
                  buttonType: ButtonType.transparent,
                  title: !controller.showDetail.value ? L10n.of(context)!.showDetails : L10n.of(context)!.hideDetails,
                  onTap: () {
                    controller.toggleExpansion();
                    setState(() {});
                  }),
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
                              height: MediaQuery.of(context).size.height * 0.6 - AppTheme.cardPadding * 1.25,

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
                    !controller.showDetail.value
                        ? Expanded(
                            child: MediaQuery.removePadding(
                              context: context,
                              removeTop: true,
                              child: ListView.builder(
                                physics: const AlwaysScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: controller.transactionModel?.vin?.length,
                                itemBuilder: (context, index) {
                                  double value = (controller.transactionModel!.vin![index].prevout!.value!) / 100000000;
                                  controller.input.value = double.parse(value.toStringAsFixed(8));
                                  String address = '';
                                  if (controller.transactionModel!.vin?[index].prevout!.scriptpubkeyAddress != null)
                                    address = controller.transactionModel!.vin?[index].prevout!.scriptpubkeyAddress ?? '';
                                  return address.contains(inputCtrl.text)
                                      ? Padding(
                                          padding: const EdgeInsets.symmetric(vertical: AppTheme.elementSpacing),
                                          child: GlassContainer(
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(
                                                  horizontal: AppTheme.elementSpacing, vertical: AppTheme.elementSpacing),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    height: 20,
                                                    width: 20,
                                                    decoration: const BoxDecoration(
                                                      color: Colors.red,
                                                      shape: BoxShape.circle,
                                                    ),
                                                    child: const Center(
                                                        child: Icon(
                                                      Icons.arrow_forward_outlined,
                                                      size: 15,
                                                    )),
                                                  ),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: [
                                                      Flexible(
                                                        flex: 2,
                                                        child: GestureDetector(
                                                          onTap: () {
                                                            controller.getAddressComponent(
                                                                controller.transactionModel!.vin?[index].prevout!.scriptpubkeyAddress);
                                                            controller.addressId =
                                                                controller.transactionModel!.vin?[index].prevout!.scriptpubkeyAddress ?? '';
                                                            Navigator.push(context, MaterialPageRoute(builder: (context) => const AddressComponent()));
                              
                                                            // Get.to(() =>
                                                            //     AddressComponent());
                                                          },
                                                          child: Text(
                                                            controller.transactionModel!.vin?[index].prevout?.scriptpubkeyAddress == null &&
                                                                    controller.transactionModel!.vin?[index].prevout?.scriptpubkeyType ==
                                                                        "op_return"
                                                                ? 'OP_RETURN (R)'
                                                                : '${controller.transactionModel!.vin?[index].prevout?.scriptpubkeyAddress!.substring(0, 10)}'
                                                                    '... '
                                                                    '${controller.transactionModel!.vin?[index].prevout?.scriptpubkeyAddress!.substring((controller.transactionModel!.vin?[index].prevout?.scriptpubkeyAddress!.length)! - 5)}',
                                                            style: const TextStyle(
                                                              fontSize: 14,
                                                              color: Colors.blue,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      controller.isShowBTC.value
                                                          ? Text(
                                                              '${controller.inPutBTC(index)} BTC',
                                                              style: AppTheme.textTheme.bodyMedium,
                                                            )
                                                          : Text('\$ ${controller.inPutDollar(index)} ', style: const TextStyle(color: Colors.black))
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        )
                                      : const SizedBox();
                                },
                              ),
                            ),
                          )
                        : Expanded(
                            child: MediaQuery.removePadding(
                              context: context,
                              removeTop: true,
                              child: ListView.builder(
                                physics: const AlwaysScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: controller.transactionModel?.vin?.length,
                                itemBuilder: (context, index) {
                                  double value = (controller.transactionModel!.vin![index].prevout!.value!) / 100000000;
                                  controller.input.value = double.parse(value.toStringAsFixed(8));
                                  String address = '';
                                  if (controller.transactionModel!.vin?[index].prevout!.scriptpubkeyAddress != null)
                                    address = controller.transactionModel!.vin?[index].prevout!.scriptpubkeyAddress ?? '';
                                  return address.contains(inputCtrl.text)
                                      ? Padding(
                                          padding: const EdgeInsets.symmetric(vertical: AppTheme.elementSpacing),
                                          child: GlassContainer(
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(
                                                  horizontal: AppTheme.elementSpacing, vertical: AppTheme.elementSpacing),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    height: 20,
                                                    width: 20,
                                                    decoration: const BoxDecoration(
                                                      color: Colors.red,
                                                      shape: BoxShape.circle,
                                                    ),
                                                    child: const Center(
                                                      child: Icon(
                                                        Icons.arrow_forward_outlined,
                                                        size: 15,
                                                      ),
                                                    ),
                                                  ),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: [
                                                      Flexible(
                                                        flex: 3,
                                                        child: GestureDetector(
                                                          onTap: () {
                                                            controller.getAddressComponent(
                                                                controller.transactionModel!.vin?[index].prevout!.scriptpubkeyAddress);
                                                            controller.addressId =
                                                                controller.transactionModel!.vin?[index].prevout!.scriptpubkeyAddress ?? '';
                                                            Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder: (context) => const AddressComponent(),
                                                              ),
                                                            );
                                                          },
                                                          child: Text(
                                                            controller.transactionModel!.vin?[index].prevout?.scriptpubkeyAddress == null &&
                                                                    controller.transactionModel!.vin?[index].prevout?.scriptpubkeyType ==
                                                                        "op_return"
                                                                ? 'OP_RETURN (R)'
                                                                : '${controller.transactionModel!.vin?[index].prevout?.scriptpubkeyAddress!.substring(0, 10)}'
                                                                    '... '
                                                                    '${controller.transactionModel!.vin?[index].prevout?.scriptpubkeyAddress!.substring((controller.transactionModel!.vin?[index].prevout?.scriptpubkeyAddress!.length)! - 5)}',
                                                            style: const TextStyle(
                                                              fontSize: 14,
                                                              color: Colors.blue,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Flexible(
                                                        flex: 2,
                                                        child: Container(
                                                          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                                                          decoration: BoxDecoration(
                                                            color: Colors.grey,
                                                            borderRadius: AppTheme.cardRadiusCircular,
                                                          ),
                                                          child: controller.isShowBTC.value
                                                              ? Text(
                                                                  '${controller.isShowBTC.value ? controller.inPutBTC(index) : controller.inPutDollar(index)} BTC',
                                                                  style: const TextStyle(color: Colors.black),
                                                                )
                                                              : Text('\$ ${controller.inPutDollar(index)} ',
                                                                  style: const TextStyle(color: Colors.black)),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  SizedBox(
                                                    child: Row(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Expanded(
                                                          child: Text(L10n.of(context)!.witness, style: AppTheme.textTheme.bodyMedium),
                                                        ),
                                                        Expanded(
                                                          child: Column(
                                                            children: [
                                                              ListView.builder(
                                                                physics: const NeverScrollableScrollPhysics(),
                                                                shrinkWrap: true,
                                                                itemCount: controller.transactionModel!.vin?[index].witness?.length,
                                                                itemBuilder: (context, ind) {
                                                                  return Padding(
                                                                    padding: const EdgeInsets.only(bottom: 10),
                                                                    child: Text(
                                                                        controller.transactionModel?.vin != null
                                                                            ? '${controller.transactionModel?.vin?[index].witness?[ind]}'
                                                                            : '',
                                                                        style: AppTheme.textTheme.bodyMedium),
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
                                                      Text('nSequence', style: AppTheme.textTheme.bodyMedium),
                                                      Text('0x${controller.transactionModel?.vin?[index].sequence?.toRadixString(16)}',
                                                          style: AppTheme.textTheme.bodyMedium)
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Text(L10n.of(context)!.previousOutputScripts, style: AppTheme.textTheme.bodyMedium),
                                                      const SizedBox(
                                                        width: 10,
                                                      ),
                                                      Flexible(
                                                          child: Text('${controller.transactionModel?.vin?[index].prevout?.scriptpubkeyAsm}',
                                                              style: AppTheme.textTheme.bodyMedium))
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Text('Previous output type', style: AppTheme.textTheme.bodyMedium),
                                                      const SizedBox(
                                                        width: 10,
                                                      ),
                                                      Flexible(
                                                          child: Text('${controller.transactionModel?.vin?[index].prevout?.scriptpubkeyType}',
                                                              style: AppTheme.textTheme.bodyMedium))
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        )
                                      : const SizedBox();
                                },
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
}
