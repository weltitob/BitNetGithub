import 'dart:math';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/BitNetTabBar.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/pages/chat_list/createnew/new_group/new_group.dart';
import 'package:bitnet/pages/chat_list/createnew/new_private_chat/new_private_chat.dart';
import 'package:bitnet/pages/chat_list/createnew/new_space/new_space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:vrouter/vrouter.dart';

class CreateNewScreen extends StatefulWidget {
  final int initialIndex;
  const CreateNewScreen({Key? key, required this.initialIndex})
      : super(key: key);

  @override
  State<CreateNewScreen> createState() => _CreateNewScreenState();
}

class _CreateNewScreenState extends State<CreateNewScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late String _title;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
        length: 3, vsync: this, initialIndex: widget.initialIndex);
    _tabController.addListener(_handleTabSelection);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _title = _getTitle(_tabController.index); // Set the initial title here.
  }

  void _handleTabSelection() {
    setState(() {
      _title = _getTitle(_tabController.index);
    });
  }

  String _getTitle(int index) {
    switch (index) {
      case 0:
        return L10n.of(context)!.newChat;
      case 1:
        return L10n.of(context)!.createNewGroup;
      case 2:
        return L10n.of(context)!.createNewSpace;
      default:
        return L10n.of(context)!.newChat;
    }
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabSelection);
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // A GlobalKey is used to identify this widget in the widget tree, used to access and modify its properties
    GlobalKey globalKeyQR = GlobalKey();

    final qrCodeSize =
        min(MediaQuery.of(context).size.width - 16, 256).toDouble();
    return bitnetScaffold(
      context: context,
      appBar: bitnetAppBar(
        context: context,
        onTap: () => VRouter.of(context).to('/rooms'),
        text: _title,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: AppTheme.cardPadding * 1),
              child: Container(
                margin:
                    EdgeInsets.symmetric(horizontal: AppTheme.elementSpacing),
                alignment: Alignment.center,
                child: DefaultTabController(
                  length: 3,
                  initialIndex: 0,
                  child: Container(
                    height: AppTheme.elementSpacing * 3,
                    child: BitNetTabBar(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: AppTheme.elementSpacing,
                      ),
                      //buttonMargin: EdgeInsets.only(left: AppTheme.elementSpacing, right: AppTheme.elementSpacing),
                      tabController: _tabController,
                      tabs: [
                        Tab(
                          child: Text(
                            L10n.of(context)!.newChat,
                            style: AppTheme.textTheme.titleSmall!.copyWith(
                                color: AppTheme.white80,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Tab(
                          child: Text(
                            L10n.of(context)!.createNewGroup,
                            style: AppTheme.textTheme.titleSmall!.copyWith(
                                color: AppTheme.white80,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Tab(
                          child: Text(
                            L10n.of(context)!.createNewSpace,
                            style: AppTheme.textTheme.titleSmall!.copyWith(
                                color: AppTheme.white80,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height -
                  AppTheme.cardPadding * 10.5,
              child: TabBarView(controller: _tabController, children: [
                const NewPrivateChat(),
                const NewGroup(),
                const NewSpace(),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
