import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/appstandards/optioncontainer.dart';
import 'package:bitnet/components/buttons/lang_picker_widget.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:bitnet/components/dialogsandsheets/notificationoverlays/overlay.dart';
import 'package:bitnet/components/resultlist/users.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';

class ChooseRestoreScreen extends StatefulWidget {
  ChooseRestoreScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ChooseRestoreScreen> createState() => _ChooseRestoreScreenState();
}

class _ChooseRestoreScreenState extends State<ChooseRestoreScreen> {
  void showError() {
    showOverlay(
      context,
      L10n.of(context)!.overlayErrorOccured,
      color: AppTheme.errorColor,
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      final screenWidth = MediaQuery.of(context).size.width;
      bool isSuperSmallScreen =
          constraints.maxWidth < AppTheme.isSuperSmallScreen;

      return bitnetScaffold(
        margin: isSuperSmallScreen
            ? EdgeInsets.symmetric(horizontal: 0)
            : EdgeInsets.symmetric(horizontal: (screenWidth / 2 - 250.w) < 0 ? 0 :screenWidth / 2 - 250.w),
        extendBodyBehindAppBar: true,
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: bitnetAppBar(
          text: L10n.of(context)!.restoreAccount,
          context: context,
          onTap: () {
            Navigator.pop(context);
          },
          actions: [PopUpLangPickerWidget()],
        ),
        body: ListView(
          children: [
            SizedBox(
              height: AppTheme.cardPadding * 1.h,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: AppTheme.cardPadding),
              child: Text(
                L10n.of(context)!.restoreOptions,
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            SizedBox(
              height: AppTheme.cardPadding,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                BitNetImageWithTextContainer(L10n.of(context)!.wordRecovery,
                    () {
                  context.go('/authhome/login/word_recovery');
                }, image: "assets/images/wallet.png"),
                BitNetImageWithTextContainer(
                    L10n.of(context)!.connectWithOtherDevices, () {
                  context.go('/authhome/login/device_recovery');
                }, image: "assets/images/scan_qr_device.png"),
              ],
            ),
            SizedBox(
              height: AppTheme.cardPadding.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                BitNetImageWithTextContainer(L10n.of(context)!.socialRecovery,
                    () {
                  context.go('/authhome/login/social_recovery');
                }, image: "assets/images/friends.png"),
                BitNetImageWithTextContainer(L10n.of(context)!.useDidPrivateKey,
                    () {
                  context.go('/authhome/login/did_recovery');
                }, image: "assets/images/key_removed_bck.png"),
              ],
            ),
            SizedBox(
              height: AppTheme.cardPadding * 2.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppTheme.cardPadding.w),
              child: Text(
                L10n.of(context)!.locallySavedAccounts,
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            //list accounts
            UsersList(
              showError: showError,
            ),
            SizedBox(
              height: AppTheme.cardPadding,
            ),
          ],
        ),
        context: context,
      );
    });
  }
}
