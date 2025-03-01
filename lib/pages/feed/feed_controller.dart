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
import 'package:shared_preferences/shared_preferences.dart';

class FeedController extends GetxController
    with GetSingleTickerProviderStateMixin {
  QuerySnapshot? searchResultsFuture;
  List<UserSearchResult> searchresults = [];
  List<UserSearchResult> searchresultsMain = [];
  UserSearchResult? searchResult;
  handleSearchPeople(String query) async {
    try {
      QuerySnapshot users = await usersCollection.get();
      searchResultsFuture = users;
      searchResultsFuture!.docs.forEach(
        (doc) {
          UserData user = UserData.fromDocument(doc);
          searchResult = UserSearchResult(
            onTap: () async {},
            userData: user,
          );
          searchresults.add(searchResult!);
          searchresultsMain = searchresults;
        },
      );
      update();
    } catch (e) {
      searchResultsFuture = null;
      update();
      print("Error searching for user: $e");
    }
  }

  handleSearch(String query, BuildContext context) async {
    try {
      final controllerTransaction = Get.find<TransactionController>();
      final homeController = Get.find<HomeController>();
      if (query.isNotEmpty &&
          tabController!.index == 0 &&
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
      if (query.isNotEmpty &&
          tabController!.index == 0 &&
          containsSixIntegers(query)) {
        homeController.blockHeight = int.parse(query);
        context.push('/wallet/bitcoinscreen/mempool');
      }
      if (query.isNotEmpty &&
          tabController!.index == 0 &&
          isValidBitcoinAddressHash(query)) {
        controllerTransaction.getAddressComponent(query);
        controllerTransaction.addressId = query;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const AddressComponent(),
          ),
        );
      }
      if (tabController!.index == 2) {
        searchresults = searchresultsMain;
        update();
      }
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
    WalletCategory(
      'assets/images/friends.png',
      'People',
      'People',
    ),
    WalletCategory(
      'assets/images/bitcoin.png',
      'Blockchain',
      'Blockchain',
    ),
  ];

  TabController? tabController;
  Rx<ScrollController>? scrollController;
  late final ScrollController scrollControllerColumn;
  RxBool fixedScroll = false.obs;

  @override
  void onInit() {
    super.onInit();
    handleSearchPeople('');
    tabController = TabController(length: 4, vsync: this);
    scrollControllerColumn = ScrollController();
    scrollController?.value = ScrollController();
    scrollController?.value.addListener(scrollListener);
    tabController?.addListener(smoothScrollToTop);
    getData();
  }

  @override
  void dispose() {
    super.dispose();
    scrollControllerColumn.dispose();
    tabController?.dispose();
    scrollController?.value.dispose();
  }

  scrollListener() {
    if (fixedScroll.value) {
      scrollController?.value.jumpTo(0);
    }
  }

  smoothScrollToTop() {
    scrollController?.value.animateTo(
      0,
      duration: const Duration(microseconds: 300),
      curve: Curves.ease,
    );
    fixedScroll.value = tabController?.index == 0;
  }

  Future<void> initNFC(BuildContext context) async {
    bool isAvailable = await NfcManager.instance.isAvailable();
    if (isAvailable) {
      // Start Session
      NfcManager.instance.startSession(
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