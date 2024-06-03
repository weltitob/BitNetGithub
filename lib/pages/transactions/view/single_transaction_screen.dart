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
import 'package:bitnet/components/fields/searchfield/searchfield.dart';
import 'package:bitnet/pages/secondpages/mempool/controller/home_controller.dart';
import 'package:bitnet/pages/transactions/controller/transaction_controller.dart';
import 'package:bitnet/pages/transactions/view/address_component.dart';
import 'package:bitnet/pages/wallet/controllers/wallet_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';

class SingleTransactionScreen extends StatelessWidget {
  SingleTransactionScreen({Key? key}) : super(key: key);
  TextEditingController inputCtrl = TextEditingController();
  TextEditingController outputCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TransactionController());
    final controllerHome = Get.put(HomeController());
    final controllerWallet = Get.put(WalletsController());
    String? currency =
        Provider.of<CurrencyChangeProvider>(context).selectedCurrency;
    final coin = Provider.of<CurrencyTypeProvider>(context, listen: true);
    currency = currency ?? "USD";

    return bitnetScaffold(
      context: context,
      extendBodyBehindAppBar: true,
      appBar: bitnetAppBar(
        context: context,
        onTap: () {
          controller.timer?.cancel();
          controller.timerLatest?.cancel();
          controller.timerTime?.cancel();
          channel.sink.add('{"track-rbf-summary":true}');
          channel.sink.add('{"track-tx":"stop"}');
          channel.sink
              .add('{"action":"want","data":["blocks","mempool-blocks"]}');

          Navigator.pop(context);
          controller.homeController.isRbfTransaction.value = false;
          // controller.txID = '';
        },
      ),
      body: PopScope(
        canPop: true,
        onPopInvoked: (bool didPop) {
          // if (didPop) {
          controller.timer?.cancel();
          controller.timerLatest?.cancel();
          controller.timerTime?.cancel();
          channel.sink.add('{"track-rbf-summary":true}');
          channel.sink.add('{"track-tx":"stop"}');
          channel.sink
              .add('{"action":"want","data":["blocks","mempool-blocks"]}');
          controller.homeController.isRbfTransaction.value = false;
        },
        child: Obx(() {
          return controller.isLoading.isTrue
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : controller.transactionModel == null
                  ? Center(child: Text('Something went wrong'))
                  : SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: AppTheme.cardPadding * 2),
                        child: Container(
                          child: Column(
                            children: [
                              controller.homeController.isRbfTransaction.value
                                  ? Container(
                                      margin: EdgeInsets.symmetric(
                                        vertical: 10,
                                        horizontal: 10,
                                      ),
                                      padding: EdgeInsets.symmetric(
                                        vertical: 10,
                                        horizontal: 10,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.purple.shade400,
                                        borderRadius: BorderRadius.circular(
                                          5,
                                        ),
                                      ),
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              L10n.of(context)!.transactionReplaced,
                                              style: TextStyle(
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
                                                Get.snackbar(
                                                    L10n.of(context)
                                                       ! .copiedToClipboard,
                                                    controller.txID!);
                                              },
                                              child: Row(
                                                children: [
                                                  SizedBox(
                                                    width: 300,
                                                    child: Text(
                                                      controllerHome
                                                          .replacedTx.value,
                                                      style: TextStyle(
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
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Icon(
                                                    Icons.copy,
                                                    color: Colors.white,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ]),
                                    )
                                  : SizedBox(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Avatar(
                                    size: AppTheme.cardPadding * 4.75,
                                    onTap: () {
                                      BitNetBottomSheet(
                                          context: context,
                                          child: StatefulBuilder(
                                              builder: (context, setState) {
                                            return Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 16.0,
                                                        vertical: 12.0),
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(L10n.of(context)!.inputTx,
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .headlineMedium),
                                                        LongButtonWidget(
                                                            customWidth: 200,
                                                            customHeight: 40,
                                                            title: !controller
                                                                    .showDetail
                                                                    .value
                                                                ? L10n.of(context)!.showDetails
                                                                : L10n.of(context)!.hideDetails,
                                                            onTap: () {
                                                              controller
                                                                  .toggleExpansion();
                                                            })
                                                      ],
                                                    ),
                                                    SearchFieldWidget(
                                                      // controller: searchCtrl,
                                                      hintText: L10n.of(context)
                                                          !.search,
                                                      handleSearch: (v) {
                                                        setState(() {
                                                          inputCtrl.text = v;
                                                        });
                                                      },
                                                      isSearchEnabled: true,
                                                    ),
                                                    !controller.showDetail.value
                                                        ? Expanded(
                                                            child: ListView
                                                                .builder(
                                                              physics:
                                                                  const AlwaysScrollableScrollPhysics(),
                                                              shrinkWrap: true,
                                                              itemCount: controller
                                                                  .transactionModel
                                                                  ?.vin
                                                                  ?.length,
                                                              itemBuilder:
                                                                  (context,
                                                                      index) {
                                                                double value = (controller
                                                                        .transactionModel!
                                                                        .vin![
                                                                            index]
                                                                        .prevout!
                                                                        .value!) /
                                                                    100000000;
                                                                controller.input
                                                                        .value =
                                                                    double.parse(
                                                                        value.toStringAsFixed(
                                                                            8));
                                                                String address =
                                                                    '';
                                                                if (controller
                                                                        .transactionModel!
                                                                        .vin?[
                                                                            index]
                                                                        .prevout!
                                                                        .scriptpubkeyAddress !=
                                                                    null)
                                                                  address = controller
                                                                          .transactionModel!
                                                                          .vin?[
                                                                              index]
                                                                          .prevout!
                                                                          .scriptpubkeyAddress ??
                                                                      '';
                                                                return address.contains(
                                                                        inputCtrl
                                                                            .text)
                                                                    ? Padding(
                                                                        padding: const EdgeInsets
                                                                            .symmetric(
                                                                            vertical:
                                                                                8.0),
                                                                        child:
                                                                            GlassContainer(
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(8.0),
                                                                            child:
                                                                                Column(
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              children: [
                                                                                Container(
                                                                                  height: 20,
                                                                                  width: 20,
                                                                                  decoration: BoxDecoration(
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
                                                                                          controller.getAddressComponent(controller.transactionModel!.vin?[index].prevout!.scriptpubkeyAddress);
                                                                                          controller.addressId = controller.transactionModel!.vin?[index].prevout!.scriptpubkeyAddress ?? '';
                                                                                          Navigator.push(context, MaterialPageRoute(builder: (context) => AddressComponent()));

                                                                                          // Get.to(() =>
                                                                                          //     AddressComponent());
                                                                                        },
                                                                                        child: Text(
                                                                                          controller.transactionModel!.vin?[index].prevout?.scriptpubkeyAddress == null && controller.transactionModel!.vin?[index].prevout?.scriptpubkeyType == "op_return"
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
                                                                                            style: TextStyle(color: Colors.black),
                                                                                          )
                                                                                        : Text('\$ ${controller.inPutDollar(index)} ', style: TextStyle(color: Colors.black))
                                                                                  ],
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      )
                                                                    : SizedBox();
                                                              },
                                                            ),
                                                          )
                                                        : Expanded(
                                                            child: ListView
                                                                .builder(
                                                              physics:
                                                                  const AlwaysScrollableScrollPhysics(),
                                                              shrinkWrap: true,
                                                              itemCount: controller
                                                                  .transactionModel
                                                                  ?.vin
                                                                  ?.length,
                                                              itemBuilder:
                                                                  (context,
                                                                      index) {
                                                                double value = (controller
                                                                        .transactionModel!
                                                                        .vin![
                                                                            index]
                                                                        .prevout!
                                                                        .value!) /
                                                                    100000000;
                                                                controller.input
                                                                        .value =
                                                                    double.parse(
                                                                        value.toStringAsFixed(
                                                                            8));
                                                                String address =
                                                                    '';
                                                                if (controller
                                                                        .transactionModel!
                                                                        .vin?[
                                                                            index]
                                                                        .prevout!
                                                                        .scriptpubkeyAddress !=
                                                                    null)
                                                                  address = controller
                                                                          .transactionModel!
                                                                          .vin?[
                                                                              index]
                                                                          .prevout!
                                                                          .scriptpubkeyAddress ??
                                                                      '';
                                                                return address.contains(
                                                                        inputCtrl
                                                                            .text)
                                                                    ? Padding(
                                                                        padding: const EdgeInsets
                                                                            .symmetric(
                                                                            vertical:
                                                                                8.0),
                                                                        child:
                                                                            GlassContainer(
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(10.0),
                                                                            child:
                                                                                Column(
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              children: [
                                                                                Container(
                                                                                  height: 20,
                                                                                  width: 20,
                                                                                  decoration: BoxDecoration(
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
                                                                                      flex: 3,
                                                                                      child: GestureDetector(
                                                                                        onTap: () {
                                                                                          controller.getAddressComponent(controller.transactionModel!.vin?[index].prevout!.scriptpubkeyAddress);
                                                                                          controller.addressId = controller.transactionModel!.vin?[index].prevout!.scriptpubkeyAddress ?? '';
                                                                                          Navigator.push(
                                                                                            context,
                                                                                            MaterialPageRoute(
                                                                                              builder: (context) => AddressComponent(),
                                                                                            ),
                                                                                          );
                                                                                        },
                                                                                        child: Text(
                                                                                          controller.transactionModel!.vin?[index].prevout?.scriptpubkeyAddress == null && controller.transactionModel!.vin?[index].prevout?.scriptpubkeyType == "op_return"
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
                                                                                        padding: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                                                                                        decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(5)),
                                                                                        child: controller.isShowBTC.value
                                                                                            ? Text(
                                                                                                '${controller.isShowBTC.value ? controller.inPutBTC(index) : controller.inPutDollar(index)} BTC',
                                                                                                style: TextStyle(color: Colors.black),
                                                                                              )
                                                                                            : Text('\$ ${controller.inPutDollar(index)} ', style: TextStyle(color: Colors.black)),
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
                                                                                        child: Text(L10n.of(context)!.witness, style: TextStyle(color: Colors.black)),
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
                                                                                                  child: Text(controller.transactionModel?.vin != null ? '${controller.transactionModel?.vin?[index].witness?[ind]}' : '', style: TextStyle(color: Colors.black)),
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
                                                                                    const Text('nSequence', style: TextStyle(color: Colors.black)),
                                                                                    Text('0x${controller.transactionModel?.vin?[index].sequence?.toRadixString(16)}', style: TextStyle(color: Colors.black))
                                                                                  ],
                                                                                ),
                                                                                const SizedBox(
                                                                                  height: 10,
                                                                                ),
                                                                                Row(
                                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                  children: [
                                                                                      Text(L10n.of(context)!.previousOutputScripts, style: TextStyle(color: Colors.black)),
                                                                                    const SizedBox(
                                                                                      width: 10,
                                                                                    ),
                                                                                    Flexible(child: Text('${controller.transactionModel?.vin?[index].prevout?.scriptpubkeyAsm}', style: TextStyle(color: Colors.black)))
                                                                                  ],
                                                                                ),
                                                                                const SizedBox(
                                                                                  height: 10,
                                                                                ),
                                                                                Row(
                                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                  children: [
                                                                                    const Text('Previous output type', style: TextStyle(color: Colors.black)),
                                                                                    const SizedBox(
                                                                                      width: 10,
                                                                                    ),
                                                                                    Flexible(child: Text('${controller.transactionModel?.vin?[index].prevout?.scriptpubkeyType}', style: TextStyle(color: Colors.black)))
                                                                                  ],
                                                                                ),
                                                                                const Divider(
                                                                                  height: 10,
                                                                                  color: Colors.black87,
                                                                                )
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      )
                                                                    : SizedBox();
                                                              },
                                                            ),
                                                          ),
                                                  ],
                                                ));
                                          }));
                                    },
                                  ),
                                  SizedBox(
                                    width: AppTheme.elementSpacing,
                                  ),
                                  Icon(
                                    Icons.double_arrow_rounded,
                                    size: AppTheme.cardPadding * 3,
                                    color: Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? AppTheme.white80
                                        : AppTheme.black60,
                                  ),
                                  SizedBox(
                                    width: AppTheme.elementSpacing,
                                  ),
                                  Avatar(
                                    size: AppTheme.cardPadding * 4.75,
                                    onTap: () {
                                      BitNetBottomSheet(
                                          context: context,
                                          child: StatefulBuilder(
                                              builder: (context, setState) {
                                            return Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 12.0,
                                                        vertical: 12.0),
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(L10n.of(context)!.outputTx,
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .headlineMedium),
                                                        LongButtonWidget(
                                                            customWidth: 200,
                                                            customHeight: 40,
                                                            title: !controller
                                                                    .showDetail
                                                                    .value
                                                                ? L10n.of(context)!.showDetails
                                                                : L10n.of(context)!.hideDetails,
                                                            onTap: () {
                                                              controller
                                                                  .toggleExpansion();
                                                            })
                                                      ],
                                                    ),
                                                    SearchFieldWidget(
                                                      // controller: searchCtrl,
                                                      hintText: L10n.of(context)
                                                         ! .search,
                                                      handleSearch: (v) {
                                                        setState(() {
                                                          outputCtrl.text = v;
                                                        });
                                                      },
                                                      isSearchEnabled: true,
                                                    ),
                                                    !controller.showDetail.value
                                                        ? Expanded(
                                                            child: ListView
                                                                .builder(
                                                              physics:
                                                                  const AlwaysScrollableScrollPhysics(),
                                                              shrinkWrap: true,
                                                              itemCount: controller
                                                                  .transactionModel
                                                                  ?.vout
                                                                  ?.length,
                                                              itemBuilder:
                                                                  (context,
                                                                      index) {
                                                                double value = (controller
                                                                        .transactionModel!
                                                                        .vout![
                                                                            index]
                                                                        .value!) /
                                                                    100000000;

                                                                controller
                                                                        .output
                                                                        .value =
                                                                    double
                                                                        .parse(
                                                                  value
                                                                      .toStringAsFixed(
                                                                          8),
                                                                );
                                                                String address =
                                                                    '';
                                                                if (controller
                                                                        .transactionModel!
                                                                        .vout?[
                                                                            index]
                                                                        .scriptpubkeyAddress !=
                                                                    null)
                                                                  address = controller
                                                                          .transactionModel!
                                                                          .vout?[
                                                                              index]
                                                                          .scriptpubkeyAddress ??
                                                                      '';
                                                                return address.contains(
                                                                        outputCtrl
                                                                            .text)
                                                                    ? Padding(
                                                                        padding: const EdgeInsets
                                                                            .symmetric(
                                                                            vertical:
                                                                                8.0),
                                                                        child:
                                                                            GlassContainer(
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(8.0),
                                                                            child:
                                                                                Column(
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              children: [
                                                                                Container(
                                                                                  height: 20,
                                                                                  width: 20,
                                                                                  decoration: BoxDecoration(
                                                                                    color: controller.dataOutSpents1.data[0][index]['spent'] == false
                                                                                        ? Colors.green
                                                                                        : controller.dataOutSpents1.data[0][index]['spent'] == true
                                                                                            ? Colors.red
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
                                                                                          controller.getAddressComponent(controller.transactionModel!.vout?[index].scriptpubkeyAddress.toString());
                                                                                          controller.addressId = controller.transactionModel!.vout?[index].scriptpubkeyAddress.toString() ?? '';
                                                                                          Navigator.push(
                                                                                            context,
                                                                                            MaterialPageRoute(
                                                                                              builder: (context) => AddressComponent(),
                                                                                            ),
                                                                                          );
                                                                                        },
                                                                                        child: Text(
                                                                                          controller.transactionModel!.vout?[index].scriptpubkeyAddress == null && controller.transactionModel!.vout?[index].scriptpubkeyType == "op_return" ? 'OP_RETURN (R)' : controller.transactionModel!.vout?[index].scriptpubkeyAddress.toString() ?? '',
                                                                                          style: Theme.of(context).textTheme.bodyMedium,
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    Flexible(
                                                                                      flex: 2,
                                                                                      child: Container(
                                                                                        padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                                                                                        decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(3)),
                                                                                        child: controller.isShowBTC.value ? Text('${controller.isShowBTC.value ? controller.outPutBTC(index) : controller.outPutDollar(index)} BTC', style: TextStyle(color: Colors.black)) : Text('\$ ${controller.outPutDollar(index)} ', style: TextStyle(color: Colors.black)),
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      )
                                                                    : SizedBox();
                                                              },
                                                            ),
                                                          )
                                                        : Expanded(
                                                            child: ListView
                                                                .builder(
                                                              physics:
                                                                  const AlwaysScrollableScrollPhysics(),
                                                              shrinkWrap: true,
                                                              itemCount: controller
                                                                  .transactionModel
                                                                  ?.vout
                                                                  ?.length,
                                                              itemBuilder:
                                                                  (context,
                                                                      index) {
                                                                double value = (controller
                                                                        .transactionModel!
                                                                        .vout![
                                                                            index]
                                                                        .value!) /
                                                                    100000000;
                                                                controller
                                                                        .output
                                                                        .value =
                                                                    double.parse(
                                                                        value.toStringAsFixed(
                                                                            8));
                                                                return Padding(
                                                                  padding: const EdgeInsets
                                                                      .symmetric(
                                                                      vertical:
                                                                          8.0),
                                                                  child:
                                                                      GlassContainer(
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                          .all(
                                                                          8.0),
                                                                      child:
                                                                          Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          Container(
                                                                            height:
                                                                                20,
                                                                            width:
                                                                                20,
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              color: controller.dataOutSpents1.data[0][index]['spent'] == false
                                                                                  ? Colors.green
                                                                                  : controller.dataOutSpents1.data[0][index]['spent'] == true
                                                                                      ? Colors.red
                                                                                      : Colors.grey.shade600,
                                                                              shape: BoxShape.circle,
                                                                            ),
                                                                            child:
                                                                                const Center(
                                                                              child: Icon(
                                                                                Icons.arrow_forward_outlined,
                                                                                size: 15,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          const SizedBox(
                                                                            height:
                                                                                10,
                                                                          ),
                                                                          Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.spaceBetween,
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.center,
                                                                            children: [
                                                                              Flexible(
                                                                                flex: 3,
                                                                                child: GestureDetector(
                                                                                  onTap: () {
                                                                                    controller.getAddressComponent(controller.transactionModel!.vout?[index].scriptpubkeyAddress.toString());
                                                                                    controller.addressId = controller.transactionModel!.vout?[index].scriptpubkeyAddress.toString() ?? '';
                                                                                    Navigator.push(context, MaterialPageRoute(builder: (context) => AddressComponent()));
                                                                                  },
                                                                                  child: Text(
                                                                                    controller.transactionModel!.vout?[index].scriptpubkeyAddress == null && controller.transactionModel!.vout?[index].scriptpubkeyType == "op_return" ? 'OP_RETURN (R)' : controller.transactionModel!.vout?[index].scriptpubkeyAddress.toString() ?? '',
                                                                                    style: const TextStyle(color: Colors.black, fontSize: 14),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              Flexible(
                                                                                flex: 2,
                                                                                child: Container(
                                                                                  padding: EdgeInsets.all(4),
                                                                                  decoration: BoxDecoration(
                                                                                    borderRadius: BorderRadius.circular(5),
                                                                                    color: Colors.grey,
                                                                                  ),
                                                                                  child: controller.isShowBTC.value ? Text('${controller.isShowBTC.value ? controller.outPutBTC(index) : controller.outPutDollar(index)} BTC', style: TextStyle(color: Colors.black)) : Text('\$ ${controller.outPutDollar(index)} ', style: TextStyle(color: Colors.black)),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          const SizedBox(
                                                                            height:
                                                                                10,
                                                                          ),
                                                                          Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.spaceBetween,
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: [
                                                                              const Text('ScriptPubKey (ASM)	', style: TextStyle(color: Colors.black)),
                                                                              const SizedBox(
                                                                                width: 10,
                                                                              ),
                                                                              Flexible(child: Text('${controller.transactionModel?.vout?[index].scriptpubkeyAsm}', style: TextStyle(color: Colors.black)))
                                                                            ],
                                                                          ),
                                                                          const SizedBox(
                                                                            height:
                                                                                10,
                                                                          ),
                                                                          Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.spaceBetween,
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: [
                                                                              const Text('ScriptPubKey (HEX)	', style: TextStyle(color: Colors.black)),
                                                                              const SizedBox(
                                                                                width: 10,
                                                                              ),
                                                                              Flexible(child: Text('${controller.transactionModel?.vout?[index].scriptpubkey}', style: TextStyle(color: Colors.black)))
                                                                            ],
                                                                          ),
                                                                          const SizedBox(
                                                                            height:
                                                                                10,
                                                                          ),
                                                                          Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.spaceBetween,
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: [
                                                                                Text(L10n.of(context)!.typeBehavior, style: TextStyle(color: Colors.black)),
                                                                              const SizedBox(
                                                                                width: 10,
                                                                              ),
                                                                              Flexible(child: Text('${controller.transactionModel?.vout?[index].scriptpubkeyType}', style: TextStyle(color: Colors.black)))
                                                                            ],
                                                                          ),
                                                                          const Divider(
                                                                            height:
                                                                                10,
                                                                            color:
                                                                                Colors.black87,
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
                                    },
                                  ),
                                ],
                              ),
                              SizedBox(height: AppTheme.cardPadding),
                              controllerWallet.hideBalance.value
                                  ? Text(
                                      '*****',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium,
                                    )
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            coin.setCurrencyType(
                                                coin.coin != null
                                                    ? !coin.coin!
                                                    : false);
                                          },
                                          child: Text(
                                              coin.coin ?? true
                                                  ? '${controller.transactionModel == null ? '' : controller.formatPrice(controller.transactionModel!.fee.toString())}'
                                                  : "\$${controller.usdValue.value.toStringAsFixed(2)}",
                                              overflow: TextOverflow.ellipsis,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .displayLarge!),
                                        ),
                                        coin.coin ?? true
                                            ? Icon(
                                                AppTheme.satoshiIcon,
                                              )
                                            : SizedBox.shrink(),
                                      ],
                                    ),
                              SizedBox(height: AppTheme.elementSpacing),
                              Obx(() {
                                return Text(
                                    controllerHome.txConfirmed.value
                                        ? '${controller.formatTimeAgo(DateTime.fromMillisecondsSinceEpoch(controller.transactionModel!.status!.blockTime! * 1000))}'
                                        : '${controller.timeST.value}',
                                    style:
                                        Theme.of(context).textTheme.bodyLarge);
                              }),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: AppTheme.cardPadding * 2),
                                child: Row(
                                  children: [
                                    Flexible(
                                      child: Text(
                                        controller.txID!,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    IconButton(
                                        onPressed: () async {
                                          await Clipboard.setData(ClipboardData(
                                            text: controller.txID!,
                                          ));
                                          Get.snackbar(
                                              L10n.of(context)!
                                                  .copiedToClipboard,
                                              controller.txID!);
                                        },
                                        icon: const Icon(Icons.copy))
                                  ],
                                ),
                              ),
                              SizedBox(height: AppTheme.cardPadding * 1),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: AppTheme.elementSpacing),
                                child: MyDivider(),
                              ),
                              BitNetListTile(
                                text: L10n.of(context)!.status,
                                trailing: Container(
                                  height: AppTheme.cardPadding * 1.5,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: AppTheme.elementSpacing),
                                  decoration: BoxDecoration(
                                    borderRadius: AppTheme.cardRadiusCircular,
                                    color: controller.transactionModel == null
                                        ? Colors.red
                                        : controller.transactionModel!.status!
                                                .confirmed!
                                            ? Colors.green
                                            : controllerHome.isRbfTransaction
                                                        .value ==
                                                    true
                                                ? Colors.orange
                                                : Colors.red,
                                  ),
                                  child: Center(
                                    child: Text(
                                      controllerHome.isRbfTransaction.value ==
                                              true
                                          ? L10n.of(context)!.replaced
                                          : '${controller.confirmations == 0 ? '' : controller.confirmations} ' +
                                              controller
                                                  .statusTransaction.value,
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                              BitNetListTile(
                                  text:L10n.of(context)!.paymentNetwork,
                                  trailing: Image.asset(
                                    "assets/images/bitcoin.png",
                                    width: AppTheme.cardPadding * 1.5,
                                    height: AppTheme.cardPadding * 1.5,
                                  )),
                              BitNetListTile(
                                  text:L10n.of(context)!.time,
                                  trailing: controllerHome.txConfirmed.value
                                      ? Container(
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    L10n.of(context)!.timestamp,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .titleMedium,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        '${DateFormat('yyyy-MM-dd HH:mm').format(DateTime.fromMillisecondsSinceEpoch(controller.transactionModel!.status!.blockTime! * 1000))}'
                                                        ' (${controller.formatTimeAgo(DateTime.fromMillisecondsSinceEpoch(controller.transactionModel!.status!.blockTime! * 1000))})',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyMedium,
                                                      ),
                                                      // const SizedBox(width: 10),
                                                      // Text(),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(L10n.of(context)!.confirmed,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyMedium),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        L10n.of(context)!.afterTx +
                                                            DateTime
                                                                .fromMillisecondsSinceEpoch(
                                                              (controller
                                                                          .transactionModel!
                                                                          .status!
                                                                          .blockTime! *
                                                                      1000) -
                                                                  (controller
                                                                          .txTime! *
                                                                      1000),
                                                            ).minute.toString() +
                                                            L10n.of(context)!.minutesTx,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyMedium,
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        )
                                      : Obx(() {
                                          return Text(
                                            controller.timeST.value,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium,
                                          );
                                        })),
                              controllerHome.txConfirmed.value
                                  ? SizedBox()
                                  : BitNetListTile(
                                      text: 'ETA',
                                      trailing: Row(
                                        children: [
                                          Text(
                                            controllerHome.txPosition.value >= 7
                                                ? L10n.of(context)!.inSeveralHours
                                                : 'In ~ ${controllerHome.txPosition.value + 1 * 10}${L10n.of(context)!.minutesTx}',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge,
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 8, vertical: 4),
                                            decoration: BoxDecoration(
                                                color: Colors.purple,
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            child: Center(
                                              child: Text(
                                              L10n.of(context)!.accelerate,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge,
                                              ),
                                            ),
                                          )
                                        ],
                                      )),
                              BitNetListTile(
                                  text: L10n.of(context)!.features,
                                  trailing: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      if (controller.segwitEnabled.value)
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 4, vertical: 2),
                                          margin: const EdgeInsets.symmetric(
                                            horizontal: 2,
                                            vertical: 2,
                                          ),
                                          decoration: BoxDecoration(
                                            color: controller
                                                            .realizedSegwitGains !=
                                                        0 &&
                                                    controller
                                                            .potentialSegwitGains !=
                                                        0
                                                ? Colors.orange
                                                : controller.potentialP2shSegwitGains !=
                                                        0
                                                    ? Colors.red
                                                    : Colors.green,
                                            borderRadius:
                                                BorderRadius.circular(4),
                                          ),
                                          child: Text(
                                            'SegWit',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge
                                                ?.copyWith(
                                                    decoration: controller
                                                                .potentialP2shSegwitGains !=
                                                            0
                                                        ? TextDecoration
                                                            .lineThrough
                                                        : TextDecoration.none),
                                          ),
                                        ),
                                      if (controller.taprootEnabled.value)
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 4, vertical: 2),
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 2, vertical: 2),
                                          decoration: BoxDecoration(
                                            color: controller.isTaproot.value
                                                ? Colors.green
                                                : Colors.red,
                                            borderRadius:
                                                BorderRadius.circular(4),
                                          ),
                                          child: Text(
                                            'Taproot',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge
                                                ?.copyWith(
                                                    decoration: controller
                                                            .isTaproot.value
                                                        ? TextDecoration.none
                                                        : TextDecoration
                                                            .lineThrough),
                                          ),
                                        ),
                                      if (controller.rbfEnabled.value)
                                        Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 4, vertical: 2),
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 2, vertical: 2),
                                            decoration: BoxDecoration(
                                              color: controller
                                                      .isRbfTransaction.value
                                                  ? Colors.green
                                                  : Colors.red,
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                            ),
                                            child: Text(
                                              'RBF',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge
                                                  ?.copyWith(
                                                      decoration: controller
                                                              .isRbfTransaction
                                                              .value
                                                          ? TextDecoration.none
                                                          : TextDecoration
                                                              .lineThrough),
                                            )),
                                    ],
                                  )),
                              BitNetListTile(
                                  text: 'Fee',
                                  trailing: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          coin.setCurrencyType(coin.coin != null
                                              ? !coin.coin!
                                              : false);
                                        },
                                        child: Text(
                                          coin.coin ?? true
                                              ? '${controller.transactionModel == null ? '' : controller.formatPrice(controller.transactionModel!.fee.toString())} sat '
                                              : '\$ ${controller.usdValue.value.toStringAsFixed(2)}  ',
                                          overflow: TextOverflow.ellipsis,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge,
                                        ),
                                      ),
                                      coin.coin ?? true
                                          ? Icon(AppTheme.satoshiIcon)
                                          : SizedBox.shrink(),
                                    ],
                                  )),
                              BitNetListTile(
                                  text: L10n.of(context)!.feeRate,
                                  trailing: Row(
                                    children: [
                                      Text(
                                        '${(controller.feeRate * 4).toStringAsFixed(1)} sat/vB',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      controllerHome.txConfirmed.value
                                          ? Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 8, vertical: 4),
                                              decoration: BoxDecoration(
                                                color: controller
                                                            .feeRating.value ==
                                                        1
                                                    ? Colors.green
                                                    : controller.feeRating
                                                                .value ==
                                                            2
                                                        ? Colors.orange
                                                        : Colors.red,
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  controller.feeRating.value ==
                                                          1
                                                      ? L10n.of(context)!.optimal
                                                      : '${L10n.of(context)!.overpaid} ${controller.overpaidTimes ?? 1}x',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyLarge,
                                                ),
                                              ),
                                            )
                                          : SizedBox(),
                                    ],
                                  )),
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
