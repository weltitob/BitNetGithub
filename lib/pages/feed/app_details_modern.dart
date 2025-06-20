import 'package:bitnet/backbone/auth/auth.dart';
import 'package:bitnet/backbone/helper/databaserefs.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/pages/feed/appstab.dart';
import 'package:bitnet/pages/routetrees/marketplaceroutes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class AppDetailsModern extends StatefulWidget {
  final AppData app;
  
  const AppDetailsModern({
    Key? key,
    required this.app,
  }) : super(key: key);

  @override
  State<AppDetailsModern> createState() => _AppDetailsModernState();
}

class _AppDetailsModernState extends State<AppDetailsModern> {
  bool loading = true;
  bool appOwned = false;
  bool buttonLoading = false;
  
  @override
  void initState() {
    super.initState();
    checkOwnership();
  }
  
  Future<void> checkOwnership() async {
    final doc = await Databaserefs.appsRef.doc(Auth().currentUser!.uid).get();
    if (doc.exists && doc.data() != null && doc.data()!['apps'] != null) {
      List appIds = doc.data()!['apps'] as List;
      appOwned = appIds.contains(widget.app.docId);
    }
    loading = false;
    if (mounted) setState(() {});
  }
  
  @override
  Widget build(BuildContext context) {
    return bitnetScaffold(
      context: context,
      appBar: bitnetAppBar(
        context: context,
        text: "",
      ),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero Header
            Container(
              height: 300.h,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Theme.of(context).colorScheme.primary.withOpacity(0.8),
                    Theme.of(context).colorScheme.primary.withOpacity(0.4),
                  ],
                ),
              ),
              child: Stack(
                children: [
                  // Pattern overlay
                  Positioned.fill(
                    child: CustomPaint(
                      painter: PatternPainter(
                        color: Colors.white.withOpacity(0.05),
                      ),
                    ),
                  ),
                  // Content
                  SafeArea(
                    child: Padding(
                      padding: EdgeInsets.all(AppTheme.cardPadding.w),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // App Icon
                          Container(
                            width: 100.w,
                            height: 100.h,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(24.r),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 20,
                                  offset: Offset(0, 10),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(24.r),
                              child: AppImageBuilder(
                                app: widget.app,
                                width: 80.w,
                                height: 80.h,
                              ),
                            ),
                          ),
                          SizedBox(height: 20.h),
                          // App Name
                          Text(
                            widget.app.name,
                            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          // App Developer
                          Text(
                            'BitNET Community',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.white.withOpacity(0.8),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            // App Info Cards
            Padding(
              padding: EdgeInsets.all(AppTheme.cardPadding.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Stats Row
                  Row(
                    children: [
                      Expanded(
                        child: _buildStatCard(
                          context,
                          icon: Icons.star_rounded,
                          value: '4.8',
                          label: 'Rating',
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: _buildStatCard(
                          context,
                          icon: Icons.download_rounded,
                          value: '10K+',
                          label: 'Downloads',
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: _buildStatCard(
                          context,
                          icon: Icons.code_rounded,
                          value: '2.3MB',
                          label: 'Size',
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: 24.h),
                  
                  // Description
                  Text(
                    'About this app',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(height: 12.h),
                  Container(
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(16.r),
                      border: Border.all(
                        color: Theme.of(context).colorScheme.outline.withOpacity(0.1),
                      ),
                    ),
                    child: Text(
                      widget.app.desc,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        height: 1.5,
                      ),
                    ),
                  ),
                  
                  SizedBox(height: 24.h),
                  
                  // Features
                  Text(
                    'Features',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(height: 12.h),
                  _buildFeatureItem(context, Icons.flash_on, 'Lightning fast transactions'),
                  _buildFeatureItem(context, Icons.security, 'Secure and private'),
                  _buildFeatureItem(context, Icons.cloud_off, 'Works offline'),
                  _buildFeatureItem(context, Icons.language, 'Multi-language support'),
                  
                  SizedBox(height: 100.h), // Space for bottom button
                ],
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        padding: EdgeInsets.all(AppTheme.cardPadding.w),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: Offset(0, -5),
            ),
          ],
        ),
        child: SafeArea(
          child: LongButtonWidget(
            title: appOwned ? 'Open' : 'Get',
            state: buttonLoading ? ButtonState.loading : ButtonState.idle,
            onTap: () async {
              if (appOwned) {
                buttonLoading = true;
                setState(() {});
                
                final url = await widget.app.getUrl();
                context.pushNamed(kWebViewScreenRoute,
                  pathParameters: {
                    'url': url,
                    'name': widget.app.name,
                  },
                  extra: {'is_app': true}
                );
                
                buttonLoading = false;
                if (mounted) setState(() {});
              } else {
                buttonLoading = true;
                setState(() {});
                
                await addAppToUser(widget.app);
                appOwned = true;
                
                buttonLoading = false;
                if (mounted) setState(() {});
              }
            },
          ),
        ),
      ),
    );
  }
  
  Widget _buildStatCard(BuildContext context, {
    required IconData icon,
    required String value,
    required String label,
  }) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withOpacity(0.1),
        ),
      ),
      child: Column(
        children: [
          Icon(icon, color: Theme.of(context).colorScheme.primary),
          SizedBox(height: 8.h),
          Text(
            value,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildFeatureItem(BuildContext context, IconData icon, String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        children: [
          Container(
            width: 40.w,
            height: 40.h,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(
              icon,
              size: 20,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          SizedBox(width: 12.w),
          Text(
            text,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}

// Pattern painter for background
class PatternPainter extends CustomPainter {
  final Color color;
  
  PatternPainter({required this.color});
  
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    
    final spacing = 30.0;
    final radius = 2.0;
    
    for (double x = 0; x < size.width; x += spacing) {
      for (double y = 0; y < size.height; y += spacing) {
        canvas.drawCircle(Offset(x, y), radius, paint);
      }
    }
  }
  
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}