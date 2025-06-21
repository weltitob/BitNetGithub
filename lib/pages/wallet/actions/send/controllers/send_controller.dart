import 'dart:async';
import 'dart:convert';

import 'package:bitcoin_base/bitcoin_base.dart';
import 'package:bitnet/backbone/auth/auth.dart';
import 'package:bitnet/backbone/auth/storePrivateData.dart';
import 'package:bitnet/backbone/cloudfunctions/lnd/lightningservice/list_invoices.dart';
import 'package:bitnet/backbone/cloudfunctions/lnd/walletkitservice/estimatefee.dart' as old_fee;
import 'package:bitnet/backbone/cloudfunctions/lnd/walletkitservice/send_coins.dart';
import 'package:bitnet/backbone/cloudfunctions/lnd/walletkitservice/list_btc_addresses.dart';
import 'package:bitnet/backbone/cloudfunctions/lnd/walletkitservice/listunspent.dart';
import 'package:bitnet/backbone/cloudfunctions/lnd/walletkitservice/nextaddr.dart';
import 'package:bitnet/backbone/helper/currency/currency_converter.dart';
import 'package:bitnet/backbone/helper/databaserefs.dart';
import 'package:bitnet/backbone/helper/helpers.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/security/biometrics/biometric_check.dart';
import 'package:bitnet/backbone/services/base_controller/base_controller.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:bitnet/backbone/streams/lnd/sendpayment_v2.dart';
import 'package:bitnet/backbone/services/lnurl_channel_service.dart';
import 'package:bitnet/components/dialogsandsheets/channel_opening_sheet.dart';
import 'package:bitnet/components/dialogsandsheets/notificationoverlays/overlay.dart';
import 'package:bitnet/models/bitcoin/lnd/payment_model.dart';
import 'package:bitnet/models/bitcoin/lnd/received_invoice_model.dart';
import 'package:bitnet/models/bitcoin/walletkit/input.dart';
import 'package:bitnet/models/bitcoin/walletkit/output.dart';
import 'package:bitnet/models/bitcoin/walletkit/rawtransactiondata.dart';
import 'package:bitnet/models/bitcoin/walletkit/transactiondata.dart';
import 'package:bitnet/models/bitcoin/walletkit/utxorequest.dart';
import 'package:bitnet/models/currency/bitcoinunitmodel.dart';
import 'package:bitnet/models/firebase/restresponse.dart';
import 'package:bitnet/models/keys/privatedata.dart';
import 'package:bitnet/models/user/userdata.dart';
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

enum SendType {
  Lightning,
  LightningUrl,
  OnChain,
  Invoice,
  Bip21,
  LightningChannel,
  Unknown,
}

class SendsController extends BaseController {
  late BuildContext context;
  final bool getClipOnInit;
  SendsController({required this.context, this.getClipOnInit = true});

  late FocusNode myFocusNodeAdressSearch;
  late TextEditingController bitcoinReceiverAdressController;
  late ScrollController sendScrollerController;
  Rx<String> usersQuery = ''.obs;
  List<ReSendUser> queriedUsers = List.empty(growable: true);

  // ADD:
  RxList<UserData> foundUsers = <UserData>[].obs;
  
  // Store all subscriptions for proper disposal
  final List<StreamSubscription> _subscriptions = [];

  void handleSearch(String value) {
    logger.i("handleSearch called with value: $value");
    onQRCodeScanned(value, context);
  }

  // ADD this method:
  Future<void> handleSearchPeople(String query) async {
    foundUsers.clear();
    if (query.isEmpty) {
      update();
      return;
    }
    try {
      QuerySnapshot users = await usersCollection.get();
      for (var doc in users.docs) {
        UserData user = UserData.fromDocument(doc);
        if (user.username.toLowerCase().contains(query.toLowerCase()) ||
            user.displayName.toLowerCase().contains(query.toLowerCase())) {
          foundUsers.add(user);
        }
      }
      update();
    } catch (e) {
      print("Error searching for user: $e");
    }
  }

  clearFoundUsers() {
    foundUsers.clear();
  }

