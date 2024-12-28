import 'dart:async';
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
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class Transactions extends StatefulWidget {
  final bool fullList;
  final ScrollController scrollController;
  final List<dynamic>? newData;

  // Filter & Custom-Transactions
  final bool hideOnchain;
  final bool hideLightning;
  final List<String>? filters;
  final List<TransactionItem>? customTransactions;

  const Transactions({
    Key? key,
    this.fullList = false,
    required this.scrollController,
    this.newData,
    this.hideOnchain = false,
    this.hideLightning = false,
    this.filters,
    this.customTransactions,
  }) : super(key: key);

  @override
  State<Transactions> createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions>
    with AutomaticKeepAliveClientMixin {
  final walletController = Get.find<WalletsController>();
  final logger = Get.find<LoggerService>();

  // (Neu) Filter-Controller & Suchfeld
  late final WalletFilterController controller;
  final TextEditingController searchCtrl = TextEditingController();

  bool transactionsLoaded = false;
  bool transactionsOrdered = false;
  bool firstInit = false;

  // Hier werden alle Transaktionen gesammelt (ungefiltert):
  List<LightningPayment> lightningPayments = [];
  List<ReceivedInvoice> lightningInvoices = [];
  List<BitcoinTransaction> onchainTransactions = [];
  List<Swap> loopOperations = []; // optional

  // UI- & Paging-States
  List<Widget> orderedTransactions = [];
  int loadedActivityItems = 4;
  bool isLoadingTransactionGroups = false;

  // Streams
  StreamSubscription<BitcoinTransaction?>? transactionStream;
  StreamSubscription<ReceivedInvoice?>? lightningStream;

  @override
  void initState() {
    super.initState();

    // (Neu) Vorherigen Filter-Controller entfernen und neu anlegen
    Get.delete<WalletFilterController>();
    controller = Get.put(WalletFilterController());

    // (Neu) Bereits mitgegebene Filter anwenden
    if (widget.filters != null) {
      for (int i = 0; i < widget.filters!.length; i++) {
        controller.toggleFilter(widget.filters![i]);
      }
    }

    logger.i("Initializing transactions (with filters).");
    widget.scrollController.addListener(_onScroll);

    // Falls du customTransactions mitgibst
    if (widget.customTransactions != null) {
      transactionsLoaded = true;
      combineAllTransactionsWithFiltering();
      return;
    }

    // War mal: "if (walletController.futuresCompleted >= 3)"
    if (walletController.futuresCompleted >= 3) {
      loadActivity();
    } else {
      walletController.futuresCompleted.listen((val) {
        if (val >= 3) {
          loadActivity();
        }
      });
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!firstInit) {
      firstInit = true;

      // Falls schon Transaktionen zwischengespeichert sind:
      if (walletController.allTransactions.isNotEmpty &&
          widget.customTransactions == null) {
        Future.microtask(() {
          final tmp = walletController.allTransactions
              .map((item) => TransactionItem(data: item,))
              .toList();
          orderedTransactions = arrangeTransactions(tmp);
          transactionsLoaded = true;
          transactionsOrdered = true;
          setState(() {});
        });
      }

      // Stream: Onchain
      transactionStream =
          walletController.subscribeToOnchainTransactions().listen((val) {
            if (val != null) {
              onchainTransactions.add(val);
              combineAllTransactionsWithFiltering();
            }
          }, onError: (error) {
            logger.e("Received error for Transactions-stream: $error");
          });

      // Stream: Lightning (Invoices)
      lightningStream = walletController.subscribeToInvoices().listen((inv) {
        if (inv != null && inv.settled == true) {
          lightningInvoices.add(inv);
          combineAllTransactionsWithFiltering();
        }
      }, onError: (error) {
        logger.e("Received error for Invoice-stream: $error");
      });
    }
  }

  @override
  void dispose() {
    lightningStream?.cancel();
    transactionStream?.cancel();
    super.dispose();
  }

  /// Startet das Laden aller Daten (Onchain, Lightning)
  void loadActivity() {
    setState(() {
      transactionsLoaded = false;
    });

    int futuresCompleted = 0;
    int errorCount = 0;
    String errorMessage = "";

    // 1) On-Chain
    getOnchainTransactions().then((success) {
      futuresCompleted++;
      if (!success) {
        errorCount++;
        errorMessage = "${L10n.of(context)!.failedToLoadOnchain}";
      }
      _checkAndDisplay(futuresCompleted, errorCount, errorMessage);
    });

    // 2) LN-Payments
    getLightningPayments().then((success) {
      futuresCompleted++;
      if (!success) {
        errorCount++;
        errorMessage = "${L10n.of(context)!.failedToLoadPayments}";
      }
      _checkAndDisplay(futuresCompleted, errorCount, errorMessage);
    });

    // 3) LN-Invoices
    getLightningInvoices().then((success) {
      futuresCompleted++;
      if (!success) {
        errorCount++;
        errorMessage = "${L10n.of(context)!.failedToLoadLightning}";
      }
      _checkAndDisplay(futuresCompleted, errorCount, errorMessage);
    });
  }

  void _checkAndDisplay(int futuresCompleted, int errorCount, String errorMsg) {
    // Passe hier an, wenn du mehr oder weniger als 3 Ladefunktionen hast
    if (futuresCompleted == 3) {
      updateDataWithNew();
      if (mounted) {
        setState(() {
          transactionsLoaded = true;
        });
        combineAllTransactionsWithFiltering();
        handlePageLoadErrors(errorCount, errorMsg, context);
      }
    }
  }

  void handlePageLoadErrors(
      int errorCount, String errorMessage, BuildContext context) {

    final overlayController = Get.find<OverlayController>();

    if (errorCount == 1) {
      overlayController.showOverlay(errorMessage, color: AppTheme.errorColor);
      logger.e("Error loading transactions: $errorMessage");
    } else if (errorCount > 1) {
      overlayController.showOverlay(L10n.of(context)!.failedToLoadCertainData,
          color: AppTheme.errorColor);
      logger.e("Multiple errors loading transactions: $errorMessage");
    }
  }

  /// Daten, die über [widget.newData] reinkommen, einpflegen
  void updateDataWithNew() {
    logger.i("Checking for newData...");
    if (widget.newData == null) return;

    for (dynamic data in widget.newData!) {
      if (data is LightningPayment) {
        logger.i("Adding new lightning payment from newData: $data");
        lightningPayments.add(data);
       }else if(data is ReceivedInvoice) {
        logger.i("Adding new ReceivedInvoice from newData: $data");
        lightningInvoices.add(data);
      } else if (data is BitcoinTransaction) {
        logger.i("Adding new onchain tx from newData: $data");
        onchainTransactions.add(data);
      }
    }
  }

  /// (Neu) Alle Transaktionen sammeln + Filterung + Search anwenden
  void combineAllTransactionsWithFiltering({bool sticky = true}) {
    Future.microtask(() {
      // 1) Alle Transaktionen (ungefiltert) sammeln
      final List<TransactionItem> combinedTransactions = [
        // On-Chain
        ...onchainTransactions.map(
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
        // Lightning-Payments (sent)
        ...lightningPayments.map(
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
        // Lightning-Invoices (received)
        ...lightningInvoices.map(
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
        // Optional: Loop
      ];

      // 2) Duplikate entfernen
      final Set<String> seenIds = {};
      final uniqueList = combinedTransactions.where((txItem) {
        if (seenIds.contains(txItem.data.txHash)) {
          return false;
        } else {
          seenIds.add(txItem.data.txHash);
          return true;
        }
      }).toList();

      // 3) Sortieren
      uniqueList.sort((a, b) => a.data.timestamp.compareTo(b.data.timestamp));
      final finalList = uniqueList.reversed.toList();

      // 4) Filter & Search anwenden (Neu)
      final filteredSearchList = applyFiltersAndSearch(finalList);

      // Optional: Globale Speicherung
      if (sticky) {
        walletController.allTransactions.value =
            filteredSearchList.map((e) => e.data).toList();
      }

      // 5) Final in Kategorien packen
      return arrangeTransactions(filteredSearchList);
    }).then((val) {
      orderedTransactions = val;
      transactionsOrdered = true;
      setState(() {});
    });
  }

  /// (Neu) Filter- & Suchlogik
  /// (Neu) Filter- & Suchlogik
  List<TransactionItem> applyFiltersAndSearch(List<TransactionItem> items) {
    // 1) Zeitfilter
    final timeFiltered = items.where((tx) {
      final ts = tx.data.timestamp;
      return ts >= controller.start && ts <= controller.end;
    }).toList();

    // 2) Suchfeld => durchsucht "receiver"
    final searchText = searchCtrl.text.trim().toLowerCase();
    final searchFiltered = timeFiltered.where((tx) {
      return tx.data.receiver.toLowerCase().contains(searchText);
    }).toList();

    // 3) Filter Onchain/Lightning
    final filterOnchain = controller.selectedFilters.contains('Onchain');
    final filterLightning = controller.selectedFilters.contains('Lightning');

    List<TransactionItem> typeFiltered = searchFiltered;
    if (filterOnchain && !filterLightning) {
      // Nur Onchain anzeigen
      typeFiltered = searchFiltered.where(
              (tx) => tx.data.type == TransactionType.onChain
      ).toList();
    } else if (!filterOnchain && filterLightning) {
      // Nur Lightning anzeigen
      typeFiltered = searchFiltered.where(
              (tx) => tx.data.type == TransactionType.lightning
      ).toList();
    }
    // Falls beide oder keine ausgewählt sind, zeigen wir alle an (onChain + lightning).
    // Möchtest du Loop oder andere Typen filtern, erweitere hier entsprechend.

    // 4) Filter "Sent/Received"
    final filterSent = controller.selectedFilters.contains('Sent');
    final filterReceived = controller.selectedFilters.contains('Received');

    // a) Beide aktiviert oder beide nicht vorhanden => alles anzeigen
    // b) Nur 'Sent' => amount fängt mit '-' an
    // c) Nur 'Received' => amount fängt mit '+' an
    if (filterSent && !filterReceived) {
      // Nur gesendete => amount fängt mit '-' an
      return typeFiltered
          .where((tx) => tx.data.amount.startsWith('-'))
          .toList();
    } else if (filterReceived && !filterSent) {
      // Nur empfangene => amount fängt mit '+' an
      return typeFiltered
          .where((tx) => tx.data.amount.startsWith('+'))
          .toList();
    } else {
      // Beide oder gar keine => alles anzeigen
      return typeFiltered;
    }
  }


  /// Wie gehabt, gruppiert nach Zeit in "Kategorien"
  List<Widget> arrangeTransactions(List<TransactionItem> combinedTransactions) {
    Map<String, List<TransactionItem>> categorizedTransactions = {};

    // Du kannst das beliebig anpassen
    categorizedTransactions['This Week'] = [];
    categorizedTransactions['Last Week'] = [];
    categorizedTransactions['This Month'] = [];

    List<Widget> finalTransactions = [];
    DateTime now = DateTime.now();
    DateTime startOfThisMonth = DateTime(now.year, now.month, 1);

    for (TransactionItem item in combinedTransactions) {
      DateTime date =
      DateTime.fromMillisecondsSinceEpoch(item.data.timestamp * 1000);

      if (date.isAfter(startOfThisMonth)) {
        String timeTag = displayTimeAgoFromInt(item.data.timestamp);
        categorizedTransactions.putIfAbsent(timeTag, () => []).add(item);
      } else {
        String yearMonth = '${date.year}, ${DateFormat('MMMM').format(date)}';
        categorizedTransactions.putIfAbsent(yearMonth, () => []).add(item);
      }
    }

    categorizedTransactions.forEach((category, transactions) {
      if (transactions.isEmpty) return;

      finalTransactions.add(
        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: AppTheme.cardPadding,
              vertical: AppTheme.elementSpacing),
          child: Text(
            category,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
      );

      finalTransactions.add(TransactionContainer(transactions: transactions));
    });

    return finalTransactions;
  }

  /// Paging/Scroll
  void _onScroll() {
    if (widget.scrollController.position.pixels ==
        widget.scrollController.position.maxScrollExtent &&
        !isLoadingTransactionGroups) {
      _loadMoreTransactionGroups();
    }
  }

  void _loadMoreTransactionGroups() async {
    if (!mounted) return;
    setState(() {
      isLoadingTransactionGroups = true;
    });

    await Future.delayed(const Duration(milliseconds: 500));

    if (mounted) {
      setState(() {
        loadedActivityItems += 4;
        isLoadingTransactionGroups = false;
      });
    }
  }

  /// Holt Onchain TX
  Future<bool> getOnchainTransactions() async {
    try {
      logger.i("Getting onchain transactions...");
      Map<String, dynamic> data = walletController.onchainTransactions;
      onchainTransactions = await Future.microtask(() {
        return BitcoinTransactionsList.fromJson(data).transactions;
      });
      logger.i("Loaded ${onchainTransactions.length} on-chain transactions.");
    } catch (e) {
      logger.e("Error loading on-chain TX: $e");
      return false;
    }
    return true;
  }

  /// Holt Lightning Payments
  Future<bool> getLightningPayments() async {
    try {
      logger.i("Getting lightning payments...");
      Map<String, dynamic> data = walletController.lightningPayments;
      lightningPayments = await compute(
            (d) => LightningPaymentsList.fromJson(d).payments,
        data,
      );
      logger.i("Loaded ${lightningPayments.length} lightning payments.");
    } catch (e) {
      logger.e("Error loading LN payments: $e");
      return false;
    }
    return true;
  }

  /// Holt Lightning Invoices
  Future<bool> getLightningInvoices() async {
    try {
      logger.i("Getting lightning invoices...");
      Map<String, dynamic> data = walletController.lightningInvoices;
      lightningInvoices = await compute((d) {
        final allInv = ReceivedInvoicesList.fromJson(d);
        return allInv.invoices.where((i) => i.settled).toList();
      }, data);
      logger.i("Loaded ${lightningInvoices.length} settled LN invoices.");
    } catch (e) {
      logger.e("Error loading LN invoices: $e");
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    if (!transactionsOrdered) {
      return SliverToBoxAdapter(
        child: Container(
          height: AppTheme.cardPadding * 10.h,
          child: dotProgress(context),
        ),
      );
    }

    if (widget.fullList) {


      // Falls "fullList" == true, alles in einem SliverToBoxAdapter
      return SliverToBoxAdapter(
        child: Column(
          children: [

            // (Neu) Search & Filter-Bar
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: AppTheme.cardPadding,
                vertical: AppTheme.elementSpacing,
              ),
              child: SearchFieldWidget(
                hintText: 'Search',
                isSearchEnabled: true,
                handleSearch: (v) {
                  searchCtrl.text = v;
                  combineAllTransactionsWithFiltering();
                },
                suffixIcon: IconButton(
                  icon: Icon(
                    FontAwesomeIcons.filter,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? AppTheme.white60
                        : AppTheme.black60,
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
                    combineAllTransactionsWithFiltering();
                    setState(() {});
                  },
                ),
              ),
            ),
            // Die kategorisierten Transaktionen
            ...orderedTransactions,
          ],
        ),
      );
    } else {
      // Ansonsten im SliverList
      if(orderedTransactions.length == 0) {
        return SliverToBoxAdapter(
          child: Column(
            children: [
              //image


              //text that user doesnt have any transactions yet
              Container(
                  height: AppTheme.cardPadding * 4,
                  child: Center(child: Text("No activity to display")))

            ],
          ),
        );
      }

      return SliverList(
        delegate: SliverChildBuilderDelegate(
              (ctx, index) {
            if (index == 0) {
              // (Neu) Erster Eintrag = Search-Bar + Filter-Button
              return Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: AppTheme.cardPadding,
                  vertical: AppTheme.elementSpacing,
                ),
                child: SearchFieldWidget(
                  hintText: 'Search',
                  isSearchEnabled: true,
                  handleSearch: (v) {
                    searchCtrl.text = v;
                    combineAllTransactionsWithFiltering();
                  },
                  suffixIcon: IconButton(
                    icon: Icon(
                      FontAwesomeIcons.filter,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? AppTheme.white60
                          : AppTheme.black60,
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
                      combineAllTransactionsWithFiltering();
                      setState(() {});
                    },
                  ),
                ),
              );
            }

            final contentIndex = index - 1;
            if (contentIndex < orderedTransactions.length) {
              return orderedTransactions[contentIndex];
            } else {
              return const SizedBox.shrink();
            }
          },
          childCount: orderedTransactions.length + 1,
        ),
      );
    }
  }

  @override
  bool get wantKeepAlive => true;
}

class TransactionContainer extends StatelessWidget {
  final List<TransactionItem> transactions;
  const TransactionContainer({
    Key? key,
    required this.transactions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppTheme.cardPadding),
      child: Column(
        children: [
          GlassContainer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: transactions,
            ),
          ),
          SizedBox(height: AppTheme.cardPadding * 1.h),
        ],
      ),
    );
  }
}
