import 'dart:async';

import 'package:bitnet/backbone/cloudfunctions/lnd/lightningservice/channel_balance.dart';
import 'package:bitnet/backbone/cloudfunctions/lnd/lightningservice/get_transactions.dart';
import 'package:bitnet/backbone/cloudfunctions/lnd/lightningservice/list_invoices.dart';
import 'package:bitnet/backbone/cloudfunctions/lnd/lightningservice/list_payments.dart';
import 'package:bitnet/backbone/cloudfunctions/lnd/lightningservice/wallet_balance.dart';
import 'package:bitnet/backbone/cloudfunctions/lnd/stateservice/litd_subserverstatus.dart';
import 'package:bitnet/backbone/cloudfunctions/loop/listswaps.dart';
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
import 'package:bitnet/models/bitcoin/lnd/received_invoice_model.dart';
import 'package:bitnet/models/bitcoin/lnd/subserverinfo.dart';
import 'package:bitnet/models/bitcoin/lnd/transaction_model.dart';
import 'package:bitnet/models/bitcoin/transactiondata.dart';
import 'package:bitnet/models/currency/bitcoinunitmodel.dart';
import 'package:bitnet/models/firebase/restresponse.dart';
import 'package:bitnet/pages/secondpages/mempool/controller/bitcoin_screen_controller.dart';
import 'package:bitnet/pages/wallet/component/wallet_filter_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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

  //----------------------NEW SECTION FOR UPDATED WALLET SYSTEM-------------------------------

  //Get the balance for users hdwallet


  //get the balance for the end


  //get the .....


  //retrive all transactions for the wallet and it's keys



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
      RestResponse onchainBalanceRest = await walletBalance();
      if (!onchainBalanceRest.data.isEmpty) {
        OnchainBalance onchainBalance =
            OnchainBalance.fromJson(onchainBalanceRest.data);
        this.onchainBalance.value = onchainBalance;
      }
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
