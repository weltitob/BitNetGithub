import 'dart:async';
import 'dart:typed_data';

import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/helper/helpers.dart';
import 'package:bitnet/components/appstandards/BitNetListTile.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/appstandards/fadelistviewwrapper.dart';
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

class _WebsitesTabState extends State<WebsitesTab> {
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
        name: "Lnmarkets", 
        url: "https://lnmarkets.com",
        description: "Bitcoin derivatives trading platform using Lightning Network"),
    WebsiteData(
        name: "Fold", 
        url: "https://foldapp.com/",
        description: "Earn Bitcoin rewards when you shop at your favorite places"),
    WebsiteData(
        name: "The Bitcoin Company",
        url: "https://thebitcoincompany.com/",
        iconPath: 'assets/images/thebitcoincompany_logo.jpeg',
        useNetworkImage: true,
        description: "All-in-one Bitcoin app for daily Bitcoin use"),
    WebsiteData(
        name: "Azteco", 
        url: "https://azte.co/",
        description: "Buy Bitcoin vouchers to fund your wallet instantly"),
    WebsiteData(
        name: "Boltz", 
        url: "https://boltz.exchange/",
        description: "Non-custodial cryptocurrency exchange with Lightning support"),
    WebsiteData(
        name: "Geyser", 
        url: "https://geyser.fund/",
        description: "Fund open-source Bitcoin projects through crowdfunding"),
    WebsiteData(
        name: "Lightsats", 
        url: "https://lightsats.com/",
        description: "Send Bitcoin tips and onboard new users easily"),
    WebsiteData(
        name: "LN.PIZZA", 
        url: "https://ln.pizza/",
        description: "Order pizza with Bitcoin Lightning payments"),
    WebsiteData(
        name: "Sms4Sats", 
        url: "https://sms4sats.com/",
        description: "Get an SMS number with Bitcoin Lightning payments"),
    WebsiteData(
        name: "Lightning Roulette", 
        url: "https://lightning-roulette.com/",
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

          // Carousel Slider for Trending Tokens

          CarouselSlider.builder(
            options: getStandardizedCarouselOptions(
              autoPlayIntervalSeconds: 5
            ),
            itemCount: 3,
            itemBuilder: (context, index, _) {
              final website = websites[index];

              return RepaintBoundary(
                child: GestureDetector(
                  onTap: () {
                    context.pushNamed(kWebViewScreenRoute, pathParameters: {
                      'url': website.url,
                      'name': website.name
                    });
                  },
                  child: GlassContainer(
                  width: getStandardizedCardWidth().w,
                  margin: EdgeInsets.symmetric(horizontal: getStandardizedCardMargin().w),
                  customShadow: isDarkMode ? [] : null,
                  borderRadius:AppTheme.cardRadiusMid.r,
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
                                color: Theme.of(context).colorScheme.surface,
                                borderRadius: BorderRadius.circular(12.r),
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
                                      return Container(
                                        color: Colors.white,
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
                                          return Icon(Icons.public, size: 24);
                                        },
                                      );
                                    }
                                  }
                                  // Second priority: Use network image if useNetworkImage is true
                                  else if (website.useNetworkImage) {
                                    // Use network image directly if useNetworkImage is true
                                    return FutureBuilder<String>(
                                      future: website.getFaviconUrl(),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData &&
                                            snapshot.data != null &&
                                            snapshot.data!.isNotEmpty) {
                                          final String iconUrl =
                                              snapshot.data!;
                                          final bool isSvg = iconUrl
                                                  .toLowerCase()
                                                  .endsWith('.svg') ||
                                              (website.isSvgFavicon);

                                          if (isSvg) {
                                            return SvgPicture.network(
                                              iconUrl,
                                              fit: BoxFit.fill,
                                              placeholderBuilder:
                                                  (BuildContext context) =>
                                                      dotProgress(context),
                                            );
                                          } else {
                                            return Image.network(
                                              iconUrl,
                                              fit: BoxFit.contain,
                                              errorBuilder: (context, error,
                                                  stackTrace) {
                                                return Icon(Icons.public,
                                                    size: 24);
                                              },
                                              loadingBuilder: (context, child,
                                                  loadingProgress) {
                                                if (loadingProgress == null)
                                                  return child;
                                                return dotProgress(context);
                                              },
                                            );
                                          }
                                        } else {
                                          return dotProgress(context);
                                        }
                                      },
                                    );
                                  } else {
                                    // Use memory image if useNetworkImage is false (original behavior)
                                    return FutureBuilder<Uint8List?>(
                                      future: website.loadFaviconBytes(),
                                      builder: (BuildContext context,
                                          AsyncSnapshot<Uint8List?>
                                              snapshot) {
                                        if (snapshot.hasData &&
                                            snapshot.data != null) {
                                          // Check if favicon is SVG and render accordingly
                                          if (website.isSvgFavicon) {
                                            return SvgPicture.memory(
                                              snapshot.data!,
                                              fit: BoxFit.fill,
                                            );
                                          } else {
                                            return Image.memory(
                                              snapshot.data!,
                                              fit: BoxFit.contain,
                                              errorBuilder: (context, error,
                                                  stackTrace) {
                                                // Fallback if image fails to render
                                                return Icon(Icons.public,
                                                    size: 24);
                                              },
                                            );
                                          }
                                        } else {
                                          return dotProgress(context);
                                        }
                                      },
                                    );
                                  }
                                },
                              ),
                            ),

                            SizedBox(width: AppTheme.elementSpacing.w),

                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    website.name,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    Uri.parse(website.url).host,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                          color: Theme.of(context).colorScheme.primary,
                                        ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                            
                            Icon(
                              Icons.open_in_new_rounded,
                              size: 18,
                              color: Theme.of(context).colorScheme.primary.withOpacity(0.7),
                            )
                          ],
                        ),

                        SizedBox(height: 16.h),

                        // Website banner image
                        Expanded(
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: AppTheme.cardRadiusSmall.r,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: AppTheme.cardRadiusSmall.r,
                              child: website.bannerPath != null
                                ? Image.asset(
                                    website.bannerPath!,
                                    color: website.replaceColor ? Colors.white : null,
                                    fit: BoxFit.cover,
                                  )
                                : Container(
                                    color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                                    child: Center(
                                      child: Icon(
                                        Icons.language,
                                        size: 48,
                                        color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
                                      ),
                                    ),
                                  ),
                            ),
                          ),
                        ),

                        SizedBox(height: 12.h),
                        
                        // Website description
                        Text(
                          website.description,
                          style: Theme.of(context).textTheme.bodyMedium,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
            },
          ),

          SizedBox(height: AppTheme.cardPadding.h * 1.5),

          CommonHeading(
            headingText: "Websites",
            hasButton: false,
            onPress: '',
          ),

          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: AppTheme.cardPadding),
            child: GlassContainer(
              customShadow: isDarkMode ? [] : null,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: AppTheme.elementSpacing * 0.5),
                child: Column(
                  children: websites.map((entry) {
                    return BitNetListTile(
                      onTap: () {
                        context.pushNamed(kWebViewScreenRoute, pathParameters: {
                          'url': entry.url,
                          'name': entry.name
                        });
                      },
                      margin: EdgeInsets.zero,
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: AppTheme.elementSpacing * 0.75,
                          vertical: AppTheme.elementSpacing * 0.75),
                      leading: Container(
                        height: 38.h, // Increased from 34.h

                        width: 38.w, // Increased from 34.w

                        child: Builder(
                          builder: (context) {
                            // First priority: Use local asset if iconPath is provided
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
                            // Second priority: Use network image if useNetworkImage is true
                            else if (entry.useNetworkImage) {
                              return FutureBuilder<String>(
                                future: entry.getFaviconUrl(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData &&
                                      snapshot.data != null &&
                                      snapshot.data!.isNotEmpty) {
                                    final String iconUrl = snapshot.data!;
                                    final bool isSvg = iconUrl
                                            .toLowerCase()
                                            .endsWith('.svg') ||
                                        (entry.isSvgFavicon);

                                    if (isSvg) {
                                      return SvgPicture.network(
                                        iconUrl,
                                        fit: BoxFit.fill,
                                        placeholderBuilder:
                                            (BuildContext context) =>
                                                dotProgress(context),
                                      );
                                    } else {
                                      return Image.network(
                                        iconUrl,
                                        fit: BoxFit.contain,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return Icon(Icons.public, size: 20);
                                        },
                                        loadingBuilder:
                                            (context, child, loadingProgress) {
                                          if (loadingProgress == null)
                                            return child;
                                          return dotProgress(context);
                                        },
                                      );
                                    }
                                  } else {
                                    return dotProgress(context);
                                  }
                                },
                              );
                            }
                            // Third priority: Use memory image (original behavior)
                            else {
                              return FutureBuilder<Uint8List?>(
                                future: entry.loadFaviconBytes(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<Uint8List?> snapshot) {
                                  if (snapshot.hasData &&
                                      snapshot.data != null) {
                                    // Check if favicon is SVG and render accordingly
                                    if (entry.isSvgFavicon) {
                                      return SvgPicture.memory(
                                        snapshot.data!,
                                        fit: BoxFit.fill,
                                      );
                                    } else {
                                      return Image.memory(
                                        snapshot.data!,
                                        fit: BoxFit.contain,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          // Fallback if image fails to render
                                          return Icon(Icons.public, size: 20);
                                        },
                                      );
                                    }
                                  } else {
                                    return dotProgress(context);
                                  }
                                },
                              );
                            }
                          },
                        ),
                      ),
                      text: entry.name,
                      trailing: Icon(Icons.arrow_forward_ios_rounded),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),

          SizedBox(height: AppTheme.cardPadding.h),

          // Top Volume Today section with CommonHeading (Added section)

          SizedBox(height: 100.h), // Added extra space at the bottom
        ],
      )),
      context: context,
    );
  }
}

