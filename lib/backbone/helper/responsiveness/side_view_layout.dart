import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SideViewLayout extends StatelessWidget {
  final Widget mainView;
  final Widget? sideView;

  const SideViewLayout({Key? key, required this.mainView, this.sideView})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    var currentUrl = Uri.decodeFull(
        GoRouter.of(context).routeInformationProvider.value.uri.toString());
    if (!currentUrl.endsWith('/')) currentUrl += '/';
    final hideSideView = currentUrl.split('/').length == 4;
    final sideView = this.sideView;
    return sideView == null
        ? mainView
        : MediaQuery.of(context).size.width < AppTheme.columnWidth * 3.5 &&
                !hideSideView
            ? sideView
            : Row(
                children: [
                  Expanded(
                    child: ClipRRect(child: mainView),
                  ),
                  Container(
                    width: 1.0,
                    color: Theme.of(context).dividerColor,
                  ),
                  AnimatedContainer(
                    duration: AppTheme.animationDuration,
                    curve: AppTheme.animationCurve,
                    clipBehavior: Clip.antiAlias,
                    decoration: const BoxDecoration(),
                    width: hideSideView ? 0 : 360.0,
                    child: hideSideView ? null : sideView,
                  ),
                ],
              );
  }
}
