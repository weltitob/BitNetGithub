import 'dart:async';
import 'package:bitnet/backbone/cloudfunctions/lnd/lightningservice/channel_balance.dart';
import 'package:bitnet/backbone/cloudfunctions/lnd/lightningservice/get_transactions.dart';
import 'package:bitnet/backbone/cloudfunctions/lnd/lightningservice/list_invoices.dart';
import 'package:bitnet/backbone/cloudfunctions/lnd/lightningservice/list_payments.dart';
import 'package:bitnet/backbone/cloudfunctions/lnd/lightningservice/wallet_balance.dart';
import 'package:bitnet/backbone/cloudfunctions/lnd/stateservice/litd_subserverstatus.dart';
import 'package:bitnet/backbone/helper/currency/currency_converter.dart';
import 'package:bitnet/backbone/helper/databaserefs.dart';
import 'package:bitnet/backbone/helper/theme/remoteconfig_controller.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/services/base_controller/base_controller.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:bitnet/backbone/services/local_storage.dart';
import 'package:bitnet/components/dialogsandsheets/notificationoverlays/overlay.dart';
import 'package:bitnet/components/items/crypto_item_controller.dart';
import 'package:bitnet/components/items/transactionitem.dart';
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
import 'package:bitnet/models/loop/swaps.dart';
import 'package:bitnet/pages/secondpages/mempool/controller/bitcoin_screen_controller.dart';
import 'package:bitnet/pages/wallet/actions/receive/controller/receive_controller.dart';
import 'package:bitnet/pages/wallet/component/wallet_filter_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../backbone/auth/auth.dart';

class WalletsController extends BaseController {
  final overlayController = Get.find<OverlayController>();
  RxBool hideBalance = false.obs;
  RxBool showInfo = false.obs;
  RxBool transactionsLoaded = false.obs;
  RxBool additionalTransactionsLoaded = false.obs;


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

  Rx<ChartLine?> chartLines = Rx<ChartLine?>(null);
  RxString totalBalanceStr = "0".obs;
  RxDouble totalBalanceSAT = 0.0.obs;
  Rx<BitcoinUnitModel> totalBalance =
      BitcoinUnitModel(bitcoinUnit: BitcoinUnits.SAT, amount: 0).obs;
  String loadMessageError = "";
  int errorCount = 0;

  int loadedBalanceFutures = 0;
  RxInt futuresCompleted = 0.obs;

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

  // Hier werden alle Transaktionen gesammelt (ungefiltert):
  RxList<LightningPayment> lightningPayments_list = <LightningPayment>[].obs;
  RxList<ReceivedInvoice> lightningInvoices_list = <ReceivedInvoice>[].obs;
  RxList<BitcoinTransaction> onchainTransactions_list = <BitcoinTransaction>[].obs;
  RxList<Swap> loopOperations_list = <Swap>[].obs; // optional

  List<TransactionItem> allTransactionItems = [];
  RxList<TransactionItemData> allTransactions =
      RxList<TransactionItemData>.empty(growable: true);
  RxList<TransactionItemData> filteredTransactions =
      RxList<TransactionItemData>.empty(growable: true);

  List<String> btcAddresses = List<String>.empty(growable: true);

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

    logger.i("Fetching balances initially in wallet_controller");

    fetchOnchainWalletBalance().then((value) {
      loadedBalanceFutures++;
      if (!value) {
        errorCount++;
        loadMessageError = "Failed to load Onchain Balance";
      }
      if (loadedBalanceFutures == 2) {
        queueErrorOvelay = true;
      }
    });

    fetchLightingWalletBalance().then((value) {
      loadedBalanceFutures++;
      if (!value) {
        errorCount++;
        loadMessageError = "Failed to load Lightning Balance";
      }
      if (loadedBalanceFutures == 2) {
        queueErrorOvelay = true;
      }
    });

    //---------------------------------------------------

    //----------------------ACTIVITY----------------------

    logger.i("Fetching activity initially in wallet_controller");

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

    // War mal: "if (walletController.futuresCompleted >= 3)"
    if (futuresCompleted >= 3) {
      logger.i("All 3 activity futures fetched can put into lists now");
      loadActivity();
    } else {
      futuresCompleted.listen((val) {
        if (val >= 3) {
          logger.i("All 3 activity futures fetched can put into lists now");
          loadActivity();
        }
      });
    }

