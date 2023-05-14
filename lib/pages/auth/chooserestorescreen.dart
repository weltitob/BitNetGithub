import 'package:BitNet/backbone/helper/theme.dart';
import 'package:BitNet/components/appstandards/BitNetAppBar.dart';
import 'package:BitNet/components/appstandards/BitNetScaffold.dart';
import 'package:BitNet/components/buttons/longbutton.dart';
import 'package:BitNet/components/container/imagewithtext.dart';
import 'package:BitNet/components/dialogsandsheets/dialogs.dart';
import 'package:BitNet/components/resultlist/users.dart';
import 'package:BitNet/generated/l10n.dart';
import 'package:BitNet/pages/auth/ionloadingscreen.dart';
import 'package:flutter/material.dart';

class ChooseRestoreScreen extends StatefulWidget {
  final Function() toggleView;
  final Function() toggleGetStarted;
  final Function() toggleResetPassword;

  ChooseRestoreScreen({
    Key? key,
    required this.toggleView,
    required this.toggleGetStarted,
    required this.toggleResetPassword,
  }) : super(key: key);

  @override
  State<ChooseRestoreScreen> createState() => _ChooseRestoreScreenState();
}

class _ChooseRestoreScreenState extends State<ChooseRestoreScreen> {

  bool loading = false;

  void toggleLoading() {
    setState(() {
      if (loading == true)
        loading = false;
      else {
        loading = true;
      }
    });
  }

  void showError(){
    showErrorDialog(
        image: 'assets/images/error_character.png',
        title: "An error occured, please try again later.",
        context: context,
    );
  }

  @override
  Widget build(BuildContext context) {
    return loading ? IONLoadingScreen(
        loadingText: "Patience, please. We're validating "
            "your account on the blockchain...") : BitNetScaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
        appBar: BitNetAppBar(
            text: "Choose Restore Option",
            context: context,
            onTap: (){
          widget.toggleGetStarted();
        }),
        body: ListView(
          children: [
            SizedBox(height: AppTheme.cardPadding * 2 ,),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppTheme.cardPadding),
              child: Text(
                "Restore options",
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            SizedBox(height: AppTheme.cardPadding,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OptionContainer(context, "Word recovery", (){}, image: "assets/images/wallet.png"),
                OptionContainer(context, "Connect with other device", (){}, image: "assets/images/scan_qr_device.png"),
              ],
            ),
            SizedBox(height: AppTheme.cardPadding,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OptionContainer(context, "Social recovery", (){}, image: "assets/images/friends.png"),
                OptionContainer(context, "Use DID and Private Key", (){}, image: "assets/images/key_removed_bck.png"),
              ],
            ),
            SizedBox(height: AppTheme.cardPadding * 2,),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppTheme.cardPadding),
              child: Text(
                "Locally saved accounts",
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            //list accounts
            UsersList(loadingION: toggleLoading, showError: showError,)
          ],
        ), context: context,);
  }
}
