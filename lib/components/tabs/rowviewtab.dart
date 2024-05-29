import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/container/avatar.dart';
import 'package:bitnet/components/loaders/loaders.dart';
import 'package:bitnet/components/marketplace_widgets/NftProductSlider.dart';
import 'package:bitnet/pages/profile/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class RowViewTab extends StatefulWidget {
  @override
  _RowViewTabState createState() => _RowViewTabState();
}

class _RowViewTabState extends State<RowViewTab>
    with SingleTickerProviderStateMixin {
  bool get wantKeepAlive => true;
  final controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: SingleChildScrollView(
        child: Obx(() {
          return controller.isLoading.value
              ? dotProgress(context)
              : LayoutBuilder(
            builder: (context, constraints) {
              final assetsByGroup = <String, List<dynamic>>{};

              for (var asset in controller.assets) {
                final groupMap = asset.assetGroup as Map<String, dynamic>? ?? {};
                final groupName = groupMap['raw_group_key']?.toString() ?? "None";

                if (!assetsByGroup.containsKey(groupName)) {
                  assetsByGroup[groupName] = [];
                }
                assetsByGroup[groupName]!.add(asset);
              }

              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: assetsByGroup.entries.map((entry) {
                  final groupName = entry.key;
                  final groupAssets = entry.value;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: AppTheme.elementSpacing, top: AppTheme.cardPadding, bottom: AppTheme.elementSpacing),
                        child: Row(
                          children: [
                            Avatar(
                              size: AppTheme.cardPadding * 1.5,
                            ),
                            SizedBox(
                              width: AppTheme.elementSpacing * 0.75,
                            ),
                            Container(
                              width: AppTheme.cardPadding * 10,
                              child: Text(
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.ellipsis,
                                groupName,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium,
                              ),
                            ),
                          ],
                        ),
                      ),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        padding: EdgeInsets.symmetric(
                            horizontal: AppTheme.elementSpacing.w),
                        gridDelegate:
                        SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, // 2 items per row
                          crossAxisSpacing: AppTheme.elementSpacing.w,
                          mainAxisSpacing: AppTheme.elementSpacing.h,
                          childAspectRatio: (size.width / 2) / 230.w, // Adjust according to your design
                        ),
                        itemCount: groupAssets.length,
                        itemBuilder: (context, index) {
                          final asset = groupAssets[index];
                          final meta = controller.assetMetaMap[
                          asset.assetGenesis!.assetId ?? ''];

                          return Container(
                            constraints: BoxConstraints(
                              minHeight:
                              230.w, // Set minimum height to match childAspectRatio
                            ),
                            child: NftProductSlider(
                              scale: 0.75,
                              medias: meta?.toMedias() ?? [],
                              nftName: meta?.data ?? 'metahash',
                              nftMainName:
                              asset.assetGenesis!.name ?? 'assetID',
                              cryptoText: asset.lockTime != null
                                  ? asset.lockTime.toString()
                                  : 'price',
                            ),
                          );
                        },
                      ),
                    ],
                  );
                }).toList(),
              );
            },
          );
        }),
      ),
    );
  }
}
