import 'dart:async';
import 'dart:developer';

import 'package:bitnet/backbone/auth/auth.dart';
import 'package:bitnet/backbone/cloudfunctions/loop/get_loopin_quote.dart';
import 'package:bitnet/backbone/cloudfunctions/loop/get_loopout_quote.dart';
import 'package:bitnet/backbone/cloudfunctions/loop/get_loop_terms.dart';
import 'package:bitnet/backbone/cloudfunctions/loop/loop_in.dart';
import 'package:bitnet/backbone/cloudfunctions/loop/loop_out.dart';
import 'package:bitnet/backbone/cloudfunctions/lnd/lightningservice/channel_balance.dart';
import 'package:bitnet/backbone/cloudfunctions/lnd/lightningservice/wallet_balance.dart';
import 'package:bitnet/backbone/helper/currency/currency_converter.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
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
import 'package:bitnet/models/loop/loop_terms_model.dart';
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

  // Loop terms for validation
  var loopInTerms = Rxn<LoopTerms>();
  var loopOutTerms = Rxn<LoopTerms>();
  var termsLoading = false.obs;

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

    // Fetch initial balances and Loop terms
    fetchOnchainWalletBalance();
    fetchLightningWalletBalance();
    fetchLoopTerms();
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

  // Fetch Loop Terms for validation
  Future<void> fetchLoopTerms() async {
    final logger = Get.find<LoggerService>();
    termsLoading.value = true;
    
    try {
      final userId = Auth().currentUser?.uid;
      if (userId == null) {
        logger.e("No user logged in for fetching Loop terms");
        return;
      }

      // Fetch both Loop In and Loop Out terms in parallel
      final results = await Future.wait([
        getLoopInTerms(userId),
        getLoopOutTerms(userId),
      ]);

      final loopInResult = results[0];
      final loopOutResult = results[1];

      if (loopInResult.statusCode == "200") {
        loopInTerms.value = LoopTerms.fromJson(loopInResult.data);
        logger.i("Loop In terms loaded: min=${loopInTerms.value?.minSwapAmount}, max=${loopInTerms.value?.maxSwapAmount}");
      } else {
        logger.e("Failed to load Loop In terms: ${loopInResult.message}");
      }

      if (loopOutResult.statusCode == "200") {
        loopOutTerms.value = LoopTerms.fromJson(loopOutResult.data);
        logger.i("Loop Out terms loaded: min=${loopOutTerms.value?.minSwapAmount}, max=${loopOutTerms.value?.maxSwapAmount}");
      } else {
        logger.e("Failed to load Loop Out terms: ${loopOutResult.message}");
      }
    } catch (e) {
      logger.e("Error fetching Loop terms: $e");
    } finally {
      termsLoading.value = false;
    }
  }

  // Validate amount against Loop terms
  bool validateLoopAmount(int amount, bool isLoopIn) {
    final terms = isLoopIn ? loopInTerms.value : loopOutTerms.value;
    if (terms == null) return false;
    return terms.isAmountValid(amount);
  }

  // Get formatted error message for invalid amounts
  String getAmountErrorMessage(int amount, bool isLoopIn) {
    final terms = isLoopIn ? loopInTerms.value : loopOutTerms.value;
    final operation = isLoopIn ? "Loop In" : "Loop Out";
    
    if (terms == null) {
      return "Unable to load $operation limits. Please try again.";
    }

    if (amount < terms.minSwapAmountInt) {
      return "$operation minimum is ${terms.getFormattedMinAmount()}. You entered ${_formatAmount(amount)}.";
    } else if (amount > terms.maxSwapAmountInt) {
      return "$operation maximum is ${terms.getFormattedMaxAmount()}. You entered ${_formatAmount(amount)}.";
    }
    
    return "Invalid amount for $operation.";
  }

  // Helper method to format amount for display
  String _formatAmount(int amount) {
    if (amount >= 100000000) {
      return '${(amount / 100000000).toStringAsFixed(8)} BTC';
    } else if (amount >= 1000000) {
      return '${(amount / 1000000).toStringAsFixed(1)}M sats';
    } else if (amount >= 1000) {
      return '${(amount / 1000).toStringAsFixed(0)}k sats';
    } else {
      return '$amount sats';
    }
  }

  // Handle Loop-In Quote
  Future<void> loopInQuote(BuildContext context) async {
    final overlayController = Get.find<OverlayController>();
    log('This is the loop-in amount: ${satController.text}');
    
    if (btcController.text == '0' || satController.text.isEmpty) {
      overlayController.showOverlay('Please enter an amount', color: AppTheme.errorColor);
      return;
    }

    int amount = int.tryParse(satController.text) ?? 0;
    int roundedAmount = amount.round();

    // Validate amount against Loop In terms
    if (!validateLoopAmount(roundedAmount, true)) {
      final errorMessage = getAmountErrorMessage(roundedAmount, true);
      overlayController.showOverlay(errorMessage, color: AppTheme.errorColor);
      return;
    }

    updateLoadingState(true);
    log('Loop-in amount: $roundedAmount');
    
    final userId = Auth().currentUser?.uid;
    if (userId == null) {
      overlayController.showOverlay('User not authenticated', color: AppTheme.errorColor);
      updateLoadingState(false);
      return;
    }
    
    final response = await getLoopinQuote(userId, roundedAmount.toString());

    if (response.statusCode == 'error') {
      overlayController.showOverlay(response.message, color: AppTheme.errorColor);
    } else {
      final loop = LoopQuoteModel.fromJson(response.data);
      log('Loop-in swap fee in SAT: ${loop.swapFeeSat}');
      _buildLoopInDialog(context, loop);
    }
    updateLoadingState(false);
  }

  // Handle Loop-Out Quote
  Future<void> loopOutQuote(BuildContext context) async {
    final overlayController = Get.find<OverlayController>();
    
    if (btcController.text == '0' || satController.text.isEmpty) {
      overlayController.showOverlay('Please enter an amount', color: AppTheme.errorColor);
      return;
    }

    int amount = int.tryParse(satController.text) ?? 0;
    int roundedAmount = amount.round();

    // Validate amount against Loop Out terms
    if (!validateLoopAmount(roundedAmount, false)) {
      final errorMessage = getAmountErrorMessage(roundedAmount, false);
      overlayController.showOverlay(errorMessage, color: AppTheme.errorColor);
      return;
    }

    updateLoadingState(true);
    log('Loop-out amount: $roundedAmount');

    final userId = Auth().currentUser?.uid;
    if (userId == null) {
      overlayController.showOverlay('User not authenticated', color: AppTheme.errorColor);
      updateLoadingState(false);
      return;
    }
    
    final response = await getLoopOutQuote(userId, roundedAmount.toString());
    if (response.statusCode == 'error') {
      overlayController.showOverlay(response.message, color: AppTheme.errorColor);
    } else {
      final loop = LoopQuoteModel.fromJson(response.data);
      log('Loop-out swap fee in SAT: ${loop.swapFeeSat}');
      _buildLoopOutDialog(context, loop);
    }
    updateLoadingState(false);
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
                loopOutFunc(mapData);
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
                        loopInFunc(mapData);
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
  Future<void> loopInFunc(Map<String, dynamic> data) async {
    // Implement the loop-in functionality
    // Example:
    final overlayController = Get.find<OverlayController>();
    updateLoadingState(true);
    try {
      // Call your loop-in function
      final userId = Auth().currentUser?.uid;
      if (userId == null) {
        overlayController.showOverlay('User not authenticated');
        return;
      }
      // Call your loop-in function
      await loopin(userId, data);
      overlayController.showOverlay('Loop-In successful!');
      // Optionally, refresh balances
      await fetchOnchainWalletBalance();
      await fetchLightningWalletBalance();
    } catch (e) {
      log('Error during loop-in: $e');
      overlayController.showOverlay('Loop-In failed: $e');
    } finally {
      updateLoadingState(false);
    }
  }

  Future<void> loopOutFunc(Map<String, dynamic> data) async {
    // Implement the loop-out functionality
    // Example:
    updateLoadingState(true);
    final overlayController = Get.find<OverlayController>();
    try {
      // Call your loop-out function
      final userId = Auth().currentUser?.uid;
      if (userId == null) {
        overlayController.showOverlay('User not authenticated');
        return;
      }
      // Call your loop-out function
      await loopOut(userId, data);
      overlayController.showOverlay('Loop-Out successful!');
      // Optionally, refresh balances
      await fetchOnchainWalletBalance();
      await fetchLightningWalletBalance();
    } catch (e) {
      log('Error during loop-out: $e');
      overlayController.showOverlay('Loop-Out failed: $e');
    } finally {
      updateLoadingState(false);
    }
  }

  // Get formatted limits text for UI display
  String getLoopLimitsText(bool isLoopIn) {
    final terms = isLoopIn ? loopInTerms.value : loopOutTerms.value;
    final operation = isLoopIn ? "Loop In" : "Loop Out";
    
    if (terms == null) {
      return "$operation limits: Loading...";
    }
    
    return "$operation limits: ${terms.getFormattedMinAmount()} - ${terms.getFormattedMaxAmount()}";
  }

  // Check if terms are loaded
  bool get areTermsLoaded => loopInTerms.value != null && loopOutTerms.value != null;

  // Refresh terms manually
  Future<void> refreshTerms() async {
    await fetchLoopTerms();
  }
}
