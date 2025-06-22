import 'package:bitnet/backbone/helper/currency/currency_converter.dart';
import 'package:bitnet/backbone/helper/currency/getcurrency.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:bitnet/backbone/streams/currency_provider.dart';
import 'package:bitnet/components/amountwidget.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetListTile.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/buttons/bottom_buybuttons.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/buttons/roundedbutton.dart';
import 'package:bitnet/components/appstandards/glasscontainer.dart';
import 'package:bitnet/components/dialogsandsheets/bottom_sheets/bit_net_bottom_sheet.dart';
import 'package:bitnet/models/currency/bitcoinunitmodel.dart';
import 'package:bitnet/pages/wallet/controllers/wallet_controller.dart';
import 'package:bitnet/pages/wallet/loop/controller/loop_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class LoopScreen extends StatefulWidget {
  const LoopScreen({
    super.key,
  });

  @override
  State<LoopScreen> createState() => _LoopScreenState();
}

class _LoopScreenState extends State<LoopScreen> {
  final loopGetController = Get.put(LoopGetxController());
  WalletsController walletController = Get.find<WalletsController>();

  // Focus nodes for the editable cards
  final FocusNode onchainFocusNode = FocusNode();
  final FocusNode lightningFocusNode = FocusNode();

  // Currency type toggle
  final RxBool swapped = false.obs;
  bool buttonDisabled = false;

  // Card type specific controllers
  // Lightning card controllers
  late TextEditingController lightningSatController;
  late TextEditingController lightningBtcController;
  late TextEditingController lightningCurrController;

  // Onchain card controllers
  late TextEditingController onchainSatController;
  late TextEditingController onchainBtcController;
  late TextEditingController onchainCurrController;

  // Amount widget controllers
  late AmountWidgetController lightningAmtController;
  late AmountWidgetController onchainAmtController;

  CardType topCardType = CardType.onchain;
  CardType bottomCardType = CardType.lightning;

