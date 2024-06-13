import 'package:bitnet/backbone/helper/helpers.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/appstandards/fadelistviewwrapper.dart';
import 'package:bitnet/components/fields/searchfield/search_field_with_notif.dart';
import 'package:bitnet/pages/feed/build_search_result_widget.dart';
import 'package:bitnet/pages/feed/feed_controller.dart';
import 'package:bitnet/pages/feed/screen_categories_widget.dart';
import 'package:bitnet/pages/marketplace/HomeScreen.dart';
import 'package:bitnet/pages/secondpages/mempool/view/mempoolhome.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
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
  late FocusNode searchNode;
  late ScrollController homeScrollController;
  late Function() scrollListener;
  @override
  void initState() {
    
    super.initState();
  
    Get.put(FeedController()).initNFC(context);
     homeScrollController = Get.find<FeedController>().scrollControllerColumn;
     scrollListener = (){
      scrollToSearchFunc(homeScrollController, searchNode);
    };
    homeScrollController.addListener(scrollListener);
       searchNode = FocusNode();
  }

   

@override
void dispose() {
  homeScrollController.removeListener(scrollListener);
  searchNode.dispose();
  super.dispose();
}
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<FeedController>();
    print(controller.searchResultsFuture);
    return bitnetScaffold(
      body: NestedScrollView(
          controller: controller.scrollController?.value,
          headerSliverBuilder: (context, value) {
            return [
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    GetBuilder<FeedController>(
                      builder: (controller) {
                        return SearchFieldWithNotificationsWidget(
                          isSearchEnabled: true,
                          hintText: "Paste walletaddress, transactionid or blockid...",
                          focus: searchNode,
                          // hintText: "${L10n.of(context)!.search}...",
                          onChanged: (v) {
                            setState(() {}); 
                            if (controller.tabController!.index == 2) {
                              controller.searchresults = controller
                                  .searchresults
                                  .where((e) => e.userData.username
                                      .toLowerCase()
                                      .contains(v))
                                  .toList();
                            }
                          },
                        );
                      },
                    ),
                    HorizontalFadeListView(
                      child: Container(
                        height: 100.h,
                        margin: EdgeInsets.only(left: AppTheme.elementSpacing),
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: controller.walletcategorys.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {
                                controller.tabController?.animateTo(index);
                                setState(() {});
                              },
                              child: ScreenCategoryWidget(
                                image:
                                    controller.walletcategorys[index].imageURL,
                                text: controller.walletcategorys[index].text,
                                header:
                                    controller.walletcategorys[index].header,
                                index: index,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    Divider(),
                  ],
                ),
              ),
            ];
          },
          body:
              //  controller.searchResultsFuture?.value == null
              //     ?
              TabBarView(
            physics: NeverScrollableScrollPhysics(),
            controller: controller.tabController,
            children: [
              HomeScreen(ctrler: homeScrollController),
              MempoolHome(
                isFromHome: true,
              ),
              GetBuilder<FeedController>(
                builder: (controller) {
                  return SearchResultWidget();
                },
              ),
              Container(
                child: Center(
                  child: Text(
                    L10n.of(context)!.groups,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              ),
              Container(
                child: Center(
                  child: Text(
                    L10n.of(context)!.liked,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              ),
            ],
          )
          // : SearchResultWidget(),
          ),
      context: context,
    );
  }
}
