import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/loaders/loaders.dart';
import 'package:bitnet/models/postmodels/post.dart';
import 'package:bitnet/models/tapd/assetmeta.dart';
import 'package:bitnet/pages/profile/profile_controller.dart';
import 'package:bitnet/pages/routetrees/marketplaceroutes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class ColumnViewTab extends StatefulWidget {
  const ColumnViewTab({Key? key}) : super(key: key);

  @override
  State<ColumnViewTab> createState() => _ColumnViewTabState();
}

class _ColumnViewTabState extends State<ColumnViewTab> {
  final controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Obx(
          () {
        return !controller.isLoading.value && controller.assets.isEmpty
            ? Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error),
              SizedBox(width: AppTheme.cardPadding),
              Text(
                'No assets found',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
        )
            : Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: controller.assetsLazyLoading.length + (controller.assetsLoading ? 1 : 0),
              itemBuilder: (context, index) {
                if (index < controller.assetsLazyLoading.length) {
                  final asset = controller.assetsLazyLoading[index];
                  final assetId = asset.assetGenesis?.assetId ?? '';
                  final meta = controller.assetMetaMap[assetId];
                  print("Asset ID: $assetId");
                  return GestureDetector(
                    onTap: () {
                      context.go("/asset_screen/$assetId",);
                      // context.goNamed('asset_screen', pathParameters: {
                      //   'nft_id': assetId,
                      // });
                    },
                    child: Post(
                      postId: assetId,
                      ownerId: "Tobias Welti" ?? '',
                      username: "username" ?? '',
                      postName: asset.assetGenesis?.name ?? '',
                      rockets: {},
                      medias: meta != null ? meta.toMedias() : [],
                      timestamp: DateTime.fromMillisecondsSinceEpoch(asset.lockTime! * 1000),
                    ),
                  );
                } else {
                  // Show loader at the end
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: dotProgress(context),
                    ),
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }
}
