import 'package:bitnet/backbone/helper/databaserefs.dart';
import 'package:bitnet/pages/feed/feedscreen.dart';
import 'package:bitnet/pages/qrscanner/qrscanner.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FeedController extends GetxController
    with GetSingleTickerProviderStateMixin {
  Rx<Future<QuerySnapshot>>? searchResultsFuture;
  handleSearch(String query) {
    try {
      Future<QuerySnapshot> users = usersCollection
          .where("username", isGreaterThanOrEqualTo: query)
          .get();
      searchResultsFuture!.value = users;
      update();
    } catch (e) {
      searchResultsFuture = null;
      print("Error searching for user: $e");
    }
  }

  final List<Widget> myTabs = [
    Tab(text: 'auto short'),
    Tab(text: 'auto long'),
    Tab(text: 'fixed'),
  ];

  final List<WalletCategory> walletcategorys = [
    WalletCategory(
      'assets/images/paper_wallet.png',
      'Assets',
      'Assets',
    ),
    WalletCategory(
      'assets/images/bitcoin.png',
      'Bitcoin',
      'Bitcoin',
    ),
    WalletCategory(
      'assets/images/friends.png',
      'People',
      'People',
    ),
    WalletCategory(
      'assets/images/new_chat.png',
      'Groups',
      'Groups',
    ),
    WalletCategory(
      'assets/marketplace/ActiveHeart.png',
      'Liked',
      'Liked',
    ),
  ];

  TabController? tabController;
  Rx<ScrollController>? scrollController;
  late final ScrollController scrollControllerColumn;
  RxBool fixedScroll = false.obs;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
    scrollControllerColumn = ScrollController();
    scrollController?.value = ScrollController();
    scrollController?.value.addListener(scrollListener);
    tabController!.addListener(smoothScrollToTop);
    getData();
  }

  @override
  void dispose() {
    super.dispose();
    scrollControllerColumn.dispose();
    tabController!.dispose();
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
      duration: Duration(microseconds: 300),
      curve: Curves.ease,
    );

    fixedScroll.value = tabController!.index == 0;
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
              print(
                message.substring(3, message.length),
              );
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
