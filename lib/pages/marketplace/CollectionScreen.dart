import 'package:bitnet/backbone/helper/marketplace_helpers/sampledata.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/models/marketplace/modals.dart';
import 'package:bitnet/pages/marketplace/collection/collection_header.dart';
import 'package:bitnet/pages/marketplace/collection/collection_tab_bar.dart';
import 'package:bitnet/pages/marketplace/collection/tabs/column_tab_view.dart';
import 'package:bitnet/pages/marketplace/collection/tabs/info_tab_view.dart';
import 'package:bitnet/pages/marketplace/collection/tabs/owners_tab_view.dart';
import 'package:bitnet/pages/marketplace/collection/tabs/price_sales_tab_view.dart';
import 'package:bitnet/pages/marketplace/collection/tabs/row_tab_view.dart';
import 'package:bitnet/pages/marketplace/widgets/buy_sliding_panel.dart';
import 'package:bitnet/pages/marketplace/widgets/cart_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';

class CollectionScreen extends StatefulWidget {
  final GoRouterState? routerState;
  final BuildContext context;
  const CollectionScreen(
      {Key? key, required this.routerState, required this.context})
      : super(key: key);

  @override
  State<CollectionScreen> createState() => _CollectionScreenState();
}

class _CollectionScreenState extends State<CollectionScreen> {
  final inscriptions = [2424242, 3434343];
  var searchFilter = 1;
  late var sortingFilter;
  var sortedGridList = gridListData;
  var selectedProducts = [];
  var showCartBottomSheet = false;
  var itemBuy = -1;
  PersistentBottomSheetController? sheetController;
  Widget? bottomSheet;
  late PanelController buyPanelController;
  int currentTabIndex = 0;

  @override
  void initState() {
    super.initState();
    sortingFilter = L10n.of(widget.context)!.recentlyListed;
    sortList(searchFilter, sortingFilter);
    buyPanelController = PanelController();
  }

  void showBuyPanel(int id) {
    setState(() {
      itemBuy = id;
      BuySlidingPanel.show(context, id, sortedGridList).whenComplete(() {
        itemBuy = -1;
        setState(() {});
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final name = widget.routerState!.pathParameters['collection_id'];

    return bitnetScaffold(
      extendBodyBehindAppBar: true,
      appBar: bitnetAppBar(
        context: context,
        onTap: () => context.pop(),
      ),
      context: context,
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: CollectionHeader(
                  size: size,
                  name: name,
                  inscriptions: inscriptions,
                ),
              ),
              SliverToBoxAdapter(
                child: CollectionTabBar(
                  currentTabIndex: currentTabIndex,
                  onTabChanged: (index) {
                    setState(() {
                      currentTabIndex = index;
                    });
                  },
                ),
              ),
              // Row View Tab (now first)
              SliverOffstage(
                offstage: currentTabIndex != 0,
                sliver: RowTabView(
                  sortedGridList: sortedGridList,
                  selectedProducts: selectedProducts,
                  handleProductClick: handleProductClick,
                  showBuyPanel: showBuyPanel,
                ),
              ),
              // Column View Tab (now second)
              SliverOffstage(
                offstage: currentTabIndex != 1,
                sliver: ColumnTabView(
                  sortedGridList: sortedGridList,
                  selectedProducts: selectedProducts,
                  handleProductClick: handleProductClick,
                  showBuyPanel: showBuyPanel,
                  onSortingChanged: (str) {
                    setState(() {
                      sortingFilter = str;
                      sortList(searchFilter, sortingFilter);
                    });
                  },
                  currentSortingFilter: sortingFilter,
                ),
              ),
              // // Price/Sales Tab
              SliverOffstage(
                  offstage: currentTabIndex != 2, sliver: PriceSalesTabView()),
              // Owners Tab
              SliverOffstage(
                  offstage: currentTabIndex != 3, sliver: OwnersTabView()),
              // Info Tab
              SliverOffstage(
                  offstage: currentTabIndex != 4, sliver: InfoTabView()),
              
              // Bottom padding for better scrolling
              SliverToBoxAdapter(
                child: SizedBox(height: 100.h),
              ),
            ],
          ),

          // Cart Bottom Sheet
          if (showCartBottomSheet && itemBuy == -1 && bottomSheet != null)
            bottomSheet!
        ],
      ),
    );
  }

  void sortList(searchFilter, sortFilter) {
    // First we filter using the search filter
    List<GridListModal> newList = [];
    switch (searchFilter) {
      case 0:
        for (int i = 0; i < gridListData.length; i++) {
          if (!gridListData[i].sold) {
            newList.add(gridListData[i]);
          }
        }
      case 1:
        newList = gridListData;
      case 2:
        for (int i = 0; i < gridListData.length; i++) {
          if (gridListData[i].sold) {
            newList.add(gridListData[i]);
          }
        }
    }

    switch (sortFilter) {
      case "Recently Listed":
        newList.sort((a, b) {
          return a.date.compareTo(b.date);
        });
      case "Rank":
        newList.sort(
          (a, b) {
            return a.rank.compareTo(b.rank);
          },
        );
      case "Lowest Price":
        newList.sort(
          (a, b) {
            var priceA = double.parse(a.cryptoText);
            var priceB = double.parse(b.cryptoText);
            return priceA.compareTo(priceB);
          },
        );
      case "Highest Price":
        newList.sort(
          (a, b) {
            var priceA = double.parse(a.cryptoText);
            var priceB = double.parse(b.cryptoText);
            return -priceA.compareTo(priceB);
          },
        );
      case "Lowest Inscription":
        newList.sort(
          (a, b) {
            var inscriptionA = int.parse(a.nftMainName.substring(
                a.nftMainName.indexOf('#') + 1, (a.nftMainName.length)));
            var inscriptionB = int.parse(b.nftMainName.substring(
                b.nftMainName.indexOf('#') + 1, (b.nftMainName.length)));

            return inscriptionA.compareTo(inscriptionB);
          },
        );
      case "Highest Inscription":
        newList.sort(
          (a, b) {
            var inscriptionA = int.parse(a.nftMainName.substring(
                a.nftMainName.indexOf('#') + 1, (a.nftMainName.length)));
            var inscriptionB = int.parse(b.nftMainName.substring(
                b.nftMainName.indexOf('#') + 1, (b.nftMainName.length)));

            return -inscriptionA.compareTo(inscriptionB);
          },
        );
    }

    setState(() {
      sortedGridList = newList;
    });
  }

  void handleProductClick(int id, BuildContext ctx) {
    setState(() {
      if (selectedProducts.contains(id)) {
        selectedProducts.remove(id);
      } else {
        selectedProducts.add(id);
      }

      if (selectedProducts.isEmpty) {
        showCartBottomSheet = false;
        if (sheetController != null) {
          sheetController!.close();
        }
        bottomSheet = null;
      } else {
        showCartBottomSheet = true;

        bottomSheet = SlidingUpPanel(
            color: Colors.transparent,
            boxShadow: [],
            maxHeight: 600,
            minHeight: 100,
            panel: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: CartSheet(
                  selected_products: selectedProducts,
                  sortedGridList: sortedGridList,
                  onClear: () {
                    setState(() {
                      selectedProducts.clear();
                      showCartBottomSheet = false;
                    });
                  },
                  onDeleteItem: (i) {
                    setState(() {
                      Get.find<LoggerService>()
                          .i("about to delete item with id: ${i}");
                      selectedProducts.remove(i);
                      if (selectedProducts.isEmpty) {
                        showCartBottomSheet = false;
                      }
                    });
                  }),
            ));
      }
    });
  }
}
