import 'dart:async';
import 'dart:developer';

import 'package:bitnet/backbone/cloudfunctions/loop/get_loopin_quote.dart';
import 'package:bitnet/backbone/cloudfunctions/loop/get_loopout_quote.dart';
import 'package:bitnet/backbone/cloudfunctions/loop/loop_in.dart';
import 'package:bitnet/backbone/cloudfunctions/loop/loop_out.dart';
import 'package:bitnet/backbone/cloudfunctions/lnd/lightningservice/channel_balance.dart';
import 'package:bitnet/backbone/cloudfunctions/lnd/lightningservice/wallet_balance.dart';
import 'package:bitnet/backbone/helper/currency/currency_converter.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetListTile.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/buttons/bottom_buybuttons.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/dialogsandsheets/bottom_sheets/bit_net_bottom_sheet.dart';
import 'package:bitnet/components/dialogsandsheets/notificationoverlays/overlay.dart';
import 'package:bitnet/components/items/amount_previewer.dart';
import 'package:bitnet/models/bitcoin/lnd/lightning_balance_model.dart';
import 'package:bitnet/models/bitcoin/lnd/onchain_balance_model.dart';
import 'package:bitnet/models/bitcoin/lnd/received_invoice_model.dart';
import 'package:bitnet/models/bitcoin/lnd/transaction_model.dart';
import 'package:bitnet/models/currency/bitcoinunitmodel.dart';
import 'package:bitnet/models/firebase/restresponse.dart';
import 'package:bitnet/models/loop/loop_quote_model.dart';
import 'package:bitnet/pages/wallet/loop/loop_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoopGetxController extends GetxController {
  // Reactive state variables
  var onchainBalance = OnchainBalance(
    totalBalance: '0',
    confirmedBalance: '0',
    unconfirmedBalance: '0',
    lockedBalance: '0',
    reservedBalanceAnchorChan: '',
    accountBalance: '',
  ).obs;

  var lightningBalance = LightningBalance(
    balance: '0',
    pendingOpenBalance: '0',
    localBalance: '0',
    remoteBalance: '0',
    unsettledLocalBalance: '0',
    pendingOpenLocalBalance: '',
    unsettledRemoteBalance: '',
    pendingOpenRemoteBalance: '',
  ).obs;

  var visible = false.obs;

  var totalBalanceStr = "0".obs;
  var totalBalanceSAT = 0.0.obs;

  // Stream subscriptions
  StreamSubscription<List<ReceivedInvoice>>? _invoicesSubscription;
  StreamSubscription<List<BitcoinTransaction>>? _transactionsSubscription;

  // UI Controllers
  late TextEditingController satController;
  late TextEditingController btcController;
  late TextEditingController currencyController;
  late FocusNode amtNode;
  late ScrollController scrollController;

  // Other reactive variables
  var animate = false.obs;
  var loadingState = false.obs;

  @override
  void onInit() {
    super.onInit();
    // Initialize Text Controllers and Focus Nodes
    satController = TextEditingController();
    btcController = TextEditingController();
    currencyController = TextEditingController();
    amtNode = FocusNode();
    scrollController = ScrollController();

    // Add listener to focus node
    amtNode.addListener(() {
      if (amtNode.hasFocus) {
        scrollToBottom();
      }
    });

    // Fetch initial balances
    fetchOnchainWalletBalance();
    fetchLightningWalletBalance();
  }

  @override
  void onClose() {
    // Dispose controllers and subscriptions
    satController.dispose();
    btcController.dispose();
    currencyController.dispose();
    amtNode.removeListener(() {});
    amtNode.dispose();
    scrollController.dispose();
    _invoicesSubscription?.cancel();
    _transactionsSubscription?.cancel();
    super.onClose();
  }

  // Toggle animation state
  void changeAnimate() {
    animate.value = !animate.value;
    log('Animate Value: ${animate.value}');
  }

  // Update loading state
  void updateLoadingState(bool value) {
    loadingState.value = value;
  }

  // Scroll to bottom of the ScrollController
  void scrollToBottom() {
    if (scrollController.hasClients) {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  // Fetch on-chain wallet balance
  Future<void> fetchOnchainWalletBalance() async {
    try {
      RestResponse onchainBalanceRest = await walletBalance();
      if (onchainBalanceRest.data.isNotEmpty) {
        OnchainBalance fetchedOnchainBalance =
        OnchainBalance.fromJson(onchainBalanceRest.data);

        onchainBalance.value = fetchedOnchainBalance;
      }

      changeTotalBalanceStr();
    } catch (e) {
      log('Error fetching on-chain balance: $e');
    }
  }

  // Fetch Lightning wallet balance
  Future<void> fetchLightningWalletBalance() async {
    try {
      RestResponse lightningBalanceRest = await channelBalance();

      if (lightningBalanceRest.data.isNotEmpty) {
        LightningBalance fetchedLightningBalance =
        LightningBalance.fromJson(lightningBalanceRest.data);
        lightningBalance.value = fetchedLightningBalance;
      }

      changeTotalBalanceStr();
    } catch (e) {
      log('Error fetching lightning balance: $e');
    }
  }

  // Update total balance string
  void changeTotalBalanceStr() {
    try {
      String confirmedBalanceStr = onchainBalance.value.confirmedBalance;
      String balanceStr = lightningBalance.value.balance;

      double confirmedBalanceSAT = double.parse(confirmedBalanceStr);
      double balanceSAT = double.parse(balanceStr);

      totalBalanceSAT.value = confirmedBalanceSAT + balanceSAT;

      BitcoinUnitModel bitcoinUnit = CurrencyConverter.convertToBitcoinUnit(
          totalBalanceSAT.value, BitcoinUnits.SAT);
      final balance = bitcoinUnit.amount;
      final unit = bitcoinUnit.bitcoinUnitAsString;

      totalBalanceStr.value = "$balance $unit";
    } catch (e) {
      log('Error calculating total balance: $e');
      totalBalanceStr.value = "0 SAT";
    }
  }

  // Handle Loop-In Quote
  Future<void> loopInQuote(BuildContext context) async {
    log('This is the loop-in amount: ${satController.text}');
    if (btcController.text != '0') {
      updateLoadingState(true);
      int amount = int.tryParse(satController.text) ?? 0;
      int roundedAmount = amount.round();

      log('Loop-in amount: $roundedAmount');
      final response = await getLoopinQuote(roundedAmount.toString());

      if (response.statusCode == 'error') {
        showOverlay(context, response.message);
      } else {
        final loop = LoopQuoteModel.fromJson(response.data);
        log('Loop-in swap fee in SAT: ${loop.swapFeeSat}');
        _buildLoopInDialog(context, loop);
      }
      updateLoadingState(false);
    } else {
      showOverlay(context, 'Please enter an amount');
    }
  }

  // Handle Loop-Out Quote
  Future<void> loopOutQuote(BuildContext context) async {
    if (btcController.text != '0') {
      log('Loop-out amount: ${satController.text}');
      updateLoadingState(true);
      int amount = int.tryParse(satController.text) ?? 0;
      int roundedAmount = amount.round();
      log('Loop-out amount: $roundedAmount');

      final response = await getLoopOutQuote(roundedAmount.toString());
      if (response.statusCode == 'error') {
        showOverlay(context, response.message);
      } else {
        final loop = LoopQuoteModel.fromJson(response.data);
        log('Loop-out swap fee in SAT: ${loop.swapFeeSat}');
        _buildLoopOutDialog(context, loop);
      }
      updateLoadingState(false);
    } else {
      showOverlay(context, 'Please enter an amount');
      updateLoadingState(false);
    }
  }

  // Build Loop-Out Dialog
  void _buildLoopOutDialog(BuildContext context, LoopQuoteModel data) {
    BitNetBottomSheet(
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
              padding: const EdgeInsets.only(top: AppTheme.cardPadding * 2),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: AppTheme.elementSpacing),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: AppTheme.elementSpacing,
                        ),
                        BitNetListTile(
                          text: 'Swap Fee (SAT)',
                          trailing: AmountPreviewer(
                            unitModel: CurrencyConverter.convertToBitcoinUnit(
                                double.parse(data.swapFeeSat), BitcoinUnits.SAT),
                            textStyle:
                            Theme.of(context).textTheme.bodyMedium!,
                            textColor: null,
                            shouldHideBalance: false,
                          ),
                        ),
                        BitNetListTile(
                          text: 'HTLC Sweep Fee (SAT)',
                          trailing: AmountPreviewer(
                            unitModel: CurrencyConverter.convertToBitcoinUnit(
                                double.parse(data.htlcSweepFeeSat!),
                                BitcoinUnits.SAT),
                            textStyle:
                            Theme.of(context).textTheme.bodyMedium!,
                            textColor: null,
                            shouldHideBalance: false,
                          ),
                        ),
                        BitNetListTile(
                          text: 'Pre-pay Amount (SAT)',
                          trailing: AmountPreviewer(
                            unitModel: CurrencyConverter.convertToBitcoinUnit(
                                double.parse(data.prepayAmtSat!),
                                BitcoinUnits.SAT),
                            textStyle:
                            Theme.of(context).textTheme.bodyMedium!,
                            textColor: null,
                            shouldHideBalance: false,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
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
            ),
          ],
        ),
      ),
    );
  }

  // Build Loop-In Dialog
  void _buildLoopInDialog(BuildContext context, LoopQuoteModel data) {
    BitNetBottomSheet(
      context: context,
      child: bitnetScaffold(
        extendBodyBehindAppBar: true,
        context: context,
        appBar: bitnetAppBar(
          context: context,
          text: "On-Chain to Lightning",
        ),
        body: Container(
          padding: const EdgeInsets.only(top: AppTheme.cardPadding * 2),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(
                    horizontal: AppTheme.elementSpacing),
                child: Column(
                  children: [
                    const SizedBox(
                      height: AppTheme.elementSpacing,
                    ),
                    BitNetListTile(
                      text: 'Swap Fee (SAT)',
                      trailing: AmountPreviewer(
                        unitModel: CurrencyConverter.convertToBitcoinUnit(
                            double.parse(data.swapFeeSat), BitcoinUnits.SAT),
                        textStyle:
                        Theme.of(context).textTheme.bodyMedium!,
                        textColor: null,
                        shouldHideBalance: false,
                      ),
                    ),
                    BitNetListTile(
                      text: 'HTLC Publish Fee (SAT)',
                      trailing: AmountPreviewer(
                        unitModel: CurrencyConverter.convertToBitcoinUnit(
                            double.parse(data.htlcPublishFeeSat!),
                            BitcoinUnits.SAT),
                        textStyle:
                        Theme.of(context).textTheme.bodyMedium!,
                        textColor: null,
                        shouldHideBalance: false,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                const EdgeInsets.symmetric(vertical: AppTheme.cardPadding),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(
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
                        loopin_func(mapData);
                      },
                    ),
                    const SizedBox(
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
    );
  }

  // Add any additional methods like loopin and loopOut here
  Future<void> loopin_func(Map<String, dynamic> data) async {
    // Implement the loop-in functionality
    // Example:
    updateLoadingState(true);
    try {
      // Call your loop-in function
      await loopin(data);
      showOverlay(Get.context!, 'Loop-In successful!');
      // Optionally, refresh balances
      await fetchOnchainWalletBalance();
      await fetchLightningWalletBalance();
    } catch (e) {
      log('Error during loop-in: $e');
      showOverlay(Get.context!, 'Loop-In failed: $e');
    } finally {
      updateLoadingState(false);
    }
  }

  Future<void> loopOut(Map<String, dynamic> data) async {
    // Implement the loop-out functionality
    // Example:
    updateLoadingState(true);
    try {
      // Call your loop-out function
      await loopOut(data);
      showOverlay(Get.context!, 'Loop-Out successful!');
      // Optionally, refresh balances
      await fetchOnchainWalletBalance();
      await fetchLightningWalletBalance();
    } catch (e) {
      log('Error during loop-out: $e');
      showOverlay(Get.context!, 'Loop-Out failed: $e');
    } finally {
      updateLoadingState(false);
    }
  }
}
