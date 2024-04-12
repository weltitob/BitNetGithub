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
    return MnemonicFieldWidget(mnemonicController: MnemonicController(), triggerMnemonicCheck: triggerMnemonicCheck,);
  }

}

