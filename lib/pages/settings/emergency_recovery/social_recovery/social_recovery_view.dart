import 'package:bitnet/backbone/auth/auth.dart';
import 'package:bitnet/backbone/auth/storePrivateData.dart';
import 'package:bitnet/backbone/helper/databaserefs.dart';
import 'package:bitnet/backbone/helper/key_services/bip39_did_generator.dart';
import 'package:bitnet/backbone/helper/responsiveness/max_width_body.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/services/social_recovery_helper.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/buttons/bottom_buybuttons.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/container/imagewithtext.dart';
import 'package:bitnet/components/dialogsandsheets/notificationoverlays/overlay.dart';
import 'package:bitnet/components/fields/searchfield/searchfield.dart';
import 'package:bitnet/components/items/userresult.dart';
import 'package:bitnet/components/loaders/loaders.dart';
import 'package:bitnet/main.dart';
import 'package:bitnet/models/keys/privatedata.dart';
import 'package:bitnet/models/user/userdata.dart';
import 'package:bitnet/pages/auth/mnemonicgen/mnemonic_field_widget.dart';
import 'package:bitnet/pages/auth/mnemonicgen/mnemonicgen.dart';
import 'package:bitnet/pages/profile/profile_controller.dart';
import 'package:bitnet/pages/settings/bottomsheet/settings_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:popover/popover.dart';

