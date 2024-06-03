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
import 'package:flutter_gen/gen_l10n/l10n.dart';


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
    super.initState();
    Get.put(FeedController()).initNFC(context);
  }

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
                    hintText: "${L10n.of(context)!.search}...",
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
                  Divider()
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
                          L10n.of(context)!.noUserFound,
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
 }
