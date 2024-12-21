import 'dart:async';
import 'package:bitnet/backbone/cloudfunctions/lnd/lightningservice/channel_balance.dart';
import 'package:bitnet/backbone/cloudfunctions/lnd/lightningservice/get_transactions.dart';
import 'package:bitnet/backbone/cloudfunctions/lnd/lightningservice/list_invoices.dart';
import 'package:bitnet/backbone/cloudfunctions/lnd/lightningservice/list_payments.dart';
import 'package:bitnet/backbone/cloudfunctions/lnd/lightningservice/wallet_balance.dart';
import 'package:bitnet/backbone/cloudfunctions/lnd/stateservice/litd_subserverstatus.dart';
import 'package:bitnet/backbone/helper/currency/currency_converter.dart';
import 'package:bitnet/backbone/helper/databaserefs.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/services/base_controller/base_controller.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:bitnet/backbone/services/local_storage.dart';
import 'package:bitnet/components/dialogsandsheets/notificationoverlays/overlay.dart';
import 'package:bitnet/components/items/crypto_item_controller.dart';
import 'package:bitnet/models/bitcoin/chartline.dart';
import 'package:bitnet/models/bitcoin/lnd/lightning_balance_model.dart';
import 'package:bitnet/models/bitcoin/lnd/onchain_balance_model.dart';
import 'package:bitnet/models/bitcoin/lnd/payment_model.dart';
import 'package:bitnet/models/bitcoin/lnd/received_invoice_model.dart';
import 'package:bitnet/models/bitcoin/lnd/subserverinfo.dart';
import 'package:bitnet/models/bitcoin/lnd/transaction_model.dart';
import 'package:bitnet/models/bitcoin/transactiondata.dart';
import 'package:bitnet/models/currency/bitcoinunitmodel.dart';
import 'package:bitnet/models/firebase/restresponse.dart';
import 'package:bitnet/pages/secondpages/mempool/controller/bitcoin_screen_controller.dart';
import 'package:bitnet/pages/wallet/component/wallet_filter_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../backbone/auth/auth.dart';

class WalletsController extends BaseController {
  RxBool hideBalance = false.obs;
  RxBool showInfo = false.obs;

  late final ScrollController scrollController;
  RxInt currentView = 0.obs;
  Rx<OnchainBalance> onchainBalance = OnchainBalance(
    totalBalance: '0',
    confirmedBalance: '0',
    unconfirmedBalance: '0',
    lockedBalance: '0',
    reservedBalanceAnchorChan: '',
    accountBalance: '',
  ).obs;

  Rx<LightningBalance> lightningBalance = LightningBalance(
    balance: '0',
    pendingOpenBalance: '0',
    localBalance: '0',
    remoteBalance: '0',
    unsettledLocalBalance: '0',
    pendingOpenLocalBalance: '',
    unsettledRemoteBalance: '',
    pendingOpenRemoteBalance: '',
  ).obs;

  RxString predictedLightningBalance = '0'.obs;
  RxString predictedBtcBalance = '0'.obs;

  RxBool visible = false.obs;

  StreamSubscription<List<ReceivedInvoice>>? invoicesSubscription;
  StreamSubscription<List<BitcoinTransaction>>? transactionsSubscription;

  Rx<ChartLine?> chartLines = Rx<ChartLine?>(null);
  RxString totalBalanceStr = "0".obs;
  RxDouble totalBalanceSAT = 0.0.obs;
  Rx<BitcoinUnitModel> totalBalance =
      BitcoinUnitModel(bitcoinUnit: BitcoinUnits.SAT, amount: 0).obs;
  String loadMessageError = "";
  int errorCount = 0;
  int loadedFutures = 0;
  bool queueErrorOvelay = false;

  //for amount widget
  RxBool reversed = false.obs;
  //for onchain/lightning card, false is onchain
  RxString selectedCard = 'onchain'.obs;
  final String reversedConstant = 'amount_widget_reversed';
  final String cardTopConstant = 'lightning_on_top';

