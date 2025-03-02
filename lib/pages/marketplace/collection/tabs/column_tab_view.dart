import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/dialogsandsheets/bottom_sheets/bit_net_bottom_sheet.dart';
import 'package:bitnet/components/fields/searchfield/searchfield.dart';
import 'package:bitnet/components/marketplace_widgets/AssetCard.dart';
import 'package:bitnet/models/marketplace/modals.dart';
import 'package:bitnet/models/postmodels/media_model.dart';
import 'package:bitnet/pages/marketplace/widgets/filter_bottom_sheet.dart';
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
      padding: EdgeInsets.symmetric(horizontal: AppTheme.elementSpacing.w,),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Filter Row with SearchField
          SizedBox(height: AppTheme.cardPadding.h,),
          Row(
            children: [
              Expanded(
                child: SearchFieldWidget(
                  hintText: "Search...",
                  isSearchEnabled: true,
                  handleSearch: (value) {
                    // Implement search functionality
                  },
                  onChanged: (value) {
                    // Implement onChange functionality
                  },
                  suffixIcon: IconButton(
                    icon: Icon(Icons.filter_list),
                    onPressed: () {
                      // Show filter bottom sheet
                      BitNetBottomSheet(
                        context: context,
                        height: MediaQuery.of(context).size.height * 0.7,
                        child: FilterBottomSheet(
                          onSortingChanged: onSortingChanged,
                          currentSortingFilter: currentSortingFilter,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: AppTheme.cardPadding.h,),
          
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