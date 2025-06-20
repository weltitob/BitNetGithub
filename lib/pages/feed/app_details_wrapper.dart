import 'package:bitnet/pages/feed/appstab.dart';
import 'package:bitnet/pages/feed/app_details_modern.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ModernAppDetailsPage extends StatelessWidget {
  final GoRouterState routerState;

  const ModernAppDetailsPage({
    super.key,
    required this.routerState,
  });

  @override
  Widget build(BuildContext context) {
    // Extract app data from router state
    if (routerState.extra is Map<String, dynamic>) {
      final data = routerState.extra as Map<String, dynamic>;
      final app = AppData.fromJson(data);
      return AppDetailsModern(app: app);
    }
    
    // Fallback to original AppTab
    return AppTab(routerState: routerState);
  }
}