import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'dart:math' as math;

import 'package:bitnet/backbone/auth/auth.dart';
import 'package:bitnet/backbone/cloudfunctions/lnd/walletkitservice/nextaddr.dart';
import 'package:bitnet/backbone/helper/databaserefs.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetListTile.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/appstandards/fadelistviewwrapper.dart';
import 'package:bitnet/components/appstandards/glasscontainer.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/container/imagewithtext.dart';
import 'package:bitnet/components/loaders/loaders.dart';
import 'package:bitnet/models/bitcoin/walletkit/addressmodel.dart';
import 'package:bitnet/pages/profile/profile_controller.dart';
import 'package:bitnet/pages/routetrees/marketplaceroutes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_highlighter/themes/docco.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as html;
import 'package:share_plus/share_plus.dart';

// App categories for filtering
enum AppCategory {
  all,
  finance,
  games,
  tools,
  social,
  shopping,
  education,
  news,
}

extension AppCategoryExtension on AppCategory {
  String get displayName {
    switch (this) {
      case AppCategory.all:
        return 'All';
      case AppCategory.finance:
        return 'Finance';
      case AppCategory.games:
        return 'Games';
      case AppCategory.tools:
        return 'Tools';
      case AppCategory.social:
        return 'Social';
      case AppCategory.shopping:
        return 'Shopping';
      case AppCategory.education:
        return 'Education';
      case AppCategory.news:
        return 'News';
    }
  }

  IconData get icon {
    switch (this) {
      case AppCategory.all:
        return Icons.apps_rounded;
      case AppCategory.finance:
        return Icons.account_balance_rounded;
      case AppCategory.games:
        return Icons.sports_esports_rounded;
      case AppCategory.tools:
        return Icons.build_rounded;
      case AppCategory.social:
        return Icons.people_rounded;
      case AppCategory.shopping:
        return Icons.shopping_cart_rounded;
      case AppCategory.education:
        return Icons.school_rounded;
      case AppCategory.news:
        return Icons.newspaper_rounded;
    }
  }
}

class ModernAppsTab extends StatefulWidget {
  const ModernAppsTab({super.key});

  @override
  State<ModernAppsTab> createState() => _ModernAppsTabState();
}

