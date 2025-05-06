import 'package:bitnet/backbone/helper/marketplace_helpers/imageassets.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/container/imagewithtext.dart';
import 'package:bitnet/components/marketplace_widgets/OwnerDataText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:get/get.dart';

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
              "Description",
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            SizedBox(height: 8.h),
            GlassContainer(
              opacity: 0.1,
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ),
            SizedBox(height: 24.h),

            // Social Links Section
            Text(
              "Links",
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            SizedBox(height: 16.h),
            Wrap(
              spacing: 6.w,
              runSpacing: 12.h,
              children: [
                OwnerDataText(
                  ownerDataImg: discordIcon,
                  ownerDataTitle: 'Discord',
                  hasImage: true,
                  onTap: () {
                    // Open Discord link
                  },
                ),
                OwnerDataText(
                  ownerDataImg: twitterIcon,
                  ownerDataTitle: 'Twitter',
                  hasImage: true,
                  onTap: () {
                    // Open Twitter link
                  },
                ),
                OwnerDataText(
                  ownerDataImg: activityIcon,
                  ownerDataTitle: 'Website',
                  hasImage: true,
                  onTap: () {
                    // Open website
                  },
                ),
                OwnerDataText(
                  ownerDataImg: activityIcon,
                  ownerDataTitle: 'Ordinals Explorer',
                  hasImage: true,
                  onTap: () {
                    // Open Ordinals explorer
                  },
                ),
              ],
            ),
            SizedBox(height: 24.h),

            // Details Section
            Text(
              "Details",
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            SizedBox(height: 8.h),
            GlassContainer(
              opacity: 0.1,
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    _buildDetailRow(
                        context, "Contract Address", "bc1qwlcazq...k7mtl"),
                    SizedBox(height: 16.h),
                    _buildDetailRow(context, "Token Standard", "BRC-20"),
                    SizedBox(height: 16.h),
                    _buildDetailRow(context, "Creator Fee", "2.5%"),
                    SizedBox(height: 16.h),
                    _buildDetailRow(context, "Chain", "Bitcoin"),
                    SizedBox(height: 16.h),
                    _buildDetailRow(context, "Created", "April 2023"),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(BuildContext context, String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.titleSmall!.copyWith(
                fontWeight: FontWeight.w500,
                color: Theme.of(context).textTheme.bodySmall?.color,
              ),
        ),
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  overflow: TextOverflow.ellipsis,
                ),
          ),
        ),
      ],
    );
  }
}
