import 'dart:async';
import 'package:bitnet/backbone/cloudfunctions/lnd/lightningservice/channel_balance.dart';
import 'package:bitnet/backbone/cloudfunctions/lnd/lightningservice/get_transactions.dart';
import 'package:bitnet/backbone/cloudfunctions/lnd/lightningservice/list_invoices.dart';
import 'package:bitnet/backbone/cloudfunctions/lnd/lightningservice/list_payments.dart';
import 'package:bitnet/backbone/cloudfunctions/lnd/lightningservice/wallet_balance.dart';
import 'package:bitnet/backbone/cloudfunctions/lnd/stateservice/litd_subserverstatus.dart';
import 'package:bitnet/backbone/cloudfunctions/moonpay/moonpay_sign_url.dart';
import 'package:bitnet/backbone/helper/currency/currency_converter.dart';
import 'package:bitnet/backbone/helper/databaserefs.dart';
import 'package:bitnet/backbone/helper/supported_currencies.dart';
import 'package:bitnet/backbone/helper/theme/remoteconfig_controller.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/services/base_controller/base_controller.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:bitnet/backbone/services/bitcoin_controller.dart';
import 'package:bitnet/backbone/services/local_storage.dart';
import 'package:bitnet/components/dialogsandsheets/notificationoverlays/overlay.dart';
import 'package:bitnet/components/items/crypto_item_controller.dart';
import 'package:bitnet/components/items/transactionitem.dart';
import 'package:bitnet/models/bitcoin/channel/channel_operation.dart';
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
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:bitnet/services/moonpay.dart'
  if (dart.library.html) 'package:bitnet/services/moonpay_web.dart';

import '../../../backbone/auth/auth.dart';

class WalletsController extends BaseController {
  final overlayController = Get.find<OverlayController>();
  RxBool hideBalance = false.obs;
  RxBool showInfo = false.obs;
  RxBool transactionsLoaded = false.obs;
  RxBool additionalTransactionsLoaded = false.obs;
  ScrollController scrollController = ScrollController();
  
  // Counter to force UI updates when timeframe changes
  RxInt timeframeChangeCounter = 0.obs;

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
    var subscription = subscribeToOnchainTransactions().listen((val) {
      getOnchainBalance();
    });
    // Track subscription for cleanup
    _allSubscriptions.add(subscription);
    return subscription;
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
  RxMap<String, dynamic> internalRebalances = <String, dynamic>{}.obs;
  RxMap<String, dynamic> loopOperations = <String, dynamic>{}.obs;

  // Hier werden alle Transaktionen gesammelt (ungefiltert):
  RxList<LightningPayment> lightningPayments_list = <LightningPayment>[].obs;
  RxList<ReceivedInvoice> lightningInvoices_list = <ReceivedInvoice>[].obs;
  RxList<BitcoinTransaction> onchainTransactions_list =
      <BitcoinTransaction>[].obs;
  RxList<InternalRebalance> internalRebalancess_list =
      <InternalRebalance>[].obs;
  RxList<Swap> loopOperations_list = <Swap>[].obs; // optional
  RxList<ChannelOperation> channelOperations_list = <ChannelOperation>[].obs;

  List<TransactionItem> __allTransactionItems = [];
  List<TransactionItem> get _allTransactionItems => __allTransactionItems;
  List<TransactionItem> get allTransactionItems => _allTransactionItems;
  
  RxList<TransactionItemData> allTransactions =
      RxList<TransactionItemData>.empty(growable: true);
  RxList<TransactionItemData> filteredTransactions =
      RxList<TransactionItemData>.empty(growable: true);

  List<String> btcAddresses = List<String>.empty(growable: true);

  //reactive values to handle transaction and invoice streams
  Rx<BitcoinTransaction?> latestTransaction = Rx<BitcoinTransaction?>(null);
  Rx<ReceivedInvoice?> latestInvoice = Rx<ReceivedInvoice?>(null);
  Rx<LightningPayment?> latestPayment = Rx<LightningPayment?>(null);
  Rx<InternalRebalance?> latestinternalRebalance = Rx<InternalRebalance?>(null);
  Rx<Map<String, dynamic>?> latestChannelOperation = Rx<Map<String, dynamic>?>(null);

  // A reactive variable to hold the fetched sub-server status
  Rxn<SubServersStatus> subServersStatus = Rxn<SubServersStatus>();

  RxBool coin = false.obs;

  // Getters for currencies
  RxString? selectedCurrency;

