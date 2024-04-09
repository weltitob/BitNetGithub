import 'package:bitnet/backbone/futures/bitcoinprice.dart';
import 'package:bitnet/backbone/helper/currency/currency_converter.dart';
import 'package:bitnet/backbone/helper/currency/getcurrency.dart';
import 'package:bitnet/backbone/helper/helpers.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/streams/currency_provider.dart';
import 'package:bitnet/models/bitcoin/chartline.dart';
import 'package:bitnet/models/currency/bitcoinunitmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class AmountWidget extends StatefulWidget {
  final BuildContext context;
  final bool enabled;
  final TextEditingController btcController;
  final TextEditingController currController;
  final FocusNode focusNode;
  final BitcoinUnits bitcoinUnit;

  const AmountWidget({
    super.key,
    required this.enabled,
    required this.btcController,
    required this.currController,
    required this.focusNode,
    this.bitcoinUnit = BitcoinUnits.BTC,
    required this.context});

  @override
  State<AmountWidget> createState() => _AmountWidgetState();
}

class _AmountWidgetState extends State<AmountWidget> {
  bool swapped = true;
  var amtControllerFunc;
  var currencyAmt = 0.0;
  var coinAmt = 0.0;
  @override
  void initState(){
    widget.currController.addListener((){
      currencyAmt = double.parse(widget.currController.text.isEmpty ? "0.0" : widget.currController.text);
      coinAmt = double.parse(widget.btcController.text.isEmpty ? "0.0" : widget.btcController.text);
      setState((){});
    });
    amtControllerFunc = (){
      setState((){});
    };
    widget.btcController.addListener(amtControllerFunc
    );
  super.initState();
  }

  @override
  void dispose(){
    widget.btcController.removeListener(amtControllerFunc);
    widget.currController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    String? currency =
        Provider.of<CurrencyChangeProvider>(context).selectedCurrency;
    currency = currency ?? "USD";

    //String unit = bitcoinUnitAsString(bitcoinUnit);

    return Container(
      child: Column(
        children: [
          Stack(
            children: [
              
              // Text field to enter Bitcoin value
              TextField(
                enabled: widget.enabled,
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

                },
                maxLength: 10,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  // Only allow numerical values with a decimal point
                  FilteringTextInputFormatter.allow(RegExp(r'(^\d*\.?\d*)')),
                  // Restrict the range of input to be within 0 and 2000
                  NumericalRangeFormatter(
                      min: 0, max: double.parse("99999999999"), context: context),
                ],
                decoration: InputDecoration(
                  prefixIcon: IconButton(onPressed: (){
                  this.swapped = !this.swapped;
                  if(this.swapped) {
                     final chartLine = Provider.of<ChartLine?>(context, listen: false);
    currency = currency ?? "USD";

    final bitcoinPrice = chartLine?.price;
    final currencyEquivalent = bitcoinPrice != null
        ? CurrencyConverter.convertCurrency(widget.bitcoinUnit.name, double.parse(widget.btcController.text.isEmpty ? "0.0" : widget.btcController.text), currency!, bitcoinPrice)
        : "0.00";
                    this.widget.currController.text = currencyEquivalent;
                  } else {
                                   final chartLine = Provider.of<ChartLine?>(context, listen: false);
    currency = currency ?? "USD";

    final bitcoinPrice = chartLine?.price;
    final currencyEquivalent = bitcoinPrice != null
        ? CurrencyConverter.convertCurrency(currency!, double.parse(widget.currController.text.isEmpty ? "0.0" : widget.currController.text), widget.bitcoinUnit.name, bitcoinPrice)
        : "0.00";

                    widget.btcController.text = currencyEquivalent;
                  }
                  widget.focusNode.unfocus();
                  setState((){});
                }, icon: Icon(Icons.swap_vert)),
                suffixIcon: this.swapped? Text(getCurrency(currency!)) : Icon(
                  getCurrencyIcon(widget.bitcoinUnit.name),
                  size: AppTheme.cardPadding * 1.25,
                    ),
                  border: InputBorder.none,
                  counterText: "",
                  hintText: "0.0",
                  hintStyle: TextStyle(color: AppTheme.white60),
                ),
                controller: swapped ? widget.currController :  widget.btcController,
                autofocus: false,
                
                style: Theme.of(context).textTheme.displayLarge,
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
          SizedBox(
            height: AppTheme.elementSpacing,
          ),
          // A Center widget with a child of bitcoinToMoneyWidget()
          Center(child: !this.swapped ? bitcoinToMoneyWidget(context, widget.bitcoinUnit) : MoneyToBitcoinWidget(context, widget.bitcoinUnit)),
        ],
      ),
    );
  }

  //this automatically needs to update once there is a new value for the controller
  Widget bitcoinToMoneyWidget(BuildContext context, BitcoinUnits bitcoinUnit) {
    final chartLine = Provider.of<ChartLine?>(context, listen: true);
    String? currency =
        Provider.of<CurrencyChangeProvider>(context).selectedCurrency;
    currency = currency ?? "USD";

    final bitcoinPrice = chartLine?.price;
    final currencyEquivalent = bitcoinPrice != null
        ? CurrencyConverter.convertCurrency(bitcoinUnit.name, double.parse(widget.btcController.text.isEmpty ? "0.0" : widget.btcController.text), currency, bitcoinPrice)
        : "0.00";
  


    return Text(
      "≈ ${currencyEquivalent}${getCurrency(currency)}", // show the converted value of Bitcoin to Euro with 2 decimal places
      style: Theme.of(context)
          .textTheme
          .bodyLarge, // use the bodyLarge text theme style from the current theme
    );
  }

    Widget MoneyToBitcoinWidget(BuildContext context, BitcoinUnits bitcoinUnit) {
    final chartLine = Provider.of<ChartLine?>(context, listen: true);
    String? currency =
        Provider.of<CurrencyChangeProvider>(context).selectedCurrency;
    currency = currency ?? "USD";

    final bitcoinPrice = chartLine?.price;
    final currencyEquivalent = bitcoinPrice != null
        ? CurrencyConverter.convertCurrency(currency, double.parse(this.widget.currController.text.isEmpty ? "0.0" : this.widget.currController.text), bitcoinUnit.name, bitcoinPrice)
        : "0.00";
    widget.btcController.text = currencyEquivalent;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "≈ ${currencyEquivalent}", // show the converted value of Bitcoin to Euro with 2 decimal places
          style: Theme.of(context)
              .textTheme
              .bodyLarge, // use the bodyLarge text theme style from the current theme
        ),
        Icon(getCurrencyIcon(bitcoinUnit.name),)
      ],
    );
  }

}