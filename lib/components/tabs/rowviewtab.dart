import 'package:bitnet/backbone/cloudfunctions/taprootassets/fetchassetmeta.dart';
import 'package:bitnet/backbone/cloudfunctions/taprootassets/list_assets.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/loaders/loaders.dart';
import 'package:bitnet/components/marketplace_widgets/NftProductSlider.dart';
import 'package:bitnet/models/tapd/asset.dart';
import 'package:bitnet/models/tapd/assetmeta.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RowViewTab extends StatefulWidget {
  @override
  _RowViewTabState createState() => _RowViewTabState();
}

class _RowViewTabState extends State<RowViewTab>
    with SingleTickerProviderStateMixin {
  bool get wantKeepAlive => true;

  bool isLoading = false;
  List<Asset> assets = [];
  Map<String, AssetMetaResponse> assetMetaMap = {};

  @override
  void initState() {
    fetchTaprootAssets();
    super.initState();
  }

  void fetchTaprootAssets() async {
    setState(() {
      isLoading = true;
    });
    try {
      List<Asset> fetchedAssets = await listTaprootAssets();
      List<Asset> reversedAssets = fetchedAssets.reversed.toList();
      Map<String, AssetMetaResponse> metas = {};

      for (int i = 0; i < reversedAssets.length && i < 20; i++) {
        String assetId = reversedAssets[i].assetGenesis!.assetId ?? '';
        AssetMetaResponse? meta = await fetchAssetMeta(assetId);
        if (meta != null) {
          metas[assetId] = meta;
        }
      }

      setState(() {
        assets = reversedAssets;
        assetMetaMap = metas;
        isLoading = false;
      });
    } catch (e) {
      print('Error: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Container(
        height: size.height,
        child: isLoading
            ? Center(child: dotProgress(context))
            : LayoutBuilder(
          builder: (context, constraints) {
            return GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              padding: EdgeInsets.symmetric(horizontal: AppTheme.elementSpacing.w),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // 2 items per row
                crossAxisSpacing: AppTheme.elementSpacing.w,
                mainAxisSpacing: AppTheme.elementSpacing.h,
                childAspectRatio: (size.width / 2) / 230.w, // Adjust according to your design
              ),
              itemCount: assets.length,
              itemBuilder: (context, index) {
                final asset = assets[index];
                final meta = assetMetaMap[asset.assetGenesis!.assetId ?? ''];
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
        ),
      ),
    );
  }
}
