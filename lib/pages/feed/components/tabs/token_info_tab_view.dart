import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/glasscontainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TokenInfoTabView extends StatelessWidget {
  final String tokenSymbol;
  final String tokenName;

  const TokenInfoTabView({
    Key? key,
    required this.tokenSymbol,
    required this.tokenName,
  }) : super(key: key);

  String _getTokenDescription() {
    switch (tokenSymbol) {
      case 'GENST':
        return 'Genesis Stone represents the foundational token of the BitNET ecosystem. Born from the primordial blockchain, GENST embodies the genesis of decentralized value creation. Each token carries the essence of digital scarcity and the promise of future innovation. Genesis Stone holders become part of the foundational community that shapes the future of decentralized finance on the BitNET platform.';
      case 'HTDG':
        return 'Hotdog Token brings the spirit of fun and community to the serious world of cryptocurrency. Created as a celebration of accessibility and humor in the crypto space, HTDG represents the belief that decentralized finance should be enjoyable and inclusive. With its playful nature and strong community focus, Hotdog Token proves that valuable digital assets can also bring joy and laughter to the ecosystem.';
      case 'LUMN':
        return 'Lumen illuminates the path to decentralized finance with stellar performance and bright prospects. Like light from distant stars, LUMN carries energy and information across the digital cosmos. This token represents clarity of vision and the illumination of new possibilities in the blockchain space. Lumen holders are the lightbearers of the new financial paradigm.';
      case 'NBLA':
        return 'Nebula expands the boundaries of digital assets with cosmic potential and stellar rewards. Born from the swirling cosmic dust of innovation, NBLA represents the birthplace of new digital worlds. Like astronomical nebulae that birth new stars, Nebula token creates new opportunities and value in the ever-expanding universe of decentralized finance.';
      case 'QUSR':
        return 'Quasar represents high-energy digital assets powering the next generation of decentralized applications. Like the most energetic objects in the universe, QUSR emits tremendous value and drives innovation forward. This token harnesses the power of cosmic forces to create unprecedented opportunities in the digital asset space, making it a beacon for advanced blockchain technology.';
      case 'VRTX':
        return 'Vortex creates a whirlpool of innovation in the DeFi ecosystem, drawing in new opportunities and spinning them into value. Like a cosmic vortex that bends space and time, VRTX warps the traditional financial landscape to create new paradigms. This revolutionary token generates momentum that pulls the entire ecosystem forward into uncharted territories of possibility.';
      default:
        return 'A revolutionary token on the BitNET platform, designed for the future of decentralized finance with innovative features and strong community support.';
    }
  }

  List<Map<String, String>> _getTokenFeatures() {
    switch (tokenSymbol) {
      case 'GENST':
        return [
          {
            'title': 'Foundational Asset',
            'description': 'Core token of the BitNET ecosystem'
          },
          {
            'title': 'Genesis Rights',
            'description': 'Early access to new platform features'
          },
          {
            'title': 'Governance Power',
            'description': 'Vote on important protocol decisions'
          },
          {
            'title': 'Staking Rewards',
            'description': 'Earn rewards by staking GENST tokens'
          },
        ];
      case 'HTDG':
        return [
          {
            'title': 'Community Driven',
            'description': 'Powered by active community participation'
          },
          {
            'title': 'Fun Utility',
            'description': 'Used in games and entertainment dApps'
          },
          {
            'title': 'Social Features',
            'description': 'Tip and reward community members'
          },
          {
            'title': 'Event Access',
            'description': 'Special access to community events'
          },
        ];
      case 'LUMN':
        return [
          {
            'title': 'High Performance',
            'description': 'Fast and efficient transactions'
          },
          {
            'title': 'DeFi Integration',
            'description': 'Compatible with major DeFi protocols'
          },
          {
            'title': 'Yield Farming',
            'description': 'Participate in liquidity mining programs'
          },
          {
            'title': 'Cross-Chain',
            'description': 'Multi-blockchain compatibility'
          },
        ];
      case 'NBLA':
        return [
          {
            'title': 'Expanding Utility',
            'description': 'Growing use cases and applications'
          },
          {
            'title': 'Innovation Hub',
            'description': 'Platform for experimental features'
          },
          {
            'title': 'Creator Economy',
            'description': 'Support for digital content creators'
          },
          {
            'title': 'NFT Integration',
            'description': 'Native support for NFT ecosystems'
          },
        ];
      case 'QUSR':
        return [
          {
            'title': 'High Energy',
            'description': 'Optimized for high-frequency trading'
          },
          {
            'title': 'Advanced Tech',
            'description': 'Cutting-edge blockchain technology'
          },
          {
            'title': 'Enterprise Focus',
            'description': 'Designed for institutional use'
          },
          {
            'title': 'Scalability',
            'description': 'Built to handle massive transaction volumes'
          },
        ];
      case 'VRTX':
        return [
          {
            'title': 'Revolutionary',
            'description': 'Paradigm-shifting token mechanics'
          },
          {
            'title': 'Innovation Driver',
            'description': 'Catalyst for ecosystem development'
          },
          {
            'title': 'Value Creation',
            'description': 'Generates value through unique mechanisms'
          },
          {
            'title': 'Future-Proof',
            'description': 'Designed for long-term sustainability'
          },
        ];
      default:
        return [
          {
            'title': 'Utility Token',
            'description': 'Multiple use cases within the ecosystem'
          },
          {
            'title': 'Decentralized',
            'description': 'Community-owned and operated'
          },
          {
            'title': 'Secure',
            'description': 'Built on proven blockchain technology'
          },
          {'title': 'Scalable', 'description': 'Designed for mass adoption'},
        ];
    }
  }

  Map<String, String> _getTokenStats() {
    switch (tokenSymbol) {
      case 'GENST':
        return {
          'Total Supply': '1,000,000 GENST',
          'Circulating Supply': '750,000 GENST',
          'Market Cap': '\$36.2M',
          'Launch Date': 'January 2024',
        };
      case 'HTDG':
        return {
          'Total Supply': '100,000,000 HTDG',
          'Circulating Supply': '85,000,000 HTDG',
          'Market Cap': '\$78.2K',
          'Launch Date': 'March 2024',
        };
      case 'LUMN':
        return {
          'Total Supply': '5,000,000 LUMN',
          'Circulating Supply': '3,200,000 LUMN',
          'Market Cap': '\$53.9M',
          'Launch Date': 'February 2024',
        };
      case 'NBLA':
        return {
          'Total Supply': '25,000,000 NBLA',
          'Circulating Supply': '18,500,000 NBLA',
          'Market Cap': '\$51.4M',
          'Launch Date': 'April 2024',
        };
      case 'QUSR':
        return {
          'Total Supply': '500,000 QUSR',
          'Circulating Supply': '350,000 QUSR',
          'Market Cap': '\$46.5M',
          'Launch Date': 'December 2023',
        };
      case 'VRTX':
        return {
          'Total Supply': '10,000,000 VRTX',
          'Circulating Supply': '7,200,000 VRTX',
          'Market Cap': '\$68.0M',
          'Launch Date': 'May 2024',
        };
      default:
        return {
          'Total Supply': 'TBD',
          'Circulating Supply': 'TBD',
          'Market Cap': 'TBD',
          'Launch Date': 'TBD',
        };
    }
  }

  @override
  Widget build(BuildContext context) {
    final features = _getTokenFeatures();
    final stats = _getTokenStats();

    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.all(AppTheme.cardPadding.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Description Section
                GlassContainer(
                  child: Padding(
                    padding: EdgeInsets.all(AppTheme.cardPadding.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'About $tokenName',
                          style:
                              Theme.of(context).textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        SizedBox(height: AppTheme.elementSpacing.h),
                        Text(
                          _getTokenDescription(),
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    height: 1.6,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurface
                                        .withOpacity(0.8),
                                  ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: AppTheme.cardPadding.h),

                // Features Section
                Text(
                  'Key Features',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),

                SizedBox(height: AppTheme.elementSpacing.h),

                ...features
                    .map((feature) => Container(
                          margin: EdgeInsets.only(
                              bottom: AppTheme.elementSpacing.h),
                          child: GlassContainer(
                            child: Padding(
                              padding: EdgeInsets.all(AppTheme.cardPadding.w),
                              child: Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(
                                        AppTheme.elementSpacing.w),
                                    decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary
                                          .withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(
                                          AppTheme.borderRadiusSmall.r),
                                    ),
                                    child: Icon(
                                      Icons.check_circle_outline,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      size: 20.sp,
                                    ),
                                  ),
                                  SizedBox(width: AppTheme.elementSpacing.w),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          feature['title']!,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium
                                              ?.copyWith(
                                                fontWeight: FontWeight.w600,
                                              ),
                                        ),
                                        Text(
                                          feature['description']!,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall
                                              ?.copyWith(
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
                            ),
                          ),
                        ))
                    .toList(),

                SizedBox(height: AppTheme.cardPadding.h),

                // Stats Section
                Text(
                  'Token Statistics',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),

                SizedBox(height: AppTheme.elementSpacing.h),

                GlassContainer(
                  child: Padding(
                    padding: EdgeInsets.all(AppTheme.cardPadding.w),
                    child: Column(
                      children: stats.entries
                          .map(
                            (entry) => Padding(
                              padding: EdgeInsets.symmetric(vertical: 8.h),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    entry.key,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSurface
                                              .withOpacity(0.7),
                                        ),
                                  ),
                                  Text(
                                    entry.value,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                          fontWeight: FontWeight.w600,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ),

                SizedBox(height: AppTheme.cardPadding.h),

                // Disclaimer
                GlassContainer(
                  child: Padding(
                    padding: EdgeInsets.all(AppTheme.cardPadding.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.info_outline,
                              color: AppTheme.colorBitcoin,
                              size: 20.sp,
                            ),
                            SizedBox(width: AppTheme.elementSpacing.w),
                            Text(
                              'Important Notice',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: AppTheme.colorBitcoin,
                                  ),
                            ),
                          ],
                        ),
                        SizedBox(height: AppTheme.elementSpacing.h),
                        Text(
                          'Token trading involves risk. Please do your own research and only invest what you can afford to lose. Past performance does not guarantee future results.',
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurface
                                        .withOpacity(0.7),
                                    height: 1.4,
                                  ),
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
}
