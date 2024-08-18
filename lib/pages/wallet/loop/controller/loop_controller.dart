import 'dart:developer';

import 'package:bitnet/backbone/cloudfunctions/loop/get_loopin_quote.dart';
import 'package:bitnet/backbone/cloudfunctions/loop/get_loopout_quote.dart';
import 'package:bitnet/backbone/cloudfunctions/loop/loop_in.dart';
import 'package:bitnet/backbone/cloudfunctions/loop/loop_out.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/streams/currency_provider.dart';
import 'package:bitnet/backbone/streams/currency_type_provider.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetListTile.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/buttons/bottom_buybuttons.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/dialogsandsheets/bottom_sheets/bit_net_bottom_sheet.dart';
import 'package:bitnet/components/dialogsandsheets/notificationoverlays/overlay.dart';
import 'package:bitnet/models/loop/loop_quote_model.dart';
import 'package:bitnet/pages/wallet/controllers/wallet_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_size/flutter_keyboard_size.dart';
import 'package:get/get.dart';

class LoopGetxController extends GetxController {
  //Animate value true is onchain to lightning
  //false is lightning to onchain
  //Animate value true is onchain to lightning
  //false is lightning to onchain
  RxBool animate = false.obs;
  RxBool loadingState = false.obs;
  late TextEditingController satController;
  late TextEditingController btcController;
  late TextEditingController currencyController;
  late FocusNode amtNode;
  late ScrollController scrollController;

  @override
  void onInit() {
    super.onInit();
    satController = TextEditingController();
    btcController = TextEditingController();
    currencyController = TextEditingController();
    amtNode = FocusNode();
    scrollController = ScrollController();
  }

  @override
  void dispose() {
    satController.dispose();
    btcController.dispose();
    currencyController.dispose();
    amtNode.dispose();
    scrollController.dispose();
    super.dispose();
  }

  void changeAnimate() {
    animate.value = !animate.value;
    log('Animate Value: ${animate.value}');
  }

  void updateLoadingState(bool value) {
    loadingState.value = value;
  }