  @override
  void initState() {
    super.initState();
    WalletsController walletController = Get.find<WalletsController>();

    // Initialize all controllers
    lightningSatController = TextEditingController(text: "0");
    lightningBtcController = TextEditingController(text: "0.0");
    lightningCurrController = TextEditingController(text: "0.0");

    onchainSatController = TextEditingController(text: "0");
    onchainBtcController = TextEditingController(text: "0.0");
    onchainCurrController = TextEditingController(text: "0.0");

    WidgetsBinding.instance.addPostFrameCallback((_) {
      walletController.predictedLightningBalance.value =
          walletController.lightningBalance.value.balance;

      walletController.predictedBtcBalance.value =
          walletController.onchainBalance.value.confirmedBalance;

      setState(() {});
    });

    // Setup amount in controller based on the focus nodes
    onchainFocusNode.addListener(() {
      if (onchainFocusNode.hasFocus) {
        loopGetController.scrollToBottom();
      }
    });

    lightningFocusNode.addListener(() {
      if (lightningFocusNode.hasFocus) {
        loopGetController.scrollToBottom();
      }
    });

    lightningAmtController = AmountWidgetController();
    onchainAmtController = AmountWidgetController();
    lightningAmtController.initialize(() => setState(() {}),
        lightningBtcController, lightningSatController, lightningCurrController,
        initialSwapped: Get.find<WalletsController>().reversed.value,
        storeControllers: true);
    onchainAmtController.initialize(
        () => setState(() {}),
        onchainBtcController,
        initialSwapped: Get.find<WalletsController>().reversed.value,
        onchainSatController,
        onchainCurrController,
        storeControllers: true);

    lightningSatController.addListener(() {
      if (lightningAmtController.currentUnit == BitcoinUnits.SAT &&
          !Get.find<WalletsController>().reversed.value &&
          lightningFocusNode.hasFocus) {
        if (lightningSatController.text == "") {
          lightningCurrController.text = "0.0";
          lightningBtcController.text = "0.0";
          if (topCardType != CardType.lightning &&
              bottomCardType != CardType.lightning) return;
          getCardVariables(topCardType == CardType.lightning
                  ? bottomCardType
                  : topCardType)['satController']
              .text = "0";
          getCardVariables(topCardType == CardType.lightning
                  ? bottomCardType
                  : topCardType)['btcController']
              .text = "0.0";
          getCardVariables(topCardType == CardType.lightning
                  ? bottomCardType
                  : topCardType)['currController']
              .text = "0.0";
          updateBalance("0", false);
        }
      }
    });
    lightningBtcController.addListener(() {
      if (lightningAmtController.currentUnit == BitcoinUnits.SAT &&
          !Get.find<WalletsController>().reversed.value &&
          lightningFocusNode.hasFocus) {
        if (lightningBtcController.text == "") {
          lightningCurrController.text = "0.0";
          lightningSatController.text = "0";
          if (topCardType != CardType.lightning &&
              bottomCardType != CardType.lightning) return;
          getCardVariables(topCardType == CardType.lightning
                  ? bottomCardType
                  : topCardType)['satController']
              .text = "0";
          getCardVariables(topCardType == CardType.lightning
                  ? bottomCardType
                  : topCardType)['btcController']
              .text = "0.0";
          getCardVariables(topCardType == CardType.lightning
                  ? bottomCardType
                  : topCardType)['currController']
              .text = "0.0";
          updateBalance("0", false);
        }
      }
    });
    lightningCurrController.addListener(() {
      if (Get.find<WalletsController>().reversed.value &&
          lightningFocusNode.hasFocus) {
        if (lightningCurrController.text == "") {
          lightningSatController.text = "0";
          lightningBtcController.text = "0.0";
          getCardVariables(topCardType == CardType.lightning
                  ? bottomCardType
                  : topCardType)['satController']
              .text = "0";
          getCardVariables(topCardType == CardType.lightning
                  ? bottomCardType
                  : topCardType)['btcController']
              .text = "0.0";
          getCardVariables(topCardType == CardType.lightning
                  ? bottomCardType
                  : topCardType)['currController']
              .text = "0.0";
          updateBalance("0", false);
        }
      }
    });

    onchainSatController.addListener(() {
      if (onchainAmtController.currentUnit == BitcoinUnits.SAT &&
          !Get.find<WalletsController>().reversed.value &&
          onchainFocusNode.hasFocus) {
        if (onchainSatController.text == "") {
          onchainCurrController.text = "0.0";
          onchainBtcController.text = "0.0";
          if (topCardType != CardType.onchain &&
              bottomCardType != CardType.onchain) return;
          getCardVariables(topCardType == CardType.onchain
                  ? bottomCardType
                  : topCardType)['satController']
              .text = "0";
          getCardVariables(topCardType == CardType.onchain
                  ? bottomCardType
                  : topCardType)['btcController']
              .text = "0.0";
          getCardVariables(topCardType == CardType.onchain
                  ? bottomCardType
                  : topCardType)['currController']
              .text = "0.0";
          updateBalance("0", true);
        }
      }
    });
    onchainBtcController.addListener(() {
      if (onchainAmtController.currentUnit == BitcoinUnits.SAT &&
          !Get.find<WalletsController>().reversed.value &&
          onchainFocusNode.hasFocus) {
        if (onchainBtcController.text == "") {
          onchainCurrController.text = "0.0";
          onchainSatController.text = "0";
          if (topCardType != CardType.onchain &&
              bottomCardType != CardType.onchain) return;
          getCardVariables(topCardType == CardType.onchain
                  ? bottomCardType
                  : topCardType)['satController']
              .text = "0";
          getCardVariables(topCardType == CardType.onchain
                  ? bottomCardType
                  : topCardType)['btcController']
              .text = "0.0";
          getCardVariables(topCardType == CardType.onchain
                  ? bottomCardType
                  : topCardType)['currController']
              .text = "0.0";
          updateBalance("0", true);
        }
      }
    });
    onchainCurrController.addListener(() {
      if (Get.find<WalletsController>().reversed.value &&
          onchainFocusNode.hasFocus) {
        if (onchainCurrController.text == "") {
          onchainSatController.text = "0";
          onchainBtcController.text = "0.0";
          getCardVariables(topCardType == CardType.onchain
                  ? bottomCardType
                  : topCardType)['satController']
              .text = "0";
          getCardVariables(topCardType == CardType.onchain
                  ? bottomCardType
                  : topCardType)['btcController']
              .text = "0.0";
          getCardVariables(topCardType == CardType.onchain
                  ? bottomCardType
                  : topCardType)['currController']
              .text = "0.0";
          updateBalance("0", true);
        }
      }
    });
  }

  @override
  void dispose() {
    // Clear controller values in the loopGetController
    loopGetController.satController.clear();
    loopGetController.btcController.clear();
    loopGetController.currencyController.clear();

    // Dispose our text controllers
    lightningSatController.dispose();
    lightningBtcController.dispose();
    lightningCurrController.dispose();
    onchainSatController.dispose();
    onchainBtcController.dispose();
    onchainCurrController.dispose();

    // Dispose focus nodes
    onchainFocusNode.dispose();
    lightningFocusNode.dispose();
    lightningAmtController.disposeListeners(lightningBtcController,
        lightningSatController, lightningCurrController);
    onchainAmtController.disposeListeners(
        onchainBtcController, onchainSatController, onchainCurrController);

    super.dispose();
  }

