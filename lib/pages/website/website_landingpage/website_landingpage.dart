import 'dart:async';

import 'package:bitnet/backbone/helper/helpers.dart';
import 'package:bitnet/backbone/streams/website_streams/lastregisteredstream.dart';
import 'package:bitnet/backbone/streams/website_streams/userchangepercentstream.dart';
import 'package:bitnet/backbone/streams/website_streams/usercountstream.dart';
import 'package:bitnet/models/user/userdata.dart';
import 'package:bitnet/models/website/footerpagedata.dart';
import 'package:bitnet/pages/website/website_landingpage/website_landingpage_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class WebsiteLandingPage extends StatefulWidget {
  const WebsiteLandingPage({Key? key}) : super(key: key);

  @override
  WebsiteLandingPageController createState() => WebsiteLandingPageController();
}

class WebsiteLandingPageController extends State<WebsiteLandingPage> {
  late final Future<LottieComposition> composition;
  PageController pageController = PageController(
      initialPage: 0,
      viewportFraction:
          0.99); //https://github.com/flutter/flutter/issues/31191 //0.99 causes a background at bottom on the last page
  final ValueNotifier<bool> showFab = ValueNotifier<bool>(true);

  late ScrollController scrollController;

  late Timer _timer;
  double _offset = 0;
  bool isUserScrolling = false;
  DateTime?
      lastUserScrollTime; // Timestamp of the last time the user manually scrolled

  @override
  void initState() {
    super.initState();
    composition = loadComposition('assets/lottiefiles/blockchain_loader.json');
    scrollController = ScrollController();
    scrollController.addListener(_handleUserScroll);
    pageController.addListener(_updateFabVisibility);
    _timer = Timer.periodic(const Duration(milliseconds: 50), _animateList);
  }

  void _updateFabVisibility() {
    if (pageController.page != null) {
      final int currentPage = pageController.page!.round();
      showFab.value =
          currentPage != 4; // 0-indexed, so 4 corresponds to the fifth page
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
      _offset = scrollController
          .offset; // Update _offset to the current scroll position
    }
  }

  void _animateList(Timer timer) {
    if (!scrollController.hasClients) return;
    if (DateTime.now()
            .difference(lastUserScrollTime ?? DateTime.now())
            .inSeconds >=
        1) {
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
          duration: const Duration(milliseconds: 50), curve: Curves.linear);
    }
  }

  List<PageData> pageDataList = [
    PageData(
      '"BitNet has completely changed how I use Bitcoin day-to-day. The speed of transactions and clean design make it so easy to use."',
      UserData(
        backgroundImageUrl: "",
        isPrivate: false,
        showFollowers: false,
        did: "whattheheck",
        displayName: "Mark Johnson",
        bio: "Tech enthusiast",
        customToken: "dsd",
        username: "mjohnson84",
        profileImageUrl:
            //"https://static.demilked.com/wp-content/uploads/2019/04/5cb6d34f775c2-stock-models-share-weirdest-stories-photo-use-102-5cb5c725bc378__700.jpg",
            "pfptest.jpg",
        createdAt: timestamp,
        updatedAt: timestamp,
        isActive: false,
        setupQrCodeRecovery: false,
        setupWordRecovery: false,
        dob: 2,
      ),
    ),
    PageData(
      '"So happy I found BitNet! The Lightning integration makes sending Bitcoin actually practical for everyday purchases."',
      UserData(
          backgroundImageUrl: "",
          isPrivate: false,
          showFollowers: false,
          did: "djskdj",
          displayName: "Sarah Chen",
          bio: "Software developer",
          customToken: "dsd",
          username: "schen_dev",
          profileImageUrl:
              //"https://img.freepik.com/free-photo/people-taking-selfie-together-registration-day_23-2149096795.jpg",
              "pfptest.jpg",
          createdAt: timestamp,
          updatedAt: timestamp,
          setupWordRecovery: false,
          isActive: false,
          dob: 2,
          setupQrCodeRecovery: false),
    ),
    PageData(
      '"BitNet is exactly what Bitcoin needed. It is fast, secure, and actually makes sense for small transactions. Really impressed!"',
      UserData(
        backgroundImageUrl: "",
        isPrivate: false,
        showFollowers: false,
        did: "djskdj",
        displayName: "James Wilson",
        bio: "Finance professional",
        customToken: "dsd",
        username: "jwilson_fin",
        profileImageUrl:
            //"https://variety.com/wp-content/uploads/2022/08/Jonah-Hill.jpg?w=1000",
            "pfptest.jpg",
        createdAt: timestamp,
        updatedAt: timestamp,
        isActive: false,
        setupWordRecovery: false,
        setupQrCodeRecovery: false,
        dob: 2,
      ),
    ),
  ];

  @override
  void dispose() {
    scrollController.removeListener(_handleUserScroll);
    scrollController.dispose();

    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      //all providers for the website landing page
      StreamProvider<List<UserData>>(
        create: (context) => lastUsersStream(),
        initialData: [], // Initial empty list
      ),
      StreamProvider<double>(
        create: (context) => percentageChangeInUserCountStream(),
        initialData: 0.0, // Initial percentage change
      ),
      StreamProvider<int>(
        create: (context) => userCountStream(),
        initialData: 0, // Initial user count
      ),
    ], child: WebsiteLandingPageView(controller: this));
  }
}