class WebsiteData {
  final String url;
  final String? bannerPath;
  final String? iconPath; // Local asset path for the icon
  final String name;
  final String description; // Added description field
  final bool replaceColor;
  final bool useNetworkImage;
  String? faviconUrl;
  Uint8List? _faviconBytes;
  bool _isLoading = false;
  int _retryCount = 0;
  Timer? _retryTimer;
  final int _maxRetries = 5;
  final _completer = Completer<Uint8List?>();

  WebsiteData(
      {required this.name,
      required this.url,
      this.bannerPath,
      this.iconPath,
      this.description = '', // Default empty description
      this.replaceColor = true,
      this.useNetworkImage = false});

  Future<String> getFaviconUrl() async {
    if (faviconUrl != null) {
      return faviconUrl!;
    }
    try {
      // Ensure the URL has a scheme (http/https)
      String websiteUrl = url;
      if (!websiteUrl.startsWith('http')) {
        websiteUrl = 'https://$websiteUrl';
      }

      // Fetch the website HTML
      final response = await http.get(Uri.parse(websiteUrl));

      if (response.statusCode == 200) {
        final document = html.parse(response.body);

        // Look for <link rel="icon"> or similar tags
        final iconTags = document.querySelectorAll(
            'link[rel="icon"], link[rel="shortcut icon"], link[rel="apple-touch-icon"]');

        for (var tag in iconTags) {
          final iconUrl = tag.attributes['href'];
          if (iconUrl != null) {
            // Handle relative paths by resolving them to absolute URLs
            faviconUrl = Uri.parse(websiteUrl).resolve(iconUrl).toString();
            return faviconUrl!;
          }
        }
      }

      // Fallback to default favicon.ico
      faviconUrl = '$websiteUrl/favicon.ico';
      return faviconUrl!;
    } catch (e) {
      print('Error fetching favicon: $e');
      return ''; // Return empty string if fetching fails
    }
  }

