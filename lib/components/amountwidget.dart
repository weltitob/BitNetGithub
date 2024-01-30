import 'package:bitnet/backbone/futures/bitcoinprice.dart';
import 'package:bitnet/backbone/helper/helpers.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/loaders/loaders.dart';
import 'package:bitnet/pages/wallet/actions/send/send.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AmountWidget extends StatelessWidget {
  final SendController controller;
  const AmountWidget({super.key, required this.controller});

    @override
    Widget build(BuildContext context) {
      return Container(
        child: Column(
          children: [
            Stack(
              alignment: Alignment.centerRight,
              children: [
                // Text field to enter Bitcoin value
                TextField(
                  focusNode: controller.myFocusNodeMoney,
                  onTap: () {
                    // Validate Bitcoin address when the text field is tapped
                  },
                  onTapOutside: (value) {
                    // Unfocus the text field when tapped outside
                    if (controller.myFocusNodeMoney.hasFocus) {
                      controller.myFocusNodeMoney.unfocus();
                    }
                  },
                  textAlign: TextAlign.center,
                  onChanged: (text) {
                    // Get the current Bitcoin price and update the UI
                    //getBitcoinPrice();
                    //setState(() {});
                  },
                  maxLength: 10,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [
                    // Only allow numerical values with a decimal point
                    FilteringTextInputFormatter.allow(RegExp(r'(^\d*\.?\d*)')),
                    // Restrict the range of input to be within 0 and 2000
                    NumericalRangeFormatter(
                        min: 0, max: double.parse("2.000"), context: context),
                  ],
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    counterText: "",
                    hintText: "0.0",
                    hintStyle: TextStyle(color: AppTheme.white60),
                  ),
                  controller: controller.moneyController,
                  autofocus: false,
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                // Icon for Bitcoin currency
                Icon(
                  Icons.currency_bitcoin_rounded,
                  size: AppTheme.cardPadding * 1.5,
                )
              ],
            ),
            SizedBox(height: AppTheme.elementSpacing,),
            // A Center widget with a child of bitcoinToMoneyWidget()
            Center(child: bitcoinToMoneyWidget(context)),
          ],
        ),
      );
    }
    Widget bitcoinToMoneyWidget(BuildContext context) {
      return controller.isLoadingExchangeRt == true // if exchange rate is still loading
          ? dotProgress(context) // show a loading indicator
          : Text(
        "≈ ${controller.moneyineur.toStringAsFixed(2)}€", // show the converted value of Bitcoin to Euro with 2 decimal places
        style: Theme.of(context)
            .textTheme
            .bodyLarge, // use the bodyLarge text theme style from the current theme
      );
    }
}
