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
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Description
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
          
          // Social Links
          Text(
            "Links",
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          SizedBox(height: 8.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const OwnerDataText(
                ownerDataImg: discordIcon,
                ownerDataTitle: 'Discord',
                hasImage: true,
              ),
              const OwnerDataText(
                ownerDataImg: twitterIcon,
                ownerDataTitle: 'Twitter',
                hasImage: true,
              ),
              GestureDetector(
                onTap: () {
                  // Navigate to activity screen
                },
                child: OwnerDataText(
                  ownerDataImg: activityIcon,
                  ownerDataTitle: L10n.of(context)!.activity,
                  hasImage: true,
                ),
              ),
            ],
          ),
          SizedBox(height: 24.h),
          
          // Details
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
                  _buildDetailRow(context, "Contract Address", "bc1qwlcazq...k7mtl"),
                  Divider(height: 24),
                  _buildDetailRow(context, "Token Standard", "BRC-20"),
                  Divider(height: 24),
                  _buildDetailRow(context, "Creator Fee", "2.5%"),
                  Divider(height: 24),
                  _buildDetailRow(context, "Chain", "Bitcoin"),
                  Divider(height: 24),
                  _buildDetailRow(context, "Created", "April 2023"),
                ],
              ),
            ),
          ),
        ],
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
                color: AppTheme.colorBitcoin,
              ),
        ),
        Text(
          value,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ],
    );
  }
}