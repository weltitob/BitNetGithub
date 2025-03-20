import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/services/timezone_provider.dart';
import 'package:bitnet/components/loaders/loaders.dart';
import 'package:bitnet/models/postmodels/post_component.dart';
import 'package:bitnet/pages/other_profile/other_profile_controller.dart';
import 'package:bitnet/pages/profile/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:timezone/timezone.dart';
import 'dart:math';

class ColumnViewTab extends StatefulWidget {
  const ColumnViewTab({Key? key, this.other = false}) : super(key: key);
  final bool other;
  
  @override
  State<ColumnViewTab> createState() => _ColumnViewTabState();
}

class _ColumnViewTabState extends State<ColumnViewTab> {
  late final controller;
  
  // Bitcoin genesis block timestamp: January 3, 2009, 18:15:05 GMT
  final DateTime genesisBlockTime = DateTime.utc(2009, 1, 3, 18, 15, 05);
  
  // Helper method to convert lockTime to DateTime based on Bitcoin block height
  DateTime _convertBlockHeightToDateTime(int blockHeight) {
    // Bitcoin has a target of 1 block every 10 minutes (600 seconds)
    // Calculate approximate time since genesis block
    final int secondsSinceGenesis = blockHeight * 600; // 10 minutes per block
    
    // Add this duration to the genesis block time
    return genesisBlockTime.add(Duration(seconds: secondsSinceGenesis));
  }
  
  // Helper method to decide if a value is a block height or Unix timestamp
  DateTime _convertLockTimeToDateTime(int lockTime) {
    // Current timestamp in seconds
    final int nowInSeconds = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    
    // If lockTime is close to current timestamp (within 10 years), treat as Unix timestamp
    if (nowInSeconds - lockTime < 315360000) { // 10 years in seconds
      return DateTime.fromMillisecondsSinceEpoch(lockTime * 1000);
    }
    
    // Handle very recent block heights (last 2 years)
    // Current estimated block height (~830,000 as of early 2025)
    if (lockTime > 750000 && lockTime < 900000) {
      return _convertBlockHeightToDateTime(lockTime);
    }
    
    // If lockTime is very small, it's likely a block height from early days
    if (lockTime < 100000) {
      return _convertBlockHeightToDateTime(lockTime);
    }
    
    // For other values, use a more recent reference point
    // This handles newer assets with more recent timestamps
    final DateTime recentReferenceDate = DateTime.now().subtract(const Duration(days: 90));
    return recentReferenceDate;
  }
  
  @override
  void initState() {
    super.initState();
    controller = widget.other
        ? Get.find<OtherProfileController>()
        : Get.put(ProfileController());
  }
  
  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return !controller.isLoading.value && controller.assets.isEmpty
            ? SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.error),
                      const SizedBox(width: AppTheme.cardPadding),
                      Text(
                        'No assets found',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                ),
              )
            : Obx(
                () => SliverList.builder(
                  itemCount: controller.assetsLazyLoading.length + 1,
                  itemBuilder: (context, index) {
                    if (index < controller.assetsLazyLoading.length) {
                      final asset = controller.assetsLazyLoading[index];
                      final assetId = asset.assetGenesis?.assetId ?? '';
                      final meta = controller.assetMetaMap[assetId];
                      
                      return GestureDetector(
                        onTap: () {
                          context.push(
                            "/asset_screen/$assetId",
                          );
                        },
                        child: PostComponent(
                          postId: assetId,
                          ownerId: "${controller.userData.value.username}" ?? '',
                          displayname: "${controller.userData.value.displayName}" ?? '',
                          username: "${controller.userData.value.username}" ?? '',
                          postName: asset.assetGenesis?.name ?? '',
                          rockets: {},
                          medias: meta != null ? meta.toMedias() : [],
                          timestamp: _convertLockTimeToDateTime(asset.lockTime ?? 0),
                        ),
                      );
                    } else {
                      // Show loader at the end
                      return controller.assetsLoading.value
                          ? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: dotProgress(context),
                              ),
                            )
                          : const SizedBox.shrink();
                    }
                  },
                ),
              );
      },
    );
  }
}