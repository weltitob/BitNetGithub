import 'package:bitnet/pages/feed/appstab.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ModernMyAppsPage extends StatelessWidget {
  final GoRouterState routerState;

  const ModernMyAppsPage({
    super.key,
    required this.routerState,
  });

  @override
  Widget build(BuildContext context) {
    // Use the original MyAppsPage which handles the my apps list
    return MyAppsPage(routerState: routerState);
  }
}
