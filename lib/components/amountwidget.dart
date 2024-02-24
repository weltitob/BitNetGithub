import 'package:bitnet/backbone/futures/bitcoinprice.dart';
import 'package:bitnet/backbone/helper/getcurrency.dart';
import 'package:bitnet/backbone/helper/helpers.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/streams/currency_provider.dart';
import 'package:bitnet/models/bitcoin/chartline.dart';
import 'package:bitnet/pages/wallet/actions/send/send.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

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
                  enabled: controller.moneyTextFieldIsEnabled,
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
                Text(
                  "BTC",
                  style: Theme.of(context).textTheme.titleMedium,
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
      final chartLine = Provider.of<ChartLine?>(context, listen: true);
      String? currency = Provider.of<CurrencyChangeProvider>(context).selectedCurrency;
      currency = currency ?? "USD";

      final bitcoinPrice = chartLine?.price;
      final currencyEquivalent = bitcoinPrice != null ? (double.parse(controller.moneyController.text) * bitcoinPrice).toStringAsFixed(2) : "0.00";

      return Text(
        "≈ ${currencyEquivalent}${getCurrency(currency)}", // show the converted value of Bitcoin to Euro with 2 decimal places
        style: Theme.of(context)
            .textTheme
            .bodyLarge, // use the bodyLarge text theme style from the current theme
      );
    }
}
