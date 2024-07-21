import 'package:bitnet/backbone/auth/auth.dart';
import 'package:bitnet/backbone/cloudfunctions/lnd/lightningservice/get_transactions.dart';
import 'package:bitnet/backbone/cloudfunctions/lnd/lightningservice/list_invoices.dart';
import 'package:bitnet/backbone/cloudfunctions/lnd/lightningservice/list_payments.dart';
import 'package:bitnet/backbone/cloudfunctions/loop/listswaps.dart';
import 'package:bitnet/backbone/helper/databaserefs.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:bitnet/components/dialogsandsheets/bottom_sheets/bit_net_bottom_sheet.dart';
import 'package:bitnet/components/dialogsandsheets/notificationoverlays/overlay.dart';
import 'package:bitnet/components/fields/searchfield/searchfield.dart';
import 'package:bitnet/components/items/transactionitem.dart';
import 'package:bitnet/components/loaders/loaders.dart';
import 'package:bitnet/models/bitcoin/lnd/payment_model.dart';
import 'package:bitnet/models/bitcoin/lnd/received_invoice_model.dart';
import 'package:bitnet/models/bitcoin/lnd/transaction_model.dart';
import 'package:bitnet/models/bitcoin/transactiondata.dart';
import 'package:bitnet/models/firebase/restresponse.dart';
import 'package:bitnet/models/loop/swaps.dart';
import 'package:bitnet/pages/wallet/component/wallet_filter_controller.dart';
import 'package:bitnet/pages/wallet/component/wallet_filter_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class Transactions extends StatefulWidget {
  final bool fullList;
  Transactions({Key? key, this.fullList = false}) : super(key: key);

  @override
  State<Transactions> createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions> with SingleTickerProviderStateMixin {
  final controller = Get.put(
    WalletFilterController(),
  );

  bool transactionsLoaded = false;
  List<LightningPayment> lightningPayments = [];
  List<ReceivedInvoice> lightningInvoices = [];
  List<BitcoinTransaction> onchainTransactions = [];
  List<dynamic> loopOperations = [];
  final searchCtrl = TextEditingController();

  Future<bool> getOnchainTransactions() async {
    LoggerService logger = Get.find();
    try {
      logger.i("Getting onchain transactions");
      RestResponse restBitcoinTransactions = await getTransactions();
      BitcoinTransactionsList bitcoinTransactions = BitcoinTransactionsList.fromJson(restBitcoinTransactions.data);
      onchainTransactions = bitcoinTransactions.transactions;
      List<Map<String, dynamic>> mapList = List<Map<String, dynamic>>.from(restBitcoinTransactions.data['transactions'] as List);

      sendPaymentDataReceivedOnchainBatch(mapList);
      setState(() {});
    } on Error catch (_) {
      return false;
    } catch (e) {
      return false;
    }
    return true;
  }

  Future<bool> getLoopOperations() async {
    LoggerService logger = Get.find();
    try {
      logger.i("Getting loop operations");
      RestResponse restLoopOperations = await listSwaps();
      SwapList swapList = SwapList.fromJson(restLoopOperations.data);
      this.loopOperations = swapList.swaps;
      setState(() {});
    } on Error catch (_) {
      return false;
    } catch (e) {
      return false;
    }
    return true;
  }

  //what i sent on the lightning network
  Future<bool> getLightningPayments() async {
    LoggerService logger = Get.find();
    try {
      logger.i("Getting lightning payments");
      RestResponse restLightningPayments = await listPayments();
      LightningPaymentsList lightningPayments = LightningPaymentsList.fromJson(restLightningPayments.data);
      this.lightningPayments = lightningPayments.payments;
      // sendPaymentDataReceivedLightningBatch(restLightningPayments.data['transactions']);

      setState(() {});
    } on Error catch (_) {
      return false;
    } catch (e) {
      return false;
    }
    return true;
  }

  //what I received on the lightning network
  Future<bool> getLightningInvoices() async {
    LoggerService logger = Get.find();
    logger.i("Getting lightning invoices");
    try {
      RestResponse restLightningInvoices = await listInvoices();
      ReceivedInvoicesList lightningInvoices = ReceivedInvoicesList.fromJson(restLightningInvoices.data);
      List<ReceivedInvoice> settledInvoices = lightningInvoices.invoices.where((invoice) => invoice.settled).toList();
      this.lightningInvoices = settledInvoices;
      List<Map<String, dynamic>> mapList = List<Map<String, dynamic>>.from(restLightningInvoices.data['invoices'] as List);
      sendPaymentDataReceivedInvoiceBatch(mapList);

      setState(() {});
    } on Error catch (_) {
      return false;
    } catch (e) {
      return false;
    }
    return true;
  }

  // Subscriptions

  @override
  void initState() {
    LoggerService logger = Get.find();
    logger.i("Initializing transactions page");
    super.initState();
    setState(() {
      transactionsLoaded = false;
    });
    int futuresCompleted = 0;
    int errorCount = 0;
    String errorMessage = "";
    getOnchainTransactions().then((value) {
      futuresCompleted++;
      if (!value) {
        errorCount++;
        errorMessage = "${L10n.of(context)!.failedToLoadOnchain}";
      }

      if (futuresCompleted == 3) {
        if (mounted) {
          setState(() {
            transactionsLoaded = true;
          });
          handlePageLoadErrors(errorCount, errorMessage, context);
        }
      }
    });

    getLightningPayments().then((value) {
      futuresCompleted++;
      if (!value) {
        errorCount++;
        errorMessage = "${L10n.of(context)!.failedToLoadPayments}";
      }

      if (futuresCompleted == 3) {
        if (mounted) {
          setState(() {
            transactionsLoaded = true;
          });
          handlePageLoadErrors(errorCount, errorMessage, context);
        }
      }
    });

    getLightningInvoices().then((value) {
      futuresCompleted++;
      if (!value) {
        errorCount++;
        errorMessage = "${L10n.of(context)!.failedToLoadLightning}";
      }

      if (futuresCompleted == 3) {
        if (mounted) {
          setState(() {
            transactionsLoaded = true;
          });
          handlePageLoadErrors(errorCount, errorMessage, context);
        }
      }
    });
    // getLoopOperations().then((value) {
    //   futuresCompleted++;
    //   if (!value) {
    //     errorCount++;
    //     errorMessage = L10n.of(context)!.failedToLoadOperations;
    //   }
    //
    //   if (futuresCompleted == 3) {
    //     setState(() {
    //       transactionsLoaded = true;
    //     });
    //     handlePageLoadErrors(errorCount, errorMessage, context);
    //   }
    // });
  }

  void handlePageLoadErrors(int errorCount, String errorMessage, BuildContext context) {
    if (errorCount == 1) {
      showOverlay(context, errorMessage, color: AppTheme.errorColor);
    } else if (errorCount > 1) {
      showOverlay(context, L10n.of(context)!.failedToLoadCertainData, color: AppTheme.errorColor);
    }
  }

  @override
  Widget build(BuildContext context) {
    var combinedTransactions = controller.selectedFilters.contains('Lightning')
        ? [
            ...lightningInvoices.map(
              (transaction) => TransactionItem(
                context: context,
                data: TransactionItemData(
                  timestamp: transaction.settleDate,
                  type: TransactionType.lightning,
                  direction: TransactionDirection.received,
                  receiver: transaction.paymentRequest.toString(),
                  txHash: transaction.value.toString(),
                  amount: "+" + transaction.amtPaid.toString(),
                  fee: 0,
                  status: transaction.settled ? TransactionStatus.confirmed : TransactionStatus.failed,
                ),
              ),
            ),
            ...lightningPayments.map(
              (transaction) => TransactionItem(
                context: context,
                data: TransactionItemData(
                  timestamp: transaction.creationDate,
                  type: TransactionType.lightning,
                  direction: TransactionDirection.sent,
                  receiver: transaction.paymentHash.toString(),
                  txHash: transaction.paymentHash.toString(),
                  amount: "-" + transaction.valueSat.toString(),
                  fee: transaction.fee,
                  status: transaction.status == "SUCCEEDED"
                      ? TransactionStatus.confirmed
                      : transaction.status == "FAILED"
                          ? TransactionStatus.failed
                          : TransactionStatus.pending,
                ),
              ),
            ),
          ].toList()
        : controller.selectedFilters.contains('Onchain')
            ? [
                ...onchainTransactions.map(
                  (transaction) => TransactionItem(
                    context: context,
                    data: TransactionItemData(
                      timestamp: transaction.timeStamp,
                      status: transaction.numConfirmations > 0 ? TransactionStatus.confirmed : TransactionStatus.pending,
                      type: TransactionType.onChain,
                      direction: transaction.amount!.contains("-") ? TransactionDirection.sent : TransactionDirection.received,
                      receiver: transaction.amount!.contains("-")
                          ? transaction.destAddresses.last.toString()
                          : transaction.destAddresses.first.toString(),
                      txHash: transaction.txHash.toString(),
                      fee: 0,
                      amount: transaction.amount!.contains("-") ? transaction.amount.toString() : "+" + transaction.amount.toString(),
                    ),
                  ),
                ),
              ].toList()
            : [
                ...lightningInvoices.map(
                  (transaction) => TransactionItem(
                    context: context,
                    data: TransactionItemData(
                      timestamp: transaction.settleDate,
                      type: TransactionType.lightning,
                      direction: TransactionDirection.received,
                      receiver: transaction.paymentRequest.toString(),
                      txHash: transaction.value.toString(),
                      amount: "+" + transaction.amtPaid.toString(),
                      fee: 0,
                      status: transaction.settled ? TransactionStatus.confirmed : TransactionStatus.failed,
                    ),
                  ),
                ),
                ...lightningPayments.map(
                  (transaction) => TransactionItem(
                    context: context,
                    data: TransactionItemData(
                      timestamp: transaction.creationDate,
                      type: TransactionType.lightning,
                      direction: TransactionDirection.sent,
                      receiver: transaction.paymentHash.toString(),
                      txHash: transaction.paymentHash.toString(),
                      amount: "-" + transaction.valueSat.toString(),
                      fee: transaction.fee,
                      status: transaction.status == "SUCCEEDED"
                          ? TransactionStatus.confirmed
                          : transaction.status == "FAILED"
                              ? TransactionStatus.failed
                              : TransactionStatus.pending,
                    ),
                  ),
                ),
                ...onchainTransactions.map(
                  (transaction) => TransactionItem(
                    context: context,
                    data: TransactionItemData(
                      timestamp: transaction.timeStamp,
                      status: transaction.numConfirmations > 0 ? TransactionStatus.confirmed : TransactionStatus.pending,
                      type: TransactionType.onChain,
                      direction: transaction.amount!.contains("-") ? TransactionDirection.sent : TransactionDirection.received,
                      receiver: transaction.amount!.contains("-")
                          ? transaction.destAddresses.last.toString()
                          : transaction.destAddresses.first.toString(),
                      txHash: transaction.txHash.toString(),
                      fee: 0,
                      amount: transaction.amount!.contains("-") ? transaction.amount.toString() : "+" + transaction.amount.toString(),
                    ),
                  ),
                ),
              ].toList();

    combinedTransactions.sort(
      (a, b) => a.data.timestamp.compareTo(b.data.timestamp),
    );
    combinedTransactions = combinedTransactions.reversed.toList();
    if (combinedTransactions.isNotEmpty) {
      controller.initialDate(combinedTransactions.last.data.timestamp);
    }
    return transactionsLoaded
        ? widget.fullList
            ? Container()
            : Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: AppTheme.elementSpacing,
                    ),
                    child: SearchFieldWidget(
                      hintText: 'Search',
                      handleSearch: (v) {
                        setState(() {
                          searchCtrl.text = v;
                        });
                      },
                      suffixIcon: IconButton(
                        icon: Icon(
                          FontAwesomeIcons.filter,
                          color: Theme.of(context).brightness == Brightness.dark ? AppTheme.white60 : AppTheme.black60,
                          size: AppTheme.cardPadding * 0.75,
                        ),
                        onPressed: () async {
                          await BitNetBottomSheet(
                            context: context,
                            child: WalletFilterScreen(),
                          );
                          setState(() {});
                        },
                      ),
                      isSearchEnabled: true,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true, // This is important
                        itemCount: combinedTransactions.length,
                        itemBuilder: (context, index) {
                          if (combinedTransactions[index].data.timestamp >= controller.start &&
                              combinedTransactions[index].data.timestamp <= controller.end) {
                            if (controller.selectedFilters.contains('Sent') && controller.selectedFilters.contains('Received')) {
                              return combinedTransactions[index];
                            }
                            if (controller.selectedFilters.contains('Sent')) {
                              return combinedTransactions[index].data.amount.contains('-') ? combinedTransactions[index] : SizedBox();
                            }
                            if (controller.selectedFilters.contains('Received')) {
                              return combinedTransactions[index].data.amount.contains('+') ? combinedTransactions[index] : SizedBox();
                            }
                            return combinedTransactions[index].data.receiver.contains(searchCtrl.text.toLowerCase())
                                ? combinedTransactions[index]
                                : SizedBox();
                          }
                          return SizedBox(); // Return a SizedBox for other cases
                        },
                      ),
                      SizedBox(
                        height: AppTheme.cardPadding.h * 1,
                      )
                    ],
                  ),
                ],
              )
        : Container(
            height: AppTheme.cardPadding * 10.h,
            child: dotProgress(context),
          );
  }

  Future<void> sendPaymentDataReceivedOnchainBatch(List<Map<String, dynamic>> data) async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await btcReceiveRef.doc(Auth().currentUser!.uid).collection('onchain').get();
    List<Map<String, dynamic>> allData = snapshot.docs.map((doc) => doc.data()).toList();
    BitcoinTransactionsList btcFinalList = BitcoinTransactionsList.fromList(allData);
    List<BitcoinTransaction> transactions = btcFinalList.transactions;
    List<BitcoinTransaction> newTransactions = BitcoinTransactionsList.fromList(data).transactions;
    List<String> duplicateHashes = List.empty(growable: true);
    for (int i = 0; i < newTransactions.length; i++) {
      BitcoinTransaction item1 = newTransactions[i];
      if (item1.amount!.contains('-')) {
        duplicateHashes.add(item1.txHash!);
      }
      for (int j = 0; j < transactions.length; j++) {
        BitcoinTransaction item2 = transactions[j];
        if ((item1.txHash == item2.txHash && item1.txHash != null && item2.txHash != null)) {
          duplicateHashes.add(item1.txHash!);
        }
      }
    }
    newTransactions.removeWhere((test) => test.txHash != null && duplicateHashes.contains(test.txHash!));
    WriteBatch batch = FirebaseFirestore.instance.batch();
    for (int i = 0; i < newTransactions.length; i++) {
      batch.set(btcReceiveRef.doc(Auth().currentUser!.uid).collection('onchain').doc(), newTransactions[i].toJson());
    }
    batch.commit();
  }

  Future<void> sendPaymentDataReceivedLightningBatch(List<Map<String, dynamic>> data) async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await btcReceiveRef.doc(Auth().currentUser!.uid).collection('lnurl').get();
    List<Map<String, dynamic>> allData = snapshot.docs.map((doc) => doc.data()).toList();
    LightningPaymentsList btcFinalList = LightningPaymentsList.fromList(allData);
    List<LightningPayment> transactions = btcFinalList.payments;
    List<LightningPayment> newTransactions = LightningPaymentsList.fromList(data).payments;
    List<String> duplicateHashes = List.empty(growable: true);
    for (int i = 0; i < newTransactions.length; i++) {
      LightningPayment item1 = newTransactions[i];
      for (int j = 0; j < transactions.length; j++) {
        LightningPayment item2 = transactions[j];
        if ((item1.paymentHash == item2.paymentHash)) {
          duplicateHashes.add(item1.paymentHash);
        }
      }
    }
    newTransactions.removeWhere((test) => duplicateHashes.contains(test.paymentHash));
    WriteBatch batch = FirebaseFirestore.instance.batch();
    for (int i = 0; i < newTransactions.length; i++) {
      batch.set(btcReceiveRef.doc(Auth().currentUser!.uid).collection('lnurl').doc(), newTransactions[i]);
    }
    batch.commit();
  }

  Future<void> sendPaymentDataReceivedInvoiceBatch(List<Map<String, dynamic>> data) async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await btcReceiveRef.doc(Auth().currentUser!.uid).collection('lnbc').get();
    List<Map<String, dynamic>> allData = snapshot.docs.map((doc) => doc.data()).toList();
    ReceivedInvoicesList btcFinalList = ReceivedInvoicesList.fromList(allData);
    List<ReceivedInvoice> transactions = btcFinalList.invoices;
    List<ReceivedInvoice> newTransactions = ReceivedInvoicesList.fromList(data).invoices;
    List<String> duplicateHashes = List.empty(growable: true);
    for (int i = 0; i < newTransactions.length; i++) {
      ReceivedInvoice item1 = newTransactions[i];
      for (int j = 0; j < transactions.length; j++) {
        ReceivedInvoice item2 = transactions[j];
        if ((item1.rHash == item2.rHash)) {
          duplicateHashes.add(item1.rHash);
        }
      }
    }
    newTransactions.removeWhere((test) => duplicateHashes.contains(test.rHash));
    WriteBatch batch = FirebaseFirestore.instance.batch();
    for (int i = 0; i < newTransactions.length; i++) {
      batch.set(btcReceiveRef.doc(Auth().currentUser!.uid).collection('lnbc').doc(), newTransactions[i].toJson());
    }
    batch.commit();
  }
}
