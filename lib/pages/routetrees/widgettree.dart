import 'package:flutter/material.dart';
import 'package:nexus_wallet/backbone/auth/auth.dart';
import 'package:nexus_wallet/backbone/loaders.dart';
import 'package:nexus_wallet/bottomnav.dart';
import 'package:nexus_wallet/models/userwallet.dart';
import 'package:nexus_wallet/pages/routetrees/authtree.dart';
import 'package:provider/provider.dart';

class WidgetTree extends StatefulWidget {
  const WidgetTree({Key? key}) : super(key: key);

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  @override
  Widget build(BuildContext context) {
    //hier schon das erste mal aufrufen aber noch mit Fragezeichen >> daruch kann noch nicht null sein
    final userWallet = Provider.of<UserWallet?>(context);

    // if(userWallet == null) {
    //   return Container(
    //     height: MediaQuery.of(context).size.height,
    //     width: MediaQuery.of(context).size.width,
    //     child: Center(
    //       child: Text("Lade User... // Screen ersetzen"),
    //     ),
    //   );
    // }
    return StreamBuilder(
      stream: Auth().authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (userWallet == null) {
            return Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: Theme.of(context).backgroundColor,
              child: Center(
                child: dotProgress(context),
              ),
            );
          }
          return BottomNav();
        } else {
          return AuthTree();
        }
      },
    );
  }
}