  //transactions
  RxMap<String, dynamic> onchainTransactions = <String, dynamic>{}.obs;
  RxMap<String, dynamic> lightningInvoices = <String, dynamic>{}.obs;
  RxMap<String, dynamic> lightningPayments = <String, dynamic>{}.obs;
  RxMap<String, dynamic> loopOperations = <String, dynamic>{}.obs;
  RxList<TransactionItemData> allTransactions = RxList.empty(growable: true);
  List<dynamic> newTransactionData = List.empty(growable: true);

  List<String> btcAddresses = List<String>.empty(growable: true);

  RxInt futuresCompleted = 0.obs;

  //reactive values to handle transaction and invoice streams
  Rx<BitcoinTransaction?> latestTransaction = Rx<BitcoinTransaction?>(null);
  Rx<ReceivedInvoice?> latestInvoice = Rx<ReceivedInvoice?>(null);
  Rx<LightningPayment?> latestPayment = Rx<LightningPayment?>(null);

  // A reactive variable to hold the fetched sub-server status
  Rxn<SubServersStatus> subServersStatus = Rxn<SubServersStatus>();


  RxBool coin = false.obs;

  // Getters for currencies

  RxString? selectedCurrency;


  @override
  void onInit() {

    final logger = Get.find<LoggerService>();
    logger.i("Calling onInit in wallet_controller");

    super.onInit();
    Get.put(CryptoItemController());
    Get.put(WalletFilterController());
    Get.put(BitcoinScreenController());


    // Get.put(PurchaseSheetController());
    // Get.put(() => SellSheetController());
    scrollController = ScrollController();
    reversed.value = LocalStorage.instance.getBool(reversedConstant);

    selectedCard.value =
        LocalStorage.instance.getString(cardTopConstant) ?? 'onchain';
    settingsCollection.doc(FirebaseAuth.instance.currentUser!.uid).get().then(
            (value) {
          coin.value = value.data()?["showCoin"] ?? false;
          selectedCurrency = RxString("");
          selectedCurrency!.value = value.data()?["selectedCurrency"] ?? "USD";

        }, onError: (a, b) {
      coin.value = false;
      selectedCurrency = RxString("");
      selectedCurrency!.value = "USD";
    });

    //----------------------BALANCES----------------------

    logger.i("Fetching balances initally in wallet_controller");

    fetchOnchainWalletBalance().then((value) {
      loadedFutures++;
      if (!value) {
        errorCount++;
        loadMessageError = "Failed to load Onchain Balance";
      }
      if (loadedFutures == 2) {
        queueErrorOvelay = true;
      }
    });

    fetchLightingWalletBalance().then((value) {
      loadedFutures++;
      if (!value) {
        errorCount++;
        loadMessageError = "Failed to load Lightning Balance";
      }
      if (loadedFutures == 2) {
        queueErrorOvelay = true;
      }
    });

    //---------------------------------------------------


    //----------------------ACTIVITY----------------------

    logger.i("Fetching activity initally in wallet_controller");

    getTransactions(Auth().currentUser!.uid).then((val) {
      logger.i("Fetching transactions in wallet_controller");
      onchainTransactions.value = {
        'transactions': val.map((tx) => tx.toJson()).toList()
      };
      logger.i("Transactions: $onchainTransactions");
      futuresCompleted++;
    });

    listPayments(Auth().currentUser!.uid).then((val) {
      logger.i("Fetching payments in wallet_controller");
      List<Map<String, dynamic>> paymentsMapped =
      val.map((payment) => payment.toJson()).toList();
      lightningPayments.value = {
        'payments': paymentsMapped,
        'first_index_offset': -1,
        'last_index_offset': -1,
        'total_num_payments': paymentsMapped.length
      };
      logger.i("Payments: $paymentsMapped");
      futuresCompleted++;
    });

    listInvoices(Auth().currentUser!.uid).then((val) {
      logger.i("Fetching invoices in wallet_controller");
      List<Map<String, dynamic>> mapList =
      val.map((inv) => inv.toJson()).toList();
      lightningInvoices.value = {'invoices': mapList};
      logger.i("Invoices: $mapList");
      futuresCompleted++;
    });


    // listSwaps().then((val) {
    //   logger.i("Fetching swaps in wallet_controller");
    //   loopOperations.addAll(val.data);
    //   futuresCompleted++;
    // });

    //---------------------------------------------------


    //----------------------SUBSCRIPTIONS----------------------
    logger.i("Subscribing to streams in wallet_controller");

    backendRef
        .doc(Auth().currentUser!.uid)
        .collection('invoices')
        .snapshots()
        .listen((query) {
      ReceivedInvoice? model;
      try {
        logger.i("Received invoice from stream");
        model = ReceivedInvoice.fromJson(query.docs.last.data());
      } catch (e) {
        model = null;
        logger.e('failed to convert invoice json to invoice model');
      }
      latestInvoice.value = model;
    });

    backendRef
        .doc(Auth().currentUser!.uid)
        .collection('payments')
        .snapshots()
        .listen((query) {
      LightningPayment? model;
      try {
        logger.i("Received payment from stream");
        model = LightningPayment.fromJson(query.docs.last.data());
      } catch (e) {
        model = null;
        logger.e('failed to convert payment json to payment model');
      }
      latestPayment.value = model;
    });

    backendRef
        .doc(Auth().currentUser!.uid)
        .collection('transactions')
        .snapshots()
        .listen((query) {
      BitcoinTransaction? model;
      try {
        logger.i("Received transaction from stream");
        model = BitcoinTransaction.fromJson(query.docs.last.data());
      } catch (e) {
        model = null;
        logger.e('failed to convert transaction json to transaction model');
      }
      latestTransaction.value = model;
    });

    //---------------------------------------------------
    subscribeToOnchainBalance();
    subscribeToInvoices();
    subscribeToLightningPayments();
    subscribeToOnchainTransactions();
    //------------------------

  }

