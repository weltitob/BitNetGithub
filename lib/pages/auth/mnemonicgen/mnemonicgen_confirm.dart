import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/fields/textfield/formtextfield.dart';
import 'package:bitnet/components/indicators/smoothpageindicator.dart';
import 'package:bitnet/pages/auth/mnemonicgen/mnemonic_field_widget.dart';
import 'package:bitnet/pages/auth/mnemonicgen/mnemonicgen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:matrix/matrix.dart';

class MnemonicGenConfirm extends StatefulWidget {
  final MnemonicController mnemonicController;

  const MnemonicGenConfirm({super.key, required this.mnemonicController});
  @override
  _MnemonicGenConfirm createState() => _MnemonicGenConfirm();
}

class _MnemonicGenConfirm extends State<MnemonicGenConfirm> {



  void triggerMnemonicCheck(mCtrl, tCtrls){
    final String mnemonic = tCtrls.map((controller) => controller.text).join(' ');
    mCtrl.confirmMnemonic(mnemonic);
  }

  @override
  Widget build(BuildContext context) {
     final Size size = MediaQuery.of(context).size;
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final screenWidth = MediaQuery.of(context).size.width;
          bool isSuperSmallScreen =
              constraints.maxWidth < AppTheme.isSuperSmallScreen;
          return bitnetScaffold(
            context: context,
            margin: isSuperSmallScreen
                ? EdgeInsets.symmetric(horizontal: 0)
                : EdgeInsets.symmetric(horizontal: screenWidth / 2 - 250),
            extendBodyBehindAppBar: true,
            backgroundColor: Theme.of(context).colorScheme.background,
            appBar: bitnetAppBar(
                text: "Confirm your mnemonic",
                context: context,
                onTap: () {
                  widget.mnemonicController.changeWrittenDown();
                }),

     body: SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
       child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
       children: [MnemonicFieldWidget(mnemonicController: widget.mnemonicController, triggerMnemonicCheck: triggerMnemonicCheck),
         Container(
                        margin: EdgeInsets.only(top: AppTheme.cardPadding),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: AppTheme.white60,
                            width: 2,
                          ),
                          borderRadius: AppTheme.cardRadiusCircular,
                        ),
                        child: SizedBox(
                          height: 0,
                          width: 65,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            top: AppTheme.cardPadding,
                            bottom: AppTheme.cardPadding),
                        child: GestureDetector(
                          onTap: () {
                            Logs().w("Skip at own risk pressed");
                            //context.go("/pinverification");
                            widget.mnemonicController.signUp();
                          },
                          child: Text(
                            "Skip at own risk",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                      ),]),
     ),
          );});
  }

 

}

