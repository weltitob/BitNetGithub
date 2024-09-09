import 'dart:developer';

import 'package:bitnet/backbone/helper/currency/getcurrency.dart';
import 'package:bitnet/backbone/helper/helpers.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/streams/currency_provider.dart';
import 'package:bitnet/backbone/streams/currency_type_provider.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetListTile.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/container/imagewithtext.dart';
import 'package:bitnet/components/dialogsandsheets/bottom_sheets/bit_net_bottom_sheet.dart';
import 'package:bitnet/components/dialogsandsheets/notificationoverlays/overlay.dart';
import 'package:bitnet/components/items/transactionitem.dart';
import 'package:bitnet/models/bitcoin/transactiondata.dart';
import 'package:bitnet/pages/transactions/controller/transaction_controller.dart';
import 'package:bitnet/pages/wallet/controllers/wallet_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class LoopTransactionScreen extends GetWidget<WalletsController> {
  final TransactionItemData transactionItemData;
  const LoopTransactionScreen({super.key, required this.transactionItemData});

  @override
  Widget build(BuildContext context) {
    log('This is the loop transaction screen now');
    final String formattedDate = displayTimeAgoFromInt(transactionItemData.timestamp);
    final String time = convertIntoDateFormat(transactionItemData.timestamp);
    final chartLine = Get.find<WalletsController>().chartLines.value;
    String? currency = Provider.of<CurrencyChangeProvider>(context).selectedCurrency;
    final coin = Provider.of<CurrencyTypeProvider>(context, listen: true);
    print('cooin ${coin.coin}');
    currency = currency ?? "USD";
    final TransactionController transactionController = Get.put(TransactionController());
    final bitcoinPrice = chartLine?.price;
    final currencyEquivalent =
        bitcoinPrice != null ? (double.parse(transactionItemData.amount) / 100000000 * bitcoinPrice).toStringAsFixed(2) : "0.00";
    final currencyEquivalentFee =
        bitcoinPrice != null ? (transactionItemData.fee.toDouble() / 100000000 * bitcoinPrice).toStringAsFixed(2) : "0.00";
    return bitnetScaffold(
        context: context,
        extendBodyBehindAppBar: true,
        appBar: bitnetAppBar(
          context: context,
          text: 'Loop Transaction',
          onTap: () {
            Navigator.pop(context);
          },
        ),
        body: Obx(() {
          Get.find<WalletsController>().chartLines.value;
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: AppTheme.cardPadding * 3,
                ),
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
                              Image.asset(
                                'assets/images/bitcoin.png',
                                width: AppTheme.cardPadding * 4,
                              ),
                              const SizedBox(
                                width: AppTheme.cardPadding * 0.75,
                              ),
                              Transform.rotate(
                                angle: transactionItemData.type == TransactionType.loopOut ? 3.14 : 0,
                                child: Icon(
                                  Icons.double_arrow_rounded,
                                  size: AppTheme.cardPadding * 2.5,
                                  color: Theme.of(context).brightness == Brightness.dark ? AppTheme.white80 : AppTheme.black60,
                                ),
                              ),
                              const SizedBox(
                                width: AppTheme.cardPadding * 0.75,
                              ),
                              Image.asset(
                                'assets/images/lightning.png',
                                width: AppTheme.cardPadding * 4,
                              ),
                            ],
                          ),
                          const SizedBox(height: AppTheme.cardPadding * 0.75),
                          controller.hideBalance.value
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
                                              ? '${transactionController.formatPrice(transactionItemData.amount)}'
                                              : "${currencyEquivalent} ${getCurrency(currency!)}",
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
                const SizedBox(height: AppTheme.elementSpacing),
                BitNetListTile(
                    text: 'TransactionID',
                    trailing: GestureDetector(
                      onTap: () async {
                        await Clipboard.setData(ClipboardData(
                          text: transactionItemData.txHash,
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
                              transactionItemData.txHash,
                              style: Theme.of(context).textTheme.bodyMedium,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    )),
                BitNetListTile(
                  text: 'Status',
                  trailing: Row(
                    children: [
                      transactionItemData.status == TransactionStatus.pending
                          ? Positioned(
                              top: 0,
                              right: 10,
                              child: Transform.scale(
                                scale: 1.1,
                                child: GestureDetector(
                                  onTap: () {
                                    controller.showInfo.value = !controller.showInfo.value;
                                    BitNetBottomSheet(
                                      context: context,
                                      child: bitnetScaffold(
                                        extendBodyBehindAppBar: true,
                                        appBar: bitnetAppBar(
                                          context: context,
                                          text: 'Info',
                                        ),
                                        context: context,
                                        body: Padding(
                                          padding: const EdgeInsets.only(
                                              top: AppTheme.cardPaddingBigger * 5,
                                              left: AppTheme.cardPaddingBig,
                                              right: AppTheme.cardPaddingBig),
                                          child: Text(
                                            'When the lightning invoice wont get trough the payment will be canceled and the user will receive the funds back',
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.center,
                                            maxLines: 3,
                                            style: Theme.of(context).textTheme.titleMedium!,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    alignment: Alignment.topRight,
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppTheme.black60,
                                    ),
                                    child: Center(
                                      child: Icon(
                                        controller.showInfo.value ? Icons.info : Icons.info_outline,
                                        color: AppTheme.white60,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : const SizedBox.shrink(),
                      SizedBox(
                        width: 10.w,
                      ),
                      Container(
                        height: AppTheme.cardPadding * 1.5,
                        padding: const EdgeInsets.symmetric(horizontal: AppTheme.elementSpacing),
                        decoration: BoxDecoration(
                          borderRadius: AppTheme.cardRadiusCircular,
                          color: transactionItemData.status == TransactionStatus.confirmed
                              ? AppTheme.successColor
                              : transactionItemData.status == TransactionStatus.pending
                                  ? AppTheme.colorBitcoin
                                  : AppTheme.errorColor,
                        ),
                        child: Center(
                          child: Text(
                            transactionItemData.status == TransactionStatus.confirmed
                                ? 'Received'
                                : transactionItemData.status == TransactionStatus.pending
                                    ? 'Pending'
                                    : 'Error',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                BitNetListTile(
                  text: "Payment Network",
                  trailing: transactionItemData.type == TransactionType.onChain
                      ? Image.asset(
                          "assets/images/bitcoin.png",
                          width: AppTheme.cardPadding * 1.5,
                          height: AppTheme.cardPadding * 1.5,
                        )
                      : Row(
                          children: [
                            Image.asset("assets/images/lightning.png", width: AppTheme.cardPadding * 1, height: AppTheme.cardPadding * 1),
                            const Text('  ↔  '),
                            Image.asset(
                              "assets/images/bitcoin.png",
                              width: AppTheme.cardPadding * 1,
                              height: AppTheme.cardPadding * 1,
                            )
                          ],
                        ),
                ),
                BitNetListTile(
                    text: 'Time',
                    trailing: Text(
                      "${time} "
                      "(${formattedDate})",
                      style: Theme.of(context).textTheme.bodyLarge,
                    )),
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
                            coin.coin ?? true ? '${transactionItemData.fee}' : "$currencyEquivalentFee ${getCurrency(currency!)}",
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                        coin.coin ?? true ? Icon(AppTheme.satoshiIcon) : const SizedBox.shrink(),
                      ],
                    )),
              ],
            ),
          );
        }));
  }
}
