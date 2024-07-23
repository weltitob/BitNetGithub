import 'dart:async';
import 'dart:convert';

import 'package:bitnet/backbone/auth/auth.dart';
import 'package:bitnet/backbone/cloudfunctions/lnd/walletkitservice/estimatefee.dart';
import 'package:bitnet/backbone/cloudfunctions/lnd/walletkitservice/finalizepsbt.dart';
import 'package:bitnet/backbone/cloudfunctions/lnd/walletkitservice/fundpsbt.dart';
import 'package:bitnet/backbone/cloudfunctions/lnd/walletkitservice/listunspent.dart';
import 'package:bitnet/backbone/cloudfunctions/lnd/walletkitservice/publishtransaction.dart';
import 'package:bitnet/backbone/helper/currency/currency_converter.dart';
import 'package:bitnet/backbone/helper/databaserefs.dart';
import 'package:bitnet/backbone/helper/helpers.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/security/biometrics/biometric_check.dart';
import 'package:bitnet/backbone/services/base_controller/base_controller.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
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
import 'package:bitnet/pages/qrscanner/qrscanner.dart';
import 'package:bitnet/pages/wallet/actions/send/search_receiver.dart';
import 'package:bolt11_decoder/bolt11_decoder.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dart_lnurl/dart_lnurl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_multi_formatter/utils/bitcoin_validator/bitcoin_validator.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;

class SendsController extends BaseController {
  late BuildContext context;
  SendsController({required this.context});

  late FocusNode myFocusNodeAdressSearch;
  late TextEditingController bitcoinReceiverAdressController;
  late ScrollController sendScrollerController;

  void handleSearch(String value) {
    onQRCodeScanned(value, context);
  }

  Future<void> getClipboardData() async {
    LoggerService logger = Get.find();
    ClipboardData? data = await Clipboard.getData('text/plain');
    logger.i('clipboard data ${data?.text}');
    handleSearch(data?.text ?? '');
  }

  BitcoinUnits bitcoinUnit = BitcoinUnits.BTC;
  RxBool initializedValues = false.obs;
  RxBool isLoadingExchangeRt = true.obs;
  RxBool isLoadingFees = false.obs;
  RxBool hasReceiver = false.obs;
  RxBool moneyTextFieldIsEnabled = true.obs;
  RxBool amountWidgetOverBound = false.obs;
  RxBool amountWidgetUnderBound = false.obs;
  late FocusNode myFocusNodeAdress;
  late FocusNode myFocusNodeMoney;
  late double feesInEur_medium;
  late double feesInEur_high;
  late double feesInEur_low;
  late SendType sendType;
  String feesSelected = "Niedrig";
  RxString description = "".obs;
  late double feesDouble;
  TextEditingController satController = TextEditingController();
  TextEditingController btcController = TextEditingController(); // the controller for the amount text field
  TextEditingController currencyController = TextEditingController();
  RxBool isFinished = false.obs; // a flag indicating whether the send process is finished
  dynamic moneyineur = ''; // the amount in Euro, stored as dynamic type
  double bitcoinprice = 0.0;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>(); // a key for the form widget
  String bitcoinReceiverAdress = ""; // the Bitcoin receiver address
  int? lowerBound;
  int? upperBound;
  BitcoinUnits? boundType;
  String? lnCallback;
  //for storing lnUrl user Data
  String lnUrlname = '';
  String lnUrlLogo = '';
  RxList<ReSendUser> resendUsers = RxList<ReSendUser>();
  void processParameters(BuildContext context, String? address) {
    LoggerService logger = Get.find();
    print('Process parameters for');
    logger.i("Process parameters for sendscreen called");

    Map<String, String> queryParams = GoRouter.of(context).routeInformationProvider.value.uri.queryParameters;
    String? invoice = queryParams['invoice'];
    String? walletAdress = queryParams['walletAdress'];
    if (address != null) {
      walletAdress = address;
    }
    if (invoice != null) {
      logger.i("Invoice: $invoice");
      giveValuesToInvoice(invoice);

      bitcoinUnit = BitcoinUnits.SAT;
    } else if (walletAdress != null) {
      onQRCodeScanned(walletAdress, context);
      // logger.w("Walletadress: $walletAdress");

      // giveValuesToOnchainSend(walletAdress);
      bitcoinUnit = BitcoinUnits.SAT;
    } else {
      logger.i("No parameters found");
    }
    logger.i("Invoice: $invoice");
  }