    //---------------------------------------------------

    //----------------------SUBSCRIPTIONS----------------------
    logger.i("Subscribing to streams in wallet_controller");

    // --- Invoices Stream Listener ---
    backendRef
        .doc(Auth().currentUser!.uid)
        .collection('invoices')
        .orderBy('settle_date', descending: true)
        .snapshots()
        .listen((query) {
      ReceivedInvoice? model;
      additionalTransactionsLoaded.value = false;
      try {
        logger.i("Received invoice from stream");
        logger.i("first data: ${query.docs.first.data()}");
        logger.i("entire data: ${query.docs}");

        model = ReceivedInvoice.fromJson(query.docs.first.data());

        // Create TransactionItemData for the settled invoice
        TransactionItemData transactionItem = TransactionItemData(
          timestamp: model.settleDate,
          type: TransactionType.lightning,
          direction: TransactionDirection.received,
          receiver: model.paymentRequest.toString(),
          txHash: model.rHash,
          amount: "+${model.amtPaidSat}",
          fee: 0,
          status: TransactionStatus.confirmed,
        );

        // Add to allTransactions list
        addOrUpdateTransaction(transactionItem);

        // Add to lightningInvoices_list
        addOrUpdateLightningInvoice(model);

        // Generate a new empty invoice for the user with 0 amount
        logger.i("Generating new empty invoice for user");
        final receiveController = Get.find<ReceiveController>();
        receiveController.getInvoice(0, "");

        // If the received invoice is settled
        if (model.settled) {
          logger.i("Received invoice from stream: showOverlay should be triggered now");

          // Show overlay for the settled invoice
          overlayController.showOverlayTransaction(
            "Lightning invoice settled",
            transactionItem,
          );

          // Update the lightning balance
          fetchLightingWalletBalance();
        } else {
          logger.i("Invoice received but not settled yet: ${model.settled}");
          // Optionally, handle unsettled invoices here
        }
      } catch (e, stacktrace) {
        model = null;
        logger.e(
            'Failed to convert invoice JSON to invoice model: $e\n$stacktrace');
      }

      // Update the latest invoice regardless of settlement status
      latestInvoice.value = model;
      additionalTransactionsLoaded.value = true;
    });

    // --- Payments Stream Listener ---
    backendRef
        .doc(Auth().currentUser!.uid)
        .collection('payments')
        .orderBy('creation_date', descending: true)
        .snapshots()
        .listen((query) {
      LightningPayment? model;
      additionalTransactionsLoaded.value = false;
      try {
        logger.i("Payment sent and detected in wallet_controller stream");
        model = LightningPayment.fromJson(query.docs.first.data());

        // If the payment is succeeded
        if (model.status == "SUCCEEDED") {
          logger.i("Payment succeeded: showOverlay gets triggered now");
          logger.i("first data: ${query.docs.first.data()}");
          logger.i("entire data: ${query.docs}");

          // Create TransactionItemData for the succeeded payment
          TransactionItemData transactionItem = TransactionItemData(
            timestamp: model.creationDate,
            type: TransactionType.lightning,
            direction: TransactionDirection.sent,
            receiver: model.paymentHash,
            txHash: model.paymentHash,
            amount: "-${model.valueSat}",
            fee: model.fee,
            status: TransactionStatus.confirmed,
          );

          // Show overlay for the succeeded payment
          overlayController.showOverlay(
            "Payment succeeded!",
          );

          // Add to allTransactions list
          addOrUpdateTransaction(transactionItem);

          // Add to lightningPayments_list
          addOrUpdateLightningPayment(model);

          // Update the lightning balance
          fetchLightingWalletBalance();
        } else {
          logger.i("Payment received but not settled yet: ${model.status}");
          // Optionally, handle pending payments here
        }
      } catch (e, stacktrace) {
        model = null;
        logger.e(
            'Failed to convert payment JSON to payment model: $e\n$stacktrace');
      }

      // Update the latest payment regardless of status
      latestPayment.value = model;
      additionalTransactionsLoaded.value = true;
    });

