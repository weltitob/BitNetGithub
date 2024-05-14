import 'package:bitnet/backbone/auth/auth.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/dialogsandsheets/bottom_sheets/bit_net_bottom_sheet.dart';
import 'package:bitnet/components/loaders/loaders.dart';
import 'package:bitnet/pages/profile/profile_controller.dart';
import 'package:bitnet/pages/profile/widgets/profile_header.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

class ProfileView extends StatelessWidget {
  final ProfileController controller;

  const ProfileView(this.controller, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final myuser = Auth().currentUser!.uid;
    print('myuser: $myuser');
    final String currentUserId = controller.profileId;
    // bool isProfileOwner = currentUserId == myuser;
    // final testuser = UserPreferences.myUser;

    return Obx(
      () => bitnetScaffold(
        context: context,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: controller.isUserLoading.value
            ? Center(
                child: dotProgress(context),
              )
            : ListView(
                children: [
                  ProfileHeader(),
                  controller.pages[controller.currentview.value],
                  // ProfilePosts(userId: currentUserId),
                ],
              ),
      ),
    );
  }

  void onQRButtonPressed(BuildContext context) {
    BitNetBottomSheet(
      width: MediaQuery.sizeOf(context).width,
      context: context,
      title: "Share Profile",
      iconData: Icons.qr_code_rounded,
      child: Center(
        child: RepaintBoundary(
          key: controller.globalKeyQR,
          child: Column(
            children: [
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
                    data: 'did: ${controller.userData.did}',
                    errorCorrectLevel: QrErrorCorrectLevel.M,
                    roundEdges: true,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
