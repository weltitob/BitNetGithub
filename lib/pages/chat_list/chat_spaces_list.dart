import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/BitNetTabBar.dart';
import 'package:bitnet/components/appstandards/horizontallistviewwrapper.dart';
import 'package:bitnet/components/container/customtab.dart';
import 'package:bitnet/components/loaders/loaders.dart';
import 'package:bitnet/pages/chat_list/chat_list.dart';
import 'package:bitnet/pages/matrix/utils/matrix_sdk_extensions/matrix_locals.dart';
import 'package:bitnet/pages/routetrees/matrix.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';

class SpacesWidget extends StatelessWidget {
  final ChatListController controller;

  const SpacesWidget(this.controller, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final client = Matrix.of(context).client;
    final activeSpaceId = controller.activeSpaceId;
    final allSpaces = client.rooms.where((room) => room.isSpace);

    if (activeSpaceId == null) {
      final rootSpaces = allSpaces
          .where(
            (space) => !allSpaces.any(
              (parentSpace) => parentSpace.spaceChildren
              .any((child) => child.roomId == space.id),
        ),
      )
          .toList();

      return HorizontalFadeListView(
        child: DefaultTabController(
          length: rootSpaces.length,
          child: BitNetTabBar(
            buttonMargin: EdgeInsets.only(
                left:
                AppTheme.elementSpacing *
                    1),
            contentPadding:
            const EdgeInsets.symmetric(
              vertical:
              AppTheme.elementSpacing *
                  0.5,
              horizontal:
              AppTheme.elementSpacing / 4,
            ),
            //tabController: controller.tabController,
            borderWidth:
            AppTheme.tabbarBorderWidth,
            unselectedBorderColor:
            Colors.transparent,
            radius: AppTheme.cardPaddingSmall,
            physics: ClampingScrollPhysics(),
            // give the indicator a decoration (color and border radius)
            unselectedDecoration:
            BoxDecoration(
              color: Colors.transparent,
              borderRadius:
              AppTheme.cardRadiusSmall,
            ),
            //controller: ,
            tabs: List.generate(
              rootSpaces.length,
                  (index) {
                final rootSpace = rootSpaces[index];
                final displayname = rootSpace.getLocalizedDisplayname(
                  MatrixLocals(L10n.of(context)!),
                );
                return Tab(
                    child: CustomTabContent(
                      mxContent: rootSpace.avatar,
                      text: displayname,
                    ));
              },
            ),
          ),

            // body: TabBarView(
            //   controller: controller.tabController,
            //   children: List.generate(
            //     rootSpaces.length,
            //         (index) {
            //       final space = rootSpaces[index];
            //       return YourSpaceView(
            //           space: space); // Replace with your actual space view widget
            //     },
            //   ),
            // ),

        ),
      );
  }
  return Container(
    child: dotProgress(
      context,
      //L10n.of(context)!.loading,
  ));
  }
}
