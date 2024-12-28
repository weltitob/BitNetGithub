import 'dart:async';
import 'dart:convert';

import 'package:bitcoin_base/bitcoin_base.dart';
import 'package:bitnet/backbone/auth/auth.dart';
import 'package:bitnet/backbone/auth/storePrivateData.dart';
import 'package:bitnet/backbone/cloudfunctions/broadcast_transaction.dart';
import 'package:bitnet/backbone/cloudfunctions/lnd/lightningservice/list_invoices.dart';
import 'package:bitnet/backbone/cloudfunctions/lnd/walletkitservice/estimatefee.dart';
import 'package:bitnet/backbone/cloudfunctions/lnd/walletkitservice/finalizepsbt.dart';
import 'package:bitnet/backbone/cloudfunctions/lnd/walletkitservice/fundpsbt.dart';
import 'package:bitnet/backbone/cloudfunctions/lnd/walletkitservice/get_transaction.dart';
import 'package:bitnet/backbone/cloudfunctions/lnd/walletkitservice/list_btc_addresses.dart';
import 'package:bitnet/backbone/cloudfunctions/lnd/walletkitservice/listunspent.dart';
import 'package:bitnet/backbone/cloudfunctions/lnd/walletkitservice/nextaddr.dart';
import 'package:bitnet/backbone/cloudfunctions/lnd/walletkitservice/publishtransaction.dart';
import 'package:bitnet/backbone/helper/currency/currency_converter.dart';
import 'package:bitnet/backbone/helper/databaserefs.dart';
import 'package:bitnet/backbone/helper/helpers.dart';
import 'package:bitnet/backbone/helper/key_services/hdwalletfrommnemonic.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/security/biometrics/biometric_check.dart';
import 'package:bitnet/backbone/services/base_controller/base_controller.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:bitnet/backbone/streams/lnd/sendpayment_v2.dart';
import 'package:bitnet/components/dialogsandsheets/notificationoverlays/overlay.dart';
import 'package:bitnet/models/bitcoin/lnd/payment_model.dart';
import 'package:bitnet/models/bitcoin/lnd/received_invoice_model.dart';
import 'package:bitnet/models/bitcoin/lnd/transaction_model.dart';
import 'package:bitnet/models/bitcoin/walletkit/finalizepsbtresponse.dart';
import 'package:bitnet/models/bitcoin/walletkit/fundpsbtresponse.dart';
import 'package:bitnet/models/bitcoin/walletkit/input.dart';
import 'package:bitnet/models/bitcoin/walletkit/output.dart';
import 'package:bitnet/models/bitcoin/walletkit/rawtransactiondata.dart';
import 'package:bitnet/models/bitcoin/walletkit/transactiondata.dart';
import 'package:bitnet/models/bitcoin/walletkit/utxorequest.dart';
import 'package:bitnet/models/currency/bitcoinunitmodel.dart';
import 'package:bitnet/models/firebase/restresponse.dart';
import 'package:bitnet/models/keys/privatedata.dart';
import 'package:bitnet/pages/qrscanner/qrscanner.dart';
import 'package:bitnet/pages/wallet/actions/send/search_receiver.dart';
import 'package:bitnet/pages/wallet/controllers/wallet_controller.dart';
import 'package:blockchain_utils/hex/hex.dart';
import 'package:blockchain_utils/utils/string/string.dart';
import 'package:bolt11_decoder/bolt11_decoder.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:dart_lnurl/dart_lnurl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_multi_formatter/utils/bitcoin_validator/bitcoin_validator.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;

class SendsController extends BaseController {
  late BuildContext context;
  final bool getClipOnInit;
  SendsController({required this.context, this.getClipOnInit = true});

  late FocusNode myFocusNodeAdressSearch;
  late TextEditingController bitcoinReceiverAdressController;
  late ScrollController sendScrollerController;
  Rx<String> usersQuery = ''.obs;
  List<ReSendUser> queriedUsers = List.empty(growable: true);

  void handleSearch(String value) {
    logger.i("handleSearch called with value: $value");
    onQRCodeScanned(value, context);
  }

