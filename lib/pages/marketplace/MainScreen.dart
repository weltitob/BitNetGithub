// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// class MainScreen extends StatefulWidget {
//   const MainScreen({Key? key}) : super(key: key);
//
//   @override
//   _MainScreenState createState() => _MainScreenState();
// }
//
// class _MainScreenState extends State<MainScreen> {
//   int _selectedIndex = 0;
//
//   final List<Widget> _widgetOptions = <Widget>[
//     const HomeScreen(),
//     const CategoriesScreen(),
//     const SearchScreen(),
//     const ProfileScreen(),
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       bottomNavigationBar: Theme(
//         data: Theme.of(context).copyWith(
//           canvasColor: const Color.fromRGBO(21, 27, 34, 1),
//         ),
//         child: BottomNavigationBar(
//           type: BottomNavigationBarType.fixed,
//           currentIndex: _selectedIndex,
//           showSelectedLabels: false,
//           showUnselectedLabels: false,
//           items: <BottomNavigationBarItem>[
//             BottomNavigationBarItem(
//               icon: Image.asset(
//                 homeIcon,
//                 width: 20.w,
//                 height: 20.w,
//                 fit: BoxFit.contain,
//               ),
//               label: '',
//               activeIcon: Image.asset(
//                 homeActiveIcon,
//                 width: 20.w,
//                 height: 20.w,
//                 fit: BoxFit.contain,
//               ),
//             ),
//             BottomNavigationBarItem(
//               icon: Image.asset(
//                 categoryIcon,
//                 width: 20.w,
//                 height: 20.w,
//                 fit: BoxFit.contain,
//               ),
//               label: '',
//               activeIcon: Image.asset(
//                 categoryActiveIcon,
//                 width: 20.w,
//                 height: 20.w,
//                 fit: BoxFit.contain,
//               ),
//             ),
//             BottomNavigationBarItem(
//               icon: Image.asset(
//                 searchIcon,
//                 width: 20.w,
//                 height: 20.w,
//                 fit: BoxFit.contain,
//               ),
//               label: '',
//               activeIcon: Image.asset(
//                 searchActiveIcon,
//                 width: 20.w,
//                 height: 20.w,
//                 fit: BoxFit.contain,
//               ),
//             ),
//             BottomNavigationBarItem(
//               icon: Image.asset(
//                 profileIcon,
//                 width: 20.w,
//                 height: 20.w,
//                 fit: BoxFit.contain,
//               ),
//               label: '',
//               activeIcon: Image.asset(
//                 profileActiveIcon,
//                 width: 20.w,
//                 height: 20.w,
//                 fit: BoxFit.contain,
//               ),
//             ),
//           ],
//           onTap: (index) {
//             setState(() {
//               _selectedIndex = index;
//             });
//           },
//         ),
//       ),
//       body: _widgetOptions.elementAt(_selectedIndex),
//     );
//   }
// }
