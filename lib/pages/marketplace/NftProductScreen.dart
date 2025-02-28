import 'package:bitnet/backbone/cloudfunctions/taprootassets/fetchassetmeta.dart';
import 'package:bitnet/backbone/cloudfunctions/taprootassets/universeservice/queryassetstats.dart';
import 'package:bitnet/backbone/helper/marketplace_helpers/imageassets.dart';
import 'package:bitnet/backbone/helper/marketplace_helpers/sampledata.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/buttons/bottom_buybuttons.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/loaders/loaders.dart';
import 'package:bitnet/components/marketplace_widgets/BarChart.dart';
import 'package:bitnet/components/marketplace_widgets/ChaunInfo.dart';
import 'package:bitnet/components/marketplace_widgets/CommonHeading.dart';
import 'package:bitnet/components/marketplace_widgets/NftProductHorizontal.dart';
import 'package:bitnet/components/marketplace_widgets/OwnerDataText.dart';
import 'package:bitnet/models/postmodels/post_component.dart';
import 'package:bitnet/models/tapd/assetmeta.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class NftProductScreen extends StatefulWidget {
  final GoRouterState? routerState;
  const NftProductScreen({Key? key, this.routerState}) : super(key: key);

  @override
  State<NftProductScreen> createState() => _NftProductScreenState();
}

class _NftProductScreenState extends State<NftProductScreen> {
  late AssetMetaResponse? meta;
  late dynamic assetStats;
  bool loading = true;
  late String? nft_id;

  @override initState(){
    super.initState();

    getAssetData();
  }

  getAssetData() async {
    nft_id = await widget.routerState?.pathParameters['nft_id'];
    print("nft_id: $nft_id");
    meta = await fetchAssetMeta(nft_id!);
    assetStats = await queryAssetStats(nft_id!);
    print("assetStats: $assetStats");
    print("meta: $meta");

    setState(() {
      loading = false;
    });
  }

  //nftname and timestamp is missing
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return bitnetScaffold(
      extendBodyBehindAppBar: true,
      appBar: bitnetAppBar(
        context: context,
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
                        SizedBox(height: AppTheme.cardPadding.h * 2,),
                        // Text("assetStats: $assetStats"),
                        // Text("meta: ${meta!.data}"),

                        PostComponent(
                          postId: nft_id!,
                          ownerId: "Tobias Welti" ?? '',
                          username: "username" ?? '',
                          postName:' assetStats.assetGenesis.name ?? ''',
                          rockets: {},
                          medias: meta!.toMedias(),
                          timestamp: DateTime.fromMillisecondsSinceEpoch(
                              10 * 1000),
                          displayname: "Tobias Welti" ?? '',
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          margin: EdgeInsets.only(bottom: 20.h),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12.r),
                            child: Image.asset(
                              nftImage1,
                              width: size.width,
                              height: 335.w,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          margin: EdgeInsets.only(bottom: 30.h),
                          child: Column(
                            children: [
                              Container(
                                width: size.width,
                                margin: EdgeInsets.only(bottom: 15.h),
                                child: Text(
                                  'NFToker #2293',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                        fontSize: 28.sp,
                                        fontWeight: FontWeight.w700,
                                      ),
                                ),
                              ),
                              Row(
                                children: [
                                  OwnerDataText(
                                    hasText: true,
                                    ownerDataText: '1',
                                    ownerDataTitle: L10n.of(context)!.owners,
                                  ),
                                  OwnerDataText(
                                    hasText: true,
                                    ownerDataText: '1',
                                    ownerDataTitle:
                                        L10n.of(context)!.itemsTotal,
                                  ),
                                  OwnerDataText(
                                    hasText: true,
                                    ownerDataText: '1',
                                    ownerDataTitle: L10n.of(context)!.views,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          margin: EdgeInsets.only(bottom: 30.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(bottom: 30.h),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(
                                          bottom: 15.h, top: 30.h),
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
                                    Row(
                                      children: [
                                        Image.asset(
                                          ethereumIcon,
                                          height: 13.h,
                                          fit: BoxFit.contain,
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(left: 8.w),
                                          child: Text(
                                            '12.5',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .copyWith(
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                          ),
                                        ),
                                        Text(
                                          ' (\$1717.17)',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w400,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
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
                                        width: 60.w,
                                        height: 60.w,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        margin: EdgeInsets.only(left: 8.w),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              margin:
                                                  EdgeInsets.only(bottom: 5.w),
                                              child: Text(
                                                L10n.of(context)!.cryptoPills,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium!
                                                    .copyWith(
                                                      fontSize: 14.sp,
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
                              ChaunInfo(
                                chainHeading: L10n.of(context)!.contractAddress,
                                chainPeragraph:
                                    '0x495f947276749ce646f68ac8c24842004512345478',
                                hasBtn: true,
                              ),
                              ChaunInfo(
                                chainHeading: L10n.of(context)!.tokenId,
                                chainPeragraph:
                                    '8425989087892580822781084918495798454',
                                hasBtn: true,
                              ),
                              ChaunInfo(
                                chainHeading:
                                    L10n.of(context)!.blockChain.toUpperCase(),
                                chainPeragraph: L10n.of(context)!.ethereum,
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

  _buildBuySlidingPanel() {
    showGeneralDialog(
        barrierDismissible: true,
        barrierLabel: "buy_dialog",
        context: context,
        pageBuilder: (context, a1, a2) {
          return AlertDialog(
            insetPadding: EdgeInsets.zero,
            backgroundColor: Colors.transparent,
            content: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: AppTheme.colorBackground,
                  border: Border.all(color: AppTheme.colorBitcoin, width: 2)),
              height: 600,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Buy",
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(color: Colors.white)),
                    const Divider(
                      color: AppTheme.colorBitcoin,
                      thickness: 2,
                    ),
                    _buildHorizontalProductWithId(),
                    const Spacer(),
                    Container(
                      width: AppTheme.cardPadding * 10,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Subtotal",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(color: Colors.white),
                              ),
                              Text(
                                "0.024",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(color: Colors.white),
                              )
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Network Fee",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(color: Colors.white),
                              ),
                              Text(
                                "0.024",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(color: Colors.white),
                              )
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Market Fee",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(color: Colors.white),
                              ),
                              Text(
                                "0.024",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(color: Colors.white),
                              )
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Total Price",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(color: Colors.white),
                              ),
                              Text(
                                "0.024",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(color: Colors.white),
                              )
                            ],
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          LongButtonWidget(
                            title: "Cancel",
                            onTap: () {
                              Navigator.pop(context);
                            },
                            buttonType: ButtonType.transparent,
                            customWidth: 15 * 10,
                            customHeight: 15 * 2.5,
                          ),
                          LongButtonWidget(
                            title: "Buy Now",
                            onTap: () {},
                            customWidth: 15 * 10,
                            customHeight: 15 * 2.5,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  _buildHorizontalProductWithId() {
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
}
