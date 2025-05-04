import 'package:bitnet/backbone/helper/helpers.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/appstandards/fadelistviewwrapper.dart';
import 'package:bitnet/components/container/imagewithtext.dart';
import 'package:bitnet/components/items/number_indicator.dart';
import 'package:bitnet/components/marketplace_widgets/AssetCard.dart';
import 'package:bitnet/components/marketplace_widgets/CommonHeading.dart';
import 'package:bitnet/models/bitcoin/chartline.dart';
import 'package:bitnet/models/postmodels/media_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';

class AssetsTab extends StatefulWidget {
  const AssetsTab({super.key});

  @override
  State<AssetsTab> createState() => _AssetsTabState();
}

class _AssetsTabState extends State<AssetsTab> {
  // Sample asset data
  final List<Map<String, dynamic>> assetData = [
    {
      'name': 'Cosmic Perspective',
      'collection': 'Cosmic Series #42',
      'image': 'assets/marketplace/NftImage1.png',
      'price': '0.023',
      'owner': false,
      'color': AppTheme.colorBitcoin,
    },
    {
      'name': 'Digital Waves',
      'collection': 'Abstract Art #15',
      'image': 'assets/marketplace/NftImage2.png',
      'price': '0.045',
      'owner': false,
      'color': Colors.blue,
    },
    {
      'name': 'Pixel World',
      'collection': 'Pixel Series #05',
      'image': 'assets/marketplace/NftImage3.png',
      'price': '0.018',
      'owner': false,
      'color': Colors.purple,
    },
  ];

  // Top projects data
  final List<Map<String, dynamic>> topProjects = [
    {
      'id': 'project-001',
      'name': 'Mutant Apes',
      'collection': 'Mutant Ape Club',
      'image': 'assets/marketplace/NftImage4.png',
      'price': '0.089',
      'change': '+12.4%',
      'isPositive': true,
    },
    {
      'id': 'project-002',
      'name': 'Crypto Punks',
      'collection': 'Punk Collection',
      'image': 'assets/marketplace/NftImage5.png',
      'price': '0.152',
      'change': '+8.7%',
      'isPositive': true,
    },
    {
      'id': 'project-003',
      'name': 'Bored Apes',
      'collection': 'Bored Ape Club',
      'image': 'assets/marketplace/NftImage6.png',
      'price': '0.215',
      'change': '+6.2%',
      'isPositive': true,
    },
  ];

  // Trending projects data
  final List<Map<String, dynamic>> trendingProjects = [
    {
      'id': 'trending-001',
      'name': 'Ordinal Punks',
      'collection': 'Bitcoin Punks',
      'image': 'assets/marketplace/NftImage7.png',
      'price': '0.067',
      'change': '+25.8%',
      'isPositive': true,
    },
    {
      'id': 'trending-002',
      'name': 'Taproot Wizards',
      'collection': 'Magic Collection',
      'image': 'assets/marketplace/NftImage8.png',
      'price': '0.103',
      'change': '+19.2%',
      'isPositive': true,
    },
    {
      'id': 'trending-003',
      'name': 'Bitcoin Frens',
      'collection': 'Frens Club',
      'image': 'assets/marketplace/NftImage9.png',
      'price': '0.058',
      'change': '+14.7%',
      'isPositive': true,
    },
  ];

