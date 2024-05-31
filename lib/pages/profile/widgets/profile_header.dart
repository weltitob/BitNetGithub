import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/container/avatar.dart';
import 'package:bitnet/components/dialogsandsheets/dialogs/dialogs.dart';
import 'package:bitnet/pages/profile/profile_controller.dart';
import 'package:bitnet/pages/profile/widgets/center_widget.dart';
import 'package:bitnet/pages/profile/widgets/profile_button.dart';
import 'package:bitnet/pages/profile/widgets/qr_button.dart';
import 'package:bitnet/pages/profile/widgets/setting_button.dart';
import 'package:bitnet/pages/profile/widgets/user_information.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProfileController>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(alignment: Alignment.center, children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  color: Colors.black,
                  boxShadow: [AppTheme.boxShadowProfile],
                  image: DecorationImage(
                    image: NetworkImage(controller.userData.backgroundImageUrl),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.25), BlendMode.dstATop),
                  ),
                  borderRadius: BorderRadius.only(
                      bottomLeft: AppTheme.cornerRadiusBig,
                      bottomRight: AppTheme.cornerRadiusBig),
                ),
                child: Column(
                  children: [
                    const SizedBox(height: AppTheme.cardPadding * 3),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: GestureDetector(
                            onTap: controller.currentview.value != 2
                                ? () {
                                    print('follow dagelassen lol');
                                  }
                                : () {
                                    showDialogueMultipleOptions(
                                      isActives: [
                                        true,
                                        true,
                                        true,
                                        true,
                                      ],
                                      actions: [
                                        () {},
                                        () {},
                                        () {},
                                        () {},
                                      ],
                                      images: [
                                        'assets/images/bitcoin.png',
                                        'assets/images/bitcoin.png',
                                        'assets/images/bitcoin.png',
                                        'assets/images/bitcoin.png',
                                      ],
                                      texts: [
                                        'Profilepic',
                                        'Background',
                                        'Porfile NFT',
                                        'Backgr. NFT',
                                      ],
                                      context: context,
                                    );
                                  },
                            child: Stack(
                              children: [
                                Avatar(
                                  mxContent: Uri.parse(
                                      controller.userData.profileImageUrl),
                                  size: AppTheme.cardPadding * 5.75,
                                  type: profilePictureType.lightning,
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: 4,
                                  child: ProfileButton(),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppTheme.elementSpacing / 2),
                    UserInformation(),
                    const SizedBox(height: AppTheme.cardPadding * 2),
                  ],
                ),
              ),
              const SizedBox(
                height: 40,
              ),
            ],
          ),
          SettingsButton(),
          QrButton(),
          CenterWidget(),
        ]),
      ],
    );
    ;
  }
}
