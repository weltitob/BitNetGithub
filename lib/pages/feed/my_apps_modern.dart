import 'package:bitnet/backbone/auth/auth.dart';
import 'package:bitnet/backbone/helper/databaserefs.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/appstandards/fadelistviewwrapper.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/pages/feed/appstab_modern.dart';
import 'package:bitnet/pages/routetrees/marketplaceroutes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class ModernMyAppsPage extends StatefulWidget {
  const ModernMyAppsPage({super.key, required this.routerState});
  final GoRouterState routerState;
  
  @override
  State<ModernMyAppsPage> createState() => _ModernMyAppsPageState();
}

class _ModernMyAppsPageState extends State<ModernMyAppsPage>
    with TickerProviderStateMixin {
  List<AppData> myApps = [];
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;
  String sortBy = 'name'; // 'name', 'recent', 'mostUsed'

  @override
  void initState() {
    super.initState();
    
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeInOut,
    );
    
    myApps = (widget.routerState.extra as List<Map<String, dynamic>>)
        .map((data) => AppData.fromJson(data))
        .toList();
    
    for (final app in myApps) {
      app.loadFaviconBytes();
    }
    
    _sortApps();
    _fadeController.forward();
  }

  void _sortApps() {
    switch (sortBy) {
      case 'name':
        myApps.sort((a, b) => a.name.compareTo(b.name));
        break;
      case 'recent':
        // In production, sort by last used timestamp
        myApps.shuffle(); // Simulate for demo
        break;
      case 'mostUsed':
        // In production, sort by usage count
        myApps.sort((a, b) => b.name.length.compareTo(a.name.length)); // Simulate
        break;
    }
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return bitnetScaffold(
      context: context,
      appBar: bitnetAppBar(
        context: context,
        text: "My Apps",
        actions: [
          PopupMenuButton<String>(
            icon: Icon(Icons.sort_rounded),
            onSelected: (value) {
              setState(() {
                sortBy = value;
                _sortApps();
              });
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'name',
                child: Row(
                  children: [
                    Icon(
                      Icons.sort_by_alpha_rounded,
                      size: 20.r,
                      color: sortBy == 'name'
                          ? Theme.of(context).colorScheme.primary
                          : null,
                    ),
                    SizedBox(width: 8.w),
                    Text('Name'),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'recent',
                child: Row(
                  children: [
                    Icon(
                      Icons.access_time_rounded,
                      size: 20.r,
                      color: sortBy == 'recent'
                          ? Theme.of(context).colorScheme.primary
                          : null,
                    ),
                    SizedBox(width: 8.w),
                    Text('Recently Used'),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'mostUsed',
                child: Row(
                  children: [
                    Icon(
                      Icons.trending_up_rounded,
                      size: 20.r,
                      color: sortBy == 'mostUsed'
                          ? Theme.of(context).colorScheme.primary
                          : null,
                    ),
                    SizedBox(width: 8.w),
                    Text('Most Used'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: Databaserefs.appsRef.doc(Auth().currentUser!.uid).snapshots(),
        builder: (context, snapshot) {
          List<String> ownedApps = [];
          if (snapshot.hasData && snapshot.data!.data() != null) {
            List? dataList = snapshot.data!.data()!['apps'] as List?;
            ownedApps = dataList?.map((item) => item as String).toList() ?? [];
          }
          
          return CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              // Stats Header
              SliverToBoxAdapter(
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: Container(
                    margin: EdgeInsets.all(AppTheme.cardPadding.r),
                    padding: EdgeInsets.all(AppTheme.cardPadding.r),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Theme.of(context).colorScheme.primary,
                          Theme.of(context).colorScheme.primary.withOpacity(0.8),
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildStatItem(
                          icon: Icons.apps_rounded,
                          value: myApps.length.toString(),
                          label: 'Total Apps',
                          color: Colors.white,
                        ),
                        Container(
                          height: 50.h,
                          width: 1,
                          color: Colors.white.withOpacity(0.3),
                        ),
                        _buildStatItem(
                          icon: Icons.storage_rounded,
                          value: '${(myApps.length * 2.5).toStringAsFixed(1)} MB',
                          label: 'Storage Used',
                          color: Colors.white,
                        ),
                        Container(
                          height: 50.h,
                          width: 1,
                          color: Colors.white.withOpacity(0.3),
                        ),
                        _buildStatItem(
                          icon: Icons.update_rounded,
                          value: '2',
                          label: 'Updates',
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Apps Grid
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: AppTheme.cardPadding.w),
                sliver: SliverGrid(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 0.8,
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
                              (index / myApps.length).clamp(0.0, 0.4),
                              ((index / myApps.length) + 0.1).clamp(0.0, 1.0),
                              curve: Curves.easeOut,
                            ),
                          )),
                          child: _buildAppItem(myApps[index], ownedApps),
                        ),
                      );
                    },
                    childCount: myApps.length,
                  ),
                ),
              ),

              // Bottom padding
              SliverToBoxAdapter(
                child: SizedBox(height: AppTheme.cardPadding.h * 2),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildStatItem({
    required IconData icon,
    required String value,
    required String label,
    required Color color,
  }) {
    return Column(
      children: [
        Icon(
          icon,
          color: color,
          size: 24.r,
        ),
        SizedBox(height: 4.h),
        Text(
          value,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: color,
              ),
        ),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: color.withOpacity(0.8),
              ),
        ),
      ],
    );
  }

  Widget _buildAppItem(AppData app, List<String> ownedApps) {
    final hasUpdate = app.name.length % 3 == 0; // Simulate some apps having updates
    
    return GestureDetector(
      onTap: () async {
        context.pushNamed(kWebViewScreenRoute, pathParameters: {
          'url': await app.getUrl(),
          'name': app.name,
        }, extra: {
          "is_app": true
        });
      },
      onLongPress: () {
        _showAppOptions(app);
      },
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                width: 80.w,
                height: 80.h,
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
                    width: 80.w,
                    height: 80.h,
                  ),
                ),
              ),
              // Update indicator
              if (hasUpdate)
                Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    width: 20.w,
                    height: 20.h,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.error,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Theme.of(context).colorScheme.surface,
                        width: 2,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        '1',
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                  ),
                ),
            ],
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
    );
  }

  void _showAppOptions(AppData app) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(AppTheme.borderRadiusMid.r),
            topRight: Radius.circular(AppTheme.borderRadiusMid.r),
          ),
        ),
        padding: EdgeInsets.all(AppTheme.cardPadding.r),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.2),
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            SizedBox(height: AppTheme.cardPadding.h),
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
                        style: Theme.of(context).textTheme.titleLarge,
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
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: AppTheme.cardPadding.h),
            Divider(),
            ListTile(
              leading: Icon(Icons.info_outline_rounded),
              title: Text('App Info'),
              onTap: () {
                Navigator.pop(context);
                context.go("/feed/" + kMyAppsPageRoute + "/" + kAppPageRoute,
                    extra: app.toJson());
              },
            ),
            ListTile(
              leading: Icon(Icons.delete_outline_rounded, color: Theme.of(context).colorScheme.error),
              title: Text('Remove App', style: TextStyle(color: Theme.of(context).colorScheme.error)),
              onTap: () async {
                Navigator.pop(context);
                _showRemoveConfirmation(app);
              },
            ),
            SizedBox(height: MediaQuery.of(context).padding.bottom),
          ],
        ),
      ),
    );
  }

  void _showRemoveConfirmation(AppData app) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Remove ${app.name}?'),
        content: Text('This app will be removed from your collection. You can add it again later from the Apps store.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              await _removeApp(app);
            },
            child: Text(
              'Remove',
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _removeApp(AppData app) async {
    await Databaserefs.appsRef.doc(Auth().currentUser!.uid).update({
      'apps': FieldValue.arrayRemove([app.docId]),
    });
    
    setState(() {
      myApps.removeWhere((a) => a.docId == app.docId);
    });
  }
}