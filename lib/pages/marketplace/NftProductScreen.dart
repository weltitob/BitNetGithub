import 'dart:convert';

import 'package:bitnet/backbone/cloudfunctions/taprootassets/fetchassetmeta.dart';
import 'package:bitnet/backbone/cloudfunctions/taprootassets/universeservice/queryassetstats.dart';
import 'package:bitnet/backbone/helper/helpers.dart';
import 'package:bitnet/backbone/helper/marketplace_helpers/imageassets.dart';
import 'package:bitnet/backbone/helper/marketplace_helpers/sampledata.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetListTile.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/buttons/bottom_buybuttons.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/container/avatar.dart';
import 'package:bitnet/components/appstandards/glasscontainer.dart';
import 'package:bitnet/components/dialogsandsheets/bottom_sheets/bit_net_bottom_sheet.dart';
import 'package:bitnet/components/loaders/loaders.dart';
import 'package:bitnet/components/marketplace_widgets/BarChart.dart';
import 'package:bitnet/components/marketplace_widgets/ChaunInfo.dart';
import 'package:bitnet/components/marketplace_widgets/CommonHeading.dart';
import 'package:bitnet/components/marketplace_widgets/NftProductHorizontal.dart';
import 'package:bitnet/components/marketplace_widgets/OwnerDataText.dart';
import 'package:bitnet/components/post/components/applemusicbuilder.dart';
import 'package:bitnet/components/post/components/attributesbuilder.dart';
import 'package:bitnet/components/post/components/audiobuilder.dart';
import 'package:bitnet/components/post/components/collectionbuilder.dart';
import 'package:bitnet/components/post/components/deezerbuilder.dart';
import 'package:bitnet/components/post/components/description_editor.dart';
import 'package:bitnet/components/post/components/descriptionbuilder.dart';
import 'package:bitnet/components/post/components/imagebuilder.dart';
import 'package:bitnet/components/post/components/linkbuilder.dart';
import 'package:bitnet/components/post/components/spotifybuilder.dart';
import 'package:bitnet/components/post/components/textbuilder.dart';
import 'package:bitnet/components/post/components/youtubemusicbuilder.dart';
import 'package:bitnet/components/post/post_header.dart';
import 'package:bitnet/models/postmodels/media_model.dart';
import 'package:bitnet/models/postmodels/post_component.dart';
import 'package:bitnet/models/tapd/assetmeta.dart';
import 'package:bitnet/pages/profile/profile_controller.dart';
import 'package:bitnet/pages/secondpages/mempool/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:bitnet/intl/generated/l10n.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../models/tapd/asset.dart';

class NftProductScreen extends StatefulWidget {
  final GoRouterState? routerState;
  const NftProductScreen({Key? key, this.routerState}) : super(key: key);

  @override
  State<NftProductScreen> createState() => _NftProductScreenState();
}

class _NftProductScreenState extends State<NftProductScreen> {
  AssetMetaResponse? meta;
  Asset? assetStats;
  bool loading = true;
  String? nft_id;

  @override
  void initState() {
    super.initState();
    getAssetData();
  }

  void getAssetData() async {
    try {
      nft_id = (widget.routerState?.extra! as Map)['nft_id'];
      print("nft_id: $nft_id");

      if (nft_id != null) {
        try {
          meta = await fetchAssetMeta(nft_id!);
        } catch (e) {
          print("Error fetching asset meta: $e");
        }

        try {
          assetStats = Get.find<ProfileController>()
              .assets
              .where((test) =>
                  test is Asset &&
                  test.assetGenesis != null &&
                  test.assetGenesis!.assetId == nft_id)
              .firstOrNull;
        } catch (e) {
          print("Error fetching asset stats: $e");
        }

        print("assetStats: $assetStats");
        print("meta: $meta");
      } else {
        print("Error: nft_id is null");
      }
    } catch (e) {
      print("General error in getAssetData: $e");
    } finally {
      setState(() {
        loading = false;
      });
    }
  }

