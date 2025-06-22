import 'dart:async';
import 'dart:typed_data';

import 'package:bitnet/backbone/auth/auth.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
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
    
    // Add some coming soon apps
    comingSoonApps = [
      AppData(
        docId: 'coming_soon_1',
        url: '',
        name: 'Lightning Chess',
        desc: 'Play chess and win sats in real-time matches',
        iconPath: 'assets/images/bitcoin.png',
        useNetworkImage: false,
      ),
      AppData(
        docId: 'coming_soon_2',
        url: '',
        name: 'Sat Streamer',
        desc: 'Stream content and earn Bitcoin from your audience',
        iconPath: 'assets/images/lightning.png',
        useNetworkImage: false,
      ),
      AppData(
        docId: 'coming_soon_3',
        url: '',
        name: 'Node Monitor',
        desc: 'Professional Lightning node monitoring and analytics',
        iconPath: 'assets/images/bitcoin.png',
        useNetworkImage: false,
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
                
                // Featured Section
                if (!loading && featuredApps.isNotEmpty) ...[
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: AppTheme.cardPadding.w),
                    child: Text(
                      'Featured',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  SizedBox(height: AppTheme.elementSpacing.h),
                  SizedBox(
                    height: 180.h,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.symmetric(horizontal: AppTheme.cardPadding.w),
                      itemCount: featuredApps.length,
                      itemBuilder: (context, index) {
                        final app = featuredApps[index];
                        final isOwned = ownedApps.contains(app.docId);
                        
                        return Padding(
                          padding: EdgeInsets.only(right: 16.w),
                          child: GestureDetector(
                            onTap: () {
                              context.go("/feed/" + kAppPageRoute, extra: app.toJson());
                            },
                            child: GlassContainer(
                              width: 280.w,
                              height: 180.h,
                              opacity: 0.1,
                              borderRadius: AppTheme.cardPaddingBig.r,
                              child: Padding(
                                padding: EdgeInsets.all(20.w),
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
                                        // Small button consistent with app design
                                        LongButtonWidget(
                                          title: isOwned ? 'Open' : 'Get',
                                          customWidth: 65.w,
                                          customHeight: 32.h,
                                          buttonType: ButtonType.transparent,
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
                                    Spacer(),
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
                            ),
                          ),
                        );
                      },
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
                          return _buildIOSAppIcon(app, false, true);
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
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Coming soon!'),
                  duration: Duration(seconds: 2),
                ),
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
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Coming soon!'),
              duration: Duration(seconds: 2),
            ),
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
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Coming soon!'),
              duration: Duration(seconds: 2),
            ),
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
}