  Future<void> getClipboardData() async {
    List<ReceivedInvoice> restLightningInvoices =
        await listInvoices(Auth().currentUser!.uid, pending_only: true);
    ReceivedInvoicesList lightningInvoices = ReceivedInvoicesList.fromJson({
      'invoices': restLightningInvoices.map((inv) => inv.toJson()).toList()
    });
    LoggerService logger = Get.find();
    ClipboardData? data = await Clipboard.getData('text/plain');
    bool isBip21 = isBip21WithBolt11(data?.text ?? '');
    if (isBip21) {
      Uri uri = Uri.parse(data!.text!);
      String lightning = uri.queryParameters['lightning'] ?? '';
      List<ReceivedInvoice> memoVoices = lightningInvoices.invoices
          .where((inv) => inv.memo.isNotEmpty)
          .toList();
      bool shouldSearchInvoice = lightningInvoices.invoices
              .where((invoice) => invoice.paymentRequest == (lightning))
              .length ==
          0;
      String btc = uri.path;
      List<String> btcAddresses =
          Get.find<WalletsController>().btcAddresses.toList();
      bool shouldSearchOnchain =
          !Get.find<WalletsController>().btcAddresses.contains(btc);
      if (shouldSearchOnchain && shouldSearchInvoice) {
        handleSearch(data.text ?? '');
      }
    } else {
      List<ReceivedInvoice> memoVoices = lightningInvoices.invoices
          .where((inv) => inv.memo.isNotEmpty)
          .toList();
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
  RxString bip21Mode = "lightning".obs;
  String originalBip21Uri = ""; // Store the original BIP21 URI

  double? feesDouble;
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
  final GlobalKey<FormState> bip21InvoiceFormKey =
      GlobalKey<FormState>(); // a key for the form widget

  String bitcoinReceiverAdress = ""; // the Bitcoin receiver address
  String bip21InvoiceAddress = "";
  String? bip21BitcoinAddress; // Bitcoin address from BIP21 URI
  TextEditingController bip21InvoiceSatController = TextEditingController();
  TextEditingController bip21InvoiceBtcController = TextEditingController();
  TextEditingController bip21InvoiceCurrencyController =
      TextEditingController();
  TextEditingController bip21OnchainSatController = TextEditingController();
  TextEditingController bip21OnchainBtcController = TextEditingController();
  TextEditingController bip21OnchainCurrencyController = TextEditingController();

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

    final isBip21Bolt11 = isBip21WithBolt11(encodedString);

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
    
    // Check for LNURL Channel request
    final isLnurlChannel = _isLnurlChannelRequest(encodedString);
    
    late QRTyped qrTyped;

    logger.i("Determining the QR type...");
    // Logic to determine the QR type based on the encoded string
    // Return the appropriate QRTyped enum value
    if (isBip21Bolt11) {
      qrTyped = QRTyped.BIP21WithBolt11;
    } else if (isLightningMailValid) {
      qrTyped = QRTyped.LightningMail;
    } else if (isLnurlChannel) {
      qrTyped = QRTyped.LightningChannel;
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

  bool _isLnurlChannelRequest(String encodedString) {
    try {
      // Check if it's an LNURL format (starts with lnurl)
      if (!encodedString.toLowerCase().startsWith('lnurl')) {
        return false;
      }
      
      // Use the service to check if it's a channel request
      final channelService = LnurlChannelService();
      return channelService.isChannelRequest(encodedString);
    } catch (e) {
      return false;
    }
  }

  Future<void> onQRCodeScanned(dynamic encodedString, BuildContext cxt) async {
    // Logic to determine the type of QR code
    QRTyped type = determineQRType(encodedString);
    logger.i("TYPE DETECTED! $type");

    switch (type) {
      case QRTyped.BIP21WithBolt11:
        logger.i("Bip21 was detected");
        giveValuesToBip21(encodedString);
        break;
      case QRTyped.LightningUrl:
        logger.i("LightningUrl was detected");
        giveValuesToLnUrl(encodedString);
        break;
      case QRTyped.LightningMail:
        logger.i("LightningMail was detected");
        // Handle LightningMail QR code
        giveValuesToLnUrl(encodedString, asAddress: true);
        break;
      case QRTyped.LightningChannel:
        logger.i("LightningChannel was detected - treating as LNURL payment");
        giveValuesToLnUrl(encodedString);
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
    satController.text = "0";
    bip21InvoiceSatController.text = "0";
    bip21InvoiceBtcController.text = "0.0";
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

  @override
  void onClose() {
    // Reset all states when controller is disposed
    resetValues();
    
    // Cancel any active subscriptions
    for (final subscription in _subscriptions) {
      subscription.cancel();
    }
    _subscriptions.clear();
    
    // Dispose controllers and focus nodes
    sendScrollerController.dispose();
    myFocusNodeAdressSearch.dispose();
    myFocusNodeAdress.dispose();
    myFocusNodeMoney.dispose();
    bitcoinReceiverAdressController.dispose();
    
    super.onClose();
  }

  void resetValues() {
    hasReceiver.value = false;
    bitcoinReceiverAdress = "";
    btcController.text = "0.0";
    satController.text = "0";
    bip21InvoiceSatController.text = "0";
    bip21InvoiceBtcController.text = "0.0";

    moneyTextFieldIsEnabled.value = true;
    description.value = "";
    
    // Reset send button state
    isFinished.value = false;
    loadingSending.value = false;
    
    //context.go("/wallet/send");
  }

  void giveValuesToOnchainSend(String onchainAdress, {bool keepBip21Address = false}) async {
    // Don't call resetValues() if we're just switching modes while preserving the BIP21 state
    if (!keepBip21Address) {
      resetValues();
    }
    
    Uri? uri = Uri.tryParse(onchainAdress);
    if (uri == null) {
      throw Exception(
          "Reached onchain uri parsing, but uri failed to be parsed, please check this. ${StackTrace.current}");
    }
    String finalAddress = uri.path; // Extracts the Bitcoin address
    String? amountStr = uri.queryParameters["amount"];
    String? label = uri.queryParameters["label"];
    String? message = uri.queryParameters["message"];

    if (amountStr != null) {
      btcController.text = amountStr;

      satController.text =
          CurrencyConverter.convertBitcoinToSats(double.parse(amountStr))
              .toStringAsFixed(0);
    } else {
      btcController.text = '0.0';
      satController.text = '0';
    }

    {
      // If keepBip21Address is true, retain SendType.Bip21, otherwise set to SendType.OnChain
      if (keepBip21Address) {
        // Keep SendType.Bip21 but switch to onchain mode
        logger.i("Preserving BIP21 state while switching to onchain mode");
        bip21Mode.value = "onchain";
        // Ensure we retain the BIP21 type
        sendType = SendType.Bip21;
      } else {
        sendType = SendType.OnChain;
      }
      hasReceiver.value = true;
      bitcoinReceiverAdress = finalAddress;
      description.value = message ?? label ?? '';
      moneyTextFieldIsEnabled.value = true;
    }

    // Note: This fee estimation is for UI display only
    // The actual fee will be calculated when sending
    // Using a dummy address for fee estimation
    final dummyAddress = "bc1qxy2kgdygjrsqtzq2n0yrf2493p83kkfjhx0wlh";
    final dummyAmount = 10000; // 10k sats for estimation
    
    dynamic fundedPsbtResponse = await estimateFee(
      userId: Auth().currentUser!.uid,
      address: dummyAddress,
      amountSat: dummyAmount,
      targetConf: AppTheme.targetConf,
    );
    
    if (fundedPsbtResponse.statusCode == "success") {
      final feeRate = fundedPsbtResponse.data["feerate_sat_per_vbyte"] ?? 1;
      feesDouble = feeRate.toDouble();
    } else {
      feesDouble = 1.0; // Default fee rate
    }
    bitcoinUnit = BitcoinUnits.SAT;

    logger.i("Estimated fees: $feesDouble");
  }

  void giveValuesToLnUrl(String lnUrl, {bool asAddress = false}) async {
    logger.i("LNURL detected: $lnUrl, asAddress: $asAddress");
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
      logger.i("LNURL response: ${httpResult.body}");
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
      String url, int amount, BuildContext context, {bool canNavigate = true}) async {
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
    // bool transactionsUpdated = false;

    sub = paymentStream.listen((dynamic response) {
      isFinished.value = true;
      if ((response as Map<String, dynamic>)['status'] == 'SUCCEEDED') {
        //sendPaymentDataLnUrl(response, lnUrl, lnUrlname);
        // Convert response to a valid JSON string
        String jsonString = jsonEncode(response);
        // Decode the JSON string back into a Map<String, dynamic>
        var typedResponse = jsonDecode(jsonString) as Map<String, dynamic>;
        LightningPayment payment = LightningPayment.fromJson(typedResponse);
        sub!.cancel();
        logger.i("Payment successful! Forwarding to feed...");
        if (canNavigate) {
          context.go("/");
        }
      } else if ((response)['status'] == 'FAILED') {
        String failureReason = response['failure_reason'] ?? '';
        // Check if invoice is already paid - treat as success
        if (failureReason.toLowerCase().contains('already paid')) {
          logger.i("Invoice already paid - treating as success");
          overlayController.showOverlay("Invoice was already paid!");
          isFinished.value = true;
          if (canNavigate) {
            context.go("/");
          }
        } else {
          overlayController.showOverlay("Payment failed: $failureReason");
          isFinished.value = false;
        }
        sub!.cancel();
      } else {
        overlayController
            .showOverlay("Payment failed: please try again later...");
        isFinished.value = false;
        sub!.cancel();
      }
    }, onError: (error) {
      isFinished.value = false;
      overlayController.showOverlay("An error occurred: $error");
    }, onDone: () {
      resetValues();
    }, cancelOnError: true);

    logger.i("Payment successful! ${response.body}");

    return payment;
  }

  void giveValuesToInvoice(String invoiceString, {bool keepBip21Address = false}) {
    LoggerService logger = Get.find();
    logger.i("Invoice that is about to be paid for: $invoiceString");
    
    // If keepBip21Address is true, preserve the BIP21 state
    if (keepBip21Address && sendType == SendType.Bip21) {
      logger.i("Preserving BIP21 state while switching to lightning mode");
      // Just update the invoice address and mode but keep sendType as Bip21
      bip21InvoiceAddress = invoiceString;
      bip21Mode.value = "lightning";
    } else {
      // Normal invoice flow
      sendType = SendType.Invoice;
      hasReceiver.value = true;
      bitcoinReceiverAdress = invoiceString;
    }
    
    Bolt11PaymentRequest req = Bolt11PaymentRequest(invoiceString);
    
    // Log the parsed amount details
    logger.i("🔍 Invoice parsing details:");
    logger.i("Raw amount from invoice: ${req.amount} BTC");
    logger.i("Amount in millisats: ${(req.amount.toDouble() * 100000000000).toString()}");
    
    double satoshi =
        CurrencyConverter.convertBitcoinToSats(req.amount.toDouble());
    int cleanAmount = satoshi.toInt();
    
    logger.i("Amount in sats: $cleanAmount");
    logger.i("Setting amount in controller text field...");
    
    if (sendType == SendType.Bip21) {
      bip21InvoiceSatController.text = cleanAmount.toString();
      logger.i("Set BIP21 invoice amount: ${bip21InvoiceSatController.text}");
    } else {
      satController.text = cleanAmount.toString();
      logger.i("Set regular invoice amount: ${satController.text}");
    }
    
    moneyTextFieldIsEnabled.value = false;
    logger.i("💰 Money text field disabled for invoice amount");
    description.value = req.tags[1].data;
    
    // Reset send button state when new invoice is scanned
    isFinished.value = false;
    loadingSending.value = false;
    logger.i("🔄 Send button reset to allow new payment");
    
    // Force UI update to show the amount
    update();
    
    // Ensure we maintain a consistent state
    logger.i("Setting type: $sendType, Mode: ${bip21Mode.value}");
    logger.i("✅ Invoice parsing complete. hasReceiver: ${hasReceiver.value}");
  }

  Future<void> giveValuesToBip21(String encodedString) async {
    LoggerService logger = Get.find();
    resetValues();

    originalBip21Uri = encodedString;
    Uri? uri = Uri.tryParse(encodedString);
    if (uri == null) {
      throw Exception(
          "Reached onchain uri parsing, but uri failed to be parsed, please check this. ${StackTrace.current}");
    }
    String finalAddress = uri.path; // Extracts the Bitcoin address
    String? amountStr = uri.queryParameters["amount"];
    String? label = uri.queryParameters["label"];
    String? message = uri.queryParameters["message"];
    String? invoice = uri.queryParameters["lightning"];

    if (amountStr != null) {
      btcController.text = amountStr;

      satController.text =
          CurrencyConverter.convertBitcoinToSats(double.parse(amountStr))
              .toStringAsFixed(0);
    } else {
      btcController.text = '0.0';
      satController.text = '0';
    }

    {
      sendType = SendType.Bip21;
    // Set lightning as the default mode for Bip21
    bip21Mode.value = "lightning";
      hasReceiver.value = true;
      bitcoinReceiverAdress = finalAddress;
      description.value = message ?? label ?? '';
      moneyTextFieldIsEnabled.value = true;
    }

    // Note: This fee estimation is for UI display only
    // The actual fee will be calculated when sending
    // Using a dummy address for fee estimation
    final dummyAddress = "bc1qxy2kgdygjrsqtzq2n0yrf2493p83kkfjhx0wlh";
    final dummyAmount = 10000; // 10k sats for estimation
    
    dynamic fundedPsbtResponse = await estimateFee(
      userId: Auth().currentUser!.uid,
      address: dummyAddress,
      amountSat: dummyAmount,
      targetConf: AppTheme.targetConf,
    );
    
    if (fundedPsbtResponse.statusCode == "success") {
      final feeRate = fundedPsbtResponse.data["feerate_sat_per_vbyte"] ?? 1;
      feesDouble = feeRate.toDouble();
    } else {
      feesDouble = 1.0; // Default fee rate
    }
    bitcoinUnit = BitcoinUnits.SAT;

    logger.i("Estimated fees: $feesDouble");

    logger.i("Invoice that is about to be paid for: $encodedString");
    if (invoice != null) {
      bip21InvoiceAddress = invoice;
      Bolt11PaymentRequest req = Bolt11PaymentRequest(invoice);
      double satoshi =
          CurrencyConverter.convertBitcoinToSats(req.amount.toDouble());
      int cleanAmount = satoshi.toInt();
      bip21InvoiceSatController.text = cleanAmount.toString();
      // Set lightning as default
      bip21Mode.value = "lightning";
      // Call giveValuesToInvoice with the invoice
      giveValuesToInvoice(invoice, keepBip21Address: true);
    }
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

  void toggleButtonState() {
    loadingSending.value =
        !loadingSending.value; // Toggle the state between true and false
  }

  // OLD: Multiple users one node approach - Complex Bitcoin transaction building with HDWallet
  // This entire function is commented out because it won't work with the new one-user-one-node approach
  // It requires specialized Bitcoin key derivation (hdWallet.findKeyPair) that needs reimplementation
  /*
  Future<dynamic> sendBip21BTC(BuildContext context, bool onchain) async {
    LoggerService logger = Get.find<LoggerService>();
    final overlayController = Get.find<OverlayController>();
    logger.i("sendBip21BTC() called with onchain=$onchain");

    await isBiometricsAvailable();
    if (isBioAuthenticated == true || hasBiometrics == false) {
      if (onchain) {
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
        // Use new estimateFee with proper parameters
        dynamic feeResponse = await estimateFee(
          userId: Auth().currentUser!.uid,
          address: bitcoinReceiverAdress,
          amountSat: amountInSat.toInt(),
          targetConf: AppTheme.targetConf,
        );
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
                  value:
                      BigInt.from(utxoSum - (amountInSat.toInt() + sat_per_kw)))
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
        const network = BitcoinNetwork.mainnet;

        /// Define http provider and api provider
        final service = BitcoinApiService();
        final api = ApiProvider.fromBlocCypher(network, service);
        String response = await api.sendRawTransaction(tr.serialize());
        print(response);
        isFinished.value = true;
        if ('' == "200") {
          Get.find<WalletsController>().fetchOnchainWalletBalance();
          overlayController.showOverlay(
              "Onchain transaction successfully broadcastet, it can take a while!");
          if (canNavigate) {
            GoRouter.of(this.context).go("/feed");
          }
        } else {
          overlayController.showOverlay("Payment failed.");
          isFinished.value = false;
        }
      } else {
        logger.i("Sending invoice: $bip21InvoiceAddress");

        List<String> invoiceStrings = [
          bip21InvoiceAddress
        ]; // Assuming you want to send a list containing a single invoice for now

        Stream<dynamic> paymentStream = sendPaymentV2Stream(
            Auth().currentUser!.uid,
            invoiceStrings,
            int.parse(bip21InvoiceSatController.text));
        bool firstSuccess = false;
        final sub = paymentStream.listen((dynamic response) {
          isFinished.value =
              true; // Assuming you might want to update UI on each response
          if (response['status'] == "SUCCEEDED") {
            logger.i("Success: ${response}");

            String jsonString = jsonEncode(response);

            // Decode the JSON string back into a Map<String, dynamic>
            var typedResponse = jsonDecode(jsonString) as Map<String, dynamic>;

            LightningPayment payment = LightningPayment.fromJson(typedResponse);
            sendPaymentDataInvoice(response);

            if (!firstSuccess) {
              logger.i(
                  "Payment successful it should update the stream in walletcontroller which shows the overlay!");
              logger.i("Payment successful! Forwarding to wallet...");
              if (canNavigate) {
                context.go("/");
              }
              firstSuccess = true;
            }
          }
          if (response['status'] == "FAILED") {
            // Handle error
            logger.i("Payment failed!");
            if (!firstSuccess) {
              overlayController
                  .showOverlay("Payment failed: ${response.message}");
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
          overlayController.showOverlay("An error occurred: $error");
        }, onDone: () {
          // Handle stream completion if necessary
        }, cancelOnError: true // Cancel the subscription upon first error
            );
        _subscriptions.add(sub);
      }
    }
  }
  */
  
  // NEW: One user one node approach - Bitcoin transaction handling for individual nodes
  Future<dynamic> sendBip21BTC(BuildContext context, bool onchain) async {
    final logger = Get.find<LoggerService>();
    final overlayController = Get.find<OverlayController>();
    
    if (onchain) {
      logger.i("Processing BIP21 onchain payment");
      // Use the onchain address from BIP21
      final address = bitcoinReceiverAdress;
      final amountSat = int.parse(satController.text.isEmpty ? "0" : satController.text);
      
      try {
        // First estimate the fee
        final feeEstimate = await estimateFee(
          userId: Auth().currentUser!.uid,
          address: address,
          amountSat: amountSat,
          targetConf: AppTheme.targetConf,
        );
        
        if (feeEstimate.statusCode != "success") {
          overlayController.showOverlay("Failed to estimate fee: ${feeEstimate.message}");
          isFinished.value = false;
          return false;
        }
        
        final feeSat = feeEstimate.data['fee_sat'] ?? 0;
        logger.i("Estimated fee: $feeSat sats");
        
        // Show confirmation dialog
        bool? confirmed = await Get.dialog<bool>(
          AlertDialog(
            title: Text('Confirm BIP21 Onchain Transaction'),
            content: Text(
              'Send ${amountSat} sats to\n${address.substring(0, 10)}...${address.substring(address.length - 10)}\n\nFee: $feeSat sats\nTotal: ${amountSat + feeSat} sats',
            ),
            actions: [
              TextButton(
                onPressed: () => Get.back(result: false),
                child: Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Get.back(result: true),
                child: Text('Confirm'),
              ),
            ],
          ),
          barrierDismissible: false,
        );
        
        if (confirmed != true) {
          isFinished.value = false;
          return false;
        }
        
        // Send the transaction
        final sendResult = await sendCoins(
          userId: Auth().currentUser!.uid,
          address: address,
          amountSat: amountSat,
          targetConf: AppTheme.targetConf,
        );
        
        if (sendResult.statusCode == "success") {
          final txid = sendResult.data['txid'];
          logger.i("BIP21 onchain transaction sent! TXID: $txid");
          
          Get.find<WalletsController>().fetchOnchainWalletBalance();
          overlayController.showOverlay(
            "BIP21 onchain transaction sent!\nTXID: ${txid.substring(0, 8)}..."
          );
          
          context.go("/");
          return true;
        } else {
          overlayController.showOverlay("Transaction failed: ${sendResult.message}");
          isFinished.value = false;
          return false;
        }
      } catch (e) {
        logger.e("Error sending BIP21 onchain transaction: $e");
        overlayController.showOverlay("Error: $e");
        isFinished.value = false;
        return false;
      }
    } else {
      logger.i("Processing BIP21 Lightning payment");
      // Process Lightning invoice from BIP21
      final invoice = bip21InvoiceAddress;
      if (invoice.isEmpty) {
        overlayController.showOverlay("No Lightning invoice in BIP21");
        isFinished.value = false;
        return false;
      }
      
      List<String> invoiceStrings = [invoice];
      Stream<dynamic> paymentStream = sendPaymentV2Stream(
        Auth().currentUser!.uid,
        invoiceStrings,
        int.parse(bip21InvoiceSatController.text)
      );
      
      bool success = false;
      final completer = Completer<bool>();
      
      final sub = paymentStream.listen((dynamic response) {
        isFinished.value = true;
        if (response['status'] == "SUCCEEDED") {
          logger.i("BIP21 Lightning payment successful!");
          overlayController.showOverlay("BIP21 Lightning payment sent!");
          context.go("/");
          success = true;
          if (!completer.isCompleted) completer.complete(true);
        } else if (response['status'] == "FAILED") {
          String failureReason = response['failure_reason'] ?? 'Unknown error';
          // Check if invoice is already paid - treat as success
          if (failureReason.toLowerCase().contains('already paid')) {
            logger.i("BIP21 Invoice already paid - treating as success");
            overlayController.showOverlay("Invoice was already paid!");
            isFinished.value = true;
            context.go("/");
            success = true;
            if (!completer.isCompleted) completer.complete(true);
          } else {
            overlayController.showOverlay("Payment failed: $failureReason");
            isFinished.value = false;
            if (!completer.isCompleted) completer.complete(false);
          }
        }
      }, onError: (error) {
        isFinished.value = false;
        overlayController.showOverlay("Error: $error");
        if (!completer.isCompleted) completer.complete(false);
      });
      
      _subscriptions.add(sub);
      return await completer.future;
    }
  }

  Future<dynamic> sendBTC(BuildContext context, {bool canNavigate = true, bool shouldPop = false}) async {
    LoggerService logger = Get.find<LoggerService>();
    final overlayController = Get.find<OverlayController>();
    logger.i("sendBTC() called");

    await isBiometricsAvailable();
    if (isBioAuthenticated == true || hasBiometrics == false) {
      try {
        // Check if this is a BIP21 transaction and handle accordingly
        if (sendType == SendType.Bip21) {
          logger.i("Handling Bip21 payment with mode: ${bip21Mode.value}");
          return await sendBip21BTC(context, bip21Mode.value == "onchain");
        } else if (sendType == SendType.LightningUrl) {
          logger.i("Amount that is being sent: ${satController.text}");
          logger.i("Satcontroller text: ${satController.text}");
          logger
              .i("Satcontroller text parsed: ${int.parse(satController.text)}");
          payLnUrl(lnCallback!, int.parse(satController.text), context, canNavigate: canNavigate);
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
          final sub = paymentStream.listen((dynamic response) {
            isFinished.value =
                true; // Assuming you might want to update UI on each response
            if (response['status'] == "SUCCEEDED") {
              logger.i("Success: ${response}");

              String jsonString = jsonEncode(response);

              // Decode the JSON string back into a Map<String, dynamic>
              var typedResponse =
                  jsonDecode(jsonString) as Map<String, dynamic>;

              LightningPayment payment =
                  LightningPayment.fromJson(typedResponse);
              //
              // Get.find<WalletsController>().newTransactionData.add(payment);
              // Handle success
              sendPaymentDataInvoice(response);

              if (!firstSuccess) {
                logger.i(
                    "Payment successful it should update the stream in walletcontroller which shows the overlay!");
                // Get.find<WalletsController>().fetchLightingWalletBalance();
                // overlayController.showOverlay("Payment successful!");

                logger.i("Payment successful! Forwarding to wallet...");
                if (canNavigate) {
                  context.go("/");
                }

                firstSuccess = true;
              }
            }
            if (response['status'] == "FAILED") {
              // Handle error
              logger.i("Payment failed!");
              String failureReason = response['failure_reason'] ?? 'Unknown error';
              
              // Check if invoice is already paid - treat as success
              if (failureReason.toLowerCase().contains('already paid')) {
                logger.i("Invoice already paid - treating as success");
                if (!firstSuccess) {
                  overlayController.showOverlay("Invoice was already paid!");
                  firstSuccess = true;
                }
                isFinished.value = true;
                if (canNavigate) {
                  context.go("/");
                }
              } else {
                if (!firstSuccess) {
                  overlayController.showOverlay("Payment failed: $failureReason");
                  firstSuccess = true;
                }
                isFinished.value = false; // Keep the user on the same page to possibly retry or show error
              }
            } else {
              logger.i("Parsing of response failed! PLEASE FIX");
              isFinished.value =
                  false; // Keep the user on the same page to possibly retry or show error
            }
          }, onError: (error) {
            isFinished.value = false;
            overlayController.showOverlay("An error occurred: $error");
          }, onDone: () {
            // Handle stream completion if necessary
          }, cancelOnError: true // Cancel the subscription upon first error
              );
          _subscriptions.add(sub);
        } else if (sendType == SendType.OnChain) {
          // NEW: One user one node approach - Direct onchain sending via LND
          logger.i("Sending Onchain Payment to: $bitcoinReceiverAdress");
          final amountInSat = int.parse(satController.text);
          
          try {
            // First estimate the fee
            final feeEstimate = await estimateFee(
              userId: Auth().currentUser!.uid,
              address: bitcoinReceiverAdress,
              amountSat: amountInSat,
              targetConf: AppTheme.targetConf,
            );
            
            if (feeEstimate.statusCode != "success") {
              overlayController.showOverlay("Failed to estimate fee: ${feeEstimate.message}");
              isFinished.value = false;
              return;
            }
            
            final feeSat = feeEstimate.data['fee_sat'] ?? 0;
            logger.i("Estimated fee: $feeSat sats");
            
            // Show confirmation dialog
            bool? confirmed = await Get.dialog<bool>(
              AlertDialog(
                title: Text('Confirm Transaction'),
                content: Text(
                  'Send ${amountInSat} sats to\n${bitcoinReceiverAdress.substring(0, 10)}...${bitcoinReceiverAdress.substring(bitcoinReceiverAdress.length - 10)}\n\nFee: $feeSat sats\nTotal: ${amountInSat + feeSat} sats',
                ),
                actions: [
                  TextButton(
                    onPressed: () => Get.back(result: false),
                    child: Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () => Get.back(result: true),
                    child: Text('Confirm'),
                  ),
                ],
              ),
              barrierDismissible: false,
            );
            
            if (confirmed != true) {
              isFinished.value = false;
              return;
            }
            
            // Send the transaction
            final sendResult = await sendCoins(
              userId: Auth().currentUser!.uid,
              address: bitcoinReceiverAdress,
              amountSat: amountInSat,
              targetConf: AppTheme.targetConf,
            );
            
            if (sendResult.statusCode == "success") {
              final txid = sendResult.data['txid'];
              logger.i("Transaction sent successfully! TXID: $txid");
              
              Get.find<WalletsController>().fetchOnchainWalletBalance();
              overlayController.showOverlay(
                "Onchain transaction sent!\nTXID: ${txid.substring(0, 8)}..."
              );
              
              if (canNavigate) {
                context.go("/");
              }
            } else {
              overlayController.showOverlay("Transaction failed: ${sendResult.message}");
              isFinished.value = false;
            }
          } catch (e) {
            logger.e("Error sending onchain transaction: $e");
            overlayController.showOverlay("Error: $e");
            isFinished.value = false;
          }
          

          
          // NEW: One user one node approach - Bitcoin transaction handling for individual nodes
          logger.i("OLD sendBTC OnChain function called - needs new one user one node implementation since old version will not work anymore");
          // TODO: Implement new Bitcoin transaction handling for individual user nodes via Caddy
          // This will require new Bitcoin key derivation compatible with BIP39 and individual node architecture
          overlayController.showOverlay("OnChain transactions need reimplementation for individual nodes");
          isFinished.value = false;
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
    // Cancel all stream subscriptions
    for (final sub in _subscriptions) {
      sub.cancel();
    }
    _subscriptions.clear();
    
    myFocusNodeAdress.dispose();
    myFocusNodeMoney.dispose();
    btcController.dispose();
    satController.dispose();
    currencyController.dispose();
    bip21InvoiceSatController.dispose();
    bip21InvoiceBtcController.dispose();
    bip21InvoiceCurrencyController.dispose();
    foundUsers.clear();
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

  // LNURL Channel handling methods
  Future<void> _handleChannelRequest(String lnurlString, BuildContext cxt) async {
    logger.i("Handling LNURL Channel request in send controller: $lnurlString");
    
    try {
      // Show channel opening bottom sheet
      await _showChannelOpeningSheet(cxt, lnurlString);
    } catch (e) {
      logger.e("Error handling channel request: $e");
      final overlayController = Get.find<OverlayController>();
      overlayController.showOverlay("Error processing channel request: $e");
    }
  }

  Future<void> _showChannelOpeningSheet(BuildContext context, String lnurlString) async {
    await context.showChannelOpeningSheet(
      lnurlString,
      onChannelOpened: () {
        final overlayController = Get.find<OverlayController>();
        overlayController.showOverlay("Lightning channel opened successfully!");
        
        // Reset the send form
        resetValues();
      },
    );
  }
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