  QRTyped determineQRType(dynamic encodedString) {
    RegExp onchainQueryValidator = RegExp(r'bitcoin:(.+?)\?amount=([0-9.]+)');
    Match? onchainQueryMatch = onchainQueryValidator.firstMatch(encodedString);

    final isLightningMailValid = isLightningAdressAsMail(encodedString);
    print("isLightingMailValid: $isLightningMailValid");
    final isStringInvoice = isStringALNInvoice(encodedString);
    print("isStringInvoice: $isStringInvoice");
    final isBitcoinValid =
        isBitcoinWalletValid(encodedString) || (onchainQueryMatch != null && isBitcoinWalletValid(onchainQueryMatch.group(1)));
    ;
    print("isBitcoinValid: $isBitcoinValid");
    final isLnUrl = (encodedString as String).toLowerCase().startsWith("lnurl");
    late QRTyped qrTyped;

    logger.i("Determining the QR type...");
    // Logic to determine the QR type based on the encoded string
    // Return the appropriate QRTyped enum value
    if (isLightningMailValid) {
      qrTyped = QRTyped.LightningMail;
    } else if (isLnUrl) {
      qrTyped = QRTyped.LightningUrl;
    } else if (isStringInvoice) {
      qrTyped = QRTyped.Invoice;
    } else if (isBitcoinValid) {
      qrTyped = QRTyped.OnChain;
    } else {
      qrTyped = QRTyped.Unknown;
    }
    return qrTyped;
  }

  void onQRCodeScanned(dynamic encodedString, BuildContext cxt) {
    // Logic to determine the type of QR code
    QRTyped type = determineQRType(encodedString);
    logger.i("TYPE DETECTED! $type");

    switch (type) {
      case QRTyped.LightningUrl:
        giveValuesToLnUrl(encodedString);
        break;
      case QRTyped.LightningMail:
        // Handle LightningMail QR code
        giveValuesToLnUrl(encodedString, asAddress: true);
        break;
      case QRTyped.OnChain:
        // Navigator.push(cxt, MaterialPageRoute(builder: (context)=>Send()));
        // cxt.go("/wallet/send?walletAdress=$encodedString");
        giveValuesToOnchainSend(encodedString);
        break;
      case QRTyped.Invoice:
        logger.i("Invoice was detected will forward to Send screen with invoice: $encodedString");
        showOverlay(context, encodedString);
        giveValuesToInvoice(encodedString);
        //cxt.go("/wallet/send?walletAdress=$encodedString");
        break;
      case QRTyped.Profile:
        // Handle Profile QR code
        break;
      case QRTyped.RestoreLogin:
      //  onScannedForSignIn(encodedString);
      case QRTyped.Unknown:

        //send to unknown qr code page which shows raw data
        //context.go("/error");
        break;
      default:
      // Handle unknown QR code
    }
    initializedValues.value = true;
  }

  @override
  void onInit() {
    super.onInit();
    btcController.text = "0.00001"; // set the initial amount to 0.00001
    satController.text = "1000";
    myFocusNodeAdress = FocusNode();
    myFocusNodeMoney = FocusNode();
    bitcoinReceiverAdressController = TextEditingController();
    sendScrollerController = ScrollController();
    sendScrollerController.addListener(() {
      scrollToSearchFunc(sendScrollerController, myFocusNodeAdressSearch);
    });
    myFocusNodeAdressSearch = FocusNode();
    getClipboardData();
    getSendUsers();
  }

