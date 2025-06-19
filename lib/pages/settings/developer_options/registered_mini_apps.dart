import 'package:bitnet/backbone/auth/auth.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/appstandards/fadelistviewwrapper.dart';
import 'package:bitnet/components/appstandards/glasscontainer.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/dialogsandsheets/notificationoverlays/overlay.dart';
import 'package:bitnet/components/loaders/loaders.dart';
import 'package:bitnet/pages/feed/appstab.dart';
import 'package:bitnet/pages/profile/profile_controller.dart';
import 'package:bitnet/pages/routetrees/marketplaceroutes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class RegisteredMiniAppsPage extends StatefulWidget {
  const RegisteredMiniAppsPage({Key? key}) : super(key: key);

  @override
  State<RegisteredMiniAppsPage> createState() => _RegisteredMiniAppsPageState();
}

class _RegisteredMiniAppsPageState extends State<RegisteredMiniAppsPage> {
  bool _isLoading = true;
  List<AppData> _registeredApps = [];

  @override
  void initState() {
    super.initState();
    _loadRegisteredApps();
  }

  Future<void> _loadRegisteredApps() async {
    try {
      // In a real implementation, we would fetch from Firestore
      // For now, we'll use dummy data based on the profile controller's availableApps

      // Simulate network delay

      // Get apps from profile controller (these are just for demo purposes)
      final profileController = Get.find<ProfileController>();
      if (profileController.availableApps.isNotEmpty) {
        _registeredApps = List<AppData>.from(profileController.availableApps)
            .where((test) =>
                test.ownerId != null && test.ownerId == Auth().currentUser!.uid)
            .cast<AppData>()
            .toList();
      } else {
        // Create dummy apps if none are available
        _registeredApps = _createDummyApps();
      }

      // Load favicons for all apps
      for (final app in _registeredApps) {
        app.loadFaviconBytes();
      }
    } catch (e) {
      print("Error loading registered apps: $e");
      // Show error notification
      OverlayController overlayController = Get.find<OverlayController>();
      overlayController.showOverlay(
        'Failed to load registered apps',
        color: AppTheme.errorColor,
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  List<AppData> _createDummyApps() {
    return [
      AppData(
        docId: 'app1',
        name: 'Bitcoin News',
        url: 'https://news.bitcoin.com',
        desc: 'Latest Bitcoin and cryptocurrency news from around the world',
        useNetworkImage: true,
      ),
      AppData(
        docId: 'app2',
        name: 'Lightning Calculator',
        url: 'https://lightning-calculator.com',
        desc: 'Calculate Lightning Network fees and routing paths',
        useNetworkImage: true,
      ),
      AppData(
        docId: 'app3',
        name: 'Bitcoin Explorer',
        url: 'https://blockstream.info',
        desc: 'Explore the Bitcoin blockchain and transactions',
        useNetworkImage: true,
      ),
      AppData(
        docId: 'app4',
        name: 'Satoshi\'s Games',
        url: 'https://satoshis.games',
        desc: 'Play games and earn Bitcoin',
        useNetworkImage: true,
      ),
      AppData(
        docId: 'app5',
        name: 'Bitcoin Markets',
        url: 'https://bitcoinmarkets.io',
        desc: 'Real-time Bitcoin price and market data',
        useNetworkImage: true,
      ),
    ];
  }

  @override
  void dispose() {
    // Clean up resources
    for (final app in _registeredApps) {
      app.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.cardPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title and description

            // Loading indicator or app list
            _isLoading
                ? Column(
                    children: [
                      SizedBox(height: 128),
                      Center(child: dotProgress(context)),
                    ],
                  )
                : _registeredApps.isEmpty
                    ? _buildEmptyState()
                    : _buildAppsList(),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 30),
          Icon(
            Icons.apps_outlined,
            size: 60,
            color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
          ),
          const SizedBox(height: 16),
          Text(
            "No registered apps found",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Text(
            "Applications will appear here after they are approved",
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 30),
          LongButtonWidget(
            title: "Submit an App",
            onTap: () {
              // Navigate back to the first view and then to the application form
              context.pop();
              // After a short delay, navigate to main developer options page
            },
            buttonType: ButtonType.solid,
            customWidth: 200,
          ),
        ],
      ),
    );
  }

  Widget _buildAppsList() {
    return GlassContainer(
      opacity: 0.8,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: ListView(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          children: [
            ..._registeredApps.map((app) => AppListTile(
                  inMyAppsScreen: false,
                  app: app,
                  outsideNavigation: true,
                  appOwned: true,
                )),
          ],
        ),
      ),
    );
  }
}
