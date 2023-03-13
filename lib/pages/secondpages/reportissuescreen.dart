import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:nexus_wallet/components/buttons/glassbutton.dart';
import 'package:nexus_wallet/components/glassmorph.dart';
import 'package:nexus_wallet/components/snackbar/snackbar.dart';
import 'package:nexus_wallet/pages/settingsscreen.dart';
import 'package:nexus_wallet/backbone/theme.dart';

class ReportIssueScreen extends StatefulWidget {
  const ReportIssueScreen({Key? key}) : super(key: key);

  @override
  State<ReportIssueScreen> createState() => _ReportIssueScreenState();
}

class _ReportIssueScreenState extends State<ReportIssueScreen> {
  TextEditingController _issueController = TextEditingController();

  sendIssue() {
    print('Issue commited');
    if(_issueController.text.isNotEmpty) {
      _issueController.text = "";
      displaySnackbar(context, "Deine Fehlermeldung wurde weitergeleitet");
    } else {
      displaySnackbar(context, "Bitte geben Sie erst einen Fehlertext an");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.colorBackground,
      body: Container(
        padding: EdgeInsets.only(top: AppTheme.cardPadding * 2),
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: AppTheme.cardPadding, vertical: AppTheme.cardPadding),
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.email_outlined,
                  color: Colors.white,
                ),
                SizedBox(width: AppTheme.elementSpacing / 2,),
                Text("Fehler melden",
                  style: Theme.of(context).textTheme.headlineMedium,),
              ],
            ),
            MyDivider(),
            SizedBox(height: AppTheme.cardPadding,),
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
                        sendIssue();
                      });
                      ;
                    },
                    style: Theme.of(context).textTheme.bodyMedium,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      counterText: "",
                      hintText: "Bitte teile uns mit was schief gelaufen ist...",
                      hintStyle:
                      TextStyle(color: AppTheme.white60),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: AppTheme.cardPadding,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppTheme.cardPadding * 5),
              child: glassButton(
                  text: "Melden", iconData: Icons.send, onTap: () => sendIssue()),
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
