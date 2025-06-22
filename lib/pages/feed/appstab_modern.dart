import 'dart:async';
import 'dart:typed_data';

import 'package:bitnet/backbone/auth/auth.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/appstandards/BitNetListTile.dart';
import 'package:bitnet/components/appstandards/fadelistviewwrapper.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/loaders/loaders.dart';
import 'package:bitnet/pages/feed/appstab.dart';
import 'package:bitnet/components/appstandards/glasscontainer.dart';
import 'package:bitnet/components/items/cached_app_image.dart';
import 'package:bitnet/backbone/services/app_image_cache_service.dart';
import 'package:bitnet/pages/routetrees/marketplaceroutes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:get/get.dart';
import 'package:bitnet/backbone/helper/databaserefs.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bitnet/components/dialogsandsheets/notificationoverlays/overlay.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:bitnet/backbone/helper/helpers.dart';
import 'package:bitnet/components/items/number_indicator.dart';

class AppsTabModern extends StatefulWidget {
  const AppsTabModern({super.key});

  @override
  State<AppsTabModern> createState() => _AppsTabModernState();
}

class _AppsTabModernState extends State<AppsTabModern>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  List<AppData> myApps = [];
  List<AppData> availableApps = [];
  List<AppData> featuredApps = [];
  List<AppData> comingSoonApps = [];
  bool loading = true;
  String selectedCategory = 'All';
  late final AppImageCacheService _imageCacheService;
  
  final List<String> categories = ['All', 'Finance', 'Games', 'Tools', 'Social'];

  @override
  void initState() {
    super.initState();
    
    // Initialize image cache service with safety check
    try {
      _imageCacheService = Get.find<AppImageCacheService>();
    } catch (e) {
      // If service not found, register it
      Get.put(AppImageCacheService(), permanent: true);
      _imageCacheService = Get.find<AppImageCacheService>();
    }
    
    loadAsync();
  }

  Future<void> loadAsync() async {
    // Load actual apps from Firebase
    availableApps = await getAvailableApps();
    
    // Set featured apps (first 3 apps)
    featuredApps = availableApps.take(3).toList();
    
    // Preload images for featured apps
    _preloadImages();
    
    // Add website apps as coming soon (they work via WebView)
    comingSoonApps = [
      // Real websites integrated as apps with automatic favicon loading
      AppData(
        docId: 'website_satoshis_place',
        url: 'https://satoshis.place/',
        name: "Satoshi's Place",
        desc: 'Collaborative pixel art canvas where you paint with satoshis',
        useNetworkImage: true, // Auto-fetch favicon
      ),
      AppData(
        docId: 'website_lnmarkets',
        url: 'https://lnmarkets.com',
        name: 'LN Markets',
        desc: 'Bitcoin derivatives trading platform using Lightning Network',
        useNetworkImage: true, // Auto-fetch favicon
      ),
      AppData(
        docId: 'website_fold',
        url: 'https://foldapp.com/',
        name: 'Fold App',
        desc: 'Earn Bitcoin rewards when you shop at your favorite places',
        useNetworkImage: true, // Auto-fetch favicon
      ),
      AppData(
        docId: 'website_azteco',
        url: 'https://azte.co/',
        name: 'Azteco',
        desc: 'Buy Bitcoin vouchers to fund your wallet instantly',
        useNetworkImage: true, // Auto-fetch favicon
      ),
      AppData(
        docId: 'website_boltz',
        url: 'https://boltz.exchange/',
        name: 'Boltz Exchange',
        desc: 'Non-custodial cryptocurrency exchange with Lightning support',
        useNetworkImage: true, // Auto-fetch favicon
      ),
      AppData(
        docId: 'website_geyser',
        url: 'https://geyser.fund/',
        name: 'Geyser Fund',
        desc: 'Fund open-source Bitcoin projects through crowdfunding',
        useNetworkImage: true, // Auto-fetch favicon
      ),
      AppData(
        docId: 'website_lightsats',
        url: 'https://lightsats.com/',
        name: 'Lightsats',
        desc: 'Send Bitcoin tips and onboard new users easily',
        useNetworkImage: true, // Auto-fetch favicon
      ),
      AppData(
        docId: 'website_lnpizza',
        url: 'https://ln.pizza/',
        name: 'LN Pizza',
        desc: 'Order pizza with Bitcoin Lightning payments',
        useNetworkImage: true, // Auto-fetch favicon
      ),
      AppData(
        docId: 'website_sms4sats',
        url: 'https://sms4sats.com/',
        name: 'SMS4Sats',
        desc: 'Get an SMS number with Bitcoin Lightning payments',
        useNetworkImage: true, // Auto-fetch favicon
      ),
    ];
    
    // Get user's apps
    final doc = await Databaserefs.appsRef.doc(Auth().currentUser!.uid).get();
    if (doc.data() != null && doc.data()!['apps'] != null) {
      List appIds = doc.data()!['apps'];
      myApps = availableApps.where((app) => appIds.contains(app.docId)).toList();
    }
    
    loading = false;
    if (mounted) setState(() {});
  }
  
  Future<void> _preloadImages() async {
    // Preload featured app images
    final storageNames = featuredApps
        .where((app) => app.useNetworkAsset && app.storageName != null)
        .map((app) => app.storageName!)
        .toList();
    
    final urls = featuredApps
        .where((app) => app.useNetworkImage)
        .map((app) => app.url)
        .toList();
    
    await _imageCacheService.preloadImages(storageNames, urls);
    
    // Preload visible apps (first 6)
    final visibleApps = availableApps.take(6).toList();
    final visibleStorageNames = visibleApps
        .where((app) => app.useNetworkAsset && app.storageName != null)
        .map((app) => app.storageName!)
        .toList();
    
    final visibleUrls = visibleApps
        .where((app) => app.useNetworkImage)
        .map((app) => app.url)
        .toList();
    
    // Delay preloading of remaining apps
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        _imageCacheService.preloadImages(visibleStorageNames, visibleUrls);
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    super.build(context);
    
    return bitnetScaffold(
      context: context,
      body: VerticalFadeListView.standardTab(
        child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          stream: Databaserefs.appsRef.doc(Auth().currentUser!.uid).snapshots(),
          builder: (context, snapshot) {
            List<String> ownedApps = [];
            if (snapshot.hasData && snapshot.data!.data() != null) {
              List? dataList = snapshot.data!.data()!['apps'] as List?;
              ownedApps = dataList?.map((item) => item as String).toList() ?? [];
              myApps = availableApps.where((app) => ownedApps.contains(app.docId)).toList();
            }

            return ListView(
              physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
              children: [
                SizedBox(height: AppTheme.cardPadding.h),
                
                // Featured Apps Carousel Section
                if (!loading && featuredApps.isNotEmpty) ...[
                  SizedBox(height: AppTheme.cardPadding * 0.5.h),
                  CarouselSlider.builder(
                    options: getStandardizedCarouselOptions(
                      autoPlayIntervalSeconds: 5
                    ),
                    itemCount: featuredApps.length,
                    itemBuilder: (context, index, _) {
                      final app = featuredApps[index];
                      final isOwned = ownedApps.contains(app.docId);
                      
                      return RepaintBoundary(
                        child: GlassContainer(
                          width: getStandardizedCardWidth().w,
                          margin: EdgeInsets.symmetric(horizontal: getStandardizedCardMargin().w),
                          child: Padding(
                            padding: EdgeInsets.all(AppTheme.cardPadding.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // App info section
                                GestureDetector(
                                  onTap: () {
                                    context.go("/feed/" + kAppPageRoute, extra: app.toJson());
                                  },
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            width: 50.w,
                                            height: 50.h,
                                            decoration: BoxDecoration(
                                              color: Theme.of(context).colorScheme.surface,
                                              borderRadius: BorderRadius.circular(12.r),
                                              border: Border.all(
                                                color: Theme.of(context).colorScheme.outline.withOpacity(0.1),
                                              ),
                                            ),
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(12.r),
                                              child: Center(
                                                child: CachedAppImage(
                                                  app: app,
                                                  width: 35.w,
                                                  height: 35.h,
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 12.w),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  app.name,
                                                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Text(
                                                  'BitNET Community',
                                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 12.h),
                                      Text(
                                        app.desc,
                                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.8),
                                          height: 1.3,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                                
                                // Spacer to push button to bottom
                                Spacer(),
                                
                                // Button at the bottom
                                SizedBox(height: 16.h),
                                LongButtonWidget(
                                  title: isOwned ? 'Open' : 'Get',
                                  customHeight: 36.h, // Smaller height for thinner button
                                  buttonType: isOwned ? ButtonType.solid : ButtonType.transparent,
                                  titleStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                  onTap: () async {
                                    if (isOwned) {
                                      final url = await app.getUrl();
                                      context.pushNamed(kWebViewScreenRoute, 
                                        pathParameters: {
                                          'url': url,
                                          'name': app.name,
                                        }, 
                                        extra: {"is_app": true}
                                      );
                                    } else {
                                      context.go("/feed/" + kAppPageRoute, extra: app.toJson());
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: AppTheme.cardPadding.h),
                ],
                SizedBox(height: AppTheme.cardPadding * 1.h,),
                // Trending Apps Section  
                if (!loading) ...[
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: AppTheme.cardPadding.w),
                    child: Row(
                      children: [
                        Text(
                          '🔥 Trending Apps',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: AppTheme.cardPadding.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: AppTheme.cardPadding.w),
                    child: GlassContainer(
                      child: Padding(
                        padding: EdgeInsets.only(bottom: AppTheme.elementSpacing),
                        child: Column(
                          children: [
                            _buildTrendingAppTile(1, "Bitrefill", "https://www.bitrefill.com", "Buy gift cards and mobile refills with Bitcoin", 'assets/images/bitrefill_banner.png'),
                            _buildTrendingAppTile(2, "Wavlake", "https://wavlake.com/", "Stream music and support artists with Bitcoin", 'assets/images/wavlake_banner.png'),
                            _buildTrendingAppTile(3, "Flipit", "https://flipittoken.eth.limo/", "Decentralized gaming platform built on Bitcoin", 'assets/images/flipit_banner.png'),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: AppTheme.cardPadding.h),
                ],
                
                // My Apps Section
                if (loading || myApps.isNotEmpty) ...[
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: AppTheme.cardPadding.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'My Apps',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        if (myApps.isNotEmpty)
                          TextButton(
                            onPressed: () {
                              context.goNamed(kMyAppsPageRoute,
                                  extra: myApps.map((app) => app.toJson()).toList());
                            },
                            child: Row(
                              children: [
                                Text(
                                  'See All',
                                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                                SizedBox(width: 4.w),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  size: 12,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                  
                  SizedBox(height: AppTheme.elementSpacing.h),
                  
                  if (loading)
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: AppTheme.cardPadding.w),
                      child: dotProgress(context),
                    )
                  else if (myApps.isNotEmpty)
                    Container(
                      height: myApps.length <= 3 ? 120.h : 240.h,
                      padding: EdgeInsets.symmetric(horizontal: AppTheme.cardPadding.w),
                      child: GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 16.w,
                          mainAxisSpacing: 16.h,
                          childAspectRatio: 0.9,
                        ),
                        itemCount: myApps.length,
                        itemBuilder: (context, index) {
                          final app = myApps[index];
                          return _buildIOSAppIcon(app, true, false);
                        },
                      ),
                    ),
                  
                  SizedBox(height: AppTheme.cardPadding.h),
                ],
                
                // Available Apps Section
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: AppTheme.cardPadding.w),
                  child: Text(
                    'All Apps',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                
                SizedBox(height: AppTheme.elementSpacing.h),
                
                if (loading)
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: AppTheme.cardPadding.w),
                    child: dotProgress(context),
                  )
                else ...[
                  // Available Apps Grid - iOS Style
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: AppTheme.cardPadding.w),
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 16.w,
                        mainAxisSpacing: 16.h,
                        childAspectRatio: 0.9,
                      ),
                      itemCount: availableApps.length + comingSoonApps.length,
                      itemBuilder: (context, index) {
                        if (index < availableApps.length) {
                          final app = availableApps[index];
                          final isOwned = ownedApps.contains(app.docId);
                          
                          return _buildIOSAppIcon(app, isOwned, false);
                        } else {
                          final app = comingSoonApps[index - availableApps.length];
                          // Website apps are functional, not coming soon
                          final isComingSoon = app.docId.startsWith('coming_soon_');
                          return _buildIOSAppIcon(app, false, isComingSoon);
                        }
                      },
                    ),
                  ),
                ],
                
                SizedBox(height: AppTheme.cardPadding * 2.h),
              ],
            );
          },
        ),
      ),
    );
  }
  
  Widget _buildIOSAppIcon(AppData app, bool isOwned, bool isComingSoon) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final iconSize = constraints.maxWidth * 0.75;
        
        return GestureDetector(
          onTap: () async {
            if (isComingSoon) {
              Get.find<OverlayController>().showOverlay(
                'Coming soon!',
                color: AppTheme.successColor,
              );
            } else if (isOwned) {
              final url = await app.getUrl();
              context.pushNamed(kWebViewScreenRoute, 
                pathParameters: {
                  'url': url,
                  'name': app.name,
                }, 
                extra: {"is_app": true}
              );
            } else if (app.docId.startsWith('website_')) {
              // Handle website apps - open directly in WebView
              context.pushNamed(kWebViewScreenRoute,
                pathParameters: {
                  'url': app.url,
                  'name': app.name,
                },
              );
            } else {
              context.go("/feed/" + kAppPageRoute, extra: app.toJson());
            }
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                flex: 3,
                child: Center(
                  child: Stack(
                    children: [
                      // Glass Container App Icon
                      Container(
                        width: iconSize,
                        height: iconSize,
                        child: GlassContainer(
                        borderRadius: BorderRadius.circular(AppTheme.borderRadiusMid.r),
                        opacity: 0.1,
                        border: Border.all(width: 1, color: Theme.of(context).dividerColor),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(AppTheme.borderRadiusMid.r),
                          child: Container(
                            width: iconSize,
                            height: iconSize,
                            child: FittedBox(
                              fit: BoxFit.cover,
                              child: SizedBox(
                                width: iconSize,
                                height: iconSize,
                                child: CachedAppImage(
                                  app: app,
                                  width: iconSize,
                                  height: iconSize,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    
                    // Coming Soon Overlay
                    if (isComingSoon)
                      Positioned.fill(
                        child: Container(
                          width: iconSize,
                          height: iconSize,
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(AppTheme.borderRadiusMid.r),
                          ),
                          child: Center(
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.9),
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: Text(
                                'SOON',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    
                    ],
                  ),
                ),
              ),
              
              // App Name
              Expanded(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  child: Text(
                    app.name,
                    style: Theme.of(context).textTheme.bodySmall,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildModernAppCard(AppData app, bool isOwned, bool isComingSoon, List<String> ownedApps) {
    return GestureDetector(
      onTap: () async {
        if (isComingSoon) {
          Get.find<OverlayController>().showOverlay(
            'Coming soon!',
            color: AppTheme.successColor,
          );
        } else if (isOwned) {
          final url = await app.getUrl();
          context.pushNamed(kWebViewScreenRoute, 
            pathParameters: {
              'url': url,
              'name': app.name,
            }, 
            extra: {"is_app": true}
          );
        } else {
          context.go("/feed/" + kAppPageRoute, extra: app.toJson());
        }
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(AppTheme.cardPadding.w),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(AppTheme.borderRadiusMid.r),
          border: Border.all(
            color: Theme.of(context).colorScheme.outline.withOpacity(0.1),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).shadowColor.withOpacity(0.05),
              blurRadius: 10,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // App Icon
            Stack(
              children: [
                Container(
                  width: 65.w,
                  height: 65.h,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.background,
                    borderRadius: BorderRadius.circular(AppTheme.borderRadiusSmall.r),
                    border: Border.all(
                      color: Theme.of(context).colorScheme.outline.withOpacity(0.1),
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(AppTheme.borderRadiusSmall.r),
                    child: Center(
                      child: AppImageBuilder(
                        app: app,
                        width: 50.w,
                        height: 50.h,
                      ),
                    ),
                  ),
                ),
                if (isComingSoon)
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(AppTheme.borderRadiusSmall.r),
                      ),
                      child: Center(
                        child: Text(
                          'SOON',
                          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 10.sp,
                          ),
                        ),
                      ),
                    ),
                  ),
                if (isOwned)
                  Positioned(
                    top: -2,
                    right: -2,
                    child: Container(
                      width: 20.w,
                      height: 20.h,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Theme.of(context).colorScheme.surface,
                          width: 2,
                        ),
                      ),
                      child: Icon(
                        Icons.check,
                        size: 12.sp,
                        color: Colors.white,
                      ),
                    ),
                  ),
              ],
            ),
            
            SizedBox(width: AppTheme.elementSpacing.w),
            
            // App Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          app.name,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (isComingSoon)
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.outline.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Text(
                            'Coming Soon',
                            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        )
                      else if (isOwned)
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Text(
                            'Owned',
                            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                    ],
                  ),
                  
                  SizedBox(height: 4.h),
                  
                  Text(
                    'BitNET Community',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                    ),
                  ),
                  
                  SizedBox(height: 6.h),
                  
                  Text(
                    app.desc,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface.withOpacity(0.8),
                      height: 1.3,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            
            SizedBox(width: AppTheme.elementSpacing.w),
            
            // Action Button
            if (!isComingSoon)
              LongButtonWidget(
                title: isOwned ? 'Open' : 'Get',
                customWidth: 70.w,
                customHeight: 36.h,
                buttonType: isOwned ? ButtonType.solid : ButtonType.transparent,
                titleStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                onTap: () async {
                  if (isOwned) {
                    final url = await app.getUrl();
                    context.pushNamed(kWebViewScreenRoute, 
                      pathParameters: {
                        'url': url,
                        'name': app.name,
                      }, 
                      extra: {"is_app": true}
                    );
                  } else {
                    context.go("/feed/" + kAppPageRoute, extra: app.toJson());
                  }
                },
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppGridItem(AppData app, bool isOwned, bool isComingSoon) {
    return GestureDetector(
      onTap: () async {
        if (isComingSoon) {
          Get.find<OverlayController>().showOverlay(
            'Coming soon!',
            color: AppTheme.successColor,
          );
        } else if (isOwned) {
          final url = await app.getUrl();
          context.pushNamed(kWebViewScreenRoute, 
            pathParameters: {
              'url': url,
              'name': app.name,
            }, 
            extra: {"is_app": true}
          );
        } else {
          context.go("/feed/" + kAppPageRoute, extra: app.toJson());
        }
      },
      child: Opacity(
        opacity: isComingSoon ? 0.5 : 1.0,
        child: Container(
          width: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 60.w,
                height: 60.h,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(14.r),
                  border: Border.all(
                    color: Theme.of(context).colorScheme.outline.withOpacity(0.1),
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(14.r),
                        child: Center(
                          child: AppImageBuilder(
                            app: app,
                            width: 45.w,
                            height: 45.h,
                          ),
                        ),
                      ),
                    ),
                    if (isComingSoon)
                      Positioned.fill(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(14.r),
                          ),
                          child: Center(
                            child: Text(
                              'SOON',
                              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 9.sp,
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              SizedBox(height: 4.h),
              Flexible(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2.w),
                  child: Text(
                    app.name,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontSize: 10.sp,
                      height: 1.2,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildTrendingAppTile(int position, String name, String url, String description, String iconPath) {
    return Stack(
      children: [
        BitNetListTile(
          leading: Container(
            width: 40.w,
            height: 40.h,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(
                color: Theme.of(context).colorScheme.outline.withOpacity(0.1),
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: Image.asset(
                iconPath,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(Icons.public, size: 20);
                },
              ),
            ),
          ),
          text: name,
          subtitle: Text(
            description,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: LongButtonWidget(
            title: 'Open',
            customWidth: 70.w,
            customHeight: 36.h,
            buttonType: ButtonType.transparent,
            titleStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
            onTap: () {
              context.pushNamed(kWebViewScreenRoute,
                pathParameters: {
                  'url': url,
                  'name': name,
                },
              );
            },
          ),
          onTap: () {
            context.pushNamed(kWebViewScreenRoute,
              pathParameters: {
                'url': url,
                'name': name,
              },
            );
          },
        ),
        Positioned(
          left: 10,
          top: 10,
          child: NumberIndicator(number: position),
        ),
      ],
    );
  }
}