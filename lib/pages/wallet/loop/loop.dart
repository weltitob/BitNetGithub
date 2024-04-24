import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/items/balancecard.dart';
import 'package:bitnet/pages/wallet/loop/loop_view.dart';
import 'package:bitnet/pages/wallet/wallet.dart';
import 'package:flutter/material.dart';

class Loop extends StatefulWidget {
  const Loop({super.key});

  @override
  State<Loop> createState() => LoopController();
}

class LoopController extends State<Loop> {

  bool animate = false;
  TextEditingController btcController = TextEditingController(text: '123');
    TextEditingController currController = TextEditingController();
    FocusNode node = FocusNode();

  List<Container> cards = [
    Container(
        height: AppTheme.cardPadding * 8,
        margin: EdgeInsets.symmetric(horizontal: AppTheme.cardPadding),
        child: BalanceCardBtc(controller: WalletController())),
    Container(
        height: AppTheme.cardPadding * 8,
        margin: EdgeInsets.symmetric(
          horizontal: AppTheme.cardPadding,
        ),
        child: BalanceCardLightning(
            controller: WalletController())),
  ];

@override
void dispose(){
  btcController.dispose();
  currController.dispose();
  node.dispose();
  super.dispose();
}

  void changeAnimate() {
    setState(() {
      animate = !animate;
    });
  }



  @override
  Widget build(BuildContext context) {
    return LoopScreen(controller: this);
  }
}
