import 'package:bitnet/backbone/cloudfunctions/lnd/walletkitservice/estimatefee.dart';
import 'package:bitnet/backbone/cloudfunctions/lnd/walletkitservice/finalizepsbt.dart';
import 'package:bitnet/backbone/cloudfunctions/lnd/walletkitservice/fundpsbt.dart';
import 'package:bitnet/backbone/cloudfunctions/lnd/walletkitservice/listunspent.dart';
import 'package:bitnet/backbone/cloudfunctions/lnd/walletkitservice/publishtransaction.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/security/biometrics/biometric_check.dart';
import 'package:bitnet/backbone/streams/lnd/sendpayment_v2.dart';
import 'package:bitnet/components/dialogsandsheets/notificationoverlays/overlay.dart';
import 'package:bitnet/models/bitcoin/walletkit/finalizepsbtresponse.dart';
import 'package:bitnet/models/bitcoin/walletkit/fundpsbtresponse.dart';
import 'package:bitnet/models/bitcoin/walletkit/input.dart';
import 'package:bitnet/models/bitcoin/walletkit/output.dart';
import 'package:bitnet/models/bitcoin/walletkit/rawtransactiondata.dart';
import 'package:bitnet/models/bitcoin/walletkit/transactiondata.dart';
import 'package:bitnet/models/bitcoin/walletkit/utxorequest.dart';
import 'package:bitnet/models/currency/bitcoinunitmodel.dart';
import 'package:bitnet/models/firebase/restresponse.dart';
import 'package:bitnet/pages/wallet/actions/send/search_receiver.dart';
import 'package:bitnet/pages/wallet/actions/send/send_view.dart';
import 'package:flutter/material.dart';
import 'package:matrix/matrix.dart';
import 'package:bolt11_decoder/bolt11_decoder.dart';
import 'package:go_router/go_router.dart';


