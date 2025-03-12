import 'dart:async';

import 'package:bitnet/backbone/helper/currency/currency_converter.dart';
import 'package:bitnet/backbone/helper/currency/getcurrency.dart';
import 'package:bitnet/backbone/helper/helpers.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/streams/currency_provider.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/buttons/roundedbutton.dart';
import 'package:bitnet/models/currency/bitcoinunitmodel.dart';
import 'package:bitnet/pages/wallet/actions/send/controllers/send_controller.dart';
import 'package:bitnet/pages/wallet/controllers/wallet_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class AmountWidget extends StatefulWidget {
  final BuildContext context;
  final bool Function()? enabled;

  final TextEditingController btcController;
  final TextEditingController currController;
  final TextEditingController satController;
  final FocusNode focusNode;
  final BitcoinUnits bitcoinUnit;
  final bool swapped;
  final int? lowerBound;
  final int? upperBound;
  final BitcoinUnits? boundType;
  final Function()? init;
  final Function(String currencyType, String text)? onAmountChange;
  final bool autoConvert;
  //to prevent usd to btc units conversion and vice versa, set amounts in the controller will be used.
  final bool Function()? preventConversion;
  //only useful for when in a send tab
  final SendsController? ctrler;

  const AmountWidget(
      {super.key,
      required this.enabled,
      required this.btcController,
      required this.satController,
      required this.currController,
      required this.focusNode,
      this.bitcoinUnit = BitcoinUnits.BTC,
      this.swapped = true,
      required this.context,
      this.lowerBound,
      this.upperBound,
      this.boundType,
      required this.autoConvert,
      this.onAmountChange,
      this.ctrler,
      this.init,
      this.preventConversion});

  @override
  State<AmountWidget> createState() => _AmountWidgetState();
}

class _AmountWidgetState extends State<AmountWidget> {
  late AmountWidgetController controller;

  @override
  void initState() {
    widget.init?.call();

    // Initialize the controller with all state variables
    controller = AmountWidgetController();
    controller.initialize(() => setState(() {}), widget.btcController,
        widget.satController, widget.currController,
        initialSwapped: widget.swapped,
        preventConversionValue: widget.preventConversion?.call() ?? false,
        enabledValue: widget.enabled?.call() ?? true,
        initialUnit: widget.bitcoinUnit);

    super.initState();
  }

