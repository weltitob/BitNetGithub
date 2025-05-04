import 'dart:convert';

import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/buttons/roundedbutton.dart';
import 'package:bitnet/components/container/avatar.dart';
import 'package:bitnet/components/container/imagewithtext.dart';
import 'package:bitnet/components/loaders/loaders.dart';
import 'package:bitnet/components/marketplace_widgets/AssetCard.dart';
import 'package:bitnet/models/tapd/assetmeta.dart';
import 'package:bitnet/pages/other_profile/other_profile_controller.dart';
import 'package:bitnet/pages/profile/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../models/tapd/asset.dart';

class RowViewTab extends StatefulWidget {
  final bool other;

  const RowViewTab({super.key, this.other = false});
  @override
  _RowViewTabState createState() => _RowViewTabState();
}

class _RowViewTabState extends State<RowViewTab>
    with SingleTickerProviderStateMixin {
  bool get wantKeepAlive => true;
  late final controller;
  @override
  void initState() {
    super.initState();
    controller = widget.other
        ? Get.find<OtherProfileController>()
        : Get.put(ProfileController());
  }

  String? findCollectionValue(AssetMetaResponse meta) {
    String decodedData = meta.decodeData();
    Map<String, dynamic> jsonMap;
    try {
      jsonMap = jsonDecode(decodedData);
      if (jsonMap.containsKey('collection')) {
        return jsonMap['collection'].toString();
      }
    } catch (e) {
      // Handle error if decoding or parsing fails
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final assetsByGroup = <String, List<dynamic>>{};

    for (var asset in controller.assets) {
      final groupMap = asset.assetGroup as Map<String, dynamic>? ?? {};
      final groupName = groupMap['raw_group_key']?.toString() ?? "None";

      if (!assetsByGroup.containsKey(groupName)) {
        assetsByGroup[groupName] = [];
      }
      assetsByGroup[groupName]!.add(asset);
    }

    return Obx(() {
      return controller.isLoading.value
          ? SliverToBoxAdapter(child: dotProgress(context))
          : SliverList(
              // mainAxisAlignment: MainAxisAlignment.start,
              // crossAxisAlignment: CrossAxisAlignment.start,
              delegate:
                  SliverChildListDelegate(assetsByGroup.entries.map((entry) {
                final groupName = entry.key;
                final groupAssets = entry.value;

                // Check if all loaded assets in this group have the same "collection" value
                String displayName = groupName;
                final loadedAssetsMeta = groupAssets
                    .take(10)
                    .map((asset) => controller
                        .assetMetaMap[asset.assetGenesis!.assetId ?? ''])
                    .where((meta) => meta != null)
                    .toList();

                if (loadedAssetsMeta.isNotEmpty) {
                  String? firstCollectionValue =
                      findCollectionValue(loadedAssetsMeta.first!);
                  if (firstCollectionValue != null &&
                      loadedAssetsMeta.every((meta) =>
                          findCollectionValue(meta!) == firstCollectionValue)) {
                    displayName = firstCollectionValue;
                  }
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          left: AppTheme.elementSpacing.w,
                          bottom: AppTheme.elementSpacing * 1,
                          right: AppTheme.elementSpacing.w),
                      child: Padding(
                        padding:
                            const EdgeInsets.all(AppTheme.elementSpacing / 2),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Avatar(
                                  size: AppTheme.cardPadding * 1.75.h,
                                  isNft: false,
                                ),
                                SizedBox(
                                  width: AppTheme.elementSpacing * 0.75.w,
                                ),
                                Container(
                                  width: AppTheme.cardPadding.w * 8,
                                  child: Text(
                                    displayName,
                                    maxLines: 2,
                                    textAlign: TextAlign.start,
                                    overflow: TextOverflow.ellipsis,
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  ),
                                ),
                              ],
                            ),
                            RoundedButtonWidget(
                                size: AppTheme.cardPadding.h * 1.25,
                                buttonType: ButtonType.transparent,
                                iconData: Icons.arrow_forward_ios_rounded,
                                onTap: () {})
                          ],
                        ),
                      ),
                    ),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      padding: EdgeInsets.symmetric(
                          horizontal: AppTheme.elementSpacing.w / 2),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // 2 items per row
                        mainAxisSpacing: AppTheme.elementSpacing.h,
                        crossAxisSpacing: AppTheme.elementSpacing.w / 6,
                        childAspectRatio: (size.width / 2) /
                            240.w, // Adjust according to your design
                      ),
                      itemCount:
                          groupAssets.length > 10 ? 10 : groupAssets.length,
                      itemBuilder: (context, index) {
                        final asset = groupAssets[index];
                        final meta = controller
                            .assetMetaMap[asset.assetGenesis!.assetId ?? ''];

                        return Container(
                          child: AssetCard(
                            scale: 0.75,
                            medias: meta?.toMedias() ?? [],
                            nftName: meta?.data ?? 'metahash',
                            nftMainName: asset.assetGenesis!.name ?? 'assetID',
                            assetId: asset.assetGenesis!.assetId ?? "",
                            hasListForSale: true,
                            isOwner: true,
                            cryptoText: asset.lockTime != null
                                ? asset.lockTime.toString()
                                : 'price',
                          ),
                        );
                      },
                    ),
                    if (groupAssets.length > 10)
                      Padding(
                        padding:
                            EdgeInsets.only(top: AppTheme.elementSpacing.w),
                        child: Center(
                          child: LongButtonWidget(
                            buttonType: ButtonType.transparent,
                            customHeight: AppTheme.cardPadding * 1.5,
                            customWidth: AppTheme.cardPadding * 4.5,
                            title: 'View All',
                            onTap: () {},
                          ),
                        ),
                      ),
                    SizedBox(
                      height: AppTheme.cardPadding,
                    )
                  ],
                );
              }).toList()),
            );
    });
  }
}