    // --- Transactions Stream Listener ---
    // this currently causes a bug because it shows a transaction each time we load the app and it does that even before we loaded all transactions causing some issues
    backendRef
        .doc(Auth().currentUser!.uid)
        .collection('transactions')
        .orderBy('time_stamp', descending: true)
        .snapshots()
        .listen((query) {
      BitcoinTransaction? model;
      additionalTransactionsLoaded.value = false;
      try {
        logger.i("Received transaction from stream");
        //this right here is a problem sometimes it doesnt actually is the last data
        logger.i("Last data: ${query.docs.first.data()}");
        logger.i("entire data: ${query.docs}");

        model = BitcoinTransaction.fromJson(query.docs.first.data());

        // If the transaction is confirmed
        if (model.numConfirmations > 0) {
          logger.i("Transaction confirmed: showOverlay should be triggered now");

          // Create TransactionItemData for the confirmed transaction
          TransactionItemData transactionItem = TransactionItemData(
            timestamp: model.timeStamp,
            status: TransactionStatus.confirmed,
            type: TransactionType.onChain,
            direction: model.amount!.contains("-")
                ? TransactionDirection.sent
                : TransactionDirection.received,
            receiver: model.amount!.contains("-")
                ? model.destAddresses.last
                : model.destAddresses.first,
            txHash: model.txHash.toString(),
            fee: 0,
            amount: model.amount!.contains("-")
                ? model.amount.toString()
                : "+${model.amount}",
          );

          // Show overlay for the confirmed transaction
          overlayController.showOverlayTransaction(
            "Onchain transaction received",
            transactionItem,
          );

          // Add to allTransactions list
          addOrUpdateTransaction(transactionItem);

          // Add to onchainTransactions_list
          addOrUpdateOnchainTransaction(model);

          // Update the onchain balance
          fetchOnchainWalletBalance();
        } else {
          logger.i(
              "Transaction received but not confirmed yet: Confirmations = ${model.numConfirmations}");
          // Optionally, handle unconfirmed transactions here
        }
      } catch (e, stacktrace) {
        model = null;
        logger.e(
            'Failed to convert transaction JSON to transaction model: $e\n$stacktrace');
      }

      // Update the latest transaction regardless of confirmation status
      latestTransaction.value = model;
      additionalTransactionsLoaded.value = true;
    });


    //---------------------------------------------------
    subscribeToOnchainBalance();
    subscribeToInvoices();
    subscribeToLightningPayments();
    subscribeToOnchainTransactions();
    //---------------------------------------------------

    // Handle initial balance fetch errors if any
    handleFuturesCompleted(Get.context!);
  }

  // Method to add or update transactions in allTransactions list
  void addOrUpdateTransaction(TransactionItemData transaction) {
    // Find the index in allTransactions list
    int index = allTransactions.indexWhere((tx) => tx.txHash == transaction.txHash);

    // Find the index in allTransactionItems list
    int indexForItem = allTransactionItems.indexWhere((tx) => tx.data.txHash == transaction.txHash);

    if (index != -1 && indexForItem != -1) {
      // Update existing transaction in both lists
      allTransactions[index] = transaction;
      allTransactionItems[indexForItem] = TransactionItem(data: transaction);
      logger.i("allTransactions and allTransactionItems existing transaction updated ");
    } else if (index == -1 && indexForItem == -1) {
      // Add new transaction to both lists
      allTransactions.insert(0, transaction);
      allTransactionItems.insert(0, TransactionItem(data: transaction));
      logger.i("allTransactions and allTransactionItems updated");
    } else {
      // Handle inconsistent state where one list contains the transaction and the other does not
      logger.i("Inconsistent state: Transaction found in one list but not the other.");
      // Optionally, synchronize the lists
      if (index != -1 && indexForItem == -1) {
        allTransactionItems.insert(index, TransactionItem(data: transaction));
      } else if (index == -1 && indexForItem != -1) {
        allTransactions.insert(indexForItem, transaction);
      }
    }

    // Re-combine the transactions to update the combined list
    combineTransactions();
  }

  // Method to add or update invoices in lightningInvoices_list
