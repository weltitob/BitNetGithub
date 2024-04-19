import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/fields/textfield/formtextfield.dart';
import 'package:bitnet/pages/auth/mnemonicgen/mnemonicgen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class MnemonicGenScreen extends StatelessWidget {
  MnemonicController mnemonicController;

  MnemonicGenScreen({
    super.key,
    required this.mnemonicController,
  });

  @override
  Widget build(BuildContext context) {
    return bitnetScaffold(
      context: context,
      appBar: bitnetAppBar(
        text: "Your Password & Backup",
        context: context,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: AppTheme.cardPadding * 5,),
            Icon(FontAwesomeIcons.key,
            size: AppTheme.cardPadding * 2,),
            SizedBox(height: AppTheme.cardPadding * 2,),
            Text("Save your mnemonic securely!", style: Theme.of(context).textTheme.headlineSmall,),
            SizedBox(height: AppTheme.cardPadding,),
            Container(
              margin: EdgeInsets.symmetric(horizontal: AppTheme.cardPadding),
              child: Text(
                "Save this sequence on a piece of paper it acts as your password to your account, a loss of this sequence will result in a loss of your funds.",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,),
            ),
            SizedBox(height: AppTheme.cardPadding,),
            Container(
              width: AppTheme.cardPadding * 14,
              child: FormTextField(
                readOnly: true, // This makes the text field read-only
                isMultiline: true,
                controller: mnemonicController.mnemonicTextController,
                //height: AppTheme.cardPadding * 8,
                //width: AppTheme.cardPadding * 10,
                hintText: '',
              ),
            ),
            SizedBox(height: AppTheme.cardPadding * 1,),
            LongButtonWidget(
                customWidth: AppTheme.cardPadding * 14,
                title: "Continue", onTap: (){
              mnemonicController.changeWrittenDown();
            }),
          ],
        ),
      ),

    );
  }
}
