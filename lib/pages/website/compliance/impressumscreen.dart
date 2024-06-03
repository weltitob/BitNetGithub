import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/appstandards/BitNetWebsiteAppBar.dart';
import 'package:bitnet/components/appstandards/mydivider.dart';
import 'package:flutter/material.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';

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
        Text(L10n.of(context)!.imprint,
          style: Theme.of(context).textTheme.headlineMedium,),
      ],
    ),
    MyDivider(),
    SizedBox(height: AppTheme.cardPadding,),
    Text(L10n.of(context)!.provider,
      style: Theme.of(context).textTheme.headlineSmall,),
    SizedBox(height: AppTheme.elementSpacing / 2),
    Text(L10n.of(context)!.bitnerGMBH,
      style: Theme.of(context).textTheme.bodyMedium,),
    Text(L10n.of(context)!.fallenBrunnen,
      style: Theme.of(context).textTheme.bodyMedium,),
    Text(L10n.of(context)!.friedrichshafen,
      style: Theme.of(context).textTheme.bodyMedium,),
    Text("Germany",
      style: Theme.of(context).textTheme.bodyMedium,),

    SizedBox(height: AppTheme.cardPadding,),
    Text(L10n.of(context)!.contact,
      style: Theme.of(context).textTheme.headlineSmall,),
    SizedBox(height: AppTheme.elementSpacing / 2),
    Text("${L10n.of(context)!.phone} +49 17636384058",
      style: Theme.of(context).textTheme.bodyMedium,),
    Text("${L10n.of(context)!.email} contact@mybitnet.com",
      style: Theme.of(context).textTheme.bodyMedium,),

    SizedBox(height: AppTheme.cardPadding,),
    Text(L10n.of(context)!.responsibleForContent,
      style: Theme.of(context).textTheme.headlineSmall,),
    SizedBox(height: AppTheme.elementSpacing / 2),
    Text("Tobias Welti",
      style: Theme.of(context).textTheme.bodyMedium,),

    SizedBox(height: AppTheme.cardPadding,),
    Text(L10n.of(context)!.disclaimer,
      style: Theme.of(context).textTheme.headlineSmall,),
    SizedBox(height: AppTheme.elementSpacing / 2),
    Text(L10n.of(context)!.contentOnlineOffer,
      style: Theme.of(context).textTheme.bodySmall,),
    SizedBox(height: AppTheme.elementSpacing / 2,),
    Text(L10n.of(context)!.availabilityProvider, style: Theme.of(context).textTheme.bodySmall,),
    SizedBox(height: AppTheme.elementSpacing / 2,),
    Text(L10n.of(context)!.referencesLinks,  style: Theme.of(context).textTheme.bodySmall,),
    SizedBox(height: AppTheme.cardPadding * 4),
  ],
),
 ),
    );
  }
}
