import 'dart:async';

import 'package:bitnet/backbone/helper/databaserefs.dart';
import 'package:bitnet/backbone/helper/helpers.dart';
import 'package:bitnet/models/footerpagedata.dart';
import 'package:bitnet/models/user/userdata.dart';
import 'package:bitnet/models/user/userwallet.dart';
import 'package:bitnet/pages/website/website_landingpage/pagefooter.dart';
import 'package:bitnet/pages/website/website_landingpage/website_landingpage_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:lottie/lottie.dart';

class WebsiteLandingPage extends StatefulWidget {
  const WebsiteLandingPage({Key? key}) : super(key: key);

  @override
  WebsiteLandingPageController createState() => WebsiteLandingPageController();
}

class WebsiteLandingPageController extends State<WebsiteLandingPage> {

  bool isLastPage = false;


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
      '"So happy to be part of the club 1 million. Zero chance Im selling my bitcoin NFT! This feels like buying bitcoin back in 2015."',
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
      '"Wow! Bitnet is the part that I was always missing for bitcoin. Lightning wallets truly are the future. Now we will only see more and more bitcoin adoption."',
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

  late final Future<LottieComposition> composition;

  PageController pageController = PageController(initialPage: 0, viewportFraction: 0.99); //https://github.com/flutter/flutter/issues/31191
  final ValueNotifier<bool> showFab = ValueNotifier<bool>(true);

  late ScrollController scrollController;
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
  }

  void _updateFabVisibility() {
    if (pageController.page != null) {
      final int currentPage = pageController.page!.round();
      showFab.value = currentPage != 4; // 0-indexed, so 4 corresponds to the fifth page
    }
  }

  Stream<int> userCountStream() {
    print("Usercountstream called");
    return usersCollection
        .snapshots()
        .map((snapshot) => snapshot.size);
  }

  Stream<List<UserData>> lastUsersStream() {
    print("Last 100 users stream called");
    return usersCollection
        .orderBy('createdAt', descending: true)
        .limitToLast(100)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => UserData.fromDocument(doc)).toList());
  }

  Stream<double> percentageChangeInUserCountStream() async* {
    print("Percentchange called");
    int initialUserCount = await _userCountFrom7DaysAgo();
    await for (int currentUserCount in userCountStream()) {
      if (initialUserCount == 0) {
        yield (currentUserCount > 0) ? 100.0 : 0.0; // If we had 0 users 7 days ago and now we have more, that's a 100% increase
      } else {
        double percentageChange = ((currentUserCount - initialUserCount) / initialUserCount) * 100;
        yield percentageChange;
      }
    }

  }

  Future<int> _userCountFrom7DaysAgo() async {
    DateTime sevenDaysAgo = DateTime.now().subtract(Duration(days: 7));
    var snapshot = await usersCollection.where('createdAt', isLessThanOrEqualTo: sevenDaysAgo).get();
    return snapshot.size;
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

  @override
  void dispose() {
    scrollController.removeListener(_handleUserScroll);
    scrollController.dispose();
    _timer.cancel();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return WebsiteLandingPageView(controller: this);
  }
}