  void resetValues() {
    hasReceiver.value = false;
    bitcoinReceiverAdress = "";
    btcController.text = "0.00001";
    satController.text = "1000";
    moneyTextFieldIsEnabled.value = true;
    description.value = "";
    //context.go("/wallet/send");
  }

  void giveValuesToOnchainSend(String onchainAdress) async {
    resetValues();
    RegExp onchainQueryValidator = RegExp(r'bitcoin:(.+?)\?amount=([0-9.]+)');
    Match? onchainQueryMatch = onchainQueryValidator.firstMatch(onchainAdress);

    if (onchainQueryMatch != null && onchainQueryMatch.group(2) != null && double.tryParse(onchainQueryMatch.group(2)!) != null) {
      btcController.text = onchainQueryMatch.group(2)!;
      satController.text = CurrencyConverter.convertBitcoinToSats(double.parse(onchainQueryMatch.group(2)!)).toStringAsFixed(0);
    } else {
      btcController.text = '0.0';
      satController.text = '0';
    }
    String finalAddress = onchainQueryMatch?.group(1) != null ? onchainQueryMatch!.group(1)! : onchainAdress;
    {
      sendType = SendType.OnChain;
      hasReceiver.value = true;
      bitcoinReceiverAdress = finalAddress;
      moneyTextFieldIsEnabled.value = true;
    }
    dynamic fundedPsbtResponse = await estimateFee(AppTheme.targetConf.toString());
    final sat_per_kw = fundedPsbtResponse.data["sat_per_kw"];
    double sat_per_vbyte = double.parse(sat_per_kw); // / 4
    feesDouble = sat_per_vbyte;
    bitcoinUnit = BitcoinUnits.SAT;

    print("Estimated fees: $feesDouble");
  }

  void giveValuesToLnUrl(String lnUrl, {bool asAddress = false}) async {
    String finalLnUrl = lnUrl;
    LNURLParseResult? lnResult = null;
    if (asAddress) {
      List<String> lnUrlParts = lnUrl.split('@');
      finalLnUrl = 'https://${lnUrlParts[1]}/.well-known/lnurlp/${lnUrlParts[0]}';
      dynamic httpResult = await http.get(Uri.parse(finalLnUrl));
      if (httpResult.statusCode != 200) {
        return;
      }
      lnResult = LNURLParseResult(payParams: LNURLPayParams.fromJson(jsonDecode(httpResult.body)));
      lnUrlname = lnUrlParts[0];
      //for logo
      dynamic logoUrl = 'https://${lnUrlParts[1]}';
      lnUrlLogo = (await extractLogoUrl(logoUrl)) ?? '';
    } else {
      lnResult = await getParams(finalLnUrl);
      if (lnResult.payParams != null) {
        String url = lnResult.payParams!.metadata;
        List<dynamic> metadata = jsonDecode(url);
        String? identifierString = metadata.where((t) => t is List && t.contains('text/identifier')).firstOrNull?[1];
        if (identifierString != null) {
          List<String> lnUrlParts = identifierString.split('@');

          lnUrlname = lnUrlParts[0];
          dynamic logoUrl = 'https://${lnUrlParts[1]}';
          try {
            lnUrlLogo = (await extractLogoUrl(logoUrl)) ?? '';
          } catch (e) {
            lnUrlLogo = '';
          }
        }
      }
    }
    if (lnResult.payParams != null) {
      hasReceiver.value = true;
      sendType = SendType.LightningUrl;
      bitcoinReceiverAdress = lnUrl;
      satController.text = lnResult.payParams!.minSendable.toString();

      bitcoinUnit = BitcoinUnits.SAT;
      moneyTextFieldIsEnabled.value = false;
      lowerBound = lnResult.payParams!.minSendable;
      upperBound = lnResult.payParams!.maxSendable;
      boundType = BitcoinUnits.SAT;
      lnCallback = lnResult.payParams!.callback;
    }
  }

