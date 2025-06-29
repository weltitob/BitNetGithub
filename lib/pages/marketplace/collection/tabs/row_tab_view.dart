import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/models/marketplace/modals.dart';
import 'package:bitnet/models/postmodels/media_model.dart';
import 'package:bitnet/models/postmodels/post_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

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
    List<dynamic> gridList = List.empty(growable: true);
    for (List<GridListModal> item in groupedAssets.values) {
      gridList.add("stop");
      gridList.addAll(item);
      gridList.add("stop");
    }
    return SliverList(
      delegate: SliverChildListDelegate(
        gridList.map((entry) {
          if (entry is String) {
            return SizedBox(height: AppTheme.elementSpacing.h / 2);
          }
          GridListModal item = entry as GridListModal;
          final media = Media(
            data: item.nftImage,
            type:
                "image", // Changed from asset_image to image to match PostComponent format
          );

          // Create fake rockets map with current user state
          Map<String, bool> rockets = {};
          if (selectedProducts.contains(item.id)) {
            rockets["current_user"] = true;
          }

          // Use PostComponent directly without transform, matching profile screen
          return PostComponent(
            postId: item.id.toString(),
            ownerId: "marketplace_owner", // Placeholder owner ID
            username: "marketplace", // Placeholder username
            displayname: item.nftMainName,
            rockets: rockets,
            medias: [media],
            timestamp: DateTime.now(), // Use current time as placeholder
            postName: item.nftName,
            onTap: () {
              context
                  .push('/asset_screen', extra: {'nft_id': item.id.toString()});
            },
          );
        }).toList(),
      ),
    );
  }
}
