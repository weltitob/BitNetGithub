import 'package:bitnet/backbone/helper/currency/getcurrency.dart';
import 'package:bitnet/backbone/helper/helpers.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/streams/currency_provider.dart';
import 'package:bitnet/backbone/streams/currency_type_provider.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetListTile.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/appstandards/mydivider.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/container/avatar.dart';
import 'package:bitnet/components/container/imagewithtext.dart';
import 'package:bitnet/components/dialogsandsheets/bottom_sheets/bit_net_bottom_sheet.dart';
import 'package:bitnet/components/items/transactionitem.dart';
import 'package:bitnet/models/bitcoin/chartline.dart';
import 'package:bitnet/models/bitcoin/transactiondata.dart';
import 'package:bitnet/pages/secondpages/mempool/controller/home_controller.dart';
import 'package:bitnet/pages/transactions/controller/transaction_controller.dart';
import 'package:bitnet/pages/transactions/view/address_component.dart';
import 'package:bitnet/pages/wallet/controllers/wallet_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class LightningTransactionDetails extends GetWidget<WalletsController> {
  final TransactionItemData data;
  final bool onChain;
  LightningTransactionDetails(
      {required this.data, required this.onChain, super.key});

  @override
  Widget build(BuildContext context) {
    final controllerTransaction = Get.put(TransactionController());
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
            if (onChain) {
              controllerTransaction.timer?.cancel();
              controllerTransaction.timerLatest?.cancel();
              controllerTransaction.timerTime?.cancel();
              channel.sink.add('{"track-rbf-summary":true}');
              channel.sink.add('{"track-tx":"stop"}');
              channel.sink
                  .add('{"action":"want","data":["blocks","mempool-blocks"]}');

              Navigator.pop(context);
              controllerTransaction.homeController.isRbfTransaction.value =
                  false;
            } else {
              Navigator.pop(context);
            }
          },
        ),
        body: PopScope(
          canPop: true,
          onPopInvoked: (bool didPop) {
            if (onChain) {
              controllerTransaction.timer?.cancel();
              controllerTransaction.timerLatest?.cancel();
              controllerTransaction.timerTime?.cancel();
              channel.sink.add('{"track-rbf-summary":true}');
              channel.sink.add('{"track-tx":"stop"}');
              channel.sink
                  .add('{"action":"want","data":["blocks","mempool-blocks"]}');
              controllerTransaction.homeController.isRbfTransaction.value =
                  false;
            }
          },
          child: Obx(() {
            Get.find<WalletsController>().chartLines.value;
            return Column(
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
                      onTap: () {
                        if(onChain){
                        BitNetBottomSheet(
                            context: context,
                            child: Obx(() {
                              return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0, vertical: 12.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('Inputs\n',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headlineMedium),
                                          LongButtonWidget(
                                              customWidth: 200,
                                              customHeight: 40,
                                              title: !controllerTransaction
                                                      .showDetail.value
                                                  ? 'Show Details'
                                                  : 'Hide Details',
                                              onTap: () {
                                                controllerTransaction
                                                    .toggleExpansion();
                                              })
                                        ],
                                      ),
                                      !controllerTransaction.showDetail.value
                                          ? Expanded(
                                              child: ListView.builder(
                                                physics:
                                                    const AlwaysScrollableScrollPhysics(),
                                                shrinkWrap: true,
                                                itemCount: controllerTransaction
                                                    .transactionModel
                                                    ?.vin
                                                    ?.length,
                                                itemBuilder: (context, index) {
                                                  double value =
                                                      (controllerTransaction
                                                              .transactionModel!
                                                              .vin![index]
                                                              .prevout!
                                                              .value!) /
                                                          100000000;
                                                  controllerTransaction
                                                          .input.value =
                                                      double.parse(value
                                                          .toStringAsFixed(8));
                                                  return Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        vertical: 8.0),
                                                    child: GlassContainer(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Container(
                                                              height: 20,
                                                              width: 20,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color:
                                                                    Colors.red,
                                                                shape: BoxShape
                                                                    .circle,
                                                              ),
                                                              child:
                                                                  const Center(
                                                                      child:
                                                                          Icon(
                                                                Icons
                                                                    .arrow_forward_outlined,
                                                                size: 15,
                                                              )),
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Flexible(
                                                                  flex: 2,
                                                                  child:
                                                                      GestureDetector(
                                                                    onTap: () {
                                                                      controllerTransaction.getAddressComponent(controllerTransaction
                                                                          .transactionModel!
                                                                          .vin?[
                                                                              index]
                                                                          .prevout!
                                                                          .scriptpubkeyAddress);
                                                                      controllerTransaction
                                                                          .addressId = controllerTransaction
                                                                              .transactionModel!
                                                                              .vin?[index]
                                                                              .prevout!
                                                                              .scriptpubkeyAddress ??
                                                                          '';
                                                                      Navigator.push(
                                                                          context,
                                                                          MaterialPageRoute(
                                                                              builder: (context) => AddressComponent()));

                                                                      // Get.to(() =>
                                                                      //     AddressComponent());
                                                                    },
                                                                    child: Text(
                                                                      controllerTransaction.transactionModel!.vin?[index].prevout?.scriptpubkeyAddress == null &&
                                                                              controllerTransaction.transactionModel!.vin?[index].prevout?.scriptpubkeyType == "op_return"
                                                                          ? 'OP_RETURN (R)'
                                                                          : '${controllerTransaction.transactionModel!.vin?[index].prevout?.scriptpubkeyAddress!.substring(0, 10)}'
                                                                              '... '
                                                                              '${controllerTransaction.transactionModel!.vin?[index].prevout?.scriptpubkeyAddress!.substring((controllerTransaction.transactionModel!.vin?[index].prevout?.scriptpubkeyAddress!.length)! - 5)}',
                                                                      style:
                                                                          const TextStyle(
                                                                        fontSize:
                                                                            14,
                                                                        color: Colors
                                                                            .blue,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                controllerTransaction
                                                                        .isShowBTC
                                                                        .value
                                                                    ? Text(
                                                                        '${controllerTransaction.inPutBTC(index)} BTC',
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.black),
                                                                      )
                                                                    : Text(
                                                                        '\$ ${controllerTransaction.inPutDollar(index)} ',
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.black))
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                            )
                                          : Expanded(
                                              child: ListView.builder(
                                                physics:
                                                    const AlwaysScrollableScrollPhysics(),
                                                shrinkWrap: true,
                                                itemCount: controllerTransaction
                                                    .transactionModel
                                                    ?.vin
                                                    ?.length,
                                                itemBuilder: (context, index) {
                                                  double value =
                                                      (controllerTransaction
                                                              .transactionModel!
                                                              .vin![index]
                                                              .prevout!
                                                              .value!) /
                                                          100000000;
                                                  controllerTransaction
                                                          .input.value =
                                                      double.parse(value
                                                          .toStringAsFixed(8));
                                                  return Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        vertical: 8.0),
                                                    child: GlassContainer(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(10.0),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Container(
                                                              height: 20,
                                                              width: 20,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color:
                                                                    Colors.red,
                                                                shape: BoxShape
                                                                    .circle,
                                                              ),
                                                              child:
                                                                  const Center(
                                                                      child:
                                                                          Icon(
                                                                Icons
                                                                    .arrow_forward_outlined,
                                                                size: 15,
                                                              )),
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Flexible(
                                                                  flex: 3,
                                                                  child:
                                                                      GestureDetector(
                                                                    onTap: () {
                                                                      controllerTransaction.getAddressComponent(controllerTransaction
                                                                          .transactionModel!
                                                                          .vin?[
                                                                              index]
                                                                          .prevout!
                                                                          .scriptpubkeyAddress);
                                                                      controllerTransaction
                                                                          .addressId = controllerTransaction
                                                                              .transactionModel!
                                                                              .vin?[index]
                                                                              .prevout!
                                                                              .scriptpubkeyAddress ??
                                                                          '';
                                                                      Navigator
                                                                          .push(
                                                                        context,
                                                                        MaterialPageRoute(
                                                                          builder: (context) =>
                                                                              AddressComponent(),
                                                                        ),
                                                                      );
                                                                    },
                                                                    child: Text(
                                                                      controllerTransaction.transactionModel!.vin?[index].prevout?.scriptpubkeyAddress == null &&
                                                                              controllerTransaction.transactionModel!.vin?[index].prevout?.scriptpubkeyType == "op_return"
                                                                          ? 'OP_RETURN (R)'
                                                                          : '${controllerTransaction.transactionModel!.vin?[index].prevout?.scriptpubkeyAddress!.substring(0, 10)}'
                                                                              '... '
                                                                              '${controllerTransaction.transactionModel!.vin?[index].prevout?.scriptpubkeyAddress!.substring((controllerTransaction.transactionModel!.vin?[index].prevout?.scriptpubkeyAddress!.length)! - 5)}',
                                                                      style:
                                                                          const TextStyle(
                                                                        fontSize:
                                                                            14,
                                                                        color: Colors
                                                                            .blue,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Flexible(
                                                                  flex: 2,
                                                                  child:
                                                                      Container(
                                                                    padding: EdgeInsets.symmetric(
                                                                        horizontal:
                                                                            4,
                                                                        vertical:
                                                                            4),
                                                                    decoration: BoxDecoration(
                                                                        color: Colors
                                                                            .grey,
                                                                        borderRadius:
                                                                            BorderRadius.circular(5)),
                                                                    child: controllerTransaction
                                                                            .isShowBTC
                                                                            .value
                                                                        ? Text(
                                                                            '${controllerTransaction.isShowBTC.value ? controllerTransaction.inPutBTC(index) : controllerTransaction.inPutDollar(index)} BTC',
                                                                            style:
                                                                                TextStyle(color: Colors.black),
                                                                          )
                                                                        : Text(
                                                                            '\$ ${controllerTransaction.inPutDollar(index)} ',
                                                                            style:
                                                                                TextStyle(color: Colors.black)),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            const SizedBox(
                                                              height: 10,
                                                            ),
                                                            SizedBox(
                                                              child: Row(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  const Expanded(
                                                                    child: Text(
                                                                        'Witness',
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.black)),
                                                                  ),
                                                                  Expanded(
                                                                    child:
                                                                        Column(
                                                                      children: [
                                                                        ListView
                                                                            .builder(
                                                                          physics:
                                                                              const NeverScrollableScrollPhysics(),
                                                                          shrinkWrap:
                                                                              true,
                                                                          itemCount: controllerTransaction
                                                                              .transactionModel!
                                                                              .vin?[index]
                                                                              .witness
                                                                              ?.length,
                                                                          itemBuilder:
                                                                              (context, ind) {
                                                                            return Padding(
                                                                              padding: const EdgeInsets.only(bottom: 10),
                                                                              child: Text(controllerTransaction.transactionModel?.vin != null ? '${controllerTransaction.transactionModel?.vin?[index].witness?[ind]}' : '', style: TextStyle(color: Colors.black)),
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
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                const Text(
                                                                    'nSequence',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .black)),
                                                                Text(
                                                                    '0x${controllerTransaction.transactionModel?.vin?[index].sequence?.toRadixString(16)}',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .black))
                                                              ],
                                                            ),
                                                            const SizedBox(
                                                              height: 10,
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                const Text(
                                                                    'Previous output script',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .black)),
                                                                const SizedBox(
                                                                  width: 10,
                                                                ),
                                                                Flexible(
                                                                    child: Text(
                                                                        '${controllerTransaction.transactionModel?.vin?[index].prevout?.scriptpubkeyAsm}',
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.black)))
                                                              ],
                                                            ),
                                                            const SizedBox(
                                                              height: 10,
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                const Text(
                                                                    'Previous output type',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .black)),
                                                                const SizedBox(
                                                                  width: 10,
                                                                ),
                                                                Flexible(
                                                                    child: Text(
                                                                        '${controllerTransaction.transactionModel?.vin?[index].prevout?.scriptpubkeyType}',
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.black)))
                                                              ],
                                                            ),
                                                            const Divider(
                                                              height: 10,
                                                              color: Colors
                                                                  .black87,
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                    ],
                                  ));
                            }));
                        }
                      },
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
                      onTap: () {
                        if(onChain){
                        BitNetBottomSheet(
                            context: context,
                            child: Obx(() {
                              return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12.0, vertical: 12.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('Outputs\n',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headlineMedium),
                                          LongButtonWidget(
                                              customWidth: 200,
                                              customHeight: 40,
                                              title: !controllerTransaction
                                                      .showDetail.value
                                                  ? 'Show Details'
                                                  : 'Hide Details',
                                              onTap: () {
                                                controllerTransaction
                                                    .toggleExpansion();
                                              })
                                        ],
                                      ),
                                      !controllerTransaction.showDetail.value
                                          ? Expanded(
                                              child: ListView.builder(
                                                physics:
                                                    const AlwaysScrollableScrollPhysics(),
                                                shrinkWrap: true,
                                                itemCount: controllerTransaction
                                                    .transactionModel
                                                    ?.vout
                                                    ?.length,
                                                itemBuilder: (context, index) {
                                                  double value =
                                                      (controllerTransaction
                                                              .transactionModel!
                                                              .vout![index]
                                                              .value!) /
                                                          100000000;

                                                  controllerTransaction.output
                                                      .value = double.parse(
                                                    value.toStringAsFixed(8),
                                                  );
                                                  return Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        vertical: 8.0),
                                                    child: GlassContainer(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Container(
                                                              height: 20,
                                                              width: 20,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: controllerTransaction.dataOutSpents1.data[0][index]
                                                                            [
                                                                            'spent'] ==
                                                                        false
                                                                    ? Colors
                                                                        .green
                                                                    : controllerTransaction.dataOutSpents1.data[0][index]['spent'] ==
                                                                            true
                                                                        ? Colors
                                                                            .red
                                                                        : Colors
                                                                            .grey
                                                                            .shade600,
                                                                shape: BoxShape
                                                                    .circle,
                                                              ),
                                                              child:
                                                                  const Center(
                                                                child: Icon(
                                                                  Icons
                                                                      .arrow_forward_outlined,
                                                                  size: 15,
                                                                ),
                                                              ),
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Flexible(
                                                                  flex: 2,
                                                                  child:
                                                                      GestureDetector(
                                                                    onTap: () {
                                                                      controllerTransaction.getAddressComponent(controllerTransaction
                                                                          .transactionModel!
                                                                          .vout?[
                                                                              index]
                                                                          .scriptpubkeyAddress
                                                                          .toString());
                                                                      controllerTransaction
                                                                          .addressId = controllerTransaction
                                                                              .transactionModel!
                                                                              .vout?[index]
                                                                              .scriptpubkeyAddress
                                                                              .toString() ??
                                                                          '';
                                                                      Navigator
                                                                          .push(
                                                                        context,
                                                                        MaterialPageRoute(
                                                                          builder: (context) =>
                                                                              AddressComponent(),
                                                                        ),
                                                                      );
                                                                    },
                                                                    child: Text(
                                                                      controllerTransaction.transactionModel!.vout?[index].scriptpubkeyAddress == null &&
                                                                              controllerTransaction.transactionModel!.vout?[index].scriptpubkeyType ==
                                                                                  "op_return"
                                                                          ? 'OP_RETURN (R)'
                                                                          : controllerTransaction.transactionModel!.vout?[index].scriptpubkeyAddress.toString() ??
                                                                              '',
                                                                      style: const TextStyle(
                                                                          color: Colors
                                                                              .black,
                                                                          fontSize:
                                                                              14),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Flexible(
                                                                  flex: 2,
                                                                  child:
                                                                      Container(
                                                                    padding: EdgeInsets.symmetric(
                                                                        horizontal:
                                                                            4,
                                                                        vertical:
                                                                            2),
                                                                    decoration: BoxDecoration(
                                                                        color: Colors
                                                                            .grey,
                                                                        borderRadius:
                                                                            BorderRadius.circular(3)),
                                                                    child: controllerTransaction
                                                                            .isShowBTC
                                                                            .value
                                                                        ? Text(
                                                                            '${controllerTransaction.isShowBTC.value ? controllerTransaction.outPutBTC(index) : controllerTransaction.outPutDollar(index)} BTC',
                                                                            style: TextStyle(
                                                                                color: Colors
                                                                                    .black))
                                                                        : Text(
                                                                            '\$ ${controllerTransaction.outPutDollar(index)} ',
                                                                            style:
                                                                                TextStyle(color: Colors.black)),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                            )
                                          : Expanded(
                                              child: ListView.builder(
                                                physics:
                                                    const AlwaysScrollableScrollPhysics(),
                                                shrinkWrap: true,
                                                itemCount: controllerTransaction
                                                    .transactionModel
                                                    ?.vout
                                                    ?.length,
                                                itemBuilder: (context, index) {
                                                  double value =
                                                      (controllerTransaction
                                                              .transactionModel!
                                                              .vout![index]
                                                              .value!) /
                                                          100000000;
                                                  controllerTransaction
                                                          .output.value =
                                                      double.parse(value
                                                          .toStringAsFixed(8));
                                                  return Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        vertical: 8.0),
                                                    child: GlassContainer(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Container(
                                                              height: 20,
                                                              width: 20,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: controllerTransaction.dataOutSpents1.data[0][index]
                                                                            [
                                                                            'spent'] ==
                                                                        false
                                                                    ? Colors
                                                                        .green
                                                                    : controllerTransaction.dataOutSpents1.data[0][index]['spent'] ==
                                                                            true
                                                                        ? Colors
                                                                            .red
                                                                        : Colors
                                                                            .grey
                                                                            .shade600,
                                                                shape: BoxShape
                                                                    .circle,
                                                              ),
                                                              child:
                                                                  const Center(
                                                                child: Icon(
                                                                  Icons
                                                                      .arrow_forward_outlined,
                                                                  size: 15,
                                                                ),
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              height: 10,
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Flexible(
                                                                  flex: 3,
                                                                  child:
                                                                      GestureDetector(
                                                                    onTap: () {
                                                                      controllerTransaction.getAddressComponent(controllerTransaction
                                                                          .transactionModel!
                                                                          .vout?[
                                                                              index]
                                                                          .scriptpubkeyAddress
                                                                          .toString());
                                                                      controllerTransaction
                                                                          .addressId = controllerTransaction
                                                                              .transactionModel!
                                                                              .vout?[index]
                                                                              .scriptpubkeyAddress
                                                                              .toString() ??
                                                                          '';
                                                                      Navigator.push(
                                                                          context,
                                                                          MaterialPageRoute(
                                                                              builder: (context) => AddressComponent()));
                                                                    },
                                                                    child: Text(
                                                                      controllerTransaction.transactionModel!.vout?[index].scriptpubkeyAddress == null &&
                                                                              controllerTransaction.transactionModel!.vout?[index].scriptpubkeyType ==
                                                                                  "op_return"
                                                                          ? 'OP_RETURN (R)'
                                                                          : controllerTransaction.transactionModel!.vout?[index].scriptpubkeyAddress.toString() ??
                                                                              '',
                                                                      style: const TextStyle(
                                                                          color: Colors
                                                                              .black,
                                                                          fontSize:
                                                                              14),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Flexible(
                                                                  flex: 2,
                                                                  child:
                                                                      Container(
                                                                    padding:
                                                                        EdgeInsets
                                                                            .all(4),
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              5),
                                                                      color: Colors
                                                                          .grey,
                                                                    ),
                                                                    child: controllerTransaction
                                                                            .isShowBTC
                                                                            .value
                                                                        ? Text(
                                                                            '${controllerTransaction.isShowBTC.value ? controllerTransaction.outPutBTC(index) : controllerTransaction.outPutDollar(index)} BTC',
                                                                            style: TextStyle(
                                                                                color: Colors
                                                                                    .black))
                                                                        : Text(
                                                                            '\$ ${controllerTransaction.outPutDollar(index)} ',
                                                                            style:
                                                                                TextStyle(color: Colors.black)),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            const SizedBox(
                                                              height: 10,
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                const Text(
                                                                    'ScriptPubKey (ASM)	',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .black)),
                                                                const SizedBox(
                                                                  width: 10,
                                                                ),
                                                                Flexible(
                                                                    child: Text(
                                                                        '${controllerTransaction.transactionModel?.vout?[index].scriptpubkeyAsm}',
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.black)))
                                                              ],
                                                            ),
                                                            const SizedBox(
                                                              height: 10,
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                const Text(
                                                                    'ScriptPubKey (HEX)	',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .black)),
                                                                const SizedBox(
                                                                  width: 10,
                                                                ),
                                                                Flexible(
                                                                    child: Text(
                                                                        '${controllerTransaction.transactionModel?.vout?[index].scriptpubkey}',
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.black)))
                                                              ],
                                                            ),
                                                            const SizedBox(
                                                              height: 10,
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                const Text(
                                                                    'Type',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .black)),
                                                                const SizedBox(
                                                                  width: 10,
                                                                ),
                                                                Flexible(
                                                                    child: Text(
                                                                        '${controllerTransaction.transactionModel?.vout?[index].scriptpubkeyType}',
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.black)))
                                                              ],
                                                            ),
                                                            const Divider(
                                                              height: 10,
                                                              color: Colors
                                                                  .black87,
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                    ],
                                  ));
                            }));
                        }
                      },
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
                            child: Text(
                              coin.coin ?? true
                                  ? data.amount
                                  : "$currencyEquivalent${getCurrency(currency!)}",
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
                  trailing: Container(
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
                ),
                BitNetListTile(
                  text: "Payment Network",
                  trailing: data.type == TransactionType.onChain
                      ? Image.asset(
                          "assets/images/bitcoin.png",
                          width: AppTheme.cardPadding * 1.5,
                          height: AppTheme.cardPadding * 1.5,
                        )
                      : Image.asset(
                          "assets/images/lightning.png",
                          width: AppTheme.cardPadding * 1.5,
                          height: AppTheme.cardPadding * 1.5,
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
            );
          }),
        ));
  }
}
