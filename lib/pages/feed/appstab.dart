import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:bitnet/backbone/auth/auth.dart';
import 'package:bitnet/backbone/cloudfunctions/lnd/walletkitservice/nextaddr.dart';
import 'package:bitnet/backbone/helper/databaserefs.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetListTile.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/appstandards/fadelistviewwrapper.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/appstandards/glasscontainer.dart';
import 'package:bitnet/components/loaders/loaders.dart';
import 'package:bitnet/models/bitcoin/walletkit/addressmodel.dart';
import 'package:bitnet/pages/profile/profile_controller.dart';
import 'package:bitnet/pages/routetrees/marketplaceroutes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_highlighter/themes/docco.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as html;
import 'package:share_plus/share_plus.dart';

//VARIABLE PARAMETERS:
//address
String ORIGIN_APP_NAME = "Bitnet";
String MINI_APP_API_VERSION = "0.0.1";

class AppsTab extends StatefulWidget {
  const AppsTab({super.key});

  @override
  State<AppsTab> createState() => _AppsTabState();
}

class _AppsTabState extends State<AppsTab> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  List<AppData> myApps = List.empty();
  List<AppData> availableApps = List.empty();
  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadAsync();
    for (final app in myApps) {
      app.loadFaviconBytes();
    }
    for (final app in availableApps) {
      app.loadFaviconBytes();
    }
  }

  Future<void> loadAsync() async {
    availableApps = await getAvailableApps();
    Get.find<ProfileController>().availableApps = availableApps;
    myApps = await getMyApps(availableApps);
    for (final app in myApps) {
      app.loadFaviconBytes();
    }
    for (final app in availableApps) {
      app.loadFaviconBytes();
    }
    loading = false;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();

    for (final app in myApps) {
      app.dispose();
    }
    for (final app in availableApps) {
      app.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return bitnetScaffold(
      context: context,
      body: VerticalFadeListView.standardTab(
        child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            stream:
                Databaserefs.appsRef.doc(Auth().currentUser!.uid).snapshots(),
            builder: (context, snapshot) {
              List<String> ownedApps = List.empty();
              if (snapshot.hasData && snapshot.data!.data() != null) {
                List? dataList = snapshot.data!.data()!['apps'] as List?;
                ownedApps =
                    dataList?.map((item) => item as String).toList() ?? [];
              }
              myApps = availableApps
                  .where((test) => ownedApps.contains(test.docId))
                  .toList();
              return ListView(
                physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                children: [
                  // Trending section

                  SizedBox(height: AppTheme.cardPadding.h),
                  if (loading || (!loading && myApps.isNotEmpty))
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: AppTheme.cardPadding),
                      child: TextButton(
                        onPressed: () {
                          if (!loading) {
                            context.goNamed(kMyAppsPageRoute,
                                extra:
                                    myApps.map((app) => app.toJson()).toList());
                          }
                        },
                        child: Row(
                          children: [
                            Text(
                              "My Apps",
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                            const SizedBox(width: AppTheme.elementSpacing),
                            Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: AppTheme.iconSize * 0.75,
                            )
                          ],
                        ),
                      ),
                    ),
                  if (loading)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: AppTheme.cardPadding),
                      child: dotProgress(context),
                    ),
                  if (!loading && myApps.isNotEmpty) ...{
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: AppTheme.cardPadding),
                      child: GlassContainer(
                        child: ListView(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          children: [
                            ...myApps.map((app) => AppListTile(
                                  inMyAppsScreen: false,
                                  app: app,
                                  outsideNavigation: false,
                                  appOwned: ownedApps.contains(app.docId),
                                ))
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: AppTheme.cardPadding.h),
                  },

                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppTheme.cardPadding),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          bottom: AppTheme.elementSpacing),
                      child: Text(
                        "Available Apps",
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ),
                  ),
                  if (loading)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: AppTheme.cardPadding),
                      child: dotProgress(context),
                    ),
                  if (!loading) ...{
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: AppTheme.cardPadding),
                      child: GlassContainer(
                        child: ListView(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          children: [
                            ...availableApps.map((app) => AppListTile(
                                  inMyAppsScreen: false,
                                  app: app,
                                  outsideNavigation: false,
                                  appOwned: ownedApps.contains(app.docId),
                                ))
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: AppTheme.cardPadding.h),
                  },
                ],
              );
            }),
      ),
    );
  }
}

