import 'package:bitnet/backbone/auth/auth.dart';
import 'package:bitnet/backbone/helper/databaserefs.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/helper/theme/theme_builder.dart';
import 'package:bitnet/backbone/streams/card_provider.dart';
import 'package:bitnet/backbone/streams/locale_provider.dart';
import 'package:bitnet/components/container/imagewithtext.dart';
import 'package:bitnet/pages/chat_list/chat_list.dart';
import 'package:bitnet/pages/create/createasset.dart';
import 'package:bitnet/pages/feed/feed_controller.dart';
import 'package:bitnet/pages/feed/feedscreen.dart';
import 'package:bitnet/pages/profile/profile.dart';
import 'package:bitnet/pages/profile/profile_controller.dart';
import 'package:bitnet/pages/wallet/provider/balance_hide_provider.dart';
import 'package:bitnet/pages/wallet/wallet.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class BottomNav extends StatefulWidget {
  final GoRouterState routerState;
  const BottomNav({Key? key, required this.routerState})
      : super(key: key);

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
      {'icon': FontAwesomeIcons.upload, 'route': '/create'},
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
      Provider.of<BalanceHideProvider>(context, listen: false)
          .setHideBalance(hide: data.data()?['hide_balance'] ?? false);

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
    // final preferences =
    //     _sharedPreferences ??= await SharedPreferences.getInstance();
    //
    // final rawThemeMode = preferences.getString(widget.themeModeSettingsKey);
    // final rawColor = preferences.getInt(widget.primaryColorSettingsKey);
    // print('rawTheme');
    // print(rawThemeMode);
    // print(rawColor);
    // setState(() {
    //   _themeMode = ThemeMode.values
    //       .singleWhereOrNull((value) => value.name == rawThemeMode);
    //   _primaryColor = rawColor == null ? null : Color(rawColor);
    // });
  }

  @override
  void dispose() {
    animationControllers.values.forEach((controller) => controller.dispose());
    super.dispose();
  }

  int _selectedIndex = 0;

  static  List<Widget> navItems = <Widget>[
    FeedScreen(),
    ChatList(),
    CreateAsset(),
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
    Get.put(FeedController(),);
    Get.put(ProfileController());

    //final navItems = getNavItems();
    print(widget.routerState.fullPath);
    void onTabTapped(String route, dynamic item) {
      setState(() {
        animationControllers.forEach((route, controller) {
          if (item['route'] == route) {
            controller.forward();
          } else {
            controller.reverse();
          }
        });
        context.go(item['route']);
      });
      context.go(route);
    }

    return Scaffold(
      resizeToAvoidBottomInset: false, // Add this line
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
          child: GlassContainer(
            child: BottomNavigationBar(
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(FontAwesomeIcons.fire),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Icon(FontAwesomeIcons.rocketchat),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Icon(FontAwesomeIcons.upload),
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
              selectedItemColor: AppTheme.colorBitcoin,
              unselectedItemColor: AppTheme.glassMorphColorLight,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              onTap: _onItemTapped,
            ),
          ),
        ),
        body: Center(
          child: navItems.elementAt(_selectedIndex),
        )

      //   body: Stack(
      //   children: [
      //     widget.child,
      //     if (widget.routerState.fullPath != null &&
      //             (widget.routerState.fullPath == '/feed' ||
      //                 widget.routerState.fullPath == '/rooms' ||
      //                 widget.routerState.fullPath == '/create' ||
      //                 widget.routerState.fullPath == '/wallet' ||
      //                 widget.routerState.fullPath!.contains('/profile')) ||
      //         widget.routerState.fullPath != '/wallet/bitcoinscreen')
      //       IgnorePointer(
      //         child: Padding(
      //           padding: const EdgeInsets.only(top: AppTheme.cardPadding * 33),
      //           child: Container(
      //             height: MediaQuery.of(context).size.height -
      //                 AppTheme.cardPadding * 33,
      //             decoration: BoxDecoration(
      //               gradient: LinearGradient(
      //                 begin: Alignment.topCenter,
      //                 end: Alignment.bottomCenter,
      //                 // Use color stops to create an "exponential" effect
      //                 stops: [0.0, 0.2, 0.4, 0.6, 0.8, 1.0],
      //                 colors: Theme.of(context).brightness == Brightness.light
      //                     ? [
      //                         lighten(
      //                                 Theme.of(context)
      //                                     .colorScheme
      //                                     .primaryContainer,
      //                                 60)
      //                             .withOpacity(0.0001),
      //                         lighten(
      //                                 Theme.of(context)
      //                                     .colorScheme
      //                                     .primaryContainer,
      //                                 60)
      //                             .withOpacity(0.33),
      //                         lighten(
      //                                 Theme.of(context)
      //                                     .colorScheme
      //                                     .primaryContainer,
      //                                 60)
      //                             .withOpacity(0.66),
      //                         lighten(
      //                                 Theme.of(context)
      //                                     .colorScheme
      //                                     .primaryContainer,
      //                                 60)
      //                             .withOpacity(0.99),
      //                         // Theme.of(context).colorScheme.background.withOpacity(0.45), //with opacity probably doesnt work because od the alpha changes we did
      //                         // Theme.of(context).colorScheme.background.withOpacity(0.9), //with opacity probably doesnt work because od the alpha changes we did
      //                         // Theme.of(context).colorScheme.background,
      //                         // Theme.of(context).colorScheme.background,
      //                         lighten(
      //                             Theme.of(context)
      //                                 .colorScheme
      //                                 .primaryContainer,
      //                             60),
      //                         lighten(
      //                             Theme.of(context)
      //                                 .colorScheme
      //                                 .primaryContainer,
      //                             60)
      //                       ]
      //                     : [
      //                         darken(
      //                                 Theme.of(context)
      //                                     .colorScheme
      //                                     .primaryContainer,
      //                                 80)
      //                             .withOpacity(0.0001),
      //                         darken(
      //                                 Theme.of(context)
      //                                     .colorScheme
      //                                     .primaryContainer,
      //                                 80)
      //                             .withOpacity(0.33),
      //                         darken(
      //                                 Theme.of(context)
      //                                     .colorScheme
      //                                     .primaryContainer,
      //                                 80)
      //                             .withOpacity(0.66),
      //                         darken(
      //                                 Theme.of(context)
      //                                     .colorScheme
      //                                     .primaryContainer,
      //                                 80)
      //                             .withOpacity(0.99),
      //                         // Theme.of(context).colorScheme.background.withOpacity(0.45), //with opacity probably doesnt work because od the alpha changes we did
      //                         // Theme.of(context).colorScheme.background.withOpacity(0.9), //with opacity probably doesnt work because od the alpha changes we did
      //                         // Theme.of(context).colorScheme.background,
      //                         // Theme.of(context).colorScheme.background,
      //                         darken(
      //                             Theme.of(context)
      //                                 .colorScheme
      //                                 .primaryContainer,
      //                             80),
      //                         darken(
      //                             Theme.of(context)
      //                                 .colorScheme
      //                                 .primaryContainer,
      //                             80)
      //                       ],
      //               ),
      //             ),
      //           ),
      //         ),
      //       ),
      //     if (widget.routerState.fullPath != null &&
      //             (widget.routerState.fullPath == '/feed' ||
      //                 widget.routerState.fullPath == '/rooms' ||
      //                 widget.routerState.fullPath == '/create' ||
      //                 widget.routerState.fullPath == '/wallet' ||
      //                 widget.routerState.fullPath!.contains('/profile')) ||
      //         widget.routerState.fullPath != '/wallet/bitcoinscreen')
      //       Align(
      //         alignment: Alignment.bottomCenter,
      //         child: Padding(
      //           padding: EdgeInsets.only(
      //             bottom: AppTheme.cardPadding,
      //             left: AppTheme.cardPadding * 1,
      //             right: AppTheme.cardPadding * 1,
      //           ),
      //           child: GlassContainer(
      //             // borderRadius: AppTheme.cardRadiusBig,
      //             child: Container(
      //               height: AppTheme.cardPadding * 2.75,
      //               //alignment: Alignment.center,
      //               margin: EdgeInsets.only(
      //                 left: AppTheme.elementSpacing * 2,
      //                 right: AppTheme.elementSpacing * 2,
      //               ),
      //               child: Row(
      //                 crossAxisAlignment: CrossAxisAlignment.center,
      //                 // crossAxisAlignment: CrossAxisAlignment.center,
      //                 mainAxisAlignment: MainAxisAlignment.spaceAround,
      //                 children: [
      //                   for (var item in navItems)
      //                     AnimatedScale(
      //                       scale: widget.routerState.fullPath != null &&
      //                               widget.routerState.fullPath!.contains(
      //                                   (item['route'] as String).split('/')[1])
      //                           ? 1.1
      //                           : 1,
      //                       duration: const Duration(milliseconds: 300),
      //                       child: InkWell(
      //                         onTap: () =>
      //                             onTabTapped(item['route'] as String, item),
      //                         child: Icon(
      //                           item['icon'] as IconData, // <--- Here
      //                           color: widget.routerState.fullPath != null &&
      //                                   widget.routerState.fullPath!.contains(
      //                                       (item['route'] as String)
      //                                           .split('/')[1])
      //                               ? Theme.of(context)
      //                                   .colorScheme
      //                                   .onPrimaryContainer
      //                               : Theme.of(context)
      //                                   .colorScheme
      //                                   .onPrimaryContainer
      //                                   .withOpacity(0.5),
      //                           size: AppTheme.cardPadding,
      //                         ),
      //                       ),
      //                     ),
      //                 ],
      //               ),
      //             ),
      //           ),
      //         ),
      //       ),
      //   ],
      // ),
    );
  }

  final CollectionReference _collectionRef =
      FirebaseFirestore.instance.collection('settings');

  // Future<void> getData() async {
  //   QuerySnapshot querySnapshot = await _collectionRef.get();
  //   final allData = querySnapshot.docs.map((doc) => doc.id).toList();
  //   print(allData);
  //   if(allData.contains(FirebaseAuth.instance.currentUser!.uid)){
  //     getUserTheme();
  //     getUserLanguage();
  //   }else{
  //     Map<String,dynamic> data = {
  //       "theme_mode" : "System",
  //       "lang" : "en",
  //       "primary_color": "",
  //       "selected_currency":"",
  //       "selected_card":""
  //     };
  //     _collectionRef.doc(FirebaseAuth.instance.currentUser!.uid)
  //         .set(data);
  //   }
  // }

  void getUserTheme() {
    _collectionRef
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      setState(() {
        String myTheme = value.get("theme");
        // if(myTheme == "System"){
        //   updateTheme(ThemeMode.system);
        // }else if(myTheme == "Dark"){
        //   updateTheme(ThemeMode.dark);
        // }else{
        //   updateTheme(ThemeMode.light);
        // }
      });
    });
  }

// void getUserLanguage(){
//   _collectionRef.doc(FirebaseAuth.instance.currentUser!.uid).get().then((value) {
//     setState(() {
//       String myLanguage = value.get("lang");
//       Provider.of<LocalProvider>(context, listen: false)
//           .setLocaleInDatabase(myLanguage,Locale.fromSubtags(languageCode: myLanguage));
//     });
//   });
// }

// updateTheme(ThemeMode mode){
//   Provider.of<MyThemeProvider>(context, listen: false)
//       .updateThemeInDatabase(mode);
// }
}