enum SendType {
  Lightning,
  OnChain,
  Invoice,
  Unknown,
}

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

  BitcoinUnits bitcoinUnit = BitcoinUnits.BTC;
  bool isLoadingExchangeRt =  true; // a flag indicating whether the exchange rate is loading
  bool isLoadingFees = false;
  bool hasReceiver = false;
  bool moneyTextFieldIsEnabled = true;
  late FocusNode myFocusNodeAdress;
  late FocusNode myFocusNodeMoney;
  late double feesInEur_medium;
  late double feesInEur_high;
  late double feesInEur_low;
  late SendType sendType;
  String feesSelected = "Niedrig";
  String description = "";
  late double feesDouble;
  TextEditingController moneyController =
  TextEditingController(); // the controller for the amount text field
  bool isFinished = false; // a flag indicating whether the send process is finished
  dynamic moneyineur = ''; // the amount in Euro, stored as dynamic type
  double bitcoinprice = 0.0;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>(); // a key for the form widget
  String bitcoinReceiverAdress = ""; // the Bitcoin receiver address


  void processParameters(BuildContext context) {
    Logs().w("Process parameters for sendscreen called");

    Map<String, String> queryParams = GoRouter.of(context).routeInformationProvider.value.uri.queryParameters;
    String? invoice = queryParams['invoice'];
    String? walletAdress = queryParams['walletAdress'];

    if (invoice != null){
      Logs().w("Invoice: $invoice");
      giveValuesToInvoice(invoice!);
    }
    else if(walletAdress != null){
      Logs().w("Walletadress: $walletAdress");

      giveValuesToOnchainSend(walletAdress);
    }
    else{
      Logs().w("No parameters found");
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
      context.go("/wallet/send");
    });
  }

  void giveValuesToOnchainSend(String onchainAdress) async {
    {
      setState(() {
        sendType = SendType.OnChain;
        hasReceiver = true;
        bitcoinReceiverAdress = onchainAdress;
        moneyTextFieldIsEnabled = true;
      });
    }
    dynamic fundedPsbtResponse = await estimateFee(AppTheme.targetConf.toString());
    final sat_per_kw = fundedPsbtResponse.data["sat_per_kw"];
    double sat_per_vbyte = double.parse(sat_per_kw); // / 4
    feesDouble = sat_per_vbyte;
    print("Estimated fees: $feesDouble");
    setState(() {});
  }

  void giveValuesToInvoice(String invoiceString){
    setState(() {
      sendType = SendType.Invoice;
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

  // void validateAdress(String value) {
  //   if (value.isEmpty) {
  //     Logs().w("Value: $value... Diese Walletadresse scheint nicht zu existieren");
  //   }
  //   Logs().w("Value: ->$value");
  //   //https://pub.dev/packages/bolt11_decoder
  //   final isLightningMailValid = isLightningAdressAsMail(value);
  //   final isStringInvoice = isStringALNInvoice(value);
  //   final isBitcoinValid = isBitcoinWalletValid(value);
  //
  //   if (isBitcoinValid) {
  //     final walletType = getBitcoinWalletType(value);
  //     Logs().w(walletType.toString());
  //     final walletdetails = getBitcoinWalletDetails(value);
  //     Logs().w(walletdetails.toString());
  //   }
  //   if (isLightningMailValid) {
  //
  //   }
  //   if (isStringInvoice) {
  //     giveValuesToInvoice(value);
  //     setState(() {
  //
  //     });
  //   }
  //   else {
  //     Logs().w("Value: $value... Diese Walletadresse scheint nicht zu existieren");
  //   } //to indicate the input is valid
  // }

  changeFees(String fees){
    setState(() {
      // update the state with the new selected fees
      feesSelected = fees;
      switch (fees) {
        case "Niedrig":
          feesDouble = feesInEur_low;
          break;
        case "Mittel":
          feesDouble = feesInEur_medium;
          break;
        case "Hoch":
          feesDouble = feesInEur_high;
          break;
      }
    });
  }

  sendBTC() async {
    Logs().w("sendBTC() called");
    await isBiometricsAvailable();
    if (isBioAuthenticated == true || hasBiometrics == false) {
      try {
        if (sendType == SendType.Invoice) {
          final amountInSat = double.parse(moneyController.text) * 100000000;
          List<String> invoiceStrings = [bitcoinReceiverAdress]; // Assuming you want to send a list containing a single invoice for now

          Stream<RestResponse> paymentStream = sendPaymentV2Stream(invoiceStrings);
          paymentStream.listen(
                  (RestResponse response) {
                setState(() {
                  isFinished = true; // Assuming you might want to update UI on each response
                });
                if (response.statusCode == "success") {
                  // Handle success
                  showOverlay(context, "Payment successful!");
                  GoRouter.of(context).pushNamed("/wallet");
                } else {
                  // Handle error
                  showOverlay(context, "Payment failed: ${response.message}");
                  setState(() {
                    isFinished = false; // Keep the user on the same page to possibly retry or show error
                  });
                }
              },
              onError: (error) {
                setState(() {
                  isFinished = false;
                });
                showOverlay(context, "An error occurred: $error");
              },
              onDone: () {
                // Handle stream completion if necessary
              },
              cancelOnError: true // Cancel the subscription upon first error
          );
        }

        else if(sendType == SendType.OnChain){
          final amountInSat = double.parse(moneyController.text) * 100000000;

          dynamic restResponseListUnspent = await listUnspent();
          UtxoRequestList utxos = UtxoRequestList.fromJson(restResponseListUnspent.data);

          TransactionData transactiondata = TransactionData(
              raw: RawTransactionData(
                inputs: utxos.utxos.map((i) => Input(
                    txidStr: i.outpoint.txidStr,
                    txidBytes: i.outpoint.txidBytes,
                    outputIndex: i.outpoint.outputIndex,
                )).toList(),
                outputs: Outputs(
                    outputs: {
                      bitcoinReceiverAdress: amountInSat.toInt()
                    }
                ),
              ),
              targetConf: AppTheme.targetConf, //The number of blocks to aim for when confirming the transaction.
              account: "",
              minConfs: 4, //going for safety and not speed because for speed oyu would use the lightning network
              spendUnconfirmed: false, //Whether unconfirmed outputs should be used as inputs for the transaction.
              changeType: 0 //CHANGE_ADDRESS_TYPE_UNSPECIFIED
          );

          dynamic fundPsbtrestResponse = await fundPsbt(transactiondata);
          FundedPsbtResponse fundedPsbtResponse = FundedPsbtResponse.fromJson(fundPsbtrestResponse.data);
          dynamic finalizedPsbtRestResponse =  await finalizePsbt(fundedPsbtResponse.fundedPsbt);
          FinalizePsbtResponse finalizedPsbtResponse = FinalizePsbtResponse.fromJson(finalizedPsbtRestResponse.data);

          dynamic publishTransactionRestResponse = await publishTransaction(finalizedPsbtResponse.rawFinalTx, ""); //txhex and label


          setState(() {
            isFinished = true;
          });
          if (publishTransactionRestResponse.statusCode == "success") {
            context.go("/wallet");
            // Display a success message and navigate to the bottom navigation bar
          } else {
            context.go("/wallet");
            setState(() {
              // Display an error message if the cloud function failed and set isFinished to false
              isFinished = false;
            });
          }
        } else{
          Logs().w("Unknown sendType");
        }

      } catch (e) {
        Logs().e("Error with sendBTC: " + e.toString());
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
    myFocusNodeAdress.dispose();
    myFocusNodeMoney.dispose();
    moneyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    processParameters(context);

    return hasReceiver ?
      SendBTCScreen(controller: this) : SearchReceiver(controller: this);
  }
}
