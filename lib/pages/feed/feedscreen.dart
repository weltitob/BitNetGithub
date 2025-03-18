import 'package:bitnet/backbone/helper/helpers.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/appstandards/fadelistviewwrapper.dart';
import 'package:bitnet/components/fields/searchfield/search_field_with_notif.dart';
import 'package:bitnet/components/fields/searchfield/searchfield.dart';
import 'package:bitnet/pages/feed/build_search_result_widget.dart';
import 'package:bitnet/pages/feed/feed_controller.dart';
import 'package:bitnet/pages/feed/screen_categories_widget.dart';
import 'package:bitnet/pages/feed/tokenstab.dart';
import 'package:bitnet/pages/feed/assetstab.dart';
import 'package:bitnet/pages/secondpages/mempool/view/mempoolhome.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:flutter_keyboard_size/flutter_keyboard_size.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

/// A wrapper widget that keeps its child alive in a [TabBarView]
class KeepAliveWrapper extends StatefulWidget {
  final Widget child;

  const KeepAliveWrapper({Key? key, required this.child}) : super(key: key);

  @override
  _KeepAliveWrapperState createState() => _KeepAliveWrapperState();
}

class _KeepAliveWrapperState extends State<KeepAliveWrapper> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.child;
  }

  @override
  bool get wantKeepAlive => true;
}

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
    scrollListener = () {
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
    return KeyboardSizeProvider(
      child: bitnetScaffold(
        body: NestedScrollView(
            controller: controller.scrollController?.value,
            headerSliverBuilder: (context, value) {
              return [
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      GetBuilder<FeedController>(
                        builder: (controller) {
                          return Consumer<ScreenHeight>(
                              builder: (context, res, child) {
                                if (!res.isOpen) {
                                  searchNode.unfocus();
                                }
                                return child!;
                              },
                              child: Padding(
                                padding:  EdgeInsets.only(left: AppTheme.elementSpacing.w, right: AppTheme.elementSpacing.w, top: AppTheme.cardPadding.h, bottom: AppTheme.elementSpacing.h),
                                child: SearchFieldWidget(
                                  isSearchEnabled: true,
                                  hintText:
                                      "Paste walletaddress, transactionid or blockid...",
                                  // focus: searchNode,
                                  // notificationCount:
                                  //     3, // You can customize this based on your needs
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
                                  }, handleSearch: (text){



                                },
                                ),
                              ));
                        },
                      ),
                      HorizontalFadeListView(
                        child: Container(
                          height: AppTheme.cardPadding * 2.h,
                          margin: const EdgeInsets.symmetric(
                              horizontal: AppTheme.elementSpacing),
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: controller.walletcategorys.length,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: () {
                                  controller.tabController?.animateTo(index);
                                  setState(() {});
                                },
                                child: ScreenCategoryWidget(
                                  text: controller.walletcategorys[index].text,
                                  index: index,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      // const Divider(),
                    ],
                  ),
                ),
              ];
            },
            body: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              controller: controller.tabController,
              children: [
                // Use KeepAlive to prevent rebuilding tabs when switching
                KeepAliveWrapper(child: const TokensTab()),
                KeepAliveWrapper(child: const AssetsTab()),
                GetBuilder<FeedController>(
                  builder: (controller) {
                    return const SearchResultWidget();
                  },
                ),
                KeepAliveWrapper(
                  child: MempoolHome(
                    isFromHome: true,
                  ),
                ),
              ],
            )
            // : SearchResultWidget(),
            ),
        context: context,
      ),
    );
  }
}