  //------------------------------------------------------------------------------------------
  //----------------------NEW SECTION FOR UPDATED WALLET SYSTEM-------------------------------
  //------------------------------------------------------------------------------------------

  Future<OnchainBalance> getOnchainBalance() async {
    try {

      RestResponse onchainBalanceRest =
      await walletBalance(acc: Auth().currentUser!.uid);

      if (!onchainBalanceRest.data.isEmpty) {
        OnchainBalance onchainBalance =
        OnchainBalance.fromJson(onchainBalanceRest.data);

        this.onchainBalance.value = onchainBalance;
      }
      changeTotalBalanceStr();
    } catch (e) {
      print(e);
    }

    return this.onchainBalance.value;
  }

  Future<num> getOnchainAddressBalance(String addr) async {
    String url = '${AppTheme.baseUrlMemPoolSpaceApi}address/$addr/utxo';
    try {
      final response = await dioClient.get(url: url);
      if (response.statusCode == 200) {
        List utxos = response.data;
        num addressBalance =
        utxos.fold<num>(0, (sum, utxo) => sum + utxo['value']);
        return addressBalance;
      }
      return 0;
    } catch (e) {
      print('Error fetching UTXOs for $addr: $e');
      return 0;
    }
  }

  // ----------------------
  // GET ADDRESSES COUNT
  // ----------------------
  Future<int?> getAddressesCount() async {
    DocumentSnapshot<Map<String, dynamic>> doc =
    await btcAddressesRef.doc(Auth().currentUser!.uid).get();
    if (doc.data() != null && doc.data()!.isNotEmpty) {
      return doc.data()!['count'];
    } else {
      return null;
    }
  }

  // ----------------------
  // GET ON-CHAIN ADDRESSES
  // ----------------------
  Future<List<String>> getOnchainAddresses() async {
    DocumentSnapshot<Map<String, dynamic>> doc =
    await btcAddressesRef.doc(Auth().currentUser!.uid).get();
    String uid = Auth().currentUser!.uid;
    Map<String, dynamic>? data = doc.data();
    if (doc.data() != null && doc.data()!.isNotEmpty) {
      return (doc.data()!['addresses'] as List).cast<String>();
    } else {
      return <String>[];
    }
  }

