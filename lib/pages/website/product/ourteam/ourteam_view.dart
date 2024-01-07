import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/appstandards/BitNetWebsiteAppBar.dart';
import 'package:bitnet/components/items/teamprofilecard.dart';
import 'package:bitnet/pages/website/product/ourteam/ourteam.dart';
import 'package:flutter/material.dart';

class OurTeamView extends StatelessWidget {
  final OurTeamController controller;

  const OurTeamView({super.key, required this.controller});

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
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: AppTheme.cardPadding * 6 * spacingMultiplier,
                ),
                Container(
                  width: bigtextWidth,
                  child: Text(
                    "We believe in empowering our people and building true loyalty!",
                    textAlign: TextAlign.center,
                    style: Theme
                        .of(context)
                        .textTheme
                        .displayLarge
                  ),
                ),
                SizedBox(
                  height: AppTheme.cardPadding * 4 * spacingMultiplier,
                ),
                // Container(
                //   width: bigtextWidth,
                //   child: Text(
                //     "Our Team",
                //     textAlign: TextAlign.center,
                //     style: Theme
                //         .of(context)
                //         .textTheme
                //         .headlineLarge,
                //   ),
                // ),
                Container(
                  height: controller.teamMembers.length * 160.0,
                  width: MediaQuery.of(context).size.width - AppTheme.columnWidth * 2,
                  alignment: Alignment.center,
                  child: Column(
                    children: _buildRows(),
                  )
                ),
                SizedBox(
                  height: AppTheme.cardPadding * 2 * spacingMultiplier,
                ),
                Row(
                  children: [
                    Container(

                    )
                  ],
                ),
                SizedBox(
                  height: AppTheme.cardPadding * 2 * spacingMultiplier,
                ),
              ],
            ),
          ), context: context,
        );
      },
    );
  }

  List<Widget> _buildRows() {
    List<Widget> rows = [];
    List<Widget> itemsInRow = [];

    for (int i = 0; i < controller.teamMembers.length; i++) {
      final member = controller.teamMembers[i];
      itemsInRow.add(
        TeamProfileCard(
          avatarUrl: member.avatarUrl,
          name: member.name,
          position: member.position,
          quote: member.quote,
          isYou: member.isYou,
        ),
      );

      if ((i + 1) % 4 == 0 || i == controller.teamMembers.length - 1) {
        rows.add(
          Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: itemsInRow,
            ),
          ),
        );
        rows.add(SizedBox(height: AppTheme.cardPadding)); // Add spacing between rows
        itemsInRow = [];
      }
    }

    return rows;
  }

}