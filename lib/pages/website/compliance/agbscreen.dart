import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/appstandards/BitNetWebsiteAppBar.dart';
import 'package:bitnet/components/appstandards/mydivider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';

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

      double bigtextWidth = isMidScreen
          ? isSmallScreen
              ? AppTheme.cardPadding * 24
              : AppTheme.cardPadding * 28
          : AppTheme.cardPadding * 30;
      double textWidth = isMidScreen
          ? isSmallScreen
              ? AppTheme.cardPadding * 16
              : AppTheme.cardPadding * 22
          : AppTheme.cardPadding * 24;
      double subtitleWidth = isMidScreen
          ? isSmallScreen
              ? AppTheme.cardPadding * 14
              : AppTheme.cardPadding * 18
          : AppTheme.cardPadding * 22;
      double spacingMultiplier = isMidScreen
          ? isSmallScreen
              ? 0.5
              : 0.75
          : 1;
      double centerSpacing = isMidScreen
          ? isSmallScreen
              ? AppTheme.columnWidth * 0.15
              : AppTheme.columnWidth * 0.65
          : AppTheme.columnWidth;

      return bitnetScaffold(
        extendBodyBehindAppBar: true,
        appBar: const bitnetWebsiteAppBar(),
        context: context,
        backgroundColor: AppTheme.colorBackground,
        body: Container(
          padding: const EdgeInsets.only(top: AppTheme.cardPadding * 2),
          child: ListView(
            padding: const EdgeInsets.symmetric(
              horizontal: AppTheme.columnWidth,
              vertical: AppTheme.cardPadding,
            ),
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.article_outlined,
                    color: Colors.white,
                  ),
                  const SizedBox(
                    width: AppTheme.elementSpacing / 2,
                  ),
                  Text(
                    L10n.of(context)!.termsAndConditions,
                    maxLines: 2,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ],
              ),
              MyDivider(),
              const SizedBox(
                height: AppTheme.cardPadding,
              ),
              Text(
                L10n.of(context)!.scope,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: AppTheme.elementSpacing / 2),
              Text(L10n.of(context)!.termsAndConditionsDescription,
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(
                height: AppTheme.cardPadding,
              ),
              Text(
                L10n.of(context)!.functionality,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: AppTheme.elementSpacing / 2),
              Text(L10n.of(context)!.appAllowsUsers,
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(
                height: AppTheme.cardPadding,
              ),
              Text(
                L10n.of(context)!.userResponsibility,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: AppTheme.elementSpacing / 2),
              Text(L10n.of(context)!.userSolelyResponsible,
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(
                height: AppTheme.cardPadding,
              ),
              Text(
                L10n.of(context)!.fees,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: AppTheme.elementSpacing / 2),
              Text(
                L10n.of(context)!.certainFeaturesOfApp,
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(
                height: AppTheme.cardPadding,
              ),
              Text(
                L10n.of(context)!.limitationOfLiability,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: AppTheme.elementSpacing / 2),
              Text(L10n.of(context)!.walletLiable, style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(
                height: AppTheme.cardPadding,
              ),
              Text(
                L10n.of(context)!.changes,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: AppTheme.elementSpacing / 2),
              Text(L10n.of(context)!.walletReserves,  style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(
                height: AppTheme.cardPadding,
              ),
              Text(
                L10n.of(context)!.finalProvisions,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: AppTheme.elementSpacing / 2),
              Text(L10n.of(context)!.termsAndConditionsEntire, style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: AppTheme.cardPadding * 2),
              Center(
                child: Text(
                  "© BitNet 2023",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
              const SizedBox(height: AppTheme.cardPadding * 4),
            ],
          ),
        ),
      );
    });
  }
}
