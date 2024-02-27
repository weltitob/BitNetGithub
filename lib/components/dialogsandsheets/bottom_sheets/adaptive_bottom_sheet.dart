// import 'package:bitnet/backbone/helper/platform_infos.dart';
// import 'package:bitnet/backbone/helper/theme/theme.dart';
// import 'package:flutter/material.dart';
//
//
// Future<T?> showAdaptiveBottomSheet<T>({
//   required BuildContext context,
//   required Widget Function(BuildContext) builder,
//   bool isDismissible = true,
//   bool isScrollControlled = true,
// }) =>
//     showModalBottomSheet(
//       context: context,
//       builder: builder,
//       useRootNavigator: !PlatformInfos.isMobile,
//       isDismissible: isDismissible,
//       isScrollControlled: isScrollControlled,
//       constraints: const BoxConstraints(
//         maxHeight: 500,
//         maxWidth: AppTheme.columnWidth * 1.5,
//       ),
//       clipBehavior: Clip.hardEdge,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(AppTheme.borderRadiusSmall),
//           topRight: Radius.circular(AppTheme.borderRadiusSmall),
//         ),
//       ),
//     );
