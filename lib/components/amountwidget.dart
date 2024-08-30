import 'dart:async';

import 'package:bitnet/backbone/helper/currency/currency_converter.dart';
import 'package:bitnet/backbone/helper/currency/getcurrency.dart';
import 'package:bitnet/backbone/helper/helpers.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/streams/currency_provider.dart';
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
  bool swapped = true;
  bool preventConversion = false;
  bool enabled = true;
  var currControllerFunc;
  var amtControllerFunc;
  var satControllerFunc;
  BitcoinUnits currentUnit = BitcoinUnits.SAT;
  StreamSubscription? btcPriceStream;

  @override
  void initState() {
    widget.init?.call();
    if (widget.preventConversion != null) {
      preventConversion = widget.preventConversion!.call();
    }
    satControllerFunc = () {
      setState(() {});
    };
    swapped = widget.swapped;
    currControllerFunc = () {
      setState(() {});
    };
    widget.currController.addListener(currControllerFunc);
    amtControllerFunc = () {
      setState(() {});
    };
    widget.btcController.addListener(amtControllerFunc);
    widget.satController.addListener(satControllerFunc);

    currentUnit = widget.bitcoinUnit;
    enabled = widget.enabled?.call() ?? true;
    btcPriceStream = Get.find<WalletsController>().chartLines.listen((data) {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    widget.currController.removeListener(currControllerFunc);
    widget.btcController.removeListener(amtControllerFunc);
    widget.satController.removeListener(satControllerFunc);
    btcPriceStream?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String? currencyType = swapped ? "USD" : currentUnit.name;
    String? currency = Provider.of<CurrencyChangeProvider>(context).selectedCurrency;
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
                  IconButton(
                      onPressed: () {
                        this.swapped = !this.swapped;
                        Get.find<WalletsController>().setAmtWidgetReversed(this.swapped);
                        if (this.swapped) {
                          final chartLine = Get.find<WalletsController>().chartLines.value;
                          currency = currency ?? "USD";

                          final bitcoinPrice = chartLine?.price;
                          final currencyEquivalent = bitcoinPrice != null
                              ? CurrencyConverter.convertCurrency(
                                  currentUnit.name,
                                  currentUnit == BitcoinUnits.BTC
                                      ? double.parse(widget.btcController.text.isEmpty ? "0.0" : widget.btcController.text)
                                      : int.parse(widget.satController.text.isEmpty ? "0" : widget.satController.text).toDouble(),
                                  currency!,
                                  bitcoinPrice,
                                  fixed: false)
                              : "0.00";

                          this.widget.currController.text = double.parse(currencyEquivalent).toStringAsFixed(2);
                        } else {
                          final chartLine = Get.find<WalletsController>().chartLines.value;
                          currency = currency ?? "USD";

                          final bitcoinPrice = chartLine?.price;
                          final currencyEquivalent = bitcoinPrice != null
                              ? CurrencyConverter.convertCurrency(
                                  currency!,
                                  double.parse(widget.currController.text.isEmpty ? "0.0" : widget.currController.text),
                                  currentUnit.name,
                                  bitcoinPrice)
                              : "0.00";

                          widget.btcController.text = currencyEquivalent;
                        }
                        if (widget.onAmountChange != null) {
                          widget.onAmountChange!(currentUnit.name, widget.btcController.text);
                        }
                        widget.focusNode.unfocus();
                        setState(() {});
                      },
                      icon: Icon(Icons.swap_vert,
                          color: Theme.of(context).brightness == Brightness.light ? AppTheme.black70 : AppTheme.white90)),
                  Expanded(
                    child: Container(
                      width: 300,
                      child: Obx(
                        () {
                          double? btcPrice = Get.find<WalletsController>().chartLines.value?.price;
                          return TextField(
                            enabled: enabled,
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
                              if (widget.onAmountChange != null) {
                                if (swapped) {
                                  //widget.onAmountChange!(currencyType, widget.btcController.text.isEmpty ? '0' : widget.btcController.text);
                                } else {
                                  widget.onAmountChange!(currencyType, widget.btcController.text.isEmpty ? '0' : widget.btcController.text);
                                }
                              }
                            },
                            maxLength: widget.lowerBound != null ? 20 : 10,
                            keyboardType: const TextInputType.numberWithOptions(decimal: true),
                            inputFormatters: [
                              if (widget.boundType != null) ...[
                                BoundInputFormatter(
                                  swapped: swapped,
                                  lowerBound: widget.lowerBound ?? 0,
                                  upperBound: widget.upperBound ?? 999999999999999,
                                  boundType: widget.boundType!,
                                  valueType: currentUnit,
                                  inputCurrency: currency ?? "USD",
                                  bitcoinPrice: btcPrice ?? 1,
                                  overBound: (double currentVal) {
                                    widget.ctrler?.amountWidgetUnderBound.value = false;
                                    widget.ctrler?.amountWidgetOverBound.value = true;
                                  },
                                  underBound: (double currentVal) {
                                    widget.ctrler?.amountWidgetUnderBound.value = true;
                                    widget.ctrler?.amountWidgetOverBound.value = false;
                                  },
                                  inBound: (double currentVal) {
                                    widget.ctrler?.amountWidgetUnderBound.value = false;
                                    widget.ctrler?.amountWidgetOverBound.value = false;
                                  },
                                ),
                              ], // Only allow numerical values with a decimal point or without if SAT

                              (currentUnit == BitcoinUnits.SAT && !swapped)
                                  ? FilteringTextInputFormatter.allow(RegExp(r'(^\d+)'))
                                  : FilteringTextInputFormatter.allow(RegExp(r'(^\d*\.?\d*)')),
                              // Restrict the range of input to be within 0 and 2000
                              NumericalRangeFormatter(
                                  min: 0,
                                  max: (widget.upperBound != null && (widget.upperBound! > double.parse("99999999999")))
                                      ? widget.upperBound!.toDouble()
                                      : double.parse("99999999999"),
                                  context: context),
                            ],
                            decoration: InputDecoration(
                              suffixIcon: this.swapped
                                  ? Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(getCurrency(currency!),
                                            style: TextStyle(
                                                fontSize: 24,
                                                color: Theme.of(context).brightness == Brightness.light
                                                    ? AppTheme.black70
                                                    : AppTheme.white90)),
                                      ],
                                    )
                                  : Icon(getCurrencyIcon(currentUnit.name),
                                      size: AppTheme.cardPadding * 1.25,
                                      color: Theme.of(context).brightness == Brightness.light ? AppTheme.black70 : AppTheme.white90),
                              border: InputBorder.none,
                              counterText: "",
                              hintText: "0.0",
                              hintStyle:
                                  TextStyle(color: Theme.of(context).brightness == Brightness.light ? AppTheme.black60 : AppTheme.white60),
                            ),
                            controller: swapped
                                ? widget.currController
                                : (currentUnit == BitcoinUnits.BTC ? widget.btcController : widget.satController),
                            autofocus: false,
                            style: Theme.of(context)
                                .textTheme
                                .displayLarge!
                                .copyWith(color: Theme.of(context).brightness == Brightness.light ? AppTheme.black70 : AppTheme.white90),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
              // TextField(
              //   enabled: controller.moneyTextFieldIsEnabled,
              //   focusNode: controller.myFocusNodeMoney,
              //   onTap: () {
              //     // Validate Bitcoin address when the text field is tapped
              //   },
              //   onTapOutside: (value) {
              //     // Unfocus the text field when tapped outside
              //     if (controller.myFocusNodeMoney.hasFocus) {
              //       controller.myFocusNodeMoney.unfocus();
              //     }
              //   },
              //   textAlign: TextAlign.center,
              //   onChanged: (text) {
              //
              //   },
              //   maxLength: 10,
              //   keyboardType: TextInputType.numberWithOptions(decimal: true),
              //   inputFormatters: [
              //     // Only allow numerical values with a decimal point
              //     FilteringTextInputFormatter.allow(RegExp(r'(^\d*\.?\d*)')),
              //     // Restrict the range of input to be within 0 and 2000
              //     NumericalRangeFormatter(
              //         min: 0, max: double.parse("2.000"), context: context),
              //   ],
              //   decoration: InputDecoration(
              //     border: InputBorder.none,
              //     counterText: "",
              //     hintText: "0.0",
              //     hintStyle: TextStyle(color: AppTheme.white60),
              //   ),
              //   controller: controller.moneyController,
              //   autofocus: false,
              //   style: Theme.of(context).textTheme.displayLarge,
              // ),
              // Icon for Bitcoin currency

              // Align(
              //   alignment: Alignment.centerRight,
              //   child: Icon(
              //     getCurrencyIcon(widget.bitcoinUnit.name),
              //     size: AppTheme.cardPadding * 1.25,
              //       ),
              // ),
            ],
          ),
          const SizedBox(
            height: AppTheme.elementSpacing,
          ),
          // A Center widget with a child of bitcoinToMoneyWidget()
          Center(child: !this.swapped ? bitcoinToMoneyWidget(context, currentUnit) : MoneyToBitcoinWidget(context, currentUnit)),
        ],
      ),
    );
  }

  //this automatically needs to update once there is a new value for the controller
  Widget bitcoinToMoneyWidget(BuildContext context, BitcoinUnits bitcoinUnit) {
    final chartLine = Get.find<WalletsController>().chartLines.value;
    String? currency = Provider.of<CurrencyChangeProvider>(context).selectedCurrency;
    currency = currency ?? "USD";

    final bitcoinPrice = chartLine?.price;
    var currencyEquivalent = bitcoinPrice != null
        ? CurrencyConverter.convertCurrency(
            currentUnit.name,
            double.parse(currentUnit == BitcoinUnits.BTC
                ? (widget.btcController.text.isEmpty ? "0.0" : widget.btcController.text)
                : widget.satController.text.isEmpty
                    ? "0"
                    : widget.satController.text),
            currency,
            bitcoinPrice,
            fixed: false)
        : "0.00";

    final unitEquivalent = CurrencyConverter.convertToBitcoinUnit(
        currentUnit == BitcoinUnits.BTC
            ? double.parse((!widget.btcController.text.isEmpty ? widget.btcController.text : "0.0"))
            : double.parse(!widget.satController.text.isEmpty ? widget.satController.text : "0"),
        currentUnit);
    final oppositeUnit = unitEquivalent.bitcoinUnit == BitcoinUnits.BTC
        ? CurrencyConverter.convertBitcoinToSats(unitEquivalent.amount)
        : CurrencyConverter.convertSatoshiToBTC((unitEquivalent.amount as int).toDouble());
    if (widget.autoConvert) {
      processAutoConvert(unitEquivalent, oppositeUnit);
    } else {
      if (unitEquivalent.bitcoinUnit == BitcoinUnits.BTC && currentUnit != BitcoinUnits.BTC) {
        widget.btcController.text = unitEquivalent.amount.toString();
      } else if (unitEquivalent.bitcoinUnit == BitcoinUnits.SAT && currentUnit != BitcoinUnits.SAT) {
        widget.satController.text = unitEquivalent.amount.toString();
      } else if (unitEquivalent.bitcoinUnit == currentUnit && currentUnit == BitcoinUnits.SAT) {
        widget.btcController.text = oppositeUnit.toString();
      } else if (unitEquivalent.bitcoinUnit == currentUnit && currentUnit == BitcoinUnits.BTC) {
        widget.satController.text = oppositeUnit.toString();
      }
    }
    if (!preventConversion) {
      widget.currController.text = double.parse(currencyEquivalent).toStringAsFixed(2);
    }

    return Obx(() {
      Get.find<WalletsController>().chartLines.value;
      return Text(
        "≈ ${widget.currController.text}${getCurrency(currency!)}", // show the converted value of Bitcoin to Euro with 2 decimal places
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            color: Theme.of(context).brightness == Brightness.light
                ? AppTheme.black70
                : AppTheme.white90), // use the bodyLarge text theme style from the current theme
      );
    });
  }

  void processAutoConvert(BitcoinUnitModel unitEquivalent, double oppositeUnit) {
    if (unitEquivalent.bitcoinUnit != currentUnit) {
      currentUnit = unitEquivalent.bitcoinUnit;
      if (currentUnit == BitcoinUnits.BTC) {
        widget.btcController.text = unitEquivalent.amount.toString();
      } else {
        widget.satController.text = unitEquivalent.amount.toString();
      }
      WidgetsBinding.instance.addPostFrameCallback((d) {
        setState(() {});
      });
    }
  }

  Widget MoneyToBitcoinWidget(BuildContext context, BitcoinUnits bitcoinUnit) {
    final chartLine = Get.find<WalletsController>().chartLines.value;
    String? currency = Provider.of<CurrencyChangeProvider>(context).selectedCurrency;
    currency = currency ?? "USD";

    final bitcoinPrice = chartLine?.price;
    final currencyEquivalent = bitcoinPrice != null
        ? CurrencyConverter.convertCurrency(
            currency,
            double.parse(this.widget.currController.text.isEmpty ? "0.0" : this.widget.currController.text),
            BitcoinUnits.BTC.name,
            bitcoinPrice)
        : "0.00";
    final currencyEquivalentSats = bitcoinPrice != null
        ? CurrencyConverter.convertCurrency(
            currency,
            double.parse(this.widget.currController.text.isEmpty ? "0.0" : this.widget.currController.text),
            BitcoinUnits.SAT.name,
            bitcoinPrice)
        : "0.00";
    if (!preventConversion) {
      widget.btcController.text = double.parse(currencyEquivalent).toString();
      widget.satController.text = double.parse(currencyEquivalentSats).round().toString();
    }
    if (widget.autoConvert) {
      final unitEquivalent = CurrencyConverter.convertToBitcoinUnit(
          currentUnit == BitcoinUnits.BTC
              ? double.parse((!widget.btcController.text.isEmpty ? widget.btcController.text : "0.0"))
              : double.parse(!widget.satController.text.isEmpty ? widget.satController.text : "0"),
          currentUnit);
      final oppositeUnit = unitEquivalent.bitcoinUnit == BitcoinUnits.BTC
          ? CurrencyConverter.convertBitcoinToSats(unitEquivalent.amount)
          : CurrencyConverter.convertSatoshiToBTC((unitEquivalent.amount as int).toDouble());

      processAutoConvert(unitEquivalent, oppositeUnit);
    }
    String? currencyType = swapped ? "USD" : currentUnit.name;
    if (widget.onAmountChange != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        widget.onAmountChange!(currencyType, widget.btcController.text.isEmpty ? '0' : widget.btcController.text);
      });
    }
    return Obx(() {
      Get.find<WalletsController>().chartLines.value;
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "≈ ${currentUnit == BitcoinUnits.BTC ? widget.btcController.text : widget.satController.text}", // show the converted value of Bitcoin to Euro with 2 decimal places
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Theme.of(context).brightness == Brightness.light
                    ? AppTheme.black70
                    : AppTheme.white90), // use the bodyLarge text theme style from the current theme
          ),
          Icon(
            getCurrencyIcon(
              currentUnit.name,
            ),
            color: Theme.of(context).brightness == Brightness.light ? AppTheme.black70 : AppTheme.white90,
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
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    double convertedNewValue = double.tryParse(newValue.text) ?? 0;
    if (!swapped) {
      if (valueType != boundType) {
        if (valueType == BitcoinUnits.SAT) {
          convertedNewValue = CurrencyConverter.convertSatoshiToBTC(convertedNewValue);
        } else {
          convertedNewValue = CurrencyConverter.convertBitcoinToSats(convertedNewValue);
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
      convertedNewValue =
          double.parse(CurrencyConverter.convertCurrency(inputCurrency, double.tryParse(newValue.text) ?? 0, boundType.name, bitcoinPrice));
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