class _ModernAppsTabState extends State<ModernAppsTab>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  @override
  bool get wantKeepAlive => true;

  List<AppData> myApps = [];
  List<AppData> availableApps = [];
  List<AppData> featuredApps = [];
  List<AppData> filteredApps = [];
  bool loading = true;
  AppCategory selectedCategory = AppCategory.all;
  String searchQuery = '';
  late TextEditingController searchController;
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;
  final ScrollController _categoriesScrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeInOut,
    );
    loadAsync();
  }

  Future<void> loadAsync() async {
    availableApps = await getAvailableApps();
    
    // Simulate featured apps (in production, this would come from a backend flag)
    featuredApps = availableApps.take(5).toList();
    
    Get.find<ProfileController>().availableApps = availableApps;
    myApps = await getMyApps(availableApps);
    
    // Load favicon bytes for all apps
    for (final app in [...myApps, ...availableApps]) {
      app.loadFaviconBytes();
    }
    
    filterApps();
    loading = false;
    
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        setState(() {});
        _fadeController.forward();
      }
    });
  }

  void filterApps() {
    filteredApps = availableApps.where((app) {
      final matchesCategory = selectedCategory == AppCategory.all ||
          app.category == selectedCategory;
      final matchesSearch = searchQuery.isEmpty ||
          app.name.toLowerCase().contains(searchQuery.toLowerCase()) ||
          app.desc.toLowerCase().contains(searchQuery.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();
  }

  @override
  void dispose() {
    searchController.dispose();
    _fadeController.dispose();
    _categoriesScrollController.dispose();
    for (final app in [...myApps, ...availableApps]) {
      app.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return bitnetScaffold(
      context: context,
      body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: Databaserefs.appsRef.doc(Auth().currentUser!.uid).snapshots(),
        builder: (context, snapshot) {
          List<String> ownedApps = [];
          if (snapshot.hasData && snapshot.data!.data() != null) {
            List? dataList = snapshot.data!.data()!['apps'] as List?;
            ownedApps = dataList?.map((item) => item as String).toList() ?? [];
          }
          myApps = availableApps
              .where((test) => ownedApps.contains(test.docId))
              .toList();

          return CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              // Search Bar
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                    AppTheme.cardPadding.w,
                    AppTheme.cardPadding.h,
                    AppTheme.cardPadding.w,
                    AppTheme.elementSpacing.h,
                  ),
                  child: _buildSearchBar(),
                ),
              ),

              // Categories
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 50.h,
                  child: _buildCategories(),
                ),
              ),

              // Loading State
              if (loading)
                SliverFillRemaining(
                  child: Center(child: dotProgress(context)),
                ),

              // Content
              if (!loading) ...[
                // Featured Apps Section
                if (featuredApps.isNotEmpty && selectedCategory == AppCategory.all && searchQuery.isEmpty)
                  SliverToBoxAdapter(
                    child: FadeTransition(
                      opacity: _fadeAnimation,
                      child: _buildFeaturedSection(ownedApps),
                    ),
                  ),

                // My Apps Section
                if (myApps.isNotEmpty && searchQuery.isEmpty)
                  SliverToBoxAdapter(
                    child: FadeTransition(
                      opacity: _fadeAnimation,
                      child: _buildMyAppsSection(ownedApps),
                    ),
                  ),

                // Explore Apps Grid
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppTheme.cardPadding.w,
                      vertical: AppTheme.elementSpacing.h,
                    ),
                    child: FadeTransition(
                      opacity: _fadeAnimation,
                      child: Text(
                        searchQuery.isNotEmpty ? 'Search Results' : 'Explore Apps',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ),
                  ),
                ),

                SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: AppTheme.cardPadding.w),
                  sliver: SliverGrid(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.75,
                      crossAxisSpacing: AppTheme.elementSpacing.w,
                      mainAxisSpacing: AppTheme.elementSpacing.h,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return FadeTransition(
                          opacity: _fadeAnimation,
                          child: SlideTransition(
                            position: Tween<Offset>(
                              begin: Offset(0, 0.1),
                              end: Offset.zero,
                            ).animate(CurvedAnimation(
                              parent: _fadeController,
                              curve: Interval(
                                (index / filteredApps.length).clamp(0.0, 0.4),
                                ((index / filteredApps.length) + 0.1).clamp(0.0, 1.0),
                                curve: Curves.easeOut,
                              ),
                            )),
                            child: _buildModernAppCard(
                              filteredApps[index],
                              ownedApps.contains(filteredApps[index].docId),
                            ),
                          ),
                        );
                      },
                      childCount: filteredApps.length,
                    ),
                  ),
                ),

                // Bottom padding
                SliverToBoxAdapter(
                  child: SizedBox(height: AppTheme.cardPadding.h * 2),
                ),
              ],
            ],
          );
        },
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface.withOpacity(0.5),
        borderRadius: BorderRadius.circular(AppTheme.borderRadiusMid.r),
        border: Border.all(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: TextField(
        controller: searchController,
        onChanged: (value) {
          setState(() {
            searchQuery = value;
            filterApps();
          });
        },
        decoration: InputDecoration(
          hintText: 'Search apps...',
          hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
              ),
          prefixIcon: Icon(
            Icons.search_rounded,
            color: Theme.of(context).colorScheme.primary,
          ),
          suffixIcon: searchQuery.isNotEmpty
              ? IconButton(
                  icon: Icon(Icons.clear_rounded),
                  onPressed: () {
                    setState(() {
                      searchController.clear();
                      searchQuery = '';
                      filterApps();
                    });
                  },
                )
              : null,
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(
            horizontal: AppTheme.elementSpacing.w,
            vertical: AppTheme.elementSpacing.h,
          ),
        ),
      ),
    );
  }

  Widget _buildCategories() {
    return ListView.builder(
      controller: _categoriesScrollController,
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.symmetric(horizontal: AppTheme.cardPadding.w),
      itemCount: AppCategory.values.length,
      itemBuilder: (context, index) {
        final category = AppCategory.values[index];
        final isSelected = selectedCategory == category;
        
        return Padding(
          padding: EdgeInsets.only(right: AppTheme.elementSpacing.w),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            child: FilterChip(
              selected: isSelected,
              label: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    category.icon,
                    size: 16.r,
                    color: isSelected
                        ? Theme.of(context).colorScheme.onPrimary
                        : Theme.of(context).colorScheme.primary,
                  ),
                  SizedBox(width: 4.w),
                  Text(
                    category.displayName,
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: isSelected
                              ? Theme.of(context).colorScheme.onPrimary
                              : Theme.of(context).colorScheme.primary,
                        ),
                  ),
                ],
              ),
              onSelected: (selected) {
                setState(() {
                  selectedCategory = category;
                  filterApps();
                });
              },
              backgroundColor: Theme.of(context).colorScheme.surface,
              selectedColor: Theme.of(context).colorScheme.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppTheme.borderRadiusSmall.r),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildFeaturedSection(List<String> ownedApps) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(
            AppTheme.cardPadding.w,
            AppTheme.cardPadding.h,
            AppTheme.cardPadding.w,
            AppTheme.elementSpacing.h,
          ),
          child: Row(
            children: [
              Icon(
                Icons.star_rounded,
                color: Theme.of(context).colorScheme.primary,
                size: 24.r,
              ),
              SizedBox(width: AppTheme.elementSpacing.w / 2),
              Text(
                'Featured Apps',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ],
          ),
        ),
        SizedBox(
          height: 200.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: AppTheme.cardPadding.w),
            itemCount: featuredApps.length,
            itemBuilder: (context, index) {
              final app = featuredApps[index];
              final isOwned = ownedApps.contains(app.docId);
              
              return Padding(
                padding: EdgeInsets.only(right: AppTheme.elementSpacing.w),
                child: _buildFeaturedCard(app, isOwned),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildFeaturedCard(AppData app, bool isOwned) {
    return GestureDetector(
      onTap: () {
        context.go("/feed/" + kAppPageRoute, extra: app.toJson());
      },
      child: Container(
        width: 300.w,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).colorScheme.primary.withOpacity(0.8),
              Theme.of(context).colorScheme.primary.withOpacity(0.4),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(AppTheme.borderRadiusMid.r),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
              blurRadius: 20,
              offset: Offset(0, 10),
            ),
          ],
        ),
        child: Stack(
          children: [
            // Background pattern
            Positioned.fill(
              child: CustomPaint(
                painter: _PatternPainter(
                  color: Colors.white.withOpacity(0.1),
                ),
              ),
            ),
            // Content
            Padding(
              padding: EdgeInsets.all(AppTheme.cardPadding.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      AppImageBuilder(
                        app: app,
                        width: 60.w,
                        height: 60.h,
                      ),
                      SizedBox(width: AppTheme.elementSpacing.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              app.name,
                              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 4.h),
                            Row(
                              children: [
                                Icon(
                                  Icons.star_rounded,
                                  size: 16.r,
                                  color: Colors.amber,
                                ),
                                SizedBox(width: 4.w),
                                Text(
                                  '4.${5 + (app.name.length % 5)}',
                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                        color: Colors.white,
                                      ),
                                ),
                                SizedBox(width: 8.w),
                                Text(
                                  '${1000 + (app.name.length * 100)} downloads',
                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                        color: Colors.white70,
                                      ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: AppTheme.elementSpacing.h),
                  Text(
                    app.desc,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.white.withOpacity(0.9),
                        ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Spacer(),
                  Container(
                    width: double.infinity,
                    height: 40.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(AppTheme.borderRadiusSmall.r),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(AppTheme.borderRadiusSmall.r),
                        onTap: () async {
                          if (isOwned) {
                            context.pushNamed(kWebViewScreenRoute, pathParameters: {
                              'url': await app.getUrl(),
                              'name': app.name,
                            }, extra: {
                              "is_app": true
                            });
                          } else {
                            await addAppToUser(app);
                          }
                        },
                        child: Center(
                          child: Text(
                            isOwned ? 'Open' : 'Get',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: Theme.of(context).colorScheme.primary,
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
          ],
        ),
      ),
    );
  }

  Widget _buildMyAppsSection(List<String> ownedApps) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(
            AppTheme.cardPadding.w,
            AppTheme.cardPadding.h,
            AppTheme.cardPadding.w,
            AppTheme.elementSpacing.h,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'My Apps',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              TextButton(
                onPressed: () {
                  context.goNamed(kMyAppsPageRoute,
                      extra: myApps.map((app) => app.toJson()).toList());
                },
                child: Row(
                  children: [
                    Text(
                      'See all',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 14.r,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 120.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: AppTheme.cardPadding.w),
            itemCount: math.min(myApps.length, 5),
            itemBuilder: (context, index) {
              final app = myApps[index];
              return Padding(
                padding: EdgeInsets.only(right: AppTheme.elementSpacing.w),
                child: _buildMyAppCard(app),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildMyAppCard(AppData app) {
    return GestureDetector(
      onTap: () async {
        context.pushNamed(kWebViewScreenRoute, pathParameters: {
          'url': await app.getUrl(),
          'name': app.name,
        }, extra: {
          "is_app": true
        });
      },
      child: Container(
        width: 100.w,
        child: Column(
          children: [
            Container(
              width: 70.w,
              height: 70.h,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(AppTheme.borderRadiusSmall.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(AppTheme.borderRadiusSmall.r),
                child: AppImageBuilder(
                  app: app,
                  width: 70.w,
                  height: 70.h,
                ),
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              app.name,
              style: Theme.of(context).textTheme.bodySmall,
              maxLines: 2,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildModernAppCard(AppData app, bool isOwned) {
    return GestureDetector(
      onTap: () {
        context.go("/feed/" + kAppPageRoute, extra: app.toJson());
      },
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(AppTheme.borderRadiusMid.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // App Icon and Header
            Container(
              height: 120.h,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).colorScheme.primary.withOpacity(0.1),
                    Theme.of(context).colorScheme.primary.withOpacity(0.05),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(AppTheme.borderRadiusMid.r),
                  topRight: Radius.circular(AppTheme.borderRadiusMid.r),
                ),
              ),
              child: Center(
                child: AppImageBuilder(
                  app: app,
                  width: 60.w,
                  height: 60.h,
                ),
              ),
            ),
            // App Info
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(AppTheme.elementSpacing.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      app.name,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      app.desc,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                          ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Spacer(),
                    // Rating and Downloads
                    Row(
                      children: [
                        Icon(
                          Icons.star_rounded,
                          size: 14.r,
                          color: Colors.amber,
                        ),
                        SizedBox(width: 2.w),
                        Text(
                          '4.${3 + (app.name.length % 3)}',
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                        SizedBox(width: 8.w),
                        Icon(
                          Icons.download_rounded,
                          size: 14.r,
                          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
                        ),
                        SizedBox(width: 2.w),
                        Text(
                          '${100 + (app.name.length * 50)}',
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    // Action Button
                    Container(
                      width: double.infinity,
                      height: 32.h,
                      decoration: BoxDecoration(
                        color: isOwned
                            ? Theme.of(context).colorScheme.surface
                            : Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.circular(AppTheme.borderRadiusSmall.r),
                        border: isOwned
                            ? Border.all(
                                color: Theme.of(context).colorScheme.primary,
                                width: 1,
                              )
                            : null,
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(AppTheme.borderRadiusSmall.r),
                          onTap: () async {
                            if (isOwned) {
                              context.pushNamed(kWebViewScreenRoute, pathParameters: {
                                'url': await app.getUrl(),
                                'name': app.name,
                              }, extra: {
                                "is_app": true
                              });
                            } else {
                              await addAppToUser(app);
                            }
                          },
                          child: Center(
                            child: Text(
                              isOwned ? 'Open' : 'Get',
                              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                    color: isOwned
                                        ? Theme.of(context).colorScheme.primary
                                        : Theme.of(context).colorScheme.onPrimary,
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
          ],
        ),
      ),
    );
  }
}

// Custom painter for background pattern
class _PatternPainter extends CustomPainter {
  final Color color;

  _PatternPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    const spacing = 30.0;
    for (double i = 0; i < size.width + size.height; i += spacing) {
      canvas.drawLine(
        Offset(i, 0),
        Offset(0, i),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Enhanced AppData class with category support
class AppData {
  final String docId;
  final String url;
  final String name;
  final String desc;
  final String? iconPath;
  final bool useNetworkImage;
  final bool useNetworkAsset;
  final String? storageName;
  final Map<String, dynamic>? parameters;
  final String? ownerId;
  final AppCategory category;

  String? faviconUrl;
  Uint8List? _faviconBytes;
  bool _isLoading = false;
  int _retryCount = 0;
  Timer? _retryTimer;
  final int _maxRetries = 5;
  final _completer = Completer<Uint8List?>();
  bool? _isSvgFavicon;

  AppData({
    required this.docId,
    required this.url,
    required this.name,
    required this.desc,
    this.parameters,
    this.iconPath,
    this.storageName,
    this.useNetworkImage = true,
    this.useNetworkAsset = false,
    this.ownerId,
    this.category = AppCategory.tools,
  });

  bool get isSvgFavicon => _isSvgFavicon ?? false;

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'url': url,
      'desc': desc,
      'docId': docId,
      'useNetworkImage': useNetworkImage,
      'useNetworkAsset': useNetworkAsset,
      'storage_name': storageName,
      'parameters': parameters,
      'category': category.index,
      if (iconPath != null) 'iconPath': iconPath,
      if (ownerId != null) 'owner_id': ownerId
    };
  }

  factory AppData.fromJson(Map<String, dynamic> map) {
    return AppData(
      docId: map['docId'],
      url: map['url'],
      name: map['name'],
      desc: map['desc'],
      useNetworkAsset: map['useNetworkAsset'] ?? false,
      storageName: map['storage_name'],
      parameters: map['parameters'],
      iconPath: map.containsKey('iconPath') ? map['iconPath'] : null,
      ownerId: map.containsKey('ownerId') ? map['ownerId'] : null,
      category: map.containsKey('category') 
          ? AppCategory.values[map['category']] 
          : AppCategory.tools,
    );
  }

  Future<String> getUrl() async {
    final logger = Get.find<LoggerService>();

    if (parameters == null) {
      return url;
    } else {
      String finalUrl = url + "?";
      for (String paramKey in parameters!.keys) {
        if (parameters![paramKey] == "VAR") {
          if (paramKey == "address") {
            logger.i("Getting BTC Address");
            String? addr = await nextAddr(Auth().currentUser!.uid);
            if (addr == null) {
              logger.e("Failed to generate address");
              continue;
            }
            BitcoinAddress address = BitcoinAddress.fromJson({'addr': addr});
            finalUrl = finalUrl + "${paramKey}=${address.addr}&";
          }
        } else {
          finalUrl = finalUrl + "${paramKey}=${parameters![paramKey]}&";
        }
      }
      if (finalUrl.endsWith("&"))
        finalUrl = finalUrl.substring(0, finalUrl.length - 1);
      return finalUrl;
    }
  }

  Future<String> getFaviconUrl() async {
    if (faviconUrl != null) {
      return faviconUrl!;
    }
    try {
      String websiteUrl = url;
      if (!websiteUrl.startsWith('http')) {
        websiteUrl = 'https://$websiteUrl';
      }

      final response = await http.get(Uri.parse(websiteUrl));

      if (response.statusCode == 200) {
        final document = html.parse(response.body);
        final iconTags = document.querySelectorAll(
            'link[rel="icon"], link[rel="shortcut icon"], link[rel="apple-touch-icon"]');

        for (var tag in iconTags) {
          final iconUrl = tag.attributes['href'];
          if (iconUrl != null) {
            faviconUrl = Uri.parse(websiteUrl).resolve(iconUrl).toString();
            return faviconUrl!;
          }
        }
      }

      faviconUrl = '$websiteUrl/favicon.ico';
      return faviconUrl!;
    } catch (e) {
      print('Error fetching favicon: $e');
      return '';
    }
  }

  Future<Uint8List?> loadFaviconBytes() async {
    if (_faviconBytes != null) {
      return _faviconBytes;
    }

    if (_isLoading) {
      return _completer.future;
    }

    _isLoading = true;
    _loadAndRetryImage();
    return _completer.future;
  }

  void _loadAndRetryImage() async {
    try {
      final iconUrl = await getFaviconUrl();
      if (iconUrl.isEmpty) {
        if (!_completer.isCompleted) {
          _completer.complete(null);
        }
        _isLoading = false;
        return;
      }

      _isSvgFavicon = iconUrl.toLowerCase().endsWith('.svg');

      final response = await http.get(Uri.parse(iconUrl));

      if (response.statusCode == 200) {
        if (!_isSvgFavicon!) {
          final contentType = response.headers['content-type'] ?? '';
          _isSvgFavicon = contentType.contains('svg');
        }

        _faviconBytes = response.bodyBytes;
        if (!_completer.isCompleted) {
          _completer.complete(_faviconBytes);
        }
        _isLoading = false;
        _retryCount = 0;
        return;
      } else if (response.statusCode == 429) {
        _retryWithDelay(Duration(seconds: 10 * (_retryCount + 1)));
      } else {
        _retryWithDelay(Duration(seconds: 2 * (_retryCount + 1)));
      }
    } catch (e) {
      print('Error loading favicon image: $e');
      _retryWithDelay(Duration(seconds: 2 * (_retryCount + 1)));
    }
  }

  void _retryWithDelay(Duration delay) {
    if (_retryCount < _maxRetries) {
      _retryCount++;
      print(
          'Retrying favicon load (${_retryCount}/$_maxRetries) after ${delay.inSeconds}s');

      _retryTimer?.cancel();
      _retryTimer = Timer(delay, () {
        _loadAndRetryImage();
      });
    } else {
      print('Max retries reached for favicon from $url');
      if (!_completer.isCompleted) {
        _completer.complete(null);
      }
      _isLoading = false;
      _retryCount = 0;
    }
  }

  void dispose() {
    _retryTimer?.cancel();
  }
}

// Keep existing helper functions
Widget _buildImagePlaceholder({double size = 24.0}) {
  return Container(
    width: size,
    height: size,
    decoration: BoxDecoration(
      color: Colors.grey.withOpacity(0.2),
      shape: BoxShape.circle,
    ),
  );
}

// Keep existing AppImageBuilder widget
class AppImageBuilder extends StatelessWidget {
  const AppImageBuilder({
    super.key,
    required this.app,
    required this.width,
    required this.height,
  });

  final AppData app;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        height: width,
        width: height,
        child: Builder(
          builder: (context) {
            if (app.iconPath != null) {
              final String iconPath = app.iconPath!;
              if (iconPath.toLowerCase().endsWith('.svg')) {
                return SvgPicture.asset(
                  iconPath,
                  fit: BoxFit.contain,
                );
              } else {
                return Image.asset(
                  iconPath,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(Icons.apps_rounded, size: width);
                  },
                );
              }
            } else if (app.useNetworkAsset) {
              return FutureBuilder<String>(
                future: storageRef
                    .child("mini_app_icons/${app.storageName}")
                    .getDownloadURL(),
                builder: (context, snapshot) {
                  if (snapshot.hasData &&
                      snapshot.data != null &&
                      snapshot.data!.isNotEmpty) {
                    final String iconUrl = snapshot.data!;
                    final bool isSvg = iconUrl.toLowerCase().endsWith('.svg') ||
                        (app.isSvgFavicon);

                    if (isSvg) {
                      return SvgPicture.network(
                        iconUrl,
                        fit: BoxFit.fill,
                        placeholderBuilder: (BuildContext context) =>
                            _buildImagePlaceholder(size: 24.0),
                      );
                    } else {
                      return Image.network(
                        iconUrl,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(Icons.apps_rounded, size: width);
                        },
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return _buildImagePlaceholder(size: 24.0);
                        },
                      );
                    }
                  } else {
                    return _buildImagePlaceholder(size: 24.0);
                  }
                },
              );
            } else if (app.useNetworkImage) {
              return FutureBuilder<String>(
                future: app.getFaviconUrl(),
                builder: (context, snapshot) {
                  if (snapshot.hasData &&
                      snapshot.data != null &&
                      snapshot.data!.isNotEmpty) {
                    final String iconUrl = snapshot.data!;
                    final bool isSvg = iconUrl.toLowerCase().endsWith('.svg') ||
                        (app.isSvgFavicon);

                    if (isSvg) {
                      return SvgPicture.network(
                        iconUrl,
                        fit: BoxFit.fill,
                        placeholderBuilder: (BuildContext context) =>
                            _buildImagePlaceholder(size: 24.0),
                      );
                    } else {
                      return Image.network(
                        iconUrl,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(Icons.apps_rounded, size: width);
                        },
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return _buildImagePlaceholder(size: 24.0);
                        },
                      );
                    }
                  } else {
                    return _buildImagePlaceholder(size: 24.0);
                  }
                },
              );
            } else {
              return FutureBuilder<Uint8List?>(
                future: app.loadFaviconBytes(),
                builder:
                    (BuildContext context, AsyncSnapshot<Uint8List?> snapshot) {
                  if (snapshot.hasData && snapshot.data != null) {
                    if (app.isSvgFavicon) {
                      return SvgPicture.memory(
                        snapshot.data!,
                        fit: BoxFit.fill,
                      );
                    } else {
                      return Image.memory(
                        snapshot.data!,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(Icons.apps_rounded, size: width);
                        },
                      );
                    }
                  } else {
                    return _buildImagePlaceholder(size: 20.0);
                  }
                },
              );
            }
          },
        ),
      ),
    );
  }
}

Future<void> addAppToUser(AppData app) async {
  await Databaserefs.appsRef.doc(Auth().currentUser!.uid).set({
    'apps': FieldValue.arrayUnion([app.docId]),
  }, SetOptions(merge: true));
}

Future<List<AppData>> getAvailableApps() async {
  QuerySnapshot<Map<String, dynamic>> q =
      await Databaserefs.appsRef.doc("total_apps").collection("apps").get();

  return q.docs.map((doc) {
    // Determine category based on name or description
    AppCategory category = AppCategory.tools;
    final name = doc.data()['name']?.toLowerCase() ?? '';
    final desc = doc.data()['desc']?.toLowerCase() ?? '';
    
    if (name.contains('game') || desc.contains('game')) {
      category = AppCategory.games;
    } else if (name.contains('news') || desc.contains('news')) {
      category = AppCategory.news;
    } else if (name.contains('social') || desc.contains('social')) {
      category = AppCategory.social;
    } else if (name.contains('finance') || desc.contains('bitcoin') || desc.contains('lightning')) {
      category = AppCategory.finance;
    } else if (name.contains('shop') || desc.contains('buy')) {
      category = AppCategory.shopping;
    } else if (name.contains('learn') || desc.contains('education')) {
      category = AppCategory.education;
    }
    
    return AppData(
      docId: doc.id,
      url: doc.data()['url'],
      name: doc.data()['name'],
      desc: doc.data()['desc'],
      useNetworkAsset: doc.data()['useNetworkAsset'] ?? false,
      storageName: doc.data()['storage_name'],
      useNetworkImage: doc.data()['useNetworkImage'],
      parameters: doc.data().containsKey('parameters')
          ? doc.data()['parameters']
          : null,
      iconPath: doc.data().containsKey('iconPath')
          ? doc.data()['iconPath']
          : null,
      category: category,
    );
  }).toList();
}

Future<List<AppData>> getMyApps(List<AppData> availableApps) async {
  DocumentSnapshot<Map<String, dynamic>> doc =
      await Databaserefs.appsRef.doc(Auth().currentUser!.uid).get();
  if (doc.data() == null) {
    return [];
  }
  List appIds = doc.data()!['apps'];

  return availableApps.where((test) => appIds.contains(test.docId)).toList();
}