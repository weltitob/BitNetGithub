import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:nexus_wallet/backbone/helper/databaserefs.dart';
import 'package:nexus_wallet/components/buttons/glassbutton.dart';
import 'package:nexus_wallet/components/container/glassmorph.dart';
import 'package:nexus_wallet/components/snackbar/snackbar.dart';
import 'package:nexus_wallet/models/issuereport.dart';
import 'package:nexus_wallet/models/userwallet.dart';
import 'package:nexus_wallet/pages/settingsscreen.dart';
import 'package:nexus_wallet/components/theme/theme.dart';
import 'package:provider/provider.dart';

class ReportIssueScreen extends StatefulWidget {
  const ReportIssueScreen({Key? key}) : super(key: key);

  @override
  State<ReportIssueScreen> createState() => _ReportIssueScreenState();
}

class _ReportIssueScreenState extends State<ReportIssueScreen> {
  TextEditingController _issueController = TextEditingController();

  sendIssue(UserWallet userWallet) async {
    print('Issue commited');
    if (_issueController.text.isNotEmpty) {
      _issueController.text = "";
      final issuereport = IssueReport(
          useremail: userWallet.email, issue: _issueController.text);
      // Push issuereport object to Firebase Realtime Database
      await issueCollection.doc(userWallet.useruid).set(issuereport.toMap());
      displaySnackbar(context, "Deine Fehlermeldung wurde weitergeleitet");
      Navigator.of(context).pop();
    } else {
      displaySnackbar(context, "Bitte geben Sie erst einen Fehlertext an");
    }
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
              child: Glassmorphism(
                blur: 20,
                opacity: 0.1,
                radius: 24.0,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppTheme.elementSpacing * 1.5),
                  height: AppTheme.cardPadding * 11,
                  alignment: Alignment.topLeft,
                  child: TextField(
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    controller: _issueController,
                    autofocus: false,
                    onSubmitted: (text) {
                      setState(() {
                        print('pressed');
                        sendIssue(userWallet);
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
                  onTap: () => sendIssue(userWallet)),
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
