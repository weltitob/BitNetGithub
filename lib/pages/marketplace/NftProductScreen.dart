import 'package:bitnet/backbone/helper/marketplace_helpers/imageassets.dart';
import 'package:bitnet/backbone/helper/marketplace_helpers/sampledata.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/marketplace_widgets/BarChart.dart';
import 'package:bitnet/components/marketplace_widgets/ChaunInfo.dart';
import 'package:bitnet/components/marketplace_widgets/CommonHeading.dart';
import 'package:bitnet/components/marketplace_widgets/NftProductHorizontal.dart';
import 'package:bitnet/components/marketplace_widgets/OwnerDataText.dart';
import 'package:bitnet/components/marketplace_widgets/PropertieList.dart';
import 'package:bitnet/components/marketplace_widgets/StatusBarBg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';

class NftProductScreen extends StatefulWidget {
  const NftProductScreen({Key? key}) : super(key: key);

  @override
  State<NftProductScreen> createState() => _NftProductScreenState();
}

class _NftProductScreenState extends State<NftProductScreen> {
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
      body: Stack(
        children: [
          Container(
            width: size.width,
            height: size.height,
            child: SingleChildScrollView(
              padding: EdgeInsets.only(bottom: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                              ownerDataTitle: L10n.of(context)!.itemsTotal,
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
                                margin:
                                    EdgeInsets.only(bottom: 15.h, top: 30.h),
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
                        Container(
                          margin: EdgeInsets.only(bottom: 30.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              LongButtonWidget(
                                  customWidth: 17 * 10,
                                  customHeight: 17 * 3.5,
                                  title: L10n.of(context)!.buyNow,
                                  onTap: _buildBuySlidingPanel),
                              LongButtonWidget(
                                  customWidth: 17 * 10,
                                  customHeight: 17 * 3.5,
                                  buttonType: ButtonType.transparent,
                                  title: L10n.of(context)!.viewOffers,
                                  onTap: () {}),
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
                                        margin: EdgeInsets.only(bottom: 5.w),
                                        child: Text(
                                          L10n.of(context)!.cryptoPills,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w500,
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
                      child: BarChart(),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: CommonHeading(
                      headingText: L10n.of(context)!.properties,
                      hasButton: false,
                      collapseBtn: true,
                      child: Container(
                        margin: EdgeInsets.only(bottom: 30.w),
                        child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 1.7, //9.1 / 4.5,
                            crossAxisSpacing: 15,
                            mainAxisSpacing: 15,
                            crossAxisCount: 2,
                          ),
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          itemCount: propertieList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return PropertieList(
                              heading: propertieList[index].heading,
                              subHeading: propertieList[index].subHeading,
                              peragraph: propertieList[index].peragraph,
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: CommonHeading(
                      headingText: L10n.of(context)!.aboutCryptoPills,
                      hasButton: false,
                      collapseBtn: true,
                      child: Container(
                        margin: EdgeInsets.only(bottom: 30.h),
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(bottom: 15.h),
                              child: Text(
                                L10n.of(context)!.propertiesDescription,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(bottom: 15.h),
                              child: Text(
                                L10n.of(context)!.guardiansStored,
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
                              L10n.of(context)!.guardiansDesigned,
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
                  ),
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
          const StatusBarBg()
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
                    Text(L10n.of(context)!.buy,
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(color: Colors.white)),
                    Divider(
                      color: AppTheme.colorBitcoin,
                      thickness: 2,
                    ),
                    _buildHorizontalProductWithId(),
                    Spacer(),
                    Container(
                      width: AppTheme.cardPadding * 10,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                L10n.of(context)!.subTotal,
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
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                L10n.of(context)!.networkFee,
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
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                L10n.of(context)!.marketFee,
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
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                L10n.of(context)!.totalPrice,
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
                          SizedBox(height: 10),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          LongButtonWidget(
                            title:  L10n.of(context)!.cancel,
                            onTap: () {
                              Navigator.pop(context);
                            },
                            buttonType: ButtonType.transparent,
                            customWidth: 15 * 10,
                            customHeight: 15 * 2.5,
                          ),
                          LongButtonWidget(
                            title:  L10n.of(context)!.buyNow,
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