  @override
  void dispose() {
    // Use the controller to dispose listeners
    controller.disposeListeners(
        widget.btcController, widget.satController, widget.currController);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String? currencyType =
        controller.swapped ? "USD" : controller.currentUnit.name;
    String? currency =
        Provider.of<CurrencyChangeProvider>(context).selectedCurrency;
    currency = currency ?? "USD";
    final chartLine = Get.find<WalletsController>().chartLines.value;
    final bitcoinPrice = chartLine?.price;

    return Container(
      child: Column(
        children: [
          Stack(
            children: [
              // Text field to enter Bitcoin value
              Row(
                children: [
                  RoundedButtonWidget(
                    buttonType: ButtonType.transparent,
                    size: AppTheme.cardPadding * 1.5,
                    iconData: Icons.swap_vert,
                    onTap: () {
                      controller.swapped = !controller.swapped;
                      Get.find<WalletsController>()
                          .setAmtWidgetReversed(controller.swapped);
                      if (controller.swapped) {
                        final chartLine =
                            Get.find<WalletsController>().chartLines.value;
                        currency = currency ?? "USD";

                        final bitcoinPrice = chartLine?.price;
                        final currencyEquivalent = bitcoinPrice != null
                            ? CurrencyConverter.convertCurrency(
                                controller.currentUnit.name,
                                controller.currentUnit == BitcoinUnits.BTC
                                    ? double.parse(
                                        widget.btcController.text.isEmpty
                                            ? "0.0"
                                            : widget.btcController.text)
                                    : int.parse(
                                            widget.satController.text.isEmpty
                                                ? "0"
                                                : widget.satController.text)
                                        .toDouble(),
                                currency!,
                                bitcoinPrice,
                                fixed: false)
                            : "0.00";

                        widget.currController.text =
                            double.parse(currencyEquivalent).toStringAsFixed(2);
                      } else {
                        final chartLine =
                            Get.find<WalletsController>().chartLines.value;
                        currency = currency ?? "USD";

                        final bitcoinPrice = chartLine?.price;
                        final currencyEquivalent = bitcoinPrice != null
                            ? CurrencyConverter.convertCurrency(
                                currency!,
                                double.parse(widget.currController.text.isEmpty
                                    ? "0.0"
                                    : widget.currController.text),
                                controller.currentUnit.name,
                                bitcoinPrice)
                            : "0.00";

                        widget.btcController.text = currencyEquivalent;
                      }
                      if (widget.onAmountChange != null) {
                        widget.onAmountChange!(controller.currentUnit.name,
                            widget.btcController.text);
                      }
                      widget.focusNode.unfocus();
                      setState(() {});
                    },
                  ),
                  Expanded(
                    child: Container(
                      width: 300,
                      child: Obx(
                        () {
                          double? btcPrice = Get.find<WalletsController>()
                              .chartLines
                              .value
                              ?.price;
                          return TextField(
                            enabled: controller.enabled,
                            focusNode: widget.focusNode,
                            onTap: () {
                              // Validate Bitcoin address when the text field is tapped
                            },
                            onTapOutside: (value) {
                              // Unfocus the text field when tapped outside
                              if (widget.focusNode.hasFocus) {
                                widget.focusNode.unfocus();
                              }
                            },
                            textAlign: TextAlign.center,
                            onChanged: (text) {
                              if (!controller.swapped) {
                                if (controller.currentUnit ==
                                    BitcoinUnits.SAT) {
                                  widget.btcController.text = CurrencyConverter
                                          .convertSatoshiToBTC(double.tryParse(
                                                  widget.satController.text) ??
                                              0)
                                      .toStringAsFixed(8);
                                } else {
                                  widget.satController.text = CurrencyConverter
                                          .convertBitcoinToSats(double.tryParse(
                                                  widget.btcController.text) ??
                                              0)
                                      .toInt()
                                      .toString();
                                }
                              }
                              if (widget.onAmountChange != null &&
                                  !controller.swapped) {
                                widget.onAmountChange!(
                                    currencyType,
                                    widget.btcController.text.isEmpty
                                        ? '0'
                                        : widget.btcController.text);
                              }
                            },
                            maxLength: widget.lowerBound != null ? 20 : 10,
                            keyboardType: const TextInputType.numberWithOptions(
                                decimal: true),
                            inputFormatters: controller.getInputFormatters(
                              hasBoundType: widget.boundType != null,
                              context: context,
                              currency: currency ?? "USD",
                              bitcoinPrice: btcPrice,
                              lowerBound: widget.lowerBound,
                              upperBound: widget.upperBound,
                              boundType: widget.boundType,
                              overBoundCallback: (double currentVal) {
                                widget.ctrler?.amountWidgetUnderBound.value =
                                    false;
                                widget.ctrler?.amountWidgetOverBound.value =
                                    true;
                              },
                              underBoundCallback: (double currentVal) {
                                widget.ctrler?.amountWidgetUnderBound.value =
                                    true;
                                widget.ctrler?.amountWidgetOverBound.value =
                                    false;
                              },
                              inBoundCallback: (double currentVal) {
                                widget.ctrler?.amountWidgetUnderBound.value =
                                    false;
                                widget.ctrler?.amountWidgetOverBound.value =
                                    false;
                              },
                            ),
                            decoration: InputDecoration(
                              suffixIcon: controller.swapped
                                  ? Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(getCurrency(currency!),
                                            style: TextStyle(
                                                fontSize: 24,
                                                color: Theme.of(context)
                                                            .brightness ==
                                                        Brightness.light
                                                    ? AppTheme.black70
                                                    : AppTheme.white90)),
                                      ],
                                    )
                                  : Icon(
                                      getCurrencyIcon(
                                          controller.currentUnit.name),
                                      size: AppTheme.cardPadding * 1.25,
                                      color: Theme.of(context).brightness ==
                                              Brightness.light
                                          ? AppTheme.black70
                                          : AppTheme.white90),
                              border: InputBorder.none,
                              counterText: "",
                              hintText: "0.0",
                              hintStyle: TextStyle(
                                  color: Theme.of(context).brightness ==
                                          Brightness.light
                                      ? AppTheme.black60
                                      : AppTheme.white60),
                            ),
                            controller: controller.getCurrentController(
                                widget.btcController,
                                widget.satController,
                                widget.currController),
                            autofocus: false,
                            style: Theme.of(context)
                                .textTheme
                                .displayLarge!
                                .copyWith(
                                    color: Theme.of(context).brightness ==
                                            Brightness.light
                                        ? AppTheme.black70
                                        : AppTheme.white90),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: AppTheme.elementSpacing,
          ),
          // A Center widget with a child of bitcoinToMoneyWidget()
          Center(
              child: !controller.swapped
                  ? bitcoinToMoneyWidget(context, controller.currentUnit)
                  : MoneyToBitcoinWidget(context, controller.currentUnit)),
        ],
      ),
    );
  }

  //this automatically needs to update once there is a new value for the controller
  Widget bitcoinToMoneyWidget(BuildContext context, BitcoinUnits bitcoinUnit) {
    final chartLine = Get.find<WalletsController>().chartLines.value;
    String? currency =
        Provider.of<CurrencyChangeProvider>(context).selectedCurrency;
    currency = currency ?? "USD";

    final bitcoinPrice = chartLine?.price;
    var currencyEquivalent = bitcoinPrice != null
        ? CurrencyConverter.convertCurrency(
            controller.currentUnit.name,
            double.parse(controller.currentUnit == BitcoinUnits.BTC
                ? (widget.btcController.text.isEmpty
                    ? "0.0"
                    : widget.btcController.text)
                : widget.satController.text.isEmpty
                    ? "0"
                    : widget.satController.text),
            currency,
            bitcoinPrice,
            fixed: false)
        : "0.00";

    final unitEquivalent = CurrencyConverter.convertToBitcoinUnit(
        controller.currentUnit == BitcoinUnits.BTC
            ? double.parse((!widget.btcController.text.isEmpty
                ? widget.btcController.text
                : "0.0"))
            : double.parse(!widget.satController.text.isEmpty
                ? widget.satController.text
                : "0"),
        controller.currentUnit);
    final oppositeUnit = unitEquivalent.bitcoinUnit == BitcoinUnits.BTC
        ? CurrencyConverter.convertBitcoinToSats(unitEquivalent.amount)
        : CurrencyConverter.convertSatoshiToBTC(
            (unitEquivalent.amount as int).toDouble());
    if (widget.autoConvert) {
      controller.processAutoConvert(unitEquivalent, widget.btcController,
          widget.satController, () => setState(() {}));
    } else {
      if (unitEquivalent.bitcoinUnit == BitcoinUnits.BTC &&
          controller.currentUnit != BitcoinUnits.BTC) {
        widget.btcController.text = unitEquivalent.amount.toString();
      } else if (unitEquivalent.bitcoinUnit == BitcoinUnits.SAT &&
          controller.currentUnit != BitcoinUnits.SAT) {
        widget.satController.text = unitEquivalent.amount.toString();
      } else if (unitEquivalent.bitcoinUnit == controller.currentUnit &&
          controller.currentUnit == BitcoinUnits.SAT) {
        widget.btcController.text = oppositeUnit.toString();
      } else if (unitEquivalent.bitcoinUnit == controller.currentUnit &&
          controller.currentUnit == BitcoinUnits.BTC) {
        widget.satController.text = oppositeUnit.toString();
      }
    }
    if (!controller.preventConversion) {
      widget.currController.text =
          double.parse(currencyEquivalent).toStringAsFixed(2);
    }

    return Obx(() {
      Get.find<WalletsController>().chartLines.value;
      return Text(
        "≈ ${widget.currController.text}${getCurrency(currency!)}", // show the converted value of Bitcoin to Euro with 2 decimal places
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            color: Theme.of(context).brightness == Brightness.light
                ? AppTheme.black70
                : AppTheme
                    .white90), // use the bodyLarge text theme style from the current theme
      );
    });
  }

  Widget MoneyToBitcoinWidget(BuildContext context, BitcoinUnits bitcoinUnit) {
    final chartLine = Get.find<WalletsController>().chartLines.value;
    String? currency =
        Provider.of<CurrencyChangeProvider>(context).selectedCurrency;
    currency = currency ?? "USD";

    final bitcoinPrice = chartLine?.price;
    final currencyEquivalent = bitcoinPrice != null
        ? CurrencyConverter.convertCurrency(
            currency,
            double.parse(widget.currController.text.isEmpty
                ? "0.0"
                : widget.currController.text),
            BitcoinUnits.BTC.name,
            bitcoinPrice)
        : "0.00";
    final currencyEquivalentSats = bitcoinPrice != null
        ? CurrencyConverter.convertCurrency(
            currency,
            double.parse(widget.currController.text.isEmpty
                ? "0.0"
                : widget.currController.text),
            BitcoinUnits.SAT.name,
            bitcoinPrice)
        : "0.00";
    if (!controller.preventConversion) {
      widget.btcController.text = double.parse(currencyEquivalent).toString();
      widget.satController.text =
          double.parse(currencyEquivalentSats).round().toString();
    }
    if (widget.autoConvert) {
      final unitEquivalent = CurrencyConverter.convertToBitcoinUnit(
          controller.currentUnit == BitcoinUnits.BTC
              ? double.parse((!widget.btcController.text.isEmpty
                  ? widget.btcController.text
                  : "0.0"))
              : double.parse(!widget.satController.text.isEmpty
                  ? widget.satController.text
                  : "0"),
          controller.currentUnit);
      final oppositeUnit = unitEquivalent.bitcoinUnit == BitcoinUnits.BTC
          ? CurrencyConverter.convertBitcoinToSats(unitEquivalent.amount)
          : CurrencyConverter.convertSatoshiToBTC(
              (unitEquivalent.amount as int).toDouble());

      controller.processAutoConvert(unitEquivalent, widget.btcController,
          widget.satController, () => setState(() {}));
    }
    String? currencyType =
        controller.swapped ? "USD" : controller.currentUnit.name;
    if (widget.onAmountChange != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        widget.onAmountChange!(
            currencyType,
            widget.btcController.text.isEmpty
                ? '0'
                : widget.btcController.text);
      });
    }
    return Obx(() {
      Get.find<WalletsController>().chartLines.value;
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "≈ ${controller.currentUnit == BitcoinUnits.BTC ? widget.btcController.text : widget.satController.text}", // show the converted value of Bitcoin to Euro with 2 decimal places
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Theme.of(context).brightness == Brightness.light
                    ? AppTheme.black70
                    : AppTheme
                        .white90), // use the bodyLarge text theme style from the current theme
          ),
          Icon(
            getCurrencyIcon(
              controller.currentUnit.name,
            ),
            color: Theme.of(context).brightness == Brightness.light
                ? AppTheme.black70
                : AppTheme.white90,
          )
        ],
      );
    });
  }
}

