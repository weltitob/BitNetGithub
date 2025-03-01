import 'package:bitnet/backbone/helper/currency/currency_converter.dart';
import 'package:bitnet/backbone/helper/currency/getcurrency.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:bitnet/backbone/streams/currency_provider.dart';
import 'package:bitnet/backbone/streams/currency_type_provider.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetListTile.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/appstandards/glasscontainerborder.dart';
import 'package:bitnet/components/buttons/bottom_buybuttons.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/buttons/roundedbutton.dart';
import 'package:bitnet/components/container/imagewithtext.dart';
import 'package:bitnet/components/dialogsandsheets/bottom_sheets/bit_net_bottom_sheet.dart';
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
  
  // Currency type toggle
  final RxBool swapped = false.obs;

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

                                  // Format the predicted balance to 8 decimal places
                                  final formattedBalance = predictedBtcBalance.toStringAsFixed(8);

                                  return EditableBalanceCard(
                                    balance: formattedBalance,
                                    confirmedBalance: confirmedBalanceStr,
                                    unconfirmedBalance: unconfirmedBalanceStr,
                                    defaultUnit: BitcoinUnits.SAT,
                                    cardType: CardType.onchain,
                                    cardTitle: loopGetController.animate.value
                                        ? "You Pay"
                                        : "You Receive",
                                    focusNode: onchainFocusNode,
                                    onChanged: (value) => updateBalance(value, true),
                                    swapped: swapped.value,
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

                                // Format the predicted balance to 8 decimal places
                                final formattedBalance = predictedBalance.toStringAsFixed(8);

                                return EditableBalanceCard(
                                  balance: formattedBalance,
                                  confirmedBalance: confirmedBalanceStr,
                                  defaultUnit: BitcoinUnits.SAT,
                                  cardType: CardType.lightning,
                                  cardTitle: loopGetController.animate.value
                                      ? "You Receive"
                                      : "You Pay",
                                  focusNode: lightningFocusNode,
                                  onChanged: (value) => updateBalance(value, false),
                                  swapped: swapped.value,
                                );
                              }),
                            ),
                          ],
                        ),
                        // CONTROL BUTTONS IN THE MIDDLE
                        Align(
                          alignment: Alignment.center,
                          child: GlassContainer(
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: AppTheme.elementSpacing * 0.5,
                                vertical: AppTheme.elementSpacing * 0.25,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  // Currency swap button
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    child: Icon(
                                      Icons.swap_vert,
                                      size: 20,
                                      color: Theme.of(context).colorScheme.onSurface,
                                    ),
                                  ),

                                  // Divider
                                  Container(
                                    height: 24,
                                    width: 1,
                                    margin: const EdgeInsets.symmetric(horizontal: 4),
                                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.2),
                                  ),

                                  // Direction arrow button
                                  Obx(() => InkWell(
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
                                    },
                                    borderRadius: BorderRadius.circular(AppTheme.cardPadding * 0.5),
                                    child: Container(
                                      padding: const EdgeInsets.all(8),
                                      child: Transform.rotate(
                                        angle: loopGetController.animate.value ? 0 : 3.14159, // 180 degrees in radians
                                        child: Icon(
                                          Icons.arrow_downward,
                                          size: 20,
                                          color: Theme.of(context).colorScheme.onSurface,
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
        borderRadius: AppTheme.cardRadiusMid,

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
  final bool swapped;

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
    required this.swapped,
  }) : super(key: key);

  @override
  State<EditableBalanceCard> createState() => _EditableBalanceCardState();
}

class _EditableBalanceCardState extends State<EditableBalanceCard> {
  late TextEditingController _controller;
  String _alternateValue = "0.00";

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.balance);
    _updateAlternateValue(widget.balance);
  }

  void _updateAlternateValue(String value) {
    if (value.isEmpty) value = "0";

    // Get the current Bitcoin price
    final chartLine = Get.find<WalletsController>().chartLines.value;
    String? currency = Provider.of<CurrencyChangeProvider>(context, listen: false).selectedCurrency ?? "USD";
    final bitcoinPrice = chartLine?.price ?? 0;

    // Calculate value in the alternate currency
    final amount = double.tryParse(value) ?? 0.0;

    if (widget.swapped) {
      // If we're in fiat mode, convert from fiat to BTC/SAT
      _alternateValue = CurrencyConverter.convertCurrency(
        currency,
        amount,
        widget.defaultUnit.name,
        bitcoinPrice
      );
    } else {
      // If we're in crypto mode, convert from BTC/SAT to fiat
      _alternateValue = CurrencyConverter.convertCurrency(
        widget.defaultUnit.name,
        amount,
        currency,
        bitcoinPrice,
        fixed: true
      );
    }
    
    setState(() {});
  }

  @override
  void didUpdateWidget(EditableBalanceCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.balance != widget.balance && !widget.focusNode.hasFocus) {
      _controller.text = widget.balance;
      _updateAlternateValue(widget.balance);
    }
    
    if (oldWidget.swapped != widget.swapped) {
      _updateAlternateValue(_controller.text);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isOnchain = widget.cardType == CardType.onchain;
    final String? currency = Provider.of<CurrencyChangeProvider>(context).selectedCurrency ?? "USD";
    
    // Get the appropriate unit and icon based on swapped state
    final IconData currencyIcon = widget.swapped
        ? getCurrencyIcon(currency!)
        : getCurrencyIcon(widget.defaultUnit.name);
        
    final String alternateUnitName = widget.swapped
        ? widget.defaultUnit.name
        : currency!;
    
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
                  style: Theme.of(context).textTheme.titleSmall,
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
                          style: Theme.of(context).textTheme.headlineLarge,
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
                            _updateAlternateValue(value);
                          },
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r'(^\d*\.?\d*)')),
                          ],
                        ),
                      ),
                      Icon(
                        currencyIcon,
                        color: Theme.of(context).brightness == Brightness.light
                            ? AppTheme.black70
                            : AppTheme.white90,
                      ),
                    ],
                  ),
                ),
                
                // Alternative currency value
                Obx(() {
                  // Listen to chart updates for price changes
                  Get.find<WalletsController>().chartLines.value;
                  
                  return Container(
                    width: 180.w,
                    margin: const EdgeInsets.only(top: 4),
                    child: Row(
                      children: [
                        Text(
                          "≈ $_alternateValue",
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Theme.of(context).brightness == Brightness.light
                                ? AppTheme.black60
                                : AppTheme.white60,
                          ),
                        ),
                        const SizedBox(width: 2),
                        Icon(
                          getCurrencyIcon(alternateUnitName),
                          size: 14,
                          color: Theme.of(context).brightness == Brightness.light
                              ? AppTheme.black60
                              : AppTheme.white60,
                        ),
                      ],
                    ),
                  );
                }),
                
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
          
          // Currency Selector - properly positioned at top right
          Positioned(
            right: AppTheme.cardPadding * 1,
            top: AppTheme.cardPadding * 1,
            child: CurrencySelector(
              currentType: isOnchain ? CurrencyType.bitcoin : CurrencyType.lightning,
              onCurrencyChanged: (type) {
                // This would be implemented if we want to switch between BTC and LN within a card
                // For now, we're just using it as a visual indicator
              },
            ),
          ),
          
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