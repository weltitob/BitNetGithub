import 'package:bitnet/backbone/helper/currency/currency_converter.dart';
import 'package:bitnet/backbone/helper/currency/getcurrency.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:bitnet/backbone/streams/currency_provider.dart';
import 'package:bitnet/backbone/streams/currency_type_provider.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/buttons/bottom_buybuttons.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/buttons/roundedbutton.dart';
import 'package:bitnet/components/items/balancecard.dart';
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

  @override
  void initState() {
    super.initState();
    WalletsController walletController = Get.find<WalletsController>();

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
  }

  @override
  void dispose() {
    loopGetController.satController.clear();
    loopGetController.btcController.clear();
    loopGetController.currencyController.clear();
    
    onchainFocusNode.dispose();
    lightningFocusNode.dispose();
    
    super.dispose();
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
                                  final logger = Get.find<LoggerService>();
                                  // Extracting reactive variables from the controller
                                  final predictedBtcBalanceStr = walletController.predictedBtcBalance.value;
                                  final confirmedBalanceStr = walletController.onchainBalance.value.confirmedBalance;
                                  final unconfirmedBalanceStr = walletController.onchainBalance.value.unconfirmedBalance;

                                  // Safely parse the string balances to doubles
                                  final predictedBtcBalance = double.tryParse(predictedBtcBalanceStr) ?? 0.0;
                                  final confirmedBalance = double.tryParse(confirmedBalanceStr) ?? 0.0;
                                  final unconfirmedBalance = double.tryParse(unconfirmedBalanceStr) ?? 0.0;

                                  logger.i('predictedBtcBalance: $predictedBtcBalance');
                                  logger.i('confirmedBalance: $confirmedBalance');
                                  logger.i('unconfirmedBalance: $unconfirmedBalance');

                                  // Determine text color based on balance comparison
                                  Color? textColor;
                                  if (confirmedBalance < predictedBtcBalance) {
                                    textColor = AppTheme.successColor;
                                  } else if (confirmedBalance > predictedBtcBalance) {
                                    textColor = AppTheme.errorColor;
                                  } else {
                                    textColor = null;
                                  }

                                  // Format the predicted balance to 8 decimal places
                                  final formattedBalance = predictedBtcBalance.toStringAsFixed(8);

                                  return EditableBalanceCard(
                                    balance: formattedBalance,
                                    confirmedBalance: confirmedBalanceStr,
                                    unconfirmedBalance: unconfirmedBalanceStr,
                                    defaultUnit: BitcoinUnits.SAT,
                                    textColor: textColor,
                                    cardType: CardType.onchain,
                                    cardTitle: loopGetController.animate.value 
                                        ? "You Pay" 
                                        : "You Receive",
                                    focusNode: onchainFocusNode,
                                    onChanged: (value) => updateBalance(value, true),
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
                                final logger = Get.find<LoggerService>();
                                // Extracting reactive variables from the controller
                                final predictedBalanceStr = walletController.predictedLightningBalance.value;
                                final confirmedBalanceStr = walletController.lightningBalance.value.balance;

                                // Safely parse the string balances to doubles
                                final predictedBalance = double.tryParse(predictedBalanceStr) ?? 0.0;
                                final confirmedBalance = double.tryParse(confirmedBalanceStr) ?? 0.0;

                                logger.i('predictedBalance: $predictedBalance');
                                logger.i('confirmedBalance: $confirmedBalance');

                                // Determine text color based on balance comparison
                                Color? textColor;
                                if (confirmedBalance < predictedBalance) {
                                  textColor = AppTheme.successColor;
                                } else if (confirmedBalance > predictedBalance) {
                                  textColor = AppTheme.errorColor;
                                } else {
                                  textColor = null;
                                }

                                // Format the predicted balance to 8 decimal places
                                final formattedBalance = predictedBalance.toStringAsFixed(8);

                                return EditableBalanceCard(
                                  balance: formattedBalance,
                                  confirmedBalance: confirmedBalanceStr,
                                  defaultUnit: BitcoinUnits.SAT,
                                  textColor: textColor,
                                  cardType: CardType.lightning,
                                  cardTitle: loopGetController.animate.value 
                                      ? "You Receive" 
                                      : "You Pay",
                                  focusNode: lightningFocusNode,
                                  onChanged: (value) => updateBalance(value, false),
                                );
                              }),
                            ),
                          ],
                        ),
                        // SWAP ARROW BUTTON
                        Align(
                          alignment: Alignment.center,
                          child: Obx(() => AnimatedRotation(
                                turns: loopGetController.animate.value
                                    ? 1 / 2
                                    : 3 / 2,
                                duration: const Duration(milliseconds: 400),
                                child: RotatedBox(
                                  quarterTurns:
                                      loopGetController.animate.value ? 1 : 3,
                                  child: RoundedButtonWidget(
                                      buttonType: ButtonType.transparent,
                                      iconData: Icons.arrow_back,
                                      onTap: () {
                                        loopGetController.changeAnimate();
                                        double lightningBalance = double.parse(
                                            walletController
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
                                        setState(() {});
                                      }),
                                ),
                              )),
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
                buttonState: loopGetController.loadingState.value
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

class EditableBalanceCard extends StatefulWidget {
  final String balance;
  final String confirmedBalance; 
  final String? unconfirmedBalance;
  final BitcoinUnits defaultUnit;
  final Color? textColor;
  final CardType cardType;
  final String cardTitle;
  final FocusNode focusNode;
  final Function(String) onChanged;

  const EditableBalanceCard({
    Key? key,
    required this.balance,
    required this.confirmedBalance,
    this.unconfirmedBalance,
    this.defaultUnit = BitcoinUnits.SAT,
    this.textColor,
    required this.cardType,
    required this.cardTitle,
    required this.focusNode,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<EditableBalanceCard> createState() => _EditableBalanceCardState();
}

class _EditableBalanceCardState extends State<EditableBalanceCard> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.balance);
  }

  @override
  void didUpdateWidget(EditableBalanceCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.balance != widget.balance && !widget.focusNode.hasFocus) {
      _controller.text = widget.balance;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final BitcoinUnitModel unitModel = CurrencyConverter.convertToBitcoinUnit(
      double.parse(widget.balance),
      widget.defaultUnit,
    );

    final bool isOnchain = widget.cardType == CardType.onchain;
    
    return Container(
      child: Stack(
        children: [
          // Background with appropriate style based on card type
          isOnchain 
              ? const CardBackgroundOnchain() 
              : const CardBackgroundLightning(),
          
          // Card content
          Padding(
            padding: const EdgeInsets.all(AppTheme.cardPadding * 1.25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Card title ("You Pay" or "You Receive")
                Text(
                  widget.cardTitle,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                
                const SizedBox(height: AppTheme.elementSpacing * 0.5),
                
                // Editable amount field
                Container(
                  width: 180.w,
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _controller,
                          focusNode: widget.focusNode,
                          keyboardType: const TextInputType.numberWithOptions(decimal: true),
                          style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                            color: widget.textColor,
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.zero,
                            isDense: true,
                            hintText: "0.0",
                            hintStyle: TextStyle(
                              color: Theme.of(context).brightness == Brightness.light
                                  ? AppTheme.black60
                                  : AppTheme.white60
                            ),
                          ),
                          onChanged: (value) {
                            widget.onChanged(value);
                          },
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r'(^\d*\.?\d*)')),
                          ],
                        ),
                      ),
                      Icon(
                        getCurrencyIcon(unitModel.bitcoinUnitAsString),
                        color: widget.textColor,
                      ),
                    ],
                  ),
                ),
                
                // Available balance indicator
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      "Available: ${widget.confirmedBalance}",
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: Theme.of(context).brightness == Brightness.light
                            ? AppTheme.black60
                            : AppTheme.white60,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Card decoration elements
          isOnchain
              ? const PaymentNetworkPicture(imageUrl: 'assets/images/bitcoin.png')
              : const PaymentNetworkPicture(imageUrl: 'assets/images/lightning.png'),
              
          // For onchain cards with unconfirmed balance
          if (isOnchain && widget.unconfirmedBalance != null && double.parse(widget.unconfirmedBalance!) > 0)
            Positioned(
              bottom: -10,
              left: 0,
              child: Padding(
                padding: const EdgeInsets.all(AppTheme.cardPadding * 0.5),
                child: Text(
                  "Incoming: ${widget.unconfirmedBalance}",
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: Theme.of(context).brightness == Brightness.light
                        ? AppTheme.black60
                        : AppTheme.white60,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}