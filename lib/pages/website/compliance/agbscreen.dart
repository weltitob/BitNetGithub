import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/appstandards/BitNetWebsiteAppBar.dart';
import 'package:bitnet/components/appstandards/mydivider.dart';
import 'package:flutter/material.dart';
import 'package:bitnet/pages/settings/settingsscreen.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';

class AGBScreen extends StatefulWidget {
  const AGBScreen({Key? key}) : super(key: key);

  @override
  State<AGBScreen> createState() => _AGBScreenState();
}

class _AGBScreenState extends State<AGBScreen> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          // Check if the screen width is less than 600 pixels.
          bool isSmallScreen = constraints.maxWidth < AppTheme.isSmallScreen;
          bool isMidScreen = constraints.maxWidth < AppTheme.isMidScreen;

          double bigtextWidth = isMidScreen ? isSmallScreen ? AppTheme
              .cardPadding * 24 : AppTheme.cardPadding * 28 : AppTheme
              .cardPadding * 30;
          double textWidth = isMidScreen ? isSmallScreen ? AppTheme.cardPadding *
              16 : AppTheme.cardPadding * 22 : AppTheme.cardPadding * 24;
          double subtitleWidth = isMidScreen ? isSmallScreen ? AppTheme
              .cardPadding * 14 : AppTheme.cardPadding * 18 : AppTheme
              .cardPadding * 22;
          double spacingMultiplier = isMidScreen ? isSmallScreen ? 0.5 : 0.75 : 1;
          double centerSpacing = isMidScreen ? isSmallScreen ? AppTheme
              .columnWidth * 0.15 : AppTheme.columnWidth * 0.65 : AppTheme
              .columnWidth;

        return bitnetScaffold(
          extendBodyBehindAppBar: true,
          appBar: bitnetWebsiteAppBar(),
          context: context,
          backgroundColor: AppTheme.colorBackground,
          body: Container(
            padding: EdgeInsets.only(top: AppTheme.cardPadding * 2),
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: AppTheme.columnWidth, vertical: AppTheme.cardPadding),
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.article_outlined,
                      color: Colors.white,
                    ),
                    SizedBox(width: AppTheme.elementSpacing / 2,),
                    Text("Allgemeine Geschäftsbedingungen",
                    maxLines: 2,
                    style: Theme.of(context).textTheme.headlineMedium,),
                  ],
                ),
                MyDivider(),
                SizedBox(height: AppTheme.cardPadding,),
                Text("Anwendungsbereich:",
                style: Theme.of(context).textTheme.headlineSmall,),
                SizedBox(height: AppTheme.elementSpacing / 2),
                Text("Diese Geschäftsbedingungen"
                    "regeln die Nutzung der Bitcoin-Wallet-App"
                    "(im Folgenden BitNet), die von der BitNet GmbH bereitgestellt wird."
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
                  child: Text("© BitNet 2023",
                    style: Theme.of(context).textTheme.bodySmall,),
                ),
                SizedBox(height: AppTheme.cardPadding * 4),

              ],
            ),
          ),
        );
      }
    );
  }
}
