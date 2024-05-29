import 'package:bitnet/backbone/auth/auth.dart';
import 'package:bitnet/backbone/helper/databaserefs.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/helper/theme/theme_builder.dart';
import 'package:bitnet/backbone/streams/card_provider.dart';
import 'package:bitnet/backbone/streams/locale_provider.dart';
import 'package:bitnet/components/appstandards/bottomnavgradient.dart';
import 'package:bitnet/components/container/imagewithtext.dart';
import 'package:bitnet/pages/feed/feed_controller.dart';
import 'package:bitnet/pages/feed/feedscreen.dart';
import 'package:bitnet/pages/profile/profile.dart';
import 'package:bitnet/pages/profile/profile_controller.dart';
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

int _selectedIndex = 0;

class BottomNav extends StatefulWidget {
  final GoRouterState routerState;
  const BottomNav({Key? key, required this.routerState}) : super(key: key);

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
      {'icon': FontAwesomeIcons.fire, 'route': '/feed'},
      {'icon': FontAwesomeIcons.rocketchat, 'route': '/rooms'},
      // {'icon': FontAwesomeIcons.upload, 'route': '/create'},
      {'icon': FontAwesomeIcons.wallet, 'route': '/wallet'},
      {'icon': FontAwesomeIcons.userAstronaut, 'route': '/profile/$profileId'},
    ];
  }

  void loadData() async {
    QuerySnapshot querySnapshot = await settingsCollection.get();
    final allData = querySnapshot.docs.map((doc) => doc.id).toList();
    print(allData);
    if (allData.contains(FirebaseAuth.instance.currentUser?.uid)) {
      var data = await settingsCollection
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .get();
      print(data.data());
      ThemeController.of(context).setThemeMode(ThemeMode.values
              .singleWhereOrNull(
                  (value) => value.name == data.data()?['theme_mode']) ??
          ThemeMode.system);
      ThemeController.of(context)
          .setPrimaryColor(Color(data.data()?['primary_color']));
      final locale = Locale.fromSubtags(languageCode: data.data()?['lang']);
      Provider.of<LocalProvider>(context, listen: false)
          .setLocaleInDatabase(data.data()?['lang'], locale);
      Provider.of<CardChangeProvider>(context, listen: false)
          .setCardInDatabase(data.data()?['selected_card']);
      final walletController = Get.find<WalletsController>();
      walletController.setHideBalance(
          hide: data.data()?['hide_balance'] ?? false);
      setState(() {});
    } else {
      Map<String, dynamic> data = {
        "theme_mode": "system",
        "lang": "en",
        "primary_color": 4283657726,
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

  static List<Widget> navItems = <Widget>[
    FeedScreen(),
    // CreateAsset(),
    Wallet(),
    Profile()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Get.put(
      FeedController(),
    );
    Get.put(ProfileController());
    Get.put(WalletsController());

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

    return Scaffold(
        resizeToAvoidBottomInset: false, // Add this line
        bottomNavigationBar: Container(
            color: Theme.of(context).brightness == Brightness.light
                ? lighten(Theme.of(context).colorScheme.primaryContainer, 40)
                : darken(Theme.of(context).colorScheme.primaryContainer, 70),
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
                  selectedIconTheme: IconThemeData(size: 25.sp, color: Theme.of(context).colorScheme.onPrimaryContainer,),
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
                  onTap: _onItemTapped,
                  elevation: 0, // Box-Shadow entfernen
                ),
              ),
            )),
        body: Stack(
          children: [
            Center(
              child: navItems.elementAt(_selectedIndex),
            ),
            Align(
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
      setState(() {
        String myTheme = value.get("theme");
      });
    });
  }
}