  // Get the appropriate controllers based on card type
  Map<String, dynamic> getCardVariables(CardType cardType) {
    if (cardType == CardType.lightning) {
      final predictedBalanceStr =
          walletController.predictedLightningBalance.value;
      final confirmedBalanceStr =
          walletController.lightningBalance.value.balance;

      // Safely parse the string balances to doubles
      final predictedBalance = double.tryParse(predictedBalanceStr) ?? 0.0;

      // Format the predicted balance to 8 decimal places
      final formattedBalance = predictedBalance.toStringAsFixed(8);
      
      return {
        'satController': lightningSatController,
        'btcController': lightningBtcController,
        'currController': lightningCurrController,
        'focusNode': lightningFocusNode,
        'amtController': lightningAmtController,
        'balance': formattedBalance,
        'confirmedBalance': confirmedBalanceStr,
        'otherCardConfirmedBalance':
            walletController.onchainBalance.value.confirmedBalance
      };
    } else {
      // CardType.onchain
      final predictedBtcBalanceStr = walletController.predictedBtcBalance.value;
      final confirmedBalanceStr =
          walletController.onchainBalance.value.confirmedBalance;
      final unconfirmedBalanceStr =
          walletController.onchainBalance.value.unconfirmedBalance;

      // Safely parse the string balances to doubles
      final predictedBtcBalance =
          double.tryParse(predictedBtcBalanceStr) ?? 0.0;

      final formattedBalance = predictedBtcBalance.toStringAsFixed(8);

      return {
        'satController': onchainSatController,
        'btcController': onchainBtcController,
        'currController': onchainCurrController,
        'focusNode': onchainFocusNode,
        'amtController': onchainAmtController,
        'balance': formattedBalance,
        'confirmedBalance': confirmedBalanceStr,
        'unconfirmedBalance': unconfirmedBalanceStr,
        'otherCardConfirmedBalance':
            walletController.lightningBalance.value.balance
      };
    }
  }

  bool checkOverBound(TextEditingController satController,
      String confirmedBalance, String otherConfirmedBalance, bool isPayCard) {
    if (isPayCard) {
      return (double.tryParse(satController.text) ?? 0) >
          (double.tryParse(confirmedBalance) ?? 0);
    } else {
      return (double.tryParse(satController.text) ?? 0) >
          (double.tryParse(otherConfirmedBalance) ?? 0);
    }
  }

  // Updates the corresponding balance with the new input value
  void updateBalance(String text, bool isOnchain) {
    if (text.isEmpty) text = "0";

    final double amount = double.tryParse(text) ?? 0.0;

    if (isOnchain) {
      // Update onchain balance
      walletController.predictedBtcBalance.value = amount.toString();
    } else {
      // Update lightning balance
      walletController.predictedLightningBalance.value = amount.toString();
    }

    // Update controller values for the swap functions
    loopGetController.satController.text = amount.toString();

    setState(() {});
  }