  Future<void> getClipboardData() async {
    List<ReceivedInvoice> restLightningInvoices =
        await listInvoices(Auth().currentUser!.uid, pending_only: true);
    ReceivedInvoicesList lightningInvoices = ReceivedInvoicesList.fromJson({
      'invoices': restLightningInvoices.map((inv) => inv.toJson()).toList()
    });
    LoggerService logger = Get.find();
    ClipboardData? data = await Clipboard.getData('text/plain');
    List<ReceivedInvoice> memoVoices =
        lightningInvoices.invoices.where((inv) => inv.memo.isNotEmpty).toList();
    bool shouldSearchInvoice = lightningInvoices.invoices
            .where((invoice) => invoice.paymentRequest == (data?.text ?? ''))
            .length ==
        0;
    String btcAddressToCompare = (data?.text ?? '').startsWith('bitcoin:')
        ? data!.text!.split(":")[1].split("?")[0]
        : (data?.text ?? '');
    List<String> btcAddresses =
        Get.find<WalletsController>().btcAddresses.toList();
    bool shouldSearchOnchain = !Get.find<WalletsController>()
        .btcAddresses
        .contains(btcAddressToCompare);
    logger.i('clipboard data ${data?.text}');
    if (shouldSearchOnchain && shouldSearchInvoice) {
      handleSearch(data?.text ?? '');
    }
  }

  BitcoinUnits bitcoinUnit = BitcoinUnits.BTC;
  RxBool initializedValues = false.obs;
  RxBool isLoadingExchangeRt = true.obs;
  RxBool isLoadingFees = false.obs;
  RxBool hasReceiver = false.obs;
  RxBool moneyTextFieldIsEnabled = true.obs;
  RxBool amountWidgetOverBound = false.obs;
  RxBool amountWidgetUnderBound = false.obs;

  RxBool loadingSending = false.obs;

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
  TextEditingController btcController =
      TextEditingController(); // the controller for the amount text field
  TextEditingController currencyController = TextEditingController();
  RxBool isFinished =
      false.obs; // a flag indicating whether the send process is finished
  dynamic moneyineur = ''; // the amount in Euro, stored as dynamic type
  double bitcoinprice = 0.0;
  final GlobalKey<FormState> formKey =
      GlobalKey<FormState>(); // a key for the form widget
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
    logger.i('Process parameters for $address');
    logger.i("Process parameters for sendscreen called");

