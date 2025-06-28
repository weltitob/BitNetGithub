import 'package:bitnet/backbone/helper/databaserefs.dart';
import 'package:bitnet/backbone/helper/helpers.dart';
import 'package:bitnet/components/items/usersearchresult.dart';
import 'package:bitnet/models/user/userdata.dart';
import 'package:bitnet/pages/feed/feedscreen.dart';
import 'package:bitnet/pages/qrscanner/qrscanner.dart';
import 'package:bitnet/pages/secondpages/mempool/controller/home_controller.dart';
import 'package:bitnet/pages/transactions/controller/transaction_controller.dart';
import 'package:bitnet/pages/transactions/view/address_component.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:nfc_manager_ndef/nfc_manager_ndef.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FeedController extends GetxController
    with GetSingleTickerProviderStateMixin {
  // Observable properties for reactive UI updates
  RxInt currentTabIndex = 0.obs;
  RxBool isLoading = false.obs;
  RxBool isSearching = false.obs;
  RxString searchQuery = ''.obs;

  // Cached data
  QuerySnapshot? searchResultsFuture;
  RxList<UserSearchResult> searchresults = <UserSearchResult>[].obs;
  List<UserSearchResult> searchresultsMain = [];

  // Filter search results without rebuilding entire widget tree
  void filterSearchResults(String query) {
    searchQuery.value = query.toLowerCase();
    if (query.isEmpty) {
      searchresults.value = List.from(searchresultsMain);
    } else {
      searchresults.value = searchresultsMain
          .where((result) => result.userData.username
              .toLowerCase()
              .contains(query.toLowerCase()))
          .toList();
    }
  }

  // Optimized search people with proper loading states
  Future<void> handleSearchPeople(String query) async {
    if (searchresultsMain.isNotEmpty && query.isEmpty) {
      // Use cached results if available
      searchresults.value = searchresultsMain;
      return;
    }

    try {
      isLoading.value = true;

      // Clear existing results for a fresh search
      searchresults.clear();

      // Fetch data if not already cached
      if (searchResultsFuture == null) {
        searchResultsFuture = await usersCollection.get();
      }

      // Process results
      final results = <UserSearchResult>[];
      for (var doc in searchResultsFuture!.docs) {
        UserData user = UserData.fromDocument(doc);
        results.add(UserSearchResult(
          onTap: () async {},
          userData: user,
        ));
      }

      // Store and filter results
      searchresultsMain = results;
      filterSearchResults(query);
    } catch (e) {
      searchResultsFuture = null;
      print("Error searching for user: $e");
    } finally {
      isLoading.value = false;
    }
  }

  handleSearch(String query, BuildContext context) async {
    try {
      final controllerTransaction = Get.find<TransactionController>();
      final homeController = Get.find<HomeController>();
      if (query.isNotEmpty &&
          !query.startsWith('00') &&
          isValidBitcoinTransactionID(query)) {
        controllerTransaction.txID = query.toString();
        controllerTransaction.getSingleTransaction(
          query,
        );
        controllerTransaction.changeSocket();
        context.push('/single_transaction');
      }
      if (query.isNotEmpty && query.startsWith('00')) {
        homeController.blockHeight =
            await homeController.getDataHeightHash(query);
        context.push('/wallet/bitcoinscreen/mempool');
      }
      if (query.isNotEmpty && containsSixIntegers(query)) {
        homeController.blockHeight = int.parse(query);
        context.push('/wallet/bitcoinscreen/mempool');
      }
      if (query.isNotEmpty && isValidBitcoinAddressHash(query)) {
        controllerTransaction.getAddressComponent(query);
        controllerTransaction.addressId = query;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const AddressComponent(),
          ),
        );
      }
      // People tab removed - search functionality disabled
    } catch (e) {
      searchResultsFuture = null;
      print("Error searching for user: $e");
    }
  }

  final List<Widget> myTabs = [
    const Tab(text: 'auto short'),
    const Tab(text: 'auto long'),
    const Tab(text: 'fixed'),
  ];

  final List<WalletCategory> walletcategorys = [
    WalletCategory('assets/images/bitcoin.png', "Apps", "Apps"),
    WalletCategory(
      'assets/images/paper_wallet.png',
      'Tokens',
      'Tokens',
    ),
    WalletCategory(
      'assets/images/paper_wallet.png',
      'Assets',
      'Assets',
    ),
    // Commented out People tab - can be re-enabled later
    // WalletCategory(
    //   'assets/images/friends.png',
    //   'People',
    //   'People',
    // ),
    WalletCategory(
      'assets/images/bitcoin.png',
      'Blockchain',
      'Blockchain',
    ),
  ];

  // Properly typed controllers for better performance
  TabController? tabController;
  Rx<ScrollController>? scrollController;
  late final ScrollController scrollControllerColumn;

  // Per-tab scroll position cache to maintain scroll positions
  final Map<int, double> tabScrollPositions = {};

  // Observable states
  RxBool fixedScroll = false.obs;
  RxBool isTabSwitching = false.obs;

  // Method to explicitly switch tabs that updates both the TabController and reactive state
  void switchToTab(int index) {
    if (tabController == null || index < 0 || index >= tabController!.length) {
      return;
    }

    // First update our reactive state directly
    currentTabIndex.value = index;

    // Then update the actual TabController if needed
    if (tabController!.index != index) {
      try {
        tabController!.animateTo(index);
      } catch (e) {
        print("Error animating tab: $e");
        // Fallback approach - force the tab selection
        tabController!.index = index;
      }
    }

    // Save the current scroll position before switching
    saveScrollPosition(currentTabIndex.value);
  }

  // Save tab scroll position when changing tabs
  void saveScrollPosition(int tabIndex) {
    if (scrollController?.value.hasClients == true) {
      tabScrollPositions[tabIndex] = scrollController!.value.position.pixels;
    }
  }

  // Restore scroll position when returning to a tab
  void restoreScrollPosition(int tabIndex) {
    if (scrollController?.value.hasClients == true) {
      final savedPosition = tabScrollPositions[tabIndex] ?? 0.0;
      if (savedPosition > 0) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          scrollController!.value.jumpTo(savedPosition);
        });
      }
    }
  }

  @override
  void onInit() {
    super.onInit();

    // Initialize scroll controllers first
    scrollControllerColumn = ScrollController();
    scrollController = ScrollController().obs;

    // Set up optimized scroll listeners
    if (scrollController != null) {
      scrollController!.value.addListener(_optimizedScrollListener);
    }

    // Initialize tab controller with listener for reactive updates
    tabController = TabController(length: 5, vsync: this); // Changed from 6 to 5 (removed People tab)

    // Enhanced tab controller listener with better error handling
    tabController!.addListener(() {
      if (tabController != null && tabController!.indexIsChanging == false) {
        // Only update if this is a settled index, not during animation
        int newIndex = tabController!.index;

        // Update our reactive state
        if (currentTabIndex.value != newIndex) {
          print("Tab changed to: $newIndex");
          currentTabIndex.value = newIndex;

          // Save scroll position and scroll to top
          saveScrollPosition(currentTabIndex.value);
          Future.microtask(() => smoothScrollToTop());
        }
      }
    });

    // Add a reaction to ensure tab state and controller stay in sync
    ever(currentTabIndex, (int index) {
      print("currentTabIndex changed to: $index");
      if (tabController != null && tabController!.index != index) {
        tabController!.animateTo(index);
      }
    });

    // Load initial data - lazy load for better performance
    Future.microtask(() => handleSearchPeople(''));
    Future.microtask(() => getData());
  }

  @override
  void dispose() {
    // Clean up resources properly
    scrollControllerColumn.dispose();
    tabController?.removeListener(() {});
    tabController?.dispose();
    scrollController?.value.removeListener(_optimizedScrollListener);
    scrollController?.value.dispose();
    super.dispose();
  }

  // Optimized scroll listener - only perform work when needed
  void _optimizedScrollListener() {
    if (fixedScroll.value && scrollController!.value.position.pixels > 0) {
      scrollController!.value.jumpTo(0);
    }
  }

  // Improved scroll to top with proper animation duration
  void smoothScrollToTop() {
    try {
      // More robust check to ensure the controller is properly attached
      if (scrollController?.value != null &&
          scrollController!.value.hasClients) {
        scrollController!.value.animateTo(
          0,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutCubic,
        );
      } else {
        print("ScrollController not attached yet - skipping scroll to top");
      }

      // Only fix scroll for specific tabs
      fixedScroll.value = tabController?.index == 0;

      // Make sure current tab is properly initialized
      int currentIndex = currentTabIndex.value;
      if (currentIndex >= 0 && currentIndex < walletcategorys.length) {
        // Ensure tab controllers are in sync
        if (tabController != null && tabController!.index != currentIndex) {
          tabController!.index = currentIndex;
        }
      }
    } catch (e) {
      print("Error in smoothScrollToTop: $e");
    }
  }

  Future<void> initNFC(BuildContext context) async {
    bool isAvailable = await NfcManager.instance.isAvailable();
    if (isAvailable) {
      // Start Session
      NfcManager.instance.startSession(
        pollingOptions: {
          NfcPollingOption.iso14443,
          NfcPollingOption.iso15693,
          NfcPollingOption.iso18092
        },
        onDiscovered: (NfcTag tag) async {
          var ndef = Ndef.from(tag);
          if (ndef != null) {
            if (ndef.cachedMessage != null) {
              String message = String.fromCharCodes(
                  ndef.cachedMessage!.records.first.payload);
              // print(
              //   message.substring(3, message.length),
              // );
              QRScannerController().onQRCodeScanned(
                  message.substring(3, message.length), context);
            }
          }
          // Do something with an NfcTag instance.
        },
      );
    }
  }

  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    watchlist.value = prefs.getString('watchlist').toString();
    print(watchlist);
    loading.value = false;
  }

  RxString watchlist = "".obs;
  RxBool loading = true.obs;
}
