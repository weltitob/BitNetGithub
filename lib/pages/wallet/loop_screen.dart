import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/amountwidget.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/buttons/roundedbutton.dart';
import 'package:bitnet/components/items/balancecard.dart';
import 'package:bitnet/pages/wallet/wallet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class LoopScreen extends StatefulWidget {
  const LoopScreen({super.key});

  @override
  State<LoopScreen> createState() => _LoopScreenState();
}

class _LoopScreenState extends State<LoopScreen> {


  bool animate = false;

  List<Container> cards = [
    Container(
        height: AppTheme.cardPadding * 10,
        margin: EdgeInsets.symmetric(horizontal: 20.w),
        child: BalanceCardBtc(controller: WalletController())),
    Container(
        height: AppTheme.cardPadding * 10,
        margin: EdgeInsets.symmetric(horizontal: 20.w,),
        child: BalanceCardLightning(controller: WalletController())),  ];

  @override
  Widget build(BuildContext context) {
    return bitnetScaffold(
      extendBodyBehindAppBar: true,
      context: context,
      resizeToAvoidBottomInset: false,
      backgroundColor: AppTheme.colorBackground,
      appBar: bitnetAppBar(text: 'Loop Screen', context: context, onTap: (){Navigator.pop(context);},),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                AnimatedSwitcher(
                  duration: Duration(seconds: 3),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.63,
                    child: ListView.builder(
                        reverse: animate,
                        itemCount: cards.length,
                        itemBuilder: (context, index)=> Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: cards[index],
                        )),
                  ),
                ),
                Positioned(
                  left: MediaQuery.of(context).size.width/2.2,
                  top: MediaQuery.of(context).size.height/3.1,
                  child: AnimatedRotation(
                    turns: animate ? 1/2 : 3/2,
                    duration: Duration(seconds: 1),
                    child: RotatedBox(
                      quarterTurns: animate ? 1 : 3,
                      child: RoundedButtonWidget(
                          buttonType: ButtonType.transparent,
                          iconData: Icons.arrow_back,
                          onTap: (){
                            setState(() {
                              animate = !animate;
                            });
                          }
                      ),
                    ),
                  ),
                ),        ],
            ),
            AmountWidget(enabled: true, amountController: TextEditingController(text: '123'), focusNode: FocusNode(), context: context,)
          ],
        ),
      ),

    );
  }
}