class MyAppsPage extends StatefulWidget {
  const MyAppsPage({super.key, required this.routerState});
  final GoRouterState routerState;
  @override
  State<MyAppsPage> createState() => _MyAppsPageState();
}

class _MyAppsPageState extends State<MyAppsPage> {
  List<AppData> myApps = List.empty();

  @override
  void initState() {
    super.initState();
    myApps = (widget.routerState.extra as List<Map<String, dynamic>>)
        .map((data) => AppData.fromJson(data))
        .toList();
    for (final app in myApps) {
      app.loadFaviconBytes();
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return bitnetScaffold(
      context: context,
      appBar: bitnetAppBar(
        context: context,
        text: "My Apps",
      ),
      body: VerticalFadeListView.standardTab(
        child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            stream:
                Databaserefs.appsRef.doc(Auth().currentUser!.uid).snapshots(),
            builder: (context, snapshot) {
              List<String> ownedApps = List.empty();
              if (snapshot.hasData && snapshot.data!.data() != null) {
                List? dataList = snapshot.data!.data()!['apps'] as List?;
                ownedApps =
                    dataList?.map((item) => item as String).toList() ?? [];
              }
              return ListView(
                physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                padding: EdgeInsets.zero,
                children: [
                  SizedBox(height: AppTheme.cardPadding.h),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppTheme.cardPadding),
                    child: GlassContainer(
                      child: ListView(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        children: [
                          ...myApps.map((app) => AppListTile(
                                inMyAppsScreen: true,
                                app: app,
                                outsideNavigation: false,
                                appOwned: ownedApps.contains(app.docId),
                              ))
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: AppTheme.cardPadding.h),
                ],
              );
            }),
      ),
    );
  }
}

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

class AppListTile extends StatefulWidget {
  const AppListTile({
    required this.app,
    required this.appOwned,
    required this.inMyAppsScreen,
    required this.outsideNavigation,
  });
  final AppData app;
  final bool appOwned;
  final bool inMyAppsScreen;
  final bool outsideNavigation;
  @override
  State<AppListTile> createState() => _AppListTileState();
}

class _AppListTileState extends State<AppListTile> {
  bool buttonLoading = false;
  @override
  Widget build(BuildContext context) {
    return BitNetListTile(
      text: widget.app.name,
      leading: AppImageBuilder(app: widget.app, width: 38.w, height: 38.h),
      trailing: LongButtonWidget(
          state: buttonLoading ? ButtonState.loading : ButtonState.idle,
          title: widget.appOwned ? "Go" : "Get",
          customWidth: 90.w,
          customHeight: 40.h,
          onTap: () async {
            if (widget.appOwned) {
              buttonLoading = true;
              setState(() {});

              final url = await widget.app.getUrl();
              context.pushNamed(kWebViewScreenRoute, pathParameters: {
                'url': url,
                'name': widget.app.name,
              }, extra: {
                "is_app": true
              });
              buttonLoading = false;
              if (context.mounted) {
                setState(() {});
              }
            } else {
              buttonLoading = true;
              setState(() {});
              await addAppToUser(widget.app);
              buttonLoading = false;
              WidgetsBinding.instance.addPostFrameCallback((_) {
                setState(() {});
              });
            }
          }),
      onTap: () {
        if (widget.outsideNavigation) {
          context.push("/feed/" + kAppPageRoute, extra: widget.app.toJson());
        } else {
          if (widget.inMyAppsScreen) {
            context.go("/feed/" + kMyAppsPageRoute + "/" + kAppPageRoute,
                extra: widget.app.toJson());
          } else {
            context.go("/feed/" + kAppPageRoute, extra: widget.app.toJson());
          }
        }
      },
    );
  }
}

class AppData {
  final String docId;
  final String url;
  final String name;
  final String desc;
  final String? iconPath; // Local asset path for the icon
  final bool useNetworkImage;
  final bool useNetworkAsset;
  final String? storageName;
  final Map<String, dynamic>? parameters;
  final String? ownerId;

