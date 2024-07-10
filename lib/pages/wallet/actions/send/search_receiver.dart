import 'package:bitnet/backbone/helper/helpers.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/appstandards/fadelistviewwrapper.dart';
import 'package:bitnet/components/buttons/bottom_buybuttons.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/container/avatar.dart';
import 'package:bitnet/components/container/imagewithtext.dart';
import 'package:bitnet/components/fields/searchfield/searchfield.dart';
import 'package:bitnet/models/user/userdata.dart';
import 'package:bitnet/pages/wallet/actions/send/controllers/send_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';

class SearchReceiver extends GetWidget<SendsController> {
  const SearchReceiver({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return bitnetScaffold(
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
                  height: AppTheme.cardPadding * 2.5,
                ),
                SearchFieldWidget(
                  hintText: L10n.of(context)!.searchReceipient,
                  isSearchEnabled: true,
                  handleSearch: controller.handleSearch,
                  node: controller.myFocusNodeAdressSearch,
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 1,
                  child: ListView(
                      controller: controller.sendScrollerController,
                      physics: BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics()),
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
                                height: AppTheme.cardPadding * 6.h,
                                child: Container(
                                  margin:
                                      EdgeInsets.all(AppTheme.elementSpacing),
                                  child: MostPopularWidget(),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: AppTheme.cardPadding.h * 1.25),
                        Container(
                          margin: EdgeInsets.only(left: AppTheme.cardPadding),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //tab2
                              Text("Send Again",
                                  style:
                                      Theme.of(context).textTheme.titleLarge),
                              SizedBox(
                                height: AppTheme.cardPadding,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: 125,
                                child: HorizontalFadeListView(
                                  child: ListView.builder(
                                      //this will be the last lnurls if there are some or if there is none this will be filled with btc addresses and if there is absolutly none this will be empty
                                      scrollDirection: Axis.horizontal,
                                      itemCount: fakeUsers.length,
                                      itemBuilder: (context, i) {
                                        return UserSendWidget(
                                          user: fakeUsers[9 - i],
                                        );
                                      }),
                                ),
                              ),
                              SizedBox(height: AppTheme.cardPadding.h * 1.25),
                              Text("Most used",
                                  style:
                                      Theme.of(context).textTheme.titleLarge),
                              SizedBox(
                                height: AppTheme.cardPadding,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height: 125,
                                child: HorizontalFadeListView(
                                  //this will be filled with the lnurls that have been mostly used and bc addresses in ranking order (5) (3) (1) // when all only have one then it will be similar to send again
                                  child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: fakeUsers.length,
                                      itemBuilder: (context, i) {
                                        return UserSendWidget(
                                            user: fakeUsers[i]);
                                      }),
                                ),
                              ),
                              //space
                              SizedBox(height: AppTheme.cardPadding * 2),
                              SizedBox(height: AppTheme.cardPadding.h * 8),
                            ],
                          ),
                        ),
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
                controller.processParameters(
                    context, (await context.push("/qrscanner")) as String?);
              },
              buttonTitle: L10n.of(context)!.scanQr,
              buttonState: ButtonState.idle,
            )
          ],
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
               Text("Tor", style: Theme.of(context).textTheme.titleSmall,),
               SizedBox(height: AppTheme.elementSpacing,),
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
                Text("Wikileaks", style: Theme.of(context).textTheme.titleSmall,),
                SizedBox(height: AppTheme.elementSpacing,),
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
                Text("BitNet", style: Theme.of(context).textTheme.titleSmall,),
                SizedBox(height: AppTheme.elementSpacing,),
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
  });
  final UserData user;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          left: AppTheme.elementSpacing, right: AppTheme.cardPadding * 1.5),
      child: Column(
        children: [
          Avatar(
            size: AppTheme.cardPadding * 3,
            name: "@${user.displayName}",
          ),
          SizedBox(
            height: AppTheme.elementSpacing.h,
          ),
          Text("@${user.displayName}", style: Theme.of(context).textTheme.bodySmall,)
        ],
      ),
    );
  }
}

