import 'package:bitnet/backbone/helper/helpers.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/appstandards/fadelistviewwrapper.dart';
import 'package:bitnet/components/fields/searchfield/search_field_with_notif.dart';
import 'package:bitnet/components/fields/searchfield/searchfield.dart';
import 'package:bitnet/pages/feed/appstab.dart';
import 'package:bitnet/pages/feed/build_search_result_widget.dart';
import 'package:bitnet/pages/feed/feed_controller.dart';
import 'package:bitnet/pages/feed/screen_categories_widget.dart';
import 'package:bitnet/pages/feed/tokenstab.dart';
import 'package:bitnet/pages/feed/assetstab.dart';
import 'package:bitnet/pages/feed/websitestab.dart';
import 'package:bitnet/pages/secondpages/mempool/view/mempoolhome.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:flutter_keyboard_size/flutter_keyboard_size.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

/// Optimized wrapper widget that keeps its child alive but with better performance
class KeepAliveWrapper extends StatefulWidget {
  final Widget child;
  final bool keepAlive;

  const KeepAliveWrapper({
    Key? key,
    required this.child,
    this.keepAlive = true,
  }) : super(key: key);

  @override
  _KeepAliveWrapperState createState() => _KeepAliveWrapperState();
}

class _KeepAliveWrapperState extends State<KeepAliveWrapper>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    // Always call super.build for AutomaticKeepAliveClientMixin
    super.build(context);

    // Performance optimization: use RepaintBoundary to isolate repaints
    return RepaintBoundary(
      child: widget.child,
    );
  }

  @override
  bool get wantKeepAlive => widget.keepAlive;
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

    // Ensure the controller is ready
    if (controller.scrollController?.value == null) {
      controller.scrollController = ScrollController().obs;
    }

    return KeyboardSizeProvider(
      child: bitnetScaffold(
        body: CustomScrollView(
          controller: controller.scrollController?.value,
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  // Search field with optimized rebuild
                  Padding(
                    padding: EdgeInsets.only(
                        left: AppTheme.elementSpacing.w,
                        right: AppTheme.elementSpacing.w,
                        top: AppTheme.cardPadding.h,
                        bottom: AppTheme.elementSpacing.h),
                    child: Consumer<ScreenHeight>(
                      builder: (context, res, child) {
                        if (!res.isOpen) {
                          searchNode.unfocus();
                        }
                        return SearchFieldWidget(
                          isSearchEnabled: true,
                          hintText:
                              "Paste walletaddress, transactionid or blockid...",
                          onChanged: (v) {
                            // Only update search for people tab
                            if (controller.tabController!.index == 3) {
                              controller.filterSearchResults(v);
                            }
                          },
                          handleSearch: (text) {},
                        );
                      },
                    ),
                  ),

                  // Optimized TabBar - pre-built categories list
                  Container(
                    height: AppTheme.cardPadding * 2.h,
                    margin: const EdgeInsets.symmetric(
                        horizontal: AppTheme.elementSpacing),
                    child: _buildTabs(controller),
                  ),
                ],
              ),
            ),

            // Tab content - rendering only active tab content using Obx for reactive updates
            SliverFillRemaining(
              child: Obx(() {
                final int currentIndex = controller.currentTabIndex.value;
                print("Rendering tab index: $currentIndex");
                return IndexedStack(
                  index: currentIndex,
                  sizing: StackFit.expand,
                  children: [
                    // Lazy-loading tabs for better performance
                    const WebsitesTab(),
                    const TokensTab(),
                    const AssetsTab(),
                    const SearchResultWidget(),
                    MempoolHome(isFromHome: true),
                    const AppsTab()
                  ],
                );
              }),
            ),
          ],
        ),
        context: context,
      ),
    );
  }

  // Pre-built optimized tabs widget
  Widget _buildTabs(FeedController controller) {
    return Obx(() {
      final currentIndex = controller.currentTabIndex.value;
      return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: controller.walletcategorys.length,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: ScreenCategoryWidget(
              text: controller.walletcategorys[index].text,
              index: index,
            ),
          );
        },
      );
    });
  }
}