class BoundInputFormatter extends TextInputFormatter {
  final bool swapped;
  final String inputCurrency;
  final int lowerBound;
  final int upperBound;
  final double bitcoinPrice;
  final BitcoinUnits boundType;
  final BitcoinUnits valueType;
  final Function(double currentVal)? overBound;
  final Function(double currentVal)? underBound;
  final Function(double currentVal)? inBound;
  BoundInputFormatter(
      {required this.overBound,
      required this.underBound,
      required this.inBound,
      required this.inputCurrency,
      required this.bitcoinPrice,
      required this.swapped,
      required this.lowerBound,
      required this.upperBound,
      required this.boundType,
      required this.valueType});

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    double convertedNewValue = double.tryParse(newValue.text) ?? 0;
    if (!swapped) {
      if (valueType != boundType) {
        if (valueType == BitcoinUnits.SAT) {
          convertedNewValue =
              CurrencyConverter.convertSatoshiToBTC(convertedNewValue);
        } else {
          convertedNewValue =
              CurrencyConverter.convertBitcoinToSats(convertedNewValue);
        }
      }
      if (convertedNewValue < lowerBound) {
        //  return newValue.copyWith(text: "$lowerBound", selection: TextSelection.collapsed(offset: lowerBound.toString().length), composing: TextRange.empty);
        underBound?.call(convertedNewValue);
      } else if (convertedNewValue > upperBound) {
        //  return newValue.copyWith(text: "$upperBound", selection: TextSelection.collapsed(offset: upperBound.toString().length), composing: TextRange.empty);
        overBound?.call(convertedNewValue);
      } else {
        inBound?.call(convertedNewValue);
      }
    } else {
      convertedNewValue = double.parse(CurrencyConverter.convertCurrency(
          inputCurrency,
          double.tryParse(newValue.text) ?? 0,
          boundType.name,
          bitcoinPrice));
      if (convertedNewValue < lowerBound) {
        underBound?.call(convertedNewValue);

        // return newValue.copyWith(text: CurrencyConverter.convertCurrency(boundType.name, lowerBound.toDouble(), inputCurrency, bitcoinPrice) , selection: TextSelection.collapsed(offset: CurrencyConverter.convertCurrency(boundType.name, lowerBound.toDouble(), inputCurrency, bitcoinPrice).length), composing: TextRange.empty);
      } else if (convertedNewValue > upperBound) {
        overBound?.call(convertedNewValue);

        // return newValue.copyWith(text: CurrencyConverter.convertCurrency(boundType.name, upperBound.toDouble(), inputCurrency, bitcoinPrice) , selection: TextSelection.collapsed(offset: CurrencyConverter.convertCurrency(boundType.name, upperBound.toDouble(), inputCurrency, bitcoinPrice).length), composing: TextRange.empty);
      } else {
        inBound?.call(convertedNewValue);
      }
    }
    return newValue;
  }
}

