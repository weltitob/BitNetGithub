import 'dart:async';

import 'package:bitnet/backbone/helper/databaserefs.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/services/local_storage.dart';
import 'package:bitnet/backbone/services/protocol_controller.dart';
import 'package:bitnet/backbone/services/social_recovery_helper.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/buttons/appbaractions.dart';
import 'package:bitnet/components/buttons/bottom_buybuttons.dart';
import 'package:bitnet/components/buttons/lang_picker_widget.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/dialogsandsheets/notificationoverlays/overlay.dart';
import 'package:bitnet/components/fields/searchfield/searchfield.dart';
import 'package:bitnet/components/items/userresult.dart';
import 'package:bitnet/components/loaders/loaders.dart';
import 'package:bitnet/models/user/userdata.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class SocialRecoveryScreen extends StatefulWidget {
  const SocialRecoveryScreen({Key? key}) : super(key: key);

  @override
  State<SocialRecoveryScreen> createState() => _SocialRecoveryScreenState();
}

class _SocialRecoveryScreenState extends State<SocialRecoveryScreen> {
  bool isFinished = false; // a flag indicating whether the send process is finished
  bool readyForLogin = false; // a flag indicating wh
  late PageController controller;
  late Function() nodeListener;
  late FocusNode node;
  List<Map<String, dynamic>> searchUsers = List.empty(growable: true);
  List<Map<String, dynamic>> keyUsers = List.empty(growable: true);
  StreamSubscription<DocumentSnapshot<Map<String, dynamic>>>? socialRecoveryStream;
  Map<String, dynamic>? selectedUser;
  SocialRecoveryDocModel? socialRecoveryModel;
  //0 for failure but initUser exists, 1 for success, 2 for loading
  int state = 0;
  @override
  void initState() {
    node = FocusNode();

    controller = PageController();
    node.addListener(nodeListener = () {
      setState(() {});
    });
    //izak, intentional typo for testing purposes...
    String? initUser = LocalStorage.instance.getString('social_recovery_init_user');
    if (initUser != null && initUser.isNotEmpty) {
      setupRecoveryData(initUser, true);
    }
    super.initState();
  }

