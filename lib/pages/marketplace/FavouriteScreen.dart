import 'package:bitnet/backbone/helper/marketplace_helpers/imageassets.dart';
import 'package:bitnet/backbone/helper/marketplace_helpers/sampledata.dart';
import 'package:bitnet/components/marketplace_widgets/FavouriteList.dart';
import 'package:bitnet/components/marketplace_widgets/Header.dart';
import 'package:bitnet/components/marketplace_widgets/StatusBarBg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({Key? key}) : super(key: key);

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
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
            padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 20.h),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 20.h),
                    child: Header(
                      leftIconWidth: 50.w,
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
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 15.h),
                    width: size.width,
                    child: Text(
                      'Favourite',
                      style: TextStyle(
                        fontSize: 28.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 30.h),
                    child: Text(
                      'Press the Favorites button again to unfavorite',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: const Color.fromRGBO(255, 255, 255, 0.7),
                      ),
                    ),
                  ),
                  GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 4 / 5.9,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      crossAxisCount: 2,
                    ),
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    itemCount: favouriteListData.length,
                    itemBuilder: (BuildContext context, int index) {
                      return FavouriteList(
                        nftImage: favouriteListData[index].nftImage,
                        cryptoImage: favouriteListData[index].cryptoImage,
                        nftName: favouriteListData[index].nftName,
                        nftMainName: favouriteListData[index].nftMainName,
                        cryptoText: favouriteListData[index].cryptoText,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          // const StatusBarBg()
        ],
      ),
    );
  }
}
