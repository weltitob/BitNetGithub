import 'package:bitnet/backbone/helper/marketplace_helpers/imageassets.dart';
import 'package:bitnet/backbone/helper/marketplace_helpers/sampledata.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetListTile.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/container/imagewithtext.dart';
import 'package:bitnet/components/dialogsandsheets/bottom_sheets/bit_net_bottom_sheet.dart';
import 'package:bitnet/components/marketplace_widgets/AssetCard.dart';
import 'package:bitnet/components/marketplace_widgets/CommonHeading.dart';
import 'package:bitnet/components/marketplace_widgets/NftProductHorizontal.dart';
import 'package:bitnet/components/marketplace_widgets/NftProductSliderClickable.dart';
import 'package:bitnet/components/marketplace_widgets/OwnerDataText.dart';
import 'package:bitnet/models/marketplace/modals.dart';
import 'package:bitnet/models/postmodels/media_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:bitnet/pages/routetrees/marketplaceroutes.dart' as route;
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:popover/popover.dart';
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
  var search_filter = 1;
  late var sorting_filter;
  var sortedGridList = gridListData;
  var selected_products = [];
  var showCartBottomSheet = false;
  var item_buy = -1;
  PersistentBottomSheetController? sheetCtrler;
  Widget? bottomSheet;
  late PanelController buyPanelController;
  int currentTabIndex = 0;
  late List<Widget> tabPages;
  
  @override
  initState() {
    sorting_filter = L10n.of(widget.context)!.recentlyListed;
    sortList(search_filter, sorting_filter);
    buyPanelController = PanelController();
    _initTabPages();
    super.initState();
  }
  
  void _initTabPages() {
    tabPages = [
      // Column View - Grid layout of assets
      _buildColumnTabView(),
      // Row View - Assets organized by collections
      _buildRowTabView(),
      // Price/Sales - Price statistics and sales history
      _buildPriceSalesTabView(),
      // Owners - List of owners with their assets
      _buildOwnersTabView(),
      // Info - Collection information and description
      _buildInfoTabView(),
    ];
  }
  
  void showBuyPanel(int id) {
    setState(() {
      this.item_buy = id;
      _buildBuySlidingPanel(context).whenComplete(() {
        this.item_buy = -1;
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
          Column(
            children: [
              // Collection Header
              _buildCollectionHeader(size, name),
              
              // Tab Bar
              _buildTabBar(),
              
              // Tab Content
              Expanded(
                child: tabPages[currentTabIndex],
              )
            ],
          ),

          if (showCartBottomSheet && item_buy == -1 && bottomSheet != null)
            bottomSheet!
        ],
      ),
    );
  }
  
  Widget _buildTabBar() {
    return Container(
      height: 60.h,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 2,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildTabButton(0, Icons.view_column_rounded, "Column"),
          _buildTabButton(1, Icons.table_rows_rounded, "Row"),
          _buildTabButton(2, Icons.monetization_on, "Price"),
          _buildTabButton(3, Icons.people, "Owners"),
          _buildTabButton(4, Icons.info_outline, "Info"),
        ],
      ),
    );
  }
  
  Widget _buildTabButton(int index, IconData icon, String label) {
    bool isSelected = currentTabIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          currentTabIndex = index;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.colorBitcoin : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 20,
              color: isSelected ? Colors.white : Theme.of(context).iconTheme.color,
            ),
            if (isSelected) ...[
              SizedBox(width: 4),
              Text(
                label,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
  
  Widget _buildCollectionHeader(Size size, String? name) {
    return Container(
      padding: EdgeInsets.only(top: 90.h, bottom: 10.h),
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 38.h),
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.r),
                  child: Image.asset(
                    nftImage5,
                    width: size.width,
                    height: 160.h,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                child: SizedBox(
                  width: size.width,
                  child: Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100.r),
                      child: Image.asset(
                        user1Image,
                        width: 75.w,
                        height: 75.w,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          Text(
            name != null ? name : L10n.of(context)!.unknown,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          Text(
            'Inscriptions #${inscriptions[0]}-${inscriptions[inscriptions.length - 1]}',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }

  // Column Tab View Implementation
  Widget _buildColumnTabView() {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Filter Row
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.h),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: AppTheme.colorGlassContainer.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.search, size: 20),
                        SizedBox(width: 8),
                        Text("Search...", style: TextStyle(fontSize: 14)),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 8),
                SortingCategoryPopup(
                  onChanged: (str) {
                    setState(() {
                      sorting_filter = str;
                      sortList(search_filter, sorting_filter);
                    });
                  },
                  currentSortingCategory: sorting_filter,
                ),
              ],
            ),
          ),
          
          // Grid of Assets
          GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 4 / 6.5,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              crossAxisCount: 2,
            ),
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            itemCount: sortedGridList.length,
            itemBuilder: (BuildContext context, int index) {
              final item = sortedGridList[index];
              final media = Media(
                data: item.nftImage,
                type: "asset_image",
              );
              
              return GestureDetector(
                onTap: () {
                  if (!selected_products.isEmpty) {
                    handleProductClick(item.id, context);
                  } else {
                    context.goNamed('/asset_screen',
                      pathParameters: {
                        'nft_id': item.nftName
                      });
                  }
                },
                onLongPress: () {
                  handleProductClick(item.id, context);
                },
                child: Stack(
                  children: [
                    AssetCard(
                      scale: 0.95,
                      medias: [media],
                      nftName: item.nftName,
                      nftMainName: item.nftMainName,
                      cryptoText: item.cryptoText,
                      rank: item.rank.toString(),
                      hasPrice: true,
                      hasLiked: selected_products.contains(item.id),
                      hasListForSale: false,
                      postId: item.id.toString(),
                      onLikeChanged: (isLiked) {
                        handleProductClick(item.id, context);
                      },
                    ),
                    // Add Buy button overlay
                    Positioned(
                      right: 10,
                      bottom: 40,
                      child: GestureDetector(
                        onTap: () => showBuyPanel(item.id),
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                          decoration: BoxDecoration(
                            color: AppTheme.colorBitcoin,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            "Buy",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
  
  // Row Tab View Implementation  
  Widget _buildRowTabView() {
    // Group assets by their collections
    final groupedAssets = <String, List<GridListModal>>{};
    
    for (var asset in sortedGridList) {
      final groupName = asset.nftName;
      if (!groupedAssets.containsKey(groupName)) {
        groupedAssets[groupName] = [];
      }
      groupedAssets[groupName]!.add(asset);
    }
    
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: groupedAssets.entries.map((entry) {
          final collectionName = entry.key;
          final collectionAssets = entry.value;
          
          return Padding(
            padding: EdgeInsets.only(bottom: 24.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Collection Header
                Padding(
                  padding: EdgeInsets.only(bottom: 8.h),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          user1Image,
                          width: 40.w,
                          height: 40.w,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Text(
                          collectionName,
                          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ),
                      Icon(Icons.arrow_forward_ios, size: 16),
                    ],
                  ),
                ),
                
                // Horizontal List of Assets
                Container(
                  height: 240.h,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: collectionAssets.length,
                    itemBuilder: (context, index) {
                      final item = collectionAssets[index];
                      final media = Media(
                        data: item.nftImage,
                        type: "asset_image",
                      );
                      
                      return Padding(
                        padding: EdgeInsets.only(right: 12.w),
                        child: GestureDetector(
                          onTap: () {
                            if (!selected_products.isEmpty) {
                              handleProductClick(item.id, context);
                            } else {
                              context.goNamed('/asset_screen',
                                pathParameters: {
                                  'nft_id': item.nftName
                                });
                            }
                          },
                          child: Stack(
                            children: [
                              AssetCard(
                                scale: 0.9,
                                medias: [media],
                                nftName: item.nftName,
                                nftMainName: item.nftMainName,
                                cryptoText: item.cryptoText,
                                rank: item.rank.toString(),
                                hasPrice: true,
                                hasLiked: selected_products.contains(item.id),
                                hasListForSale: false,
                                postId: item.id.toString(),
                                onLikeChanged: (isLiked) {
                                  handleProductClick(item.id, context);
                                },
                              ),
                              // Buy button
                              Positioned(
                                right: 10,
                                bottom: 40,
                                child: GestureDetector(
                                  onTap: () => showBuyPanel(item.id),
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                                    decoration: BoxDecoration(
                                      color: AppTheme.colorBitcoin,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      "Buy",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
  
  // Price/Sales Tab View Implementation
  Widget _buildPriceSalesTabView() {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Price Statistics
          Text(
            "Price Statistics",
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          SizedBox(height: 12.h),
          
          // Statistics Cards
          _buildStatisticsCard(),
          SizedBox(height: 24.h),
          
          // Recent Sales
          Text(
            "Recent Sales",
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          SizedBox(height: 12.h),
          
          // Sales List
          _buildRecentSalesList(),
        ],
      ),
    );
  }
  
  Widget _buildStatisticsCard() {
    return GlassContainer(
      opacity: 0.1,
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            _buildStatRow("Floor Price", "0.025 BTC"),
            Divider(height: 24),
            _buildStatRow("24h Volume", "0.021 BTC"),
            Divider(height: 24),
            _buildStatRow("Total Volume", "1.0235 BTC"),
            Divider(height: 24),
            _buildStatRow("Listed", "52"),
            Divider(height: 24),
            _buildStatRow("Supply", "1000"),
            Divider(height: 24),
            _buildStatRow("Owners", "250"),
          ],
        ),
      ),
    );
  }
  
  Widget _buildStatRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.titleSmall!.copyWith(
                color: AppTheme.colorBitcoin,
              ),
        ),
        Text(
          value,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ],
    );
  }
  
  Widget _buildRecentSalesList() {
    final salesData = [
      {"id": "#2390", "price": "0.024 BTC", "date": "2 hours ago", "from": "User1", "to": "User2"},
      {"id": "#1872", "price": "0.031 BTC", "date": "5 hours ago", "from": "User3", "to": "User4"},
      {"id": "#2103", "price": "0.018 BTC", "date": "1 day ago", "from": "User5", "to": "User6"},
      {"id": "#1945", "price": "0.027 BTC", "date": "2 days ago", "from": "User7", "to": "User8"},
      {"id": "#2287", "price": "0.022 BTC", "date": "3 days ago", "from": "User9", "to": "User10"},
    ];
    
    return Column(
      children: salesData.map((sale) {
        return GlassContainer(
          opacity: 0.1,
          width: double.infinity,
          child: Container(
            margin: EdgeInsets.only(bottom: 8),
            child: Padding(
              padding: EdgeInsets.all(12),
              child: Row(
                children: [
                  // Asset image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      nftImage1,
                      width: 50.w,
                      height: 50.w,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  // Sale details
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Inscription ${sale["id"]}",
                          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "${sale["from"]} → ${sale["to"]}",
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                  // Price and time
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        sale["price"]!,
                        style: Theme.of(context).textTheme.titleMedium!.copyWith(
                              color: AppTheme.colorBitcoin,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        sale["date"]!,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
  
  // Owners Tab View Implementation
  Widget _buildOwnersTabView() {
    final ownersData = [
      {"name": "User1", "address": "bc1q...3x9f", "assets": 42, "percentage": "4.2%"},
      {"name": "User2", "address": "bc1q...7t2g", "assets": 38, "percentage": "3.8%"},
      {"name": "User3", "address": "bc1q...5k1h", "assets": 27, "percentage": "2.7%"},
      {"name": "User4", "address": "bc1q...9j4d", "assets": 19, "percentage": "1.9%"},
      {"name": "User5", "address": "bc1q...2m7s", "assets": 15, "percentage": "1.5%"},
      {"name": "User6", "address": "bc1q...6f3a", "assets": 12, "percentage": "1.2%"},
      {"name": "User7", "address": "bc1q...8n2v", "assets": 10, "percentage": "1.0%"},
      {"name": "User8", "address": "bc1q...1p4c", "assets": 8, "percentage": "0.8%"},
    ];
    
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Text(
            "Top Owners",
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          SizedBox(height: 12.h),
          
          // Owners List
          Column(
            children: ownersData.map((owner) {
              return GlassContainer(
                opacity: 0.1,
                width: double.infinity,

                child: Container(
                  margin: EdgeInsets.only(bottom: 8),
                  child: Padding(
                    padding: EdgeInsets.all(12),
                    child: Row(
                      children: [
                        // Owner avatar
                        ClipRRect(
                          borderRadius: BorderRadius.circular(25),
                          child: Image.asset(
                            user1Image,
                            width: 50.w,
                            height: 50.w,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: 12.w),
                        // Owner details
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                owner["name"].toString()!,
                                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                owner["address"].toString()!,
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                        // Assets count
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "${owner["assets"]} assets",
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            SizedBox(height: 4),
                            Text(
                              owner["percentage"].toString()!,
                              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                    color: AppTheme.colorBitcoin,
                                  ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
  
  // Info Tab View Implementation
  Widget _buildInfoTabView() {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Description
          Text(
            "Description",
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          SizedBox(height: 8.h),
          GlassContainer(
            opacity: 0.1,
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ),
          SizedBox(height: 24.h),
          
          // Social Links
          Text(
            "Links",
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          SizedBox(height: 8.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const OwnerDataText(
                ownerDataImg: discordIcon,
                ownerDataTitle: 'Discord',
                hasImage: true,
              ),
              const OwnerDataText(
                ownerDataImg: twitterIcon,
                ownerDataTitle: 'Twitter',
                hasImage: true,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                      context, route.kActivityScreenRoute);
                },
                child: OwnerDataText(
                  ownerDataImg: activityIcon,
                  ownerDataTitle: L10n.of(context)!.activity,
                  hasImage: true,
                ),
              ),
            ],
          ),
          SizedBox(height: 24.h),
          
          // Details
          Text(
            "Details",
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          SizedBox(height: 8.h),
          GlassContainer(
            opacity: 0.1,
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  _buildDetailRow("Contract Address", "bc1qwlcazq...k7mtl"),
                  Divider(height: 24),
                  _buildDetailRow("Token Standard", "BRC-20"),
                  Divider(height: 24),
                  _buildDetailRow("Creator Fee", "2.5%"),
                  Divider(height: 24),
                  _buildDetailRow("Chain", "Bitcoin"),
                  Divider(height: 24),
                  _buildDetailRow("Created", "April 2023"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.titleSmall!.copyWith(
                color: AppTheme.colorBitcoin,
              ),
        ),
        Text(
          value,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ],
    );
  }

  void sortList(search_filter, sort_filter) {
    //First we filter using the search filter
    List<GridListModal> newList = [];
    switch (search_filter) {
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
    switch (sort_filter) {
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
    sortedGridList = newList;
  }

  handleProductClick(int id, BuildContext ctx) {
    setState(() {
      if (selected_products.contains(id)) {
        selected_products.remove(id);
      } else {
        selected_products.add(id);
      }
      if (selected_products.isEmpty) {
        showCartBottomSheet = false;
        if (sheetCtrler != null) {
          sheetCtrler!.close();
        }
        bottomSheet = null;
        setState(() {});
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
                  selected_products: selected_products,
                  sortedGridList: sortedGridList,
                  onClear: () {
                    setState(() {
                      selected_products.clear();
                      showCartBottomSheet = false;
                    });
                  },
                  onDeleteItem: (i) {
                    setState(() {
                      Get.find<LoggerService>().i(
                          "about to delete item with id: ${sortedGridList[i].id}");
                      selected_products.remove(i);
                      if (selected_products.isEmpty) {
                        showCartBottomSheet = false;
                      }
                    });
                  }),
            ));
        setState(() {});
      }
    });
  }

  Widget _buildHorizontalProductWithId(int id) {
    var gridIndex = sortedGridList.indexWhere((element) => element.id == id);
    var product = Padding(
      padding: const EdgeInsets.only(bottom: 0),
      child: NftProductHorizontal(
        cryptoImage: sortedGridList[gridIndex].cryptoImage,
        nftImage: sortedGridList[gridIndex].nftImage,
        nftMainName: sortedGridList[gridIndex].nftMainName,
        nftName: sortedGridList[gridIndex].nftName,
        cryptoText: sortedGridList[gridIndex].cryptoText,
        rank: sortedGridList[gridIndex].rank,
        columnMargin: sortedGridList[gridIndex].columnMargin,
      ),
    );
    return product;
  }

  Future<T?> _buildBuySlidingPanel<T>(BuildContext ctx) {
    return BitNetBottomSheet(
      context: ctx,
      child: bitnetScaffold(
        extendBodyBehindAppBar: true,
        context: ctx,
        appBar: bitnetAppBar(
          context: ctx,
          text: "Purchase NFT",
          hasBackButton: false,
        ),
        body: Container(
          child: Padding(
            padding: const EdgeInsets.only(top: AppTheme.cardPadding * 2),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: AppTheme.elementSpacing),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: AppTheme.elementSpacing / 2,
                        ),
                        _buildHorizontalProductWithId(item_buy),
                        const SizedBox(
                          height: AppTheme.elementSpacing / 2,
                        ),
                        const BitNetListTile(
                          text: 'Subtotal',
                          trailing: Text('0.5'),
                        ),
                        const BitNetListTile(
                          text: 'Network Fee',
                          trailing: Text('0.5'),
                        ),
                        const BitNetListTile(
                          text: 'Market Fee',
                          trailing: Text('0.5'),
                        ),
                        const BitNetListTile(
                          text: 'Total Price',
                          trailing: Text('0.5'),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: AppTheme.cardPadding),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(
                          height: AppTheme.cardPadding,
                        ),
                        LongButtonWidget(
                          title: "Purchase",
                          onTap: () {},
                        ),
                        const SizedBox(
                          height: AppTheme.elementSpacing,
                        ),
                        LongButtonWidget(
                          title: "Cancel",
                          onTap: () {
                            Navigator.pop(context);
                          },
                          buttonType: ButtonType.transparent,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SortingCategoryPopup extends StatelessWidget {
  final Function(String str) onChanged;
  final String currentSortingCategory;
  const SortingCategoryPopup(
      {super.key,
      required this.onChanged,
      required this.currentSortingCategory});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showPopover(
        backgroundColor: Colors.transparent,
        context: context,
        direction: PopoverDirection.bottom,
        bodyBuilder: (context) {
          return _buildOptions(context);
        },
      ),
      child: Container(
          decoration: BoxDecoration(
              color: AppTheme.colorBitcoin,
              borderRadius: BorderRadius.circular(15)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
            child: Row(
              children: [
                Text(currentSortingCategory,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, color: Colors.white)),
                const Icon(Icons.arrow_drop_down_outlined)
              ],
            ),
          )),
    );
  }

  Widget _buildOptions(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: () {
            onChanged("Recently Listed");
            Navigator.of(context).pop();
          },
          child: Container(
              width: 160,
              decoration: BoxDecoration(
                  color: AppTheme.colorGlassContainer,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("Recently Listed",
                    style: TextStyle(color: Colors.white)),
              )),
        ),
        GestureDetector(
          onTap: () {
            onChanged("Rank");
            Navigator.of(context).pop();
          },
          child: Container(
              width: 160,
              decoration: BoxDecoration(
                color: AppTheme.colorGlassContainer,
              ),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("Rank", style: TextStyle(color: Colors.white)),
              )),
        ),
        GestureDetector(
          onTap: () {
            onChanged("Lowest Price");
            Navigator.of(context).pop();
          },
          child: Container(
              width: 160,
              decoration: BoxDecoration(
                color: AppTheme.colorGlassContainer,
              ),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child:
                    Text("Lowest Price", style: TextStyle(color: Colors.white)),
              )),
        ),
        GestureDetector(
          onTap: () {
            onChanged("Highest Price");
            Navigator.of(context).pop();
          },
          child: Container(
              width: 160,
              decoration: BoxDecoration(
                color: AppTheme.colorGlassContainer,
              ),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("Highest Price",
                    style: TextStyle(color: Colors.white)),
              )),
        ),
        GestureDetector(
          onTap: () {
            onChanged("Lowest Inscription");
            Navigator.of(context).pop();
          },
          child: Container(
              width: 160,
              decoration: BoxDecoration(
                color: AppTheme.colorGlassContainer,
              ),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("Lowest Inscription",
                    style: TextStyle(color: Colors.white)),
              )),
        ),
        GestureDetector(
          onTap: () {
            onChanged("Highest Inscription");
            Navigator.of(context).pop();
          },
          child: Container(
              width: 160,
              decoration: BoxDecoration(
                  color: AppTheme.colorGlassContainer,
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20))),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("Highest Inscription",
                    style: TextStyle(color: Colors.white)),
              )),
        )
      ],
    );
  }
}

class CartSheet extends StatefulWidget {
  const CartSheet(
      {super.key,
      this.onClear,
      this.onDeleteItem,
      required this.selected_products,
      required this.sortedGridList});
  final Function()? onClear;
  final Function(int)? onDeleteItem;
  final List<dynamic> selected_products;
  final List<GridListModal> sortedGridList;
  @override
  State<CartSheet> createState() => _CartSheetState();
}

class _CartSheetState extends State<CartSheet> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: AppTheme.elementSpacing),
        Container(
          height: AppTheme.elementSpacing / 1.5,
          width: AppTheme.cardPadding * 2.25,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onSurface,
            borderRadius: BorderRadius.circular(AppTheme.borderRadiusCircular),
          ),
        ),
        const SizedBox(height: AppTheme.elementSpacing * 0.75),
        Expanded(
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(32), topRight: Radius.circular(32)),
            child: Container(
              height: 600,
              child: MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: bitnetScaffoldUnsafe(
                  context: context,
                  extendBodyBehindAppBar: true,
                  appBar: bitnetAppBar(
                    context: context,
                    text:
                        "${L10n.of(context)!.cart}(${widget.selected_products.length})",
                    actions: [
                      TextButton(
                        child: Text(L10n.of(context)!.clearAll,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(color: Colors.white)),
                        onPressed: widget.onClear,
                      ),
                    ],
                    hasBackButton: false,
                  ),
                  body: Container(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 200.w,
                          child: ListView.builder(
                              itemCount: widget.selected_products.length,
                              itemBuilder: (ctx, i) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0),
                                  child: HorizontalProduct(
                                      item: widget.sortedGridList.firstWhere(
                                          (test) =>
                                              test.id ==
                                              widget.selected_products[i]),
                                      onDelete: () {
                                        if (widget.onDeleteItem != null) {
                                          widget.onDeleteItem!(
                                              widget.selected_products[i]);
                                          setState(() {});
                                        }
                                      }),
                                );
                              }),
                        ),
                        const Spacer(),
                        Container(
                          width: AppTheme.cardPadding * 10,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(L10n.of(context)!.subTotal),
                                  const Text("0.024")
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(L10n.of(context)!.networkFee),
                                  const Text("0.024")
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(L10n.of(context)!.marketFee),
                                  const Text("0.024")
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(L10n.of(context)!.totalPrice),
                                  const Text("0.024")
                                ],
                              ),
                              const SizedBox(height: 10),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: LongButtonWidget(
                              title: L10n.of(context)!.buyNow, onTap: () {}),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class HorizontalProduct extends StatelessWidget {
  const HorizontalProduct({super.key, required this.item, this.onDelete});
  final GridListModal item;
  final Function()? onDelete;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: NftProductHorizontal(
          cryptoImage: item.cryptoImage,
          nftImage: item.nftImage,
          nftMainName: item.nftMainName,
          nftName: item.nftName,
          cryptoText: item.cryptoText,
          rank: item.rank,
          columnMargin: item.columnMargin,
          onDelete: onDelete
          ),
    );
  }
}