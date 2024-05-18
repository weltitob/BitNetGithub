import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/buttons/lang_picker_widget.dart';
import 'package:bitnet/pages/auth/mnemonicgen/mnemonic_field_widget.dart';
import 'package:bitnet/pages/auth/mnemonicgen/mnemonicgen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';


class MnemonicGenConfirm extends StatefulWidget {
  final MnemonicController mnemonicController;

  const MnemonicGenConfirm({super.key, required this.mnemonicController});
  @override
  _MnemonicGenConfirm createState() => _MnemonicGenConfirm();
}

class _MnemonicGenConfirm extends State<MnemonicGenConfirm> {
  void triggerMnemonicCheck(mCtrl, tCtrls) {
    final String mnemonic =
        tCtrls.map((controller) => controller.text).join(' ');
    mCtrl.confirmMnemonic(mnemonic);
  }

  @override
  Widget build(BuildContext context) {
    LoggerService logger = Get.find();
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      final screenWidth = MediaQuery.of(context).size.width;
      bool isSuperSmallScreen =
          constraints.maxWidth < AppTheme.isSuperSmallScreen;
      return bitnetScaffold(
        context: context,
        margin: isSuperSmallScreen
            ? EdgeInsets.symmetric(horizontal: 0)
            : EdgeInsets.symmetric(horizontal: screenWidth / 2 - 250.w),
        extendBodyBehindAppBar: true,
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: bitnetAppBar(
          text: "Confirm your mnemonic",
          context: context,
          onTap: () {
            widget.mnemonicController.changeWrittenDown();
          },
          actions: [PopUpLangPickerWidget()],
        ),
        body: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            MnemonicFieldWidget(
                mnemonicController: widget.mnemonicController,
                triggerMnemonicCheck: triggerMnemonicCheck),
            Container(
              margin: EdgeInsets.only(top: AppTheme.cardPadding.h),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? AppTheme.white60
                      : AppTheme.black60,
                  width: 2,
                ),
                borderRadius: AppTheme.cardRadiusCircular,
              ),
              child: SizedBox(
                height: 0,
                width: 65.w,
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                  top: AppTheme.cardPadding.h, bottom: AppTheme.cardPadding.h),
              child: GestureDetector(
                onTap: () {
                  logger.i("Skip at own risk pressed");
                  //context.go("/pinverification");
                  widget.mnemonicController.signUp();
                },
                child: Text(
                  "Skip at own risk",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ),
            SizedBox(height: 30.h)
          ]),
        ),
      );
    });
  }
}