  // Featured collections data
  final List<Map<String, dynamic>> featuredCollections = [
    {
      'name': 'Abstract Masterpieces',
      'assets': [
        {
          'id': 'asset-001',
          'name': 'Cosmic Float',
          'collection': 'Abstract Masterpieces',
          'image': 'assets/marketplace/NftImage4.png',
          'price': '0.056',
          'owner': false,
        },
        {
          'id': 'asset-002',
          'name': 'Digital Wave',
          'collection': 'Abstract Masterpieces',
          'image': 'assets/marketplace/NftImage5.png',
          'price': '0.043',
          'owner': false,
        },
        {
          'id': 'asset-003',
          'name': 'Purple Haze',
          'collection': 'Abstract Masterpieces',
          'image': 'assets/marketplace/NftImage6.png',
          'price': '0.062',
          'owner': false,
        },
        {
          'id': 'asset-004',
          'name': 'Digital Sunrise',
          'collection': 'Abstract Masterpieces',
          'image': 'assets/marketplace/NftImage7.png',
          'price': '0.039',
          'owner': false,
        },
      ],
    },
    {
      'name': 'Digital Artworks',
      'assets': [
        {
          'id': 'asset-005',
          'name': 'Blue Cosmos',
          'collection': 'Digital Artworks',
          'image': 'assets/marketplace/NftImage8.png',
          'price': '0.095',
          'owner': true,
        },
        {
          'id': 'asset-006',
          'name': 'Quantum Reality',
          'collection': 'Digital Artworks',
          'image': 'assets/marketplace/NftImage9.png',
          'price': '0.076',
          'owner': true,
        },
        {
          'id': 'asset-007',
          'name': 'Pixel Plane',
          'collection': 'Digital Artworks',
          'image': 'assets/marketplace/NftImage10.png',
          'price': '0.068',
          'owner': true,
        },
        {
          'id': 'asset-008',
          'name': 'Infinite Dream',
          'collection': 'Digital Artworks',
          'image': 'assets/marketplace/NftImage11.png',
          'price': '0.082',
          'owner': true,
        },
      ],
    },
  ];

  // Top collections data
  final List<Map<String, dynamic>> topCollections = [
    {
      'name': 'Pixel Worlds',
      'assets': [
        {
          'id': 'asset-009',
          'name': 'Pixelated Landscape',
          'collection': 'Pixel Worlds',
          'image': 'assets/marketplace/NftImage12.png',
          'price': '0.042',
          'owner': false,
        },
        {
          'id': 'asset-010',
          'name': 'Digital Life',
          'collection': 'Pixel Worlds',
          'image': 'assets/marketplace/NftImage13.png',
          'price': '0.038',
          'owner': false,
        },
        {
          'id': 'asset-011',
          'name': 'Cubic Reality',
          'collection': 'Pixel Worlds',
          'image': 'assets/marketplace/NftImage14.png',
          'price': '0.027',
          'owner': false,
        },
        {
          'id': 'asset-012',
          'name': 'Pixel Universe',
          'collection': 'Pixel Worlds',
          'image': 'assets/marketplace/NftImage1.png',
          'price': '0.035',
          'owner': false,
        },
      ],
    },
  ];

  // Map to track like state for each asset
  final Map<String, bool> likeStates = {};

  @override
  void initState() {
    super.initState();

    // Initialize all featured collections' assets as unliked
    for (var collection in featuredCollections) {
      for (var asset in collection['assets']) {
        likeStates[asset['id']] = false;
      }
    }

    // Initialize all top collections' assets as unliked
    for (var collection in topCollections) {
      for (var asset in collection['assets']) {
        likeStates[asset['id']] = false;
      }
    }
  }

