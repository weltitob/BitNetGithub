//address component

import 'dart:math' as math;

import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/services/timezone_provider.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetListTile.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/dialogsandsheets/bottom_sheets/bit_net_bottom_sheet.dart';
import 'package:bitnet/components/dialogsandsheets/notificationoverlays/overlay.dart';
import 'package:bitnet/components/fields/searchfield/searchfield.dart';
import 'package:bitnet/components/items/balancecard.dart';
import 'package:bitnet/components/items/transactionitem.dart';
import 'package:bitnet/components/loaders/loaders.dart';
import 'package:bitnet/models/bitcoin/transactiondata.dart';
import 'package:bitnet/models/currency/bitcoinunitmodel.dart';
import 'package:bitnet/pages/secondpages/mempool/controller/home_controller.dart';
import 'package:bitnet/pages/transactions/controller/transaction_controller.dart';
import 'package:bitnet/pages/transactions/view/single_transaction_screen.dart';
import 'package:bitnet/pages/wallet/component/wallet_filter_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:bitnet/intl/generated/l10n.dart';
import 'package:provider/provider.dart';
import 'package:timezone/timezone.dart';

class AddressComponent extends StatelessWidget {
  const AddressComponent({super.key});
  final bool isShowMore = false;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TransactionController());
    final overlayController = Get.find<OverlayController>();
    Location loc =
        Provider.of<TimezoneProvider>(context, listen: false).timeZone;

    return bitnetScaffold(
        context: context,
        extendBodyBehindAppBar: true,
        appBar: bitnetAppBar(
          context: context,
          onTap: () {
            Navigator.pop(context);
          },
        ),
        body: Obx(
          () => controller.isLoadingAddress.value
              ? Center(
                  child: dotProgress(context),
                )
              : Padding(
                  padding: const EdgeInsets.only(top: 60.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          height: 200,
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Obx(() {
                            return BalanceCardBtc(
                              balance:
                                  '${(((controller.addressComponentModel?.chainStats.fundedTxoSum)! / 100000000 + (controller.addressComponentModel?.mempoolStats.fundedTxoSum)! / 100000000) - ((controller.addressComponentModel?.chainStats.spentTxoSum)! / 100000000 + (controller.addressComponentModel?.mempoolStats.spentTxoSum)! / 100000000)).toStringAsFixed(8)}',
                              unconfirmedBalance: '',
                              confirmedBalance: '',
                              defaultUnit: BitcoinUnits
                                  .SAT, // You can adjust this as needed
                            );
                          }),
                        ),
                        BitNetListTile(
                          text: L10n.of(context)!.address,
                          trailing: Row(
                            children: [
                              Text(
                                '${controller.addressId.substring(0, 8)}.....' +
                                    '${controller.addressId.substring(controller.addressId.length - 8)}',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              IconButton(
                                onPressed: () async {
                                  await Clipboard.setData(ClipboardData(
                                    text: controller.addressId,
                                  ));
                                  overlayController.showOverlay(
                                      L10n.of(context)!.copiedToClipboard);
                                },
                                icon: Icon(
                                  Icons.copy,
                                  color: AppTheme.white60,
                                ),
                              )
                            ],
                          ),
                        ),
                        BitNetListTile(
                          text: L10n.of(context)!.qrCode,
                          trailing: Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(
                                  AppTheme.cardPadding / 1.25),
                              //margin: const EdgeInsets.all(AppTheme.cardPadding),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: AppTheme.cardRadiusBigger),
                              child: PrettyQrView.data(
                                  data: "${controller.addressId}",
                                  decoration: const PrettyQrDecoration(
                                    shape: PrettyQrSmoothSymbol(
                                      roundFactor: 1,
                                    ),
                                  )),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        BitNetListTile(
                          text: L10n.of(context)!.totalReceived,
                          trailing: Row(
                            children: [
                              Text(
                                '${((controller.addressComponentModel?.chainStats.fundedTxoSum)! / 100000000 + (controller.addressComponentModel?.mempoolStats.fundedTxoSum)! / 100000000).toStringAsFixed(8)} BTC',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        BitNetListTile(
                          text: L10n.of(context)!.totalSent,
                          trailing: Row(
                            children: [
                              Text(
                                '${((controller.addressComponentModel?.chainStats.spentTxoSum)! / 100000000 + (controller.addressComponentModel?.mempoolStats.spentTxoSum)! / 100000000).toStringAsFixed(8)} BTC',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        BitNetListTile(
                          text: L10n.of(context)!.balance,
                          trailing: Row(
                            children: [
                              Text(
                                '${(((controller.addressComponentModel?.chainStats.fundedTxoSum)! / 100000000 + (controller.addressComponentModel?.mempoolStats.fundedTxoSum)! / 100000000) - ((controller.addressComponentModel?.chainStats.spentTxoSum)! / 100000000 + (controller.addressComponentModel?.mempoolStats.spentTxoSum)! / 100000000)).toStringAsFixed(8)} BTC',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                '\$${((((controller.addressComponentModel?.chainStats.fundedTxoSum)! / 100000000 + (controller.addressComponentModel?.mempoolStats.fundedTxoSum)! / 100000000) - ((controller.addressComponentModel?.chainStats.spentTxoSum)! / 100000000 + (controller.addressComponentModel?.mempoolStats.spentTxoSum)! / 100000000)) * controller.currentUSD.value).toStringAsFixed(2)}',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(color: Colors.green),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        StatefulBuilder(builder: (context, setState) {
                          return Column(
                            children: [
                              SearchFieldWidget(
                                hintText: L10n.of(context)!.search,
                                handleSearch: (v) {
                                  setState(() {
                                    controller.searchValue = v;
                                  });
                                },
                                suffixIcon: IconButton(
                                    icon: const Icon(FontAwesomeIcons.filter),
                                    onPressed: () async {
                                      await BitNetBottomSheet(
                                          context: context,
                                          child: const WalletFilterScreen());
                                      setState(() {});
                                    }),
                                isSearchEnabled: true,
                              ),
                              Obx(() {
                                return controller.subTransactionModel.isEmpty
                                    ? Text(L10n.of(context)!.loading)
                                    : ListView.builder(
                                        shrinkWrap: true,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12.0),
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: controller
                                            .subTransactionModel.length,
                                        itemBuilder: (context, index) {
                                          final homeController =
                                              Get.find<HomeController>();
                                          int confirmation = 0;
                                          int height = controller
                                                  .subTransactionModel[index]
                                                  .status!
                                                  .blockHeight ??
                                              0;
                                          int chainTip = homeController
                                                  .bitcoinData.first.height ??
                                              0;
                                          confirmation = math.max(
                                              1, chainTip - height + 1);
                                          num bitCoin = controller
                                                  .subTransactionModel[index]
                                                  .fee! /
                                              100000000;
                                          String feeUsd = (bitCoin * usdPrice)
                                              .toStringAsFixed(2);
                                          String time = controller
                                                      .subTransactionModel[
                                                          index]
                                                      .status!
                                                      .blockTime ==
                                                  null
                                              ? ''
                                              : DateTime.fromMillisecondsSinceEpoch(
                                                      controller
                                                              .subTransactionModel[
                                                                  index]
                                                              .status!
                                                              .blockTime!
                                                              .toInt() *
                                                          1000)
                                                  .toUtc()
                                                  .add(Duration(
                                                      milliseconds: loc
                                                          .currentTimeZone
                                                          .offset))
                                                  .toString();
                                          int value = controller
                                              .calculateAddressValue(controller
                                                  .subTransactionModel[index]);
                                          if (controller
                                                  .subTransactionModel[index]
                                                  .status!
                                                  .blockTime !=
                                              null) {
                                            List<String> date = time.split(" ");
                                            String singleDate = date[0];
                                            String times = date[1];
                                            List<String> splitTime =
                                                times.split(":");

                                            String hour = splitTime[0];
                                            String min = splitTime[1];
                                            time = '$singleDate $hour:$min';
                                          }
                                          return controller
                                                  .subTransactionModel[index]
                                                  .txid!
                                                  .contains(
                                                      controller.searchValue)
                                              ? InkWell(
                                                  onTap: () async {
                                                    controller.txID = controller
                                                        .subTransactionModel[
                                                            index]
                                                        .txid!;
                                                    Get.to(
                                                        const SingleTransactionScreen(),
                                                        arguments: controller
                                                            .subTransactionModel[
                                                                index]
                                                            .txid);
                                                    await controller
                                                        .getSingleTransaction(
                                                            controller
                                                                .subTransactionModel[
                                                                    index]
                                                                .txid!);
                                                  },
                                                  child: TransactionItem(
                                                      data: TransactionItemData(
                                                    timestamp: controller
                                                            .subTransactionModel[
                                                                index]
                                                            .locktime ??
                                                        0,
                                                    type:
                                                        TransactionType.onChain,
                                                    direction:
                                                        TransactionDirection
                                                            .received,
                                                    receiver: controller
                                                        .subTransactionModel[
                                                            index]
                                                        .txid
                                                        .toString(),
                                                    txHash: controller
                                                        .subTransactionModel[
                                                            index]
                                                        .hashCode
                                                        .toString(),
                                                    amount: '0',
                                                    fee: controller
                                                            .subTransactionModel[
                                                                index]
                                                            .fee ??
                                                        0,
                                                    status: controller
                                                                .subTransactionModel[
                                                                    index]
                                                                .status
                                                                ?.confirmed ??
                                                            false
                                                        ? TransactionStatus
                                                            .confirmed
                                                        : TransactionStatus
                                                            .failed,

                                                    // other properties
                                                  )),
                                                )
                                              : const SizedBox();
                                        });
                              }),
                            ],
                          );
                        }),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
        ));
  }
}
