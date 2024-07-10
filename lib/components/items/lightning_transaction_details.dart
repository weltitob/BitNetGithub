import 'package:bitnet/backbone/helper/currency/getcurrency.dart';
import 'package:bitnet/backbone/helper/helpers.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/streams/currency_provider.dart';
import 'package:bitnet/backbone/streams/currency_type_provider.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetListTile.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/appstandards/mydivider.dart';
import 'package:bitnet/components/container/avatar.dart';
import 'package:bitnet/components/dialogsandsheets/bottom_sheets/bit_net_bottom_sheet.dart';
import 'package:bitnet/components/items/transactionitem.dart';
import 'package:bitnet/models/bitcoin/transactiondata.dart';
import 'package:bitnet/pages/wallet/controllers/wallet_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class LightningTransactionDetails extends GetWidget<WalletsController> {
  final TransactionItemData data;
  final TextEditingController inputCtrl = TextEditingController();
  final TextEditingController outputCtrl = TextEditingController();

  LightningTransactionDetails({required this.data, super.key});

  @override
  Widget build(BuildContext context) {
    final String formattedDate = displayTimeAgoFromInt(data.timestamp);
    final String time = convertIntoDateFormat(data.timestamp);
    final chartLine = Get.find<WalletsController>().chartLines.value;
    String? currency =
        Provider.of<CurrencyChangeProvider>(context).selectedCurrency;
    final coin = Provider.of<CurrencyTypeProvider>(context, listen: true);
    print('cooin ${coin.coin}');
    currency = currency ?? "USD";

    final bitcoinPrice = chartLine?.price;
    final currencyEquivalent = bitcoinPrice != null
        ? (double.parse(data.amount) / 100000000 * bitcoinPrice)
            .toStringAsFixed(2)
        : "0.00";
    final currencyEquivalentFee = bitcoinPrice != null
        ? (data.fee.toDouble() / 100000000 * bitcoinPrice).toStringAsFixed(2)
        : "0.00";
    return bitnetScaffold(
        context: context,
        extendBodyBehindAppBar: true,
        appBar: bitnetAppBar(
          context: context,
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
                SizedBox(
                  height: AppTheme.cardPadding * 3,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Avatar(
                      size: AppTheme.cardPadding * 4.75,
                    ),
                    SizedBox(
                      width: AppTheme.elementSpacing,
                    ),
                    Icon(
                      Icons.double_arrow_rounded,
                      size: AppTheme.cardPadding * 3,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? AppTheme.white80
                          : AppTheme.black60,
                    ),
                    SizedBox(
                      width: AppTheme.elementSpacing,
                    ),
                    Avatar(
                      size: AppTheme.cardPadding * 4.75,
                    ),
                  ],
                ),
                SizedBox(height: AppTheme.cardPadding),
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
                              coin.setCurrencyType(
                                  coin.coin != null ? !coin.coin! : false);
                            },
                            child: Row(
                              children: [
                                Text(
                                  coin.coin ?? true
                                      ? data.amount
                                      : "$currencyEquivalent",
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayLarge!
                                      .copyWith(
                                          color: data.direction ==
                                                  TransactionDirection.received
                                              ? AppTheme.successColor
                                              : AppTheme.errorColor),
                                ),
                                Text(
                                  '${getCurrency(currency!)}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayLarge!
                                      .copyWith(color: Colors.grey),
                                )
                              ],
                            ),
                          ),
                          coin.coin ?? true
                              ? Icon(
                                  AppTheme.satoshiIcon,
                                  color: data.direction ==
                                          TransactionDirection.received
                                      ? AppTheme.successColor
                                      : AppTheme.errorColor,
                                )
                              : SizedBox.shrink(),
                        ],
                      ),
                SizedBox(height: AppTheme.elementSpacing),
                Text(formattedDate,
                    style: Theme.of(context).textTheme.bodyLarge),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppTheme.cardPadding * 2),
                  child: Row(
                    children: [
                      Flexible(
                        child: Text(
                          data.txHash,
                          style: Theme.of(context).textTheme.bodyMedium,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      IconButton(
                          onPressed: () async {
                            await Clipboard.setData(ClipboardData(
                              text: data.txHash,
                            ));
                            Get.snackbar('Copied', data.txHash);
                          },
                          icon: const Icon(Icons.copy))
                    ],
                  ),
                ),
                SizedBox(height: AppTheme.cardPadding * 1),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: AppTheme.elementSpacing),
                  child: MyDivider(),
                ),
                BitNetListTile(
                  text: 'Status',
                  trailing: Row(
                    children: [
                      data.status == TransactionStatus.pending
                          ? Positioned(
                              top: 0,
                              right: 10,
                              child: Transform.scale(
                                scale: 1.1,
                                child: GestureDetector(
                                  onTap: () {
                                    controller.showInfo.value =
                                        !controller.showInfo.value;
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
                                              top: AppTheme.cardPaddingBigger *
                                                  5,
                                              left: AppTheme.cardPaddingBig,
                                              right: AppTheme.cardPaddingBig),
                                          child: Text(
                                            'When the lightning invoice wont get trough the payment will be canceled and the user will receive the funds back',
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.center,
                                            maxLines: 3,
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleMedium!,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    alignment: Alignment.topRight,
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppTheme.black60,
                                    ),
                                    child: Center(
                                      child: Icon(
                                        controller.showInfo.value
                                            ? Icons.info
                                            : Icons.info_outline,
                                        color: AppTheme.white60,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : SizedBox.shrink(),
                      SizedBox(
                        width: 10.w,
                      ),
                      Container(
                        height: AppTheme.cardPadding * 1.5,
                        padding: const EdgeInsets.symmetric(
                            horizontal: AppTheme.elementSpacing),
                        decoration: BoxDecoration(
                          borderRadius: AppTheme.cardRadiusCircular,
                          color: data.status == TransactionStatus.confirmed
                              ? AppTheme.successColor
                              : data.status == TransactionStatus.pending
                                  ? AppTheme.colorBitcoin
                                  : AppTheme.errorColor,
                        ),
                        child: Center(
                          child: Text(
                            data.status == TransactionStatus.confirmed
                                ? 'Received'
                                : data.status == TransactionStatus.pending
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
                  trailing: data.type == TransactionType.onChain
                      ? Image.asset(
                          "assets/images/bitcoin.png",
                          width: AppTheme.cardPadding * 1.5,
                          height: AppTheme.cardPadding * 1.5,
                        )
                      : Row(
                          children: [
                            Image.asset("assets/images/lightning.png",
                                width: AppTheme.cardPadding * 1,
                                height: AppTheme.cardPadding * 1),
                            Text('  ↔  '),
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
                      "${time}",
                      style: Theme.of(context).textTheme.bodyLarge,
                    )),
                BitNetListTile(
                    text: 'Fee',
                    trailing: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            coin.setCurrencyType(
                                coin.coin != null ? !coin.coin! : false);
                          },
                          child: Text(
                            coin.coin ?? true
                                ? '${data.fee}'
                                : "$currencyEquivalentFee${getCurrency(currency!)}",
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ),
                        coin.coin ?? true
                            ? Icon(AppTheme.satoshiIcon)
                            : SizedBox.shrink(),
                      ],
                    )),
              ],
            ),
          );
        }));
  }
}
