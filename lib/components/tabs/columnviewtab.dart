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
  final ScrollController _scrollController = ScrollController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    controller.fetchTaprootAssets();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      _loadMoreData();
    }
  }

  Future<void> _loadMoreData() async {
    if (!_isLoading) {
      setState(() {
        _isLoading = true;
      });

      // Simulated data loading delay (replace with your actual data loading logic)
      await Future.delayed(Duration(seconds: 2));

      // Simulated adding more data (replace with your actual data loading logic)
      //await controller.fetchMoreAssets();

      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: _scrollController,
      child: Obx(
            () {
          return controller.isLoading.value
              ? Center(child: dotProgress(context))
              : !controller.isLoading.value && controller.assets.isEmpty
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
                itemCount: controller.assets.length + (_isLoading ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index < controller.assets.length) {
                    final asset = controller.assets[index];
                    final assetId = asset.assetGenesis?.assetId ?? '';
                    final meta = controller.assetMetaMap[assetId];
                    return GestureDetector(
                      onTap: () {
                        context.pushNamed(kNftProductScreenRoute, pathParameters: {'nft_id': assetId});
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
      ),
    );
  }
}