  //nftname and timestamp is missing
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return bitnetScaffold(
      extendBodyBehindAppBar: true,
      appBar: bitnetAppBar(
        context: context,
        text: assetStats?.assetGenesis?.name ?? "Asset Details",
        onTap: () => context.pop(),
      ),
      context: context,
      body: loading
          ? Container(
              height: AppTheme.cardPadding * 10,
              child: Center(child: dotProgress(context)),
            )
          : Stack(
              children: [
                Container(
                  width: size.width,
                  height: size.height,
                  child: SingleChildScrollView(
                    padding: EdgeInsets.only(bottom: 20.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: AppTheme.cardPadding.h * 2,
                        ),
                        // Text("assetStats: $assetStats"),
                        // Text("meta: ${meta!.data}"),

                        // Modern asset display section
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: AppTheme.cardPadding.w),
                          child: Column(
                            children: [
                              SizedBox(height: AppTheme.cardPadding.h),
                              _buildEnhancedAssetDisplay(),
                              SizedBox(height: AppTheme.cardPadding.h),
                            ],
                          ),
                        ),

                        // Container(
                        //   padding: EdgeInsets.symmetric(horizontal: 20.w),
                        //   margin: EdgeInsets.only(bottom: 20.h),
                        //   child: ClipRRect(
                        //     borderRadius: BorderRadius.circular(12.r),
                        //     child: Image.asset(
                        //       nftImage1,
                        //       width: size.width,
                        //       height: 335.w,
                        //       fit: BoxFit.cover,
                        //     ),
                        //   ),
                        // ),

                        // Modern asset info header
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: AppTheme.cardPadding.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                assetStats?.assetGenesis?.name ??
                                    "Unknown Asset",
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium
                                    ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              SizedBox(height: AppTheme.elementSpacing.h / 2),
                              Row(
                                children: [
                                  Avatar(
                                    profileId: "creator",
                                    name: "Creator",
                                    size: 20.w,
                                    type: profilePictureType.onchain,
                                    onTap: () {},
                                  ),
                                  SizedBox(
                                      width: AppTheme.elementSpacing.w / 2),
                                  Text(
                                    "Created by @username",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSurface
                                              .withOpacity(0.7),
                                        ),
                                  ),
                                  Text(
                                    " • ",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSurface
                                              .withOpacity(0.5),
                                        ),
                                  ),
                                  Text(
                                    displayTimeAgoFromInt((assetStats != null &&
                                                    assetStats!.chainAnchor !=
                                                        null &&
                                                    assetStats!.chainAnchor!
                                                            .blockHeight !=
                                                        null
                                                ? _convertBlockHeightToDateTime(
                                                    assetStats!.chainAnchor!
                                                        .blockHeight!)
                                                : DateTime.now())
                                            .millisecondsSinceEpoch ~/
                                        1000),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSurface
                                              .withOpacity(0.7),
                                        ),
                                  ),
                                ],
                              ),
                              SizedBox(height: AppTheme.cardPadding.h),
                            ],
                          ),
                        ),

                        // Modern price display
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: AppTheme.cardPadding.w),
                          child: GlassContainer(
                            boxShadow:
                                Theme.of(context).brightness == Brightness.dark
                                    ? []
                                    : null,
                            child: Padding(
                              padding: EdgeInsets.all(AppTheme.cardPadding),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        L10n.of(context)!.currentPrice,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall
                                            ?.copyWith(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onSurface
                                                  .withOpacity(0.7),
                                            ),
                                      ),
                                      SizedBox(height: 4.h),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.baseline,
                                        textBaseline: TextBaseline.alphabetic,
                                        children: [
                                          Icon(
                                            Icons.currency_bitcoin,
                                            color: AppTheme.colorBitcoin,
                                            size: 24.w,
                                          ),
                                          SizedBox(width: 4.w),
                                          Text(
                                            assetStats?.amount != null
                                                ? (int.parse(assetStats!
                                                            .amount!) /
                                                        100000000)
                                                    .toStringAsFixed(8)
                                                : '0.00000000',
                                            style: Theme.of(context)
                                                .textTheme
                                                .headlineSmall
                                                ?.copyWith(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                          ),
                                          SizedBox(width: 4.w),
                                          Text(
                                            'BTC',
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleMedium
                                                ?.copyWith(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .onSurface
                                                      .withOpacity(0.7),
                                                ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 12.w, vertical: 6.h),
                                    decoration: BoxDecoration(
                                      color: AppTheme.successColor
                                          .withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(20.r),
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.trending_up,
                                          color: AppTheme.successColor,
                                          size: 16.w,
                                        ),
                                        SizedBox(width: 4.w),
                                        Text(
                                          '+12.5%',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall
                                              ?.copyWith(
                                                color: AppTheme.successColor,
                                                fontWeight: FontWeight.w600,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: AppTheme.cardPadding.h),

                        // Modern stats section
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: AppTheme.cardPadding.w),
                          child: Row(
                            children: [
                              Expanded(
                                child: GlassContainer(
                                  boxShadow: Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? []
                                      : null,
                                  child: Padding(
                                    padding: EdgeInsets.all(
                                        AppTheme.cardPaddingSmall),
                                    child: Column(
                                      children: [
                                        Icon(
                                          Icons.people_outline,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                          size: 24.w,
                                        ),
                                        SizedBox(
                                            height:
                                                AppTheme.elementSpacing.h / 2),
                                        Text(
                                          '1',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge
                                              ?.copyWith(
                                                fontWeight: FontWeight.bold,
                                              ),
                                        ),
                                        Text(
                                          L10n.of(context)!.owners,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall
                                              ?.copyWith(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onSurface
                                                    .withOpacity(0.7),
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: AppTheme.elementSpacing.w),
                              Expanded(
                                child: GlassContainer(
                                  boxShadow: Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? []
                                      : null,
                                  child: Padding(
                                    padding: EdgeInsets.all(
                                        AppTheme.cardPaddingSmall),
                                    child: Column(
                                      children: [
                                        Icon(
                                          Icons.inventory_2_outlined,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                          size: 24.w,
                                        ),
                                        SizedBox(
                                            height:
                                                AppTheme.elementSpacing.h / 2),
                                        Text(
                                          assetStats?.amount ?? '1',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge
                                              ?.copyWith(
                                                fontWeight: FontWeight.bold,
                                              ),
                                        ),
                                        Text(
                                          L10n.of(context)!.itemsTotal,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall
                                              ?.copyWith(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onSurface
                                                    .withOpacity(0.7),
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: AppTheme.elementSpacing.w),
                              Expanded(
                                child: GlassContainer(
                                  boxShadow: Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? []
                                      : null,
                                  child: Padding(
                                    padding: EdgeInsets.all(
                                        AppTheme.cardPaddingSmall),
                                    child: Column(
                                      children: [
                                        Icon(
                                          Icons.schedule,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                          size: 24.w,
                                        ),
                                        SizedBox(
                                            height:
                                                AppTheme.elementSpacing.h / 2),
                                        Text(
                                          '${DateTime.now().difference(assetStats != null && assetStats!.chainAnchor != null && assetStats!.chainAnchor!.blockHeight != null ? _convertBlockHeightToDateTime(assetStats!.chainAnchor!.blockHeight!) : DateTime.now()).inDays}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge
                                              ?.copyWith(
                                                fontWeight: FontWeight.bold,
                                              ),
                                        ),
                                        Text(
                                          'Days Old',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall
                                              ?.copyWith(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onSurface
                                                    .withOpacity(0.7),
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Description section if available
                        Builder(
                          builder: (context) {
                            String? description;
                            if (meta != null) {
                              try {
                                String decodedData = meta!.decodeData();
                                Map<String, dynamic> jsonMap =
                                    jsonDecode(decodedData);
                                description =
                                    jsonMap['description']?.toString();
                              } catch (e) {
                                // If not JSON or no description field, use raw decoded data
                                description = null;
                              }
                            }

                            if (description != null && description.isNotEmpty) {
                              return Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: AppTheme.cardPadding.w),
                                margin: EdgeInsets.only(
                                    top: AppTheme.cardPadding.h),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Description',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(
                                            fontWeight: FontWeight.w600,
                                          ),
                                    ),
                                    SizedBox(height: AppTheme.elementSpacing.h),
                                    Text(
                                      description,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onSurface
                                                .withOpacity(0.8),
                                            height: 1.5,
                                          ),
                                    ),
                                  ],
                                ),
                              );
                            }
                            return SizedBox.shrink();
                          },
                        ),

                        SizedBox(height: AppTheme.cardPadding.h),
                        // Price History section - removed for now as it shows placeholder data
                        // Container(
                        //   padding: EdgeInsets.symmetric(horizontal: 20.w),
                        //   child: CommonHeading(
                        //     headingText: 'Properties',
                        //     hasButton: false,
                        //     collapseBtn: true,
                        //     child: Container(
                        //       margin: EdgeInsets.only(bottom: 30.w),
                        //       child: GridView.builder(
                        //         gridDelegate:
                        //             const SliverGridDelegateWithFixedCrossAxisCount(
                        //           childAspectRatio: 1.7, //9.1 / 4.5,
                        //           crossAxisSpacing: 15,
                        //           mainAxisSpacing: 15,
                        //           crossAxisCount: 2,
                        //         ),
                        //         physics: const NeverScrollableScrollPhysics(),
                        //         shrinkWrap: true,
                        //         padding: EdgeInsets.zero,
                        //         itemCount: propertieList.length,
                        //         itemBuilder: (BuildContext context, int index) {
                        //           return PropertieList(
                        //             heading: propertieList[index].heading,
                        //             subHeading: propertieList[index].subHeading,
                        //             peragraph: propertieList[index].peragraph,
                        //           );
                        //         },
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        // Chain information
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: AppTheme.cardPadding.w),
                          margin: EdgeInsets.only(
                              top: AppTheme.cardPadding.h, bottom: 100.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Chain Information',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                              SizedBox(height: AppTheme.elementSpacing.h),
                              GlassContainer(
                                boxShadow: Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? []
                                    : null,
                                child: Padding(
                                  padding:
                                      EdgeInsets.all(AppTheme.cardPaddingSmall),
                                  child: Column(
                                    children: [
                                      _buildInfoRow(context, 'Asset ID',
                                          nft_id ?? 'Unknown'),
                                      if (assetStats?.assetGenesis?.assetType !=
                                          null)
                                        _buildInfoRow(
                                            context,
                                            'Asset Type',
                                            assetStats!
                                                .assetGenesis!.assetType!),
                                      if (assetStats
                                              ?.chainAnchor?.blockHeight !=
                                          null)
                                        _buildInfoRow(
                                            context,
                                            'Block Height',
                                            assetStats!
                                                .chainAnchor!.blockHeight!
                                                .toString()),
                                      if (assetStats?.chainAnchor?.anchorTx !=
                                          null)
                                        _buildInfoRow(context, 'Anchor TX',
                                            '${assetStats!.chainAnchor!.anchorTx!.substring(0, 8)}...${assetStats!.chainAnchor!.anchorTx!.substring(assetStats!.chainAnchor!.anchorTx!.length - 8)}'),
                                      _buildInfoRow(context, 'Blockchain',
                                          'Bitcoin (Taproot Assets)'),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Modern bottom action buttons
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.all(AppTheme.cardPadding),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: Offset(0, -2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: LongButtonWidget(
                            title: 'Make Offer',
                            buttonType: ButtonType.transparent,
                            onTap: () => _buildBuySlidingPanel(),
                            customHeight: 50.h,
                          ),
                        ),
                        SizedBox(width: AppTheme.elementSpacing.w),
                        Expanded(
                          child: LongButtonWidget(
                            title: L10n.of(context)!.buyNow,
                            buttonType: ButtonType.solid,
                            onTap: () => _buildBuySlidingPanel(),
                            customHeight: 50.h,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                //const StatusBarBg(),
              ],
            ),
    );
  }

  final DateTime genesisBlockTime = DateTime.utc(2009, 1, 3, 18, 15, 05);

  // Helper method to convert lockTime to DateTime based on Bitcoin block height
  DateTime _convertBlockHeightToDateTime(int blockHeight) {
    // Bitcoin has a target of 1 block every 10 minutes (600 seconds)
    // Calculate approximate time since genesis block
    final int secondsSinceGenesis = blockHeight * 600; // 10 minutes per block

    // Add this duration to the genesis block time
    return genesisBlockTime.add(Duration(seconds: secondsSinceGenesis));
  }

  void _buildBuySlidingPanel() {
    BitNetBottomSheet(
      context: context,
      height: MediaQuery.of(context).size.height * 0.75,
      child: bitnetScaffold(
        extendBodyBehindAppBar: true,
        context: context,
        appBar: bitnetAppBar(
          hasBackButton: false,
          context: context,
          text: "Purchase NFT",
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppTheme.cardPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: AppTheme.cardPadding * 2),
                    // Asset display in a GlassContainer
                    GlassContainer(
                      border: Border.all(
                          width: 1.5, color: Theme.of(context).dividerColor),
                      child: Padding(
                        padding: const EdgeInsets.all(AppTheme.elementSpacing),
                        child: _buildHorizontalProductWithId(),
                      ),
                    ),
                    SizedBox(height: AppTheme.cardPadding * 1.5),

                    // Cost details using BitNetListTile
                    BitNetListTile(
                      text: "Subtotal",
                      trailing: Text(
                        "0.024 BTC",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                    BitNetListTile(
                      text: "Network Fee",
                      trailing: Text(
                        "0.001 BTC",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                    BitNetListTile(
                      text: "Market Fee",
                      trailing: Text(
                        "0.002 BTC",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                    Divider(
                      color: Theme.of(context)
                          .colorScheme
                          .primary
                          .withOpacity(0.2),
                      thickness: 1,
                    ),
                    BitNetListTile(
                      text: "Total Price",
                      trailing: Text(
                        "0.027 BTC",
                        style:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                    ),

                    // Extra space at bottom for the button
                    SizedBox(height: AppTheme.cardPadding * 6),
                  ],
                ),
              ),
            ),

            // Bottom centered button
            BottomCenterButton(
              buttonState: ButtonState.idle,
              buttonTitle: "Buy Now",
              onButtonTap: () {
                // Handle purchase
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHorizontalProductWithId() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: NftProductHorizontal(
        cryptoImage: gridListData[0].cryptoImage,
        nftImage: gridListData[0].nftImage,
        nftMainName: gridListData[0].nftMainName,
        nftName: gridListData[0].nftName,
        cryptoText: gridListData[0].cryptoText,
        rank: gridListData[0].rank,
        columnMargin: gridListData[0].columnMargin,
      ),
    );
  }

  List<Widget> _buildMediaWidgets(List<dynamic> medias) {
    if (medias.isEmpty) return [];

    return medias.map((media) {
      // In view mode, handle Media objects
      if (media is Media) {
        return _buildViewableMedia(media);
      }

      // Fallback if we somehow get the wrong type
      return Container(margin: const EdgeInsets.only(bottom: 10.0));
    }).toList();
  }

  // Builds editable media widgets for creating/editing posts

  // Builds non-editable media widgets for viewing posts
  Widget _buildViewableMedia(Media media) {
    final type = media.type;
    Widget mediaWidget;

    if (type == "text") {
      mediaWidget = TextBuilderNetwork(url: media.data);
    } else if (type == "collection") {
      mediaWidget = CollectionBuilder(data: media.data);
    } else if (type == "description") {
      mediaWidget = DescriptionBuilder(description: media.data);
    } else if (type == "attributes") {
      mediaWidget = AttributesBuilder(attributes: media.data);
    } else if (type == "spotify_url") {
      mediaWidget = SpotifyBuilder(spotifyUrl: media.data);
    } else if (type == "youtubemusic_url") {
      mediaWidget = YoutubeMusicBuilder(youtubeUrl: media.data);
    } else if (type == "deezer_url") {
      mediaWidget = DeezerBuilder(deezerUrl: media.data);
    } else if (type == "applemusic_url") {
      mediaWidget = AppleMusicBuilder(applemusicUrl: media.data);
    } else if (type == "external_link") {
      mediaWidget = LinkBuilder(url: media.data);
    } else if (type == "image" || type == "camera" || type == "image_data") {
      mediaWidget = ImageBuilder(
        radius: AppTheme.cardRadiusSmall.r,
        encodedData: media.data,
        caption: "", // Pass the post name as the caption
      );
    } else if (type == "audio") {
      mediaWidget = AudioBuilderNetwork(url: media.data);
    } else {
      mediaWidget = TextBuilderNetwork(url: media.data); // Default fallback
    }

    return Container(
        margin: const EdgeInsets.only(bottom: 0), child: mediaWidget);
  }

  Widget _buildInfoRow(BuildContext context, String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: AppTheme.elementSpacing.h / 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                ),
          ),
          Flexible(
            child: Text(
              value,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
              textAlign: TextAlign.end,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  // 1. Better header with asset name and details
  Widget _buildEnhancedHeader() {
    return Padding(
      padding: EdgeInsets.all(AppTheme.cardPadding / 2),
      child: Row(
        children: [
          // Asset creator avatar with proper styling
          Avatar(
            profileId: "",
            size: AppTheme.cardPadding * 2.5.h,
            onTap: () {},
          ),
          SizedBox(width: AppTheme.elementSpacing.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  assetStats?.assetGenesis?.name ?? "Unknown Asset",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                // Improved timestamp display
                Text(
                  "Created " +
                      displayTimeAgoFromInt(
                          (assetStats != null &&
                                      assetStats!.chainAnchor != null &&
                                      assetStats!.chainAnchor!.blockHeight !=
                                          null
                                  ? _convertBlockHeightToDateTime(
                                      assetStats!.chainAnchor!.blockHeight!)
                                  : DateTime.fromMillisecondsSinceEpoch(
                                      10 * 1000))
                              .millisecondsSinceEpoch,
                          language: 'en'),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 2. Improved asset display with animations
  Widget _buildEnhancedAssetDisplay() {
    return Hero(
      tag: 'asset-${nft_id}',
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppTheme.borderRadiusBig.r),
        child: RepaintBoundary(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _buildMediaWidgets(meta?.toMedias() ?? []),
          ),
        ),
      ),
    );
  }

  // 3. Improved stats display
  Widget _buildAssetStatsSection() {
    return Row(
      children: [
        Expanded(
          child: GlassContainer(
            child: Column(
              children: [
                Icon(Icons.people),
                Text("1", style: Theme.of(context).textTheme.titleMedium),
                Text(L10n.of(context)!.owners,
                    style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
          ),
        ),
        SizedBox(width: AppTheme.elementSpacing.w),
        // Repeat for items and views
      ],
    );
  }

  // 4. Improved price section
  Widget _buildPriceSection() {
    return GlassContainer(
      child: Padding(
        padding: EdgeInsets.all(AppTheme.cardPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              L10n.of(context)!.currentPrice,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            SizedBox(height: AppTheme.elementSpacing.h / 2),
            Row(
              children: [
                Icon(Icons.currency_bitcoin,
                    color: Theme.of(context).colorScheme.primary),
                SizedBox(width: AppTheme.elementSpacing.w / 2),
                Text(
                  "12.5 BTC",
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
            Text(
              "(\$1,717.17)",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }

  // 5. Improved buy/sell buttons
  Widget _buildActionButtons() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppTheme.cardPadding),
      child: Row(
        children: [
          Expanded(
            child: LongButtonWidget(
              buttonType: ButtonType.solid,
              customHeight: 50.h,
              title: L10n.of(context)!.buy,
              onTap: () => _buildBuySlidingPanel(),
            ),
          ),
          SizedBox(width: AppTheme.elementSpacing.w),
          Expanded(
            child: LongButtonWidget(
              buttonType: ButtonType.transparent,
              customHeight: 50.h,
              title: L10n.of(context)!.sell,
              onTap: () => context.go('/sell'),
            ),
          ),
        ],
      ),
    );
  }
}
