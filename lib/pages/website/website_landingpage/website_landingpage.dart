import 'dart:async';

import 'package:bitnet/backbone/helper/databaserefs.dart';
import 'package:bitnet/backbone/helper/helpers.dart';
import 'package:bitnet/models/footerpagedata.dart';
import 'package:bitnet/models/user/userdata.dart';
import 'package:bitnet/models/user/userwallet.dart';
import 'package:bitnet/pages/website/website_landingpage/streams/lastregisteredstream.dart';
import 'package:bitnet/pages/website/website_landingpage/streams/userchangepercentstream.dart';
import 'package:bitnet/pages/website/website_landingpage/streams/usercountstream.dart';
import 'package:bitnet/pages/website/website_landingpage/website_landingpage_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:lottie/lottie.dart';
import 'package:matrix/matrix.dart';


class WebsiteLandingPage extends StatefulWidget {
  const WebsiteLandingPage({Key? key}) : super(key: key);

  @override
  WebsiteLandingPageController createState() => WebsiteLandingPageController();
}

class WebsiteLandingPageController extends State<WebsiteLandingPage> {

  late final Future<LottieComposition> composition;

  PageController pageController = PageController(initialPage: 0, viewportFraction: 0.99); //https://github.com/flutter/flutter/issues/31191 //0.99 causes a background at bottom on the last page
  final ValueNotifier<bool> showFab = ValueNotifier<bool>(true);

  late ScrollController scrollController;

  //for usercount
  num startvalue = 1000000;
  num endvalue = (1000000 - latestUserCount);

  //for change in users
  double percentagechange = latestPercentageChange;

  //for last registered user
  List<UserData> lastRegisteredUsers = latestUserData;

  late Timer _timer;
  double _offset = 0;
  bool isUserScrolling = false;
  DateTime? lastUserScrollTime;  // Timestamp of the last time the user manually scrolled

  @override
  void initState() {
    super.initState();
    composition = loadComposition('assets/lottiefiles/blockchain_loader.json');
    scrollController = ScrollController();
    scrollController.addListener(_handleUserScroll);
    pageController.addListener(_updateFabVisibility);
    _timer = Timer.periodic(Duration(milliseconds: 50), _animateList);
    startListeningToLastUsersStream();
    startListeningToUserCountStream();
    startListeningToPercentageChange();
  }

  void _updateFabVisibility() {
    if (pageController.page != null) {
      final int currentPage = pageController.page!.round();
      showFab.value = currentPage != 4; // 0-indexed, so 4 corresponds to the fifth page
    }
  }


  void _handleUserScroll() {
    if (scrollController.position.userScrollDirection == ScrollDirection.idle) {
      // User has stopped scrolling
      lastUserScrollTime = DateTime.now();
    } else {
      // User is scrolling
      isUserScrolling = true;
      lastUserScrollTime = DateTime.now();
      _offset = scrollController.offset;  // Update _offset to the current scroll position
    }
  }

  void _animateList(Timer timer) {
    if (!scrollController.hasClients) return;

    if (DateTime.now().difference(lastUserScrollTime ?? DateTime.now()).inSeconds >= 1) {
      // It's been more than 1 second since the last manual scroll, resume auto-scroll
      isUserScrolling = false;
    }

    if (!isUserScrolling) {
      double maxScrollExtent = scrollController.position.maxScrollExtent;

      if (_offset > maxScrollExtent) {
        _offset = 0;
      } else {
        _offset += 1;
      }

      scrollController.animateTo(_offset,
          duration: Duration(milliseconds: 50), curve: Curves.linear);
    }
  }


  List<PageData> pageDataList = [
    PageData(
      '"I have always been a Bitcoin enthusiast, so BitNet was a no-brainer for me. Its great to see how far we have come with Bitcoin."',
      UserData(
          backgroundImageUrl: "",
          isPrivate: false,
          showFollowers: false,
          did: "whattheheck",
          displayName: "Display Name",
          bio: "jddjskd",
          customToken: "dsd",
          username: "brianbelt",
          profileImageUrl:
          "https://static.demilked.com/wp-content/uploads/2019/04/5cb6d34f775c2-stock-models-share-weirdest-stories-photo-use-102-5cb5c725bc378__700.jpg",
          createdAt: timestamp,
          updatedAt: timestamp,
          isActive: false,
          dob: 2,
          mainWallet: UserWallet(
              walletAddress: "walletAddress",
              walletType: "walletType",
              walletBalance: "",
              privateKey: "privateKey",
              userdid: "userdid"),
          wallets: []),
    ),
    PageData(
      '"So happy to be part of the club 1 million! Lightning is the future."',
      UserData(
          backgroundImageUrl: "",
          isPrivate: false,
          showFollowers: false,
          did: "djskdj",
          displayName: "Display Name",
          bio: "jddjskd",
          customToken: "dsd",
          username: "username",
          profileImageUrl:
          "https://img.freepik.com/free-photo/people-taking-selfie-together-registration-day_23-2149096795.jpg",
          createdAt: timestamp,
          updatedAt: timestamp,
          isActive: false,
          dob: 2,
          mainWallet: UserWallet(
              walletAddress: "walletAddress",
              walletType: "walletType",
              walletBalance: "",
              privateKey: "privateKey",
              userdid: "userdid"),
          wallets: []),
    ),
    PageData(
      '"Wow! Bitnet is the part that I was always missing for bitcoin. Now we will only see more and more bitcoin adoption."',
      UserData(
          backgroundImageUrl: "",
          isPrivate: false,
          showFollowers: false,
          did: "djskdj",
          displayName: "Display Name",
          bio: "jddjskd",
          customToken: "dsd",
          username: "fakeusername",
          profileImageUrl:
          "https://variety.com/wp-content/uploads/2022/08/Jonah-Hill.jpg?w=1000",
          createdAt: timestamp,
          updatedAt: timestamp,
          isActive: false,
          dob: 2,
          mainWallet: UserWallet(
              walletAddress: "walletAddress",
              walletType: "walletType",
              walletBalance: "",
              privateKey: "privateKey",
              userdid: "userdid"),
          wallets: []),
    ),
  ];


  @override
  void dispose() {
    scrollController.removeListener(_handleUserScroll);
    scrollController.dispose();

    _timer.cancel();
    stopListeningToLastUsersStream();
    stopListeningToUserCountStream();
    stopListeningToPercentageChange();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WebsiteLandingPageView(controller: this);
  }
}
