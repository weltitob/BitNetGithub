import 'package:bitnet/backbone/helper/helpers.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/appstandards/fadelistviewwrapper.dart';
import 'package:bitnet/components/fields/searchfield/searchfield.dart';
import 'package:bitnet/pages/feed/appstab.dart';
import 'package:bitnet/pages/feed/appstab_modern.dart';
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

  // Track which tabs have been initialized for lazy loading
  final List<bool> _tabsInitialized = List.filled(5, false);

  @override
  void initState() {
    super.initState();

    // Log performance improvement
    final startTime = DateTime.now();
    print('[PERFORMANCE] FeedScreen initState started at: $startTime');

    Get.put(FeedController()).initNFC(context);
    homeScrollController = Get.find<FeedController>().scrollControllerColumn;
    scrollListener = () {
      scrollToSearchFunc(homeScrollController, searchNode);
    };
    homeScrollController.addListener(scrollListener);
    searchNode = FocusNode();

    // Initialize the first tab immediately
    _tabsInitialized[0] = true;

    final endTime = DateTime.now();
    final loadTime = endTime.difference(startTime).inMilliseconds;
    print('[PERFORMANCE] FeedScreen initState completed in: ${loadTime}ms');
    print('[PERFORMANCE] Lazy loading enabled - only 1 of 5 tabs initialized');
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
                            // Search functionality disabled since People tab was removed
                            // controller.filterSearchResults(v);
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

                // Mark current tab as initialized when it's selected - SAFE VERSION
                _initializeTabSafely(currentIndex);

                print(
                    "Rendering tab index: $currentIndex, initialized tabs: $_tabsInitialized");

                return IndexedStack(
                  index: currentIndex,
                  sizing: StackFit.expand,
                  children: [
                    // Lazy-loading tabs for better performance
                    _buildLazyTab(0, const WebsitesTab()),
                    _buildLazyTab(1, const TokensTab()),
                    _buildLazyTab(2, const AssetsTab()),
                    _buildLazyTab(3, MempoolHome(isFromHome: true)),
                    _buildLazyTab(4, const AppsTabModern())
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

  // Safe tab initialization that defers state updates outside build cycle
  void _initializeTabSafely(int currentIndex) {
    if (!_tabsInitialized[currentIndex] && mounted) {
      // Use WidgetsBinding to defer state update until after build cycle
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted && !_tabsInitialized[currentIndex]) {
          setState(() {
            _tabsInitialized[currentIndex] = true;
          });
        }
      });
    }
  }

  // Build lazy tab - returns a lightweight placeholder for uninitialized tabs
  Widget _buildLazyTab(int index, Widget tabContent) {
    final controller = Get.find<FeedController>();
    final isCurrentTab = controller.currentTabIndex.value == index;

    // If tab is not initialized and not current, return minimal placeholder
    if (!_tabsInitialized[index] && !isCurrentTab) {
      return const SizedBox.shrink();
    }

    // If tab is current but not yet initialized, show loading indicator
    if (!_tabsInitialized[index] && isCurrentTab) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                Theme.of(context).colorScheme.primary,
              ),
            ),
            SizedBox(height: AppTheme.elementSpacing.h),
            Text(
              'Loading...',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      );
    }

    // For initialized tabs, wrap with KeepAliveWrapper to maintain state
    // Only keep alive tabs that benefit from it (tabs with expensive data)
    final bool shouldKeepAlive =
        index == 1 || index == 2; // TokensTab and AssetsTab

    return KeepAliveWrapper(
      keepAlive: shouldKeepAlive,
      child: tabContent,
    );
  }
}