class AmountWidgetController {
  VoidCallback? currControllerFunc;
  VoidCallback? amtControllerFunc;
  VoidCallback? satControllerFunc;
  StreamSubscription? btcPriceStream;
  TextEditingController? satController;
  TextEditingController? btcController;
  TextEditingController? currController;

  // State variables moved from _AmountWidgetState
  bool swapped = true;
  bool preventConversion = false;
  bool enabled = true;
  BitcoinUnits currentUnit = BitcoinUnits.SAT;

  /// Initialize the controller with all required parameters and set up listeners
  void initialize(VoidCallback stateSetter, TextEditingController btcController,
      TextEditingController satController, TextEditingController currController,
      {bool initialSwapped = false,
      bool preventConversionValue = false,
      bool enabledValue = true,
      BitcoinUnits initialUnit = BitcoinUnits.SAT,
      bool storeControllers = false}) {
    // Initialize state variables
    swapped = initialSwapped;
    preventConversion = preventConversionValue;
    enabled = enabledValue;
    currentUnit = initialUnit;
    // Define the functions that will be called when the controllers change
    satControllerFunc = () {
      stateSetter();
    };

    currControllerFunc = () {
      stateSetter();
    };

    amtControllerFunc = () {
      stateSetter();
    };

    // Add the functions as listeners to the controllers
    btcController.addListener(amtControllerFunc!);
    satController.addListener(satControllerFunc!);
    currController.addListener(currControllerFunc!);
    if (storeControllers) {
      this.satController = satController;
      this.btcController = btcController;
      this.currController = currController;
    }
    // Initialize BTC price stream for real-time updates
    btcPriceStream = Get.find<WalletsController>().chartLines.listen((data) {
      stateSetter();
    });
  }

