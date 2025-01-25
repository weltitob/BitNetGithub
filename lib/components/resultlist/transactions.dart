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
import 'package:bitnet/components/resultlist/transactions_controller.dart';
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
  late final WalletFilterController filterController;
  late final TransactionsController transactionsController;
  // final transactionsController = Get.find<TransactionsController>();

  final logger = Get.find<LoggerService>();

  // (Neu) Filter-Controller & Suchfeld

  final TextEditingController searchCtrl = TextEditingController();


  bool firstInit = false;

  // // Streams
  // StreamSubscription<BitcoinTransaction?>? transactionStream;
  // StreamSubscription<ReceivedInvoice?>? lightningStream;
  // StreamSubscription<ReceivedInvoice?>? paymentStream;

  @override
  void initState() {
    super.initState();

    // (Neu) Vorherigen Filter-Controller entfernen und neu anlegen
    Get.delete<TransactionsController>();
    Get.delete<WalletFilterController>();

    filterController = Get.put(WalletFilterController());
    transactionsController = Get.put(TransactionsController());

    // (Neu) Bereits mitgegebene Filter anwenden
    if (widget.filters != null) {
      for (int i = 0; i < widget.filters!.length; i++) {
        filterController.toggleFilter(widget.filters![i]);
      }
    }

    logger.i("Initializing transactions (with filters).");
    widget.scrollController.addListener(_onScroll);

    // Falls du customTransactions mitgibst
    if (widget.customTransactions != null) {
      combineAllTransactionsWithFiltering();
      return;
    }

    // War mal: "if (walletController.futuresCompleted >= 3)"
    if (walletController.futuresCompleted >= 3) {
      _checkAndDisplay();
    } else {
      walletController.futuresCompleted.listen((val) {
        if (val >= 3) {
          _checkAndDisplay();
        }
      });
    }

    //Onchain checking for transactions
    Get.find<WalletsController>().subscribeToOnchainTransactions().listen(
            (val) {
          logger.i("subscribeTransactionsStream got data in transactions.dart: $val");
          _checkAndDisplayAdditional();

        }, onError: (error) {
      logger.e("Received error for Transactions-stream: $error");
    });

    //Lightning payments
    Get.find<WalletsController>().subscribeToInvoices().listen((inv) {
      logger.i("Received data from Invoice-stream in transactions.dart: $inv");
      _checkAndDisplayAdditional();


    }, onError: (error) {
      logger.e("Received error for Invoice-stream: $error");
    });

    Get.find<WalletsController>().subscribeToLightningPayments().listen((inv) {
      logger.i("Received Payment data from Invoice-stream in transactions.dart: $inv");
      _checkAndDisplayAdditional();

    }, onError: (error) {
      logger.e("Received error for Invoice-stream: $error");
    });

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
          transactionsController.orderedTransactions.value = arrangeTransactions(tmp);
          transactionsController.transactionsOrdered.value = true;
          // setState(() {});
        });
      }
    }
  }

  @override
  void dispose() {
    // lightningStream?.cancel();
    // transactionStream?.cancel();
    super.dispose();
  }

  void _checkAndDisplayAdditional() {
// Passe hier an, wenn du mehr oder weniger als 3 Ladefunktionen hast
    if(walletController.additionalTransactionsLoaded.value) {
      logger.i("Loading all additional transactions...");
      combineAllTransactionsWithFiltering();
    } else {
      logger.i("Transactions not loaded yet. Waiting...");
      walletController.additionalTransactionsLoaded.listen((loaded) {
        if (loaded) {
          logger.i("Loading all additional transactions...");
          combineAllTransactionsWithFiltering();
        }
      });
    }
  }

  void _checkAndDisplay() {
    // Passe hier an, wenn du mehr oder weniger als 3 Ladefunktionen hast
    if(walletController.transactionsLoaded.value) {
      logger.i("Loading all transactions...");
      combineAllTransactionsWithFiltering();

    } else {
      logger.i("Transactions not loaded yet. Waiting...");
      walletController.transactionsLoaded.listen((loaded) {
        if (loaded) {
          logger.i("Loading all transactions...");
          combineAllTransactionsWithFiltering();

        }
      });
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
  // void updateDataWithNew() {
  //   logger.i("Checking for newData...");
  //   if (widget.newData == null) return;
  //
  //   for (dynamic data in widget.newData!) {
  //     if (data is LightningPayment) {
  //       logger.i("Adding new lightning payment from newData: $data");
  //       lightningPayments.add(data);
  //      }else if(data is ReceivedInvoice) {
  //       logger.i("Adding new ReceivedInvoice from newData: $data");
  //       lightningInvoices.add(data);
  //     } else if (data is BitcoinTransaction) {
  //       logger.i("Adding new onchain tx from newData: $data");
  //       onchainTransactions.add(data);
  //     }
  //   }
  // }

  /// (Neu) Alle Transaktionen sammeln + Filterung + Search anwenden
  void combineAllTransactionsWithFiltering({bool sticky = true}) {
    Future.microtask(() {

      logger.i("Combining all transactions with filtering...");
      // 1) Alle Transaktionen (ungefiltert) sammeln
      final List<TransactionItem> combinedTransactions = walletController.allTransactionItems;
      //We need to check if the list actually got longer

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
      transactionsController.orderedTransactions.value = val;
      transactionsController.transactionsOrdered.value = true;
      // setState(() {});
    });
  }

  /// (Neu) Filter- & Suchlogik
  List<TransactionItem> applyFiltersAndSearch(List<TransactionItem> items) {
    // 1) Zeitfilter
    final timeFiltered = items.where((tx) {
      final ts = tx.data.timestamp;
      return ts >= filterController.start && ts <= filterController.end;
    }).toList();

    // 2) Suchfeld => durchsucht "receiver"
    final searchText = searchCtrl.text.trim().toLowerCase();
    final searchFiltered = timeFiltered.where((tx) {
      return tx.data.receiver.toLowerCase().contains(searchText);
    }).toList();

    // 3) Filter Onchain/Lightning
    final filterOnchain = filterController.selectedFilters.contains('Onchain');
    final filterLightning = filterController.selectedFilters.contains('Lightning');

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
    final filterSent = filterController.selectedFilters.contains('Sent');
    final filterReceived = filterController.selectedFilters.contains('Received');

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
            style: Theme.of(Get.context!).textTheme.titleSmall,
          ),
        ),
      );
      //transactions: transactions
      finalTransactions.add(TransactionContainer(transactions: transactions));
    });

    return finalTransactions;
  }

  /// Paging/Scroll
  void _onScroll() {
    if (widget.scrollController.position.pixels ==
        widget.scrollController.position.maxScrollExtent &&
        !transactionsController.isLoadingTransactionGroups.value) {
      _loadMoreTransactionGroups();
    }
  }

  void _loadMoreTransactionGroups() async {

    transactionsController.isLoadingTransactionGroups.value = true;


    await Future.delayed(const Duration(milliseconds: 500));

    transactionsController.loadedActivityItems.value += 4;
    transactionsController.isLoadingTransactionGroups.value = false;

  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Obx(() {
      // Check if transactions are ordered/loading
      if (!transactionsController.transactionsOrdered.value) {
        return SliverToBoxAdapter(
          child: Container(
            height: AppTheme.cardPadding * 10.h,
            child: dotProgress(context),
          ),
        );
      }

      // If fullList is true, display all transactions in a SliverToBoxAdapter
      if (widget.fullList) {
        return SliverToBoxAdapter(
          child: Column(
            children: [
              // Search & Filter Bar
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: AppTheme.cardPadding,
                  vertical: AppTheme.elementSpacing,
                ),
                child: SearchFieldWidget(
                  hintText: 'Search',
                  isSearchEnabled: true,
                  // controller: searchCtrl,
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
                    },
                  ),
                ),
              ),
              // Categorized Transactions
              ...transactionsController.orderedTransactions,
            ],
          ),
        );
      } else {
        // If not fullList, display transactions in a SliverList
        if (transactionsController.orderedTransactions.isEmpty) {
          return SliverToBoxAdapter(
            child: Column(
              children: [
                // You can add an image here if desired
                // Image.asset('path_to_image'),

                // Text indicating no transactions
                Container(
                  height: AppTheme.cardPadding * 4,
                  child: Center(
                    child: Text(
                      "No activity to display",
                      style: Theme.of(Get.context!).textTheme.bodyMedium,
                    ),
                  ),
                ),
              ],
            ),
          );
        }

        return SliverList(
          delegate: SliverChildBuilderDelegate(
                (ctx, index) {
              if (index == 0) {
                // First entry: Search-Bar + Filter-Button
                return Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: AppTheme.cardPadding,
                    vertical: AppTheme.elementSpacing,
                  ),
                  child: SearchFieldWidget(
                    hintText: 'Search',
                    isSearchEnabled: true,
                    // controller: searchCtrl,
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
                      },
                    ),
                  ),
                );
              }

              final contentIndex = index - 1;
              if (contentIndex < transactionsController.orderedTransactions.length) {
                return transactionsController.orderedTransactions[contentIndex];
              } else {
                return const SizedBox.shrink();
              }
            },
            childCount: transactionsController.orderedTransactions.length + 1,
          ),
        );
      }
    });
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
          SizedBox(height: AppTheme.cardPadding * 0.5.h),
        ],
      ),
    );
  }
}
