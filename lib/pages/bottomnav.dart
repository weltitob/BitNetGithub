import 'package:bitnet/backbone/auth/auth.dart';
import 'package:bitnet/backbone/helper/databaserefs.dart';
import 'package:bitnet/backbone/helper/theme/theme_builder.dart';
import 'package:bitnet/backbone/streams/card_provider.dart';
import 'package:bitnet/backbone/streams/locale_provider.dart';
import 'package:bitnet/components/container/imagewithtext.dart';
import 'package:bitnet/pages/routetrees/marketplaceroutes.dart';
import 'package:bitnet/pages/wallet/provider/balance_hide_provider.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BottomNav extends StatefulWidget {
  final Widget child;
  final GoRouterState routerState;
  const BottomNav({Key? key, required this.child, required this.routerState}) : super(key: key);

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  String profileId = Auth().currentUser?.uid ?? '';
  @override
  void initState() {
    loadData();
    //getData();
    // TODO: implement initState
    super.initState();
  }

  void loadData() async {
    QuerySnapshot querySnapshot = await settingsCollection.get();
    final allData = querySnapshot.docs.map((doc) => doc.id).toList();
    print('rawTheme');
    print(allData);
    if(allData.contains(FirebaseAuth.instance.currentUser?.uid)){
      var data = await settingsCollection.doc(FirebaseAuth.instance.currentUser?.uid).get();
      print(data.data());
      ThemeController.of(context).setThemeMode(ThemeMode.values
          .singleWhereOrNull((value) => value.name == data.data()?['theme_mode']) ?? ThemeMode.system);
      ThemeController.of(context).setPrimaryColor(Color(data.data()?['primary_color']));
      final locale = Locale.fromSubtags(languageCode: data.data()?['lang']);
      Provider.of<LocalProvider>(context, listen: false).setLocaleInDatabase(data.data()?['lang'], locale);
      Provider.of<CardChangeProvider>(context, listen: false).setCardInDatabase(data.data()?['selected_card']);
      Provider.of<BalanceHideProvider>(context, listen: false).setHideBalance(hide:data.data()?['hide_balance'] ?? false);

      setState(() {
      });
    }else{
      Map<String,dynamic> data = {
        "theme_mode" : "system",
        "lang" : "en",
        "primary_color": 4283657726,
        "selected_currency":"USD",
        "selected_card":"lightning",
        "hide_balance" : false
      };
      settingsCollection.doc(FirebaseAuth.instance.currentUser?.uid)
          .set(data);
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
  Widget build(BuildContext context) {
    final navItems = [
      {'icon': FontAwesomeIcons.fire, 'route': '/feed'},
      {'icon': FontAwesomeIcons.rocketchat, 'route': '/rooms'},
      {'icon': FontAwesomeIcons.upload, 'route': '/create'},
      {'icon': FontAwesomeIcons.wallet, 'route': '/wallet'},
      {'icon': FontAwesomeIcons.userAstronaut, 'route': '/profile/:$profileId'},
    ];

    void onTabTapped(String route) {
      context.go(route);
    }

    return Scaffold(
      resizeToAvoidBottomInset: false, // Add this line
      body: Stack(
        children: [
          widget.child,
          // Body content will be managed by VRouter based on the current route
          // if (!context.vRouter.path.contains(kCollectionScreenRoute) &&
          //     !context.vRouter.path.contains(kNftProductScreenRoute))
          //   Stack(alignment: Alignment.bottomCenter, children: <Widget>[
          //     IgnorePointer(
          //       child: Padding(
          //         padding:
          //             const EdgeInsets.only(top: AppTheme.cardPadding * 30),
          //         child: Container(
          //           height: MediaQuery.of(context).size.height -
          //               AppTheme.cardPadding * 30,
          //           decoration: BoxDecoration(
          //             gradient: LinearGradient(
          //               begin: Alignment.topCenter,
          //               end: Alignment.bottomCenter,
          //               // Use color stops to create an "exponential" effect
          //               stops: [0.0, 0.2, 0.4, 0.6, 0.8, 1.0],
          //               colors: [
          //                 Theme.of(context)
          //                     .colorScheme
          //                     .background
          //                     .withOpacity(0.0001),
          //                 Theme.of(context)
          //                     .colorScheme
          //                     .background
          //                     .withOpacity(0.33),
          //                 Theme.of(context)
          //                     .colorScheme
          //                     .background
          //                     .withOpacity(0.66),
          //                 Theme.of(context)
          //                     .colorScheme
          //                     .background
          //                     .withOpacity(0.99),
          //                 // Theme.of(context).colorScheme.background.withOpacity(0.45), //with opacity probably doesnt work because od the alpha changes we did
          //                 // Theme.of(context).colorScheme.background.withOpacity(0.9), //with opacity probably doesnt work because od the alpha changes we did
          //                 // Theme.of(context).colorScheme.background,
          //                 // Theme.of(context).colorScheme.background,
          //                 Theme.of(context).colorScheme.background,
          //                 Theme.of(context).colorScheme.background
          //               ],
          //             ),
          //           ),
          //         ),
          //       ),
          //     )
          //   ]),

          if (widget.routerState.fullPath!= null && (widget.routerState.fullPath == '/feed' || widget.routerState.fullPath == '/rooms' ||
              widget.routerState.fullPath == '/create' || widget.routerState.fullPath == '/wallet' || widget.routerState.fullPath!.contains('/profile')))
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(              bottom: AppTheme.cardPadding,

                  left: AppTheme.cardPadding * 1,
                  right: AppTheme.cardPadding * 1,
                ),
                child: GlassContainer(
                  child: Container(
                    height: AppTheme.cardPadding * 2.25,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: AppTheme.elementSpacing * 1.25,
                          vertical: AppTheme.elementSpacing * 1.25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          for (var item in navItems)
                            InkWell(
                              onTap: () => onTabTapped(item['route'] as String),
                              child: Column(
                                children: [
                                  Icon(
                                    item['icon'] as IconData, // <--- Here
                                    color: widget.routerState.fullPath != null && widget.routerState.fullPath!
                                        .contains(item['route'] as String)
                                        ? AppTheme.colorBitcoin
                                        : Theme.of(context).iconTheme.color?.withOpacity(0.5),
                                    size: AppTheme.cardPadding,
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  final CollectionReference _collectionRef =  FirebaseFirestore.instance.collection('settings');

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

  void getUserTheme(){
    _collectionRef.doc(FirebaseAuth.instance.currentUser!.uid).get().then((value) {
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