import 'package:bitnet/backbone/auth/auth.dart';
import 'package:bitnet/backbone/cloudfunctions/load_btc_addresses.dart';
import 'package:bitnet/backbone/helper/databaserefs.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/helper/theme/theme_builder.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:bitnet/backbone/services/protocol_controller.dart';
import 'package:bitnet/backbone/streams/card_provider.dart';
import 'package:bitnet/backbone/streams/locale_provider.dart';
import 'package:bitnet/components/appstandards/bottomnavgradient.dart';
import 'package:bitnet/components/appstandards/glasscontainer.dart';
import 'package:bitnet/pages/feed/feed_controller.dart';
import 'package:bitnet/pages/feed/feedscreen.dart';
import 'package:bitnet/pages/profile/profile.dart';
import 'package:bitnet/pages/profile/profile_controller.dart';
import 'package:bitnet/pages/settings/bottomsheet/settings_controller.dart';
import 'package:bitnet/pages/wallet/controllers/wallet_controller.dart';
import 'package:bitnet/pages/wallet/wallet.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';


int _selectedIndex = 1;
final GlobalKey<_BottomNavState> bottomNavKey = GlobalKey();


class BottomNav extends StatefulWidget {
  final GoRouterState routerState;
  BottomNav({Key? key, required this.routerState}) : super(key: bottomNavKey);

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav>
    with SingleTickerProviderStateMixin {
  String? profileId;
  Map<String, AnimationController> animationControllers = {};

  @override
  void initState() {
    super.initState();
    initUser();
    loadAddresses();
  }

  void initUser() async {
    profileId = Auth().currentUser?.uid;
    loadData();
    //setupAnimationControllers();
  }

  void setupAnimationControllers() {
    final navItems = getNavItems();
    navItems.forEach((item) {
      animationControllers[item['route']] ??= AnimationController(
        duration: const Duration(milliseconds: 300),
        vsync: this,
        lowerBound: 0.8,
        upperBound: 1.2,
      );
    });
  }

  List<Map<String, dynamic>> getNavItems() {
    return [
      // {'icon': FontAwesomeIcons.fire, 'route': '/comingsoon'},
      {'icon': FontAwesomeIcons.fire, 'route': '/feed'},
      // {'icon': FontAwesomeIcons.rocketchat, 'route': '/rooms'},
      // {'icon': FontAwesomeIcons.upload, 'route': '/create'},
      {'icon': FontAwesomeIcons.wallet, 'route': '/wallet'},
      {'icon': FontAwesomeIcons.userAstronaut, 'route': '/profile/$profileId'},
      // {'icon': FontAwesomeIcons.userAstronaut, 'route': '/comingsoon'},
    ];
  }

  void loadData() async {
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
      if (mounted) {
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
      }
      final walletController = Get.find<WalletsController>();
      walletController.setHideBalance(
          hide: data.data()?['hide_balance'] ?? false);
      // Removed unnecessary setState() - no UI update needed here
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

  @override
  void dispose() {
    animationControllers.values.forEach((controller) => controller.dispose());
    super.dispose();
  }
  //
  // static List<Widget> navItems = <Widget>[FeedScreen(), const Wallet(), const Profile()];

  static List<Widget> navItems = <Widget>[
    FeedScreen(),
    const Wallet(),
    // ComingSoonPage()
    Profile()
  ];

  void onItemTapped(int index, ScrollController controller) {
    if (index == _selectedIndex) {
      // Only scroll if the controller is attached to a position
      if (controller.hasClients) {
        try {
          controller.animateTo(0,
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut);
        } catch (e) {
          print("Error scrolling in BottomNav: $e");
        }
      } else {
        print("ScrollController not attached to any scroll views in BottomNav");
      }
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Initialize Remote Config Controller and fetch data
    WalletsController walletController = Get.put(WalletsController());
    ProfileController profileController = Get.put(ProfileController());
    SettingsController settingsController = Get.put(SettingsController());
    FeedController feedController = Get.put(FeedController());

    //we need to make sure we have the user doc id
    Get.find<ProfileController>().isUserLoading.listen((val) {
      if (!val) {
        if (!Get.isRegistered<ProtocolController>()) {
          Get.put(ProtocolController(logIn: true));
        }
      }
    });

    //final navItems = getNavItems();
    // print(widget.routerState.fullPath);

    // void onTabTapped(String route, dynamic item) {
    //   setState(() {
    //     animationControllers.forEach((route, controller) {
    //       if (item['route'] == route) {
    //         controller.forward();
    //       } else {
    //         controller.reverse();
    //       }
    //     });
    //     context.go(item['route']);
    //   });
    //   context.go(route);
    // }

    // return WalletScreen();

    return Scaffold(
        resizeToAvoidBottomInset: false, // Add this line
        bottomNavigationBar: !(MediaQuery.of(context).viewInsets.bottom == 0)
            ? Container(height: 0, width: 0)
            : Container(
                color: Theme.of(context).brightness == Brightness.light
                    ? lighten(
                        Theme.of(context).colorScheme.primaryContainer, 50)
                    : darken(
                        Theme.of(context).colorScheme.primaryContainer, 80),
                padding: const EdgeInsets.only(
                    top: 3,
                    left: AppTheme.cardPadding,
                    right: AppTheme.cardPadding,
                    bottom: AppTheme.elementSpacing),
                child: GlassContainer(
                  child: Theme(
                    data: Theme.of(context).copyWith(
                      shadowColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                    ),
                    child: BottomNavigationBar(
                      enableFeedback: false,
                      selectedIconTheme: IconThemeData(
                        size: 25.sp,
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                      //fixedColor: Theme.of(context).brightness == Brightness.light ? Colors.black : Colors.green,
                      useLegacyColorScheme: false,
                      items: const <BottomNavigationBarItem>[
                        BottomNavigationBarItem(
                          icon: Icon(FontAwesomeIcons.fire),
                          label: '',
                        ),
                        BottomNavigationBarItem(
                          icon: Icon(FontAwesomeIcons.wallet),
                          label: '',
                        ),
                        BottomNavigationBarItem(
                          icon: Icon(FontAwesomeIcons.userAstronaut),
                          label: '',
                        ),
                      ],
                      type: BottomNavigationBarType.fixed,
                      backgroundColor: Colors.transparent,
                      currentIndex: _selectedIndex,
                      selectedItemColor:
                          Theme.of(context).colorScheme.onPrimaryContainer,
                      unselectedItemColor: Theme.of(context)
                          .colorScheme
                          .onPrimaryContainer
                          .withOpacity(0.5),
                      showSelectedLabels: false,
                      showUnselectedLabels: false,
                      onTap: (i) {
                        try {
                          switch (i) {
                            case 0:
                              // Safely get the controller, check if it exists first
                              final feedController = Get.isRegistered<FeedController>() 
                                  ? Get.find<FeedController>() 
                                  : null;
                              if (feedController != null) {
                                onItemTapped(i, feedController.scrollControllerColumn);
                              } else {
                                // Fallback if controller not found
                                if (_selectedIndex != i) {
                                  setState(() => _selectedIndex = i);
                                }
                              }
                            case 1:
                              // Safely get the controller with null check
                              final walletController = Get.isRegistered<WalletsController>() 
                                  ? Get.find<WalletsController>() 
                                  : null;
                              if (walletController != null) {
                                onItemTapped(i, walletController.scrollController);
                              } else {
                                setState(() => _selectedIndex = i);
                              }
                            case 2:
                              // Safely get the controller with null check
                              final profileController = Get.isRegistered<ProfileController>() 
                                  ? Get.find<ProfileController>() 
                                  : null;
                              if (profileController != null) {
                                onItemTapped(i, profileController.scrollController);
                              } else {
                                setState(() => _selectedIndex = i);
                              }
                          }
                        } catch (e) {
                          print("Error in bottom nav tap: $e");
                          // Fallback - just update the selected index
                          if (_selectedIndex != i) {
                            setState(() => _selectedIndex = i);
                          }
                        }
                      },
                      elevation: 0, // Box-Shadow entfernen
                    ),
                  ),
                )),
        body: Stack(
          children: [
            Center(
              child: navItems.elementAt(_selectedIndex),
            ),
            const Align(
              alignment: Alignment.bottomCenter,
              child: BottomNavGradient(),
            ),
          ],
        ));
  }

  final CollectionReference _collectionRef =
      FirebaseFirestore.instance.collection('settings');

  void getUserTheme() {
    _collectionRef
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      // Removed setState - myTheme is not used anywhere
      String myTheme = value.get("theme");
    });
  }
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