  /// Remove listeners from controllers to prevent memory leaks
  void disposeListeners(
    TextEditingController btcController,
    TextEditingController satController,
    TextEditingController currController,
  ) {
    if (currControllerFunc != null) {
      currController.removeListener(currControllerFunc!);
    }

    if (amtControllerFunc != null) {
      btcController.removeListener(amtControllerFunc!);
    }

    if (satControllerFunc != null) {
      satController.removeListener(satControllerFunc!);
    }

    btcPriceStream?.cancel();
  }

  /// Returns the appropriate TextEditingController based on current state
  TextEditingController getCurrentController(
      TextEditingController btcController,
      TextEditingController satController,
      TextEditingController currController,
      {bool? swapAlternative}) {
    if (swapAlternative ?? swapped) {
      return currController;
    } else {
      return currentUnit == BitcoinUnits.BTC ? btcController : satController;
    }
  }

  /// Process auto conversion between Bitcoin units
  void processAutoConvert(
    BitcoinUnitModel unitEquivalent,
    TextEditingController btcController,
    TextEditingController satController,
    VoidCallback stateSetter,
  ) {
    if (unitEquivalent.bitcoinUnit != currentUnit) {
      currentUnit = unitEquivalent.bitcoinUnit;
      if (currentUnit == BitcoinUnits.BTC) {
        btcController.text = unitEquivalent.amount.toString();
      } else {
        satController.text = unitEquivalent.amount.toString();
      }
      WidgetsBinding.instance.addPostFrameCallback((d) {
        stateSetter();
      });
    }
  }

