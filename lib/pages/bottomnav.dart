import 'package:bitnet/backbone/auth/auth.dart';
import 'package:bitnet/backbone/streams/locale_provider.dart';
import 'package:bitnet/components/container/imagewithtext.dart';
import 'package:bitnet/pages/routetrees/marketplaceroutes.dart';
import 'package:flutter/material.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:vrouter/vrouter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


class BottomNav extends StatefulWidget {
  final Widget child;
  const BottomNav({Key? key, required this.child}) : super(key: key);

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  String profileId = Auth().currentUser!.uid;

  @override
  void initState() {
    getData();
    // TODO: implement initState
    super.initState();
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
      context.vRouter.to(route);
    }

    return Scaffold(
      resizeToAvoidBottomInset: false, // Add this line
      body: Stack(
        children: [
          widget.child,
          // Body content will be managed by VRouter based on the current route
          if (!context.vRouter.path.contains(kCollectionScreenRoute) &&
              !context.vRouter.path.contains(kNftProductScreenRoute))
            Stack(alignment: Alignment.bottomCenter, children: <Widget>[
              IgnorePointer(
                child: Padding(
                  padding:
                      const EdgeInsets.only(top: AppTheme.cardPadding * 30),
                  child: Container(
                    height: MediaQuery.of(context).size.height -
                        AppTheme.cardPadding * 30,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        // Use color stops to create an "exponential" effect
                        stops: [0.0, 0.2, 0.4, 0.6, 0.8, 1.0],
                        colors: [
                          Theme.of(context)
                              .colorScheme
                              .background
                              .withOpacity(0.0001),
                          Theme.of(context)
                              .colorScheme
                              .background
                              .withOpacity(0.33),
                          Theme.of(context)
                              .colorScheme
                              .background
                              .withOpacity(0.66),
                          Theme.of(context)
                              .colorScheme
                              .background
                              .withOpacity(0.99),
                          // Theme.of(context).colorScheme.background.withOpacity(0.45), //with opacity probably doesnt work because od the alpha changes we did
                          // Theme.of(context).colorScheme.background.withOpacity(0.9), //with opacity probably doesnt work because od the alpha changes we did
                          // Theme.of(context).colorScheme.background,
                          // Theme.of(context).colorScheme.background,
                          Theme.of(context).colorScheme.background,
                          Theme.of(context).colorScheme.background
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ]),
          if (!context.vRouter.path.contains(kCollectionScreenRoute) &&
              !context.vRouter.path.contains(kNftProductScreenRoute))
            Positioned(
              bottom: AppTheme.cardPadding,
              left: AppTheme.cardPadding * 1,
              right: AppTheme.cardPadding * 1,
              child: GlassContainer(
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
                                color: context.vRouter.url
                                        .contains(item['route'] as String)
                                    ? Colors.orange
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
        ],
      ),
    );
  }

  final CollectionReference _collectionRef =  FirebaseFirestore.instance.collection('settings');

  Future<void> getData() async {
    QuerySnapshot querySnapshot = await _collectionRef.get();
    final allData = querySnapshot.docs.map((doc) => doc.id).toList();
    print(allData);
    if(allData.contains(FirebaseAuth.instance.currentUser!.uid)){
      getUserTheme();
      getUserLanguage();
    }else{
      Map<String,dynamic> data = {
        "theme" : "System",
        "lang" : "en",
      };
      _collectionRef.doc(FirebaseAuth.instance.currentUser!.uid)
          .set(data);
    }
  }

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

  void getUserLanguage(){
    _collectionRef.doc(FirebaseAuth.instance.currentUser!.uid).get().then((value) {
      setState(() {
        String myLanguage = value.get("lang");
        Provider.of<LocalProvider>(context, listen: false)
            .setLocaleInDatabase(myLanguage,Locale.fromSubtags(languageCode: myLanguage));
      });
    });
  }

  // updateTheme(ThemeMode mode){
  //   Provider.of<MyThemeProvider>(context, listen: false)
  //       .updateThemeInDatabase(mode);
  // }

}
