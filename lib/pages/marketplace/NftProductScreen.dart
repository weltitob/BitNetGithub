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
import 'package:bitnet/components/container/imagewithtext.dart';
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
import 'package:flutter_gen/gen_l10n/l10n.dart';
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
        text: "NFT Product",
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

                        // Enhanced header with better styling
                        SizedBox(
                          child: Column(
                            children: [
                              _buildEnhancedHeader(),
                              _buildEnhancedAssetDisplay(),

                              // Enhanced asset display with animations
                              //SizedBox(height: AppTheme.cardPadding.h),
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

                        GlassContainer(
                          margin: EdgeInsets.all(8),
                          customColor: primaryColor.withAlpha(150),
                          borderRadius: BorderRadius.circular(8),
                          child: Container(
                            padding: EdgeInsets.all(8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 30,
                                        child: Text(
                                          L10n.of(context)!.currentPrice,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(
                                                fontSize: 18.sp,
                                                fontWeight: FontWeight.w500,
                                              ),
                                        ),
                                      ),
                                      Spacer(),
                                      SizedBox(
                                        height: 30,
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              ethereumIcon,
                                              height: 16.h,
                                              fit: BoxFit.contain,
                                            ),
                                            Container(
                                              margin:
                                                  EdgeInsets.only(left: 8.w),
                                              child: Text(
                                                '12.5',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium!
                                                    .copyWith(
                                                      fontSize: 14.sp,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                              ),
                                            ),
                                            Text(
                                              ' (\$1717.17)',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium!
                                                  .copyWith(
                                                    fontSize: 14.sp,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 0),
                          margin: EdgeInsets.only(bottom: 30.h),
                          child: Column(
                            children: [
                              // Container(
                              //   width: size.width,
                              //   margin: EdgeInsets.only(bottom: 15.h),
                              //   child: Text(
                              //     'NFToker #2293',
                              //     style: Theme.of(context)
                              //         .textTheme
                              //         .bodyMedium!
                              //         .copyWith(
                              //           fontSize: 28.sp,
                              //           fontWeight: FontWeight.w700,
                              //         ),
                              //   ),
                              // ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  OwnerDataTextExtra(
                                    hasText: true,
                                    ownerDataText: '1',
                                    ownerDataTitle: L10n.of(context)!.owners,
                                    ownerDataImg: '',
                                  ),
                                  OwnerDataTextExtra(
                                    hasText: true,
                                    ownerDataText: '1',
                                    ownerDataTitle:
                                        L10n.of(context)!.itemsTotal,
                                    ownerDataImg: '',
                                  ),
                                  OwnerDataTextExtra(
                                    hasText: true,
                                    ownerDataText: '1',
                                    ownerDataTitle: L10n.of(context)!.views,
                                    ownerDataImg: '',
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        SizedBox(
                          height: AppTheme.cardPadding * 2,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(bottom: 15.h),
                                child: Text(
                                  L10n.of(context)!.createdBy,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(bottom: 30.h),
                                child: Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(12.r),
                                      child: Image.asset(
                                        user1Image,
                                        width: 120.w,
                                        height: 120.w,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        height: 120.w,
                                        margin: EdgeInsets.only(left: 8.w),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(top: 5.w),
                                              child: Text(
                                                L10n.of(context)!.cryptoPills,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleMedium!
                                                    .copyWith(
                                                      fontSize: 16.sp,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                              ),
                                            ),
                                            Text(
                                              'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium!
                                                  .copyWith(
                                                    fontSize: 12.sp,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                            ),
                                            SizedBox(
                                              height: 2.w,
                                            )
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
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: CommonHeading(
                            headingText: L10n.of(context)!.priceHistory,
                            hasButton: false,
                            collapseBtn: true,
                            child: const BarChart(),
                          ),
                        ),
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
                        CommonHeading(
                          headingText: L10n.of(context)!.chainInfo,
                          hasButton: false,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          margin: EdgeInsets.only(bottom: 15.h),
                          child: Column(
                            children: [
                              ChainInfo(
                                chainHeading: L10n.of(context)!.contractAddress,
                                chainPeragraph:
                                    '0x495f947276749ce646f68ac8c24842004512345478',
                                hasBtn: true,
                              ),
                              ChainInfo(
                                chainHeading: L10n.of(context)!.tokenId,
                                chainPeragraph:
                                    '8425989087892580822781084918495798454',
                                hasBtn: true,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 4.0),
                                child: ChainInfoHorizontal(
                                  headingStyle: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                          fontSize: 14.sp,
                                          color: AppTheme.colorBitcoin),
                                  chainHeading: L10n.of(context)!
                                      .blockChain
                                      .toUpperCase(),
                                  chainPeragraph: L10n.of(context)!.ethereum,
                                ),
                              ),
                            ],
                          ),
                        ),
                        CommonHeading(
                          headingText: L10n.of(context)!.openOnEtherscan,
                          hasButton: false,
                        ),
                      ],
                    ),
                  ),
                ),
                BottomButtons(
                  leftButtonTitle: L10n.of(context)!.buy,
                  rightButtonTitle: L10n.of(context)!.sell,
                  onLeftButtonTap: () {
                    _buildBuySlidingPanel();
                  },
                  onRightButtonTap: () {
                    context.go('/sell');
                  },
                ),
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
                      borderThickness: 1.5,
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