  Future<List<String>> getChangeAddresses() async {
    DocumentSnapshot<Map<String, dynamic>> doc =
    await btcAddressesRef.doc(Auth().currentUser!.uid).get();
    String uid = Auth().currentUser!.uid;
    Map<String, dynamic>? data = doc.data();
    if (doc.data() != null && doc.data()!.isNotEmpty) {
      return (doc.data()!['change_addresses'] as List).cast<String>();
    } else {
      return <String>[];
    }
  }

  Future<List<String>> getNonChangeAddresses() async {
    DocumentSnapshot<Map<String, dynamic>> doc =
    await btcAddressesRef.doc(Auth().currentUser!.uid).get();
    String uid = Auth().currentUser!.uid;
    Map<String, dynamic>? data = doc.data();
    if (doc.data() != null && doc.data()!.isNotEmpty) {
      return (doc.data()!['non_change_addresses'] as List).cast<String>();
    } else {
      return <String>[];
    }
  }

  // // // ----------------------
  // // // GET ON-CHAIN TRANSACTIONS
  // // // ----------------------
  // Future<List<dynamic>> getOnchainTransactions() async {
  //   // 1. Get all addresses
  //   List<String> addresses = await getOnchainAddresses();
  //   final DioClient dioClient = Get.find<DioClient>();

  //   List<TransactionModel> allTxs = [];

  //   // 2. Fetch transactions for each address and aggregate
  //   for (String addr in addresses) {
  //     try {
  //       String url =
  //           '${AppTheme.baseUrlMemPoolSpaceApi}v1/validate-address/$addr';
  //       print(url);
  //       await dioClient.get(url: url).then((value) async {
  //         print(value.data);
  //         ValidateAddressComponentModel validateAddressComponentModel =
  //             ValidateAddressComponentModel.fromJson(value.data);
  //         print(validateAddressComponentModel.isvalid);
  //         validateAddressComponentModel.isvalid
  //             ? await dioClient
  //                 .get(
  //                     url:
  //                         '${AppTheme.baseUrlMemPoolSpaceApi}address/$addr/txs')
  //                 .then((value) async {
  //                 for (int i = 0; i < value.data.length; i++) {
  //                   allTxs.add(TransactionModel.fromJson(value.data[i]));
  //                 }
  //                 print(value.data);
  //               })
  //             : null;
  //       });
  //     } catch (e, tr) {
  //       print(e);
  //       print(tr);
  //     }
  //   }

  //   // Optional: Deduplicate transactions if they appear in multiple addresses
  //   // You can identify transactions by their txid and maintain a set.

  //   // Return aggregated transaction list
  //   allTxs = allTxs.toSet().toList();
  //   return allTxs;
  // }

  // ----------------------
  // SUBSCRIBE TO ON-CHAIN BALANCE UPDATES
  // ----------------------
  dynamic subscribeToOnchainBalance() {
    subscribeToOnchainTransactions().listen((val) {
      getOnchainBalance();
    });
  }

  Stream<BitcoinTransaction?> subscribeToOnchainTransactions() {
    return latestTransaction.stream.asBroadcastStream();
  }

  Stream<LightningPayment?> subscribeToLightningPayments() {
    return latestPayment.stream.asBroadcastStream();
  }

  Stream<ReceivedInvoice?> subscribeToInvoices() {
    return latestInvoice.stream.asBroadcastStream();
  }

  // Call this method from your UI when you want to fetch the status
  Future<void> updateSubServerStatus() async {
    final result = await fetchSubServerStatus();
    subServersStatus.value = result;
  }

  void setHideBalance({bool? hide}) {
    print(hide);
    if (hide != null) {
      hideBalance.value = hide;
    }
    settingsCollection.doc(FirebaseAuth.instance.currentUser?.uid).update({
      "hide_balance": hideBalance.value,
    });
    hideBalance.value = hideBalance.value;
  }