  void payLnUrl(String url, int amount, BuildContext context) async {
    Uri finalUrl = Uri.parse(url + "?amount=${amount * 1000}");

    dynamic response = await http.get(finalUrl);
    dynamic body = jsonDecode(response.body);
    String invoicePr = body["pr"];
    String lnUrl = bitcoinReceiverAdress;
    List<String> invoiceStrings = [invoicePr];

    Stream<RestResponse> paymentStream = sendPaymentV2Stream(invoiceStrings);
    StreamSubscription? sub;
    sub = paymentStream.listen((RestResponse response) {
      isFinished.value = true;
      if (response.statusCode == "success") {
        sendPaymentDataLnUrl(response.data['result'], lnUrl, lnUrlname);
        sub!.cancel();

        GoRouter.of(context).go("/feed");
        showOverlay(context, "Payment successful!");
      } else {
        showOverlay(context, "Payment failed: ${response.message}");
        isFinished.value = false;
        sub!.cancel();
      }
    }, onError: (error) {
      isFinished.value = false;
      showOverlay(context, "An error occurred: $error");
    }, onDone: () {}, cancelOnError: true);
    print(response.body);
    resetValues();
  }

  void giveValuesToInvoice(String invoiceString) {
    LoggerService logger = Get.find();
    logger.i("Invoice that is about to be paid for: $invoiceString");
    sendType = SendType.Invoice;
    hasReceiver.value = true;
    bitcoinReceiverAdress = invoiceString;

    Bolt11PaymentRequest req = Bolt11PaymentRequest(invoiceString);
    satController.text = CurrencyConverter.convertBitcoinToSats(req.amount.toDouble()).toString();
    moneyTextFieldIsEnabled.value = false;
    description.value = req.tags[1].data;
  }

  changeFees(String fees) {
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
  }

  sendBTC(BuildContext context) async {
    LoggerService logger = Get.find();
    logger.i("sendBTC() called");
    await isBiometricsAvailable();
    if (isBioAuthenticated == true || hasBiometrics == false) {
      try {
        if (sendType == SendType.LightningUrl) {
          payLnUrl(lnCallback!, int.parse(satController.text), context);
        } else if (sendType == SendType.Invoice) {
          logger.i("Sending invoice: $bitcoinReceiverAdress");

          List<String> invoiceStrings = [bitcoinReceiverAdress]; // Assuming you want to send a list containing a single invoice for now

          Stream<RestResponse> paymentStream = sendPaymentV2Stream(invoiceStrings);
          paymentStream.listen((RestResponse response) {
            isFinished.value = true; // Assuming you might want to update UI on each response
            if (response.statusCode == "success") {
              // Handle success
              if (response.data['result']['status'] != "FAILED") {
                sendPaymentDataInvoice(response.data['result']);
              }
              logger.i("Payment successful!");
              showOverlay(context, "Payment successful!");
              GoRouter.of(context).go("/feed");
            } else {
              // Handle error
              logger.i("Payment failed!");
              showOverlay(context, "Payment failed: ${response.message}");
              isFinished.value = false; // Keep the user on the same page to possibly retry or show error
            }
          }, onError: (error) {
            isFinished.value = false;
            showOverlay(context, "An error occurred: $error");
          }, onDone: () {
            // Handle stream completion if necessary
          }, cancelOnError: true // Cancel the subscription upon first error
              );
        } else if (sendType == SendType.OnChain) {
          logger.i("Sending Onchain Payment to: $bitcoinReceiverAdress");
          final amountInSat = int.parse(satController.text);

          dynamic restResponseListUnspent = await listUnspent();
          UtxoRequestList utxos = UtxoRequestList.fromJson(restResponseListUnspent.data);

          TransactionData transactiondata = TransactionData(
              raw: RawTransactionData(
                inputs: utxos.utxos
                    .map((i) => Input(
                          txidStr: i.outpoint.txidStr,
                          txidBytes: i.outpoint.txidBytes,
                          outputIndex: i.outpoint.outputIndex,
                        ))
                    .toList(),
                outputs: Outputs(outputs: {bitcoinReceiverAdress: amountInSat.toInt()}),
              ),
              targetConf: AppTheme.targetConf, //The number of blocks to aim for when confirming the transaction.
              account: "",
              minConfs: 4, //going for safety and not speed because for speed oyu would use the lightning network
              spendUnconfirmed: false, //Whether unconfirmed outputs should be used as inputs for the transaction.
              changeType: 0 //CHANGE_ADDRESS_TYPE_UNSPECIFIED
              );

          dynamic fundPsbtrestResponse = await fundPsbt(transactiondata);
          FundedPsbtResponse fundedPsbtResponse = FundedPsbtResponse.fromJson(fundPsbtrestResponse.data);
          dynamic finalizedPsbtRestResponse = await finalizePsbt(fundedPsbtResponse.fundedPsbt);
          FinalizePsbtResponse finalizedPsbtResponse = FinalizePsbtResponse.fromJson(finalizedPsbtRestResponse.data);

          RestResponse publishTransactionRestResponse = await publishTransaction(finalizedPsbtResponse.rawFinalTx, ""); //txhex and label

          isFinished.value = true;
          if (publishTransactionRestResponse.statusCode == "200") {
            sendPaymentDataOnchain(
                {...finalizedPsbtRestResponse.data, ...fundPsbtrestResponse.data, 'min_confs': 4, 'address': bitcoinReceiverAdress});
            context.go("/feed");
            // Display a success message and navigate to the bottom navigation bar
          } else {
            context.go("/feed");
            // Display an error message if the cloud function failed and set isFinished to false
            isFinished.value = false;
          }
        } else {
          logger.i("Unknown sendType");
        }
      } catch (e) {
        logger.e("Error with sendBTC: " + e.toString());
        isFinished.value = false;
      }
    } else {
      // Display an error message if biometric authentication failed
      isFinished.value = false;
      logger.e('Biometric authentication failed');
    }
  }

