import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AgbsAndImpressumScreen extends StatelessWidget {
  const AgbsAndImpressumScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return bitnetScaffold(
      extendBodyBehindAppBar: true,
      context: context,
      appBar: bitnetAppBar(
        text: "Agbs and Impressum",
        context: context,
        onTap: ()=> context.pop(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 100, left: 16, right: 16),
          child: Column(children: [
             Text("Allgemeine Geschäftsbedingungen",
                    maxLines: 2,
                    style: Theme.of(context).textTheme.headlineSmall,),

             SizedBox(height: AppTheme.cardPadding,),
             Divider(indent: 10, endIndent: 10),
                          SizedBox(height: AppTheme.cardPadding,),

                Text("Anwendungsbereich:",
                style: Theme.of(context).textTheme.headlineSmall,),
                SizedBox(height: AppTheme.elementSpacing / 2),
                Text("Diese Geschäftsbedingungen"
                    "regeln die Nutzung der Bitcoin-Wallet-App"
                    "(im Folgenden BitNet), die von der BitNet GmbH bereitgestellt wird."
                    "Durch die Nutzung der App erklären Sie sich mit diesen"
                    "Geschäftsbedingungen einverstanden.",
                  style: Theme.of(context).textTheme.bodySmall,
                  textAlign: TextAlign.center,),
                SizedBox(height: AppTheme.cardPadding,),
                Text("Funktionalität:",
                  style: Theme.of(context).textTheme.headlineSmall,),
                SizedBox(height: AppTheme.elementSpacing / 2),
                Text("Die App ermöglicht es Benutzern, Bitcoins zu empfangen, zu senden und zu verwalten."
                    "Die App ist keine Bank und bietet keine Bankdienstleistungen an.",
                  style: Theme.of(context).textTheme.bodySmall,
                  textAlign: TextAlign.center,),
                SizedBox(height: AppTheme.cardPadding,),
                Text("Verantwortung des Benutzers:",
                  style: Theme.of(context).textTheme.headlineSmall,),
                SizedBox(height: AppTheme.elementSpacing / 2),
                Text("Der Benutzer ist allein für die Sicherheit seiner Bitcoins verantwortlich. Die App bietet Schutzfunktionen wie Passwortschutz und Zwei-Faktor-Authentifizierung,"
                    "aber es liegt in der Verantwortung des Benutzers, diese Funktionen sorgfältig zu verwenden."
                    "NexusWallet haftet nicht für Verluste, die aufgrund von Unachtsamkeit, Verlust von Geräten oder Zugangsdaten des Benutzers entstehen.",
                  style: Theme.of(context).textTheme.bodySmall,
                  textAlign: TextAlign.center,),
                SizedBox(height: AppTheme.cardPadding,),
                Text("Gebühren:",
                  style: Theme.of(context).textTheme.headlineSmall,),
                SizedBox(height: AppTheme.elementSpacing / 2),
                Text("Für bestimmte Funktionen der App können Gebühren anfallen."
                    "Diese Gebühren werden dem Benutzer im Vorfeld mitgeteilt und"
                    "sind in der App ersichtlich.",
                  style: Theme.of(context).textTheme.bodySmall,
                  textAlign: TextAlign.center,),
                SizedBox(height: AppTheme.cardPadding,),
                Text("Haftungsbeschränkung:",
                  style: Theme.of(context).textTheme.headlineSmall,),
                SizedBox(height: AppTheme.elementSpacing / 2),
                Text("NexusWallet haftet nur für Schäden, die durch vorsätzliches oder grob fahrlässiges Handeln von"
                    "NexusWallet verursacht werden. [Name des Unternehmens] haftet nicht für Schäden, die aus der Nutzung der App oder dem Verlust von Bitcoins resultieren.",
                  style: Theme.of(context).textTheme.bodySmall,
                  textAlign: TextAlign.center,),
                SizedBox(height: AppTheme.cardPadding,),
                Text("Änderungen:",
                  style: Theme.of(context).textTheme.headlineSmall,),
                SizedBox(height: AppTheme.elementSpacing / 2),
                Text("NexusWallet behält sich das Recht vor, diese Geschäftsbedingungen jederzeit zu ändern."
                    "Der Benutzer wird über solche Änderungen informiert und muss diesen zustimmen, um die App weiterhin nutzen zu können.",
                  style: Theme.of(context).textTheme.bodySmall,
                  textAlign: TextAlign.center,),
                SizedBox(height: AppTheme.cardPadding,),
                Text("Schlussbestimmungen:",
                  style: Theme.of(context).textTheme.headlineSmall,),
                SizedBox(height: AppTheme.elementSpacing / 2),
                Text("Diese Geschäftsbedingungen stellen die gesamte Vereinbarung zwischen dem Benutzer und NexusWallet dar."
                    "Sollte eine Bestimmung unwirksam sein, bleiben die übrigen Bestimmungen in Kraft.",
                  style: Theme.of(context).textTheme.bodySmall,
                  textAlign: TextAlign.center,),
                SizedBox(height: AppTheme.cardPadding * 2),
          
            Text("Impressum",
                  style: Theme.of(context).textTheme.headlineMedium,),
                                SizedBox(height: AppTheme.cardPadding/2,),

              Divider(),
              SizedBox(height: AppTheme.cardPadding/2,),
              Text("Anbieter:",
                style: Theme.of(context).textTheme.headlineSmall,),
              SizedBox(height: AppTheme.elementSpacing / 2),
              Text("BitNet GmbH",
                style: Theme.of(context).textTheme.bodyMedium,),
              Text("Fallenbrunnen 12",
                style: Theme.of(context).textTheme.bodyMedium,),
              Text("88405 Friedrichshafen",
                style: Theme.of(context).textTheme.bodyMedium,),
              Text("Deutschland",
                style: Theme.of(context).textTheme.bodyMedium,),
          
              SizedBox(height: AppTheme.cardPadding,),
              Text("Kontakt:",
                style: Theme.of(context).textTheme.headlineSmall,),
              SizedBox(height: AppTheme.elementSpacing / 2),
              Text("Telefon: +49 17636384058",
                style: Theme.of(context).textTheme.bodyMedium,),
              Text("E-Mail: contact@mybitnet.com",
                style: Theme.of(context).textTheme.bodyMedium,),
          
              SizedBox(height: AppTheme.cardPadding,),
              Text("Verantwortlich für den Inhalt:",
                style: Theme.of(context).textTheme.headlineSmall,),
              SizedBox(height: AppTheme.elementSpacing / 2),
              Text("Tobias Welti",
                style: Theme.of(context).textTheme.bodyMedium,),
          
              SizedBox(height: AppTheme.cardPadding,),
              Text("Haftungsausschluss:",
                style: Theme.of(context).textTheme.headlineSmall,),
              SizedBox(height: AppTheme.elementSpacing / 2),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  
                  children: [
                    Text("Inhalt des Onlineangebots: Der Anbieter übernimmt keinerlei Gewähr für die Aktualität, "
                        "Korrektheit, Vollständigkeit oder Qualität der bereitgestellten "
                        "Informationen. Haftungsansprüche gegen den Anbieter, welche sich auf "
                        "Schäden materieller oder ideeller Art beziehen, die durch die Nutzung oder "
                        "Nichtnutzung der dargebotenen Informationen bzw. durch die Nutzung "
                        "fehlerhafter und unvollständiger Informationen verursacht wurden, sind "
                        "grundsätzlich ausgeschlossen, sofern seitens des Anbieters kein nachweislich "
                        "vorsätzliches oder grob fahrlässiges Verschulden vorliegt.",
                      style: Theme.of(context).textTheme.bodySmall,
                      textAlign: TextAlign.center,),
                    SizedBox(height: AppTheme.elementSpacing / 2,),
                    Text("Verfügbarkeit: Der Anbieter behält sich ausdrücklich vor, "
                        "Teile der Seiten oder das gesamte Angebot ohne gesonderte "
                        "Ankündigung zu verändern, zu ergänzen, zu löschen oder die "
                        "Veröffentlichung zeitweise oder endgültig einzustellen.",
                        textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodySmall,),
                    SizedBox(height: AppTheme.elementSpacing / 2,),
                    Text("Verweise und Links: Bei direkten oder indirekten Verwe "
                        "isen auf fremde Internetseiten "
                        "die außerhalb des Verantwortungsbereiches des Anbieters liegen, "
                        "würde eine Haftungsverpflichtung ausschließlich in dem Fall in Kraft "
                        "treten, in dem der Anbieter von den Inhalten Kenntnis hat und es "
                        "ihm technisch möglich und zumutbar wäre, die Nutzung im Falle "
                        "rechtswidriger Inhalte zu verhindern. Der Anbieter erklärt hiermit "
                        "ausdrücklich, dass zum Zeitpunkt der Linksetzung keine illegalen Inhalte "
                        "auf den zu verlinkenden Seiten erkennbar waren. Auf die aktuelle und "
                        "zukünftige Gestaltung, die Inhalte oder die Urheberschaft der "
                        "verlinkten/verknüpften Seiten hat der Anbieter keinerlei Einfluss. "
                        "Deshalb distanziert er sich hiermit ausdrücklich von allen Inhalten "
                        "aller verlinkten /verknüpften Seiten.",
                        textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodySmall,),
                    SizedBox(height: AppTheme.cardPadding * 2),
                    Divider(),
                Center(
                  child: Text("© BitNet 2023",
                    style: Theme.of(context).textTheme.bodySmall,),
                    
                ),
                                                    SizedBox(height: AppTheme.cardPadding * 2),


                  ],
                ),
              ),
          ],),
        )
      ),
    );
  }
}