import 'dart:math' as math;

import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetListTile.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/dialogsandsheets/bottom_sheets/bit_net_bottom_sheet.dart';
import 'package:bitnet/components/fields/searchfield/searchfield.dart';
import 'package:bitnet/components/items/balancecard.dart';
import 'package:bitnet/components/items/transactionitem.dart';
import 'package:bitnet/models/bitcoin/transactiondata.dart';
import 'package:bitnet/pages/secondpages/mempool/controller/home_controller.dart';
import 'package:bitnet/pages/transactions/controller/transaction_controller.dart';
import 'package:bitnet/pages/transactions/view/single_transaction_screen.dart';
import 'package:bitnet/pages/wallet/component/wallet_filter_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

class BitcoinCardInformationScreen extends StatefulWidget {
  BitcoinCardInformationScreen({super.key});

  @override
  State<BitcoinCardInformationScreen> createState() =>
      _BitcoinCardInformationScreenState();
}

class _BitcoinCardInformationScreenState
    extends State<BitcoinCardInformationScreen> {
  bool isShowMore = false;
  final controller = Get.put(TransactionController());

  @override
  void initState() {
    controller.getAddressComponent(
        'bc1p5lfahjz2j3679ynqy4fu8tvteem92fuqfqfsax7vx97lyr3vhkwqlxjh5e');
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return bitnetScaffold(
      extendBodyBehindAppBar: true,
      appBar: bitnetAppBar(
        context: context,
        onTap: () {
          context.go("/feed");
        },
        text: "Bitcoin Card Information",
      ),
      context: context,
      body: PopScope(
        canPop: false,
        onPopInvoked: (v) {
          context.go("/feed");
        },
        child: Obx(
          () => controller.isLoadingAddress.value
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Padding(
                  padding: const EdgeInsets.only(top: 60.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                            height: 200,
                            padding: EdgeInsets.symmetric(horizontal: 12.0),
                            child: BalanceCardBtc()),
                        BitNetListTile(
                          text: 'Address',
                          trailing: Text('bc1qkmlp...' + '30fltzunefdjln', style: Theme.of(context).textTheme.bodyMedium),
                        ),
                        BitNetListTile(
                          text: 'QRCode',
                          trailing: Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(
                                  AppTheme.cardPadding / 1.25),
                              //margin: const EdgeInsets.all(AppTheme.cardPadding),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: AppTheme.cardRadiusBigger),
                              child: PrettyQrView.data(
                                  data:
                                      "bc1qkmlpuea96ekcjlk2wpjhsrr030fltzunefdjln",
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
                          text: 'Total Received',
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
                          text: 'Total Sent',
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
                          text: 'Balance',
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
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.green),
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
                                hintText: 'Search',
                                handleSearch: (v) {
                                  setState(() {
                                    controller.searchValue = v;
                                  });
                                },
                                suffixIcon: IconButton(
                                    icon: Icon(FontAwesomeIcons.filter),
                                    onPressed: () async {
                                      await BitNetBottomSheet(
                                          context: context,
                                          child: WalletFilterScreen());
                                      setState(() {});
                                    }),
                                isSearchEnabled: true,
                              ),
                              Obx(() {
                                return controller.subTransactionModel.isEmpty
                                    ? const Text('Loading')
                                    : ListView.builder(
                                        shrinkWrap: true,
                                        padding: EdgeInsets.symmetric(
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
                                                  .toString();
                                          int value = controller
                                              .calculateAddressValue(controller
                                                  .subTransactionModel[index]);
                                          print('difference $value');
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
                                                      context: context,
                                                      data: TransactionItemData(
                                                        timestamp: controller
                                                            .subTransactionModel[
                                                        index].locktime ?? 0,
                                                        type: TransactionType.onChain,
                                                        direction: TransactionDirection.received,
                                                        receiver: controller
                                                            .subTransactionModel[
                                                        index].txid.toString(),
                                                        txHash: controller
                                                          .subTransactionModel[
                                                          index].hashCode.toString(),
                                                        amount: '0',
                                                        fee: controller
                                                            .subTransactionModel[
                                                        index].fee ?? 0,
                                                        status: controller
                                                            .subTransactionModel[
                                                        index].status?.confirmed ?? false
                                                            ? TransactionStatus.confirmed
                                                            : TransactionStatus.failed,

                                                        // other properties
                                                      )),
                                                )
                                              : SizedBox();
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
        ),
      ),
    );
  }
}
