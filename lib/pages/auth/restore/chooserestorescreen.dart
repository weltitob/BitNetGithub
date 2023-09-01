import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/bitnetAppBar.dart';
import 'package:bitnet/components/appstandards/bitnetScaffold.dart';
import 'package:bitnet/components/container/imagewithtext.dart';
import 'package:bitnet/components/dialogsandsheets/dialogs/dialogs.dart';
import 'package:bitnet/components/resultlist/users.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:vrouter/vrouter.dart';

class ChooseRestoreScreen extends StatefulWidget {
  ChooseRestoreScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ChooseRestoreScreen> createState() => _ChooseRestoreScreenState();
}

class _ChooseRestoreScreenState extends State<ChooseRestoreScreen> {
  void showError() {
    showErrorDialog(
      image: 'assets/images/error_character.png',
      title: "An error occured, please try again later.",
      context: context,
    );
  }

  @override
  Widget build(BuildContext context) {
    return bitnetScaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: bitnetAppBar(
          text: L10n.of(context)!.restoreAccount,
          context: context,
          onTap: () {
            VRouter.of(context).to('/authhome');
          }),
      body: ListView(
        children: [
          SizedBox(
            height: AppTheme.cardPadding * 1,
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: AppTheme.cardPadding),
            child: Text(
              "Restore options",
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
              OptionContainer(context, "Word recovery", () {
                VRouter.of(context).to('/word_recovery');
              }, image: "assets/images/wallet.png"),
              OptionContainer(context, "Connect with other device", () {
                VRouter.of(context).to('/device_recovery');
              }, image: "assets/images/scan_qr_device.png"),
            ],
          ),
          SizedBox(
            height: AppTheme.cardPadding,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              OptionContainer(context, "Social recovery", () {
                VRouter.of(context).to('/social_recovery');
              }, image: "assets/images/friends.png"),
              OptionContainer(context, "Use DID and Private Key", () {
                VRouter.of(context).to('/did_recovery');
              }, image: "assets/images/key_removed_bck.png"),
            ],
          ),
          SizedBox(
            height: AppTheme.cardPadding * 2,
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: AppTheme.cardPadding),
            child: Text(
              "Locally saved accounts",
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
  }
}
