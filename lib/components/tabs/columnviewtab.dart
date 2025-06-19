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
    // Special case for zero or very small values (likely uninitialized)
    if (lockTime <= 1) {
      return DateTime.now();
    }

    // Current timestamp in seconds
    final int nowInSeconds = DateTime.now().millisecondsSinceEpoch ~/ 1000;

    // If lockTime is within a reasonable range for a recent Unix timestamp
    // (from 2015 to present)
    if (lockTime > 1420070400 && lockTime <= nowInSeconds) {
      // Jan 1, 2015 to now
      return DateTime.fromMillisecondsSinceEpoch(lockTime * 1000);
    }

    // Handle Bitcoin block heights in the expected range
    // Modern Bitcoin blocks are >750,000 as of early 2025
    if (lockTime >= 1 && lockTime < 1000000) {
      return _convertBlockHeightToDateTime(lockTime);
    }

    // For any other values that don't make sense as either a timestamp or block height
    // Return a recent time as fallback
    // This handles edge cases without showing an unreasonable date
    return DateTime.now().subtract(const Duration(hours: 2));
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
                child: Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: AppTheme.cardPadding,
                    vertical: AppTheme.cardPadding * 2,
                  ),
                  padding: const EdgeInsets.all(AppTheme.cardPadding * 1.5),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor.withOpacity(0.5),
                    borderRadius: AppTheme.cardRadiusMid,
                    border: Border.all(
                      color: Theme.of(context).dividerColor.withOpacity(0.1),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(AppTheme.cardPadding),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.collections_outlined,
                          size: AppTheme.cardPadding * 2,
                          color: Theme.of(context).colorScheme.primary.withOpacity(0.7),
                        ),
                      ),
                      const SizedBox(height: AppTheme.elementSpacing),
                      Text(
                        'No Assets Yet',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: AppTheme.elementSpacing * 0.5),
                      Text(
                        'Your created assets will appear here',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.7),
                        ),
                        textAlign: TextAlign.center,
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

                      return PostComponent(
                        onTap: () {
                          context.push("/asset_screen",
                              extra: {'nft_id': assetId});
                        },
                        postId: assetId,
                        ownerId: "${controller.userData.value.username}" ?? '',
                        displayname:
                            "${controller.userData.value.displayName}" ?? '',
                        username: "${controller.userData.value.username}" ?? '',
                        postName: asset.assetGenesis?.name ?? '',
                        rockets: {},
                        medias: meta != null ? meta.toMedias() : [],
                        timestamp:
                            _convertLockTimeToDateTime(asset.lockTime ?? 0),
                        // Add original lockTime for debugging
                        debugLockTime: asset.lockTime ?? 0,
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
