import 'dart:async';
import 'dart:typed_data';

import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/helper/helpers.dart';
import 'package:bitnet/components/appstandards/BitNetListTile.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/appstandards/fadelistviewwrapper.dart';
import 'package:bitnet/components/appstandards/glasscontainer.dart' hide GlassContainer;
import 'package:bitnet/components/container/imagewithtext.dart';
import 'package:bitnet/components/loaders/loaders.dart';
import 'package:bitnet/components/marketplace_widgets/CommonHeading.dart';
import 'package:bitnet/pages/routetrees/marketplaceroutes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
        fallbackIconPath: 'assets/images/bitcoin.png',
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
    // Preload all favicons in parallel as soon as the widget initializes
    print('WebsitesTab: Starting to load favicons for ${websites.length} websites');
    for (final website in websites) {
      website.loadFaviconBytes();
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
                    customShadow: isDarkMode ? [] : null,
                    borderRadius: BorderRadius.circular(AppTheme.borderRadiusMid),
                    child: Padding(
                      padding: EdgeInsets.all(AppTheme.cardPadding * 0.8),
                      child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Website logo and name
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: 48.h,
                              width: 48.h,
                              decoration: BoxDecoration(
                                color: Theme.of(context).brightness == Brightness.dark 
                                    ? Theme.of(context).colorScheme.surface.withOpacity(0.8)
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(12.r),
                                border: Border.all(
                                  color: Theme.of(context).colorScheme.outline.withOpacity(0.1),
                                  width: 1,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.05),
                                    blurRadius: 8,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              padding: const EdgeInsets.all(6),
                              child: Builder(
                                builder: (context) {
                                  // First priority: Use local asset if iconPath is provided
                                  if (website.iconPath != null) {
                                    final String iconPath = website.iconPath!;
                                    if (iconPath
                                        .toLowerCase()
                                        .endsWith('.svg')) {
                                      return ClipRRect(
                                        borderRadius: BorderRadius.circular(4),
                                        child: SvgPicture.asset(
                                          iconPath,
                                          fit: BoxFit.contain,
                                        ),
                                      );
                                    } else {
                                      return Image.asset(
                                        iconPath,
                                        fit: BoxFit.contain,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return Icon(Icons.public, size: 24,
                                              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5));
                                        },
                                      );
                                    }
                                  }

                                  // Second priority: Use fetched favicon bytes
                                  return StreamBuilder<Uint8List?>(
                                    stream: website.faviconBytesStream,
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData &&
                                          snapshot.data != null) {
                                        return ClipRRect(
                                          borderRadius: BorderRadius.circular(4),
                                          child: Image.memory(
                                            snapshot.data!,
                                            fit: BoxFit.contain,
                                            errorBuilder:
                                                (context, error, stackTrace) {
                                              return Icon(Icons.public,
                                                  size: 24,
                                                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5));
                                            },
                                          ),
                                        );
                                      } else {
                                        // Show fallback icon while loading or if no favicon
                                        if (website.fallbackIconPath != null) {
                                          return Image.asset(
                                            website.fallbackIconPath!,
                                            fit: BoxFit.contain,
                                            color: Theme.of(context).colorScheme.primary,
                                            errorBuilder: (context, error, stackTrace) {
                                              return Icon(Icons.public, size: 24,
                                                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5));
                                            },
                                          );
                                        }
                                        return Icon(Icons.public, size: 24,
                                            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5));
                                      }
                                    },
                                  );

                                  // Third priority: Use network image
                                  if (website.useNetworkImage &&
                                      website.iconPath != null) {
                                    return ClipRRect(
                                      borderRadius: BorderRadius.circular(4),
                                      child: Image.network(
                                        website.iconPath!,
                                        fit: BoxFit.contain,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return Icon(Icons.public, size: 24,
                                              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5));
                                        },
                                        loadingBuilder:
                                            (context, child, loadingProgress) {
                                          if (loadingProgress == null)
                                            return child;
                                          return _buildImagePlaceholder(size: 24.0);
                                        },
                                      ),
                                    );
                                  }

                                  // This should never be reached
                                  return Icon(Icons.public, size: 24,
                                      color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5));
                                },
                              ),
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
                          SizedBox(height: 12.h),
                          Text(
                            website.description!,
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.8),
                              height: 1.3,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],

                        // Banner image if available
                        if (website.bannerPath != null) ...[
                          SizedBox(height: 12.h),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8.r),
                            child: Image.asset(
                              website.bannerPath!,
                              height: 100.h,
                              width: double.infinity,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  height: 100.h,
                                  color: Theme.of(context).colorScheme.surface,
                                  child: Center(
                                    child: Icon(
                                      Icons.image_not_supported,
                                      color: Theme.of(context).colorScheme.onSurface.withOpacity(0.3),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ));
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
              customShadow: isDarkMode ? [] : null,
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
                        width: 40.w,
                        height: 40.h,
                        decoration: BoxDecoration(
                          color: Theme.of(context).brightness == Brightness.dark 
                              ? Theme.of(context).colorScheme.surface.withOpacity(0.8)
                              : Colors.white,
                          borderRadius: BorderRadius.circular(8.r),
                          border: Border.all(
                            color: Theme.of(context).colorScheme.outline.withOpacity(0.1),
                            width: 1,
                          ),
                        ),
                        padding: const EdgeInsets.all(8),
                        child: Builder(
                          builder: (context) {
                            // Use icon if provided
                            if (entry.iconPath != null) {
                              final String iconPath = entry.iconPath!;
                              if (iconPath.toLowerCase().endsWith('.svg')) {
                                return SvgPicture.asset(
                                  iconPath,
                                  fit: BoxFit.contain,
                                );
                              } else {
                                return Image.asset(
                                  iconPath,
                                  fit: BoxFit.contain,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Icon(Icons.public, size: 20);
                                  },
                                );
                              }
                            }

                            // Use fetched favicon - always use StreamBuilder for dynamic loading
                            return StreamBuilder<Uint8List?>(
                              stream: entry.faviconBytesStream,
                              builder: (context, snapshot) {
                                if (snapshot.hasData && snapshot.data != null) {
                                  return ClipRRect(
                                    borderRadius: BorderRadius.circular(4),
                                    child: Image.memory(
                                      snapshot.data!,
                                      fit: BoxFit.contain,
                                      errorBuilder: (context, error, stackTrace) {
                                        return Icon(Icons.public, size: 20,
                                            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5));
                                      },
                                    ),
                                  );
                                } else {
                                  // Show fallback icon while loading or if no favicon
                                  if (entry.fallbackIconPath != null) {
                                    return Image.asset(
                                      entry.fallbackIconPath!,
                                      fit: BoxFit.contain,
                                      color: Theme.of(context).colorScheme.primary,
                                      errorBuilder: (context, error, stackTrace) {
                                        return Icon(Icons.public, size: 20,
                                            color: Theme.of(context).colorScheme.primary.withOpacity(0.5));
                                      },
                                    );
                                  }
                                  return Icon(Icons.public, size: 20,
                                      color: Theme.of(context).colorScheme.primary.withOpacity(0.5));
                                }
                              },
                            );

                            // This should never be reached now
                            return Icon(Icons.public, size: 20,
                                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5));
                          },
                        ),
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
  Timer? _faviconTimer;

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

  Future<void> loadFaviconBytes() async {
    // Only fetch favicon if no iconPath is provided
    if (iconPath != null) return;
    
    // Debug print to track favicon loading
    print('Loading favicon for $name from $url');
    
    // Delay favicon loading to prevent overwhelming the network
    _faviconTimer = Timer(Duration(milliseconds: 100 + (name.hashCode % 500)), () async {
      try {
        // Extract domain from URL properly
        final Uri uri = Uri.parse(url);
        final domain = uri.host.isEmpty ? url : uri.host;
        
        // Try direct favicon first, then fall back to Google's service
        String faviconUrl;
        if (name == "BitreFill") {
          faviconUrl = 'https://www.bitrefill.com/favicon.ico';
        } else if (name == "Fold") {
          faviconUrl = 'https://foldapp.com/favicon.ico';
        } else {
          faviconUrl = 'https://www.google.com/s2/favicons?domain=$domain&sz=128';
        }
        print('Fetching favicon from: $faviconUrl');
        
        final response = await http.get(Uri.parse(faviconUrl));
        if (response.statusCode == 200 && response.bodyBytes.isNotEmpty) {
          faviconBytes = response.bodyBytes;
          _faviconBytesController.add(faviconBytes);
          print('Successfully loaded favicon for $name (${response.bodyBytes.length} bytes)');
        } else {
          print('Failed to load favicon for $name - Status: ${response.statusCode}');
          _faviconBytesController.add(null);
        }
      } catch (e) {
        print('Error loading favicon for $name: $e');
        // Still emit null to update the stream
        _faviconBytesController.add(null);
      }
    });
  }

  void dispose() {
    _faviconTimer?.cancel();
    _faviconBytesController.close();
  }
}