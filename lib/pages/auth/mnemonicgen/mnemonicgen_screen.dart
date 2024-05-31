import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/buttons/lang_picker_widget.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/fields/textfield/formtextfield.dart';
import 'package:bitnet/pages/auth/mnemonicgen/mnemonicgen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:flutter_gen/gen_l10n/l10n.dart';

class MnemonicGenScreen extends StatelessWidget {
  final MnemonicController mnemonicController;

  MnemonicGenScreen({
    super.key,
    required this.mnemonicController,
  });

  @override
  Widget build(BuildContext context) {
    return bitnetScaffold(
      extendBodyBehindAppBar: true,
      context: context,
      appBar: bitnetAppBar(
        text: L10n.of(context)!.yourPassowrdBackup,
        context: context,
        actions: [PopUpLangPickerWidget()],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: AppTheme.cardPadding * 5.h,
            ),
            Icon(
              FontAwesomeIcons.key,
              size: AppTheme.cardPadding * 2.h,
            ),
            SizedBox(
              height: AppTheme.cardPadding * 2.h,
            ),
            Text(
              L10n.of(context)!.saveYourmnemonicSecurely,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            SizedBox(
              height: AppTheme.cardPadding.h,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: AppTheme.cardPadding.w),
              child: Text(
                L10n.of(context)!.saveYourmnemonicSecurelyDescription,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            SizedBox(
              height: AppTheme.cardPadding,
            ),
            Container(
              width: AppTheme.cardPadding * 14.w,
              child: FormTextField(
                readOnly: true, // This makes the text field read-only
                isMultiline: true,
                controller: mnemonicController.mnemonicTextController,
                //height: AppTheme.cardPadding * 8,
                //width: AppTheme.cardPadding * 10,
                hintText: '',
              ),
            ),
            SizedBox(
              height: AppTheme.cardPadding * 1.h,
            ),
            LongButtonWidget(
                customWidth: AppTheme.cardPadding * 14.w,
                title: L10n.of(context)!.continues,
                onTap: () {
                  mnemonicController.changeWrittenDown();
                }),
          ],
        ),
      ),
    );
  }
}