  // This method loads the favicon image and caches its bytes
  // Indicates if the favicon is an SVG
  bool? _isSvgFavicon;

  // Getter for isSvgFavicon
  bool get isSvgFavicon => _isSvgFavicon ?? false;

  Future<Uint8List?> loadFaviconBytes() async {
    // If we already have bytes cached, return them
    if (_faviconBytes != null) {
      return _faviconBytes;
    }

    // If we're already loading and have a completer waiting, return its future
    if (_isLoading) {
      return _completer.future;
    }

    _isLoading = true;
    _loadAndRetryImage();
    return _completer.future;
  }

  void _loadAndRetryImage() async {
    try {
      final iconUrl = await getFaviconUrl();
      if (iconUrl.isEmpty) {
        if (!_completer.isCompleted) {
          _completer.complete(null);
        }
        _isLoading = false;
        return;
      }

      // Check if the URL ends with .svg
      _isSvgFavicon = iconUrl.toLowerCase().endsWith('.svg');

      final response = await http.get(Uri.parse(iconUrl));

      if (response.statusCode == 200) {
        // Check content type for SVG if file extension doesn't indicate it
        if (!_isSvgFavicon!) {
          final contentType = response.headers['content-type'] ?? '';
          _isSvgFavicon = contentType.contains('svg');
        }

        _faviconBytes = response.bodyBytes;
        if (!_completer.isCompleted) {
          _completer.complete(_faviconBytes);
        }
        _isLoading = false;
        _retryCount = 0;
        return;
      } else if (response.statusCode == 429) {
        // Rate limited - wait longer before retrying
        _retryWithDelay(Duration(seconds: 10 * (_retryCount + 1)));
      } else {
        // Other HTTP error - retry with backoff
        _retryWithDelay(Duration(seconds: 2 * (_retryCount + 1)));
      }
    } catch (e) {
      print('Error loading favicon image: $e');
      _retryWithDelay(Duration(seconds: 2 * (_retryCount + 1)));
    }
  }

  void _retryWithDelay(Duration delay) {
    if (_retryCount < _maxRetries) {
      _retryCount++;
      print(
          'Retrying favicon load (${_retryCount}/$_maxRetries) after ${delay.inSeconds}s');

      _retryTimer?.cancel();
      _retryTimer = Timer(delay, () {
        _loadAndRetryImage();
      });
    } else {
      print('Max retries reached for favicon from $url');
      if (!_completer.isCompleted) {
        _completer.complete(null);
      }
      _isLoading = false;
      _retryCount = 0;
    }
  }

  void dispose() {
    _retryTimer?.cancel();
  }
}