    Map<String, String> queryParams =
        GoRouter.of(context).routeInformationProvider.value.uri.queryParameters;

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
    logger.e("Invoice: $invoice");
  }

  QRTyped determineQRType(dynamic encodedString) {
    RegExp onchainQueryValidator = RegExp(r'bitcoin:(.+?)\?amount=([0-9.]+)');
    Match? onchainQueryMatch = onchainQueryValidator.firstMatch(encodedString);

    final isLightningMailValid = isLightningAdressAsMail(encodedString);
    print("isLightingMailValid: $isLightningMailValid");
    final isStringInvoice = isStringALNInvoice(encodedString);
    print("isStringInvoice: $isStringInvoice");
    final isBitcoinValid = isBitcoinWalletValid(encodedString) ||
        (onchainQueryMatch != null &&
            isBitcoinWalletValid(onchainQueryMatch.group(1)));
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
        logger.i("LightningUrl was detected");
        giveValuesToLnUrl(encodedString);
        break;
      case QRTyped.LightningMail:
        logger.i("LightningMail was detected");
        // Handle LightningMail QR code
        giveValuesToLnUrl(encodedString, asAddress: true);
        break;
      case QRTyped.OnChain:
        logger.i("OnChain was detected");
        // Navigator.push(cxt, MaterialPageRoute(builder: (context)=>Send()));
        // cxt.go("/wallet/send?walletAdress=$encodedString");
        giveValuesToOnchainSend(encodedString);
        break;
      case QRTyped.Invoice:
        logger.i(
            "Invoice was detected will forward to Send screen with invoice: $encodedString");
        // showOverlay(context, encodedString);
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
    btcController.text = "0.0"; // set the initial amount to 0.0
    satController.text = "0.0";
    myFocusNodeAdress = FocusNode();
    myFocusNodeMoney = FocusNode();
    bitcoinReceiverAdressController = TextEditingController();
    sendScrollerController = ScrollController();
    sendScrollerController.addListener(() {
      scrollToSearchFunc(sendScrollerController, myFocusNodeAdressSearch);
    });
    myFocusNodeAdressSearch = FocusNode();

    getSendUsers();
  }

  void resetValues() {
    hasReceiver.value = false;
    bitcoinReceiverAdress = "";
    btcController.text = "0.0";
    satController.text = "0.0";
    moneyTextFieldIsEnabled.value = true;
    description.value = "";
    //context.go("/wallet/send");
  }

  void giveValuesToOnchainSend(String onchainAdress) async {
    resetValues();
    RegExp onchainQueryValidator = RegExp(r'bitcoin:(.+?)\?amount=([0-9.]+)');
    Match? onchainQueryMatch = onchainQueryValidator.firstMatch(onchainAdress);

    if (onchainQueryMatch != null &&
        onchainQueryMatch.group(2) != null &&
        double.tryParse(onchainQueryMatch.group(2)!) != null) {
      btcController.text = onchainQueryMatch.group(2)!;

      satController.text = CurrencyConverter.convertBitcoinToSats(
              double.parse(onchainQueryMatch.group(2)!))
          .toStringAsFixed(0);
    } else {
      btcController.text = '0.0';
      satController.text = '0';
    }

    String finalAddress = onchainQueryMatch?.group(1) != null
        ? onchainQueryMatch!.group(1)!
        : onchainAdress;
    {
      sendType = SendType.OnChain;
      hasReceiver.value = true;
      bitcoinReceiverAdress = finalAddress;
      moneyTextFieldIsEnabled.value = true;
    }

    dynamic fundedPsbtResponse =
        await estimateFee(AppTheme.targetConf.toString());
    final sat_per_kw = fundedPsbtResponse.data["sat_per_kw"];
    double sat_per_vbyte = double.parse(sat_per_kw); // / 4
    feesDouble = sat_per_vbyte;
    bitcoinUnit = BitcoinUnits.SAT;

    logger.i("Estimated fees: $feesDouble");
  }

  void giveValuesToLnUrl(String lnUrl, {bool asAddress = false}) async {
    logger.i("LNURL detected: $lnUrl");
    String finalLnUrl = lnUrl;
    LNURLParseResult? lnResult = null;
    if (asAddress) {
      List<String> lnUrlParts = lnUrl.split('@');
      finalLnUrl =
          'https://${lnUrlParts[1]}/.well-known/lnurlp/${lnUrlParts[0]}';
      dynamic httpResult = await http.get(Uri.parse(finalLnUrl));
      if (httpResult.statusCode != 200) {
        return;
      }
      lnResult = LNURLParseResult(
          payParams: LNURLPayParams.fromJson(jsonDecode(httpResult.body)));
      lnUrlname = lnUrlParts[0];
      //for logo
      dynamic logoUrl = 'https://${lnUrlParts[1]}';
      lnUrlLogo = (await extractLogoUrl(logoUrl)) ?? '';
    } else {
      lnResult = await getParams(finalLnUrl);
      if (lnResult.payParams != null) {
        String url = lnResult.payParams!.metadata;
        List<dynamic> metadata = jsonDecode(url);
        String? identifierString = metadata
            .where((t) => t is List && t.contains('text/identifier'))
            .firstOrNull?[1];
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
      logger.i("Min sendable: ${lnResult.payParams!.minSendable}");

      bitcoinUnit = BitcoinUnits.SAT;
      moneyTextFieldIsEnabled.value = false;
      lowerBound = lnResult.payParams!.minSendable;
      upperBound = lnResult.payParams!.maxSendable;
      boundType = BitcoinUnits.SAT;
      lnCallback = lnResult.payParams!.callback;
    }
  }

  Future<LightningPayment?> payLnUrl(
      String url, int amount, BuildContext context) async {
    final logger = Get.find<LoggerService>();
    final overlayController = Get.find<OverlayController>();

    logger.i("payLnUrl called with url: $url and amount: ${amount * 1000}");

    Uri finalUrl = Uri.parse(url + "?amount=${amount * 1000}");
    LightningPayment? payment;
    dynamic response = await http.get(finalUrl);
    dynamic body = jsonDecode(response.body);
    String invoicePr = body["pr"];

    String lnUrl = bitcoinReceiverAdress;
    List<String> invoiceStrings = [invoicePr];

    //ahhhh nur wenn quasie der text geändert wird passt aktuell aber wenn der nicht geändert wird kackts ab
    Stream<dynamic> paymentStream =
        sendPaymentV2Stream(Auth().currentUser!.uid, invoiceStrings, amount);
    StreamSubscription? sub;
    bool transactionsUpdated = false;

    sub = paymentStream.listen((dynamic response) {
      isFinished.value = true;
      if ((response as Map<String, dynamic>)['status'] == 'SUCCEEDED') {
        //sendPaymentDataLnUrl(response, lnUrl, lnUrlname);
        // Convert response to a valid JSON string
        String jsonString = jsonEncode(response);

        // Decode the JSON string back into a Map<String, dynamic>
        var typedResponse = jsonDecode(jsonString) as Map<String, dynamic>;

        LightningPayment payment = LightningPayment.fromJson(typedResponse);
        if (!transactionsUpdated) {
          Get.find<WalletsController>().newTransactionData.add(payment);
          transactionsUpdated = true;
        }
        //connect this with transactions views
        Get.find<WalletsController>().fetchLightingWalletBalance();
        sub!.cancel();
        logger.i("Payment successful! Forwarding to feed...");
        overlayController.showOverlay(this.context, "Payment successful!");
        context.go("/");

      } else if ((response)['status'] == 'FAILED') {

        overlayController.showOverlay(
            this.context, "Payment failed: ${response['failure_reason']}");

        isFinished.value = false;
        sub!.cancel();
      } else {
        overlayController.showOverlay(
              this.context, "Payment failed: please try again later...");

        isFinished.value = false;
        sub!.cancel();
      }
    }, onError: (error) {
      isFinished.value = false;

      overlayController.showOverlay(this.context, "An error occurred: $error");

    }, onDone: () {
      resetValues();
    }, cancelOnError: true);
    logger.i("Payment successful! ${response.body}");

    return payment;
  }

  void giveValuesToInvoice(String invoiceString) {
    LoggerService logger = Get.find();
    logger.i("Invoice that is about to be paid for: $invoiceString");
    sendType = SendType.Invoice;
    hasReceiver.value = true;
    bitcoinReceiverAdress = invoiceString;

    Bolt11PaymentRequest req = Bolt11PaymentRequest(invoiceString);
    double satoshi =
        CurrencyConverter.convertBitcoinToSats(req.amount.toDouble());
    int cleanAmount = satoshi.toInt();
    satController.text = cleanAmount.toString();
    // currencyController.text = CurrencyConverter.convertCurrency(BitcoinUnits.SAT.name, cleanAmount.toDouble(), outputCurrency, bitcoinPrice);
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

    loadingSending = true.obs;
    LoggerService logger = Get.find<LoggerService>();
    final overlayController = Get.find<OverlayController>();
    logger.i("sendBTC() called");

    await isBiometricsAvailable();
    if (isBioAuthenticated == true || hasBiometrics == false) {
      try {
        if (sendType == SendType.LightningUrl) {

          logger.i("Amount that is being sent: ${satController.text}");
          logger.i("Satcontroller text: ${satController.text}");
          logger
              .i("Satcontroller text parsed: ${int.parse(satController.text)}");
          payLnUrl(lnCallback!, int.parse(satController.text), context);


        } else if (sendType == SendType.Invoice) {
          logger.i("Sending invoice: $bitcoinReceiverAdress");

          List<String> invoiceStrings = [
            bitcoinReceiverAdress
          ]; // Assuming you want to send a list containing a single invoice for now

          Stream<dynamic> paymentStream = sendPaymentV2Stream(
              Auth().currentUser!.uid,
              invoiceStrings,
              int.parse(satController.text));
          bool firstSuccess = false;
          paymentStream.listen((dynamic response) {
            isFinished.value =
                true; // Assuming you might want to update UI on each response
            if (response['status'] == "SUCCEEDED") {
              logger.i("Success: ${response}");

              String jsonString = jsonEncode(response);

              // Decode the JSON string back into a Map<String, dynamic>
              var typedResponse = jsonDecode(jsonString) as Map<String, dynamic>;

              LightningPayment payment = LightningPayment.fromJson(typedResponse);

              Get.find<WalletsController>().newTransactionData.add(payment);
              // Handle success
              sendPaymentDataInvoice(response);

              if (!firstSuccess) {
                logger.i("Payment successful!");
                Get.find<WalletsController>().fetchLightingWalletBalance();

                overlayController.showOverlay(this.context, "Payment successful!");
                logger.i("Payment successful! Forwarding to wallet...");
                context.go("/");

                firstSuccess = true;
              }
            }
            if (response['status'] == "FAILED") {
              // Handle error
              logger.i("Payment failed!");
              if (!firstSuccess) {
                overlayController.showOverlay(
                    this.context, "Payment failed: ${response.message}");

                firstSuccess = true;
              }

              isFinished.value =
                  false; // Keep the user on the same page to possibly retry or show error
            } else {
              logger.i("Parsing of response failed! PLEASE FIX");
              isFinished.value =
                  false; // Keep the user on the same page to possibly retry or show error
            }
          }, onError: (error) {
            isFinished.value = false;
            overlayController.showOverlay(this.context, "An error occurred: $error");

          }, onDone: () {
            // Handle stream completion if necessary
          }, cancelOnError: true // Cancel the subscription upon first error
              );
        } else if (sendType == SendType.OnChain) {
          logger.i("Sending Onchain Payment to: $bitcoinReceiverAdress");
          final amountInSat = int.parse(satController.text);
          RestResponse listAddressesResponse =
              await listAddressesLnd(Auth().currentUser!.uid);

          AccountWithAddresses account = AccountWithAddresses.fromJson(
              (listAddressesResponse.data['account_with_addresses'] as List)
                  .firstWhereOrNull(
                      (acc) => acc['name'] == Auth().currentUser!.uid));
          List<String> changeAddresses = account.addresses
              .where((test) => test.isInternal)
              .map((test) => test.address)
              .toList();
          List<String> nonChangeAddresses = account.addresses
              .where((test) => !test.isInternal)
              .map((test) => test.address)
              .toList();

          dynamic restResponseListUnspent =
              await listUnspent(Auth().currentUser!.uid);
          UtxoRequestList utxos =
              UtxoRequestList.fromJson(restResponseListUnspent.data);
          TransactionData transactiondata = TransactionData(
              raw: RawTransactionData(
                inputs: utxos.utxos
                    .map((i) => Input(
                          txidStr: i.outpoint.txidStr,
                          txidBytes: i.outpoint.txidBytes,
                          outputIndex: i.outpoint.outputIndex,
                        ))
                    .toList(),
                outputs: Outputs(
                    outputs: {bitcoinReceiverAdress: amountInSat.toInt()}),
              ),
              targetConf: AppTheme
                  .targetConf, //The number of blocks to aim for when confirming the transaction.
              account: "",
              minConfs:
                  4, //going for safety and not speed because for speed oyu would use the lightning network
              spendUnconfirmed:
                  false, //Whether unconfirmed outputs should be used as inputs for the transaction.
              changeType: 0 //CHANGE_ADDRESS_TYPE_UNSPECIFIED
              );

          PrivateData privData = await getPrivateData(Auth().currentUser!.uid);
          dynamic feeResponse =
              await estimateFee(AppTheme.targetConf.toString());
          final sat_per_kw = double.parse(feeResponse.data["sat_per_kw"]);
          double utxoSum = 0;
          for (Utxo utxo in utxos.utxos) {
            utxoSum += utxo.amountSat;
          }

          String changeAddress =
              await nextAddr(Auth().currentUser!.uid, change: true);
          HDWallet hdWallet = HDWallet.fromMnemonic(privData.mnemonic);
          final builder = BitcoinTransactionBuilder(
              outPuts: [
                BitcoinOutput(
                    address: parseBitcoinAddress(bitcoinReceiverAdress),
                    value: BigInt.from(amountInSat.toInt())),
                BitcoinOutput(
                    address: parseBitcoinAddress(changeAddress),
                    value: BigInt.from(
                        utxoSum - (amountInSat.toInt() + sat_per_kw)))
              ],
              fee: BigInt.from(sat_per_kw),
              network: BitcoinNetwork.mainnet,
              utxos: utxos.utxos
                  .map((utxo) => UtxoWithAddress(
                      utxo: BitcoinUtxo(
                          txHash: utxo.outpoint.txidStr,
                          value: BigInt.from(utxo.amountSat),
                          vout: utxo.outpoint.outputIndex,
                          scriptType: parseBitcoinAddress(utxo.address).type),
                      ownerDetails: UtxoAddressDetails(
                          publicKey: hdWallet
                              .findKeyPair(
                                utxo.address,
                                privData.mnemonic,
                                changeAddresses.contains(utxo.address) ? 1 : 0,
                              )
                              .getPublic()
                              .publicKey
                              .toHex(),
                          address: parseBitcoinAddress(utxo.address))))
                  .toList());
          // dynamic fundPsbtrestResponse =
          //     await fundPsbt(transactiondata, Auth().currentUser!.uid);
          // FundedPsbtResponse fundedPsbtResponse =
          //     FundedPsbtResponse.fromJson(fundPsbtrestResponse.data);
          // print('fundedpsbt izak');
          // print(fundedPsbtResponse.fundedPsbt);
          // dynamic finalizedPsbtRestResponse =
          //     await signPsbt(fundedPsbtResponse.fundedPsbt);
          // FinalizePsbtResponse finalizedPsbtResponse =
          //     FinalizePsbtResponse.fromJson(finalizedPsbtRestResponse.data);
          final tr =
              builder.buildTransaction((trDigest, utxo, publicKey, sighash) {
            String address =
                utxo.ownerDetails.address.toAddress(BitcoinNetwork.mainnet);
            final ECPrivate privateKey = hdWallet.findKeyPair(
              address,
              privData.mnemonic,
              changeAddresses.contains(address) ? 1 : 0,
            );
            return privateKey.signInput(trDigest, sigHash: sighash);
          });
          final txId = tr.serialize();
          // RestResponse publishTransactionRestResponse =
          //     await broadcastTransaction(txId); //txhex and label
          const network = BitcoinNetwork.mainnet;

          /// Define http provider and api provider
          final service = BitcoinApiService();
          final api = ApiProvider.fromBlocCypher(network, service);
          String response = await api.sendRawTransaction(tr.serialize());
          print(response);
          isFinished.value = true;
          if ('' == "200") {
            // sendPaymentDataOnchain({
            //   ...finalizedPsbtRestResponse.data,
            //   ...fundPsbtrestResponse.data,
            //   'min_confs': 4,
            //   'address': bitcoinReceiverAdress
            // });
            // getTransaction(convertRawTxToTxId(
            //         finalizedPsbtRestResponse.data['raw_final_tx']))
            //     .then((d) {
            //   if (d.statusCode == "200") {
            //     BitcoinTransaction transaction =
            //         BitcoinTransaction.fromJson(d.data);
            //     Get.find<WalletsController>()
            //         .newTransactionData
            //         .add(transaction);
            //   }
            // });
            Get.find<WalletsController>().fetchOnchainWalletBalance();


            overlayController.showOverlay(this.context, "Payment successful!");
            GoRouter.of(this.context).go("/feed");

          } else {

              overlayController.showOverlay(this.context, "Payment failed.");

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
    loadingSending = false.obs;
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

  void sendPaymentDataLnUrl(
      Map<String, dynamic> data, String lnUrl, String name) {
    btcSendsRef.doc(Auth().currentUser!.uid).set({"initialized": true});
    btcSendsRef.doc(Auth().currentUser!.uid).collection('lnurl').add({
      ...data,
      'lnurl': lnUrl,
      'user_name': name,
      'address_logo': lnUrlLogo
    });
    resendUsers.add(ReSendUser(
        profileUrl: lnUrlLogo,
        type: 'lnurl',
        address: lnUrl,
        userName: lnUrlname));
    resendUsers.value = resendUsers.toSet().toList();

    lnUrlname = '';
    lnUrlLogo = '';
  }

  Future<void> getSendUsers() async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await btcSendsRef
        .doc(Auth().currentUser!.uid)
        .collection('lnurl')
        .get();
    QuerySnapshot<Map<String, dynamic>> snapshotChain = await btcSendsRef
        .doc(Auth().currentUser!.uid)
        .collection('onchain')
        .get();

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
    resendUsers.clear();
    resendUsers.addAll([...users]);
    resendUsers.value = resendUsers.toSet().toList();
    //compile different lists to preview
  }

  void sendPaymentDataInvoice(Map<String, dynamic> data) {
    btcSendsRef.doc(Auth().currentUser!.uid).set({"initialized": true});
    btcSendsRef.doc(Auth().currentUser!.uid).collection('lnbc').add(data);
  }

  void sendPaymentDataOnchain(Map<String, dynamic> data) {
    btcSendsRef.doc(Auth().currentUser!.uid).set({"initialized": true});
    btcSendsRef.doc(Auth().currentUser!.uid).collection('onchain').add(data);
    resendUsers.add(ReSendUser(
        address: data['address'],
        profileUrl: 'https://walletofsatoshi.com/assets/images/icon.png',
        userName: data['address'],
        type: 'onchain'));
    resendUsers.value = resendUsers.toSet().toList();
  }

  String? convertRawTxToTxId(String rawFinalTx) {
    LoggerService logger = Get.find(); // Retrieve the LoggerService instance

    try {
      logger.i("Starting conversion of rawFinalTx to txId.");
      logger.i("Raw Final Transaction Hex: $rawFinalTx");

      // Step 1: Validate the Hex String
      bool isValidHex = RegExp(r'^[0-9a-fA-F]+$').hasMatch(rawFinalTx);
      if (!isValidHex) {
        logger.e("Invalid hex string detected in rawFinalTx.");
        throw FormatException(
            "rawFinalTx contains non-hexadecimal characters.");
      }
      logger.i("Hex string validation passed.");

      // Step 2: Decode Hex to Bytes
      Uint8List rawTxBytes;
      try {
        rawTxBytes = Uint8List.fromList(hex.decode(rawFinalTx));
        logger.i(
            "Decoded rawFinalTx to bytes successfully. Byte Length: ${rawTxBytes.length}");
      } catch (e, stacktrace) {
        logger.e(
          "Error decoding rawFinalTx from hex: $e",
        );
        throw FormatException("Failed to decode rawFinalTx from hex.");
      }

      // Step 3: Perform First SHA256 Hash
      Digest hash1;
      try {
        hash1 = sha256.convert(rawTxBytes);
        logger.i("First SHA256 hash computed successfully.");
        logger.d("Hash1 Bytes: ${hex.encode(hash1.bytes)}");
      } catch (e, stacktrace) {
        logger.e(
          "Error computing first SHA256 hash: $e",
        );
        throw Exception("Failed to compute first SHA256 hash.");
      }

      // Step 4: Perform Second SHA256 Hash
      Digest hash2;
      try {
        hash2 = sha256.convert(hash1.bytes);
        logger.i("Second SHA256 hash computed successfully.");
        logger.d("Hash2 Bytes: ${hex.encode(hash2.bytes)}");
      } catch (e, stacktrace) {
        logger.e(
          "Error computing second SHA256 hash: $e",
        );
        throw Exception("Failed to compute second SHA256 hash.");
      }

      // Step 5: Reverse the Hash Bytes
      Uint8List reversedHash;
      try {
        reversedHash = Uint8List.fromList(hash2.bytes.reversed.toList());
        logger.i("Reversed hash bytes successfully.");
        logger.d("Reversed Hash Bytes: ${hex.encode(reversedHash)}");
      } catch (e) {
        logger.e(
          "Error reversing hash bytes: $e",
        );
        throw Exception("Failed to reverse hash bytes.");
      }

      // Step 6: Encode Reversed Hash to Hex String (txId)
      String txId;
      try {
        txId = hex.encode(reversedHash);
        logger.i("Encoded reversed hash to hex string (txId) successfully.");
        logger.i("Computed txId: $txId");
      } catch (e, stacktrace) {
        logger.e("Error encoding reversed hash to hex string: $e");
        throw Exception("Failed to encode reversed hash to hex string.");
      }

      logger.i("Conversion of rawFinalTx to txId completed successfully.");
      return txId;
    } catch (e) {
      logger.e("Failed to convert rawFinalTx to txId: $e");
    }
    return null;
  }
}

enum SendType {
  Lightning,
  LightningUrl,
  OnChain,
  Invoice,
  Unknown,
}

class BitcoinApiService implements ApiService {
  BitcoinApiService([http.Client? client]) : _client = client ?? http.Client();
  final http.Client _client;
  @override
  Future<T> get<T>(String url) async {
    final response = await _client.get(Uri.parse(url));
    return _readResponse<T>(response);
  }

  @override
  Future<T> post<T>(String url,
      {Map<String, String> headers = const {"Content-Type": "application/json"},
      Object? body}) async {
    final response =
        await _client.post(Uri.parse(url), headers: headers, body: body);
    return _readResponse<T>(response);
  }

  T _readResponse<T>(http.Response response) {
    final String toString = _readBody(response);
    switch (T) {
      case String:
        return toString as T;
      case List:
      case Map:
        return jsonDecode(toString) as T;
      default:
        try {
          return jsonDecode(toString) as T;
        } catch (e) {
          throw Exception("invalid request");
        }
    }
  }

  String _readBody(http.Response response) {
    _readErr(response);
    return StringUtils.decode(response.bodyBytes);
  }

  void _readErr(http.Response response) {
    if (response.statusCode == 200 || response.statusCode == 201) return;
    String toString = StringUtils.decode(response.bodyBytes);
    Map<String, dynamic>? errorResult;
    try {
      if (toString.isNotEmpty) {
        errorResult = StringUtils.toJson(toString);
      }
      // ignore: empty_catches
    } catch (e) {}
    toString = toString.isEmpty ? "request_error" : toString;
    throw Exception(toString);
  }
}

/// Determines the Bitcoin address type and returns the appropriate address object.
BitcoinBaseAddress parseBitcoinAddress(String address) {
  final mainnetPrefix = 'bc';
  final testnetPrefix = 'tb';

  if (address.startsWith('1')) {
    // P2PKH (Pay-to-PubKey-Hash)
    return P2pkhAddress.fromAddress(
        address: address, network: BitcoinNetwork.mainnet);
  } else if (address.startsWith('3')) {
    // P2SH (Pay-to-Script-Hash)
    return P2shAddress.fromAddress(
        address: address, network: BitcoinNetwork.mainnet);
  } else if (address.startsWith('${mainnetPrefix}1q') ||
      address.startsWith('${testnetPrefix}1q')) {
    // P2WPKH (Pay-to-Witness-PubKey-Hash)
    return P2wpkhAddress.fromAddress(
        address: address, network: BitcoinNetwork.mainnet);
  } else if (address.startsWith('${mainnetPrefix}1p') ||
      address.startsWith('${testnetPrefix}1p')) {
    // P2TR (Pay-to-Taproot)
    return P2trAddress.fromAddress(
        address: address, network: BitcoinNetwork.mainnet);
  } else if (address.startsWith('${mainnetPrefix}1') ||
      address.startsWith('${testnetPrefix}1')) {
    // P2WSH (Pay-to-Witness-Script-Hash)
    return P2wshAddress.fromAddress(
        address: address, network: BitcoinNetwork.mainnet);
  } else {
    throw ArgumentError('Unsupported or invalid Bitcoin address: $address');
  }
}
