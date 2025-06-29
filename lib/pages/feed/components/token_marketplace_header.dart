import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/container/avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TokenMarketplaceHeader extends StatefulWidget {
  final Size size;
  final String tokenSymbol;
  final String tokenName;
  final String currentPrice;
  final String priceChange;
  final bool isPositive;

  const TokenMarketplaceHeader({
    Key? key,
    required this.size,
    required this.tokenSymbol,
    required this.tokenName,
    required this.currentPrice,
    required this.priceChange,
    required this.isPositive,
  }) : super(key: key);

  @override
  State<TokenMarketplaceHeader> createState() => _TokenMarketplaceHeaderState();
}

class _TokenMarketplaceHeaderState extends State<TokenMarketplaceHeader>
    with AutomaticKeepAliveClientMixin {
  String _getTokenImage() {
    switch (widget.tokenSymbol) {
      case 'GENST':
        return 'assets/tokens/genisisstone.webp';
      case 'HTDG':
        return 'assets/tokens/hotdog.webp';
      case 'LUMN':
        return 'assets/tokens/lumen.webp';
      case 'NBLA':
        return 'assets/tokens/nebula.webp';
      case 'QUSR':
        return 'assets/tokens/quasar.webp';
      case 'VRTX':
        return 'assets/tokens/vortex.webp';
      default:
        return 'assets/images/bitcoin.png';
    }
  }

  String _getTokenDescription() {
    switch (widget.tokenSymbol) {
      case 'GENST':
        return 'Genesis Stone - The foundational token of the BitNET ecosystem, representing the genesis of decentralized value creation.';
      case 'HTDG':
        return 'Hotdog Token - A community-driven meme token celebrating the spirit of fun and accessibility in the crypto space.';
      case 'LUMN':
        return 'Lumen - Illuminating the path to decentralized finance with stellar performance and bright prospects.';
      case 'NBLA':
        return 'Nebula - Expanding the boundaries of digital assets with cosmic potential and stellar rewards.';
      case 'QUSR':
        return 'Quasar - High-energy digital asset powering the next generation of decentralized applications.';
      case 'VRTX':
        return 'Vortex - Revolutionary token creating a whirlpool of innovation in the DeFi ecosystem.';
      default:
        return 'A revolutionary token on the BitNET platform, designed for the future of decentralized finance.';
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      padding: EdgeInsets.only(
          top: AppTheme.cardPadding.h, bottom: AppTheme.elementSpacing.h),
      child: Column(
        children: [
          // Header with token image and gradient background
          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.bottomCenter,
            children: [
              // Background banner with gradient
              Container(
                width: widget.size.width,
                height: 120.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(AppTheme.borderRadiusMid.r),
                    bottomRight: Radius.circular(AppTheme.borderRadiusMid.r),
                  ),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Theme.of(context).colorScheme.primary.withOpacity(0.15),
                      Theme.of(context).colorScheme.primary.withOpacity(0.05),
                    ],
                  ),
                ),
                child: Stack(
                  children: [
                    // Gradient overlay for better contrast
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft:
                                Radius.circular(AppTheme.borderRadiusMid.r),
                            bottomRight:
                                Radius.circular(AppTheme.borderRadiusMid.r),
                          ),
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .withOpacity(0.1),
                              Theme.of(context)
                                  .scaffoldBackgroundColor
                                  .withOpacity(0.7),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Token icon positioned at the bottom edge
              Positioned(
                bottom: -(AppTheme.cardPadding * 1.5),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      width: 3,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context)
                            .colorScheme
                            .shadow
                            .withOpacity(0.1),
                        blurRadius: 20,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Container(
                    width: AppTheme.cardPadding * 3,
                    height: AppTheme.cardPadding * 3,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      shape: BoxShape.circle,
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        _getTokenImage(),
                        fit: BoxFit.cover,
                        width: AppTheme.cardPadding * 3,
                        height: AppTheme.cardPadding * 3,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: AppTheme.cardPadding * 2),

          // Token info layout similar to collection header
          Container(
            padding: EdgeInsets.symmetric(horizontal: AppTheme.cardPadding.w),
            child: Column(
              children: [
                // Token name with modern styling
                Text(
                  widget.tokenName,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.5,
                      ),
                ),
                SizedBox(height: 4.h),

                // Token symbol
                Text(
                  widget.tokenSymbol,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withOpacity(0.7),
                        fontWeight: FontWeight.w500,
                      ),
                ),
                SizedBox(height: 12.h),

                // Price and change information
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '\$${widget.currentPrice}',
                      style:
                          Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: widget.isPositive
                                    ? AppTheme.successColor
                                    : AppTheme.errorColor,
                              ),
                    ),
                    SizedBox(width: 12.w),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 4.h,
                      ),
                      decoration: BoxDecoration(
                        color: (widget.isPositive
                                ? AppTheme.successColor
                                : AppTheme.errorColor)
                            .withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Text(
                        widget.priceChange,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: widget.isPositive
                                  ? AppTheme.successColor
                                  : AppTheme.errorColor,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),

                // Token description
                Container(
                  constraints: BoxConstraints(maxWidth: 300.w),
                  child: Text(
                    _getTokenDescription(),
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context)
                              .colorScheme
                              .onSurface
                              .withOpacity(0.6),
                          height: 1.5,
                          letterSpacing: 0.1,
                        ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
