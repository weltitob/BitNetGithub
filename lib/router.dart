import 'package:bitnet/pages/routetrees/routes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _shellNavigatorKey = GlobalKey<NavigatorState>();

  static final GoRouter _router = GoRouter(
    debugLogDiagnostics: !kReleaseMode,
    // localizationsDelegates: L10n.localizationsDelegates,
    // supportedLocales: L10n.supportedLocales,
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/loading',

    routes: AppRoutes(false).routes,
  );

  static GoRouter get router => _router;
  static GlobalKey<NavigatorState> get navigatorKey => _rootNavigatorKey;
}
