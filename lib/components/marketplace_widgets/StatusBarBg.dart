

// class StatusBarBg extends StatelessWidget {
//
//   const StatusBarBg({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     final Size size = MediaQuery.of(context).size;
//     double statusBarHeight = MediaQuery.of(context).padding.top;
//     return Positioned(
//       top: 0,
//       left: 0,
//       child: ClipRect(
//         child: BackdropFilter(
//           filter: ImageFilter.blur(sigmaX: 7.0, sigmaY: 7.0),
//           child: Container(
//             decoration: const BoxDecoration(
//               color: Color.fromRGBO(21, 27, 34, 0.1),
//             ),
//             height: statusBarHeight,
//             width: size.width,
//           ),
//         ),
//       ),
//     );
//   }
// }