List<UserData> fakeUsers = [
  UserData(
      backgroundImageUrl: "",
      isPrivate: false,
      showFollowers: false,
      did: "lal",
      displayName: "jimmy1",
      bio: "",
      customToken: "dsd",
      username: "jimmy1",
      profileImageUrl: "pfptest.jpg",
      createdAt: timestamp,
      updatedAt: timestamp,
      isActive: false,
      dob: 2),
  UserData(
      backgroundImageUrl: "",
      isPrivate: false,
      showFollowers: false,
      did: "lal",
      displayName: "jimmy2",
      bio: "",
      customToken: "dsd",
      username: "jimmy1",
      profileImageUrl: "pfptest.jpg",
      createdAt: timestamp,
      updatedAt: timestamp,
      isActive: false,
      dob: 2),
  UserData(
      backgroundImageUrl: "",
      isPrivate: false,
      showFollowers: false,
      did: "lal",
      displayName: "jimmy3",
      bio: "",
      customToken: "dsd",
      username: "jimmy1",
      profileImageUrl: "pfptest.jpg",
      createdAt: timestamp,
      updatedAt: timestamp,
      isActive: false,
      dob: 2),
  UserData(
      backgroundImageUrl: "",
      isPrivate: false,
      showFollowers: false,
      did: "lal",
      displayName: "jimmy4",
      bio: "",
      customToken: "dsd",
      username: "jimmy1",
      profileImageUrl: "pfptest.jpg",
      createdAt: timestamp,
      updatedAt: timestamp,
      isActive: false,
      dob: 2),
  UserData(
      backgroundImageUrl: "",
      isPrivate: false,
      showFollowers: false,
      did: "lal",
      displayName: "jimmy5",
      bio: "",
      customToken: "dsd",
      username: "jimmy1",
      profileImageUrl: "pfptest.jpg",
      createdAt: timestamp,
      updatedAt: timestamp,
      isActive: false,
      dob: 2),
  UserData(
      backgroundImageUrl: "",
      isPrivate: false,
      showFollowers: false,
      did: "lal",
      displayName: "jimmy6",
      bio: "",
      customToken: "dsd",
      username: "jimmy1",
      profileImageUrl: "pfptest.jpg",
      createdAt: timestamp,
      updatedAt: timestamp,
      isActive: false,
      dob: 2),
  UserData(
      backgroundImageUrl: "",
      isPrivate: false,
      showFollowers: false,
      did: "lal",
      displayName: "jimmy7",
      bio: "",
      customToken: "dsd",
      username: "jimmy1",
      profileImageUrl: "pfptest.jpg",
      createdAt: timestamp,
      updatedAt: timestamp,
      isActive: false,
      dob: 2),
  UserData(
      backgroundImageUrl: "",
      isPrivate: false,
      showFollowers: false,
      did: "lal",
      displayName: "jimmy8",
      bio: "",
      customToken: "dsd",
      username: "jimmy1",
      profileImageUrl: "pfptest.jpg",
      createdAt: timestamp,
      updatedAt: timestamp,
      isActive: false,
      dob: 2),
  UserData(
      backgroundImageUrl: "",
      isPrivate: false,
      showFollowers: false,
      did: "lal",
      displayName: "jimmy9",
      bio: "",
      customToken: "dsd",
      username: "jimmy1",
      profileImageUrl: "pfptest.jpg",
      createdAt: timestamp,
      updatedAt: timestamp,
      isActive: false,
      dob: 2),
  UserData(
      backgroundImageUrl: "",
      isPrivate: false,
      showFollowers: false,
      did: "lal",
      displayName: "jimmy10",
      bio: "",
      customToken: "dsd",
      username: "jimmy1",
      profileImageUrl: "pfptest.jpg",
      createdAt: timestamp,
      updatedAt: timestamp,
      isActive: false,
      dob: 2),
];
