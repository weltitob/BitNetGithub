import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/fields/searchfield/searchfield.dart';
import 'package:bitnet/pages/secondpages/mempool/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:number_paginator/number_paginator.dart';

class UnacceptedBlockTransactions extends StatefulWidget {
  const UnacceptedBlockTransactions({super.key});

  @override
  State<UnacceptedBlockTransactions> createState() => _UnacceptedBlockTransactionsState();
}

class _UnacceptedBlockTransactionsState extends State<UnacceptedBlockTransactions> {
  final controller = Get.put(HomeController());
  final NumberPaginatorController _controller = NumberPaginatorController();
  int _currentPage = 0;
  String selectedOption = 'Transaction';
  final TextFieldController = TextEditingController();
  handleSearch(String query) {}

  @override
  Widget build(BuildContext context) {
    return bitnetScaffold(
      appBar: bitnetAppBar(
        text: 'Block Transactions',
        context: context,
        onTap: () {
          Navigator.of(context).pop();
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SearchFieldWidget(
              onChanged: (value) {
                controller.isLoadingTx.value = true;
                if (value.isEmpty) {
                  controller.txDetails = controller.txDetailsReset;
                } else {
                  controller.txDetails.clear;
                  controller.txDetails = controller.txDetailsFound
                      .where((element) => element.txid == value)
                      .toList();
                }
                controller.isLoadingTx.value = false;
              },
              hintText:
              '${controller.blockTransactions.length} transactions',
              handleSearch: handleSearch,
              isSearchEnabled: true,
            ),
            // NumberPaginator(
            //   numberPages: controller.blockTransactions.length ~/
            //       25,
            //   onPageChange: (int index) {
            //     setState(() {
            //       _currentPage = index;
            //       controller.blockTransactions[index * 5];
            //       // controller.txDetailsF(
            //       //     controller.bitcoinData[controller.indexBlock.value].id!,
            //       //     index * 25);
            //     });
            //   },
            //   showPrevButton: true,
            //   showNextButton: true,
            //   nextButtonContent: const Icon(
            //     Icons.arrow_right_alt,
            //     color: Colors.white,
            //   ),
            // ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                      'TXID',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: Text(
                      'Amount',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: Text(
                      'USD',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: Text(
                      'Fee',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            controller.isLoadingTx.value
                ? const Center(
              child: CircularProgressIndicator(),
            )
                : controller.blockTransactions.isEmpty
                ? const SizedBox()
                : ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.blockTransactions.length,
                itemBuilder: (context, index) {
                  double btcValue =
                      controller.blockTransactions[index][1] / 100000000;
                  double usdValue = btcValue * usdPrice;
                  double feeSatVb = controller.blockTransactions[index][2] /
                      controller.blockTransactions[index][3];
                  return Row(
                    children: [
                      Expanded(
                        flex:2,
                        child: GestureDetector(
                          onTap: () async {
                            await Clipboard.setData(ClipboardData(
                              text: controller.blockTransactions[index][0],
                            ));
                            // Get.snackbar('Copied',
                            //     controller.txDetails[index].txid);
                          },
                          child: Text(
                            controller.blockTransactions.isEmpty
                                ? ''
                                : '${controller.blockTransactions[index][0].substring(0, 10)}...${controller.blockTransactions[index][0].substring(controller.blockTransactions[index][0].length - 10)}',
                            style: TextStyle(
                              color: Colors.blue.shade400,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                          child: Text(
                              '${(controller.blockTransactions[index][1] / 100000000).toStringAsFixed(8)} BTC' ??
                                  '')),
                      const SizedBox(width: 20),
                      Expanded(
                          child: Text(
                              '\$${formatPriceDecimal(btcValue * usdPrice)}' ??
                                  '')),
                      const SizedBox(width: 20),
                      Expanded(
                          child: Text(
                              '\$${(controller.blockTransactions[index][2] /
                                   100000000 * controller.currentUSD.value).toStringAsFixed(2)}' ??
                                  '')),

                    ],
                  );
                }),
            // NumberPaginator(
            //   numberPages: controller
            //       .bitcoinData[controller.indexBlock.value].txCount! ~/
            //       25,
            //   onPageChange: (int index) {
            //     setState(() {
            //       _currentPage = index;
            //       controller.txDetailsF(
            //           controller.bitcoinData[controller.indexBlock.value].id!,
            //           index * 25);
            //     });
            //   },
            //   showPrevButton: true,
            //   showNextButton: true,
            //   nextButtonContent: const Icon(
            //     Icons.arrow_right_alt,
            //     color: Colors.white,
            //   ),
            // ),
          ],
        ),
      ),
      context: context,
    );
  }
}