  /// Generate input formatters based on parameters from widget state
  List<TextInputFormatter> getInputFormatters(
      {required bool hasBoundType,
      required BuildContext context,
      required String currency,
      required double? bitcoinPrice,
      int? lowerBound,
      int? upperBound,
      BitcoinUnits? boundType,
      required Function(double) overBoundCallback,
      required Function(double) underBoundCallback,
      required Function(double) inBoundCallback,
      bool? swapAlternative}) {
    List<TextInputFormatter> formatters = [];

    // Add bound input formatter if boundType exists
    if (hasBoundType) {
      formatters.add(
        BoundInputFormatter(
          swapped: (swapAlternative ?? swapped),
          lowerBound: lowerBound ?? 0,
          upperBound: upperBound ?? 999999999999999,
          boundType: boundType!,
          valueType: currentUnit,
          inputCurrency: currency,
          bitcoinPrice: bitcoinPrice ?? 1,
          overBound: overBoundCallback,
          underBound: underBoundCallback,
          inBound: inBoundCallback,
        ),
      );
    }

    // Add filtering formatter based on unit and swapped state
    if (currentUnit == BitcoinUnits.SAT && !(swapAlternative ?? swapped)) {
      formatters.add(FilteringTextInputFormatter.allow(RegExp(r'(^\d+)')));
    } else {
      formatters
          .add(FilteringTextInputFormatter.allow(RegExp(r'(^\d*\.?\d*)')));
    }

    // Add numerical range formatter
    formatters.add(
      NumericalRangeFormatter(
        min: 0,
        max: (upperBound != null && (upperBound > double.parse("99999999999")))
            ? upperBound.toDouble()
            : double.parse("99999999999"),
        context: context,
      ),
    );

    return formatters;
  }
}
