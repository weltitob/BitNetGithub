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
import 'package:sliver_tools/sliver_tools.dart';

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
    final Size size = MediaQuery.of(context).size;
    return MultiSliver(children: [
      SliverToBoxAdapter(
          child: SizedBox(
        height: AppTheme.cardPadding.h,
      )),
      SliverToBoxAdapter(
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppTheme.cardPadding.w,
                ),
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
                    icon: Icon(Icons.filter_alt_rounded),
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
            ),
          ],
        ),
      ),
      SliverToBoxAdapter(
          child: SizedBox(
        height: AppTheme.cardPadding.h,
      )),
      SliverPadding(
        padding: EdgeInsets.symmetric(horizontal: AppTheme.cardPadding.w),
        sliver: SliverGrid.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // 2 items per row
            mainAxisSpacing: AppTheme.elementSpacing.h,
            crossAxisSpacing: AppTheme.elementSpacing.w,
            childAspectRatio:
                (size.width / 2) / 240.w, // Adjust according to your design
          ),
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
                context.push('/asset_screen',
                    extra: {'nft_id': item.id.toString()});
              }
            },
            onLongPress: () {
              handleProductClick(item.id, context);
            },
            child: Stack(
              children: [
                AssetCard(
                  medias: [media],
                  scale: 0.75,
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
                  onPriceClicked: (id) {
                    showBuyPanel(id);
                  },
                ),
              ],
            ),
          );
        },
        ),
      )
    ]);
  }
}
