import 'dart:async';

import 'package:bitnet/backbone/auth/storePrivateData.dart';
import 'package:bitnet/backbone/cloudfunctions/lnd/lightningservice/channel_balance.dart';
import 'package:bitnet/backbone/cloudfunctions/lnd/lightningservice/get_transactions.dart';
import 'package:bitnet/backbone/cloudfunctions/lnd/lightningservice/list_invoices.dart';
import 'package:bitnet/backbone/cloudfunctions/lnd/lightningservice/list_payments.dart';
import 'package:bitnet/backbone/cloudfunctions/lnd/lightningservice/wallet_balance.dart';
import 'package:bitnet/backbone/cloudfunctions/lnd/stateservice/litd_subserverstatus.dart';
import 'package:bitnet/backbone/cloudfunctions/loop/listswaps.dart';
import 'package:bitnet/backbone/helper/currency/currency_converter.dart';
import 'package:bitnet/backbone/helper/databaserefs.dart';
import 'package:bitnet/backbone/helper/key_services/hdwalletfrommnemonic.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/services/base_controller/base_controller.dart';
import 'package:bitnet/backbone/services/base_controller/dio/dio_service.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:bitnet/backbone/services/local_storage.dart';
import 'package:bitnet/components/dialogsandsheets/notificationoverlays/overlay.dart';
import 'package:bitnet/components/items/crypto_item_controller.dart';
import 'package:bitnet/models/bitcoin/chartline.dart';
import 'package:bitnet/models/bitcoin/lnd/lightning_balance_model.dart';
import 'package:bitnet/models/bitcoin/lnd/onchain_balance_model.dart';
import 'package:bitnet/models/bitcoin/lnd/received_invoice_model.dart';
import 'package:bitnet/models/bitcoin/lnd/subserverinfo.dart';
import 'package:bitnet/models/bitcoin/lnd/transaction_model.dart';
import 'package:bitnet/models/bitcoin/transactiondata.dart';
import 'package:bitnet/models/currency/bitcoinunitmodel.dart';
import 'package:bitnet/models/firebase/restresponse.dart';
import 'package:bitnet/models/keys/privatedata.dart';
import 'package:bitnet/models/mempool_models/validate_address_component.dart';
import 'package:bitnet/pages/secondpages/mempool/controller/bitcoin_screen_controller.dart';
import 'package:bitnet/pages/transactions/model/transaction_model.dart';
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

  late StreamController<dynamic> sendTransactionsStream;
  RxInt futuresCompleted = 0.obs;

  // A reactive variable to hold the fetched sub-server status
  Rxn<SubServersStatus> subServersStatus = Rxn<SubServersStatus>();

  //------------------------------------------------------------------------------------------
  //----------------------NEW SECTION FOR UPDATED WALLET SYSTEM-------------------------------
  //------------------------------------------------------------------------------------------

  Future<OnchainBalance> getOnchainBalance() async {
    // 1. Get all addresses
    List<String> addresses = await getOnchainAddresses();
    int totalBalance = 0;
    int confirmedBalance = 0;
    int unconfirmedBalance = 0;
    final DioClient dioClient = Get.find<DioClient>();

    // 2. For each address, fetch UTXOs and sum up the value
    for (String addr in addresses) {
      String url = '${AppTheme.baseUrlMemPoolSpaceApi}address/$addr/utxo';
      try {
        final response = await dioClient.get(
          url: url,
        );
        if (response.statusCode == 200) {
          List utxos = response.data;
          // Sum all UTXOs for this address
          for (int i = 0; i < utxos.length; i++) {
            int balance = utxos[i]['value'];
            bool confirmed = utxos[i]['status']['confirmed'];
            totalBalance += balance;
            if (confirmed) {
              confirmedBalance += balance;
            } else {
              unconfirmedBalance += balance;
            }
          }
        }
      } catch (e) {
        // Handle errors gracefully
        print('Error fetching UTXOs for $addr: $e');
      }
    }
    return OnchainBalance(
        totalBalance: totalBalance.toString(),
        confirmedBalance: confirmedBalance.toString(),
        unconfirmedBalance: unconfirmedBalance.toString(),
        lockedBalance: '0',
        reservedBalanceAnchorChan: '0',
        accountBalance: totalBalance.toString()); // in satoshis
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

  // ----------------------
  // GET ON-CHAIN TRANSACTIONS
  // ----------------------
  Future<List<dynamic>> getOnchainTransactions() async {
    // 1. Get all addresses
    List<String> addresses = await getOnchainAddresses();
    final DioClient dioClient = Get.find<DioClient>();

    List<TransactionModel> allTxs = [];

    // 2. Fetch transactions for each address and aggregate
    for (String addr in addresses) {
      try {
        String url =
            '${AppTheme.baseUrlMemPoolSpaceApi}v1/validate-address/$addr';
        print(url);
        await dioClient.get(url: url).then((value) async {
          print(value.data);
          ValidateAddressComponentModel validateAddressComponentModel =
              ValidateAddressComponentModel.fromJson(value.data);
          print(validateAddressComponentModel.isvalid);
          validateAddressComponentModel.isvalid
              ? await dioClient
                  .get(
                      url:
                          '${AppTheme.baseUrlMemPoolSpaceApi}address/$addr/txs')
                  .then((value) async {
                  for (int i = 0; i < value.data.length; i++) {
                    allTxs.add(TransactionModel.fromJson(value.data[i]));
                  }
                  print(value.data);
                })
              : null;
        });
      } catch (e, tr) {
        print(e);
        print(tr);
      }
    }

    // Optional: Deduplicate transactions if they appear in multiple addresses
    // You can identify transactions by their txid and maintain a set.

    // Return aggregated transaction list
    allTxs = allTxs.toSet().toList();
    return allTxs;
  }

  // ----------------------
  // SUBSCRIBE TO ON-CHAIN BALANCE UPDATES
  // ----------------------
  dynamic subscribeToOnchainBalance() {
    String mnemonic = "your mnemonic here";
    // There's no direct "address subscription" endpoint.
    // Instead, subscribe to mempool-wide events and filter on client side:
    // You can reuse logic from TransactionController’s websocket setup.

    // Steps:
    // 1. Derive addresses.
    // 2. Connect to mempool.space WebSocket.
    // 3. Subscribe to mempool transactions using {"action": "want", "data": ["watch-mempool"]}.
    // 4. On each incoming tx, check if it involves the derived addresses (vin/vout).
    // 5. If it does, re-fetch the balances or update the cached balance incrementally.
  }

  // ----------------------
  // SUBSCRIBE TO ON-CHAIN TRANSACTIONS
  // ----------------------
  dynamic subscribeToOnchainTransactions() {
    String mnemonic = "your mnemonic here";
    // Similar to subscribeToOnchainBalance:
    // 1. Derive addresses.
    // 2. Connect to WebSocket and subscribe to mempool updates.
    // 3. Filter incoming transactions:
    //    - Parse tx from websocket message
    //    - If any input or output matches the derived addresses, trigger update in UI or internal state.
    //
    // The TransactionController code you have already shows how to connect and receive data:
    // You'd move that logic to a dedicated method in the WalletController that:
    // - Opens the WS connection
    // - Sends the initial "want" message
    // - On message, checks against known addresses.
  }

  //------------------------------------------------------------------------------------------
  //------------------------------------------------------------------------------------------
  //------------------------------------------------------------------------------------------

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

  RxBool coin = false.obs;

  // Getters for currencies

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

  RxString? selectedCurrency;

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

  @override
  void onInit() {
    final logger = Get.find<LoggerService>();
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
      print("Currency Value : ${selectedCurrency!.value}");
    }, onError: (a, b) {
      coin.value = false;
      selectedCurrency = RxString("");
      selectedCurrency!.value = "USD";

      print("Currency Value : ${selectedCurrency!.value}");
    });

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

    getTransactions().then((val) {
      logger.i("Fetching transactions in wallet_controller");
      onchainTransactions.addAll(val.data);
      futuresCompleted++;
    });
    listSwaps().then((val) {
      logger.i("Fetching swaps in wallet_controller");
      loopOperations.addAll(val.data);
      futuresCompleted++;
    });
    listPayments().then((val) {
      logger.i("Fetching payments in wallet_controller");
      lightningPayments.addAll(val.data);
      futuresCompleted++;
    });
    listInvoices().then((val) {
      logger.i("Fetching invoices in wallet_controller");
      lightningInvoices.addAll(val.data);
      futuresCompleted++;
    });

    sendTransactionsStream = StreamController<dynamic>.broadcast();
  }

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
    scrollController.dispose();
    sendTransactionsStream.close();
    super.dispose();
  }

  //die 3 lottiefiles downloaden und anzeigen direkt gespeichert?
  final PageController pageController = PageController();
}