  // Toggle like state for a specific asset
  void toggleLike(String assetId) {
    setState(() {
      likeStates[assetId] = !(likeStates[assetId] ?? false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return bitnetScaffold(
      body: VerticalFadeListView.standardTab(
          child: ListView(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        cacheExtent: 1000, // Cache more content for smoother scrolling
        children: [
          // Spacing at the top - consistent with other tabs
          SizedBox(height: AppTheme.cardPadding * 1.5.h),

          // Carousel Slider for Trending Assets
          CarouselSlider.builder(
            options: getStandardizedCarouselOptions(autoPlayIntervalSeconds: 4),
            itemCount: assetData.length,
            itemBuilder: (context, index, _) {
              final asset = assetData[index];

              // Create media for asset
              final List<Media> assetMedia = [
                Media(
                  type: 'asset_image',
                  data: asset['image'],
                )
              ];

              // Wrap in RepaintBoundary for better performance
              return RepaintBoundary(
                child: AssetCard(
                  nftName: asset['name'],
                  nftMainName: asset['collection'],
                  cryptoText: asset['price'],
                  medias: assetMedia,
                  hasPrice: true,
                  hasLikeButton: true,
                  hasLiked: false,
                  postId: 'trending-$index',
                  scale: 1.0,
                ),
              );
            },
          ),

          SizedBox(height: AppTheme.cardPadding.h * 1.5),

          // Top Projects Today section with CommonHeading
          CommonHeading(
            headingText: '🏆 Top Projects Today',
            hasButton: true,
            onPress: 'top_projects',
          ),

          // A single GlassContainer containing all top projects with number indicators
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: AppTheme.cardPadding),
            child: GlassContainer(
              customShadow: isDarkMode ? [] : null,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: AppTheme.elementSpacing * 0.5),
                child: Column(
                  children: topProjects.asMap().entries.map((entry) {
                    final int idx = entry.key;
                    final project = entry.value;

                    return GestureDetector(
                      onTap: () {
                        // Navigate to the collection screen with the project's collection name
                        context.go(
                          '/feed/collection_screen_route/${project['collection']}',
                        );
                      },
                      child: Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: AppTheme.elementSpacing),
                            child: Container(
                              height: AppTheme.cardPadding * 2.75,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  // Project info (left side)
                                  Row(
                                    children: [
                                      Container(
                                        height: AppTheme.cardPadding * 1.75,
                                        width: AppTheme.cardPadding * 1.75,
                                        child: ClipOval(
                                          child: Image.asset(
                                            project['image'],
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                          width:
                                              AppTheme.elementSpacing.w / 1.5),
                                      Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            project['name'],
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleLarge,
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            project['collection'],
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall!
                                                .copyWith(
                                                  color: isDarkMode
                                                      ? AppTheme.white60
                                                      : AppTheme.black60,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),

                                  // Price and change (right side)
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "${project['price']} BTC",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .copyWith(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 2),
                                      Row(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 6,
                                              vertical: 2,
                                            ),
                                            decoration: BoxDecoration(
                                              color: project['isPositive']
                                                  ? AppTheme.successColor
                                                      .withOpacity(0.2)
                                                  : AppTheme.errorColor
                                                      .withOpacity(0.2),
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                            ),
                                            child: Text(
                                              project['change'],
                                              style: TextStyle(
                                                color: project['isPositive']
                                                    ? AppTheme.successColor
                                                    : AppTheme.errorColor,
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // Number indicator
                          Positioned(
                            left: 10,
                            top: 10,
                            child: NumberIndicator(number: idx + 1),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),

          SizedBox(height: AppTheme.cardPadding.h),

          // Trending section with CommonHeading
          CommonHeading(
            headingText: '🔥 Trending',
            hasButton: true,
            onPress: 'trending_projects',
          ),

          // A single GlassContainer containing all trending projects with number indicators
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: AppTheme.cardPadding),
            child: GlassContainer(
              customShadow: isDarkMode ? [] : null,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: AppTheme.elementSpacing * 0.5),
                child: Column(
                  children: trendingProjects.asMap().entries.map((entry) {
                    final int idx = entry.key;
                    final project = entry.value;

                    return GestureDetector(
                      onTap: () {
                        // Navigate to the collection screen with the project's collection name
                        context.go(
                          '/feed/collection_screen_route/${project['collection']}',
                        );
                      },
                      child: Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: AppTheme.elementSpacing),
                            child: Container(
                              height: AppTheme.cardPadding * 2.75,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  // Project info (left side)
                                  Row(
                                    children: [
                                      Container(
                                        height: AppTheme.cardPadding * 1.75,
                                        width: AppTheme.cardPadding * 1.75,
                                        child: ClipOval(
                                          child: Image.asset(
                                            project['image'],
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                          width:
                                              AppTheme.elementSpacing.w / 1.5),
                                      Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                project['name'],
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleLarge,
                                              ),
                                              SizedBox(width: 5),
                                              Icon(
                                                Icons.trending_up,
                                                color: Colors.orange,
                                                size: 16,
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            project['collection'],
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall!
                                                .copyWith(
                                                  color: isDarkMode
                                                      ? AppTheme.white60
                                                      : AppTheme.black60,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),

                                  // Price and change (right side)
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "${project['price']} BTC",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .copyWith(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 2),
                                      Row(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 6,
                                              vertical: 2,
                                            ),
                                            decoration: BoxDecoration(
                                              color: Colors.orange
                                                  .withOpacity(0.2),
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                            ),
                                            child: Text(
                                              project['change'],
                                              style: TextStyle(
                                                color: Colors.orange,
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // Standard number indicator for trending
                          Positioned(
                            left: 10,
                            top: 10,
                            child: NumberIndicator(
                              number: idx + 1,
                              size: 0.7,
                              showBorder: true,
                              useDarkVariant: true,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),

          SizedBox(height: AppTheme.cardPadding.h),

          // Featured Collections
          CommonHeading(
            headingText: '✨ Featured Collections',
            hasButton: true,
            onPress: 'featured_collections',
          ),

          // List of featured collections
          ...featuredCollections.map((collection) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Collection grid
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: AppTheme.elementSpacing.w / 2),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // 2 items per row
                      mainAxisSpacing: AppTheme.elementSpacing.h,
                      crossAxisSpacing: AppTheme.elementSpacing.w / 6,
                      childAspectRatio:
                          (size.width / 2) / 240.w, // Match TokensTab
                    ),
                    itemCount: collection['assets'].length,
                    itemBuilder: (context, index) {
                      final asset = collection['assets'][index];
                      final String assetId = asset['id'];

                      // Create media for asset
                      final List<Media> assetMedia = [
                        Media(
                          type: 'asset_image',
                          data: asset['image'],
                        )
                      ];

                      return AssetCard(
                        postId: assetId,
                        nftName: asset['name'],
                        nftMainName: asset['collection'],
                        cryptoText: asset['price'],
                        medias: assetMedia,
                        hasPrice: true,
                        hasLikeButton: true,
                        hasLiked: likeStates[assetId] ?? false,
                        hasListForSale: asset['owner'] ?? false,
                        isOwner: asset['owner'] ?? false,
                        onLikeChanged: (isLiked) {
                          setState(() {
                            likeStates[assetId] = isLiked;
                          });
                        },
                        scale: 0.75,
                      );
                    },
                  ),
                ),
                SizedBox(height: AppTheme.cardPadding.h),
              ],
            );
          }).toList(),

          // Top Collections
          CommonHeading(
            headingText: '🔝 Top Collections',
            hasButton: true,
            onPress: 'top_collections',
          ),

          // List of top collections
          ...topCollections.map((collection) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Collection grid
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: AppTheme.elementSpacing.w / 2),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // 2 items per row
                      mainAxisSpacing: AppTheme.elementSpacing.h,
                      crossAxisSpacing: AppTheme.elementSpacing.w / 6,
                      childAspectRatio:
                          (size.width / 2) / 240.w, // Match TokensTab
                    ),
                    itemCount: collection['assets'].length,
                    itemBuilder: (context, index) {
                      final asset = collection['assets'][index];
                      final String assetId = asset['id'];

                      // Create media for asset
                      final List<Media> assetMedia = [
                        Media(
                          type: 'asset_image',
                          data: asset['image'],
                        )
                      ];

                      return AssetCard(
                        postId: assetId,
                        nftName: asset['name'],
                        nftMainName: asset['collection'],
                        cryptoText: asset['price'],
                        medias: assetMedia,
                        hasPrice: true,
                        hasLikeButton: true,
                        hasLiked: likeStates[assetId] ?? false,
                        hasListForSale: asset['owner'] ?? false,
                        isOwner: asset['owner'] ?? false,
                        onLikeChanged: (isLiked) {
                          setState(() {
                            likeStates[assetId] = isLiked;
                          });
                        },
                        scale: 0.75,
                      );
                    },
                  ),
                ),
                SizedBox(height: AppTheme.cardPadding.h),
              ],
            );
          }).toList(),

          // Extra space at the bottom for better scrolling
          SizedBox(height: 100.h),
        ],
      )),
      context: context,
    );
  }
}
