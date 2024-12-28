import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/appstandards/BitNetWebsiteAppBar.dart';
import 'package:bitnet/components/appstandards/mydivider.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/container/imagewithtext.dart';
import 'package:bitnet/components/dialogsandsheets/notificationoverlays/overlay.dart';
import 'package:bitnet/models/website/issuereport.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:bitnet/backbone/auth/auth.dart';
import 'package:bitnet/backbone/helper/databaserefs.dart';
import 'package:bitnet/models/user/userwallet.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';


class ReportIssueScreen extends StatefulWidget {
  const ReportIssueScreen({Key? key}) : super(key: key);

  @override
  State<ReportIssueScreen> createState() => _ReportIssueScreenState();
}

class _ReportIssueScreenState extends State<ReportIssueScreen> {
  TextEditingController issueController = TextEditingController();
  final User? user = Auth().currentUser;

  final overlayController = Get.find<OverlayController>();


  void sendIssue() async {
    if (issueController.text.isNotEmpty) {
      issueController.text = "";
      String uid = user!.uid;
      String mail = user!.email ?? "";
      final issuereport = IssueReport(
          useremail: mail, issue: issueController.text);
      // Push issuereport object to Firebase Realtime Database
      await issueCollection.doc(uid).set(issuereport.toMap());
      overlayController.showOverlay(context, L10n.of(context)!.yourErrorReportForwarded);
      Navigator.of(context).pop();
    } else {
      overlayController.showOverlay(context, L10n.of(context)!.pleaseProvideErrorMsg);
    }
  }

  @override void dispose() {
    issueController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final UserWallet userWallet = Provider.of<UserWallet>(context);

    return bitnetScaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: AppTheme.colorBackground,
      appBar: const bitnetWebsiteAppBar(),
      body: Container(
        padding: const EdgeInsets.only(top: AppTheme.cardPadding * 2),
        child: ListView(
          padding: const EdgeInsets.symmetric(
              horizontal: AppTheme.cardPadding, vertical: AppTheme.cardPadding),
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Icon(
                  Icons.email_outlined,
                  color: Colors.white,
                ),
                const SizedBox(
                  width: AppTheme.elementSpacing / 2,
                ),
                Text(
                  L10n.of(context)!.reportError,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ],
            ),
            MyDivider(),
            const SizedBox(
              height: AppTheme.cardPadding,
            ),
            Container(
              width: AppTheme.cardPadding * 11.5,
              child: GlassContainer(
                borderThickness: 1.5, // remove border if not active
                blur: 50,
                opacity: 0.1,
                borderRadius: AppTheme.cardRadiusMid,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppTheme.elementSpacing * 1.5),
                  height: AppTheme.cardPadding * 11,
                  alignment: Alignment.topLeft,
                  child: TextField(
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    controller: issueController,
                    autofocus: false,
                    onSubmitted: (text) {
                      setState(() {
                        sendIssue();
                      });
                      ;
                    },
                    style: Theme.of(context).textTheme.bodyMedium,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      counterText: "",
                      hintText:
                          L10n.of(context)!.pleaseLetUsKnow,
                      hintStyle: TextStyle(color: AppTheme.white60),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: AppTheme.cardPadding,
            ),
            Center(
              child:
              LongButtonWidget(
                buttonType: ButtonType.transparent,
                title: L10n.of(context)!.reportWeb,
                leadingIcon: Icon(
                  Icons.send,
                  size: AppTheme.cardPadding,
                  color: AppTheme.white90,
                ),
                  onTap: () => sendIssue(),
              ),
            ),
          ],
        ),
      ), context: context,
    );
  }
}