class SocialRecoveryView extends GetWidget<SettingsController> {
  SocialRecoveryView({Key? key}) : super(key: key);
  final GlobalKey<MnemonicFieldWidgetState> mnemonicFieldKey =
      GlobalKey<MnemonicFieldWidgetState>();
  @override
  Widget build(BuildContext context) {
    const colorPickerSize = AppTheme.cardPadding * 1.5;
    final overlayController = Get.find<OverlayController>();

    return bitnetScaffold(
      extendBodyBehindAppBar: false,
      context: context,
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: controller.pageControllerSocialRecovery,
        children: [
          if (controller.initiateSocialRecovery.value != 2)
            Stack(
              children: [
                if (controller.initiateSocialRecovery.value != 2)
                  MaxWidthBody(
                    withScrolling: true,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: AppTheme.cardPadding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: AppTheme.cardPadding * 1,
                          ),
                          SearchFieldWidget(
                            hintText: 'Search for users here',
                            isSearchEnabled: true,
                            handleSearch: (String query) async {
                              List<Map<String, dynamic>> users = [];
                              if (!query.isEmpty) {
                                QuerySnapshot<Map<String, dynamic>> queryData =
                                    await usersCollection
                                        .where('username',
                                            isGreaterThanOrEqualTo: query)
                                        .where('username',
                                            isLessThanOrEqualTo:
                                                query + '\uf8ff')
                                        .get();
                                users = queryData.docs
                                    .map((doc) =>
                                        {'doc_id': doc.id, ...doc.data()})
                                    .toList();
                              }

                              controller.socialRecoveryUsers.clear();
                              controller.socialRecoveryUsers.addAll(users);
                            },
                          ),
                          const SizedBox(
                            height: AppTheme.elementSpacing,
                          ),
                          Obx(() {
                            List<Map<String, dynamic>> users = [
                              ...controller.selectedUsers,
                              ...controller.socialRecoveryUsers
                            ];
                            removeAllDuplicates(users);
                            users.removeWhere((test1) =>
                                controller.selectedUsers.firstWhereOrNull(
                                    (test2) => test2['did'] == test1['did']) !=
                                null);
                            users = [...controller.selectedUsers, ...users];
                            return Column(
                                children: users
                                    .map((user) => Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 8.0),
                                          child: UserResult(
                                              userData: UserData.fromMap(user),
                                              onTap: () {
                                                if (controller.selectedUsers
                                                        .firstWhereOrNull(
                                                            (test) =>
                                                                test['did'] ==
                                                                user['did']) !=
                                                    null) {
                                                  controller.selectedUsers
                                                      .removeWhere((test) =>
                                                          test['did'] ==
                                                          user['did']);
                                                } else {
                                                  if (controller.selectedUsers
                                                          .length <
                                                      5) {
                                                    controller.selectedUsers
                                                        .add(user);
                                                  } else {
                                                    overlayController.showOverlay(
                                                        'You already have 5 users selected, please deselect one, then try again.',
                                                        color: AppTheme
                                                            .errorColor);
                                                  }
                                                }
                                              },
                                              onDelete: () {},
                                              model: 1,
                                              onTapIcon: controller
                                                          .selectedUsers
                                                          .firstWhereOrNull(
                                                              (test) =>
                                                                  user['did'] ==
                                                                  test[
                                                                      'did']) !=
                                                      null
                                                  ? Icons.check
                                                  : null),
                                        ))
                                    .toList());
                          }),
                          SizedBox(height: 200),
                        ],
                      ),
                    ),
                  ),
                Obx(
                  () => BottomCenterButton(
                    buttonTitle: 'Activate',
                    buttonState: (controller.selectedUsers.length >= 3 &&
                            controller.selectedUsers.length <= 5)
                        ? ButtonState.idle
                        : ButtonState.disabled,
                    onButtonTap: () async {
                      controller.pageControllerSocialRecovery.nextPage(
                          duration: Duration(milliseconds: 200),
                          curve: Curves.easeIn);
                    },
                    onButtonTapDisabled: () {
                      overlayController.showOverlay(
                          'You should select atleast 3 users and at most 5.',
                          color: AppTheme.errorColor);
                    },
                  ),
                )
              ],
            ),
          if (controller.initiateSocialRecovery.value != 2)
            Stack(children: [
              SingleChildScrollView(
                child: MnemonicFieldWidget(
                  mnemonicController: null,
                  key: mnemonicFieldKey,
                  triggerMnemonicCheck: (mCtrl, tCtrls) {
                    //triggerMnemonicCheck(context, mCtrl, tCtrls);
                  },
                ),
              ),
              BottomCenterButton(
                buttonTitle: 'Confirm',
                buttonState: ButtonState.idle,
                onButtonTap: () async {
                  //this was the same before ==> when this works we should be done
                  String did = Auth().currentUser!.uid;
                  PrivateData privData =
                      await getPrivateData(Auth().currentUser!.uid);

                  // OLD: Multiple users one node approach - HDWallet-based key derivation
                  // HDWallet hdWallet = HDWallet.fromMnemonic(privData.mnemonic);
                  // initiateSocialSecurity(privData.mnemonic, hdWallet.privkey, controller.selectedUsers.length, invitedUsers)
                  
                  // NEW: One user one node approach - BIP39-based key derivation
                  Map<String, String> keys = Bip39DidGenerator.generateKeysFromMnemonic(privData.mnemonic);
                  String privateKey = keys['privateKey']!;
                  List<UserData> invitedUsers = controller.selectedUsers
                      .map((item) => UserData.fromMap(item))
                      .toList();

                  initiateSocialSecurity(privData.mnemonic, privateKey,
                          controller.selectedUsers.length, invitedUsers)
                      .then((val) {
                    controller.initiateSocialRecovery.value = val ? 2 : 1;
                  });

                  controller.pageControllerSocialRecovery.nextPage(
                      duration: Duration(milliseconds: 200),
                      curve: Curves.easeIn);

                  triggerMnemonicCheck(context, null,
                      mnemonicFieldKey.currentState?.textControllers ?? []);
                },
                onButtonTapDisabled: () {
                  overlayController.showOverlay(
                      'Please fill out your Mnemonic.',
                      color: AppTheme.errorColor);
                },
              ),
            ]),
          Stack(
            children: [
              Obx(
                () => MaxWidthBody(
                    child: controller.initiateSocialRecovery.value == 0
                        ? dotProgress(context)
                        : controller.initiateSocialRecovery.value == 2
                            ? Padding(
                                padding: EdgeInsets.only(left: 8.0, right: 8.0),
                                child: Column(children: [
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          color: Theme.of(context).brightness ==
                                                  Brightness.light
                                              ? Colors.black
                                              : Colors.white),
                                    ),
                                    child: Icon(Icons.check, size: 128),
                                  ),
                                  SizedBox(height: 16),
                                  Text(
                                    'Your social recovery has been activated, you will be notified when all your friends have accepted their invites.',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall,
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(height: 8),
                                  Divider(indent: 32, endIndent: 32),
                                  Text(
                                    'Select Restore Account -> Social Recovery in cases of emergency',
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(height: 25),
                                ]))
                            : Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Column(children: [
                                  SizedBox(
                                    height: 50,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          color: Theme.of(context).brightness ==
                                                  Brightness.light
                                              ? Colors.black
                                              : Colors.white),
                                    ),
                                    child: Icon(Icons.clear, size: 128),
                                  ),
                                  SizedBox(height: 16),
                                  Text(
                                    'Something bad happened...',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall,
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(height: 8),
                                  Divider(indent: 32, endIndent: 32),
                                  Text(
                                    'Please try again later.',
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(height: 25),
                                ]))),
              ),
              Obx(
                () => controller.isLoadingCancelSocialRecoveryButton.value
                    ? Align(
                        alignment: Alignment.bottomCenter,
                        child: dotProgress(context))
                    : BottomCenterButton(
                        buttonTitle: 'Cancel Social Recovery',
                        buttonState: ButtonState.idle,
                        onButtonTap: () async {
                          controller.isLoadingCancelSocialRecoveryButton.value =
                              true;

                          SocialRecoveryDocModel socialRecoveryModel =
                              SocialRecoveryDocModel.fromMap(
                                  (await socialRecoveryCollection
                                          .doc(Get.find<ProfileController>()
                                              .userData
                                              .value
                                              .username)
                                          .get())
                                      .data()!);

                          for (SocialRecoveryUser user
                              in socialRecoveryModel.users) {
                            String userDocId = (await usersCollection
                                    .where('username', isEqualTo: user.username)
                                    .get())
                                .docs
                                .first
                                .id;
                            QuerySnapshot<Map<String, dynamic>> qSnap =
                                await protocolCollection
                                    .doc(userDocId)
                                    .collection('protocols')
                                    .where('protocol_type',
                                        isEqualTo:
                                            'social_recovery_invite_user')
                                    .get();
                            for (DocumentSnapshot<Map<String, dynamic>> doc
                                in qSnap.docs) {
                              if (doc.data() != null &&
                                  doc.data()!['protocol_data']
                                          ['inviter_doc_id'] ==
                                      Get.find<ProfileController>()
                                          .userData
                                          .value
                                          .did) {
                                await doc.reference.delete();
                              }
                            }
                          }
                          socialRecoveryCollection
                              .doc(Get.find<ProfileController>()
                                  .userData
                                  .value
                                  .username)
                              .delete();
                          controller.isLoadingCancelSocialRecoveryButton.value =
                              false;

                          context.pop();
                          controller.initiateSocialRecovery.value = 0;
                          // controller
                          //     .pageControllerSocialRecovery = PageController(
                          //   initialPage: 0,
                          // );
                        }),
              )
            ],
          )
        ],
      ),
    );
  }

  void removeAllDuplicates(List<Map<String, dynamic>> list) {
    Map<String, int> didCount = {};

    // Count occurrences of each 'did'
    for (var item in list) {
      didCount[item['did']] = (didCount[item['did']] ?? 0) + 1;
    }

    // Remove items that have duplicates
    list.removeWhere((item) =>
        (didCount[item['did']]! > 1) || item['did'] == Auth().currentUser!.uid);
  }

  triggerMnemonicCheck(BuildContext context, MnemonicController? mCtrl,
      List<TextEditingController> tCtrls) async {
    final overlayController = Get.find<OverlayController>();

    final String mnemonic =
        tCtrls.map((controller) => controller.text).join(' ');
    PrivateData privData = await getPrivateData(Auth().currentUser!.uid);

    if (privData.mnemonic == mnemonic) {
      String did = Auth().currentUser!.uid;

      // OLD: Multiple users one node approach - HDWallet-based key derivation
      // HDWallet hdWallet = HDWallet.fromMnemonic(privData.mnemonic);
      // initiateSocialSecurity(privData.mnemonic, hdWallet.privkey, controller.selectedUsers.length, invitedUsers)
      
      // NEW: One user one node approach - BIP39-based key derivation
      Map<String, String> keys = Bip39DidGenerator.generateKeysFromMnemonic(privData.mnemonic);
      String privateKey = keys['privateKey']!;
      List<UserData> invitedUsers = controller.selectedUsers
          .map((item) => UserData.fromMap(item))
          .toList();

      initiateSocialSecurity(privData.mnemonic, privateKey,
              controller.selectedUsers.length, invitedUsers)
          .then((val) {
        controller.initiateSocialRecovery.value = val ? 2 : 1;
      });

      controller.pageControllerSocialRecovery.nextPage(
          duration: Duration(milliseconds: 200), curve: Curves.easeIn);
    } else {
      overlayController.showOverlay(
          'Your Mnemonic was Incorrect, please try again',
          color: AppTheme.errorColor);
    }

    controller.pageControllerSocialRecovery
        .nextPage(duration: Duration(milliseconds: 200), curve: Curves.easeIn);
    // Future.delayed(Duration(seconds: 10), () {
    //   if (context.mounted) {
    //     context.pop();
    //   }
    // });
  }
}

class SocialRecoveryInfoAction extends StatelessWidget {
  const SocialRecoveryInfoAction({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return IconButton(
        icon: Icon(Icons.info),
        onPressed: () {
          showPopover(
            backgroundColor: Colors.transparent,
            contentDxOffset: -200,
            context: context,
            direction: PopoverDirection.bottom,
            bodyBuilder: (context) {
              return GlassContainer(
                opacity: 0.5,
                width: 200,
                height: 250,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Please Select your social recovery users',
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(color: Colors.white),
                      ),
                      SizedBox(height: 5),
                      Text(
                          'These users will help recover your account in case of emergency',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodySmall),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Minimum: ',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(color: Colors.white)),
                          Text('3',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(color: Colors.white))
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Maximum: ',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(color: Colors.white)),
                          Text('5',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white))
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      );
    });
  }
}
