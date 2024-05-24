import 'package:bitnet/backbone/helper/marketplace_helpers/imageassets.dart';
import 'package:bitnet/components/marketplace_widgets/Header.dart';
import 'package:bitnet/components/marketplace_widgets/LogoutModal.dart';
import 'package:bitnet/components/marketplace_widgets/ProfileList.dart';
import 'package:bitnet/components/marketplace_widgets/StatusBarBg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bitnet/pages/routetrees/marketplaceroutes.dart' as route;

//
// class ProfileScreen extends StatefulWidget {
//   const ProfileScreen({Key? key}) : super(key: key);
//
//   @override
//   State<ProfileScreen> createState() => _ProfileScreenState();
// }
//
// class _ProfileScreenState extends State<ProfileScreen> {
//   bool clickSwitch = false;
//   @override
//   Widget build(BuildContext context) {
//     final Size size = MediaQuery.of(context).size;
//     return Scaffold(
//       body: Stack(
//         children: [
//           Container(
//             width: size.width,
//             height: size.height,
//             color: const Color.fromRGBO(24, 31, 39, 1),
//             child: SingleChildScrollView(
//               padding: EdgeInsets.only(bottom: 20.h, left: 20.w, right: 20.w),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Container(
//                     margin: EdgeInsets.only(bottom: 20.h),
//                     child: Header(
//                       leftIconWidth: 50.w,
//                       leftIcon: GestureDetector(
//                         onTap: () {
//                           Navigator.pushReplacementNamed(context, route.kMainScreenRoute);
//                         },
//                         child: Row(
//                           children: [
//                             Container(
//                               width: 36.w,
//                               height: 36.w,
//                               decoration: BoxDecoration(
//                                 color: const Color.fromRGBO(255, 255, 255, 0.1),
//                                 borderRadius: BorderRadius.circular(100.r),
//                               ),
//                               padding: EdgeInsets.all(10.w),
//                               child: Image.asset(
//                                 backArrowIcon,
//                                 width: 18.w,
//                                 height: 15.h,
//                                 fit: BoxFit.contain,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                   GestureDetector(
//                     onTap: () {
//                       Navigator.pushNamed(
//                           context, route.kProfileEditScreenRoute);
//                     },
//                     child: const ProfileList(
//                       hasIcon: true,
//                       text: 'Profile',
//                       icon: editSquareIcon,
//                     ),
//                   ),
//                   GestureDetector(
//                     onTap: () {
//                       Navigator.pushNamed(context, route.kFavouriteScreenRoute);
//                     },
//                     child: const ProfileList(
//                       hasIcon: true,
//                       text: 'Favourite',
//                       icon: unActiveHeartIcon,
//                     ),
//                   ),
//                   const ProfileList(
//                     hasSwitch: true,
//                     text: 'Notification',
//                     icon: unActiveHeartIcon,
//                   ),
//                   GestureDetector(
//                     onTap: () {
//                       Navigator.pushNamed(context, route.kAboutScreenRoute);
//                     },
//                     child: const ProfileList(
//                       hasIcon: true,
//                       text: 'About',
//                       icon: infoSquareIcon,
//                     ),
//                   ),
//                   GestureDetector(
//                     child: const ProfileList(
//                       hasIcon: true,
//                       text: 'Logout',
//                       icon: logoutIcon,
//                     ),
//                     onTap: () {
//                       showDialog(
//                         context: context,
//                         builder: (BuildContext context) {
//                           return const AlertDialog(
//                             scrollable: true,
//                             backgroundColor: Color.fromRGBO(255, 255, 255, 0),
//                             insetPadding: EdgeInsets.zero,
//                             content: LogoutModal(),
//                           );
//                         },
//                       );
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           const StatusBarBg()
//         ],
//       ),
//     );
//   }
// }
