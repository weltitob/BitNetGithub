import 'dart:developer';

import 'package:bitnet/backbone/cloudfunctions/lnd/pool/get_loopin_quote.dart';
import 'package:bitnet/backbone/cloudfunctions/lnd/pool/get_loopout_quote.dart';
import 'package:bitnet/backbone/cloudfunctions/lnd/pool/loop_in.dart';
import 'package:bitnet/backbone/cloudfunctions/lnd/pool/loop_out.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/dialogsandsheets/notificationoverlays/overlay.dart';
import 'package:bitnet/models/loop/loop_quote_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class LoopGetxController extends GetxController {
  //Animate value true is onchain to lightning
  //false is lightning to onchain
  RxBool animate = false.obs;
  RxBool loadingState = false.obs;

  TextEditingController btcController = TextEditingController();
  TextEditingController currencyController = TextEditingController();

  void changeAnimate() {
    animate.value = !animate.value;
    log('Animate Value: ${animate.value}');
  }

  void updateLoadingState(bool value) {
    loadingState.value = value;
  }

  void loopInQuote(BuildContext context) async {
    log('this is the loopin amount ${btcController.text}');
    if (btcController.text != '0.00') {
      updateLoadingState(true);
      double amount = double.tryParse(btcController.text) ?? 0;
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
    if (btcController.text != '0.00') {
      log('this is the loopout amount ${btcController.text}');
      updateLoadingState(true);
      double amount = double.tryParse(btcController.text) ?? 0;
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
    showGeneralDialog(
        barrierDismissible: true,
        barrierLabel: "buy_dialog",
        context: context,
        pageBuilder: (context, a1, a2) {
          return AlertDialog(
            insetPadding: EdgeInsets.zero,
            backgroundColor: Colors.transparent,
            content: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: AppTheme.colorBackground,
                  border: Border.all(color: AppTheme.colorBitcoin, width: 2)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Lightning to On-Chain",
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(color: Colors.white)),
                    Divider(
                      color: AppTheme.colorBitcoin,
                      thickness: 2,
                    ),
                    Container(
                      width: AppTheme.cardPadding * 10,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Swap Fee (SAT)',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(color: Colors.white),
                              ),
                              Text(
                                data.swapFeeSat,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(color: Colors.white),
                              )
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "HTLC sweep fee (SAT)",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(color: Colors.white),
                              ),
                              Text(
                                data.htlcSweepFeeSat.toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(color: Colors.white),
                              )
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Pre-pay ammount (SAT)",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(color: Colors.white),
                              ),
                              Text(
                                data.prepayAmtSat.toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(color: Colors.white),
                              )
                            ],
                          ),
                          SizedBox(height: 10),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          LongButtonWidget(
                            title: "Cancel",
                            onTap: () {
                              Navigator.pop(context);
                            },
                            buttonType: ButtonType.transparent,
                            customWidth: 15 * 10,
                            customHeight: 15 * 2.5,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          LongButtonWidget(
                            title: "Transfer",
                            onTap: () {
                              double amount =
                                  double.tryParse(btcController.text) ?? 0;
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
                            customWidth: 15 * 10,
                            customHeight: 15 * 2.5,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  _buildLoopInDialog(context, LoopQuoteModel data) {
    showGeneralDialog(
        barrierDismissible: true,
        barrierLabel: "buy_dialog",
        context: context,
        pageBuilder: (context, a1, a2) {
          return AlertDialog(
            insetPadding: EdgeInsets.zero,
            backgroundColor: Colors.transparent,
            content: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: AppTheme.colorBackground,
                  border: Border.all(color: AppTheme.colorBitcoin, width: 2)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("On-Chain to Lightning",
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(color: Colors.white)),
                    Divider(
                      color: AppTheme.colorBitcoin,
                      thickness: 2,
                    ),
                    Container(
                      width: AppTheme.cardPadding * 10,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Swap Fee (SAT)',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(color: Colors.white),
                              ),
                              Text(
                                data.swapFeeSat,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(color: Colors.white),
                              )
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "HTLC publish fee (SAT)",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(color: Colors.white),
                              ),
                              Text(
                                data.htlcPublishFeeSat.toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(color: Colors.white),
                              )
                            ],
                          ),
                          SizedBox(height: 10),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          LongButtonWidget(
                            title: "Cancel",
                            onTap: () {
                              Navigator.pop(context);
                            },
                            buttonType: ButtonType.transparent,
                            customWidth: 15 * 10,
                            customHeight: 15 * 2.5,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          LongButtonWidget(
                            title: "Transfer",
                            onTap: () {
                              double amount =
                                  double.tryParse(btcController.text) ?? 0;
                              int roundedAmount = amount.round();
                              log(roundedAmount.toString());
                              final mapData = {
                                'amt': roundedAmount.toString(),
                                'swapFee': data.swapFeeSat,
                                'minerFee': data.htlcPublishFeeSat,
                              };
                              loopin(mapData);
                            },
                            customWidth: 15 * 10,
                            customHeight: 15 * 2.5,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
