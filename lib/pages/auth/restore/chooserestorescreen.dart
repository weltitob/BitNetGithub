import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/appstandards/optioncontainer.dart';
import 'package:bitnet/components/buttons/lang_picker_widget.dart';
import 'package:bitnet/components/dialogsandsheets/notificationoverlays/overlay.dart';
import 'package:bitnet/components/loaders/loaders.dart';
import 'package:bitnet/components/resultlist/users.dart';
import 'package:bitnet/pages/auth/restore/userslist_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:get/get.dart'; // Import GetX

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

  @override
  Widget build(BuildContext context) {
    return bitnetScaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: bitnetAppBar(
        text: L10n.of(context)!.restoreAccount,
        context: context,
        onTap: () {
          Navigator.pop(context);
          //context.go('/authhome/login');
        },
        actions: [
          // const PopUpLangPickerWidget()
        ],
      ),
      body: ListView(
        children: [
          SizedBox(
            height: AppTheme.cardPadding * 1.5.h,
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
          const SizedBox(
            height: AppTheme.cardPadding,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              BitNetImageWithTextContainer(L10n.of(context)!.wordRecovery, () {
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
            ],
          ),
          // Commented out sections
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
          // List accounts
          UsersList(),

          const SizedBox(
            height: AppTheme.cardPadding,
          ),
        ],
      ),
      context: context,
    );
  }
}