  @override
  void dispose() {
    myFocusNodeAdress.dispose();
    myFocusNodeMoney.dispose();
    btcController.dispose();
    satController.dispose();
    currencyController.dispose();
    super.dispose();
  }

  void sendPaymentDataLnUrl(Map<String, dynamic> data, String lnUrl, String name) {
    btcSendsRef
        .doc(Auth().currentUser!.uid)
        .collection('lnurl')
        .add({...data, 'lnurl': lnUrl, 'user_name': name, 'address_logo': lnUrlLogo});
    lnUrlname = '';
    lnUrlLogo = '';
  }

  Future<void> getSendUsers() async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await btcSendsRef.doc(Auth().currentUser!.uid).collection('lnurl').get();
    QuerySnapshot<Map<String, dynamic>> snapshotChain = await btcSendsRef.doc(Auth().currentUser!.uid).collection('onchain').get();

    List<ReSendUser> users = snapshot.docs
        .map((doc) {
          try {
            return ReSendUser.fromJson(doc.data());
          } catch (e) {
            return null;
          }
        })
        .where((user) => user != null)
        .cast<ReSendUser>()
        .toList();
    users.addAll(snapshotChain.docs
        .map((doc) {
          try {
            return ReSendUser.fromJson(doc.data());
          } catch (e) {
            return null;
          }
        })
        .where((user) => user != null)
        .cast<ReSendUser>());
    resendUsers.addAll([...users]);
    //compile different lists to preview
  }

  void sendPaymentDataInvoice(Map<String, dynamic> data) {
    btcSendsRef.doc(Auth().currentUser!.uid).collection('lnbc').add(data);
  }

  void sendPaymentDataOnchain(Map<String, dynamic> data) {
    btcSendsRef.doc(Auth().currentUser!.uid).collection('onchain').add(data);
  }
}

enum SendType {
  Lightning,
  LightningUrl,
  OnChain,
  Invoice,
  Unknown,
}
