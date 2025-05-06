import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/models/marketplace/modals.dart';
import 'package:bitnet/pages/marketplace/listing_helper.dart';
import 'package:flutter/material.dart';

/// A reusable button component for listing NFT assets
/// Can be easily added to asset cards or profile items
class ListAssetButton extends StatelessWidget {
  final NFTAsset asset;
  final bool isSmall;
  final Color? backgroundColor;
  final Color? textColor;

  const ListAssetButton({
    Key? key,
    required this.asset,
    this.isSmall = false,
    this.backgroundColor,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Show the listing bottom sheet
        asset.showListingSheet(context);
      },
      borderRadius: BorderRadius.circular(isSmall ? 16 : 24),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: isSmall ? 12 : 16,
          vertical: isSmall ? 8 : 12,
        ),
        decoration: BoxDecoration(
          color: backgroundColor ?? Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(isSmall ? 16 : 24),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.sell_outlined,
              color: textColor ?? Colors.white,
              size: isSmall ? 16 : 20,
            ),
            SizedBox(width: isSmall ? 4 : 8),
            Text(
              "List",
              style: isSmall
                  ? Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: textColor ?? Colors.white,
                    )
                  : Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: textColor ?? Colors.white,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

/// A secondary version with different styling for profile pages
class ProfileListButton extends StatelessWidget {
  final NFTAsset asset;
  
  const ProfileListButton({
    Key? key,
    required this.asset,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          // Show the listing bottom sheet
          asset.showListingSheet(context);
        },
        borderRadius: BorderRadius.circular(AppTheme.borderRadiusMid),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppTheme.cardPadding,
            vertical: AppTheme.elementSpacing,
          ),
          decoration: BoxDecoration(
            border: Border.all(
              color: Theme.of(context).colorScheme.primary,
              width: 1.5,
            ),
            borderRadius: BorderRadius.circular(AppTheme.borderRadiusMid),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.sell_outlined,
                color: Theme.of(context).colorScheme.primary,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                "List for Sale",
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}