// Method to add or update invoices in lightningInvoices_list and lightningInvoices Map
  void addOrUpdateLightningInvoice(ReceivedInvoice invoice) {
    // Find the index of the existing invoice in the list
    int index = lightningInvoices_list.indexWhere((inv) => inv.rHash == invoice.rHash);

    if (index != -1) {
      // Update existing invoice in the list
      lightningInvoices_list[index] = invoice;
      logger.i("Updated existing lightning invoice with rHash: ${invoice.rHash}");
    } else {
      // Add new invoice to the list
      lightningInvoices_list.add(invoice);
      logger.i("Added new lightning invoice with rHash: ${invoice.rHash}");
    }

    // Update the RxMap with the invoice's JSON representation
    lightningInvoices[invoice.rHash] = invoice.toJson();
    logger.i("Updated lightningInvoices RxMap for rHash: ${invoice.rHash}");

    // Re-combine the transactions to refresh the combined list
    combineTransactions();
  }


  // Method to add or update payments in lightningPayments_list
  // Method to add or update payments in lightningPayments_list and lightningPayments Map
  void addOrUpdateLightningPayment(LightningPayment payment) {
    // Find the index of the existing payment in the list
    int index = lightningPayments_list.indexWhere((pmt) => pmt.paymentHash == payment.paymentHash);

    if (index != -1) {
      // Update existing payment in the list
      lightningPayments_list[index] = payment;
      logger.i("Updated existing lightning payment with paymentHash: ${payment.paymentHash}");
    } else {
      // Add new payment to the list
      lightningPayments_list.add(payment);
      logger.i("Added new lightning payment with paymentHash: ${payment.paymentHash}");
    }

    // Update the RxMap with the payment's JSON representation
    lightningPayments[payment.paymentHash] = payment.toJson();
    logger.i("Updated lightningPayments RxMap for paymentHash: ${payment.paymentHash}");

    // Re-combine the transactions to refresh the combined list
    combineTransactions();
  }


  // Method to add or update onchain transactions in onchainTransactions_list
  // Method to add or update onchain transactions in onchainTransactions_list and onchainTransactions Map
  void addOrUpdateOnchainTransaction(BitcoinTransaction transaction) {
    // Find the index of the existing transaction in the list
    int index = onchainTransactions_list.indexWhere((tx) => tx.txHash == transaction.txHash);

    if (index != -1) {
      // Update existing transaction in the list
      onchainTransactions_list[index] = transaction;
      logger.i("Updated existing onchain transaction with txHash: ${transaction.txHash}");
    } else {
      // Add new transaction to the list
      onchainTransactions_list.add(transaction);
      logger.i("Added new onchain transaction with txHash: ${transaction.txHash}");
    }

    // Update the RxMap with the transaction's JSON representation
    onchainTransactions[transaction.txHash!] = transaction.toJson();
    logger.i("Updated onchainTransactions RxMap for txHash: ${transaction.txHash}");

    // Re-combine the transactions to refresh the combined list
    combineTransactions();
  }


  //------------------------------------------------------------------------------------------

  /// Holt Onchain TX
  /// Fetch Onchain Transactions
  Future<bool> getOnchainTransactionsList() async {
    try {
      logger.i("Getting onchain transactions...");
      Map<String, dynamic> data = onchainTransactions; // Access the RxMap's value

      // Parse the transactions from JSON
      List<BitcoinTransaction> transactions = BitcoinTransactionsList.fromJson(data).transactions;

      // Update the RxList using assignAll to maintain reactivity
      onchainTransactions_list.assignAll(transactions);
      logger.i("Loaded ${onchainTransactions_list.length} on-chain transactions.");

      // Update the RxMap with the latest transactions
      onchainTransactions['transactions'] = transactions.map((tx) => tx.toJson()).toList();
      logger.i("Updated onchainTransactions RxMap.");
    } catch (e) {
      logger.e("Error loading on-chain TX: $e");
      return false;
    }
    return true;
  }

  /// Holt Lightning Payments
  /// Fetch Lightning Payments
  Future<bool> getLightningPaymentsList() async {
    try {
      logger.i("Getting lightning payments...");
      Map<String, dynamic> data = lightningPayments; // Access the RxMap's value

      // Parse the payments from JSON using compute for background processing
      List<LightningPayment> payments = await compute(
            (d) => LightningPaymentsList.fromJson(d).payments,
        data,
      );

      // Update the RxList using assignAll
      lightningPayments_list.assignAll(payments);
      logger.i("Loaded ${lightningPayments_list.length} lightning payments.");

      // Update the RxMap with the latest payments
      lightningPayments['payments'] = payments.map((pmt) => pmt.toJson()).toList();
      logger.i("Updated lightningPayments RxMap.");
    } catch (e) {
      logger.e("Error loading LN payments: $e");
      return false;
    }
    return true;
  }


  /// Holt Lightning Invoices
  /// Fetch Lightning Invoices
  Future<bool> getLightningInvoicesList() async {
    try {
      logger.i("Getting lightning invoices...");
      Map<String, dynamic> data = lightningInvoices; // Access the RxMap's value

      // Parse the invoices from JSON and filter settled invoices using compute
      List<ReceivedInvoice> invoices = await compute(
            (d) {
          final allInv = ReceivedInvoicesList.fromJson(d);
          return allInv.invoices.where((i) => i.settled).toList();
        },
        data,
      );

      // Update the RxList using assignAll
      lightningInvoices_list.assignAll(invoices);
      logger.i("Loaded ${lightningInvoices_list.length} settled LN invoices.");

      // Update the RxMap with the latest invoices
      lightningInvoices['invoices'] = invoices.map((inv) => inv.toJson()).toList();
      logger.i("Updated lightningInvoices RxMap.");
    } catch (e) {
      logger.e("Error loading LN invoices: $e");
      return false;
    }
    return true;
  }


  Future<void> loadActivity() async {
    final LoggerService logger = Get.find();
    logger.i("Loading activity in WalletsController...");

    // Reset the transactionsLoaded flag before starting
    transactionsLoaded.value = false;

    // Initialize error tracking variables
    int errorCount = 0;
    List<String> errorMessages = [];

    try {
      // Start all three loading functions in parallel
      logger.i("Starting parallel loading of transactions, payments, and invoices...");
      final List<bool> results = await Future.wait([
        getOnchainTransactionsList(),
        getLightningPaymentsList(),
        getLightningInvoicesList(),
      ]);

      // Extract results
      bool onchainSuccess = results[0];
      bool paymentsSuccess = results[1];
      bool invoicesSuccess = results[2];

      // Check each result and record errors if any
      if (!onchainSuccess) {
        errorCount++;
        errorMessages.add("Failed to load On-Chain Transactions.");
        logger.e("On-Chain Transactions failed to load.");
      } else {
        logger.i("On-Chain Transactions loaded successfully.");
      }

      if (!paymentsSuccess) {
        errorCount++;
        errorMessages.add("Failed to load Lightning Payments.");
        logger.e("Lightning Payments failed to load.");
      } else {
        logger.i("Lightning Payments loaded successfully.");
      }

      if (!invoicesSuccess) {
        errorCount++;
        errorMessages.add("Failed to load Lightning Invoices.");
        logger.e("Lightning Invoices failed to load.");
      } else {
        logger.i("Lightning Invoices loaded successfully.");
      }

      // If there were any errors, handle them (e.g., show an overlay or notify the user)
      if (errorCount > 0) {
        String combinedErrorMessage = errorMessages.join(' ');
        logger.e("Total Errors: $errorCount. Messages: $combinedErrorMessage");

        // Example: Show an overlay notification with the error message
        // Replace this with your actual error handling logic
        overlayController.showOverlay(
          combinedErrorMessage,
          color: AppTheme.errorColor,
        );
      }

    } catch (e, stacktrace) {
      // Handle unexpected errors that might occur during the loading process
      errorCount++;
      String errorMessage = "An unexpected error occurred: $e";
      errorMessages.add(errorMessage);
      logger.e("Error in loadActivity: $e\n$stacktrace");

      // Example: Show an overlay notification with the error message
      overlayController.showOverlay(
        errorMessage,
        color: AppTheme.errorColor,
      );
    } finally {
      // Set transactionsLoaded to true regardless of success or failure
      combineTransactions();
      transactionsLoaded.value = true;
      logger.i("Finished loading activity. Transactions Loaded: ${transactionsLoaded.value}");
    }
  }

  void combineTransactions() {
    LoggerService logger = Get.find();
    logger.i("Combining transactions in wallet_controller.dart...");

    Future.microtask(() {
      // Clear the existing combined list
      allTransactionItems.clear();

      // Combine On-Chain Transactions
      allTransactionItems.addAll(
        onchainTransactions_list.map(
              (tx) => TransactionItem(
            data: TransactionItemData(
              timestamp: tx.timeStamp,
              status: tx.numConfirmations > 0
                  ? TransactionStatus.confirmed
                  : TransactionStatus.pending,
              type: TransactionType.onChain,
              direction: tx.amount!.contains("-")
                  ? TransactionDirection.sent
                  : TransactionDirection.received,
              receiver: tx.amount!.contains("-")
                  ? tx.destAddresses.last
                  : tx.destAddresses.first,
              txHash: tx.txHash.toString(),
              fee: 0,
              amount: tx.amount!.contains("-")
                  ? tx.amount.toString()
                  : "+${tx.amount}",
            ),
          ),
        ),
      );

      // Combine Lightning Payments
      allTransactionItems.addAll(
        lightningPayments_list.map(
              (pmt) => TransactionItem(
            data: TransactionItemData(
              timestamp: pmt.creationDate,
              type: TransactionType.lightning,
              direction: TransactionDirection.sent,
              receiver: pmt.paymentHash,
              txHash: pmt.paymentHash,
              amount: "-${pmt.valueSat}",
              fee: pmt.fee,
              status: pmt.status == "SUCCEEDED"
                  ? TransactionStatus.confirmed
                  : pmt.status == "FAILED"
                  ? TransactionStatus.failed
                  : TransactionStatus.pending,
            ),
          ),
        ),
      );

      // Combine Lightning Invoices
      allTransactionItems.addAll(
        lightningInvoices_list.map(
              (inv) => TransactionItem(
            data: TransactionItemData(
              timestamp: inv.settleDate,
              type: TransactionType.lightning,
              direction: TransactionDirection.received,
              receiver: inv.paymentRequest.toString(),
              txHash: inv.rHash,
              amount: "+${inv.amtPaidSat}",
              fee: 0,
              status: inv.settled
                  ? TransactionStatus.confirmed
                  : TransactionStatus.failed,
            ),
          ),
        ),
      );

      // Optional: Combine Loop Operations if needed
      // allTransactionItems.addAll(...);

      // Sort the combined list by timestamp descending
      allTransactionItems.sort((a, b) => b.data.timestamp.compareTo(a.data.timestamp));
      // Update the reactive allTransactions list
      allTransactions.value = allTransactionItems.map((item) => item.data).toList();
    });
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
    final RemoteConfigController remoteConfigController =
        Get.find<RemoteConfigController>();
    String baseUrlMemPoolSpaceApi =
        remoteConfigController.baseUrlMemPoolSpaceApi.value;

    String url = '${baseUrlMemPoolSpaceApi}address/$addr/utxo';
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

  // ----------------------
  // SUBSCRIBE TO ON-CHAIN BALANCE UPDATES
  // ----------------------

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
  //   settingsCollection.doc(FirebaseAuth.instance.currentUser!.uid).update({
  //     "selected_card": selectedCard,
  //   });
  //   selectedCard = selectedCard;
  // }

  // // Clear method adjusted to reset currency values
  // void clearCard() {
  //   selectedCard = null;
  // }

  void handleFuturesCompleted(BuildContext context) {
    final overlayController = Get.find<OverlayController>();

    logger.i(
        "Handling current completed futures with an errorCount of $errorCount and an Error Message of $loadMessageError");
    if (errorCount > 1) {
      overlayController.showOverlay(
          "Failed to load certain services, please try again later.",
          color: AppTheme.errorColor);
    } else if (errorCount == 1) {
      overlayController.showOverlay(loadMessageError,
          color: AppTheme.errorColor);
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
    logger.i("Fetching Lightning Wallet Balance...");
    try {
      RestResponse lightningBalanceRest = await channelBalance();

      LightningBalance lightningBalance =
          LightningBalance.fromJson(lightningBalanceRest.data);
      if (!lightningBalanceRest.data.isEmpty) {
        this.lightningBalance.value = lightningBalance;
      }
      logger.i("Lightning Balance: ${lightningBalance.balance.toString()}");
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
    // No manual subscriptions to cancel as Firestore streams are handled by listen
    scrollController.dispose();
    super.dispose();
  }

  //die 3 lottiefiles downloaden und anzeigen direkt gespeichert?
  final PageController pageController = PageController();
}