  @override
  void onInit() {
    super.onInit();
    final logger = Get.find<LoggerService>();
    logger.i("Calling onInit in wallet_controller");
    
    // Reset the subscription list to ensure clean state
    _allSubscriptions.clear();

    Get.put(CryptoItemController());
    Get.put(WalletFilterController());
    Get.put(BitcoinScreenController());

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
    logger.i("NEW: Fetching balances from user's individual node...");
    
    // Fetch balances directly - no need to wait for remote config anymore
    // The balance functions now get node info from NodeMappingService
    fetchOnchainWalletBalance().then((value) {
      loadedBalanceFutures++;
      if (!value) {
        errorCount++;
        loadMessageError = "Failed to load Onchain Balance";
      }
      if (loadedBalanceFutures == 2) {
        queueErrorOvelay = true;
        double btcDouble =
            CurrencyConverter.convertSatoshiToBTC(totalBalanceSAT.value);
        updateBalance(DateTime.now(), btcDouble);
      }
    }).catchError((error) {
      logger.e("Error fetching onchain balance: $error");
      loadedBalanceFutures++;
      errorCount++;
      loadMessageError = "Failed to load Onchain Balance";
    });

    fetchLightingWalletBalance().then((value) {
      loadedBalanceFutures++;
      if (!value) {
        errorCount++;
        loadMessageError = "Failed to load Lightning Balance";
      }
      if (loadedBalanceFutures == 2) {
        queueErrorOvelay = true;
        double btcDouble =
            CurrencyConverter.convertSatoshiToBTC(totalBalanceSAT.value);
        updateBalance(DateTime.now(), btcDouble);
      }
    }).catchError((error) {
      logger.e("Error fetching lightning balance: $error");
      loadedBalanceFutures++;
      errorCount++;
      loadMessageError = "Failed to load Lightning Balance";
    });

    //---------------------------------------------------

    //----------------------ACTIVITY----------------------
    logger.i("Fetching activity from Firebase...");

    // Activity is still fetched from Firebase, not from individual nodes
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

    // FETCH ALL OLD REBALANCES ON INIT
    listInternalRebalances(Auth().currentUser!.uid).then((val) {
      logger.i("Fetching internal node rebalances in wallet_controller");
      final mapList = val.map((reb) => reb.toJson()).toList();
      internalRebalances.value = {
        'internalRebalances': mapList, // Even if mapList is empty
      };

      logger.i("Internal rebalances: $mapList");
      // Not incrementing futuresCompleted here by default,
      // will handle them in loadActivity with a new method
      futuresCompleted++;
    });

    // FETCH ALL CHANNEL OPERATIONS ON INIT
    _loadChannelOperations().then((val) {
      futuresCompleted++;
    });

    // War mal: "if (walletController.futuresCompleted >= 3)"
    // Now we have 5 futures: transactions, payments, invoices, rebalances, channel operations
    if (futuresCompleted >= 5) {
      logger.i("All 5 activity futures fetched can put into lists now");
      loadActivity();
    } else {
      futuresCompleted.listen((val) {
        if (val >= 5) {
          logger.i("All 5 activity futures fetched can put into lists now");
          loadActivity();
        }
      });
    }
    MoonpayFlutter().setOnUrlGenerated((url) async {
      String? signature = await moonpaySignUrl(url);
      if (signature != null) {
        MoonpayFlutter().sendSignature(signature);
      }
    });
    //---------------------------------------------------

    //----------------------SUBSCRIPTIONS----------------------
    logger.i("Subscribing to streams in wallet_controller");

    // --- Invoices Stream Listener ---
    var invoicesSubscription = backendRef
        .doc(Auth().currentUser!.uid)
        .collection('invoices')
        .orderBy('settle_date', descending: true)
        .snapshots()
        .skip(1) // Skip the initial snapshot
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
          logger.i(
              "Received invoice from stream: showOverlay should be triggered now");

          // Show overlay for the settled invoice
          overlayController.showOverlayTransaction(
            "Lightning invoice settled",
            transactionItem,
          );

          // Update the lightning balance
          fetchLightingWalletBalance(balanceUpdate: true);
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

    // --- Internal Rebalances Stream Listener ---
    var rebalancesSubscription = backendRef
        .doc(Auth().currentUser!.uid)
        .collection('internalRebalances')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .skip(1) // Skip the initial snapshot
        .listen((query) {
      InternalRebalance? model;

      logger.i("Received internal rebalance from stream");
      logger.i("first data: ${query.docs.first.data()}");
      logger.i("entire data: ${query.docs}");

      model = InternalRebalance.fromJson(query.docs.first.data());

      // We'll create a TransactionItemData object, but the direction depends on whether
      // the current user is the receiver or the sender.
      TransactionItemData transactionItem = TransactionItemData(
        timestamp: model.timestamp,
        type: TransactionType.internalRebalance,
        direction: TransactionDirection.sent, // default to 'sent'
        receiver: model.lightningAddressResolved,
        txHash: model.lightningAddressResolved,
        amount: "-${model.amountSatoshi}",
        fee: 0,
        status: TransactionStatus.confirmed,
      );

      final currentUid = Auth().currentUser!.uid;

      if (currentUid == model.internalAccountIdReceiver) {
        // If I'm the receiver, treat it like a lightning invoice
        transactionItem = TransactionItemData(
          timestamp: model.timestamp,
          type: TransactionType.internalRebalance,
          direction: TransactionDirection.received,
          receiver: model.lightningAddressResolved,
          txHash: model.senderUserUid,
          amount: "+${model.amountSatoshi}",
          fee: 0,
          status: TransactionStatus.confirmed,
        );

        overlayController.showOverlayTransaction(
          "Lightning invoice settled via BitNet",
          transactionItem,
        );

        // Also build the corresponding invoice model
        ReceivedInvoice receivemodel = ReceivedInvoice(
          memo: "",
          rPreimage: model.senderUserUid,
          settleDate: model.timestamp,
          paymentRequest: model.lightningAddressResolved,
          rHash: model.senderUserUid,
          amtPaidSat: model.amountSatoshi,
          settled: true,
          value: model.amountSatoshi,
          valueMsat: model.amountSatoshi,
          creationDate: model.timestamp,
          state: '',
          amtPaid: model.amountSatoshi,
          amtPaidMsat: model.amountSatoshi,
        );

        // Add to allTransactions list
        addOrUpdateTransaction(transactionItem);
        // Add to lightningInvoices_list
        addOrUpdateLightningInvoice(receivemodel);
      } else {
        // I'm the sender, treat it like a lightning payment
        overlayController.showOverlay(
          "Payment succeeded!",
        );

        // Add to allTransactions list
        addOrUpdateTransaction(transactionItem);

        LightningPayment lightningModel = LightningPayment(
          paymentHash: model.lightningAddressResolved,
          value: model.amountSatoshi,
          creationDate: model.timestamp,
          fee: 0,
          paymentPreimage: model.lightningAddressResolved,
          valueSat: model.amountSatoshi,
          valueMsat: model.amountSatoshi,
          paymentRequest: "paymentRequest",
          status: "TransactionStatus.confirmed",
          feeSat: 0,
          feeMsat: 0,
          creationTimeNs: model.timestamp,
          htlcs: [],
          paymentIndex: "paymentIndex",
          failureReason: "failureReason",
        );

        // Add to lightningPayments_list
        addOrUpdateLightningPayment(lightningModel);
      }

      // Update the lightning balance
      fetchLightingWalletBalance(balanceUpdate: true);

      // Update the latest invoice regardless of settlement status
      latestinternalRebalance.value = model;
    });

    // --- Payments Stream Listener ---
    var paymentsSubscription = backendRef
        .doc(Auth().currentUser!.uid)
        .collection('payments')
        .orderBy('creation_date', descending: true)
        .snapshots()
        .skip(1) // Skip the initial snapshot
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
          fetchLightingWalletBalance(balanceUpdate: true);
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
    var transactionsSubscription = backendRef
        .doc(Auth().currentUser!.uid)
        .collection('transactions')
        .orderBy('time_stamp', descending: true)
        .snapshots()
        .skip(1) // Skip the initial snapshot
        .listen((query) {
      BitcoinTransaction? model;
      additionalTransactionsLoaded.value = false;
      try {
        logger.i("Received transaction from stream");
        logger.i("Last data: ${query.docs.first.data()}");
        logger.i("entire data: ${query.docs}");

        model = BitcoinTransaction.fromJson(query.docs.first.data());

        // If the transaction is confirmed
        if (model.numConfirmations > 0) {
          logger
              .i("Transaction confirmed: showOverlay should be triggered now");

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
          fetchOnchainWalletBalance(balanceUpdate: true);
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

    // --- Channel Operations Stream Listener ---
    var channelOperationsSubscription = backendRef
        .doc(Auth().currentUser!.uid)
        .collection('channel_operations')
        .orderBy('timestamp', descending: true)
        .snapshots()
        // Don't skip initial snapshot to ensure we get all channel operations
        .listen((query) {
      Map<String, dynamic>? channelOp;
      additionalTransactionsLoaded.value = false;
      
      try {
        logger.i("Received channel operation from stream");
        if (query.docs.isEmpty) return;
        
        channelOp = query.docs.first.data();
        logger.i("Channel operation data: $channelOp");
        
        // Convert to ChannelOperation model
        final operation = ChannelOperation.fromFirestore(channelOp);
        
        // Create TransactionItemData for the channel operation
        TransactionItemData transactionItem = TransactionItemData(
          timestamp: operation.timestamp,
          type: operation.type == ChannelOperationType.existing 
              ? TransactionType.channelDetected // New type for existing channels
              : TransactionType.channelOpen,
          direction: operation.type == ChannelOperationType.existing
              ? TransactionDirection.received // Existing channels are like receiving capacity
              : TransactionDirection.sent, // Channel opens are like sending funds
          receiver: operation.displaySubtitle,
          txHash: operation.channelId,
          amount: operation.capacity.toString(),
          fee: 0,
          status: operation.status == ChannelOperationStatus.active
              ? TransactionStatus.confirmed
              : operation.status == ChannelOperationStatus.failed
                  ? TransactionStatus.failed
                  : TransactionStatus.pending,
        );
        
        // Add to allTransactions list
        addOrUpdateTransaction(transactionItem);
        
        // Completely disable automatic channel operation overlays to prevent spam
        // User will see channel status in the wallet transaction list instead
        // Remove all overlay notifications for channel operations
        
      } catch (e, stacktrace) {
        channelOp = null;
        logger.e(
            'Failed to process channel operation: $e\n$stacktrace');
      }
      
      // Update the latest channel operation
      latestChannelOperation.value = channelOp;
      additionalTransactionsLoaded.value = true;
    });

    //---------------------------------------------------
    // Track all subscriptions for proper cleanup
    _allSubscriptions.add(invoicesSubscription);
    _allSubscriptions.add(rebalancesSubscription);
    _allSubscriptions.add(paymentsSubscription);
    _allSubscriptions.add(transactionsSubscription);
    _allSubscriptions.add(channelOperationsSubscription);
    
    // Subscribe to balance and transaction updates
    subscribeToOnchainBalance();
    subscribeToInvoices();
    subscribeToLightningPayments();
    subscribeToOnchainTransactions();
    //---------------------------------------------------

    // Handle initial balance fetch errors if any
    handleFuturesCompleted(Get.context!);
  }

  // Load channel operations from Firestore
  Future<void> _loadChannelOperations() async {
    try {
      logger.i("Fetching channel operations in wallet_controller");
      
      final userId = Auth().currentUser?.uid;
      if (userId == null) {
        logger.e("No authenticated user for loading channel operations");
        return;
      }
      
      final QuerySnapshot snapshot = await backendRef
          .doc(userId)
          .collection('channel_operations')
          .orderBy('timestamp', descending: true)
          .get();
      
      for (var doc in snapshot.docs) {
        try {
          final data = doc.data() as Map<String, dynamic>;
          final operation = ChannelOperation.fromFirestore(data);
          
          // Create TransactionItemData for the channel operation
          TransactionItemData transactionItem = TransactionItemData(
            timestamp: operation.timestamp,
            type: operation.type == ChannelOperationType.existing 
                ? TransactionType.channelDetected // New type for existing channels
                : TransactionType.channelOpen,
            direction: operation.type == ChannelOperationType.existing
                ? TransactionDirection.received // Existing channels are like receiving capacity
                : TransactionDirection.sent, // Channel opens are like sending funds
            receiver: operation.displaySubtitle,
            txHash: operation.channelId,
            amount: operation.capacity.toString(),
            fee: 0,
            status: operation.status == ChannelOperationStatus.active
                ? TransactionStatus.confirmed
                : operation.status == ChannelOperationStatus.failed
                    ? TransactionStatus.failed
                    : TransactionStatus.pending,
          );
          
          // Add to allTransactions list
          allTransactions.add(transactionItem);
          
        } catch (e) {
          logger.e("Error processing channel operation: $e");
        }
      }
      
      logger.i("Loaded ${snapshot.docs.length} channel operations");
      
    } catch (e) {
      logger.e("Failed to load channel operations: $e");
    }
  }

  // Method to add or update transactions in allTransactions list
  void addOrUpdateTransaction(TransactionItemData transaction) {
    // Find the index in allTransactions list
    int index =
        allTransactions.indexWhere((tx) => tx.txHash == transaction.txHash);

    // Find the index in _allTransactionItems list
    int indexForItem = _allTransactionItems
        .indexWhere((tx) => tx.data.txHash == transaction.txHash);

    if (index != -1 && indexForItem != -1) {
      // Update existing transaction in both lists
      allTransactions[index] = transaction;
      _allTransactionItems[indexForItem] = TransactionItem(data: transaction);
      logger.i(
          "allTransactions and _allTransactionItems existing transaction updated ");
    } else if (index == -1 && indexForItem == -1) {
      // Add new transaction to both lists
      allTransactions.insert(0, transaction);
      _allTransactionItems.insert(0, TransactionItem(data: transaction));
      logger.i("allTransactions and _allTransactionItems updated");
    } else {
      // Handle inconsistent state where one list contains the transaction and the other does not
      logger.i(
          "Inconsistent state: Transaction found in one list but not the other.");
      // Optionally, synchronize the lists
      if (index != -1 && indexForItem == -1) {
        _allTransactionItems.insert(index, TransactionItem(data: transaction));
      } else if (index == -1 && indexForItem != -1) {
        allTransactions.insert(indexForItem, transaction);
      }
    }

    // Re-combine the transactions to update the combined list
    combineTransactions();
  }

  // Method to add or update invoices in lightningInvoices_list and lightningInvoices Map
  void addOrUpdateLightningInvoice(ReceivedInvoice invoice) {
    // Find the index of the existing invoice in the list
    int index =
        lightningInvoices_list.indexWhere((inv) => inv.rHash == invoice.rHash);

    if (index != -1) {
      // Update existing invoice in the list
      lightningInvoices_list[index] = invoice;
      logger
          .i("Updated existing lightning invoice with rHash: ${invoice.rHash}");
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

  // Method to add or update payments in lightningPayments_list and lightningPayments Map
  void addOrUpdateLightningPayment(LightningPayment payment) {
    // Find the index of the existing payment in the list
    int index = lightningPayments_list
        .indexWhere((pmt) => pmt.paymentHash == payment.paymentHash);

    if (index != -1) {
      // Update existing payment in the list
      lightningPayments_list[index] = payment;
      logger.i(
          "Updated existing lightning payment with paymentHash: ${payment.paymentHash}");
    } else {
      // Add new payment to the list
      lightningPayments_list.add(payment);
      logger.i(
          "Added new lightning payment with paymentHash: ${payment.paymentHash}");
    }

    // Update the RxMap with the payment's JSON representation
    lightningPayments[payment.paymentHash] = payment.toJson();
    logger.i(
        "Updated lightningPayments RxMap for paymentHash: ${payment.paymentHash}");

    // Re-combine the transactions to refresh the combined list
    combineTransactions();
  }

  // Method to add or update onchain transactions in onchainTransactions_list and onchainTransactions Map
  void addOrUpdateOnchainTransaction(BitcoinTransaction transaction) {
    // Find the index of the existing transaction in the list
    int index = onchainTransactions_list
        .indexWhere((tx) => tx.txHash == transaction.txHash);

    if (index != -1) {
      // Update existing transaction in the list
      onchainTransactions_list[index] = transaction;
      logger.i(
          "Updated existing onchain transaction with txHash: ${transaction.txHash}");
    } else {
      // Add new transaction to the list
      onchainTransactions_list.add(transaction);
      logger.i(
          "Added new onchain transaction with txHash: ${transaction.txHash}");
    }

    // Update the RxMap with the transaction's JSON representation
    onchainTransactions[transaction.txHash!] = transaction.toJson();
    logger.i(
        "Updated onchainTransactions RxMap for txHash: ${transaction.txHash}");

    // Re-combine the transactions to refresh the combined list
    combineTransactions();
  }

  /// Fetch Onchain Transactions
  Future<bool> getOnchainTransactionsList() async {
    try {
      logger.i("Getting onchain transactions...");
      Map<String, dynamic> data =
          onchainTransactions; // Access the RxMap's value

      // Parse the transactions from JSON
      List<BitcoinTransaction> transactions =
          BitcoinTransactionsList.fromJson(data).transactions;

      // Update the RxList using assignAll to maintain reactivity
      onchainTransactions_list.assignAll(transactions);
      logger.i(
          "Loaded ${onchainTransactions_list.length} on-chain transactions.");

      // Update the RxMap with the latest transactions
      onchainTransactions['transactions'] =
          transactions.map((tx) => tx.toJson()).toList();
      logger.i("Updated onchainTransactions RxMap.");
    } catch (e) {
      logger.e("Error loading on-chain TX: $e");
      return false;
    }
    return true;
  }

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
      lightningPayments['payments'] =
          payments.map((pmt) => pmt.toJson()).toList();
      logger.i("Updated lightningPayments RxMap.");
    } catch (e) {
      logger.e("Error loading LN payments: $e");
      return false;
    }
    return true;
  }

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
      lightningInvoices['invoices'] =
          invoices.map((inv) => inv.toJson()).toList();
      logger.i("Updated lightningInvoices RxMap.");
    } catch (e) {
      logger.e("Error loading LN invoices: $e");
      return false;
    }
    return true;
  }

  /// Fetch internal rebalances; then place them in the correct list (invoice if I'm receiver, payment if I'm sender)
  Future<bool> getInternalRebalancesList() async {
    final logger = Get.find<LoggerService>();
    try {
      logger.i("Getting internal rebalances from internalRebalances RxMap...");
      Map<String, dynamic> data = internalRebalances.value;

      // Extract from our internalRebalances Map
      if (!data.containsKey('internalRebalances')) {
        logger.e("No 'internalRebalances' key found in the map.");
        return true; // Not necessarily an error, just no rebalances
      }

      List<dynamic> rawList = data['internalRebalances'];
      List<InternalRebalance> rebalances = rawList
          .map((rebJson) => InternalRebalance.fromJson(rebJson))
          .toList();

      // Update the RxList
      internalRebalancess_list.assignAll(rebalances);
      logger
          .i("Loaded ${internalRebalancess_list.length} internal rebalances.");

      // For each rebalance, if I'm the receiver => treat like LN invoice,
      // if I'm the sender => treat like LN payment
      final currentUid = Auth().currentUser!.uid;

      for (final reb in rebalances) {
        if (reb.internalAccountIdReceiver == currentUid) {
          // Make it an invoice
          // We create a dummy "TransactionItemData" in the combine step anyway,
          // so let's just store them as a normal LN invoice:
          logger.i("I'm the receiver of the rebalance.");

          ReceivedInvoice invoiceModel = ReceivedInvoice(
            memo: "",
            rPreimage: reb.senderUserUid,
            settleDate: reb.timestamp,
            paymentRequest: reb.lightningAddressResolved,
            rHash: reb.senderUserUid,
            amtPaidSat: reb.amountSatoshi,
            settled: true,
            value: reb.amountSatoshi,
            valueMsat: reb.amountSatoshi,
            creationDate: reb.timestamp,
            state: '',
            amtPaid: reb.amountSatoshi,
            amtPaidMsat: reb.amountSatoshi,
          );
          addOrUpdateLightningInvoice(invoiceModel);
        } else {
          logger.i("I'm the sender of the rebalance: $currentUid");
          // Make it a LN payment
          LightningPayment paymentModel = LightningPayment(
            paymentHash: reb.lightningAddressResolved,
            value: reb.amountSatoshi,
            creationDate: reb.timestamp,
            fee: 0,
            paymentPreimage: reb.lightningAddressResolved,
            valueSat: reb.amountSatoshi,
            valueMsat: reb.amountSatoshi,
            paymentRequest: "paymentRequest",
            status: "SUCCEEDED",
            feeSat: 0,
            feeMsat: 0,
            creationTimeNs: reb.timestamp,
            htlcs: [],
            paymentIndex: "paymentIndex",
            failureReason: "failureReason",
          );
          addOrUpdateLightningPayment(paymentModel);
        }
      }

      // Update the RxMap if desired
      internalRebalances['internalRebalances'] =
          rebalances.map((reb) => reb.toJson()).toList();
      logger.i("Updated internalRebalances RxMap.");
    } catch (e, stacktrace) {
      logger.e("Error loading internal rebalances: $e\n$stacktrace");
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
      // Start all loading functions in parallel (adding rebalances and channel operations):
      logger.i(
          "Starting parallel loading of transactions, payments, invoices, rebalances, and channel operations...");
      final List<Future<bool>> futures = [
        getOnchainTransactionsList(),
        getLightningPaymentsList(),
        getLightningInvoicesList(),
        getInternalRebalancesList(),
      ];
      
      // Add channel operations loading (convert void to bool)
      final channelOpsFuture = _loadChannelOperations().then((_) => true).catchError((e) {
        logger.e("Failed to load channel operations: $e");
        return false;
      });
      futures.add(channelOpsFuture);
      
      final List<bool> results = await Future.wait(futures);

      // Extract results
      bool onchainSuccess = results[0];
      bool paymentsSuccess = results[1];
      bool invoicesSuccess = results[2];
      bool rebalancesSuccess = results[3];
      bool channelOpsSuccess = results[4];

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

      if (!rebalancesSuccess) {
        errorCount++;
        errorMessages.add("Failed to load Internal Rebalances.");
        logger.e("Internal Rebalances failed to load.");
      } else {
        logger.i("Internal Rebalances loaded successfully.");
      }

      if (!channelOpsSuccess) {
        errorCount++;
        errorMessages.add("Failed to load Channel Operations.");
        logger.e("Channel Operations failed to load.");
      } else {
        logger.i("Channel Operations loaded successfully.");
      }

      // If there were any errors, handle them
      if (errorCount > 0) {
        String combinedErrorMessage = errorMessages.join(' ');
        logger.e("Total Errors: $errorCount. Messages: $combinedErrorMessage");

        overlayController.showOverlay(
          combinedErrorMessage,
          color: AppTheme.errorColor,
        );
      }
    } catch (e, stacktrace) {
      // Handle unexpected errors
      errorCount++;
      String errorMessage = "An unexpected error occurred: $e";
      errorMessages.add(errorMessage);
      logger.e("Error in loadActivity: $e\n$stacktrace");

      overlayController.showOverlay(
        errorMessage,
        color: AppTheme.errorColor,
      );
    } finally {
      // Set transactionsLoaded to true regardless of success or failure
      combineTransactions();
      transactionsLoaded.value = true;
      logger.i(
          "Finished loading activity. Transactions Loaded: ${transactionsLoaded.value}");
    }
  }

  void combineTransactions() {
    LoggerService logger = Get.find();
    logger.i("Combining transactions in wallet_controller.dart...");

    Future.microtask(() {
      // Clear the existing combined list
      _allTransactionItems.clear();

      _allTransactionItems.addAll(
        internalRebalancess_list.map(
          (tx) => TransactionItem(
            data: TransactionItemData(
              timestamp: tx.timestamp,
              status: TransactionStatus.confirmed,
              type: TransactionType.lightning,
              direction: tx.receiverUserUid == Auth().currentUser!.uid
                  ? TransactionDirection.sent
                  : TransactionDirection.received,
              receiver: tx.receiverUserUid,
              txHash: tx.lightningAddressResolved,
              fee: 0,
              amount: tx.receiverUserUid == Auth().currentUser!.uid
                  ? "-${tx.amountSatoshi}"
                  : "+${tx.amountSatoshi}",
            ),
          ),
        ),
      );

      // Combine On-Chain Transactions
      _allTransactionItems.addAll(
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
      _allTransactionItems.addAll(
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
      _allTransactionItems.addAll(
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

      // Combine Channel Operations
      _allTransactionItems.addAll(
        channelOperations_list.map(
          (operation) => TransactionItem(
            data: TransactionItemData(
              timestamp: operation.timestamp,
              type: operation.type == ChannelOperationType.existing 
                  ? TransactionType.channelDetected
                  : TransactionType.channelOpen,
              direction: operation.type == ChannelOperationType.existing
                  ? TransactionDirection.received // Detected channels show as received
                  : TransactionDirection.sent, // New channels show as sent (we initiated)
              receiver: operation.remoteNodeAlias,
              txHash: operation.channelId,
              amount: operation.capacity > 0 ? operation.capacity.toString() : "0",
              fee: 0,
              status: operation.status == ChannelOperationStatus.active
                  ? TransactionStatus.confirmed
                  : operation.status == ChannelOperationStatus.failed
                      ? TransactionStatus.failed
                      : TransactionStatus.pending,
            ),
          ),
        ),
      );

      // Sort the combined list by timestamp descending
      _allTransactionItems
          .sort((a, b) => b.data.timestamp.compareTo(a.data.timestamp));

      // Update the reactive allTransactions list
      allTransactions.value =
          _allTransactionItems.map((item) => item.data).toList();
    });
  }

  //------------------------------------------------------------------------------------------
  //----------------------NEW SECTION FOR UPDATED WALLET SYSTEM-------------------------------
  //------------------------------------------------------------------------------------------

  Future<OnchainBalance> getOnchainBalance() async {
    try {
      RestResponse onchainBalanceRest =
          await walletBalance(acc: Auth().currentUser!.uid);
      
      logger.i("Onchain balance response: ${onchainBalanceRest.statusCode}");
      logger.d("Onchain balance data: ${onchainBalanceRest.data}");

      if (onchainBalanceRest.statusCode != "error" && !onchainBalanceRest.data.isEmpty) {
        OnchainBalance onchainBalance =
            OnchainBalance.fromJson(onchainBalanceRest.data);

        this.onchainBalance.value = onchainBalance;
        logger.i("Onchain balance updated: confirmed=${onchainBalance.confirmedBalance}, unconfirmed=${onchainBalance.unconfirmedBalance}");
      } else {
        logger.e("Failed to get onchain balance: ${onchainBalanceRest.message}");
      }
      changeTotalBalanceStr();
    } catch (e) {
      logger.e("Error in getOnchainBalance: $e");
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

  void setFirstCurrencyInDatabase(String currency) {
    settingsCollection.doc(FirebaseAuth.instance.currentUser!.uid).update({
      "selectedCurrency": currency,
    });
    selectedCurrency!.value = currency;
  }

  void clearCurrencies() {
    selectedCurrency = null;
  }

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

  Future<bool> fetchOnchainWalletBalance({bool balanceUpdate = false}) async {
    try {
      this.onchainBalance.value = await getOnchainBalance();
      changeTotalBalanceStr();
      if (balanceUpdate) {
        double btcDouble =
            CurrencyConverter.convertSatoshiToBTC(totalBalanceSAT.value);
        updateBalance(DateTime.now(), btcDouble);
      }
    } on Error catch (_) {
      return false;
    } catch (e) {
      return false;
    }
    return true;
  }

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

  void clearCurrencyType() {
    coin.value = false;
  }

  Future<bool> fetchLightingWalletBalance({bool balanceUpdate = false}) async {
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
      if (balanceUpdate) {
        double btcDouble =
            CurrencyConverter.convertSatoshiToBTC(totalBalanceSAT.value);
        updateBalance(DateTime.now(), btcDouble);
      }
    } on Error catch (_) {
      return false;
    } catch (e) {
      return false;
    }
    return true;
  }

  changeTotalBalanceStr() {
    try {
      // Get balance strings with null safety
      String confirmedBalanceStr = onchainBalance.value.confirmedBalance ?? '0';
      String balanceStr = lightningBalance.value.balance ?? '0';

      // Parse with error handling
      double confirmedBalanceSAT = 0;
      double balanceSAT = 0;
      
      try {
        confirmedBalanceSAT = double.parse(confirmedBalanceStr);
      } catch (e) {
        logger.w("Failed to parse onchain balance: $confirmedBalanceStr");
        confirmedBalanceSAT = 0;
      }
      
      try {
        balanceSAT = double.parse(balanceStr);
      } catch (e) {
        logger.w("Failed to parse lightning balance: $balanceStr");
        balanceSAT = 0;
      }

      totalBalanceSAT.value = confirmedBalanceSAT + balanceSAT;

      BitcoinUnitModel bitcoinUnit = CurrencyConverter.convertToBitcoinUnit(
          totalBalanceSAT.value, BitcoinUnits.SAT);
      final balance = bitcoinUnit.amount;
      final unit = bitcoinUnit.bitcoinUnitAsString;

      totalBalanceStr.value = balance.toString() + " " + unit;
      totalBalance.value = bitcoinUnit;
      
      logger.d("Total balance updated: ${totalBalanceSAT.value} SAT");
    } catch (e) {
      logger.e("Error in changeTotalBalanceStr: $e");
    }
  }
  
  // Calculate what the balance would be if converted at a specific historical price point
  // This allows showing the user what their balance "would have been worth" at different timeframes
  BitcoinUnitModel getTimeAdjustedBalance(double currentPrice, double historicalPrice, BitcoinUnits unit) {
    // Get current balance in SAT
    double currentBalanceSAT = totalBalanceSAT.value;
    
    // If prices are the same or historical price is 0, just return regular balance
    if (historicalPrice <= 0 || currentPrice == historicalPrice) {
      return CurrencyConverter.convertToBitcoinUnit(currentBalanceSAT, unit);
    }
    
    // Calculate adjustment factor (how much the price has changed since historical point)
    double priceRatio = historicalPrice / currentPrice;
    
    // Calculate what the value would have been at that historical price point
    double adjustedBalanceSAT = currentBalanceSAT * priceRatio;
    
    // Convert to requested unit
    return CurrencyConverter.convertToBitcoinUnit(adjustedBalanceSAT, unit);
  }

  Future<void> updateBalance(DateTime time, double price) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final String userId = Auth().currentUser!.uid;

    int timestamp = time.millisecondsSinceEpoch;
    WriteBatch batch = firestore.batch();

    for (String currency in supportedCurrencies.keys) {
      try {
        // 1️⃣ Fetch Bitcoin price localized to this currency
        DocumentSnapshot<Map<String, dynamic>> doc = await firestore
            .collection('chart_data')
            .doc(currency)
            .collection('live')
            .doc('data')
            .get();

        if (!doc.exists ||
            doc.data() == null ||
            !doc.data()!.containsKey('price')) {
          print("Skipping $currency - No price data found.");
          continue; // Skip this currency if price data is missing
        }

        num bitcoinPrice = doc.data()!['price'];

        // 2️⃣ Convert BTC price to this currency
        double localizedPrice = double.parse(CurrencyConverter.convertCurrency(
          "BTC",
          price,
          currency,
          bitcoinPrice.toDouble(),
        ));

        // 3️⃣ Prepare Firestore write batch
        DocumentReference dataPointRef = firestore
            .collection("balance_chart")
            .doc(userId)
            .collection('data')
            .doc(currency)
            .collection('data_points')
            .doc(timestamp.toString()); // Use timestamp as document ID

        batch.set(dataPointRef, {
          "price": localizedPrice,
          "timestamp": timestamp,
        });
      } catch (e) {
        print("Error processing currency $currency: $e"); // Log but continue
      }
    }

    // 4️⃣ Commit all writes in a single batch for efficiency
    await batch.commit();
    print("Balance data updated successfully.");
  }

  // List to track all active subscriptions
  final List<StreamSubscription> _allSubscriptions = [];
  
  @override
  void dispose() {
    // Cancel all tracked subscriptions to prevent memory leaks
    for (var subscription in _allSubscriptions) {
      subscription.cancel();
    }
    _allSubscriptions.clear();
    
    scrollController.dispose();
    pageController.dispose();
    super.dispose();
  }

  //die 3 lottiefiles downloaden und anzeigen direkt gespeichert?
  final PageController pageController = PageController();
}
