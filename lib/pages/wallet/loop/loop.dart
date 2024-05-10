 
import 'package:bitnet/pages/wallet/loop/loop_view.dart';
import 'package:flutter/material.dart';

class Loop extends StatelessWidget {
  const Loop({super.key});
 

  // List<Container> cards = [
  //   Container(
  //     height: AppTheme.cardPadding * 8,
  //     margin: EdgeInsets.symmetric(
  //       horizontal: AppTheme.cardPadding,
  //     ),
  //     child: BalanceCardBtc(),
  //   ),
  //   Container(
  //     height: AppTheme.cardPadding * 8,
  //     margin: EdgeInsets.symmetric(
  //       horizontal: AppTheme.cardPadding,
  //     ),
  //     child: BalanceCardLightning(),
  //   ),
  // ];


  @override
  Widget build(BuildContext context) {
    return LoopScreen();
  }
}
