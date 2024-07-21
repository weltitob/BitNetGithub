import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/dialogsandsheets/bottom_sheets/bit_net_bottom_sheet.dart';
import 'package:bitnet/components/loaders/loaders.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:bitnet/pages/profile/profile_controller.dart';
import 'package:bitnet/pages/profile/widgets/profile_header.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final controller = Get.put(ProfileController());

  @override
  void initState() {
    super.initState();
    controller.scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    controller.scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  void _scrollListener() {
    if (controller.scrollController.position.pixels ==
            controller.scrollController.position.maxScrollExtent &&
        !controller.assetsLoading) {
      _loadMoreData();
    }
  }

  Future<void> _loadMoreData() async {
    if (controller.assetsLoading == false) {
      setState(() {
        controller.assetsLoading = true;
      });

      // Call controller method to load more assets
      await controller.loadMoreAssets();

      setState(() {
        controller.assetsLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // final myuser = Auth().currentUser!.uid;
    return Obx(
      () => bitnetScaffold(
        context: context,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: controller.isUserLoading.value
            ? Center(child: dotProgress(context))
            : ListView(
                controller: controller.scrollController,
                children: [
                  ProfileHeader(),
                  SizedBox(height: AppTheme.cardPadding * 0.75,),
                  Obx(() {
                    return controller.pages[controller.currentview.value];
                  }),
                ],
              ),
        floatingActionButton: Align(
          alignment: Alignment.bottomCenter,
          child: LongButtonWidget(
            buttonType: ButtonType.solid,
            customHeight: AppTheme.cardPadding * 2,
            customWidth: AppTheme.cardPadding * 4,
            leadingIcon: Icon(
              FontAwesomeIcons.add,
              color: Theme.of(context).brightness == Brightness.light
                  ? AppTheme.black80
                  : AppTheme.white80,
            ),
            title: 'Add',
            onTap: () {
              context.go('/create');
            },
          ),
        ),
      ),
    );
  }

  void onQRButtonPressed(BuildContext context) {
    BitNetBottomSheet(
      width: MediaQuery.sizeOf(context).width,
      context: context,
      child: bitnetScaffold(
        extendBodyBehindAppBar: false,
        appBar: bitnetAppBar(
          hasBackButton: false,
          context: context,
          buttonType: ButtonType.transparent,
          text: L10n.of(context)!.shareQrCode,
        ),
        context: context,
        body: Center(
          child: RepaintBoundary(
            key: controller.globalKeyQR,
            child: Column(
              children: [
                SizedBox(height: AppTheme.cardPadding * 4),
                Container(
                  margin: EdgeInsets.all(AppTheme.cardPadding),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: AppTheme.cardRadiusSmall),
                  child: Padding(
                    padding: const EdgeInsets.all(AppTheme.elementSpacing),
                    child: PrettyQr(
                      typeNumber: 5,
                      size: AppTheme.cardPadding * 10,
                      data: 'did: ${controller.userData.value.did}',
                      errorCorrectLevel: QrErrorCorrectLevel.M,
                      roundEdges: true,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