  final arguments = Get.arguments;

  void setSelectedCard(String card) {
    selectedCard.value = card;
    LocalStorage.instance.setString(card, cardTopConstant);
  }

  void setAmtWidgetReversed(bool val) {
    reversed.value = val;
    LocalStorage.instance.setBool(val, reversedConstant);
  }

  // Method to update the first currency and its corresponding Firestore document
  void setFirstCurrencyInDatabase(String currency) {
    settingsCollection.doc(FirebaseAuth.instance.currentUser!.uid).update({
      "selectedCurrency": currency,
    });
    selectedCurrency!.value = currency;
  }

  // Clear method adjusted to reset currency values
  void clearCurrencies() {
    selectedCurrency = null;
  }


  // Getters for currencies

  // Method to update the first currency and its corresponding Firestore document
  // void setCardInDatabase(String selectedCard) {
  //   settingsCollection.doc(FirebaseAuth.instance.currentUser?.uid).update({
  //     "selected_card": selectedCard,
  //   });
  //   selectedCard = selectedCard;
  // }

  // // Clear method adjusted to reset currency values
  // void clearCard() {
  //   selectedCard = null;
  // }


  void handleFuturesCompleted(BuildContext context) {
    logger.i(
        "Handling current completed futures with an errorCount of $errorCount and an Error Message of $loadMessageError");
    if (errorCount > 1) {
      showOverlay(
          context, "Failed to load certain services, please try again later.",
          color: AppTheme.errorColor);
    } else if (errorCount == 1) {
      showOverlay(context, loadMessageError, color: AppTheme.errorColor);
    }
  }

  Future<bool> fetchOnchainWalletBalance() async {
    try {
      this.onchainBalance.value = await getOnchainBalance();

      changeTotalBalanceStr();
    } on Error catch (_) {
      return false;
    } catch (e) {
      return false;
    }
    return true;
  }


  // Method to update the first currency and its corresponding Firestore document
  void setCurrencyType(bool type, {bool updateDatabase = true}) {
    if (updateDatabase) {
      settingsCollection.doc(FirebaseAuth.instance.currentUser!.uid).update(
        {
          "showCoin": type,
        },
      );
    }

    coin.value = type;
    update();
  }

  // Clear method adjusted to reset currency values
  void clearCurrencyType() {
    coin.value = false;
  }

  Future<bool> fetchLightingWalletBalance() async {
    try {
      RestResponse lightningBalanceRest = await channelBalance();

      LightningBalance lightningBalance =
      LightningBalance.fromJson(lightningBalanceRest.data);
      if (!lightningBalanceRest.data.isEmpty) {
        this.lightningBalance.value = lightningBalance;
      }
      changeTotalBalanceStr();
    } on Error catch (_) {
      return false;
    } catch (e) {
      return false;
    }
    return true;
  }

  changeTotalBalanceStr() {
    // Assuming both values are strings and represent numerical values
    String confirmedBalanceStr = onchainBalance.value.confirmedBalance;
    String balanceStr = lightningBalance.value.balance;

    double confirmedBalanceSAT = double.parse(confirmedBalanceStr);
    double balanceSAT = double.parse(balanceStr);

    totalBalanceSAT.value = confirmedBalanceSAT + balanceSAT;

    BitcoinUnitModel bitcoinUnit = CurrencyConverter.convertToBitcoinUnit(
        totalBalanceSAT.value, BitcoinUnits.SAT);
    final balance = bitcoinUnit.amount;
    final unit = bitcoinUnit.bitcoinUnitAsString;

    totalBalanceStr.value = balance.toString() + " " + unit;
    totalBalance.value = bitcoinUnit;
  }

  @override
  void dispose() {
    transactionsSubscription?.cancel();
    invoicesSubscription?.cancel();
    scrollController.dispose();
    super.dispose();
  }

  //die 3 lottiefiles downloaden und anzeigen direkt gespeichert?
  final PageController pageController = PageController();
}