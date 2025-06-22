import 'package:bitnet/backbone/auth/auth.dart';
import 'package:bitnet/backbone/helper/databaserefs.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/pages/feed/appstab.dart';
import 'package:bitnet/components/items/cached_app_image.dart';
import 'package:bitnet/pages/routetrees/marketplaceroutes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:get/get.dart';
import 'package:bitnet/components/dialogsandsheets/notificationoverlays/overlay.dart';

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
  double userRating = 0;
  double averageRating = 0;
  int totalRatings = 0;
  bool hasRated = false;
  int downloadCount = 0;
  // appSize entfernt - wird nicht mehr angezeigt
  String developerName = 'BitNET Community';
  
  @override
  void initState() {
    super.initState();
    checkOwnership();
    fetchRatings();
    fetchDownloadStats();
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
  
  Future<void> fetchRatings() async {
    try {
      final ratingsDoc = await FirebaseFirestore.instance
          .collection('app_ratings')
          .doc(widget.app.docId)
          .get();
      
      if (ratingsDoc.exists) {
        final data = ratingsDoc.data()!;
        averageRating = (data['average_rating'] ?? 0).toDouble();
        totalRatings = data['total_ratings'] ?? 0;
      }
      
      final userRatingDoc = await FirebaseFirestore.instance
          .collection('app_ratings')
          .doc(widget.app.docId)
          .collection('user_ratings')
          .doc(Auth().currentUser!.uid)
          .get();
      
      if (userRatingDoc.exists) {
        hasRated = true;
        userRating = (userRatingDoc.data()!['rating'] ?? 0).toDouble();
      }
      
      if (mounted) setState(() {});
    } catch (e) {
      print('Error fetching ratings: $e');
    }
  }
  
  Future<void> fetchDownloadStats() async {
    try {
      final statsDoc = await FirebaseFirestore.instance
          .collection('app_stats')
          .doc(widget.app.docId)
          .get();
      
      if (statsDoc.exists) {
        final data = statsDoc.data()!;
        downloadCount = data['download_count'] ?? 0;
      }
      
      if (mounted) setState(() {});
    } catch (e) {
      print('Error fetching download stats: $e');
    }
  }
  
  String _formatDownloadCount(int count) {
    if (count < 1000) return count.toString();
    if (count < 1000000) return '${(count / 1000).toStringAsFixed(1)}K';
    return '${(count / 1000000).toStringAsFixed(1)}M';
  }
  
  Future<void> submitRating(double rating) async {
    try {
      final userId = Auth().currentUser!.uid;
      final batch = FirebaseFirestore.instance.batch();
      
      final userRatingRef = FirebaseFirestore.instance
          .collection('app_ratings')
          .doc(widget.app.docId)
          .collection('user_ratings')
          .doc(userId);
      
      batch.set(userRatingRef, {
        'rating': rating,
        'timestamp': FieldValue.serverTimestamp(),
      });
      
      final appRatingRef = FirebaseFirestore.instance
          .collection('app_ratings')
          .doc(widget.app.docId);
      
      if (hasRated) {
        final newAverage = ((averageRating * totalRatings) - userRating + rating) / totalRatings;
        batch.update(appRatingRef, {
          'average_rating': newAverage,
          'last_updated': FieldValue.serverTimestamp(),
        });
      } else {
        final newTotal = totalRatings + 1;
        final newAverage = ((averageRating * totalRatings) + rating) / newTotal;
        batch.set(appRatingRef, {
          'average_rating': newAverage,
          'total_ratings': newTotal,
          'last_updated': FieldValue.serverTimestamp(),
        }, SetOptions(merge: true));
      }
      
      await batch.commit();
      
      userRating = rating;
      hasRated = true;
      await fetchRatings();
      
      if (mounted) {
        final overlayController = Get.find<OverlayController>();
        overlayController.showOverlay('Rating submitted successfully!');
      }
    } catch (e) {
      print('Error submitting rating: $e');
      if (mounted) {
        final overlayController = Get.find<OverlayController>();
        overlayController.showOverlay('Failed to submit rating', color: AppTheme.errorColor);
      }
    }
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
      body: Stack(
        children: [
          SingleChildScrollView(
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
                              child: CachedAppImage(
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
                          value: averageRating > 0 ? averageRating.toStringAsFixed(1) : 'N/A',
                          label: totalRatings > 0 ? '$totalRatings ratings' : 'No ratings',
                          isRating: true,
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: _buildStatCard(
                          context,
                          icon: Icons.download_rounded,
                          value: downloadCount > 0 ? _formatDownloadCount(downloadCount) : '0',
                          label: 'Downloads',
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
      // Bottom Button - BitNET Style
      Positioned(
        bottom: 0,
        left: 0,
        right: 0,
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: AppTheme.cardPadding.w,
            vertical: AppTheme.cardPadding.h,
          ),
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
            top: false,
            child: LongButtonWidget(
              title: appOwned ? 'Open' : 'Get',
              customWidth: double.infinity,
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
      ),
        ],
      ),
    );
  }
  
  Widget _buildStatCard(BuildContext context, {
    required IconData icon,
    required String value,
    required String label,
    bool isRating = false,
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
          if (isRating && appOwned) ...[
            // Zeige interaktive Sterne wenn User die App besitzt
            StarRating(
              rating: userRating,
              size: 24,
              onRatingChanged: (rating) {
                submitRating(rating);
              },
            ),
            SizedBox(height: 4.h),
          ] else
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
          if (isRating && !appOwned)
            Text(
              'Get app to rate',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 10.sp,
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

class StarRating extends StatelessWidget {
  final double rating;
  final double size;
  final Function(double)? onRatingChanged;
  final bool interactive;
  
  const StarRating({
    Key? key,
    required this.rating,
    this.size = 30,
    this.onRatingChanged,
    this.interactive = true,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        final starValue = index + 1;
        final filled = rating >= starValue;
        final halfFilled = rating > index && rating < starValue;
        
        return GestureDetector(
          onTap: interactive && onRatingChanged != null 
              ? () => onRatingChanged!(starValue.toDouble()) 
              : null,
          child: Icon(
            halfFilled ? Icons.star_half : Icons.star,
            size: size,
            color: filled || halfFilled 
                ? AppTheme.colorBitcoin 
                : Colors.grey.withOpacity(0.3),
          ),
        );
      }),
    );
  }
}