import 'package:BitNet/backbone/helper/databaserefs.dart';
import 'package:BitNet/components/loaders/loaders.dart';
import 'package:BitNet/backbone/helper/theme/theme.dart';
import 'package:BitNet/components/fields/searchfield/searchfield.dart';
import 'package:BitNet/components/items/userresult.dart';
import 'package:BitNet/components/items/usersearchresult.dart';
import 'package:BitNet/models/user/userdata.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class WalletCategory {
  final String imageURL;
  final String text;
  final String header;

  WalletCategory(
    this.imageURL,
    this.text,
    this.header,
  );
}

class FeedScreen extends StatefulWidget {
  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen>
    with SingleTickerProviderStateMixin {
  bool get wantKeepAlive => true;

  final TextFieldController = TextEditingController();

  Future<QuerySnapshot>? searchResultsFuture;

  handleSearch(String query) {
    try {
      Future<QuerySnapshot> users = usersCollection
          .where("username", isGreaterThanOrEqualTo: query)
          .get();

      setState(() {
        searchResultsFuture = users;
      });

      print(searchResultsFuture);
    } catch (e) {
      searchResultsFuture = null;
      print("Error searching for user: $e");
    }
  }

  final List<Widget> myTabs = [
    Tab(text: 'auto short'),
    Tab(text: 'auto long'),
    Tab(text: 'fixed'),
  ];

  final List<WalletCategory> walletcategorys = [
    WalletCategory('assets/images/bitcoin.png', 'People', 'People'),
    WalletCategory(
      'assets/images/bitcoin.png',
      'Trending',
      'Trending',
    ),
    WalletCategory(
      'assets/images/bitcoin.png',
      'Crypto',
      'Crypto',
    ),
    WalletCategory('assets/images/bitcoin.png', 'Watchlist', 'Watchlist'),
    WalletCategory('assets/images/bitcoin.png', 'NFTS', 'NFTS'),
  ];

  late TabController _tabController;
  late ScrollController _scrollController;
  late bool fixedScroll;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    _tabController.addListener(_smoothScrollToTop);
    TextFieldController.addListener(() => setState(() {}));
    getData();

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
    _scrollController.dispose();
  }

  _scrollListener() {
    if (fixedScroll) {
      _scrollController.jumpTo(0);
    }
  }

  _smoothScrollToTop() {
    _scrollController.animateTo(
      0,
      duration: Duration(microseconds: 300),
      curve: Curves.ease,
    );

    setState(() {
      fixedScroll = _tabController.index == 0;
    });
  }

  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      watchlist = prefs.getString('watchlist')!;
      print(watchlist);
      _loading = false;
    });
  }

  String watchlist = "";
  bool _loading = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: NestedScrollView(
          controller: _scrollController,
          headerSliverBuilder: (context, value) {
            return [
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    buildSearchField(
                      context: context,
                      TextFieldController: TextFieldController,
                      handleSearch: handleSearch,
                    ),
                    Container(
                      height: 100,
                      margin: EdgeInsets.only(left: AppTheme.elementSpacing),
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: walletcategorys.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ScreenCategorys(
                                walletcategorys[index].imageURL,
                                walletcategorys[index].text,
                                walletcategorys[index].header,
                                index);
                          }),
                    ),
                  ],
                ),
              ),
            ];
          },
          body: searchResultsFuture == null
              ? TabBarView(
                  controller: _tabController,
                  children: <Widget>[
                    Container(
                      child: Center(
                          child: Text(
                        "No users found.",
                        style: Theme.of(context).textTheme.bodyMedium,
                      )),
                    ),
                  ],
                )
              : buildSearchResults(),
        ),
      ),
    );
  }

  Widget ScreenCategorys(String image, String text, String header, int index) {
    return Container(
        margin: EdgeInsets.only(
          right: 10,
          top: 10,
          bottom: 10,
          left: 3,
        ),
        width: 80,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: AppTheme.cardRadiusMid,
          border: Border.all(
            color: index == _tabController.index
                ? Theme.of(context).colorScheme.secondary
                : Colors.transparent,
            width: 3,
          ),
          boxShadow: [
            AppTheme.boxShadowSmall,
          ],
        ),
        child: Material(
            color: Theme.of(context).colorScheme.secondaryContainer,
            borderRadius: AppTheme.cardRadiusMid,
            child: InkWell(
              borderRadius: AppTheme.cardRadiusMid,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 5),
                    height: 35,
                    width: 35,
                    child: Image.asset(image),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5),
                    child:
                        Text(text, style: Theme.of(context).textTheme.button),
                  )
                ],
              ),
              onTap: () {
                setState(() {
                  _tabController.animateTo(index);
                });
              },
            )));
  }

  FutureBuilder buildSearchResults() {
    return FutureBuilder(
      future: searchResultsFuture,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return dotProgress(context);
        }
        List<UserSearchResult> searchresults = [];
        snapshot.data.docs.forEach((doc) {
          UserData user = UserData.fromDocument(doc);
          UserSearchResult searchResult = UserSearchResult(
            onTap: () async {},
            userData: user,
          );
          searchresults.add(searchResult);
        });
        if (searchresults.isEmpty) {
          return Center(
            child: Text('No users could be found'),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.only(
                left: AppTheme.cardPadding,
                right: AppTheme.cardPadding,
                top: AppTheme.elementSpacing),
            child: ListView(
              children: searchresults,
            ),
          );
        }
      },
    );
  }

//get the watchlist of an user
//
//   WatchList() {
//     if (watchlist != "") {
//       // return Text(Watchlist.decode(watchlist).toString());
//       return UsersWatchlist(coins: Watchlist.decode(watchlist));
//     } else {
//       return Text("NO DATA");
//     }
//   }

//Widget for diffrent Lists
// was mylist before to work with swiching the diffrent categorys
//
//   @override
//   Widget CurrentList() {
//     return FutureBuilder<BigDataModel>(
//       future: _futureCoins,
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.done) {
//           if (snapshot.hasData) {
//             var coinsData = snapshot.data!.dataModel;
//             return SizedBox(
//                 height: MediaQuery.of(context).size.height,
//                 child: TopCoinsByMarketcap(coins: coinsData)
//             );
//           } else if (snapshot.hasError) {
//             return Text('${snapshot.error}');
//           }
//         }
//         return dotProgress(context);
//       },
//     );
//   }
}
