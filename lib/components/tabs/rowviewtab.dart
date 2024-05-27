import 'package:bitnet/backbone/cloudfunctions/taprootassets/fetchassetmeta.dart';
import 'package:bitnet/backbone/cloudfunctions/taprootassets/list_assets.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/loaders/loaders.dart';
import 'package:bitnet/components/marketplace_widgets/NftProductSlider.dart';
import 'package:bitnet/models/tapd/asset.dart';
import 'package:bitnet/models/tapd/assetmeta.dart';
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
        child: Obx((){
          return controller.isLoading.value
            ? dotProgress(context)
            : LayoutBuilder(
          builder: (context, constraints) {
            return GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              padding: EdgeInsets.symmetric(horizontal: AppTheme.elementSpacing.w),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // 2 items per row
                crossAxisSpacing: AppTheme.elementSpacing.w,
                mainAxisSpacing: AppTheme.elementSpacing.h,
                childAspectRatio: (size.width / 2) / 230.w, // Adjust according to your design
              ),
              itemCount: controller.assets.length,
              itemBuilder: (context, index) {
                final asset = controller.assets[index];
                final meta = controller.assetMetaMap[asset.assetGenesis!.assetId ?? ''];
                return Container(
                  constraints: BoxConstraints(
                    minHeight: 230.w, // Set minimum height to match childAspectRatio
                  ),
                  child: NftProductSlider(
                    scale: 0.75,
                    medias: meta?.toMedias() ?? [],
                    nftName: meta?.data ?? 'metahash',
                    nftMainName: asset.assetGenesis!.name ?? 'assetID',
                    cryptoText: asset.lockTime != null ? asset.lockTime.toString() : 'price',
                  ),
                );
              },
            );
          },
        );}),
      ),
    );
  }
}
