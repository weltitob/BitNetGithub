import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/appstandards/BitNetWebsiteAppBar.dart';
import 'package:bitnet/components/appstandards/mydivider.dart';
import 'package:flutter/material.dart';
import 'package:bitnet/pages/settings/settingsscreen.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';

class ImpressumScreen extends StatelessWidget {
  const ImpressumScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return bitnetScaffold(
      context: context,
      backgroundColor: AppTheme.colorBackground,
      appBar: bitnetWebsiteAppBar(),
      body: Container(
        padding: EdgeInsets.only(top: AppTheme.cardPadding * 2),
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: AppTheme.columnWidth, vertical: AppTheme.cardPadding),
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.email_outlined,
                  color: Colors.white,
                ),
                SizedBox(width: AppTheme.elementSpacing / 2,),
                Text("Impressum",
                  style: Theme.of(context).textTheme.headlineMedium,),
              ],
            ),
            MyDivider(),
            SizedBox(height: AppTheme.cardPadding,),
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
            Text("Inhalt des Onlineangebots: Der Anbieter übernimmt keinerlei Gewähr für die Aktualität, "
                "Korrektheit, Vollständigkeit oder Qualität der bereitgestellten "
                "Informationen. Haftungsansprüche gegen den Anbieter, welche sich auf "
                "Schäden materieller oder ideeller Art beziehen, die durch die Nutzung oder "
                "Nichtnutzung der dargebotenen Informationen bzw. durch die Nutzung "
                "fehlerhafter und unvollständiger Informationen verursacht wurden, sind "
                "grundsätzlich ausgeschlossen, sofern seitens des Anbieters kein nachweislich "
                "vorsätzliches oder grob fahrlässiges Verschulden vorliegt.",
              style: Theme.of(context).textTheme.bodySmall,),
            SizedBox(height: AppTheme.elementSpacing / 2,),
            Text("Verfügbarkeit: Der Anbieter behält sich ausdrücklich vor, "
                "Teile der Seiten oder das gesamte Angebot ohne gesonderte "
                "Ankündigung zu verändern, zu ergänzen, zu löschen oder die "
                "Veröffentlichung zeitweise oder endgültig einzustellen.",
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
              style: Theme.of(context).textTheme.bodySmall,),
            SizedBox(height: AppTheme.cardPadding * 4),

          ],
        ),
      ),
    );
  }
}
