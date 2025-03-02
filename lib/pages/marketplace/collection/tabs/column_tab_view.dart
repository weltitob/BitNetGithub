import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/marketplace_widgets/AssetCard.dart';
import 'package:bitnet/models/marketplace/modals.dart';
import 'package:bitnet/models/postmodels/media_model.dart';
import 'package:bitnet/pages/marketplace/widgets/sorting_category_popup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class ColumnTabView extends StatelessWidget {
  final List<GridListModal> sortedGridList;
  final List<dynamic> selectedProducts;
  final Function(int, BuildContext) handleProductClick;
  final Function(int) showBuyPanel;
  final Function(String) onSortingChanged;
  final String currentSortingFilter;

  const ColumnTabView({
    Key? key,
    required this.sortedGridList,
    required this.selectedProducts,
    required this.handleProductClick,
    required this.showBuyPanel,
    required this.onSortingChanged,
    required this.currentSortingFilter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  onChanged: (str) => onSortingChanged(str),
                  currentSortingCategory: currentSortingFilter,
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
                  if (selectedProducts.isNotEmpty) {
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
                      hasLiked: selectedProducts.contains(item.id),
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
}