  // Toggle the currency type (between BTC/SAT and fiat currency)
  void toggleCurrencyType() {
    swapped.value = !swapped.value;
    walletController.setAmtWidgetReversed(swapped.value);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (bool bool) {
        if (bool) {
          context.go('/feed');
        }
      },
      child: bitnetScaffold(
        extendBodyBehindAppBar: true,
        context: context,
        resizeToAvoidBottomInset: true,
        appBar: bitnetAppBar(
          text: "Swap Screen",
          context: context,
          onTap: () {
            context.go('/feed');
          },
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              controller: loopGetController.scrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: AppTheme.cardPadding * 3.5),
                  Container(
                    height: AppTheme.cardPadding * (7.5 * 2 + 1),
                    child: Stack(
                      children: [
                        Column(
                          children: [
                            // ONCHAIN CARD ("YOU PAY" when animate is true or "YOU RECEIVE" when animate is false)
                            Container(
                                height: AppTheme.cardPadding * 7.5,
                                margin: const EdgeInsets.symmetric(
                                    horizontal: AppTheme.cardPadding),
                                child: Obx(() {
                                  // Get onchain card variables
                                  final cardVars =
                                      getCardVariables(topCardType);

                                  return EditableBalanceCard(
                                    balance: cardVars['balance'],
                                    confirmedBalance:
                                        cardVars['confirmedBalance'],
                                    unconfirmedBalance: cardVars
                                            .containsKey('unconfirmedBalance')
                                        ? cardVars['unconfirmedBalance']
                                        : null,
                                    otherCardConfirmedBalance:
                                        cardVars['otherCardConfirmedBalance'],
                                    defaultUnit: BitcoinUnits.SAT,
                                    cardType: topCardType,
                                    cardTitle: loopGetController.animate.value
                                        ? "You Pay"
                                        : "You Receive",
                                    focusNode: cardVars['focusNode'],
                                    satController: cardVars['satController'],
                                    btcController: cardVars['btcController'],
                                    currController: cardVars['currController'],
                                    isPayCard: loopGetController.animate.value,
                                    amtController: cardVars['amtController'],
                                    otherAmtController: getCardVariables(
                                        bottomCardType)['amtController'],
                                    onChanged: (value) =>
                                        updateBalance(value, true),
                                    boundState: checkOverBound(
                                            cardVars['satController'],
                                            cardVars['confirmedBalance'],
                                            cardVars[
                                                'otherCardConfirmedBalance'],
                                            loopGetController.animate.value)
                                        ? 1
                                        : 0,
                                    handleCurrencySelection: (type) {
                                      if (type != topCardType) {
                                        CardType temp = topCardType;
                                        topCardType = bottomCardType;
                                        bottomCardType = temp;

                                        setState(() {});
                                      }
                                    },
                                  );
                                })),

                            Container(
                              height: AppTheme.cardPadding * 1,
                            ),
                            // LIGHTNING CARD ("YOU RECEIVE" when animate is true or "YOU PAY" when animate is false)
                            Container(
                              height: AppTheme.cardPadding * 7.5,
                              margin: const EdgeInsets.symmetric(
                                horizontal: AppTheme.cardPadding,
                              ),
                              child: Obx(() {

                                // Get lightning card variables
                                final cardVars =
                                    getCardVariables(bottomCardType);

                                return EditableBalanceCard(
                                  balance: cardVars['balance'],
                                  confirmedBalance:
                                      cardVars['confirmedBalance'],
                                  unconfirmedBalance:
                                      cardVars.containsKey('unconfirmedBalance')
                                          ? cardVars['unconfirmedBalance']
                                          : null,
                                  otherCardConfirmedBalance:
                                      cardVars['otherCardConfirmedBalance'],
                                  defaultUnit: BitcoinUnits.SAT,
                                  cardType: bottomCardType,
                                  cardTitle: loopGetController.animate.value
                                      ? "You Receive"
                                      : "You Pay",
                                  focusNode: cardVars['focusNode'],
                                  satController: cardVars['satController'],
                                  btcController: cardVars['btcController'],
                                  currController: cardVars['currController'],
                                  isPayCard: !loopGetController.animate.value,
                                  amtController: cardVars['amtController'],
                                  otherAmtController: getCardVariables(
                                      topCardType)['amtController'],
                                  onChanged: (value) =>
                                      updateBalance(value, false),
                                  boundState: checkOverBound(
                                          cardVars['satController'],
                                          cardVars['confirmedBalance'],
                                          cardVars['otherCardConfirmedBalance'],
                                          !loopGetController.animate.value)
                                      ? 1
                                      : 0,
                                  handleCurrencySelection: (type) {
                                    if (type != bottomCardType) {
                                      CardType temp = topCardType;
                                      topCardType = bottomCardType;
                                      bottomCardType = temp;

                                      setState(() {});
                                    }
                                  },
                                );
                              }),
                            ),
                          ],
                        ),
                        // CONTROL BUTTONS IN THE MIDDLE
                        Align(
                          alignment: Alignment.center,
                          child: GlassContainer(
                            borderRadius: BorderRadius.circular(AppTheme.borderRadiusSmall),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: AppTheme.elementSpacing * 0.5,
                                vertical: AppTheme.elementSpacing * 0.25,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  // Currency swap button
                                  GestureDetector(
                                    onTap: () {
                                      CardType temp = topCardType;
                                      topCardType = bottomCardType;
                                      bottomCardType = temp;

                                      setState(() {});
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(8),
                                      child: Icon(
                                        Icons.swap_vert,
                                        size: 20,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurface,
                                      ),
                                    ),
                                  ),

                                  // Divider
                                  Container(
                                    height: 24,
                                    width: 1,
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 4),
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurface
                                        .withOpacity(0.2),
                                  ),

                                  // Direction arrow button
                                  Obx(() => InkWell(
                                        onTap: () {
                                          loopGetController.changeAnimate();
                                          double lightningBalance =
                                              double.parse(walletController
                                                  .predictedLightningBalance
                                                  .value);
                                          double normalLightningBalance =
                                              double.parse(walletController
                                                  .lightningBalance
                                                  .value
                                                  .balance);
                                          double difference =
                                              normalLightningBalance -
                                                  lightningBalance;
                                          walletController
                                                  .predictedBtcBalance.value =
                                              (double.parse(walletController
                                                          .onchainBalance
                                                          .value
                                                          .confirmedBalance) -
                                                      difference)
                                                  .toString();
                                          walletController
                                              .predictedLightningBalance
                                              .value = (double.parse(
                                                      walletController
                                                          .lightningBalance
                                                          .value
                                                          .balance) +
                                                  difference)
                                              .toString();
                                        },
                                        borderRadius: BorderRadius.circular(
                                            AppTheme.cardPadding * 0.5),
                                        child: Container(
                                          padding: const EdgeInsets.all(8),
                                          child: Transform.rotate(
                                            angle: loopGetController
                                                    .animate.value
                                                ? 0
                                                : 3.14159, // 180 degrees in radians
                                            child: Icon(
                                              Icons.arrow_downward,
                                              size: 20,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onSurface,
                                            ),
                                          ),
                                        ),
                                      )),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppTheme.cardPadding * 5.5),
                ],
              ),
            ),
            Obx(
              () => BottomCenterButton(
                buttonTitle: loopGetController.animate.value
                    ? L10n.of(context)!.onChainLightning
                    : L10n.of(context)!.lightningOnChain,
                onButtonTap: () {
                  loopGetController.animate.value
                      ? loopGetController.loopInQuote(context)
                      : loopGetController.loopOutQuote(context);
                },
                buttonState: (checkOverBound(
                            getCardVariables(topCardType)['satController'],
                            getCardVariables(topCardType)['confirmedBalance'],
                            getCardVariables(
                                topCardType)['otherCardConfirmedBalance'],
                            loopGetController.animate.value) ||
                        checkOverBound(
                            getCardVariables(bottomCardType)['satController'],
                            getCardVariables(
                                bottomCardType)['confirmedBalance'],
                            getCardVariables(
                                bottomCardType)['otherCardConfirmedBalance'],
                            !loopGetController.animate.value))
                    ? ButtonState.disabled
                    : loopGetController.loadingState.value
                        ? ButtonState.loading
                        : ButtonState.idle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

enum CardType { onchain, lightning }

// Enum for currency types
enum CurrencyType { bitcoin, lightning }

class CurrencySelector extends StatelessWidget {
  final CurrencyType currentType;
  final Function(CurrencyType) onCurrencyChanged;

  const CurrencySelector({
    Key? key,
    required this.currentType,
    required this.onCurrencyChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showCurrencySelectionSheet(context),
      child: GlassContainer(
        borderRadius: BorderRadius.circular(AppTheme.borderRadiusMid),
        height: AppTheme.cardPadding * 2,
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppTheme.elementSpacing * 0.5,
            vertical: AppTheme.elementSpacing * 0.5,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Dropdown icon
              Icon(
                Icons.keyboard_arrow_down_rounded,
                size: AppTheme.cardPadding,
                color: Theme.of(context).colorScheme.onSurface,
              ),
              const SizedBox(width: 4),
              // Currency icon
              Image.asset(
                currentType == CurrencyType.bitcoin
                    ? 'assets/images/bitcoin.png'
                    : 'assets/images/lightning.png',
                width: AppTheme.cardPadding * 1.25,
                height: AppTheme.cardPadding * 1.25,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showCurrencySelectionSheet(BuildContext context) {
    BitNetBottomSheet(
      context: context,
      child: bitnetScaffold(
        context: context,
        extendBodyBehindAppBar: true,
        appBar: bitnetAppBar(
          context: context,
          text: "Select Currency",
          hasBackButton: false,
        ),
        body: Column(
          children: [
            const SizedBox(height: AppTheme.cardPadding * 2),
            BitNetListTile(
              text: "Bitcoin",
              leading: Image.asset(
                'assets/images/bitcoin.png',
                width: 32,
                height: 32,
              ),
              selected: currentType == CurrencyType.bitcoin,
              isActive: currentType == CurrencyType.bitcoin,
              trailing: currentType == CurrencyType.bitcoin
                  ? Icon(
                      Icons.check,
                      color: Theme.of(context).colorScheme.primary,
                    )
                  : null,
              onTap: () {
                onCurrencyChanged(CurrencyType.bitcoin);
                Navigator.pop(context);
              },
            ),
            BitNetListTile(
              text: "Lightning",
              leading: Image.asset(
                'assets/images/lightning.png',
                width: 32,
                height: 32,
              ),
              selected: currentType == CurrencyType.lightning,
              isActive: currentType == CurrencyType.lightning,
              trailing: currentType == CurrencyType.lightning
                  ? Icon(
                      Icons.check,
                      color: Theme.of(context).colorScheme.primary,
                    )
                  : null,
              onTap: () {
                onCurrencyChanged(CurrencyType.lightning);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class EditableBalanceCard extends StatefulWidget {
  final String balance;
  final String confirmedBalance;
  final String? unconfirmedBalance;
  final BitcoinUnits defaultUnit;
  final CardType cardType;
  final String cardTitle;
  final FocusNode focusNode;
  final Function(String) onChanged;
  final AmountWidgetController amtController;
  final AmountWidgetController otherAmtController;
  final String otherCardConfirmedBalance;
  final bool isPayCard;
  final TextEditingController satController;
  final TextEditingController btcController;
  final TextEditingController currController;
  final int boundState;
  final Function(CardType) handleCurrencySelection;

  const EditableBalanceCard({
    Key? key,
    required this.balance,
    required this.confirmedBalance,
    this.unconfirmedBalance,
    this.defaultUnit = BitcoinUnits.SAT,
    required this.cardType,
    required this.cardTitle,
    required this.focusNode,
    required this.onChanged,
    required this.amtController,
    required this.otherAmtController,
    required this.isPayCard,
    required this.otherCardConfirmedBalance,
    required this.satController,
    required this.btcController,
    required this.currController,
    required this.boundState,
    required this.handleCurrencySelection,
  }) : super(key: key);

  @override
  State<EditableBalanceCard> createState() => _EditableBalanceCardState();
}

class _EditableBalanceCardState extends State<EditableBalanceCard> {
  String _alternateValue = "0.00";

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  // Helper method to get the correct available balance based on card type
  String _getAvailableBalance(CardType cardType) {
    // Use the confirmedBalance that was passed to this widget
    // This balance should already be the correct one for the card type
    final balance = double.tryParse(widget.confirmedBalance) ?? 0.0;
    
    // Show the actual raw values in sats - no fancy formatting
    return '${balance.toStringAsFixed(0)} sats';
  }

  //0 for inbound, 1 for overbound, 2 for underbound
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      Get.find<WalletsController>().reversed.value;
      final bool isOnchain = widget.cardType == CardType.onchain;
      final String? currency =
          Provider.of<CurrencyChangeProvider>(context).selectedCurrency ??
              "USD";
      final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
      final chartLine = Get.find<WalletsController>().chartLines.value;
      final bitcoinPrice = chartLine?.price;

      // Get the appropriate unit and icon based on swapped state
      final IconData currencyIcon = Get.find<WalletsController>().reversed.value
          ? getCurrencyIcon(currency!)
          : getCurrencyIcon(widget.defaultUnit.name);

      final String alternateUnitName =
          Get.find<WalletsController>().reversed.value
              ? widget.defaultUnit.name
              : currency!;

      return GlassContainer(
        borderRadius: BorderRadius.circular(24),
        boxShadow: isDarkMode ? [] : [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          )
        ],
        child: Stack(
          children: [
            // Main Card Content
            Padding(
              padding: EdgeInsets.all(AppTheme.cardPadding.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Available balance at the top - show correct balance based on card type
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Available: ${_getAvailableBalance(widget.cardType)}",
                        style: TextStyle(
                          fontSize: 14,
                          color:
                              isDarkMode ? AppTheme.white60 : AppTheme.black60,
                        ),
                      ),
                    ],
                  ),

                  Spacer(),

                  // Card title ("You Pay" or "You Receive")
                  Text(widget.cardTitle,
                      style: Theme.of(context).textTheme.titleSmall),

                  SizedBox(height: AppTheme.elementSpacing * 0.5.h),

                  // Editable amount field with currency icon
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Expanded(
                        child: TextField(
                          controller: widget.amtController.getCurrentController(
                              widget.btcController,
                              widget.satController,
                              widget.currController,
                              swapAlternative:
                                  Get.find<WalletsController>().reversed.value),
                          focusNode: widget.focusNode,
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true),
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: (double.tryParse(widget.amtController
                                            .getCurrentController(
                                                widget.btcController,
                                                widget.satController,
                                                widget.currController,
                                                swapAlternative: Get.find<
                                                        WalletsController>()
                                                    .reversed
                                                    .value)
                                            .text) ??
                                        0) >
                                    0
                                ? widget.isPayCard
                                    ? AppTheme.errorColor
                                    : AppTheme.successColor
                                : isDarkMode
                                    ? Colors.white
                                    : Colors.black,
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.zero,
                            isDense: true,
                            hintText: "0.0",
                            hintStyle: TextStyle(
                              color: isDarkMode
                                  ? AppTheme.white60
                                  : AppTheme.black60,
                            ),
                          ),
                          onChanged: (value) {
                            if (!Get.find<WalletsController>().reversed.value) {
                              widget.currController.text =
                                  CurrencyConverter.convertCurrency(
                                      widget.amtController.currentUnit.name,
                                      double.tryParse(value) ?? 0,
                                      currency ?? "USD",
                                      bitcoinPrice);
                            } else {
                              widget.satController.text =
                                  CurrencyConverter.convertCurrency(
                                      currency ?? "USD",
                                      double.tryParse(
                                              widget.currController.text) ??
                                          0,
                                      BitcoinUnits.SAT.name,
                                      bitcoinPrice);
                              widget.btcController.text =
                                  CurrencyConverter.convertCurrency(
                                      currency ?? "USD",
                                      double.tryParse(
                                              widget.currController.text) ??
                                          0,
                                      BitcoinUnits.BTC.name,
                                      bitcoinPrice);
                            }

                            var unitEquivalent =
                                CurrencyConverter.convertToBitcoinUnit(
                                    double.tryParse(value) ?? 0,
                                    widget.amtController.currentUnit);
                            widget.amtController.processAutoConvert(
                                unitEquivalent,
                                widget.btcController,
                                widget.satController,
                                () => setState(() {}));

                            widget.otherAmtController.satController!.text =
                                widget.satController.text;
                            widget.otherAmtController.btcController!.text =
                                widget.btcController.text;
                            widget.otherAmtController.currController!.text =
                                widget.currController.text;
                            widget.onChanged(widget.satController.text);

                            //  _updateAlternateValue(value);
                          },
                          inputFormatters:
                              widget.amtController.getInputFormatters(
                            hasBoundType: true,
                            context: context,
                            currency: currency ?? "USD",
                            bitcoinPrice: bitcoinPrice,
                            lowerBound: 0,
                            swapAlternative:
                                Get.find<WalletsController>().reversed.value,
                            upperBound: int.tryParse(widget.isPayCard
                                    ? widget.confirmedBalance
                                    : widget.otherCardConfirmedBalance) ??
                                null,
                            boundType: BitcoinUnits.SAT,
                            overBoundCallback: (double currentVal) {
                              // print("overbound");
                              // boundState = 1;
                              // widget.disableWideButton();
                              // setState(() {});
                            },
                            underBoundCallback: (double currentVal) {
                              // boundState = 2;
                              // widget.disableWideButton();

                              // setState(() {});
                            },
                            inBoundCallback: (double currentVal) {
                              // boundState = 0;
                              // widget.enableWideButton();
                              // setState(() {});
                            },
                          ),
                        ),
                      ),
                      RoundedButtonWidget(
                        buttonType: ButtonType.transparent,
                        size: AppTheme.cardPadding * 1.5,
                        iconData: Icons.swap_vert,
                        onTap: () {
                          ;
                          Get.find<WalletsController>().setAmtWidgetReversed(
                              !Get.find<WalletsController>().reversed.value);
                          if (Get.find<WalletsController>().reversed.value) {
                            final chartLine =
                                Get.find<WalletsController>().chartLines.value;
                            String curr = currency ?? "USD";

                            final bitcoinPrice = chartLine?.price;
                            final currencyEquivalent = bitcoinPrice != null
                                ? CurrencyConverter.convertCurrency(
                                    widget.amtController.currentUnit.name,
                                    widget.amtController.currentUnit ==
                                            BitcoinUnits.BTC
                                        ? double.parse(
                                            widget.btcController.text.isEmpty
                                                ? "0.0"
                                                : widget.btcController.text)
                                        : int.parse(widget
                                                    .satController.text.isEmpty
                                                ? "0"
                                                : widget.satController.text)
                                            .toDouble(),
                                    curr,
                                    bitcoinPrice,
                                    fixed: false)
                                : "0.00";

                            widget.currController.text =
                                double.parse(currencyEquivalent)
                                    .toStringAsFixed(2);
                          } else {
                            final chartLine =
                                Get.find<WalletsController>().chartLines.value;
                            String curr = currency ?? "USD";

                            final bitcoinPrice = chartLine?.price;
                            final currencyEquivalent = bitcoinPrice != null
                                ? CurrencyConverter.convertCurrency(
                                    curr,
                                    double.parse(
                                        widget.currController.text.isEmpty
                                            ? "0.0"
                                            : widget.currController.text),
                                    widget.amtController.currentUnit.name,
                                    bitcoinPrice)
                                : "0.00";

                            widget.btcController.text = currencyEquivalent;
                          }
                          widget.focusNode.unfocus();
                          setState(() {});
                        },
                      ),
                    ],
                  ),

                  // Alternative currency value
                  Obx(() {
                    // Listen to chart updates for price changes
                    Get.find<WalletsController>().chartLines.value;

                    return Row(
                      children: [
                        Text(
                          "≈ ${Get.find<WalletsController>().reversed.value ? (widget.amtController.currentUnit == BitcoinUnits.SAT ? widget.satController.text : widget.btcController.text) : widget.currController.text} ${Get.find<WalletsController>().reversed.value ? "" : getCurrency(alternateUnitName)}",
                          style: TextStyle(
                            fontSize: 14,
                            color: isDarkMode
                                ? AppTheme.white60
                                : AppTheme.black60,
                          ),
                        ),
                        if (Get.find<WalletsController>().reversed.value) ...[
                          SizedBox(
                            width: 4,
                          ),
                          Icon(getCurrencyIcon(alternateUnitName))
                        ]
                      ],
                    );
                  }),

                  if (widget.boundState != 0)
                    Text(
                      widget.boundState == 1
                          ? "You do not have the necessary funds."
                          : "You cannot send negative values.",
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(color: AppTheme.errorColor),
                    )
                ],
              ),
            ),

            // Currency Selector - positioned at top right
            Positioned(
              right: AppTheme.cardPadding.w * 0.75,
              top: AppTheme.cardPadding.w * 0.75,
              child: GestureDetector(
                onTap: () => _showCurrencySelectionSheet(context, isOnchain),
                child: GlassContainer(
                  borderRadius: BorderRadius.circular(500),
                  child: Padding(
                    padding:
                        const EdgeInsets.all(AppTheme.elementSpacing * 0.5),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(width: AppTheme.elementSpacing * 0.5),
                        Icon(
                          Icons.keyboard_arrow_down_rounded,
                          size: 16,
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                        const SizedBox(width: AppTheme.elementSpacing * 0.5),
                        _buildCurrencyIcon(isOnchain),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildCurrencyIcon(bool isOnchain) {
    return Container(
      width: AppTheme.cardPadding * 1.25.w,
      height: AppTheme.cardPadding * 1.25.w,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: Image.asset(
          isOnchain
              ? 'assets/images/bitcoin.png'
              : 'assets/images/lightning.png',
          width: AppTheme.cardPadding * 1.25.w,
          height: AppTheme.cardPadding * 1.25.w,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  void _showCurrencySelectionSheet(BuildContext context, bool isOnchain) {
    BitNetBottomSheet(
      context: context,
      child: bitnetScaffold(
        context: context,
        extendBodyBehindAppBar: true,
        appBar: bitnetAppBar(
          context: context,
          text: "Select Currency",
          hasBackButton: false,
        ),
        body: Column(
          children: [
            const SizedBox(height: AppTheme.cardPadding * 2),
            BitNetListTile(
              text: "Bitcoin",
              leading: Image.asset(
                'assets/images/bitcoin.png',
                width: 32,
                height: 32,
              ),
              selected: isOnchain,
              isActive: isOnchain,
              trailing: isOnchain
                  ? Icon(
                      Icons.check,
                      color: Theme.of(context).colorScheme.primary,
                    )
                  : null,
              onTap: () {
                // Handle currency selection
                widget.handleCurrencySelection(CardType.onchain);
                Navigator.pop(context);
              },
            ),
            BitNetListTile(
              text: "Lightning",
              leading: Image.asset(
                'assets/images/lightning.png',
                width: 32,
                height: 32,
              ),
              selected: !isOnchain,
              isActive: !isOnchain,
              trailing: !isOnchain
                  ? Icon(
                      Icons.check,
                      color: Theme.of(context).colorScheme.primary,
                    )
                  : null,
              onTap: () {
                // Handle currency selection
                widget.handleCurrencySelection(CardType.lightning);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
