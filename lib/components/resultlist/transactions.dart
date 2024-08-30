import 'dart:developer';

import 'package:bitnet/backbone/auth/auth.dart';
import 'package:bitnet/backbone/helper/databaserefs.dart';
import 'package:bitnet/backbone/helper/helpers.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:bitnet/components/container/imagewithtext.dart';
import 'package:bitnet/components/dialogsandsheets/bottom_sheets/bit_net_bottom_sheet.dart';
import 'package:bitnet/components/dialogsandsheets/notificationoverlays/overlay.dart';
import 'package:bitnet/components/fields/searchfield/searchfield.dart';
import 'package:bitnet/components/items/transactionitem.dart';
import 'package:bitnet/components/loaders/loaders.dart';
import 'package:bitnet/models/bitcoin/lnd/payment_model.dart';
import 'package:bitnet/models/bitcoin/lnd/received_invoice_model.dart';
import 'package:bitnet/models/bitcoin/lnd/transaction_model.dart';
import 'package:bitnet/models/bitcoin/transactiondata.dart';
import 'package:bitnet/models/loop/swaps.dart';
import 'package:bitnet/pages/wallet/component/wallet_filter_controller.dart';
import 'package:bitnet/pages/wallet/component/wallet_filter_screen.dart';
import 'package:bitnet/pages/wallet/controllers/wallet_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class Transactions extends StatefulWidget {
  final bool fullList;
  final bool hideOnchain;
  final bool hideLightning;
  final List<String>? filters;
  final List<TransactionItem>? customTransactions;
  final ScrollController scrollController;
  const Transactions(
      {Key? key,
      this.fullList = false,
      this.hideOnchain = false,
      this.hideLightning = false,
      this.filters,
      this.customTransactions,
      required this.scrollController})
      : super(key: key);

  @override
  State<Transactions> createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions> with AutomaticKeepAliveClientMixin {
  late final WalletFilterController controller;
  final walletController = Get.find<WalletsController>();
  bool transactionsLoaded = false;
  bool transactionsOrdered = false;
  bool firstInit = false;
  List<LightningPayment> lightningPayments = [];
  List<ReceivedInvoice> lightningInvoices = [];
  List<BitcoinTransaction> onchainTransactions = [];
  List<Swap> loopOperations = [];
  final searchCtrl = TextEditingController();
  List<Widget> orderedTransactions = List.empty(growable: true);
  int loadedTransactionGroups = 6;
  bool isLoadingTransactionGroups = false;
  Future<bool> getOnchainTransactions() async {
    LoggerService logger = Get.find();
    try {
      logger.i("Getting onchain transactions");
      Map<String, dynamic> data = walletController.onchainTransactions;
      onchainTransactions = await Future.microtask(() {
        BitcoinTransactionsList bitcoinTransactions = BitcoinTransactionsList.fromJson(data);

        return bitcoinTransactions.transactions;
      });
      List<Map<String, dynamic>> mapList = List<Map<String, dynamic>>.from(data['transactions'] as List);
      sendPaymentDataReceivedOnchainBatch(mapList);
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

      Map<String, dynamic> data = walletController.loopOperations;
      this.loopOperations = SwapList.fromJson(data).swaps;
      logger.i('This is the lenght og the loop operation list lenght ${loopOperations.length}=======}');

      // compute((d) {
      //   SwapList swapList = SwapList.fromJson(d);
      //   return swapList;
      // }, data)
      //     .then((d) {
      //   this.loopOperations = d.swaps;
      //   logger.i('This is the lenght og the loop operation list lenght ${d.swaps.length}=======}');
      // });
    } on Error catch (_, s) {
      logger.i('=========This is the error coming from the swap response method ${_} and this is the stacktrace ${s}');
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
      Map<String, dynamic> data = walletController.lightningPayments;
      this.lightningPayments = await compute(
        (d) {
          LightningPaymentsList lightningPayments = LightningPaymentsList.fromJson(d);
          return lightningPayments.payments;
        },
        data,
      );
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
      Map<String, dynamic> data = walletController.lightningInvoices;
      this.lightningInvoices = await compute((d) {
        ReceivedInvoicesList lightningInvoices = ReceivedInvoicesList.fromJson(d);
        List<ReceivedInvoice> settledInvoices = lightningInvoices.invoices.where((invoice) => invoice.settled).toList();

        return settledInvoices;
      }, data);
      List<Map<String, dynamic>> mapList = List<Map<String, dynamic>>.from(data['invoices'] as List);
      sendPaymentDataReceivedInvoiceBatch(mapList);
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
    Get.delete<WalletFilterController>();
    controller = Get.put(
      WalletFilterController(),
    );
    if (widget.filters != null) {
      for (int i = 0; i < widget.filters!.length; i++) {
        controller.toggleFilter(widget.filters![i]);
      }
    }

    logger.i("Initializing transactions");
    super.initState();
    widget.scrollController.addListener(_onScroll);
    if (widget.customTransactions != null) {
      transactionsLoaded = true;
      heavyFiltering();
      return;
    }
    ;
    if (walletController.futuresCompleted >= 4) {
      loadTransactions();
    } else {
      walletController.futuresCompleted.listen((val) {
        if (val >= 4) {
          loadTransactions();
        }
      });
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!firstInit) {
      firstInit = true;
      if (walletController.allTransactions.isNotEmpty && widget.customTransactions == null) {
        Future.microtask(() {
          List<TransactionItem> transactions =
              walletController.allTransactions.map((item) => TransactionItem(data: item, context: context)).toList();
          orderedTransactions = arrangeTransactions(transactions);
          transactionsLoaded = true;
          transactionsOrdered = true;
          setState(() {});
        });
      }
    }
  }

  void loadTransactions() {
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

      if (futuresCompleted == 4) {
        if (mounted) {
          setState(() {
            transactionsLoaded = true;
            heavyFiltering(sticky: true);
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

      if (futuresCompleted == 4) {
        if (mounted) {
          setState(() {
            transactionsLoaded = true;
            heavyFiltering(sticky: true);
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

      if (futuresCompleted == 4) {
        if (mounted) {
          setState(() {
            transactionsLoaded = true;
            heavyFiltering(sticky: true);
          });
          handlePageLoadErrors(errorCount, errorMessage, context);
        }
      }
    });
    getLoopOperations().then((value) {
      futuresCompleted++;
      if (!value) {
        errorCount++;
        errorMessage = L10n.of(context)!.failedToLoadOperations;
      }

      if (futuresCompleted == 4) {
        setState(() {
          transactionsLoaded = true;
          heavyFiltering(sticky: true);
        });
        handlePageLoadErrors(errorCount, errorMessage, context);
      }
    });
  }

  void handlePageLoadErrors(int errorCount, String errorMessage, BuildContext context) {
    if (errorCount == 1) {
      showOverlay(context, errorMessage, color: AppTheme.errorColor);
    } else if (errorCount > 1) {
      showOverlay(context, L10n.of(context)!.failedToLoadCertainData, color: AppTheme.errorColor);
    }
  }

  // List<TransactionItem> filterItems(List<TransactionItem> combinedTransactions) {
  //   List<TransactionItem> finalList = List.empty(growable: true);
  //   for (int index = 0; index < combinedTransactions.length; index++) {
  //     if (combinedTransactions[index].data.timestamp >= controller.start && combinedTransactions[index].data.timestamp <= controller.end) {
  //       if (controller.selectedFilters.contains('Sent') && controller.selectedFilters.contains('Received')) {
  //         finalList.add(combinedTransactions[index]);
  //       }
  //       if (controller.selectedFilters.contains('Sent') && combinedTransactions[index].data.amount.contains('-')) {
  //         finalList.add(combinedTransactions[index]);
  //       }
  //       if (controller.selectedFilters.contains('Received') && combinedTransactions[index].data.amount.contains('+')) {
  //         finalList.add(combinedTransactions[index]);
  //       }
  //       if (combinedTransactions[index].data.receiver.contains(widget.specificSearch ?? searchCtrl.text.toLowerCase())) {
  //         finalList.add(combinedTransactions[index]);
  //       }
  //     }
  //     finalList.add(combinedTransactions[index]);
  //   }
  //   return finalList;
  // }

  List<TransactionItem> filterItems(List<TransactionItem> combinedTransactions) {
    List<TransactionItem> finalList = List.empty(growable: true);
    for (int index = 0; index < combinedTransactions.length; index++) {
      if (combinedTransactions[index].data.timestamp >= controller.start && combinedTransactions[index].data.timestamp <= controller.end) {
        if (combinedTransactions[index].data.receiver.contains(searchCtrl.text.toLowerCase())) {
          if (controller.selectedFilters.contains('Sent') && controller.selectedFilters.contains('Received')) {
            finalList.add(combinedTransactions[index]);
          } else if (controller.selectedFilters.contains('Sent') && combinedTransactions[index].data.amount.contains('-')) {
            finalList.add(combinedTransactions[index]);
          } else if (controller.selectedFilters.contains('Received') && combinedTransactions[index].data.amount.contains('+')) {
            finalList.add(combinedTransactions[index]);
          } else if (!controller.selectedFilters.contains('Sent') && !controller.selectedFilters.contains('Sent')) {
            finalList.add(combinedTransactions[index]);
          }
        }
      }
    }
    return finalList;
  }

  //the difference between this function and filterItems is that it does everything necessary in organizing and filtering
  // so that build only has to build the UI
  //sticky bool is whether this data should be updated to walletscontroller for saving, should only happen initially on page load

  void heavyFiltering({bool sticky = false}) {
    Future.microtask(() {
      late List<TransactionItem> combinedTransactions;
      if (widget.customTransactions != null) {
        combinedTransactions = widget.customTransactions!;
      } else {
        combinedTransactions = controller.selectedFilters.contains('Lightning')
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
                : controller.selectedFilters.contains('Loop')
                    ? [
                        ...loopOperations.map((swap) => TransactionItem(
                              context: context,
                              data: TransactionItemData(
                                timestamp: int.parse(swap.initiationTime) ~/ 1000000000,
                                status: swap.state == "SUCCEEDED"
                                    ? TransactionStatus.confirmed
                                    : swap.state == "FAILED"
                                        ? TransactionStatus.failed
                                        : TransactionStatus.pending,
                                type: swap.type == "LOOP_OUT" ? TransactionType.loopOut : TransactionType.loopIn,
                                direction: swap.type == "LOOP_OUT" ? TransactionDirection.sent : TransactionDirection.received,
                                receiver: swap.htlcAddressP2tr.toString(), // Use htlc_address_p2tr as receiver
                                txHash: swap.htlcAddress.toString(), // Use htlc_address as txHash
                                fee: int.parse(swap.costServer), // Assuming cost_server is the fee
                                amount: swap.amt.toString(),
                              ),
                            ))
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
                              amount:
                                  transaction.amount!.contains("-") ? transaction.amount.toString() : "+" + transaction.amount.toString(),
                            ),
                          ),
                        ),
                        ...loopOperations.map((swap) => TransactionItem(
                              context: context,
                              data: TransactionItemData(
                                timestamp: int.parse(swap.initiationTime) ~/ 1000000000,
                                status: swap.state == "SUCCEEDED"
                                    ? TransactionStatus.confirmed
                                    : swap.state == "FAILED"
                                        ? TransactionStatus.failed
                                        : TransactionStatus.pending,
                                type: swap.type == "LOOP_OUT" ? TransactionType.loopOut : TransactionType.loopIn,
                                direction: swap.type == "LOOP_OUT" ? TransactionDirection.sent : TransactionDirection.received,
                                receiver: swap.htlcAddressP2tr.toString(), // Use htlc_address_p2tr as receiver
                                txHash: swap.htlcAddress.toString(), // Use htlc_address as txHash
                                fee: int.parse(swap.costServer), // Assuming cost_server is the fee
                                amount: swap.amt.toString(),
                              ),
                            ))
                      ].toList();
      }

//Remove dublicates from the combined List.
      Set<String> seenIds = {};
      combinedTransactions = combinedTransactions.where((transaction) {
        if (seenIds.contains(transaction.data.txHash)) {
          return false; // Duplicate ID found, exclude this transaction
        } else {
          seenIds.add(transaction.data.txHash);
          return true; // Unique ID, include this transaction
        }
      }).toList();

      combinedTransactions.sort(
        (a, b) => a.data.timestamp.compareTo(b.data.timestamp),
      );
      combinedTransactions = combinedTransactions.reversed.toList();
      log('This is the lenght of the combinedList ${combinedTransactions.length}');
      if (sticky) {
        List<TransactionItemData> data = combinedTransactions.map((item) {
          return item.data;
        }).toList();
        walletController.allTransactions.value = data;
      }
      combinedTransactions = filterItems(combinedTransactions);
      List<Widget> orderedTransactions = arrangeTransactions(combinedTransactions);

      return orderedTransactions;
    }).then((val) {
      orderedTransactions = val;
      transactionsOrdered = true;

      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return transactionsOrdered
        ? widget.fullList
            ? SliverToBoxAdapter(child: Container())
            : SliverList(
                delegate: SliverChildBuilderDelegate((ctx, index) {
                if (index == 0) {
                  return Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: AppTheme.cardPadding,
                      vertical: AppTheme.elementSpacing,
                    ),
                    child: SearchFieldWidget(
                      hintText: 'Search',
                      isSearchEnabled: true,
                      handleSearch: (v) {
                        setState(() {
                          searchCtrl.text = v;
                          heavyFiltering();
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
                            child: WalletFilterScreen(
                              hideLightning: widget.hideLightning,
                              hideOnchain: widget.hideOnchain,
                              forcedFilters: widget.filters,
                            ),
                          );
                          heavyFiltering();
                          setState(() {});
                        },
                      ),
                    ),
                  );
                } else {
                  if (isLoadingTransactionGroups && index == (loadedTransactionGroups - 1)) {
                    return Center(
                        child: Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: dotProgress(context),
                    ));
                  } else {
                    return orderedTransactions[index - 1];
                  }
                }
              },
                    childCount:
                        loadedTransactionGroups < orderedTransactions.length + 1 ? loadedTransactionGroups : orderedTransactions.length + 1)
                // delegate: SliverChildBuilderDelegate((ctx, index) {
                //   if (index == 0) {
                //     return Container(
                //       margin: EdgeInsets.symmetric(
                //         horizontal: AppTheme.elementSpacing,
                //       ),
                //       child: SearchFieldWidget(
                //         hintText: 'Search',
                //         isSearchEnabled:true,
                //         handleSearch: (v) {
                //           setState(() {
                //             searchCtrl.text = v;
                //             heavyFiltering();
                //           });
                //         },
                //         suffixIcon: IconButton(
                //           icon: Icon(
                //             FontAwesomeIcons.filter,
                //             color: Theme.of(context).brightness == Brightness.dark ? AppTheme.white60 : AppTheme.black60,
                //             size: AppTheme.cardPadding * 0.75,
                //           ),
                //           onPressed: () async {
                //             await BitNetBottomSheet(
                //               context: context,
                //               child: WalletFilterScreen(
                //                 hideLightning: widget.hideLightning,
                //                 hideOnchain: widget.hideOnchain,
                //                 forcedFilters: widget.filters,
                //               ),
                //             );
                //             heavyFiltering();
                //             setState(() {});
                //           },
                //         ),
                //       ),
                //     );
                //   } else {
                //     return orderedTransactions[index - 1];
                //   }
                // },

                )
        : SliverToBoxAdapter(
            child: Container(height: AppTheme.cardPadding * 10.h, child: dotProgress(context)),
          );
  }

  void _onScroll() {
    if (widget.scrollController.position.pixels == widget.scrollController.position.maxScrollExtent && !isLoadingTransactionGroups) {
      _loadMoreTransactionGroups();
    }
  }

  void _loadMoreTransactionGroups() async {
    if (!mounted) {
      return;
    }
    setState(() {
      isLoadingTransactionGroups = true;
    });

    // Simulate a delay to show the "Loading..." text
    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      loadedTransactionGroups += 4;
      isLoadingTransactionGroups = false;
    });
  }

  Future<void> sendPaymentDataReceivedOnchainBatch(List<Map<String, dynamic>> data) async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await btcReceiveRef.doc(Auth().currentUser!.uid).collection('onchain').get();
    List<Map<String, dynamic>> allData = snapshot.docs.map((doc) => doc.data()).toList();
    compute((data) {
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
      return newTransactions;
    }, allData)
        .then((data) {
      WriteBatch batch = FirebaseFirestore.instance.batch();
      for (int i = 0; i < data.length; i++) {
        batch.set(btcReceiveRef.doc(Auth().currentUser!.uid).collection('onchain').doc(), data[i].toJson());
      }
      batch.commit();
    });
  }

  Future<void> sendPaymentDataReceivedLightningBatch(List<Map<String, dynamic>> data) async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await btcReceiveRef.doc(Auth().currentUser!.uid).collection('lnurl').get();
    List<Map<String, dynamic>> allData = snapshot.docs.map((doc) => doc.data()).toList();
    compute((data) {
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
      return newTransactions;
    }, allData)
        .then((data) {
      WriteBatch batch = FirebaseFirestore.instance.batch();
      for (int i = 0; i < data.length; i++) {
        batch.set(btcReceiveRef.doc(Auth().currentUser!.uid).collection('lnurl').doc(), data[i]);
      }
      batch.commit();
    });
  }

  Future<void> sendPaymentDataReceivedInvoiceBatch(List<Map<String, dynamic>> data) async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await btcReceiveRef.doc(Auth().currentUser!.uid).collection('lnbc').get();
    List<Map<String, dynamic>> allData = snapshot.docs.map((doc) => doc.data()).toList();
    compute((data) {
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
      return newTransactions;
    }, allData)
        .then((data) {
      WriteBatch batch = FirebaseFirestore.instance.batch();
      for (int i = 0; i < data.length; i++) {
        batch.set(btcReceiveRef.doc(Auth().currentUser!.uid).collection('lnbc').doc(), data[i].toJson());
      }
      batch.commit();
    });
  }

  List<Widget> arrangeTransactions(List<TransactionItem> combinedTransactions) {
    Map<String, List<TransactionItem>> categorizedTransactions = {
      'This Week': [],
      'Last Week': [],
      'This Month': [],
    };

    List<Widget> finalTransactions = List.empty(growable: true);

    DateTime now = DateTime.now();
    DateTime startOfThisWeek = now.subtract(Duration(days: now.weekday - 1));
    DateTime startOfLastWeek = startOfThisWeek.subtract(const Duration(days: 7));
    DateTime startOfThisMonth = DateTime(now.year, now.month, 1);

    for (TransactionItem item in combinedTransactions) {
      DateTime date = DateTime.fromMillisecondsSinceEpoch(item.data.timestamp * 1000);

      if (date.isAfter(startOfThisMonth)) {
        String timeTag = displayTimeAgoFromInt(item.data.timestamp);
        categorizedTransactions.putIfAbsent(timeTag, () => []).add(item);
      } else if (date.year == now.year) {
        String monthName = DateFormat('MMMM').format(date);
        String key = monthName;
        categorizedTransactions.putIfAbsent(key, () => []).add(item);
      } else {
        String yearMonth = '${date.year}, ${DateFormat('MMMM').format(date)}';
        categorizedTransactions.putIfAbsent(yearMonth, () => []).add(item);
      }
    }

    categorizedTransactions.forEach((category, transactions) {
      if (transactions.isEmpty) return;

      finalTransactions.add(
        Builder(builder: (context) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppTheme.cardPadding, vertical: AppTheme.elementSpacing),
            child: Text(
              category,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          );
        }),
      );

      finalTransactions.add(TransactionContainer(transactions: transactions));
    });

    return finalTransactions;
  }

  @override
  bool get wantKeepAlive => true;
}

class TransactionContainer extends StatelessWidget {
  const TransactionContainer({
    super.key,
    required this.transactions,
  });
  final List<TransactionItem> transactions;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppTheme.cardPadding),
      child: RepaintBoundary(
        child: GlassContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...transactions.map((item) {
                return item;
              }).toList(),
            ],
          ),
        ),
      ),
    );
  }
}
