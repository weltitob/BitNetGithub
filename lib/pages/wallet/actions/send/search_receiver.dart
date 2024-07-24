import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/appstandards/fadelistviewwrapper.dart';
import 'package:bitnet/components/buttons/bottom_buybuttons.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/container/avatar.dart';
import 'package:bitnet/components/container/imagewithtext.dart';
import 'package:bitnet/components/fields/searchfield/searchfield.dart';
import 'package:bitnet/pages/wallet/actions/send/controllers/send_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:flutter_keyboard_size/flutter_keyboard_size.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:go_router/go_router.dart';

class SearchReceiver extends GetWidget<SendsController> {
  const SearchReceiver({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return KeyboardSizeProvider(
      child: bitnetScaffold(
        extendBodyBehindAppBar: true,
        appBar: bitnetAppBar(
          text: L10n.of(context)!.chooseReceipient,
          context: context,
          onTap: () {
            context.go('/feed');
          },
        ),
        context: context,
        body: PopScope(
          canPop: false,
          onPopInvoked: (v) {
            context.go('/feed');
          },
          child: Stack(
            children: [
              Column(
                children: [
                  SizedBox(
                    height: AppTheme.cardPadding * 2,
                  ),
                  Consumer<ScreenHeight>(
                    builder: (ctx, res, child) {
                      if (!res.isOpen) {
                        controller.myFocusNodeAdressSearch.unfocus();
                      }
                      return child!;
                    },
                    child: SearchFieldWidget(
                      hintText: L10n.of(context)!.searchReceipient,
                      isSearchEnabled: true,
                      handleSearch: controller.handleSearch,
                      node: controller.myFocusNodeAdressSearch,
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.7,
                    width: 500,
                    child: ListView(
                        controller: controller.sendScrollerController,
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                              right: AppTheme.cardPadding,
                              left: AppTheme.cardPadding,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "Featured",
                                  style: Theme.of(context).textTheme.titleLarge,
                                  textAlign: TextAlign.left,
                                ),
                                SizedBox(
                                  height: AppTheme.cardPadding,
                                ),
                                GlassContainer(
                                  width: MediaQuery.of(context).size.width,
                                  height: AppTheme.cardPadding * 8.h,
                                  child: Container(
                                    margin: EdgeInsets.all(AppTheme.elementSpacing),
                                    child: MostPopularWidget(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: AppTheme.cardPadding * 4),

                          Padding(
                              padding: EdgeInsets.only(left: AppTheme.cardPadding),
                              child: Text("Support Bitcoin Devs", style: Theme.of(context).textTheme.titleLarge)),
                          SizedBox(
                            height: AppTheme.cardPadding / 2,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: 125,
                            child: HorizontalFadeListView(
                              child: Obx(
                                () => ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: controller.resendUsers.length,
                                    itemBuilder: (context, i) {
                                      return UserSendWidget(
                                        user: controller.resendUsers[i],
                                        controller: controller,
                                      );
                                    }),
                              ),
                            ),
                          ),
                          //space
                          SizedBox(height: AppTheme.cardPadding * 2),

                          //tab2

                          if (controller.resendUsers.isNotEmpty) ...[
                            Padding(
                                padding: EdgeInsets.only(left: AppTheme.cardPadding),
                                child: Text("Send Again", style: Theme.of(context).textTheme.titleLarge)),
                            SizedBox(
                              height: AppTheme.cardPadding / 2,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 125,
                              child: HorizontalFadeListView(
                                child: Obx(
                                  () => ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: controller.resendUsers.length,
                                      itemBuilder: (context, i) {
                                        return UserSendWidget(
                                          user: controller.resendUsers[i],
                                          controller: controller,
                                        );
                                      }),
                                ),
                              ),
                            ),
                          ],
                          Container(height: 50)
                        ]),
                  )
                  // Expanded(
                  //   child: SingleChildScrollView(
                  //     physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                  //     controller: controller.sendScrollerController,

                  //     reverse: false,
                  //     child: Container(
                  //                 height: MediaQuery.of(context).size.height * 1.5,
                  //       child: Column(
                  //         mainAxisSize: MainAxisSize.max,
                  //         children: [
                  //           Container(height: 1)
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
              BottomCenterButton(
                onButtonTap: () async {
                  controller.processParameters(context, (await context.push("/qrscanner")) as String?);
                },
                buttonTitle: L10n.of(context)!.scanQr,
                buttonState: ButtonState.idle,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class MostPopularWidget extends StatefulWidget {
  @override
  State<MostPopularWidget> createState() => _MostPopularWidgetState();
}

class _MostPopularWidgetState extends State<MostPopularWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Text(
                  "Tor",
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                SizedBox(
                  height: AppTheme.elementSpacing,
                ),
                Avatar(
                  size: AppTheme.cardPadding * 2.75,
                  name: "Tor (bc...)",
                  mxContent: Uri.parse("https://kinsta.com/wp-content/uploads/2023/03/tor-browser-logo.png"),
                ),
                SizedBox(
                  height: AppTheme.elementSpacing / 2,
                ),
                Container(
                  width: AppTheme.cardPadding * 3,
                  child: Text(
                    "bc1qtt04zfgjxg7lpqhk9vk8hnmnwf88ucwww5arsd",
                    style: Theme.of(context).textTheme.bodySmall,
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              ],
            ),
            Column(
              children: [
                Text(
                  "Wikileaks",
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                SizedBox(
                  height: AppTheme.elementSpacing,
                ),
                Avatar(
                  size: AppTheme.cardPadding * 2.75,
                  name: "Wikileaks (bc...)",
                  mxContent: Uri.parse("https://miro.medium.com/v2/resize:fit:720/format:webp/0*TMH4r49yraVirAiH.png"),
                ),
                SizedBox(
                  height: AppTheme.elementSpacing / 2,
                ),
                SizedBox(
                  width: AppTheme.cardPadding * 3,
                  child: Text(
                    "bc1qcme5u6v8a4ss855jsvgae59z20f05sky494qpa",
                    style: Theme.of(context).textTheme.bodySmall,
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              ],
            ),
            Column(
              children: [
                Text(
                  "BitNet",
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                SizedBox(
                  height: AppTheme.elementSpacing,
                ),
                Avatar(
                  size: AppTheme.cardPadding * 2.75,
                  name: "BitNet",
                  mxContent: Uri.parse("https://bitnet.cash"),
                ),
                SizedBox(
                  height: AppTheme.elementSpacing / 2,
                ),
                Container(
                  width: AppTheme.cardPadding * 3,
                  child: Text(
                    "bitnet@bitnet.ai",
                    style: Theme.of(context).textTheme.bodySmall,
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              ],
            ),
          ],
        ),
        // SizedBox(height: AppTheme.cardPadding,),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //   children: [
        //     Column(
        //       children: [
        //         Avatar(
        //           size: AppTheme.cardPadding * 2.75,
        //           name: "@dasihdasd",
        //         ),
        //         SizedBox(
        //           height: AppTheme.elementSpacing / 2,
        //         ),
        //         Text(
        //           "@jdjkdakjldsjk",
        //           style: Theme.of(context).textTheme.bodySmall,
        //         )
        //       ],
        //     ),
        //     Column(
        //       children: [
        //         Avatar(
        //           size: AppTheme.cardPadding * 2.75,
        //           name: "@dasihdasd",
        //         ),
        //         SizedBox(
        //           height: AppTheme.elementSpacing / 2,
        //         ),
        //         Text(
        //           "@jdjkdakjldsjk",
        //           style: Theme.of(context).textTheme.bodySmall,
        //         )
        //       ],
        //     ),
        //     Column(
        //       children: [
        //         Avatar(
        //           size: AppTheme.cardPadding * 2.75,
        //           name: "@dasihdasd",
        //         ),
        //         SizedBox(
        //           height: AppTheme.elementSpacing / 2,
        //         ),
        //         Text(
        //           "@jdjkdakjldsjk",
        //           style: Theme.of(context).textTheme.bodySmall,
        //         )
        //       ],
        //     ),
        //   ],
        // ),
      ],
    );
  }
}

class UserSendWidget extends StatelessWidget {
  const UserSendWidget({
    super.key,
    required this.user,
    required this.controller,
  });
  final ReSendUser user;
  final SendsController controller;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: GestureDetector(
        onTap: () {
          controller.onQRCodeScanned(user.address, context);
        },
        child: Column(
          children: [
            Avatar(mxContent: Uri.parse(user.profileUrl), size: AppTheme.cardPadding * 3),
            SizedBox(
                width: 160,
                child: Text(
                  "@${user.userName}",
                  softWrap: false,
                  overflow: TextOverflow.ellipsis,
                ))
          ],
        ),
      ),
    );
  }
}

class ReSendUser {
  const ReSendUser({required this.profileUrl, required this.userName, required this.address, required this.type});
  final String profileUrl;
  final String userName;
  final String address;
  final String type;

  factory ReSendUser.fromJson(Map<String, dynamic> data) {
    return ReSendUser(
        profileUrl: data['address_logo'] ?? 'https://walletofsatoshi.com/assets/images/icon.png',
        userName: data['user_name'] ?? data['address'],
        address: data['lnurl'] ?? data['address'],
        type: data['lnurl'] != null ? 'lnurl' : 'onchain');
  }

  @override
  bool operator ==(Object other) {
    return other is ReSendUser && address == other.address;
  }

  @override
  int get hashCode => address.hashCode;
}

// List<UserData> fakeUsers = [
//   UserData(
//       backgroundImageUrl: "https://walletofsatoshi.com/assets/images/icon.png",
//       isPrivate: false,
//       showFollowers: false,
//       did: "lal",
//       displayName: "jimmy1",
//       bio: "",
//       customToken: "dsd",
//       username: "jimmy1",
//       profileImageUrl: "https://walletofsatoshi.com/assets/images/icon.png",
//       createdAt: timestamp,
//       updatedAt: timestamp,
//       isActive: false,
//       dob: 2),
//   UserData(
//       backgroundImageUrl: "",
//       isPrivate: false,
//       showFollowers: false,
//       did: "lal",
//       displayName: "jimmy2",
//       bio: "",
//       customToken: "dsd",
//       username: "jimmy1",
//       profileImageUrl: "pfptest.jpg",
//       createdAt: timestamp,
//       updatedAt: timestamp,
//       isActive: false,
//       dob: 2),
//   UserData(
//       backgroundImageUrl: "",
//       isPrivate: false,
//       showFollowers: false,
//       did: "lal",
//       displayName: "jimmy3",
//       bio: "",
//       customToken: "dsd",
//       username: "jimmy1",
//       profileImageUrl: "pfptest.jpg",
//       createdAt: timestamp,
//       updatedAt: timestamp,
//       isActive: false,
//       dob: 2),
//   UserData(
//       backgroundImageUrl: "",
//       isPrivate: false,
//       showFollowers: false,
//       did: "lal",
//       displayName: "jimmy4",
//       bio: "",
//       customToken: "dsd",
//       username: "jimmy1",
//       profileImageUrl: "pfptest.jpg",
//       createdAt: timestamp,
//       updatedAt: timestamp,
//       isActive: false,
//       dob: 2),
//   UserData(
//       backgroundImageUrl: "",
//       isPrivate: false,
//       showFollowers: false,
//       did: "lal",
//       displayName: "jimmy5",
//       bio: "",
//       customToken: "dsd",
//       username: "jimmy1",
//       profileImageUrl: "pfptest.jpg",
//       createdAt: timestamp,
//       updatedAt: timestamp,
//       isActive: false,
//       dob: 2),
//   UserData(
//       backgroundImageUrl: "",
//       isPrivate: false,
//       showFollowers: false,
//       did: "lal",
//       displayName: "jimmy6",
//       bio: "",
//       customToken: "dsd",
//       username: "jimmy1",
//       profileImageUrl: "pfptest.jpg",
//       createdAt: timestamp,
//       updatedAt: timestamp,
//       isActive: false,
//       dob: 2),
//   UserData(
//       backgroundImageUrl: "",
//       isPrivate: false,
//       showFollowers: false,
//       did: "lal",
//       displayName: "jimmy7",
//       bio: "",
//       customToken: "dsd",
//       username: "jimmy1",
//       profileImageUrl: "pfptest.jpg",
//       createdAt: timestamp,
//       updatedAt: timestamp,
//       isActive: false,
//       dob: 2),
//   UserData(
//       backgroundImageUrl: "",
//       isPrivate: false,
//       showFollowers: false,
//       did: "lal",
//       displayName: "jimmy8",
//       bio: "",
//       customToken: "dsd",
//       username: "jimmy1",
//       profileImageUrl: "pfptest.jpg",
//       createdAt: timestamp,
//       updatedAt: timestamp,
//       isActive: false,
//       dob: 2),
//   UserData(
//       backgroundImageUrl: "",
//       isPrivate: false,
//       showFollowers: false,
//       did: "lal",
//       displayName: "jimmy9",
//       bio: "",
//       customToken: "dsd",
//       username: "jimmy1",
//       profileImageUrl: "pfptest.jpg",
//       createdAt: timestamp,
//       updatedAt: timestamp,
//       isActive: false,
//       dob: 2),
//   UserData(
//       backgroundImageUrl: "",
//       isPrivate: false,
//       showFollowers: false,
//       did: "lal",
//       displayName: "jimmy10",
//       bio: "",
//       customToken: "dsd",
//       username: "jimmy1",
//       profileImageUrl: "pfptest.jpg",
//       createdAt: timestamp,
//       updatedAt: timestamp,
//       isActive: false,
//       dob: 2),
// ];
