import 'dart:math' as math;
import 'package:bitnet/backbone/auth/auth.dart';
import 'package:bitnet/backbone/helper/databaserefs.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/loaders/loaders.dart';
import 'package:bitnet/pages/feed/appstab_modern.dart';
import 'package:bitnet/pages/routetrees/marketplaceroutes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';

class ModernAppDetailsPage extends StatefulWidget {
  const ModernAppDetailsPage({super.key, required this.routerState});
  final GoRouterState routerState;

  @override
  State<ModernAppDetailsPage> createState() => _ModernAppDetailsPageState();
}

class _ModernAppDetailsPageState extends State<ModernAppDetailsPage>
    with TickerProviderStateMixin {
  bool somethingFailed = false;
  bool loading = true;
  bool appOwned = false;
  bool buttonLoading = false;
  late AppData app;
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;
  late AnimationController _slideController;
  late Animation<Offset> _slideAnimation;

  // Mock data for demonstration
  final List<String> screenshots = [
    'https://picsum.photos/300/600?random=1',
    'https://picsum.photos/300/600?random=2',
    'https://picsum.photos/300/600?random=3',
  ];

  final List<Map<String, dynamic>> reviews = [
    {
      'name': 'John Doe',
      'rating': 5,
      'comment': 'Excellent app! Works perfectly with Bitcoin payments.',
      'date': '2 days ago',
    },
    {
      'name': 'Jane Smith',
      'rating': 4,
      'comment': 'Great features, but could use some UI improvements.',
      'date': '1 week ago',
    },
    {
      'name': 'Bitcoin User',
      'rating': 5,
      'comment': 'Love the Lightning Network integration!',
      'date': '2 weeks ago',
    },
  ];

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

    _slideController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOut,
    ));

    if (!(widget.routerState.extra is Map<String, dynamic>)) {
      somethingFailed = true;
    } else {
      app = AppData.fromJson(widget.routerState.extra as Map<String, dynamic>);
      app.loadFaviconBytes();
      Databaserefs.appsRef.doc(Auth().currentUser!.uid).get().then((val) {
        if (val.exists &&
            val.data() != null &&
            val.data()!['apps'] != null &&
            (val.data()!['apps'] as List).contains(app.docId)) {
          appOwned = true;
        }
        loading = false;
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) {
            setState(() {});
            _fadeController.forward();
            _slideController.forward();
          }
        });
      });
    }
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return bitnetScaffold(
      context: context,
      body: somethingFailed
          ? Center(
              child: Text("Something went wrong, please try again later."),
            )
          : loading
              ? Center(child: dotProgress(context))
              : CustomScrollView(
                  physics: const BouncingScrollPhysics(),
                  slivers: [
                    // Custom App Bar with Hero Image
                    SliverAppBar(
                      expandedHeight: 300.h,
                      pinned: true,
                      stretch: true,
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      flexibleSpace: FlexibleSpaceBar(
                        background: Stack(
                          fit: StackFit.expand,
                          children: [
                            // Gradient Background
                            Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Theme.of(context).colorScheme.primary,
                                    Theme.of(context).colorScheme.primary.withOpacity(0.7),
                                  ],
                                ),
                              ),
                            ),
                            // Pattern Overlay
                            CustomPaint(
                              painter: _PatternPainter(
                                color: Colors.white.withOpacity(0.1),
                              ),
                            ),
                            // Content
                            SafeArea(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  FadeTransition(
                                    opacity: _fadeAnimation,
                                    child: SlideTransition(
                                      position: _slideAnimation,
                                      child: Hero(
                                        tag: 'app-icon-${app.docId}',
                                        child: Container(
                                          width: 100.w,
                                          height: 100.h,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(AppTheme.borderRadiusMid.r),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black.withOpacity(0.2),
                                                blurRadius: 20,
                                                offset: Offset(0, 10),
                                              ),
                                            ],
                                          ),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(AppTheme.borderRadiusMid.r),
                                            child: AppImageBuilder(
                                              app: app,
                                              width: 100.w,
                                              height: 100.h,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: AppTheme.cardPadding.h),
                                  FadeTransition(
                                    opacity: _fadeAnimation,
                                    child: Text(
                                      app.name,
                                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                  ),
                                  SizedBox(height: 8.h),
                                  FadeTransition(
                                    opacity: _fadeAnimation,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: AppTheme.elementSpacing.w,
                                        vertical: 4.h,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(AppTheme.borderRadiusSmall.r),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            app.category.icon,
                                            size: 16.r,
                                            color: Colors.white,
                                          ),
                                          SizedBox(width: 4.w),
                                          Text(
                                            app.category.displayName,
                                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                                  color: Colors.white,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      leading: IconButton(
                        icon: Container(
                          padding: EdgeInsets.all(8.r),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.3),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.arrow_back_rounded,
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () => context.pop(),
                      ),
                      actions: [
                        IconButton(
                          icon: Container(
                            padding: EdgeInsets.all(8.r),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.3),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.share_rounded,
                              color: Colors.white,
                            ),
                          ),
                          onPressed: () {
                            Share.share("Check out ${app.name} on BitNET!");
                          },
                        ),
                      ],
                    ),

                    // App Info Section
                    SliverToBoxAdapter(
                      child: FadeTransition(
                        opacity: _fadeAnimation,
                        child: Padding(
                          padding: EdgeInsets.all(AppTheme.cardPadding.r),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Stats Row
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  _buildStatItem(
                                    icon: Icons.star_rounded,
                                    value: '4.${5 + (app.name.length % 5)}',
                                    label: 'Rating',
                                    color: Colors.amber,
                                  ),
                                  _buildStatItem(
                                    icon: Icons.download_rounded,
                                    value: '${1000 + (app.name.length * 100)}',
                                    label: 'Downloads',
                                  ),
                                  _buildStatItem(
                                    icon: Icons.code_rounded,
                                    value: '2.1.0',
                                    label: 'Version',
                                  ),
                                ],
                              ),
                              SizedBox(height: AppTheme.cardPadding.h),

                              // Description
                              Text(
                                'About this app',
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              SizedBox(height: AppTheme.elementSpacing.h),
                              Text(
                                app.desc,
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                      color: Theme.of(context).colorScheme.onSurface.withOpacity(0.8),
                                    ),
                              ),
                              SizedBox(height: AppTheme.cardPadding.h),

                              // Screenshots
                              Text(
                                'Screenshots',
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              SizedBox(height: AppTheme.elementSpacing.h),
                              SizedBox(
                                height: 200.h,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: screenshots.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: EdgeInsets.only(right: AppTheme.elementSpacing.w),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(AppTheme.borderRadiusSmall.r),
                                        child: Container(
                                          width: 100.w,
                                          color: Theme.of(context).colorScheme.surface,
                                          child: Center(
                                            child: Icon(
                                              Icons.image_rounded,
                                              size: 40.r,
                                              color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              SizedBox(height: AppTheme.cardPadding.h),

                              // Reviews
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Reviews',
                                    style: Theme.of(context).textTheme.titleLarge,
                                  ),
                                  TextButton(
                                    onPressed: () {},
                                    child: Text('See all'),
                                  ),
                                ],
                              ),
                              SizedBox(height: AppTheme.elementSpacing.h),
                              ...reviews.map((review) => _buildReviewCard(review)),

                              SizedBox(height: AppTheme.cardPadding.h * 2),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
      bottomNavigationBar: somethingFailed || loading
          ? null
          : Container(
              padding: EdgeInsets.all(AppTheme.cardPadding.r),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: Offset(0, -5),
                  ),
                ],
              ),
              child: SafeArea(
                child: Row(
                  children: [
                    // Price/Status
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            appOwned ? 'Installed' : 'Free',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                                ),
                          ),
                          if (appOwned)
                            Text(
                              'Last updated 3 days ago',
                              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
                                  ),
                            ),
                        ],
                      ),
                    ),
                    // Action Button
                    LongButtonWidget(
                      customWidth: 120.w,
                      title: appOwned ? 'Open' : 'Install',
                      state: buttonLoading ? ButtonState.loading : ButtonState.idle,
                      onTap: () async {
                        if (appOwned) {
                          buttonLoading = true;
                          setState(() {});
                          context.pushNamed(kWebViewScreenRoute, pathParameters: {
                            'url': await app.getUrl(),
                            'name': app.name,
                          }, extra: {
                            "is_app": true
                          });
                          buttonLoading = false;
                          if (context.mounted) {
                            setState(() {});
                          }
                        } else {
                          buttonLoading = true;
                          setState(() {});
                          await addAppToUser(app);
                          appOwned = true;
                          buttonLoading = false;
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            setState(() {});
                          });
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildStatItem({
    required IconData icon,
    required String value,
    required String label,
    Color? color,
  }) {
    return Column(
      children: [
        Icon(
          icon,
          color: color ?? Theme.of(context).colorScheme.primary,
          size: 24.r,
        ),
        SizedBox(height: 4.h),
        Text(
          value,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
              ),
        ),
      ],
    );
  }

  Widget _buildReviewCard(Map<String, dynamic> review) {
    return Container(
      margin: EdgeInsets.only(bottom: AppTheme.elementSpacing.h),
      padding: EdgeInsets.all(AppTheme.elementSpacing.r),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(AppTheme.borderRadiusSmall.r),
        border: Border.all(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 16.r,
                backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                child: Text(
                  review['name'].split(' ').map((e) => e[0]).join(),
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      review['name'],
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    Row(
                      children: [
                        ...List.generate(
                          5,
                          (index) => Icon(
                            index < review['rating']
                                ? Icons.star_rounded
                                : Icons.star_border_rounded,
                            size: 12.r,
                            color: Colors.amber,
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          review['date'],
                          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
                              ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            review['comment'],
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}

// Pattern painter for background
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