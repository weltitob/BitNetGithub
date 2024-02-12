import 'package:bitnet/backbone/helper/marketplace_helpers/imageassets.dart';
import 'package:bitnet/backbone/helper/marketplace_helpers/sampledata.dart';
import 'package:bitnet/components/marketplace_widgets/BarChart.dart';
import 'package:bitnet/components/marketplace_widgets/ChaunInfo.dart';
import 'package:bitnet/components/marketplace_widgets/CommonBtn.dart';
import 'package:bitnet/components/marketplace_widgets/CommonHeading.dart';
import 'package:bitnet/components/marketplace_widgets/Header.dart';
import 'package:bitnet/components/marketplace_widgets/OwnerDataText.dart';
import 'package:bitnet/components/marketplace_widgets/PropertieList.dart';
import 'package:bitnet/components/marketplace_widgets/StatusBarBg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RecentlyListedScreen extends StatefulWidget {
  const RecentlyListedScreen({Key? key}) : super(key: key);

  @override
  State<RecentlyListedScreen> createState() => _RecentlyListedScreenState();
}

class _RecentlyListedScreenState extends State<RecentlyListedScreen> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: size.width,
            height: size.height,
            color: const Color.fromRGBO(24, 31, 39, 1),
            child: SingleChildScrollView(
              padding: EdgeInsets.only(bottom: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    margin: EdgeInsets.only(bottom: 20.h),
                    child: Header(
                      leftIconWidth: 36.w,
                      leftIcon: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Row(
                          children: [
                            Container(
                              width: 36.w,
                              height: 36.w,
                              decoration: BoxDecoration(
                                color: const Color.fromRGBO(255, 255, 255, 0.1),
                                borderRadius: BorderRadius.circular(100.r),
                              ),
                              padding: EdgeInsets.all(10.w),
                              child: Image.asset(
                                backArrowIcon,
                                width: 18.w,
                                height: 15.h,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ],
                        ),
                      ),
                      rightIcon: GestureDetector(
                        onTap: () {},
                        child: Row(
                          children: [
                            Container(
                              width: 36.w,
                              height: 36.w,
                              decoration: BoxDecoration(
                                color: const Color.fromRGBO(255, 255, 255, 0.1),
                                borderRadius: BorderRadius.circular(100.r),
                              ),
                              padding: EdgeInsets.all(10.w),
                              child: Image.asset(
                                shareIcon,
                                width: 18.w,
                                height: 15.h,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
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
                            style: TextStyle(
                              fontSize: 28.sp,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Row(
                          children: const [
                            OwnerDataText(
                              hasText: true,
                              ownerDataText: '1',
                              ownerDataTitle: 'Owners',
                            ),
                            OwnerDataText(
                              hasText: true,
                              ownerDataText: '1',
                              ownerDataTitle: 'Items total',
                            ),
                            OwnerDataText(
                              hasText: true,
                              ownerDataText: '1',
                              ownerDataTitle: 'Views',
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
                          margin: EdgeInsets.only(bottom: 15.h),
                          child: Text(
                            'Created By',
                            style: TextStyle(
                              color: const Color.fromRGBO(249, 249, 249, 1),
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Row(
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(bottom: 5.w),
                                      child: Text(
                                        'Crypto-Pills',
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w400,
                                        color: const Color.fromRGBO(
                                            255, 255, 255, 0.5),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
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
                          margin: EdgeInsets.only(bottom: 15.h),
                          child: Text(
                            'Current Price',
                            style: TextStyle(
                              color: const Color.fromRGBO(249, 249, 249, 1),
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
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400,
                                  color:
                                      const Color.fromRGBO(255, 255, 255, 0.7),
                                ),
                              ),
                            ),
                            Text(
                              ' (\$1717.17)',
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                                color: const Color.fromRGBO(255, 255, 255, 0.5),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    margin: EdgeInsets.only(bottom: 30.h),
                    child: Row(
                      children: [
                        Container(
                          width: size.width / 2 - 28.w,
                          margin: EdgeInsets.only(right: 8.w),
                          child: const CommonBtn(
                            hasMargin: false,
                            text: 'Buy Now',
                            hasOnPress: false
                          ),
                        ),
                        Container(
                          width: size.width / 2 - 28.w,
                          margin: EdgeInsets.only(left: 8.w),
                          child: const CommonBtn(
                            hasMargin: false,
                            text: 'View Offers',
                            hasOnPress: false,
                            hasBgColor: true,
                            bgColor: Color.fromRGBO(255, 255, 255, 0.1),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: const CommonHeading(
                      headingText: 'Price History',
                      hasButton: false,
                      collapseBtn: true,
                      child: BarChart(),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: CommonHeading(
                      headingText: 'Properties',
                      hasButton: false,
                      collapseBtn: true,
                      child: Container(
                        margin: EdgeInsets.only(bottom: 30.w),
                        child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 9.1 / 4.5,
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
                      headingText: 'About Crypto-Pills',
                      hasButton: false,
                      collapseBtn: true,
                      child: Container(
                        margin: EdgeInsets.only(bottom: 30.h),
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(bottom: 15.h),
                              child: Text(
                                'Guardians of the Metaverse are a collection of 10,000 unique 3D hero-like avatars living as NFTs on the blockchain.',
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400,
                                  color: const Color.fromRGBO(255, 255, 255, 0.5),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(bottom: 15.h),
                              child: Text(
                                'Guardians are stored as ERC721 tokens on the Ethereum blockchain. Owners can download their Guardians in .png format, they can also request a high resolution image of them, with 3D models coming soon for everyone.',
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400,
                                  color: const Color.fromRGBO(255, 255, 255, 0.5),
                                ),
                              ),
                            ),
                            Text(
                              'Not only are Guardians dope designed character-collectibles, they also serve as your ticket to a world of exclusive content. From developing new collections to fill our universe, to metaverse avatars, we have bundles of awesome features in the pipeline.',
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                                color: const Color.fromRGBO(255, 255, 255, 0.5),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const CommonHeading(
                    headingText: 'Chain Info',
                    hasButton: false,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    margin: EdgeInsets.only(bottom: 15.h),
                    child: Column(
                      children: const [
                        ChaunInfo(
                          chainHeading: 'Contract address',
                          chainPeragraph:
                              '0x495f947276749ce646f68ac8c24842004512345478',
                          hasBtn: true,
                        ),
                        ChaunInfo(
                          chainHeading: 'Token ID',
                          chainPeragraph:
                              '8425989087892580822781084918495798454',
                          hasBtn: true,
                        ),
                        ChaunInfo(
                          chainHeading: 'Blockchain',
                          chainPeragraph: 'ETHEREUM',
                        ),
                      ],
                    ),
                  ),
                  const CommonHeading(
                    headingText: 'Open On Etherscan',
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
}
