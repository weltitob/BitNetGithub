import 'package:bitnet/backbone/auth/auth.dart';
import 'package:bitnet/backbone/cloudfunctions/load_btc_addresses.dart';
import 'package:bitnet/backbone/helper/databaserefs.dart';
import 'package:bitnet/backbone/helper/theme/theme_builder.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:bitnet/backbone/streams/card_provider.dart';
import 'package:bitnet/backbone/streams/locale_provider.dart';
import 'package:bitnet/pages/wallet/controllers/wallet_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_keyboard_size/flutter_keyboard_size.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:bitnet/pages/comingsoonpage.dart';
import 'package:bitnet/pages/wallet/wallet.dart';

class BottomNavController extends GetxController {
  // Der aktuelle Index des selektierten Tabs
  var selectedIndex = 0.obs;
  late String profileId;

  // Die List von Widgets, die mit den jeweiligen Tabs angezeigt werden
  final List<Widget> navItems = <Widget>[
    ComingSoonPage(),
    const Wallet(),
    ComingSoonPage(),
    // const Profile(),
  ];

  // Setzt den selektierten Index und führt die Navigation durch
  void onTabTapped(int index, ScrollController controller) {
    if (index == selectedIndex.value) {
      controller.animateTo(0,
          duration: const Duration(milliseconds: 200), curve: Curves.easeInOut);
    } else {
      selectedIndex.value = index;
    }
  }

  @override
  void onInit() {
    super.onInit();
    // Du kannst hier auch eine Initialisierung vornehmen, falls nötig.
  }

  void initUser(BuildContext context) async {
    profileId = Auth().currentUser!.uid;
    loadData(context);
    loadAddresses();

    //setupAnimationControllers();
  }

  // void setupAnimationControllers() {
  //   final navItems = getNavItems();
  //   navItems.forEach((item) {
  //     animationControllers[item['route']] ??= AnimationController(
  //       duration: const Duration(milliseconds: 300),
  //       vsync: this,
  //       lowerBound: 0.8,
  //       upperBound: 1.2,
  //     );
  //   });
  // }

  List<Map<String, dynamic>> getNavItems() {
    return [
      {'icon': FontAwesomeIcons.fire, 'route': '/comingsoon'},
      // {'icon': FontAwesomeIcons.fire, 'route': '/feed'},
      // {'icon': FontAwesomeIcons.rocketchat, 'route': '/rooms'},
      // {'icon': FontAwesomeIcons.upload, 'route': '/create'},
      {'icon': FontAwesomeIcons.wallet, 'route': '/wallet'},
      // {'icon': FontAwesomeIcons.userAstronaut, 'route': '/profile/$profileId'},
      {'icon': FontAwesomeIcons.userAstronaut, 'route': '/comingsoon'},
    ];
  }

  void loadAddresses() async {
    AggregateQuery count = FirebaseFirestore.instance
        .collection('addresses_cache')
        .where(FieldPath.documentId, isEqualTo: Auth().currentUser!.uid)
        .count();
    bool shouldLoad = !(((await count.get()).count ?? 0) >= 1);
    if (shouldLoad) {
      loadBtcAddresses(Auth().currentUser!.uid);
    }
  }

  void loadData(BuildContext context) async {
    if (!Get.isRegistered<WalletsController>()) {
      Get.put(WalletsController());
    }
    final logger = Get.find<LoggerService>();
    QuerySnapshot querySnapshot = await settingsCollection.get();
    final allData = querySnapshot.docs.map((doc) => doc.id).toList();
    logger.i("All Data: $allData");

    if (allData.contains(FirebaseAuth.instance.currentUser?.uid)) {
      var data = await settingsCollection
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .get();

      // Jetzt kannst du den `context` verwenden:
      ThemeController.of(context).setThemeMode(ThemeMode.values
              .singleWhereOrNull(
                  (value) => value.name == data.data()?['theme_mode']) ??
          ThemeMode.system);
      ThemeController.of(context)
          .setPrimaryColor(Color(data.data()?['primary_color']), false);
      final locale = Locale.fromSubtags(languageCode: data.data()?['lang']);
      Provider.of<LocalProvider>(context, listen: false)
          .setLocaleInDatabase(data.data()?['lang'], locale);
      Provider.of<CardChangeProvider>(context, listen: false)
          .setCardInDatabase(data.data()?['selected_card']);

      final walletController = Get.find<WalletsController>();
      walletController.setHideBalance(
          hide: data.data()?['hide_balance'] ?? false);
    } else {
      Map<String, dynamic> data = {
        "theme_mode": "system",
        "lang": "en",
        "primary_color": Colors.white.value,
        "selected_currency": "USD",
        "selected_card": "lightning",
        "hide_balance": false
      };
      settingsCollection.doc(FirebaseAuth.instance.currentUser?.uid).set(data);
    }
  }
}
