import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AgbsAndImpressumScreen extends StatelessWidget {
  const AgbsAndImpressumScreen({super.key, this.onBackButton});
  final Function()? onBackButton;

  @override
  Widget build(BuildContext context) {
    return bitnetScaffold(
      extendBodyBehindAppBar: true,
      context: context,
      appBar: bitnetAppBar(
        text: "Agbs and Impressum",
        context: context,
        onTap: (onBackButton == null) ? () => context.pop() : onBackButton,
      ),
      body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: AppTheme.cardPadding * 3, left: AppTheme.cardPadding, right: AppTheme.cardPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Allgemeine Geschäftsbedingungen",
                  maxLines: 2,
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                const SizedBox(
                  height: AppTheme.cardPadding,
                ),
                const Divider(indent: 10, endIndent: 10),
                const SizedBox(
                  height: AppTheme.cardPadding,
                ),
                Text(
                  "Anwendungsbereich:",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: AppTheme.elementSpacing / 2),
                Text(
                  "Diese Geschäftsbedingungen"
                      "regeln die Nutzung der Bitcoin-Wallet-App"
                      " (im Folgenden BitNet), die von der BitNet GmbH bereitgestellt wird."
                      " Durch die Nutzung der App erklären Sie sich mit diesen"
                      "Geschäftsbedingungen einverstanden.",
                  style: Theme.of(context).textTheme.bodySmall,
                  textAlign: TextAlign.start,
                ),
                const SizedBox(
                  height: AppTheme.cardPadding,
                ),
                Text(
                  "Funktionalität:",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: AppTheme.elementSpacing / 2),
                Text(
                  "Die App ermöglicht es Benutzern, Bitcoins zu empfangen, zu senden und zu verwalten."
                      "Die App ist keine Bank und bietet keine Bankdienstleistungen an."
                      " Zusätzlich werden Tproot Assets, auch bekannt als digitale Assets, als Dienstleistungsplattform angeboten und verkauft.",
                  style: Theme.of(context).textTheme.bodySmall,
                  textAlign: TextAlign.start,
                ),
                const SizedBox(
                  height: AppTheme.cardPadding,
                ),
                Text(
                  "Verantwortung des Benutzers:",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: AppTheme.elementSpacing / 2),
                Text(
                  "Der Benutzer ist allein für die Sicherheit seiner Bitcoins verantwortlich. Die App bietet Schutzfunktionen wie Passwortschutz und Zwei-Faktor-Authentifizierung,"
                      "aber es liegt in der Verantwortung des Benutzers, diese Funktionen sorgfältig zu verwenden."
                      "BitNet haftet nicht für Verluste, die aufgrund von Unachtsamkeit, Verlust von Geräten oder Zugangsdaten des Benutzers entstehen.",
                  style: Theme.of(context).textTheme.bodySmall,
                  textAlign: TextAlign.start,
                ),
                const SizedBox(
                  height: AppTheme.cardPadding,
                ),
                Text(
                  "Gebühren:",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: AppTheme.elementSpacing / 2),
                Text(
                  "Für bestimmte Funktionen der App können Gebühren anfallen."
                      "Diese Gebühren werden dem Benutzer im Vorfeld mitgeteilt und"
                      "sind in der App ersichtlich.",
                  style: Theme.of(context).textTheme.bodySmall,
                  textAlign: TextAlign.start,
                ),
                const SizedBox(
                  height: AppTheme.cardPadding,
                ),
                Text(
                  "Haftungsbeschränkung:",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: AppTheme.elementSpacing / 2),
                Text(
                  "BitNet haftet nur für Schäden, die durch vorsätzliches oder grob fahrlässiges Handeln von"
                      "BitNet verursacht werden. [Name des Unternehmens] haftet nicht für Schäden, die aus der Nutzung der App oder dem Verlust von Bitcoins resultieren.",
                  style: Theme.of(context).textTheme.bodySmall,
                  textAlign: TextAlign.start,
                ),
                const SizedBox(
                  height: AppTheme.cardPadding,
                ),
                Text(
                  "Änderungen:",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: AppTheme.elementSpacing / 2),
                Text(
                  "BitNet behält sich das Recht vor, diese Geschäftsbedingungen jederzeit zu ändern."
                      "Der Benutzer wird über solche Änderungen informiert und muss diesen zustimmen, um die App weiterhin nutzen zu können.",
                  style: Theme.of(context).textTheme.bodySmall,
                  textAlign: TextAlign.start,
                ),
                const SizedBox(
                  height: AppTheme.cardPadding,
                ),
                Text(
                  "Schlussbestimmungen:",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: AppTheme.elementSpacing / 2),
                Text(
                  "Diese Geschäftsbedingungen stellen die gesamte Vereinbarung zwischen dem Benutzer und BitNet dar."
                      "Sollte eine Bestimmung unwirksam sein, bleiben die übrigen Bestimmungen in Kraft.",
                  style: Theme.of(context).textTheme.bodySmall,
                  textAlign: TextAlign.start,
                ),
                const SizedBox(height: AppTheme.cardPadding),
                const Divider(),
                const SizedBox(height: AppTheme.cardPadding),
                Text(
                  "Alpha-Entwicklungsphase und Risiko:",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: AppTheme.elementSpacing / 2),
                Text(
                  "Diese App befindet sich in der Alpha-Entwicklungsphase. Das bedeutet, dass die App noch getestet wird und viele Änderungen und Aktualisierungen stattfinden können."
                      " Durch die Nutzung dieser App erklären Sie sich damit einverstanden, dass es zu unerwarteten Ausfällen und Fehlern kommen kann, die zu einem Verlust von Daten oder erworbenen Geldern führen können."
                      " BitNet übernimmt keine Haftung für jegliche Verluste, die durch die Nutzung der App entstehen. Alle erworbenen Gelder könnten jederzeit verloren gehen.",
                  style: Theme.of(context).textTheme.bodySmall,
                  textAlign: TextAlign.start,
                ),
                const SizedBox(height: AppTheme.cardPadding * 2),
                Text(
                  "Impressum",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(
                  height: AppTheme.cardPadding / 2,
                ),
                const Divider(),
                const SizedBox(
                  height: AppTheme.cardPadding / 2,
                ),
                Text(
                  "Anbieter:",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: AppTheme.elementSpacing / 2),
                Text(
                  "BitNet LLC",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Text(
                  "Fünf Linden 42",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Text(
                  "88400 Biberach an der Riss",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Text(
                  "Germany",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(
                  height: AppTheme.cardPadding,
                ),
                Text(
                  "Kontakt:",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: AppTheme.elementSpacing / 2),
                Text(
                  "Telefon: +49 17636384058",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Text(
                  "E-Mail: contact@mybitnet.com",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(
                  height: AppTheme.cardPadding,
                ),
                Text(
                  "Verantwortlich für den Inhalt:",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: AppTheme.elementSpacing / 2),
                Text(
                  "Tobias Welti",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(
                  height: AppTheme.cardPadding,
                ),
                Text(
                  "Haftungsausschluss:",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: AppTheme.elementSpacing / 2),
                Column(
                  children: [
                    Text(
                      "Inhalt des Onlineangebots: Der Anbieter übernimmt keinerlei Gewähr für die Aktualität, "
                          "Korrektheit, Vollständigkeit oder Qualität der bereitgestellten "
                          "Informationen. Haftungsansprüche gegen den Anbieter, welche sich auf "
                          "Schäden materieller oder ideeller Art beziehen, die durch die Nutzung oder "
                          "Nichtnutzung der dargebotenen Informationen bzw. durch die Nutzung "
                          "fehlerhafter und unvollständiger Informationen verursacht wurden, sind "
                          "grundsätzlich ausgeschlossen, sofern seitens des Anbieters kein nachweislich "
                          "vorsätzliches oder grob fahrlässiges Verschulden vorliegt.",
                      style: Theme.of(context).textTheme.bodySmall,
                      textAlign: TextAlign.start,
                    ),
                    const SizedBox(
                      height: AppTheme.elementSpacing / 2,
                    ),
                    Text(
                      "Verfügbarkeit: Der Anbieter behält sich ausdrücklich vor, "
                          "Teile der Seiten oder das gesamte Angebot ohne gesonderte "
                          "Ankündigung zu verändern, zu ergänzen, zu löschen oder die "
                          "Veröffentlichung zeitweise oder endgültig einzustellen.",
                      textAlign: TextAlign.start,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(
                      height: AppTheme.elementSpacing / 2,
                    ),
                    Text(
                      "Verweise und Links: Bei direkten oder indirekten Verwe "
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
                      textAlign: TextAlign.start,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(height: AppTheme.cardPadding * 2),
                    const Divider(),
                    Center(
                      child: Text(
                        "© BitNet 2023",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                    const SizedBox(height: AppTheme.cardPadding * 2),
                  ],
                ),
              ],
            ),
          )),
    );
  }
}
