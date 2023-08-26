import 'package:BitNet/components/appstandards/mydivider.dart';
import 'package:BitNet/components/container/imagewithtext.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:BitNet/backbone/auth/auth.dart';
import 'package:BitNet/backbone/helper/databaserefs.dart';
import 'package:BitNet/components/buttons/glassbutton.dart';
import 'package:BitNet/components/dialogsandsheets/snackbars/snackbar.dart';
import 'package:BitNet/models/issuereport.dart';
import 'package:BitNet/models/user/userwallet.dart';
import 'package:BitNet/pages/settings/settingsscreen.dart';
import 'package:BitNet/backbone/helper/theme/theme.dart';
import 'package:provider/provider.dart';

class ReportIssueScreen extends StatefulWidget {
  const ReportIssueScreen({Key? key}) : super(key: key);

  @override
  State<ReportIssueScreen> createState() => _ReportIssueScreenState();
}

class _ReportIssueScreenState extends State<ReportIssueScreen> {
  TextEditingController issueController = TextEditingController();
  final User? user = Auth().currentUser;

  void sendIssue() async {
    print('Issue commited');
    if (issueController.text.isNotEmpty) {
      issueController.text = "";
      String uid = user!.uid;
      String mail = user!.email ?? "";
      final issuereport = IssueReport(
          useremail: mail, issue: issueController.text);
      // Push issuereport object to Firebase Realtime Database
      await issueCollection.doc(uid).set(issuereport.toMap());
      displaySnackbar(context, "Deine Fehlermeldung wurde weitergeleitet");
      Navigator.of(context).pop();
    } else {
      displaySnackbar(context, "Bitte geben Sie erst einen Fehlertext an");
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

    return Scaffold(
      backgroundColor: AppTheme.colorBackground,
      body: Container(
        padding: EdgeInsets.only(top: AppTheme.cardPadding * 2),
        child: ListView(
          padding: EdgeInsets.symmetric(
              horizontal: AppTheme.cardPadding, vertical: AppTheme.cardPadding),
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.email_outlined,
                  color: Colors.white,
                ),
                SizedBox(
                  width: AppTheme.elementSpacing / 2,
                ),
                Text(
                  "Fehler melden",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ],
            ),
            MyDivider(),
            SizedBox(
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
                        print('pressed');
                        sendIssue();
                      });
                      ;
                    },
                    style: Theme.of(context).textTheme.bodyMedium,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      counterText: "",
                      hintText:
                          "Bitte teile uns mit was schief gelaufen ist...",
                      hintStyle: TextStyle(color: AppTheme.white60),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: AppTheme.cardPadding,
            ),
            Center(
              child: glassButton(
                  text: "Melden",
                  iconData: Icons.send,
                  onTap: () => sendIssue()),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: AppTheme.cardPadding),
        child: FloatingActionButton.extended(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100.0),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
          label: const Text('Zurück'),
          elevation: 500,
          icon: const Icon(Icons.arrow_back_rounded),
          backgroundColor: Colors.purple.shade800,
        ),
      ),
    );
  }
}
