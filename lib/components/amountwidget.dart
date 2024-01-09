import 'package:bitnet/backbone/futures/bitcoinprice.dart';
import 'package:bitnet/backbone/helper/helpers.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/loaders/loaders.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AmountWidget extends StatefulWidget {
  const AmountWidget({super.key});

  @override
  State<AmountWidget> createState() => _AmountWidgetState();
}

class _AmountWidgetState extends State<AmountWidget> {
  bool _isLoadingExchangeRt =  true; // a flag indicating whether the exchange rate is loading
  late FocusNode myFocusNodeAdress;
  late FocusNode myFocusNodeMoney;
  late double feesInEur_medium;
  late double feesInEur_high;
  late double feesInEur_low;
  String feesSelected = "Niedrig";
  late double feesInEur;
  TextEditingController bitcoinReceiverAdressController =
  TextEditingController(); // the controller for the Bitcoin receiver address text field
  TextEditingController moneyController =
  TextEditingController(); // the controller for the amount text field
  bool isFinished =
  false; // a flag indicating whether the send process is finished
  dynamic _moneyineur = ''; // the amount in Euro, stored as dynamic type
  double bitcoinprice = 0.0;
  final GlobalKey<FormState> _formKey =
  GlobalKey<FormState>(); // a key for the form widget

  @override
  void initState() {
    super.initState();
    moneyController.text = "0.00001"; // set the initial amount to 0.00001
    myFocusNodeAdress = FocusNode();
    myFocusNodeMoney = FocusNode();
  }

  Future<void> getBitcoinPriceLocal() async {
    _isLoadingExchangeRt = true;
    bitcoinprice = await getBitcoinPrice();
    setState(() {
      if (moneyController.text.isNotEmpty) {
        _moneyineur = bitcoinprice * double.parse(moneyController.text);
        _isLoadingExchangeRt = false;
      } else {
        _moneyineur = 0.0;
      }
    });
  }

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
                focusNode: myFocusNodeMoney,
                onTap: () {
                  // Validate Bitcoin address when the text field is tapped
                },
                onTapOutside: (value) {
                  // Unfocus the text field when tapped outside
                  if (myFocusNodeMoney.hasFocus) {
                    myFocusNodeMoney.unfocus();
                  }
                },
                textAlign: TextAlign.center,
                onChanged: (text) {
                  // Get the current Bitcoin price and update the UI
                  //getBitcoinPrice();
                  setState(() {});
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
                controller: moneyController,
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
          Center(child: bitcoinToMoneyWidget()),
        ],
      ),
    );
  }
  Widget bitcoinToMoneyWidget() {
    return _isLoadingExchangeRt == true // if exchange rate is still loading
        ? dotProgress(context) // show a loading indicator
        : Text(
      "≈ ${_moneyineur.toStringAsFixed(2)}€", // show the converted value of Bitcoin to Euro with 2 decimal places
      style: Theme.of(context)
          .textTheme
          .bodyLarge, // use the bodyLarge text theme style from the current theme
    );
  }
}