  Future<void> setupRecoveryData(String initUser, bool initUserExists) async {
    state = 2;
    setState(() {});
    await usersCollection.doc(initUser).get().then((userDoc) async {
      if (userDoc.data() == null) {
        state = 0;
      } else {
        selectedUser = {...userDoc.data()!, 'doc_id': userDoc.id};
        DocumentSnapshot<Map<String, dynamic>> socialDoc = await socialRecoveryCollection.doc(userDoc.data()!['username']).get();

        if (socialDoc.data() == null) {
          state = -1;
          if (controller.page == 0) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (initUserExists) {
                controller.jumpToPage(1);
              } else {
                controller.nextPage(duration: Duration(milliseconds: 200), curve: Curves.easeIn);
              }
            });
          }
          setState(() {});
        } else {
          Map<String, dynamic> socialData = socialDoc.data()!;
          socialRecoveryModel = SocialRecoveryDocModel.fromMap(socialData);
          bool allAcceptedInvite = true;
          for (int i = 0; i < socialRecoveryModel!.users.length; i++) {
            if (!socialRecoveryModel!.users[i].acceptedInvite) {
              allAcceptedInvite = false;
            }
          }

          if (!allAcceptedInvite ||
              socialRecoveryModel!.users.where((test) => test.username == selectedUser!['username']).first.openKey.isEmpty) {
            state = -2;
            if (controller.page == 0) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (initUserExists) {
                  controller.jumpToPage(1);
                } else {
                  controller.nextPage(duration: Duration(milliseconds: 200), curve: Curves.easeIn);
                }
              });
            }
            setState(() {});
            return;
          }
          if (socialRecoveryModel!.requestedRecovery && !initUserExists) {
            showOverlay(context, 'Someone else is trying to recover this account.', color: AppTheme.errorColor);
            state = 0;
            return;
          }
          List users = socialData['users'];
          for (int i = 0; i < users.length; i++) {
            if (users[i]['username'] == userDoc.data()!['username']) {
              continue;
            } else {
              QuerySnapshot<Map<String, dynamic>> querySnap =
                  await usersCollection.where('username', isEqualTo: users[i]['username']).get();
              if (querySnap.docs.isEmpty) {
                keyUsers.add({'username': users[i]['username'], 'exists': false});
              } else {
                keyUsers.add({
                  'doc_id': querySnap.docs.first.id,
                  ...querySnap.docs.first.data(),
                  'request_invited': users[i]['request_invited'],
                  'request_state': users[i]['request_state']
                });
              }
            }
          }
          if (!initUserExists) {
            await socialDoc.reference.update({'requested_recovery': true, 'request_timestamp': Timestamp.now()});
            LocalStorage.instance.setString(selectedUser!['doc_id'], 'social_recovery_init_user');
          }
          if (socialRecoveryStream == null) {
            socialRecoveryStream = socialRecoveryCollection.doc(userDoc.data()!['username']).snapshots().listen(streamListener);
          }
          if (controller.page == 0) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (initUserExists) {
                controller.jumpToPage(1);
              } else {
                controller.nextPage(duration: Duration(milliseconds: 200), curve: Curves.easeIn);
              }
            });
          }
          setState(() {});
        }
      }
    });
  }

  @override
  void dispose() {
    node.removeListener(nodeListener);
    socialRecoveryStream?.cancel();
    node.dispose();
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
      final screenWidth = MediaQuery.of(context).size.width;
      bool isSuperSmallScreen = constraints.maxWidth < AppTheme.isSuperSmallScreen;
      return bitnetScaffold(
          margin: isSuperSmallScreen ? const EdgeInsets.symmetric(horizontal: 0) : EdgeInsets.symmetric(horizontal: screenWidth / 2 - 250),
          extendBodyBehindAppBar: true,
          appBar: bitnetAppBar(
              actions: [
                GestureDetector(
                    onTap: () {
                      context.go('/authhome/login/social_recovery/info_social_recovery');
                    },
                    child: const AppBarActionButton(
                      iconData: Icons.info_outline_rounded,
                    )),
                const PopUpLangPickerWidget(),
              ],
              text: L10n.of(context)!.socialRecovery,
              context: context,
              onTap: () {
                if (controller.page == 1) {
                  controller.previousPage(duration: Duration(milliseconds: 200), curve: Curves.easeIn);
                }
                context.pop();
              }),
          body: PageView(
            controller: controller,
            children: [
              Stack(
                children: [
                  SingleChildScrollView(
                      child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: AppTheme.cardPadding, vertical: AppTheme.cardPadding),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: AppTheme.cardPadding * 3.h),
                              Text('Find your account', textAlign: TextAlign.left, style: Theme.of(context).textTheme.titleLarge),
                              SizedBox(height: AppTheme.cardPadding.h),
                              SearchFieldWidget(
                                  hintText: node.hasFocus ? 'type in your username...' : 'Search for your account here',
                                  isSearchEnabled: true,
                                  node: node,
                                  handleSearch: (query) async {
                                    List<Map<String, dynamic>> users = [];
                                    if (!query.isEmpty) {
                                      QuerySnapshot<Map<String, dynamic>> queryData = await usersCollection
                                          .where('username', isGreaterThanOrEqualTo: query)
                                          .where('username', isLessThanOrEqualTo: query + '\uf8ff')
                                          .get();
                                      users = queryData.docs.map((doc) => {'doc_id': doc.id, ...doc.data()}).toList();
                                    }

                                    searchUsers.clear();
                                    searchUsers.addAll(users);

                                    setState(() {});
                                  }),
                              SizedBox(height: AppTheme.elementSpacing.h),
                              Column(
                                  children: searchUsers
                                      .map((user) => Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                                            child: UserResult(
                                              userData: UserData.fromMap(user),
                                              onTap: () {
                                                selectedUser = user;
                                                setState(() {});
                                              },
                                              selected: selectedUser != null && selectedUser!['username'] == user['username'],
                                              onDelete: () {},
                                              model: 2,
                                            ),
                                          ))
                                      .toList())
                            ],
                          ))),
                  state == 2
                      ? Align(alignment: Alignment.bottomCenter, child: dotProgress(context))
                      : BottomCenterButton(
                          buttonState: selectedUser == null ? ButtonState.disabled : ButtonState.idle,
                          buttonTitle: 'Begin Recovery',
                          onButtonTap: () async {
                            await setupRecoveryData(selectedUser!['doc_id'], false);
                            if (socialRecoveryModel != null) {
                              for (int i = 0; i < socialRecoveryModel!.users.length; i++) {
                                if (socialRecoveryModel!.users[i].acceptedInvite &&
                                    socialRecoveryModel!.users[i].username != selectedUser!['username']) {
                                  //send invitation, (protocol_type: social_recovery_recovery_request)
                                  ProtocolModel model = ProtocolModel(
                                    protocolId: '',
                                    protocolType: 'social_recovery_recovery_request',
                                    protocolData: {'inviter_user_doc_id': selectedUser!['doc_id']},
                                    satisfied: false,
                                  );
                                  String? userDocID = keyUsers
                                      .where((test) => test['username'] == socialRecoveryModel!.users[i].username)
                                      .firstOrNull?['doc_id'];
                                  if (userDocID != null) {
                                    model.sendProtocol(userDocID);
                                  }
                                }
                              }
                            }
                          },
                          onButtonTapDisabled: () {
                            showOverlay(context, 'Please find your account first.', color: AppTheme.errorColor);
                          })
                ],
              ),
              state == -1 || state == -2
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text(
                            state == -1
                                ? 'This account does not have social recovery set up.'
                                : 'The social recovery set up for this account was never completed.',
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    )
                  : Stack(
                      children: [
                        SingleChildScrollView(
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: AppTheme.cardPadding, vertical: AppTheme.cardPadding),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: AppTheme.cardPadding * 3.h,
                                ),
                                Text(
                                  L10n.of(context)!.recoverAccount,
                                  textAlign: TextAlign.left,
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                                Container(
                                  height: AppTheme.cardPadding.h,
                                ),
                                if (selectedUser != null) ...[
                                  UserResult(
                                    onTap: () async {},
                                    onDelete: () {},
                                    userData: UserData.fromMap(selectedUser!),
                                    model: 2,
                                  )
                                ],
                                Container(
                                  height: AppTheme.elementSpacing,
                                ),
                                Text(
                                  L10n.of(context)!.contactFriendsForRecovery,
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                                Container(
                                  height: AppTheme.cardPadding * 2.h,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      L10n.of(context)!.friendsKeyIssuers,
                                      textAlign: TextAlign.left,
                                      style: Theme.of(context).textTheme.titleLarge,
                                    ),
                                    IconButton(
                                        icon: Icon(Icons.refresh),
                                        onPressed: () {
                                          if (socialRecoveryModel!.requestTimestamp == null) {
                                            showOverlay(context, 'something bad happened. please try again later.',
                                                color: AppTheme.errorColor);
                                          } else {
                                            if (socialRecoveryModel!.requestTimestamp!
                                                    .toDate()
                                                    .difference(DateTime.now())
                                                    .compareTo(Duration(days: 7)) <
                                                0) {
                                              showOverlay(context, 'You can only send recovery requests once every week.',
                                                  color: AppTheme.errorColor);
                                            } else {
                                              for (int i = 0; i < socialRecoveryModel!.users.length; i++) {
                                                if (socialRecoveryModel!.users[i].acceptedInvite &&
                                                    socialRecoveryModel!.users[i].username != selectedUser!['username']) {
                                                  //send invitation, (protocol_type: social_recovery_recovery_request)
                                                  ProtocolModel model = ProtocolModel(
                                                    protocolId: '',
                                                    protocolType: 'social_recovery_recovery_request',
                                                    protocolData: {'inviter_user_doc_id': selectedUser!['doc_id']},
                                                    satisfied: false,
                                                  );
                                                  model.sendProtocol(keyUsers
                                                      .where((test) => test['username'] == socialRecoveryModel!.users[i].username)
                                                      .first['doc_id']);
                                                }
                                              }
                                              socialRecoveryCollection
                                                  .doc(selectedUser!['username'])
                                                  .update({'request_timestamp': Timestamp.now()});
                                              showOverlay(context, 'Successfully sent recovery requests.', color: AppTheme.successColor);
                                            }
                                          }
                                        })
                                  ],
                                ),
                                if (socialRecoveryModel != null &&
                                    ((socialRecoveryModel!.invitedUsersAmount -
                                            socialRecoveryModel!.users
                                                .map((user) {
                                                  return user.requestState == 1 ? 1 : 0;
                                                })
                                                .toList()
                                                .reduce((val1, val2) => val1 + val2)) <
                                        3)) ...[
                                  Text(
                                      'Too many users have denied the recovery request, you can send them another request once the week is up.')
                                ],
                                SizedBox(
                                  height: AppTheme.elementSpacing,
                                ),
                                Column(
                                    children: keyUsers.map((userMap) {
                                  if (userMap.containsKey('exists') && !userMap['exists']) {
                                    return UserResult(
                                        userData: UserData(
                                            backgroundImageUrl: '',
                                            isPrivate: false,
                                            showFollowers: false,
                                            did: '',
                                            displayName: '',
                                            bio: '',
                                            customToken: '',
                                            username: userMap['username'],
                                            profileImageUrl: '',
                                            createdAt: Timestamp.now(),
                                            updatedAt: Timestamp.now(),
                                            isActive: false,
                                            dob: 0),
                                        onTap: () {},
                                        onDelete: () {},
                                        obscureUsername: true,
                                        model: 3);
                                  } else {
                                    return UserResult(
                                        userData: UserData.fromMap(userMap),
                                        invited: userMap['request_invited'],
                                        acceptedInvite: userMap['request_state'],
                                        onTap: () {},
                                        onDelete: () {},
                                        obscureUsername: true,
                                        model: 4);
                                  }
                                }).toList())
                              ],
                            ),
                          ),
                        ),
                        // Positioned(
                        //     bottom: AppTheme.cardPadding * 2.h,
                        //     child: Padding(
                        //       padding: const EdgeInsets.symmetric(
                        //           horizontal: AppTheme.cardPadding),
                        //       child: Container(
                        //           alignment: Alignment.center,
                        //           height: AppTheme.cardPadding * 2.5.h,
                        //           width: screenWidth - AppTheme.cardPadding * 2.w,
                        //           child: LongButtonWidget(
                        //             customWidth: AppTheme.cardPadding * 14.w,
                        //             title: L10n.of(context)!.recoverAccount,
                        //             onTap: () {},
                        //           )),
                        //     )),
                        BottomCenterButton(
                          buttonTitle: 'Recover Account',
                          onButtonTap: () async {
                            if (socialRecoveryModel == null) {
                              showOverlay(context, 'Something bad happened, please try again later.', color: AppTheme.errorColor);
                              return;
                            }
                            int successfulInvites = socialRecoveryModel!.users.where((test) => test.requestState == 2).length;
                            if (successfulInvites >= 3) {
                              ProtocolModel model = ProtocolModel(
                                  protocolId: '',
                                  activateTime: Timestamp.fromDate(DateTime.now().add(Duration(days: 3))),
                                  protocolType: 'social_recovery_show_mnemonic',
                                  protocolData: {'user_doc_id': selectedUser!['doc_id'], 'user_name': selectedUser!['username']});
                              model.sendProtocol(await getDeviceInfo());
                              print('izaksprints deviceId: ${await getDeviceInfo()}');
                              ProtocolModel modelAccess =
                                  ProtocolModel(protocolId: '', protocolType: 'social_recovery_access_attempt', protocolData: {});
                              modelAccess.sendProtocol(selectedUser!['doc_id']);
                              showOverlay(context, 'Your mnemonic will be retrieved in 3 days');
                            } else {
                              showOverlay(context, 'Not enough people have accepted the social recovery request yet.',
                                  color: AppTheme.errorColor);
                            }
                          },
                          buttonState: ButtonState.idle,
                        ),
                      ],
                    ),
            ],
          ),
          context: context);
    });
  }

  void streamListener(DocumentSnapshot<Map<String, dynamic>> event) {
    if (event.data() != null) {
      Map<String, dynamic> data = event.data()!;
      socialRecoveryModel = SocialRecoveryDocModel.fromMap(data);
      for (int i = 0; i < socialRecoveryModel!.users.length; i++) {
        SocialRecoveryUser user = socialRecoveryModel!.users[i];
        bool reqInvited = user.requestInvited;
        int reqState = user.requestState;
        int index = keyUsers.indexWhere((test) => test['username'] == user.username);
        if (index != -1) {
          keyUsers[index]['request_state'] = reqState;
          keyUsers[index]['request_invited'] = reqInvited;
        }
      }

      if (mounted) setState(() {});
    }
  }
}
