import 'package:bitnet/backbone/helper/marketplace_helpers/imageassets.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/glasscontainer.dart';
import 'package:bitnet/components/marketplace_widgets/OwnerDataText.dart';
import 'package:bitnet/pages/marketplace/collection/owners_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bitnet/intl/generated/l10n.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class InfoTabView extends StatelessWidget {
  const InfoTabView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(
          horizontal: AppTheme.cardPadding.w, vertical: AppTheme.cardPadding.h),
      sliver: SliverList(
        delegate: SliverChildListDelegate.fixed(
          [
            // Description Section
            Text(
              "About",
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            SizedBox(height: AppTheme.elementSpacing.h),
            GlassContainer(
              boxShadow:
                  Theme.of(context).brightness == Brightness.dark ? [] : null,
              child: Padding(
                padding: EdgeInsets.all(AppTheme.cardPadding),
                child: Text(
                  'Bitcoin Punks is one of the first NFT collections on Bitcoin. A fixed set of 10,000 punks released in early 2023. They are 24x24 pixel art images inscribed on satoshis on the Bitcoin blockchain. The project pays homage to the original CryptoPunks while pioneering NFTs on Bitcoin through Ordinals.',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        height: 1.5,
                      ),
                ),
              ),
            ),
            SizedBox(height: AppTheme.cardPadding.h),

            // Collection Stats Section
            Text(
              "Collection Stats",
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            SizedBox(height: AppTheme.elementSpacing.h),
            GlassContainer(
              boxShadow:
                  Theme.of(context).brightness == Brightness.dark ? [] : null,
              child: Padding(
                padding: EdgeInsets.all(AppTheme.cardPadding.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildStatItem(context, 'Items', '10,000'),
                    _buildStatDivider(context),
                    _buildClickableStatItem(context, 'Owners', '2.4K', () {
                      // Navigate to owners screen
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => OwnersScreen(
                            collectionName: 'Bitcoin Punks', // Using demo data
                          ),
                        ),
                      );
                    }),
                    _buildStatDivider(context),
                    _buildStatItem(context, 'Floor', '0.24 BTC'),
                    _buildStatDivider(context),
                    _buildStatItem(context, 'Volume', '124 BTC'),
                  ],
                ),
              ),
            ),
            SizedBox(height: AppTheme.cardPadding.h),

            // Social Links Section
            Text(
              "Links & Socials",
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            SizedBox(height: AppTheme.elementSpacing.h),
            GlassContainer(
              boxShadow:
                  Theme.of(context).brightness == Brightness.dark ? [] : null,
              child: Column(
                children: [
                  _buildLinkTile(
                    context,
                    icon: FontAwesomeIcons.twitter,
                    title: 'Twitter',
                    subtitle: '@BitcoinPunks',
                    color: Color(0xFF1DA1F2),
                    onTap: () {},
                  ),
                  _buildLinkTile(
                    context,
                    icon: FontAwesomeIcons.discord,
                    title: 'Discord',
                    subtitle: 'Join our community',
                    color: Color(0xFF5865F2),
                    onTap: () {},
                  ),
                  _buildLinkTile(
                    context,
                    icon: FontAwesomeIcons.globe,
                    title: 'Website',
                    subtitle: 'bitcoinpunks.com',
                    color: Theme.of(context).colorScheme.primary,
                    onTap: () {},
                  ),
                  _buildLinkTile(
                    context,
                    icon: FontAwesomeIcons.magnifyingGlass,
                    title: 'Ordinals Explorer',
                    subtitle: 'View on chain',
                    color: AppTheme.colorBitcoin,
                    onTap: () {},
                    isLast: true,
                  ),
                ],
              ),
            ),
            SizedBox(height: AppTheme.cardPadding.h),

            // Details Section
            Text(
              "Collection Details",
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            SizedBox(height: AppTheme.elementSpacing.h),
            GlassContainer(
              boxShadow:
                  Theme.of(context).brightness == Brightness.dark ? [] : null,
              child: Padding(
                padding: EdgeInsets.all(AppTheme.cardPadding),
                child: Column(
                  children: [
                    _buildDetailRow(
                        context, "Contract Address", "bc1qwlcazq...k7mtl"),
                    _buildDetailDivider(context),
                    _buildDetailRow(context, "Token Standard", "Ordinals"),
                    _buildDetailDivider(context),
                    _buildDetailRow(context, "Creator Fee", "5.0%"),
                    _buildDetailDivider(context),
                    _buildDetailRow(context, "Blockchain", "Bitcoin"),
                    _buildDetailDivider(context),
                    _buildDetailRow(context, "Total Supply", "10,000"),
                    _buildDetailDivider(context),
                    _buildDetailRow(context, "Created", "January 2023"),
                  ],
                ),
              ),
            ),

            // Add some bottom padding
            SizedBox(height: AppTheme.cardPadding.h * 2),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(BuildContext context, String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        SizedBox(height: 4.h),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
              ),
        ),
      ],
    );
  }

  Widget _buildClickableStatItem(
      BuildContext context, String label, String value, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppTheme.borderRadiusSmall),
      child: Padding(
        padding: EdgeInsets.all(AppTheme.elementSpacing.w / 2),
        child: Column(
          children: [
            Text(
              value,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
            SizedBox(height: 4.h),
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatDivider(BuildContext context) {
    return Container(
      height: 32.h,
      width: 1,
      color: Theme.of(context).colorScheme.onSurface.withOpacity(0.1),
    );
  }

  Widget _buildDetailRow(BuildContext context, String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: AppTheme.elementSpacing.h / 2),
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
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                    overflow: TextOverflow.ellipsis,
                  ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailDivider(BuildContext context) {
    return Divider(
      height: 1,
      thickness: 1,
      color: Theme.of(context).colorScheme.outline.withOpacity(0.1),
    );
  }

  Widget _buildLinkTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
    bool isLast = false,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: isLast
          ? BorderRadius.only(
              bottomLeft: Radius.circular(AppTheme.borderRadiusMid - 1),
              bottomRight: Radius.circular(AppTheme.borderRadiusMid - 1),
            )
          : null,
      child: Padding(
        padding: EdgeInsets.all(AppTheme.cardPaddingSmall),
        child: Row(
          children: [
            Container(
              width: 44.w,
              height: 44.h,
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(
                icon,
                color: color,
                size: 20.w,
              ),
            ),
            SizedBox(width: AppTheme.elementSpacing.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  SizedBox(height: 2.h),
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
            Icon(
              Icons.arrow_forward_ios,
              size: 16.w,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.4),
            ),
          ],
        ),
      ),
    );
  }
}
