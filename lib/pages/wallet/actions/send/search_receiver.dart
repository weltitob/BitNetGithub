import 'package:bitnet/backbone/helper/helpers.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/buttons/bottom_buybuttons.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/container/avatar.dart';
import 'package:bitnet/components/fields/searchfield/searchfield.dart';
import 'package:bitnet/models/user/userdata.dart';
import 'package:bitnet/pages/wallet/actions/send/controllers/send_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_size/flutter_keyboard_size.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';

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
                    height: AppTheme.cardPadding * 2.5,
                  ),
                  Consumer<ScreenHeight>(
                    builder:( ctx, res, child) {
                      if(!res.isOpen) {
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
                    height: MediaQuery.of(context).size.height * 0.6,
                    width: 500,
                    child: ListView(
                      controller: controller.sendScrollerController,
                      physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                      children:[
                      Text("Support Bitcoin Devs", style: Theme.of(context).textTheme.titleLarge),
                      SizedBox(height: AppTheme.cardPadding /2,),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 125,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: fakeUsers.length,
                          itemBuilder: (context, i) {
                            return UserSendWidget(user: fakeUsers[i]); 
                          }),
                      ),
                      //space
                                        SizedBox(height: AppTheme.cardPadding * 4),
                    
                      //tab2
                      Text("Send Again", style: Theme.of(context).textTheme.titleLarge),
                      SizedBox(height: AppTheme.cardPadding /2,),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 125,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: fakeUsers.length,
                          itemBuilder: (context, i) {
                            return UserSendWidget(user: fakeUsers[9-i],); 
                          }),
                      ),
                      ]
                    ),
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
                  controller.processParameters(context,
                      (await context.push("/qrscanner")) as String?);
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

class UserSendWidget extends StatelessWidget {
  const UserSendWidget({
    super.key, required this.user,
  });
  final UserData user;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: Column(
        children: [
          Avatar(size: AppTheme.cardPadding * 4),
          Text(
            "@${user.displayName}"
          )
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