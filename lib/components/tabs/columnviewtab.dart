import 'package:bitnet/backbone/cloudfunctions/taprootassets/fetchassetmeta.dart';
import 'package:bitnet/backbone/cloudfunctions/taprootassets/list_assets.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/loaders/loaders.dart';
import 'package:bitnet/models/postmodels/media_model.dart';
import 'package:bitnet/models/postmodels/post.dart';
import 'package:bitnet/models/tapd/asset.dart';
import 'package:bitnet/models/tapd/assetmeta.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bitnet/backbone/services/base_controller/dio/dio_service.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'dart:convert';
import 'dart:io';

class ColumnViewTab extends StatefulWidget {
  const ColumnViewTab({super.key});

  @override
  State<ColumnViewTab> createState() => _ColumnViewTabState();
}

class _ColumnViewTabState extends State<ColumnViewTab> {
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

      //meta zu hallfinney quote fehlt iwie

      for (int i = 0; i < reversedAssets.length && i < 5; i++) {
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
    return SingleChildScrollView(
      child: Column(
        children: [
          if (isLoading)
            Center(child: dotProgress(context))
          else if (!isLoading && assets.isEmpty)
            Padding(
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
          else
            Column(
              children: assets.map((asset) {
                String assetId = asset.assetGenesis!.assetId ?? '';
                AssetMetaResponse? meta = assetMetaMap[assetId];
                return Post(
                  postId: assetId,
                  ownerId: "Tobias Welti" ?? '',
                  username: "username" ?? '',
                  postName: asset.assetGenesis!.name ?? '',
                  rockets: {},
                  medias: meta != null ? meta.toMedias() : [],
                  // medias: [
                  //   if (meta != null) Media(type: 'text', data: meta.getShortenedData()),
                  //   if (meta != null) Media(type: 'text', data: "Type: ${meta.getType()}",),
                  //   Media(type: 'text', data: asset.assetGenesis.metaHash),
                  //   Media(type: 'text', data: asset.version),
                  //   Media(type: 'text', data: asset.chainAnchor.blockHeight.toString()),
                  //   Media(type: 'text', data: asset.assetGenesis.version.toString()),
                  // ],
                  timestamp: DateTime.fromMillisecondsSinceEpoch(asset.lockTime! * 1000),
                );
              }).toList(),
            )
        ],
      ),
    );
  }
}