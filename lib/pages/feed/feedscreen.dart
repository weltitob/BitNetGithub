import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/appstandards/fadelistviewwrapper.dart';
import 'package:bitnet/components/fields/searchfield/search_field_with_notif.dart';
import 'package:bitnet/pages/feed/build_search_result_widget.dart';
import 'package:bitnet/pages/feed/feed_controller.dart';
import 'package:bitnet/pages/feed/screen_categories_widget.dart';
import 'package:bitnet/pages/marketplace/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Get.put(FeedController()).initNFC(context);
  }
  // bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<FeedController>();
    return bitnetScaffold(
      body: NestedScrollView(
        controller: controller.scrollController?.value,
        headerSliverBuilder: (context, value) {
          return [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  SearchFieldWithNotificationsWidget(
                    isSearchEnabled: true,
                    hintText: "Search...",
                    handleSearch: controller.handleSearch,
                  ),
                  HorizontalFadeListView(
                    child: Container(
                      height: 100.h,
                      margin: EdgeInsets.only(left: AppTheme.elementSpacing),
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: controller.walletcategorys.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ScreenCategoryWidget(
                              image: controller.walletcategorys[index].imageURL,
                              text: controller.walletcategorys[index].text,
                              header: controller.walletcategorys[index].header,
                              index: index,
                            );
                          }),
                    ),
                  ),
                ],
              ),
            ),
          ];
        },
        body:
            //HomeScreen(),
            controller.searchResultsFuture == null
                ? TabBarView(
                    controller: controller.tabController,
                    children: [
                      HomeScreen(),
                      Container(
                        child: Center(
                            child: Text(
                          "No users found.",
                          style: Theme.of(context).textTheme.bodyMedium,
                        )),
                      ),
                    ],
                  )
                : SearchResultWidget(),
      ),
      context: context,
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
