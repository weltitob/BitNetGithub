import 'package:bitnet/backbone/helper/helpers.dart';
import 'package:bitnet/backbone/security/biometrics/biometric_check.dart';
import 'package:bitnet/backbone/streams/lnd/sendpayment_v2.dart';
import 'package:bitnet/pages/wallet/actions/send/search_receiver.dart';
import 'package:bitnet/pages/wallet/actions/send/send_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/utils/bitcoin_validator/bitcoin_validator.dart';
import 'package:matrix/matrix.dart';
import 'package:bolt11_decoder/bolt11_decoder.dart';
import 'package:vrouter/vrouter.dart';

class Send extends StatefulWidget {
  const Send({super.key});

  @override
  State<Send> createState() => SendController();
}

class SendController extends State<Send> {
  late FocusNode myFocusNodeAdressSearch;
  late TextEditingController bitcoinReceiverAdressController;

  void handleSearch(String value) {
    print(value);
  }

  bool isLoadingExchangeRt =  true; // a flag indicating whether the exchange rate is loading
  bool isLoadingFees = false;
  bool hasReceiver = false;
  bool moneyTextFieldIsEnabled = true;
  late FocusNode myFocusNodeAdress;
  late FocusNode myFocusNodeMoney;
  late double feesInEur_medium;
  late double feesInEur_high;
  late double feesInEur_low;
  String feesSelected = "Niedrig";
  String description = "";
  late double feesInEur;
  TextEditingController moneyController =
  TextEditingController(); // the controller for the amount text field
  bool isFinished =
  false; // a flag indicating whether the send process is finished
  dynamic moneyineur = ''; // the amount in Euro, stored as dynamic type
  double bitcoinprice = 0.0;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>(); // a key for the form widget
  String bitcoinReceiverAdress = ""; // the Bitcoin receiver address

  void _processParameters(BuildContext context) {
    Logs().w("Process parameters for sendscreen called");
    // Access the query parameters
    Map<String, String> queryParams = VRouter.of(context).queryParameters;

    String? invoice = VRouter.of(context).queryParameters['invoice'];
    if (invoice != null){
      Logs().w("Invoice: $invoice");
      giveValuesToInvoice(invoice!);
    }
    Logs().w("Invoice: $invoice");

  }



  @override
  void initState() {
    super.initState();
    moneyController.text = "0.00001"; // set the initial amount to 0.00001
    myFocusNodeAdress = FocusNode();
    myFocusNodeMoney = FocusNode();
    bitcoinReceiverAdressController = TextEditingController(); // the controller for the Bitcoin receiver address text field
  }

  void resetValues(){
    hasReceiver = false;
    bitcoinReceiverAdress = "";
    moneyController.text = "0.00001";
    moneyTextFieldIsEnabled = true;
    description = "";
    setState(() {
      VRouter.of(context).to("/wallet/send");
    });
  }

  void giveValuesToInvoice(String invoiceString){
    setState(() {
      hasReceiver = true;
      bitcoinReceiverAdress = invoiceString;

      Bolt11PaymentRequest req  = Bolt11PaymentRequest(invoiceString);
      moneyController.text = req.amount.toString();
      moneyTextFieldIsEnabled = false;
      description = req.tags[1].data;
    });
    // dynamic paymentRequest = req.paymentRequest;
    // dynamic prefix = req.prefix;
    // dynamic timestamp = req.timestamp;
    // dynamic signature = req.signature;
    // dynamic tags = req.tags;
    // dynamic paymentHash = req.tags[0].data;
  }

  void validateAdress(String value) {
    if (value.isEmpty) {
      Logs().w("Value: $value... Diese Walletadresse scheint nicht zu existieren");
    }
    Logs().w("Value: ->$value");
    //https://pub.dev/packages/bolt11_decoder
    final isLightningMailValid = isLightningAdressAsMail(value);
    final isStringInvoice = isStringALNInvoice(value);
    final isBitcoinValid = isBitcoinWalletValid(value);

    if (isBitcoinValid) {
      final walletType = getBitcoinWalletType(value);
      print(walletType);
      final walletdetails = getBitcoinWalletDetails(value);
      print(walletdetails);

    }
    if (isLightningMailValid) {

    }
    if (isStringInvoice) {
      giveValuesToInvoice(value);
      setState(() {

      });
    }
    else {
      Logs().w("Value: $value... Diese Walletadresse scheint nicht zu existieren");
    } //to indicate the input is valid
  }

  changeFees(String fees){
    setState(() {
      // update the state with the new selected fees
      feesSelected = fees;
      switch (fees) {
        case "Niedrig":
          feesInEur = feesInEur_low;
          break;
        case "Mittel":
          feesInEur = feesInEur_medium;
          break;
        case "Hoch":
          feesInEur = feesInEur_high;
          break;
      }
    });
  }

  sendBTC() async {
    Logs().w("sendBTC() called");
    await isBiometricsAvailable();
    if (isBioAuthenticated == true || hasBiometrics == false) {
      try {

        final amountInSat = double.parse(moneyController.text) * 100000000;
        dynamic restResponse = await sendPaymentV2(bitcoinReceiverAdress, amountInSat);

        setState(() {
          isFinished = true;
        });
        if (restResponse.statusCode == "success") {
          // Display a success message and navigate to the bottom navigation bar
        } else {
          setState(() {
            // Display an error message if the cloud function failed and set isFinished to false
            isFinished = false;
          });
        }
      } catch (e) {
        Logs().e("Error paying for invoice: " + e.toString());
        setState(() {
          isFinished = false;
        });
      }
    } else {
      // Display an error message if biometric authentication failed
      setState(() {
        isFinished = false;
      });
      Logs().e('Biometric authentication failed');
    }
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    myFocusNodeAdress.dispose();
    myFocusNodeMoney.dispose();
    moneyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _processParameters(context);
    return hasReceiver ?
      SendBTCScreen(controller: this) : SearchReceiver(controller: this);
  }
}