  void scrollToBottom() {
    if (scrollController.hasClients) {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  void loopInQuote(BuildContext context) async {
    log('this is the loopin amount ${satController.text}');
    if (btcController.text != '0') {
      updateLoadingState(true);
      int amount = int.tryParse(satController.text) ?? 0;
      int roundedAmount = amount.round();

      log('this is the loopin amount $roundedAmount');
      final response = await getLoopinQuote(roundedAmount.toString());
      if (response.statusCode == 'error') {
        showOverlay(context, response.message);
      } else {
        final loop = LoopQuoteModel.fromJson(response.data);
        log('This is the loop in swap fee in sat ${loop.swapFeeSat}');
        _buildLoopInDialog(context, loop);
      }
      updateLoadingState(false);
    } else {
      showOverlay(context, 'Please enter an amount');
    }
  }

  void loopOutQuote(BuildContext context) async {
    if (btcController.text != '0') {
      log('this is the loopout amount ${satController.text}');
      updateLoadingState(true);
      int amount = int.tryParse(satController.text) ?? 0;
      int roundedAmount = amount.round();
      log('this is the loopout amount $roundedAmount');

      final response = await getLoopOutQuote(roundedAmount.toString());
      if (response.statusCode == 'error') {
        showOverlay(context, response.message);
      } else {
        final loop = LoopQuoteModel.fromJson(response.data);
        log('This is the loop out swap fee in sat ${loop.swapFeeSat}');
        _buildLoopOutDialog(context, loop);
      }
      updateLoadingState(false);
    } else {
      showOverlay(context, 'Please enter an amount');
      updateLoadingState(false);
    }
  }

  _buildLoopOutDialog(context, LoopQuoteModel data) {

    //
    // final controller = Get.find<WalletsController>();
    // // Use DateFormat for formatting the timestamp
    // final chartLine = controller.chartLines.value;
    // String? currency = Provider.of<CurrencyChangeProvider>(context).selectedCurrency;
    // final coin = Provider.of<CurrencyTypeProvider>(context, listen: true);
    // currency = currency ?? "USD";
    //
    // final bitcoinPrice = chartLine?.price;
    // final currencyEquivalent =
    // bitcoinPrice != null ? (double.parse(data.swapFeeSat) / 100000000 * bitcoinPrice).toStringAsFixed(2) : "0.00";

    return BitNetBottomSheet(
      context: context,
      child: bitnetScaffold(
        extendBodyBehindAppBar: true,
        context: context,
        appBar: bitnetAppBar(
          hasBackButton: false,
          context: context,
          text: "Lightning to On-Chain",
        ),
        body: Stack(
          children: [
            Container(
              child: Padding(
                padding: const EdgeInsets.only(top: AppTheme.cardPadding * 2),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: AppTheme.elementSpacing),
                      child: Column(
                        children: [
                          SizedBox(
                            height: AppTheme.elementSpacing,
                          ),
                          BitNetListTile(
                            text: 'Swap Fee (SAT)',
                            trailing: Text(data.swapFeeSat),
                          ),
                          BitNetListTile(
                            text: 'HTLC Sweep Fee (SAT)',
                            trailing: Text(data.htlcSweepFeeSat.toString()),
                          ),
                          BitNetListTile(
                            text: 'Pre-pay amount (SAT)',
                            trailing: Text(data.prepayAmtSat.toString()),
                          ),
                        ],
                      ),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(
                    //       vertical: AppTheme.cardPadding),
                    //   child: Column(
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: [
                    //       SizedBox(
                    //         height: AppTheme.cardPadding,
                    //       ),
                    //       LongButtonWidget(
                    //         title: "Transfer",
                    //       ),
                    //       SizedBox(
                    //         height: AppTheme.elementSpacing,
                    //       ),
                    //       LongButtonWidget(
                    //         title: "Cancel",
                    //         onTap: () {
                    //           Navigator.pop(context);
                    //         },
                    //         buttonType: ButtonType.transparent,
                    //       ),
                    //     ],
                    //   ),
                    // )
                  ],
                ),
              ),
            ),
            BottomButtons(
              leftButtonTitle: "Cancel",
              rightButtonTitle: "Transfer",
              onLeftButtonTap: () {
                Navigator.pop(context);
              },
              onRightButtonTap: () {
                double amount = double.tryParse(btcController.text) ?? 0;
                int roundedAmount = amount.round();
                log(roundedAmount.toString());
                final mapData = {
                  'amt': roundedAmount.toString(),
                  'swapFee': data.swapFeeSat.toString(),
                  'minerFee': data.htlcSweepFeeSat,
                  'dest': data.swapPaymentDest,
                  'maxPrepay': data.prepayAmtSat,
                };
                loopOut(mapData);
              },
            )
          ],
        ),
      ),
    );
  }

  _buildLoopInDialog(context, LoopQuoteModel data) {
    return BitNetBottomSheet(
      context: context,
      child: bitnetScaffold(
        extendBodyBehindAppBar: true,
        context: context,
        appBar: bitnetAppBar(
          context: context,
          text: "On-Chain to Lightning",
        ),
        body: Container(
          child: Padding(
            padding: const EdgeInsets.only(top: AppTheme.cardPadding * 2),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin:
                      EdgeInsets.symmetric(horizontal: AppTheme.elementSpacing),
                  child: Column(
                    children: [
                      SizedBox(
                        height: AppTheme.elementSpacing,
                      ),
                      BitNetListTile(
                        text: 'Swap Fee (SAT)',
                        trailing: Text(data.swapFeeSat),
                      ),
                      BitNetListTile(
                        text: 'HTLC publish fee (SAT)',
                        trailing: Text(data.htlcPublishFeeSat.toString()),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: AppTheme.cardPadding),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: AppTheme.cardPadding,
                      ),
                      LongButtonWidget(
                        title: "Transfer",
                        onTap: () {
                          int amount = int.tryParse(satController.text) ?? 0;
                          int roundedAmount = amount.round();
                          log(roundedAmount.toString());
                          final mapData = {
                            'amt': roundedAmount.toString(),
                            'swapFee': data.swapFeeSat,
                            'minerFee': data.htlcPublishFeeSat,
                          };
                          loopin(mapData);
                        },
                      ),
                      SizedBox(
                        height: AppTheme.elementSpacing,
                      ),
                      LongButtonWidget(
                        title: "Cancel",
                        onTap: () {
                          Navigator.pop(context);
                        },
                        buttonType: ButtonType.transparent,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
