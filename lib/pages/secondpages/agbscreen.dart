import 'package:flutter/material.dart';
import 'package:nexus_wallet/pages/settingsscreen.dart';
import 'package:nexus_wallet/theme.dart';

class AGBScreen extends StatefulWidget {
  const AGBScreen({Key? key}) : super(key: key);

  @override
  State<AGBScreen> createState() => _AGBScreenState();
}

class _AGBScreenState extends State<AGBScreen> {
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
                  Icons.article_outlined,
                  color: Colors.white,
                ),
                SizedBox(width: AppTheme.elementSpacing / 2,),
                Text("Allgemeine",
                style: Theme.of(context).textTheme.headlineMedium,),
              ],
            ),
            Text("Geschäftsbedingungen",
              style: Theme.of(context).textTheme.headlineMedium,),
            MyDivider(),
            SizedBox(height: AppTheme.cardPadding,),
            Text("Anwendungsbereich:",
            style: Theme.of(context).textTheme.headlineSmall,),
            SizedBox(height: AppTheme.elementSpacing / 2),
            Text("Diese Geschäftsbedingungen"
                "regeln die Nutzung der Bitcoin-Wallet-App"
                "(im Folgenden NexusWallet), die von Nexus bereitgestellt wird."
                "Durch die Nutzung der App erklären Sie sich mit diesen"
                "Geschäftsbedingungen einverstanden.",
              style: Theme.of(context).textTheme.bodySmall,),
            SizedBox(height: AppTheme.cardPadding,),
            Text("Funktionalität:",
              style: Theme.of(context).textTheme.headlineSmall,),
            SizedBox(height: AppTheme.elementSpacing / 2),
            Text("Die App ermöglicht es Benutzern, Bitcoins zu empfangen, zu senden und zu verwalten."
                "Die App ist keine Bank und bietet keine Bankdienstleistungen an.",
              style: Theme.of(context).textTheme.bodySmall,),
            SizedBox(height: AppTheme.cardPadding,),
            Text("Verantwortung des Benutzers:",
              style: Theme.of(context).textTheme.headlineSmall,),
            SizedBox(height: AppTheme.elementSpacing / 2),
            Text("Der Benutzer ist allein für die Sicherheit seiner Bitcoins verantwortlich. Die App bietet Schutzfunktionen wie Passwortschutz und Zwei-Faktor-Authentifizierung,"
                "aber es liegt in der Verantwortung des Benutzers, diese Funktionen sorgfältig zu verwenden."
                "NexusWallet haftet nicht für Verluste, die aufgrund von Unachtsamkeit, Verlust von Geräten oder Zugangsdaten des Benutzers entstehen.",
              style: Theme.of(context).textTheme.bodySmall,),
            SizedBox(height: AppTheme.cardPadding,),
            Text("Gebühren:",
              style: Theme.of(context).textTheme.headlineSmall,),
            SizedBox(height: AppTheme.elementSpacing / 2),
            Text("Für bestimmte Funktionen der App können Gebühren anfallen."
                "Diese Gebühren werden dem Benutzer im Vorfeld mitgeteilt und"
                "sind in der App ersichtlich.",
              style: Theme.of(context).textTheme.bodySmall,),
            SizedBox(height: AppTheme.cardPadding,),
            Text("Haftungsbeschränkung:",
              style: Theme.of(context).textTheme.headlineSmall,),
            SizedBox(height: AppTheme.elementSpacing / 2),
            Text("NexusWallet haftet nur für Schäden, die durch vorsätzliches oder grob fahrlässiges Handeln von"
                "NexusWallet verursacht werden. [Name des Unternehmens] haftet nicht für Schäden, die aus der Nutzung der App oder dem Verlust von Bitcoins resultieren.",
              style: Theme.of(context).textTheme.bodySmall,),
            SizedBox(height: AppTheme.cardPadding,),
            Text("Änderungen:",
              style: Theme.of(context).textTheme.headlineSmall,),
            SizedBox(height: AppTheme.elementSpacing / 2),
            Text("NexusWallet behält sich das Recht vor, diese Geschäftsbedingungen jederzeit zu ändern."
                "Der Benutzer wird über solche Änderungen informiert und muss diesen zustimmen, um die App weiterhin nutzen zu können.",
              style: Theme.of(context).textTheme.bodySmall,),
            SizedBox(height: AppTheme.cardPadding,),
            Text("Schlussbestimmungen:",
              style: Theme.of(context).textTheme.headlineSmall,),
            SizedBox(height: AppTheme.elementSpacing / 2),
            Text("Diese Geschäftsbedingungen stellen die gesamte Vereinbarung zwischen dem Benutzer und NexusWallet dar."
                "Sollte eine Bestimmung unwirksam sein, bleiben die übrigen Bestimmungen in Kraft.",
              style: Theme.of(context).textTheme.bodySmall,),
            SizedBox(height: AppTheme.cardPadding * 2),
            Center(
              child: Text("© NexusWallet by Nexus Inc.",
                style: Theme.of(context).textTheme.bodySmall,),
            ),
            SizedBox(height: AppTheme.cardPadding * 4),

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
