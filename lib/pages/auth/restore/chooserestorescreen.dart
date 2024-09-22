import 'package:bitnet/backbone/auth/auth.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/helper/theme/theme_builder.dart';
import 'package:bitnet/backbone/services/protocol_controller.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/appstandards/optioncontainer.dart';
import 'package:bitnet/components/buttons/lang_picker_widget.dart';
import 'package:bitnet/components/dialogsandsheets/notificationoverlays/overlay.dart';
import 'package:bitnet/components/resultlist/users.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class ChooseRestoreScreen extends StatefulWidget {
  const ChooseRestoreScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ChooseRestoreScreen> createState() => _ChooseRestoreScreenState();
}

class _ChooseRestoreScreenState extends State<ChooseRestoreScreen> {
  late TextEditingController tokenController;
  @override
  void initState() {
    tokenController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    tokenController.dispose();
    super.dispose();
  }

  void showError() {
    showOverlay(
      context,
      L10n.of(context)!.overlayErrorOccured,
      color: AppTheme.errorColor,
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
      final screenWidth = MediaQuery.of(context).size.width;
      bool isSuperSmallScreen = constraints.maxWidth < AppTheme.isSuperSmallScreen;

      return bitnetScaffold(
        margin: isSuperSmallScreen
            ? const EdgeInsets.symmetric(horizontal: 0)
            : EdgeInsets.symmetric(horizontal: (screenWidth / 2 - 250.w) < 0 ? 0 : screenWidth / 2 - 250.w),
        extendBodyBehindAppBar: true,
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: bitnetAppBar(
          text: L10n.of(context)!.restoreAccount,
          context: context,
          onTap: () {
            Navigator.pop(context);
          },
          actions: [const PopUpLangPickerWidget()],
        ),
        body: ListView(
          children: [
            SizedBox(
              height: AppTheme.cardPadding * 1.h,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppTheme.cardPadding),
              child: Text(
                L10n.of(context)!.restoreOptions,
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            const SizedBox(
              height: AppTheme.cardPadding,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                BitNetImageWithTextContainer(L10n.of(context)!.wordRecovery, () {
                  context.go('/authhome/login/word_recovery');
                }, image: "assets/images/wallet.png"),
                BitNetImageWithTextContainer(L10n.of(context)!.connectWithOtherDevices, () {
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
                BitNetImageWithTextContainer(L10n.of(context)!.socialRecovery, () {
                  context.go('/authhome/login/social_recovery');
                }, image: "assets/images/friends.png"),
                BitNetImageWithTextContainer(L10n.of(context)!.useDidPrivateKey, () {
                  context.go('/authhome/login/did_recovery');
                }, image: "assets/images/key_removed_bck.png"),
              ],
            ),
            SizedBox(
              height: AppTheme.cardPadding.h,
            ),
            TextField(
              controller: tokenController,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                BitNetImageWithTextContainer('backdoor: login token', () async {
                  final currentuser = await Auth().signInWithToken(customToken: tokenController.text);
                  WidgetsBinding.instance.addPostFrameCallback(ThemeController.of(context).loadData);
                  Get.delete<ProtocolController>();

                  context.go('/');
                }, image: "assets/images/friends.png"),
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
            const SizedBox(
              height: AppTheme.cardPadding,
            ),
          ],
        ),
        context: context,
      );
    });
  }
}
