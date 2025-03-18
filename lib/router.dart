import 'package:bitnet/pages/detail/image_detail_screen.dart';
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

    routes: [
      // Add image detail route directly
      GoRoute(
        path: '/image_detail',
        builder: (ctx, state) {
          final Map<String, String> params = state.uri.queryParameters;
          final encodedData = params['data'] ?? '';
          final caption = params['caption'];
          return ImageDetailScreen(
            encodedData: encodedData,
            caption: caption,
          );
        },
      ),
      // Add all other routes
      ...AppRoutes(false).routes,
    ],
  );

  static GoRouter get router => _router;
  static GlobalKey<NavigatorState> get navigatorKey => _rootNavigatorKey;
}