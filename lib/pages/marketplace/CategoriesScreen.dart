import 'package:bitnet/backbone/helper/marketplace_helpers/imageassets.dart';
import 'package:bitnet/backbone/helper/marketplace_helpers/sampledata.dart';
import 'package:bitnet/components/marketplace_widgets/CategoriesList.dart';
import 'package:bitnet/components/marketplace_widgets/Header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bitnet/pages/routetrees/marketplaceroutes.dart' as route;
import 'package:flutter_gen/gen_l10n/l10n.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
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
              padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 20.h),
                    child: Header(
                      leftIconWidth: 50.w,
                      leftIcon: GestureDetector(
                        onTap: () {
                          Navigator.pushReplacementNamed(
                              context, route.kMainScreenRoute);
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
                    margin: EdgeInsets.only(bottom: 5.h),
                    child: Text(
                      L10n.of(context)!.categories,
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
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur volutpat hendrerit turpis sed maximus.',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: const Color.fromRGBO(255, 255, 255, 0.7),
                      ),
                    ),
                  ),
                  ListView.builder(
                    padding: const EdgeInsets.all(0.0),
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemCount: categoriesListData.length,
                    itemBuilder: (context, index) {
                      return CategoriesList(
                        categoriesText:
                            categoriesListData[index].categoriesText,
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
