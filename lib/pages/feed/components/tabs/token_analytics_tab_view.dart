import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/glasscontainer.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class TokenAnalyticsTabView extends StatelessWidget {
  final String tokenSymbol;
  final String tokenName;
  final Map<String, dynamic> tokenData;
  final Map<String, Map<String, dynamic>>? priceHistory;

  const TokenAnalyticsTabView({
    Key? key,
    required this.tokenSymbol,
    required this.tokenName,
    required this.tokenData,
    this.priceHistory,
  }) : super(key: key);

  Widget _buildAnalyticsCard(
    BuildContext context, {
    required String title,
    required String value,
    required String subtitle,
    required IconData icon,
    required Color iconColor,
  }) {
    return GlassContainer(
      child: Padding(
        padding: EdgeInsets.all(AppTheme.cardPadding.w),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(AppTheme.elementSpacing.w),
              decoration: BoxDecoration(
                color: iconColor.withOpacity(0.1),
                borderRadius:
                    BorderRadius.circular(AppTheme.borderRadiusSmall.r),
              ),
              child: Icon(
                icon,
                color: iconColor,
                size: 24.sp,
              ),
            ),
            SizedBox(width: AppTheme.elementSpacing.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context)
                              .colorScheme
                              .onSurface
                              .withOpacity(0.7),
                        ),
                  ),
                  Text(
                    value,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Text(
                    subtitle,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context)
                              .colorScheme
                              .onSurface
                              .withOpacity(0.6),
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

  Widget _buildChartNavigationCard(BuildContext context) {
    return GlassContainer(
      child: Padding(
        padding: EdgeInsets.all(AppTheme.cardPadding.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(AppTheme.elementSpacing.w),
                  decoration: BoxDecoration(
                    color:
                        Theme.of(context).colorScheme.primary.withOpacity(0.1),
                    borderRadius:
                        BorderRadius.circular(AppTheme.borderRadiusSmall.r),
                  ),
                  child: Icon(
                    Icons.show_chart,
                    color: Theme.of(context).colorScheme.primary,
                    size: 32.sp,
                  ),
                ),
                SizedBox(width: AppTheme.elementSpacing.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Price Chart Analysis',
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                      Text(
                        'View detailed price movements and trading data',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurface
                                  .withOpacity(0.7),
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: AppTheme.elementSpacing.h),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Access comprehensive charts with multiple timeframes, technical indicators, and trading volume analysis.',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context)
                              .colorScheme
                              .onSurface
                              .withOpacity(0.8),
                          height: 1.4,
                        ),
                  ),
                ),
              ],
            ),
            SizedBox(height: AppTheme.cardPadding.h),
            LongButtonWidget(
              buttonType: ButtonType.solid,
              title: 'Go to Chart',
              onTap: () {
                _navigateToChart(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToChart(BuildContext context) {
    final navigationData = {
      'isToken': true,
      'tokenSymbol': tokenSymbol,
      'tokenName': tokenName,
      'priceHistory': priceHistory,
      'currentPrice': tokenData['currentPrice'] is double
          ? tokenData['currentPrice']
          : tokenData['currentPrice'].toDouble(),
    };

    context.push(
      '/wallet/bitcoinscreen',
      extra: navigationData,
    );
  }

  String _calculateMonthlyVolume() {
    // Calculate or fetch monthly volume
    // This is a placeholder - replace with actual calculation from your data source
    final volumeData = tokenData['monthlyVolume'] ?? 125000;

    // Format the volume number
    if (volumeData >= 1000000) {
      return '${(volumeData / 1000000).toStringAsFixed(2)}M';
    } else if (volumeData >= 1000) {
      return '${(volumeData / 1000).toStringAsFixed(1)}K';
    } else {
      return volumeData.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentPrice = tokenData['currentPrice']?.toString() ?? '0';
    final floorPrice = tokenData['floorPrice']?.toString() ?? '0';
    final sellOffersCount = tokenData['sellOffers']?.length ?? 0;
    final buyOffersCount = tokenData['buyOffers']?.length ?? 0;

    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.all(AppTheme.cardPadding.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Chart Navigation Card
                _buildChartNavigationCard(context),

                SizedBox(height: AppTheme.cardPadding.h),

                Text(
                  'Market Statistics',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),

                SizedBox(height: AppTheme.elementSpacing.h),

                // Current Price
                _buildAnalyticsCard(
                  context,
                  title: 'Current Price',
                  value: '\$$currentPrice',
                  subtitle: 'Latest market price',
                  icon: Icons.attach_money,
                  iconColor: AppTheme.successColor,
                ),

                SizedBox(height: AppTheme.elementSpacing.h),

                // Floor Price
                _buildAnalyticsCard(
                  context,
                  title: 'Floor Price',
                  value: '\$$floorPrice',
                  subtitle: 'Lowest available price',
                  icon: Icons.trending_down,
                  iconColor: Theme.of(context).colorScheme.secondary,
                ),

                SizedBox(height: AppTheme.elementSpacing.h),

                // Market Activity
                _buildAnalyticsCard(
                  context,
                  title: 'Active Offers',
                  value: '$sellOffersCount',
                  subtitle: 'Tokens available for purchase',
                  icon: Icons.sell,
                  iconColor: Theme.of(context).colorScheme.primary,
                ),

                SizedBox(height: AppTheme.elementSpacing.h),

                // Monthly Volume
                _buildAnalyticsCard(
                  context,
                  title: 'Monthly Volume',
                  value: '\$${_calculateMonthlyVolume()}',
                  subtitle: 'Trading volume last 30 days',
                  icon: Icons.show_chart,
                  iconColor: AppTheme.colorBitcoin,
                ),

                SizedBox(height: AppTheme.cardPadding.h),

                // Market Information
                GlassContainer(
                  child: Padding(
                    padding: EdgeInsets.all(AppTheme.cardPadding.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Market Information',
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        SizedBox(height: AppTheme.elementSpacing.h),
                        _buildInfoRow(
                          context,
                          'Token Symbol',
                          tokenSymbol,
                        ),
                        _buildInfoRow(
                          context,
                          'Token Name',
                          tokenName,
                        ),
                        _buildInfoRow(
                          context,
                          'Market Status',
                          'Active',
                        ),
                        _buildInfoRow(
                          context,
                          'Trading Pairs',
                          '$tokenSymbol/USD',
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        // Bottom padding
        SliverToBoxAdapter(
          child: SizedBox(height: AppTheme.cardPadding.h * 2),
        ),
      ],
    );
  }

  Widget _buildInfoRow(BuildContext context, String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                ),
          ),
          Text(
            value,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
        ],
      ),
    );
  }
}
