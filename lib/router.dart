import 'package:bitnet/pages/detail/image_detail_screen.dart';
import 'package:bitnet/pages/routetrees/routes.dart';
import 'package:bitnet/pages/website/website_landingpage/website_landingpage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _shellNavigatorKey = GlobalKey<NavigatorState>();

  // Define router with web error handling
  static GoRouter get _router {
    try {
      return GoRouter(
        debugLogDiagnostics: !kReleaseMode,
        navigatorKey: _rootNavigatorKey,
        initialLocation: kIsWeb ? '/website' : '/loading',
        routes: [
          // Add image detail route directly
          GoRoute(
            path: '/image_detail',
            builder: (ctx, state) {
              try {
                final Map<String, String> params = state.uri.queryParameters;
                final encodedData = params['data'] ?? '';
                final caption = params['caption'];
                return ImageDetailScreen(
                  encodedData: encodedData,
                  caption: caption,
                );
              } catch (e) {
                print('Error in image_detail route (safe to ignore in web preview): $e');
                return const Scaffold(
                  body: Center(child: Text('Image detail not available')),
                );
              }
            },
          ),
          // Try to add other routes safely
          ...getSafeRoutes(),
        ],
      );
    } catch (e) {
      print('Error initializing router (safe to ignore in web preview): $e');
      // Fallback minimal router
      return GoRouter(
        navigatorKey: _rootNavigatorKey,
        initialLocation: kIsWeb ? '/website' : '/loading',
        routes: [
          GoRoute(
            path: '/loading',
            builder: (context, state) => const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            ),
          ),
          GoRoute(
            path: '/website',
            builder: (context, state) => const WebsiteLandingPage(),
          ),
        ],
      );
    }
  }
  
  // Helper method to get routes safely
  static List<RouteBase> getSafeRoutes() {
    try {
      return AppRoutes(false).routes;
    } catch (e) {
      print('Error loading routes (safe to ignore in web preview): $e');
      return [
        GoRoute(
          path: '/loading',
          builder: (context, state) => const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          ),
        ),
        GoRoute(
          path: '/website',
          builder: (context, state) => const WebsiteLandingPage(),
        ),
      ];
    }
  }

  // Public router accessor
  static GoRouter get router {
    try {
      return _router;
    } catch (e) {
      print('Error getting router (safe to ignore in web preview): $e');
      // Fallback minimal router
      return GoRouter(
        navigatorKey: _rootNavigatorKey,
        initialLocation: kIsWeb ? '/website' : '/loading',
        routes: [
          GoRoute(
            path: '/loading',
            builder: (context, state) => const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            ),
          ),
          GoRoute(
            path: '/website',
            builder: (context, state) => const WebsiteLandingPage(),
          ),
        ],
      );
    }
  }
  
  static GlobalKey<NavigatorState> get navigatorKey => _rootNavigatorKey;
}