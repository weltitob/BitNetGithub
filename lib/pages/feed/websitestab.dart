import 'dart:async';
import 'dart:typed_data';

import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/helper/helpers.dart';
import 'package:bitnet/backbone/services/favicon_cache_service.dart';
import 'package:bitnet/components/appstandards/BitNetListTile.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/appstandards/fadelistviewwrapper.dart';
import 'package:bitnet/components/appstandards/glasscontainer.dart';
import 'package:bitnet/components/loaders/loaders.dart';
import 'package:bitnet/components/marketplace_widgets/CommonHeading.dart';
import 'package:bitnet/pages/routetrees/marketplaceroutes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as html;

class WebsitesTab extends StatefulWidget {
  const WebsitesTab({super.key});

  @override
  State<WebsitesTab> createState() => _WebsitesTabState();
}

class _WebsitesTabState extends State<WebsitesTab> 
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  
  late final FaviconCacheService _faviconCache;

  // Simple, non-animated placeholder for favicon/image loading
  // Much more efficient than animated progress indicators
  Widget _buildImagePlaceholder({double size = 24.0}) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.2),
        shape: BoxShape.circle,
      ),
    );
  }

  // Centralized icon building logic with performance optimizations
  Widget _buildWebsiteIcon(WebsiteData website, double size) {
    return RepaintBoundary(
      child: SizedBox(
        width: size,
        height: size,
        child: _buildIconContent(website, size),
      ),
    );
  }
  
  Widget _buildIconContent(WebsiteData website, double size) {
    // First priority: Use local asset if iconPath is provided
    if (website.iconPath != null) {
      final String iconPath = website.iconPath!;
      if (iconPath.toLowerCase().endsWith('.svg')) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: SvgPicture.asset(
            iconPath,
            fit: BoxFit.contain,
            width: size,
            height: size,
          ),
        );
      } else {
        return Image.asset(
          iconPath,
          fit: BoxFit.contain,
          width: size,
          height: size,
          cacheWidth: (size * 2).toInt(),
          cacheHeight: (size * 2).toInt(),
          errorBuilder: (context, error, stackTrace) {
            print('Error loading icon asset for ${website.name}: $error');
            return _buildFallbackIcon(website, size);
          },
        );
      }
    }

    // Second priority: Use fetched favicon bytes
    return StreamBuilder<Uint8List?>(
      stream: website.faviconBytesStream,
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: Image.memory(
              snapshot.data!,
              fit: BoxFit.contain,
              width: size,
              height: size,
              cacheWidth: (size * 2).toInt(),
              cacheHeight: (size * 2).toInt(),
              errorBuilder: (context, error, stackTrace) {
                return _buildFallbackIcon(website, size);
              },
            ),
          );
        } else {
          return _buildFallbackIcon(website, size);
        }
      },
    );
  }

  Widget _buildFallbackIcon(WebsiteData website, double size) {
    // Show fallback icon if defined
    if (website.fallbackIconPath != null) {
      return Image.asset(
        website.fallbackIconPath!,
        fit: BoxFit.contain,
        width: size,
        height: size,
        color: Theme.of(context).colorScheme.primary,
        errorBuilder: (context, error, stackTrace) {
          return _buildDefaultIcon(website, size);
        },
      );
    }
    // Use a more sophisticated default icon
    return _buildDefaultIcon(website, size);
  }
  
  Widget _buildDefaultIcon(WebsiteData website, double size) {
    // Create a colored container with the first letter of the website
    final Color backgroundColor = _getColorForWebsite(website.name);
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(size * 0.2),
      ),
      child: Center(
        child: Text(
          website.name.substring(0, 1).toUpperCase(),
          style: TextStyle(
            color: Colors.white,
            fontSize: size * 0.5,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
  
  Color _getColorForWebsite(String name) {
    // Generate a consistent color based on the website name
    final int hash = name.hashCode;
    final List<Color> colors = [
      AppTheme.colorBitcoin,
      Colors.blue,
      Colors.purple,
      Colors.green,
      Colors.orange,
      Colors.red,
      Colors.teal,
      Colors.indigo,
    ];
    return colors[hash.abs() % colors.length];
  }

  List<WebsiteData> websites = [
    WebsiteData(
        name: "BitreFill",
        url: "https://www.bitrefill.com",
        bannerPath: 'assets/images/bitrefill_banner.png',
        description: "Buy gift cards and mobile refills with Bitcoin and cryptocurrency"),
    WebsiteData(
        name: "Flipit",
        url: "https://flipittoken.eth.limo/",
        replaceColor: false,
        bannerPath: 'assets/images/flipit_banner.png',
        description: "Decentralized gaming platform built on Bitcoin"),
    WebsiteData(
        name: "Wavlake",
        url: "https://wavlake.com/",
        bannerPath: 'assets/images/wavlake_banner.png',
        description: "Stream music and support artists with Bitcoin payments"),
    WebsiteData(
        name: "Satoshi's Place",
        url: "https://satoshis.place/",
        description: "Collaborative pixel art canvas where you paint with satoshis"),
    WebsiteData(
        name: "Lnmarkets", 
        url: "https://lnmarkets.com",
        fallbackIconPath: 'assets/images/lightning.png',
        description: "Bitcoin derivatives trading platform using Lightning Network"),
    WebsiteData(
        name: "Fold", 
        url: "https://foldapp.com/",
        description: "Earn Bitcoin rewards when you shop at your favorite places"),
    WebsiteData(
        name: "The Bitcoin Company",
        url: "https://thebitcoincompany.com/",
        iconPath: 'assets/images/thebitcoincompany_logo.jpeg',
        description: "All-in-one Bitcoin app for daily Bitcoin use"),
    WebsiteData(
        name: "Azteco", 
        url: "https://azte.co/",
        fallbackIconPath: 'assets/images/bitcoin.png',
        description: "Buy Bitcoin vouchers to fund your wallet instantly"),
    WebsiteData(
        name: "Boltz", 
        url: "https://boltz.exchange/",
        fallbackIconPath: 'assets/images/lightning.png',
        description: "Non-custodial cryptocurrency exchange with Lightning support"),
    WebsiteData(
        name: "Geyser", 
        url: "https://geyser.fund/",
        fallbackIconPath: 'assets/images/bitcoin.png',
        description: "Fund open-source Bitcoin projects through crowdfunding"),
    WebsiteData(
        name: "Lightsats", 
        url: "https://lightsats.com/",
        fallbackIconPath: 'assets/images/lightning.png',
        description: "Send Bitcoin tips and onboard new users easily"),
    WebsiteData(
        name: "LN.PIZZA", 
        url: "https://ln.pizza/",
        fallbackIconPath: 'assets/images/lightning.png',
        description: "Order pizza with Bitcoin Lightning payments"),
    WebsiteData(
        name: "Sms4Sats", 
        url: "https://sms4sats.com/",
        fallbackIconPath: 'assets/images/lightning.png',
        description: "Get an SMS number with Bitcoin Lightning payments"),
    WebsiteData(
        name: "Lightning Roulette", 
        url: "https://lightning-roulette.com/",
        fallbackIconPath: 'assets/images/lightning.png',
        description: "Play roulette with Bitcoin Lightning Network"),
    WebsiteData(
        name: "Clinch", 
        url: "https://www.clinch.gg/",
        description: "E-sports platform with Bitcoin Lightning integration"),
  ];

  @override
  void initState() {
    super.initState();
    
    // Initialize favicon cache service
    _faviconCache = Get.find<FaviconCacheService>();
    
    // Load favicons using the cache service
    _loadFaviconsWithCache();
  }
  
  Future<void> _loadFaviconsWithCache() async {
    // First, load favicons for visible websites (first 4 in carousel)
    final visibleUrls = websites.take(4)
        .where((w) => w.iconPath == null)
        .map((w) => w.url)
        .toList();
    
    for (int i = 0; i < 4 && i < websites.length; i++) {
      final website = websites[i];
      if (website.iconPath == null) {
        _loadCachedFavicon(website);
      }
    }
    
    // Preload remaining favicons with a delay
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        final remainingUrls = websites.skip(4)
            .where((w) => w.iconPath == null)
            .map((w) => w.url)
            .toList();
        
        // Preload in background
        _faviconCache.preloadFavicons(remainingUrls);
        
        // Update UI for remaining websites
        for (int i = 4; i < websites.length; i++) {
          final website = websites[i];
          if (website.iconPath == null) {
            _loadCachedFavicon(website);
          }
        }
      }
    });
  }
  
  Future<void> _loadCachedFavicon(WebsiteData website) async {
    try {
      final bytes = await _faviconCache.getFavicon(website.url);
      if (bytes != null && mounted) {
        website.updateFaviconBytes(bytes);
      }
    } catch (e) {
      print('Error loading cached favicon for ${website.name}: $e');
    }
  }

  @override
  void dispose() {
    // Clean up any pending timers
    for (final website in websites) {
      website.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final Size size = MediaQuery.of(context).size;
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return bitnetScaffold(
      body: VerticalFadeListView.standardTab(
          child: ListView(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        children: [
          // Trending section
          SizedBox(height: AppTheme.cardPadding * 1.5.h),

          // Carousel Slider for Trending Websites
          CarouselSlider.builder(
            options: getStandardizedCarouselOptions(
              autoPlayIntervalSeconds: 5
            ),
            itemCount: 4,
            itemBuilder: (context, index, _) {
              final website = websites[index];

              return RepaintBoundary(
                child: GestureDetector(
                  onTap: () {
                    context.pushNamed(kWebViewScreenRoute,
                      pathParameters: {
                        'url': website.url,
                        'name': website.name,
                      },
                    );
                  },
                  child: GlassContainer(
                    width: getStandardizedCardWidth().w,
                    margin: EdgeInsets.symmetric(horizontal: getStandardizedCardMargin().w),
                    boxShadow: isDarkMode ? [] : null,
                    borderRadius: BorderRadius.circular(AppTheme.borderRadiusMid),
                    child: Stack(
                      children: [
                        // Main content with proper layout
                        Column(
                          children: [
                            // Header section with icon and text
                            Padding(
                              padding: EdgeInsets.all(AppTheme.cardPadding * 0.8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Website name and URL with icon
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      // Website icon (same style as in the list below)
                                      Container(
                                        width: 48.w,
                                        height: 48.h,
                                        decoration: BoxDecoration(
                                          color: Theme.of(context).brightness == Brightness.dark 
                                              ? Theme.of(context).colorScheme.surface.withOpacity(0.8)
                                              : Colors.white,
                                          borderRadius: BorderRadius.circular(10.r),
                                          border: Border.all(
                                            color: Theme.of(context).colorScheme.outline.withOpacity(0.1),
                                            width: 1,
                                          ),
                                        ),
                                        padding: const EdgeInsets.all(8),
                                        child: _buildWebsiteIcon(website, 32.0),
                                      ),
                                      SizedBox(width: 12.w),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              website.name,
                                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                                fontWeight: FontWeight.w600,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            SizedBox(height: 2.h),
                                            Text(
                                              website.url
                                                  .replaceAll('https://', '')
                                                  .replaceAll('http://', '')
                                                  .replaceAll('www.', '')
                                                  .split('/')[0],
                                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                                color: Theme.of(context).textTheme.bodySmall?.color?.withOpacity(0.6),
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  
                                  // Description
                                  if (website.description != null) ...[
                                    SizedBox(height: 8.h),
                                    Text(
                                      website.description!,
                                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                        color: Theme.of(context).textTheme.bodySmall?.color?.withOpacity(0.7),
                                        height: 1.15,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ],
                              ),
                            ),
                            
                            // Banner image takes remaining space
                            if (website.bannerPath != null)
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.all(AppTheme.elementSpacing * 0.75),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(AppTheme.borderRadiusSmall),
                                    child: Image.asset(
                                      website.bannerPath!,
                                      width: double.infinity,
                                      fit: BoxFit.contain,
                                      errorBuilder: (context, error, stackTrace) {
                                      return Container(
                                        color: Theme.of(context).colorScheme.surface,
                                        child: Center(
                                          child: Icon(
                                            Icons.image_not_supported,
                                            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.3),
                                            size: 40,
                                          ),
                                        ),
                                      );
                                    },
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                        
                      ],
                    ),
                  ),
                ),
              );
            },
          ),

          SizedBox(height: AppTheme.cardPadding * 1.5.h),

          // All websites section
          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppTheme.cardPadding.w),
            child: CommonHeading(
              headingText: "Websites",
              hasButton: false,
              onPress: '',
            ),
          ),

          // List of all websites in a single GlassContainer
          Padding(
            padding:
                EdgeInsets.symmetric(horizontal: AppTheme.cardPadding.w),
            child: GlassContainer(
              boxShadow: isDarkMode ? [] : null,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: AppTheme.elementSpacing * 0.5),
                child: Column(
                  children: websites.map<Widget>((entry) {
                    return BitNetListTile(
                      onTap: () {
                        context.pushNamed(kWebViewScreenRoute,
                          pathParameters: {
                            'url': entry.url,
                            'name': entry.name,
                          },
                        );
                      },
                      text: entry.name,
                      titleStyle: Theme.of(context).textTheme.titleSmall,
                      subtitle: entry.description != null
                          ? Text(
                              entry.description!,
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: Theme.of(context).textTheme.bodySmall?.color?.withOpacity(0.7),
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            )
                          : null,
                      leading: Container(
                        width: 52.w,
                        height: 52.h,
                        decoration: BoxDecoration(
                          color: Theme.of(context).brightness == Brightness.dark 
                              ? Theme.of(context).colorScheme.surface.withOpacity(0.8)
                              : Colors.white,
                          borderRadius: BorderRadius.circular(10.r),
                          border: Border.all(
                            color: Theme.of(context).colorScheme.outline.withOpacity(0.1),
                            width: 1,
                          ),
                        ),
                        padding: const EdgeInsets.all(10),
                        child: _buildWebsiteIcon(entry, 32.0),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),

          SizedBox(height: AppTheme.cardPadding * 2.h),
        ],
      )),
      context: context,
    );
  }
}

// WebsiteData model class
class WebsiteData {
  final String name;
  final String url;
  final String? iconPath;
  final String? fallbackIconPath;
  final String? bannerPath;
  final String? description;
  final bool useNetworkImage;
  final bool replaceColor;
  
  Uint8List? faviconBytes;
  final StreamController<Uint8List?> _faviconBytesController = StreamController<Uint8List?>.broadcast();
  Stream<Uint8List?> get faviconBytesStream => _faviconBytesController.stream;

  WebsiteData({
    required this.name,
    required this.url,
    this.iconPath,
    this.fallbackIconPath,
    this.bannerPath,
    this.description,
    this.useNetworkImage = false,
    this.replaceColor = true,
  });

  void updateFaviconBytes(Uint8List bytes) {
    faviconBytes = bytes;
    if (!_faviconBytesController.isClosed) {
      _faviconBytesController.add(faviconBytes);
    }
  }

  void dispose() {
    _faviconBytesController.close();
  }
}