import 'dart:async';

import 'package:bitnet/backbone/cloudfunctions/lnd/lightningservice/channel_balance.dart';
import 'package:bitnet/backbone/cloudfunctions/lnd/lightningservice/wallet_balance.dart';
import 'package:bitnet/backbone/helper/currency/currency_converter.dart';
import 'package:bitnet/backbone/helper/databaserefs.dart';
import 'package:bitnet/backbone/streams/lnd/subscribe_invoices.dart';
import 'package:bitnet/backbone/streams/lnd/subscribe_transactions.dart';
import 'package:bitnet/components/dialogsandsheets/notificationoverlays/overlay.dart';
import 'package:bitnet/components/items/crypto_item_controller.dart';
import 'package:bitnet/components/items/transactionitem.dart';
import 'package:bitnet/models/bitcoin/lnd/lightning_balance_model.dart';
import 'package:bitnet/models/bitcoin/lnd/onchain_balance_model.dart';
import 'package:bitnet/models/bitcoin/lnd/received_invoice_model.dart';
import 'package:bitnet/models/bitcoin/lnd/transaction_model.dart';
import 'package:bitnet/models/bitcoin/transactiondata.dart';
import 'package:bitnet/models/currency/bitcoinunitmodel.dart';
import 'package:bitnet/models/firebase/restresponse.dart';
import 'package:bitnet/pages/wallet/actions/receive/controller/receive_controller.dart';
import 'package:bitnet/pages/wallet/component/wallet_filter_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:matrix/matrix.dart';

class WalletsController extends GetxController {
  RxBool hideBalance = false.obs;
  late final Future<LottieComposition> compositionSend;
  late final Future<LottieComposition> compositionReceive;
  late OnchainBalance onchainBalance = OnchainBalance(
    totalBalance: '0',
    confirmedBalance: '0',
    unconfirmedBalance: '0',
    lockedBalance: '0',
    reservedBalanceAnchorChan: '',
    accountBalance: '',
  );

  late LightningBalance lightningBalance = LightningBalance(
    balance: '0',
    pendingOpenBalance: '0',
    localBalance: '0',
    remoteBalance: '0',
    unsettledLocalBalance: '0',
    pendingOpenLocalBalance: '',
    unsettledRemoteBalance: '',
    pendingOpenRemoteBalance: '',
  );

  RxBool visible = false.obs;

  StreamSubscription<List<ReceivedInvoice>>? invoicesSubscription;
  StreamSubscription<List<BitcoinTransaction>>? transactionsSubscription;

  RxString totalBalanceStr = "0".obs;
  RxDouble totalBalanceSAT = 0.0.obs;

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

  RxString? selectedCard;

  // Getters for currencies

  // Method to update the first currency and its corresponding Firestore document
  void setCardInDatabase(String selectedCard) {
    settingsCollection.doc(FirebaseAuth.instance.currentUser?.uid).update({
      "selected_card": selectedCard,
    });
    selectedCard = selectedCard;
  }

  // Clear method adjusted to reset currency values
  void clearCard() {
    selectedCard = null;
  }

  RxBool? coin;

  // Getters for currencies

  // Method to update the first currency and its corresponding Firestore document
  void setCurrencyType(bool type) {
    settingsCollection.doc(FirebaseAuth.instance.currentUser!.uid).update({
      "showCoin": type,
    });
    coin!.value = type;
    update();
  }

  // Clear method adjusted to reset currency values
  void clearCurrencyType() {
    coin!.value = false;
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
    super.onInit();
    Get.put(CryptoItemController());
    Get.put(WalletFilterController());
    subscribeInvoicesStream().listen((restResponse) {
      Logs().w("Received data from Invoice-stream: $restResponse");
      ReceivedInvoice receivedInvoice =
          ReceivedInvoice.fromJson(restResponse.data);
      if (receivedInvoice.settled == true) {
        showOverlayTransaction(
          Get.context!,
          "Lightning invoice settled",
          TransactionItemData(
            amount: receivedInvoice.amtPaidSat.toString(),
            timestamp: receivedInvoice.settleDate,
            type: TransactionType.lightning,
            fee: 0,
            status: TransactionStatus.confirmed,
            direction: TransactionDirection.received,
            receiver: receivedInvoice.paymentRequest!,
            txHash: receivedInvoice.rHash!,
          ),
        );
        //generate a new invoice for the user with 0 amount
        Logs().w("Generating new empty invoice for user");
        ReceiveController().getInvoice(0, "Empty invoice");
      } else {
        Logs().w(
            "Invoice received but not settled yet: ${receivedInvoice.settled}");
      }
    }, onError: (error) {
      Logs().e("Received error for Invoice-stream: $error");
    });

    subscribeTransactionsStream().listen((restResponse) {
      Logs().e("nisidi subscribeTransactionsStream");

      BitcoinTransaction bitcoinTransaction =
          BitcoinTransaction.fromJson(restResponse.data);
      showOverlayTransaction(
          Get.context!,
          "Onchain transaction settled",
          TransactionItemData(
            amount: bitcoinTransaction.amount.toString(),
            timestamp: bitcoinTransaction.timeStamp,
            type: TransactionType.onChain,
            fee: 0,
            status: TransactionStatus.confirmed,
            direction: TransactionDirection.received,
            receiver: bitcoinTransaction.destAddresses[0],
            txHash: bitcoinTransaction.txHash,
          ));
      //});
    }, onError: (error) {
      Logs().e("Received error for Transactions-stream: $error");
    });

    fetchOnchainWalletBalance();
    fetchLightingWalletBalance();
  }

  void fetchOnchainWalletBalance() async {
    try {
      RestResponse onchainBalanceRest = await walletBalance();
      if (!onchainBalanceRest.data.isEmpty) {
        OnchainBalance onchainBalance =
            OnchainBalance.fromJson(onchainBalanceRest.data);
        this.onchainBalance = onchainBalance;
      }
      changeTotalBalanceStr();
    } catch (e) {
      print(e);
    }
  }

  void fetchLightingWalletBalance() async {
    try {
      RestResponse lightningBalanceRest = await channelBalance();

      LightningBalance lightningBalance =
          LightningBalance.fromJson(lightningBalanceRest.data);
      if (!lightningBalanceRest.data.isEmpty) {
        this.lightningBalance = lightningBalance;
      }
      changeTotalBalanceStr();
    } catch (e) {
      print(e);
    }
  }

  changeTotalBalanceStr() {
    // Assuming both values are strings and represent numerical values
    String confirmedBalanceStr = onchainBalance.confirmedBalance;
    String balanceStr = lightningBalance.balance;

    double confirmedBalanceSAT = double.parse(confirmedBalanceStr);
    double balanceSAT = double.parse(balanceStr);

    totalBalanceSAT.value = confirmedBalanceSAT + balanceSAT;

    BitcoinUnitModel bitcoinUnit = CurrencyConverter.convertToBitcoinUnit(
        totalBalanceSAT.value, BitcoinUnits.SAT);
    final balance = bitcoinUnit.amount;
    final unit = bitcoinUnit.bitcoinUnitAsString;

    totalBalanceStr.value = balance.toString() + " " + unit;
  }

  @override
  void dispose() {
    invoicesSubscription?.cancel();
    transactionsSubscription?.cancel();
    super.dispose();
  }

  //die 3 lottiefiles downloaden und anzeigen direkt gespeichert?
  final PageController pageController = PageController();
}