  String? faviconUrl;
  Uint8List? _faviconBytes;
  bool _isLoading = false;
  int _retryCount = 0;
  Timer? _retryTimer;
  final int _maxRetries = 5;
  final _completer = Completer<Uint8List?>();

  AppData({
    required this.docId,
    required this.url,
    required this.name,
    required this.desc,
    this.parameters,
    this.iconPath,
    this.storageName,
    this.useNetworkImage = true,
    this.useNetworkAsset = false,
    this.ownerId,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'url': url,
      'desc': desc,
      'docId': docId,
      'useNetworkImage': useNetworkImage,
      'useNetworkAsset': useNetworkAsset,
      'storage_name': storageName,
      'parameters': parameters,
      if (iconPath != null) 'iconPath': iconPath,
      if (ownerId != null) 'ownerId': ownerId
    };
  }

  factory AppData.fromJson(Map<String, dynamic> map) {
    return AppData(
        docId: map['docId'],
        url: map['url'],
        name: map['name'],
        desc: map['desc'],
        useNetworkImage: map['useNetworkImage'] ?? true,
        useNetworkAsset: map['useNetworkAsset'] ?? false,
        storageName: map['storage_name'],
        parameters: map['parameters'],
        iconPath: map.containsKey('iconPath') ? map['iconPath'] : null,
        ownerId: map.containsKey('ownerId') ? map['ownerId'] : null);
  }

  Future<String> getUrl() async {
    final logger = Get.find<LoggerService>();

    if (parameters == null) {
      return url;
    } else {
      String finalUrl = url + "?";
      for (String paramKey in parameters!.keys) {
        if (parameters![paramKey] == "VAR") {
          if (paramKey == "address") {
            logger.i("Getting BTC Address");
            String? addr = await nextAddr(Auth().currentUser!.uid);
            if (addr == null) {
              logger.e("Failed to generate address");
              continue;
            }
            BitcoinAddress address = BitcoinAddress.fromJson({'addr': addr});
            finalUrl = finalUrl + "${paramKey}=${address.addr}&";
          }
        } else {
          finalUrl = finalUrl + "${paramKey}=${parameters![paramKey]}&";
        }
      }
      if (finalUrl.endsWith("&"))
        finalUrl = finalUrl.substring(0, finalUrl.length - 1);
      return finalUrl;
    }
  }

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

// Old AppTab class removed - now using AppDetailsModern instead

class AppImageBuilder extends StatelessWidget {
  const AppImageBuilder({
    super.key,
    required this.app,
    required this.width,
    required this.height,
  });

