import 'dart:math';

import 'package:BitNet/backbone/helper/theme/theme.dart';
import 'package:BitNet/components/appstandards/BitNetAppBar.dart';
import 'package:BitNet/components/appstandards/BitNetScaffold.dart';
import 'package:BitNet/components/camera/qrscanneroverlay.dart';
import 'package:BitNet/pages/matrix/pages/createnew/new_group/new_group.dart';
import 'package:BitNet/pages/matrix/pages/createnew/new_group/new_group_view.dart';
import 'package:BitNet/pages/matrix/pages/createnew/new_private_chat/new_private_chat.dart';
import 'package:BitNet/pages/matrix/pages/createnew/new_space/new_space.dart';
import 'package:BitNet/pages/matrix/pages/createnew/new_space/new_space_view.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:vrouter/vrouter.dart';

import 'package:BitNet/pages/matrix/utils/other/platform_infos.dart';
import 'package:BitNet/pages/matrix/widgets/layouts/max_width_body.dart';
import 'package:BitNet/pages/matrix/widgets/matrix.dart';

class NewPrivateChatView extends StatefulWidget {
  final NewPrivateChatController controller;

  const NewPrivateChatView(this.controller, {Key? key}) : super(key: key);

  static const double _qrCodePadding = 8;

  @override
  State<NewPrivateChatView> createState() => _NewPrivateChatViewState();
}

class _NewPrivateChatViewState extends State<NewPrivateChatView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // A GlobalKey is used to identify this widget in the widget tree, used to access and modify its properties
    GlobalKey globalKeyQR = GlobalKey();

    final qrCodeSize =
    min(MediaQuery.of(context).size.width - 16, 256).toDouble();
    return BitNetScaffold(
      context: context,
      appBar: BitNetAppBar(
        context: context,
        onTap: () => Navigator.of(context).pop(),
        text: L10n.of(context)!.newChat,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
                left: AppTheme.cardPadding,
                right: AppTheme.cardPadding,
                top: AppTheme.cardPadding * 3),
            child: DefaultTabController(
              length: 3,
              initialIndex: 0,
              child: ButtonsTabBar(
                contentPadding: const EdgeInsets.symmetric(
                  vertical: AppTheme.elementSpacing * 0.5,
                  horizontal: AppTheme.elementSpacing,
                ),
                borderWidth: 1.5,
                unselectedBorderColor: Colors.transparent,
                borderColor: Colors.white.withOpacity(0.2),
                radius: 100,
                physics: ClampingScrollPhysics(),
                controller: _tabController,
                // give the indicator a decoration (color and border radius)
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.all(Radius.circular(50.0)),
                ),
                unselectedDecoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.all(Radius.circular(50.0)),
                ),
                tabs: [
                  Tab(
                    child: Text(
                      L10n.of(context)!.newChat,
                      style: AppTheme.textTheme.bodyMedium!.copyWith(
                          color: AppTheme.white80, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Tab(
                    child: Text(
                      L10n.of(context)!.createNewGroup,
                      style: AppTheme.textTheme.bodyMedium!.copyWith(
                          color: AppTheme.white80, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Tab(
                    child: Text(
                      L10n.of(context)!.createNewSpace,
                      style: AppTheme.textTheme.bodyMedium!.copyWith(
                          color: AppTheme.white80, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: AppTheme.cardPadding * 20,
            child: TabBarView(
                controller: _tabController,
                children: [
                  NewPrivateChatView(NewPrivateChatController()),
                  NewGroupView(NewGroupController()),
                  NewSpaceView(NewSpaceController()),
                ]),
          ),
        ],
      ),
    );
  }
}
