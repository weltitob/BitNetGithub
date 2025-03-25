import 'package:bitnet/backbone/helper/marketplace_helpers/imageassets.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/models/marketplace/modals.dart';
import 'package:bitnet/models/postmodels/media_model.dart';
import 'package:bitnet/models/postmodels/post_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class RowTabView extends StatelessWidget {
  final List<GridListModal> sortedGridList;
  final List<dynamic> selectedProducts;
  final Function(int, BuildContext) handleProductClick;
  final Function(int) showBuyPanel;

  const RowTabView({
    Key? key,
    required this.sortedGridList,
    required this.selectedProducts,
    required this.handleProductClick,
    required this.showBuyPanel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Group assets by their collections
    final Map<String, List<GridListModal>> groupedAssets = {};
    
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
            padding: EdgeInsets.symmetric(vertical: AppTheme.cardPadding.h),
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
                
                // Horizontal List of Assets using PostComponent
                Container(
                  height: 350.h, // Increased height to accommodate PostComponent
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: collectionAssets.length,
                    itemBuilder: (context, index) {
                      final item = collectionAssets[index];
                      
                      // Create Media object for the post component
                      final media = Media(
                        data: item.nftImage,
                        type: "image", // Changed from asset_image to image to match PostComponent format
                      );
                      
                      // Create fake rockets map with current user state
                      Map<String, bool> rockets = {};
                      if (selectedProducts.contains(item.id)) {
                        rockets["current_user"] = true;
                      }
                      
                      return Padding(
                        padding: EdgeInsets.only(right: 16.w),
                        child: Container(
                          width: 280.w, // Set an appropriate width for horizontal scrolling
                          child: GestureDetector(
                            onTap: () {
                              if (selectedProducts.isNotEmpty) {
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
                                // PostComponent usage instead of AssetCard
                                PostComponent(
                                  postId: item.id.toString(),
                                  ownerId: "marketplace_owner", // Placeholder owner ID
                                  username: "marketplace", // Placeholder username
                                  displayname: item.nftMainName,
                                  rockets: rockets,
                                  medias: [media],
                                  timestamp: DateTime.now(), // Use current time as placeholder
                                  postName: item.nftName,
                                ),
                                
                                // Buy button overlay
                                Positioned(
                                  right: 20,
                                  top: 50,
                                  child: GestureDetector(
                                    onTap: () => showBuyPanel(item.id),
                                    child: Container(
                                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                                      decoration: BoxDecoration(
                                        color: AppTheme.colorBitcoin,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            "Buy: ",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12,
                                            ),
                                          ),
                                          Text(
                                            "${item.cryptoText} ₿",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
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
}