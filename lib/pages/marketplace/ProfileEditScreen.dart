import 'package:bitnet/backbone/helper/marketplace_helpers/imageassets.dart';
import 'package:bitnet/components/marketplace_widgets/CommonBtn.dart';
import 'package:bitnet/components/marketplace_widgets/CommonInput.dart';
import 'package:bitnet/components/marketplace_widgets/Header.dart';
import 'package:bitnet/components/marketplace_widgets/StatusBarBg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileEditScreen extends StatefulWidget {
  const ProfileEditScreen({Key? key}) : super(key: key);

  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                      'Profile',
                      style: TextStyle(
                        fontSize: 28.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const CommonInput(
                    placeholder: 'Name',
                    keyboardType: TextInputType.text,
                  ),
                  const CommonInput(
                    placeholder: 'User Name',
                    keyboardType: TextInputType.text,
                  ),
                  const CommonInput(
                    placeholder: 'Mobile Number',
                    keyboardType: TextInputType.phone,
                  ),
                  const CommonInput(
                    placeholder: 'Email Address',
                    keyboardType: TextInputType.emailAddress,
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 12.h),
                    child: const CommonBtn(
                      hasOnPress: false,
                      text: 'Save',
                    )
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