  final AppData app;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Container(
        height: width, // Increased from 34.h

        width: height, // Increased from 34.w

        child: Builder(
          builder: (context) {
            // First priority: Use local asset if iconPath is provided
            if (app.iconPath != null) {
              final String iconPath = app.iconPath!;
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
                    return Icon(Icons.public, size: width);
                  },
                );
              }
            } else if (app.useNetworkAsset) {
              return FutureBuilder<String>(
                future: storageRef
                    .child("mini_app_icons/${app.storageName}")
                    .getDownloadURL(),
                builder: (context, snapshot) {
                  if (snapshot.hasData &&
                      snapshot.data != null &&
                      snapshot.data!.isNotEmpty) {
                    final String iconUrl = snapshot.data!;
                    final bool isSvg = iconUrl.toLowerCase().endsWith('.svg') ||
                        (app.isSvgFavicon);

                    if (isSvg) {
                      return SvgPicture.network(
                        iconUrl,
                        fit: BoxFit.fill,
                        placeholderBuilder: (BuildContext context) =>
                            _buildImagePlaceholder(size: 24.0),
                      );
                    } else {
                      return Image.network(
                        iconUrl,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(Icons.public, size: width);
                        },
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return _buildImagePlaceholder(size: 24.0);
                        },
                      );
                    }
                  } else {
                    return _buildImagePlaceholder(size: 24.0);
                  }
                },
              );
            }
            // Second priority: Use network image if useNetworkImage is true
            else if (app.useNetworkImage) {
              return FutureBuilder<String>(
                future: app.getFaviconUrl(),
                builder: (context, snapshot) {
                  if (snapshot.hasData &&
                      snapshot.data != null &&
                      snapshot.data!.isNotEmpty) {
                    final String iconUrl = snapshot.data!;
                    final bool isSvg = iconUrl.toLowerCase().endsWith('.svg') ||
                        (app.isSvgFavicon);

                    if (isSvg) {
                      return SvgPicture.network(
                        iconUrl,
                        fit: BoxFit.fill,
                        placeholderBuilder: (BuildContext context) =>
                            _buildImagePlaceholder(size: 24.0),
                      );
                    } else {
                      return Image.network(
                        iconUrl,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(Icons.public, size: width);
                        },
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return _buildImagePlaceholder(size: 24.0);
                        },
                      );
                    }
                  } else {
                    return _buildImagePlaceholder(size: 24.0);
                  }
                },
              );
            }
            // Third priority: Use memory image (original behavior)
            else {
              return FutureBuilder<Uint8List?>(
                future: app.loadFaviconBytes(),
                builder:
                    (BuildContext context, AsyncSnapshot<Uint8List?> snapshot) {
                  if (snapshot.hasData && snapshot.data != null) {
                    // Check if favicon is SVG and render accordingly
                    if (app.isSvgFavicon) {
                      return SvgPicture.memory(
                        snapshot.data!,
                        fit: BoxFit.fill,
                      );
                    } else {
                      return Image.memory(
                        snapshot.data!,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          // Fallback if image fails to render
                          return Icon(Icons.public, size: width);
                        },
                      );
                    }
                  } else {
                    return _buildImagePlaceholder(size: 20.0);
                  }
                },
              );
            }
          },
        ),
      ),
    );
  }
}

Future<void> addAppToUser(AppData app) async {
  final userId = Auth().currentUser!.uid;
  final batch = FirebaseFirestore.instance.batch();

  // Add app to user's collection
  final userRef = Databaserefs.appsRef.doc(userId);
  batch.set(
      userRef,
      {
        'apps': FieldValue.arrayUnion([app.docId]),
      },
      SetOptions(merge: true));

  // Update app download statistics
  final appStatsRef =
      FirebaseFirestore.instance.collection('app_stats').doc(app.docId);

  // Add user to downloaders list
  final downloadersRef = appStatsRef.collection('downloaders').doc(userId);

  batch.set(downloadersRef, {
    'downloaded_at': FieldValue.serverTimestamp(),
    'user_id': userId,
  });

  // Increment download count
  batch.set(
      appStatsRef,
      {
        'download_count': FieldValue.increment(1),
        'last_download': FieldValue.serverTimestamp(),
      },
      SetOptions(merge: true));

  await batch.commit();
}

Future<List<AppData>> getAvailableApps() async {
  QuerySnapshot<Map<String, dynamic>> q =
      await Databaserefs.appsRef.doc("total_apps").collection("apps").get();

  return q.docs
      .map((doc) => AppData(
          docId: doc.id,
          url: doc.data()['url'],
          name: doc.data()['name'],
          desc: doc.data()['desc'],
          useNetworkAsset: doc.data()['useNetworkAsset'] ?? false,
          storageName: doc.data()['storage_name'],
          useNetworkImage: doc.data()['useNetworkImage'],
          parameters: doc.data().containsKey('parameters')
              ? doc.data()['parameters']
              : null,
          iconPath: doc.data().containsKey('iconPath')
              ? doc.data()['iconPath']
              : null))
      .toList();
}

Future<List<AppData>> getMyApps(List<AppData> availableApps) async {
  DocumentSnapshot<Map<String, dynamic>> doc =
      await Databaserefs.appsRef.doc(Auth().currentUser!.uid).get();
  if (doc.data() == null) {
    return [];
  }
  List appIds = doc.data()!['apps'];

  return availableApps.where((test) => appIds.contains(test.docId)).toList();
}
