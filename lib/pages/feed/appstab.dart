import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:bitnet/backbone/auth/auth.dart';
import 'package:bitnet/backbone/helper/databaserefs.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetListTile.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/appstandards/fadelistviewwrapper.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/container/imagewithtext.dart';
import 'package:bitnet/components/loaders/loaders.dart';
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

class AppsTab extends StatefulWidget {
  const AppsTab({super.key});

  @override
  State<AppsTab> createState() => _AppsTabState();
}

class _AppsTabState extends State<AppsTab> {
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

                  SizedBox(height: AppTheme.cardPadding * 1.5.h),
                  if (loading || (!loading && myApps.isNotEmpty))
                    TextButton(
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
                          Icon(Icons.arrow_forward_ios_rounded)
                        ],
                      ),
                    ),
                  if (loading) dotProgress(context),
                  if (!loading && myApps.isNotEmpty) ...{
                    GlassContainer(
                        child: Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: ListView(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        children: [
                          ...myApps.map((app) => _AppListTile(
                                inMyAppsScreen: false,
                                app: app,
                                appOwned: ownedApps.contains(app.docId),
                              ))
                        ],
                      ),
                    )),
                    SizedBox(height: AppTheme.cardPadding * 2.h),
                  },

                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 8.0),
                    child: Text(
                      "Available Apps",
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ),
                  if (loading) dotProgress(context),
                  if (!loading) ...{
                    GlassContainer(
                        child: Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: ListView(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        children: [
                          ...availableApps.map((app) => _AppListTile(
                                inMyAppsScreen: false,
                                app: app,
                                appOwned: ownedApps.contains(app.docId),
                              ))
                        ],
                      ),
                    ))
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
                children: [
                  // Trending section

                  SizedBox(height: AppTheme.cardPadding * 1.5.h),
                  GlassContainer(
                      child: Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: ListView(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        ...myApps.map((app) => _AppListTile(
                              inMyAppsScreen: true,
                              app: app,
                              appOwned: ownedApps.contains(app.docId),
                            ))
                      ],
                    ),
                  ))
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

class _AppListTile extends StatefulWidget {
  const _AppListTile({
    required this.app,
    required this.appOwned,
    required this.inMyAppsScreen,
  });
  final AppData app;
  final bool appOwned;
  final bool inMyAppsScreen;
  @override
  State<_AppListTile> createState() => _AppListTileState();
}

class _AppListTileState extends State<_AppListTile> {
  bool buttonLoading = false;
  @override
  Widget build(BuildContext context) {
    return BitNetListTile(
      text: widget.app.name,
      leading: AppImageBuilder(app: widget.app, width: 38.w, height: 38.h),
      trailing: LongButtonWidget(
          state: buttonLoading ? ButtonState.disabled : ButtonState.idle,
          title: widget.appOwned ? "Go" : "Get",
          customWidth: 90.w,
          customHeight: 40.h,
          onTap: () async {
            if (widget.appOwned) {
              context.pushNamed(kWebViewScreenRoute, pathParameters: {
                'url': widget.app.url,
                'name': widget.app.name,
              }, extra: {
                "is_app": true
              });
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
        if (widget.inMyAppsScreen) {
          context.go("/feed/" + kMyAppsPageRoute + "/" + kAppPageRoute,
              extra: widget.app.toJson());
        } else {
          context.go("/feed/" + kAppPageRoute, extra: widget.app.toJson());
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

  String? faviconUrl;
  Uint8List? _faviconBytes;
  bool _isLoading = false;
  int _retryCount = 0;
  Timer? _retryTimer;
  final int _maxRetries = 5;
  final _completer = Completer<Uint8List?>();

  AppData(
      {required this.docId,
      required this.url,
      required this.name,
      required this.desc,
      this.iconPath,
      this.useNetworkImage = true});

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'url': url,
      'desc': desc,
      'docId': docId,
      'useNetworkImage': useNetworkImage,
      if (iconPath != null) 'iconPath': iconPath
    };
  }

  factory AppData.fromJson(Map<String, dynamic> map) {
    return AppData(
        docId: map['docId'],
        url: map['url'],
        name: map['name'],
        desc: map['desc'],
        iconPath: map.containsKey('iconPath') ? map['iconPath'] : null);
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

class AppTab extends StatefulWidget {
  const AppTab({super.key, required this.routerState});
  final GoRouterState routerState;

  @override
  State<AppTab> createState() => _AppTabState();
}

class _AppTabState extends State<AppTab> {
  bool somethingFailed = false;
  bool loading = true;
  bool appOwned = false;
  bool buttonLoading = false;
  late AppData app;
  @override
  void initState() {
    super.initState();
    if (!(widget.routerState.extra is Map<String, dynamic>)) {
      somethingFailed = true;
    } else {
      app = AppData.fromJson(widget.routerState.extra as Map<String, dynamic>);
      Databaserefs.appsRef.doc(Auth().currentUser!.uid).get().then((val) {
        if (val.exists &&
            val.data() != null &&
            val.data()!['apps'] != null &&
            (val.data()!['apps'] as List).contains(app.docId)) {
          appOwned = true;
        }
        loading = false;
        WidgetsBinding.instance.addPostFrameCallback((_) {
          setState(() {});
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return bitnetScaffold(
      context: context,
      appBar: bitnetAppBar(
        context: context,
        actions: [
          IconButton(
              onPressed: () {
                if (somethingFailed) return;
                Share.share("");
              },
              icon: Icon(Icons.share_rounded))
        ],
        text: "App",
      ),
      body: somethingFailed
          ? Center(child: Text("Something went wrong, please try again later."))
          : loading
              ? Center(
                  child: dotProgress(context),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: AppTheme.cardPadding * 2.h),
                    AppImageBuilder(app: app, width: 80.w, height: 80.h),
                    SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32.0),
                      child: GlassContainer(
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              textAlign: TextAlign.center,
                              app.desc,
                              softWrap: true,
                            ),
                          )),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 8.0),
                      child: Text(
                        "By launching this app, you agree to the Terms & Conditions of something something",
                        style: Theme.of(context).textTheme.bodySmall,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: LongButtonWidget(
                          customWidth: double.infinity,
                          title: appOwned ? "Go" : "Get",
                          state: buttonLoading
                              ? ButtonState.loading
                              : ButtonState.idle,
                          onTap: () async {
                            if (appOwned) {
                              context.pushNamed(kWebViewScreenRoute,
                                  pathParameters: {
                                    'url': app.url,
                                    'name': app.name,
                                  },
                                  extra: {
                                    "is_app": true
                                  });
                            } else {
                              buttonLoading = true;
                              setState(() {});
                              await addAppToUser(app);
                              appOwned = true;
                              buttonLoading = false;
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                setState(() {});
                              });
                            }
                          }),
                    )
                  ],
                ),
    );
  }
}

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
    return Container(
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
                  return Icon(Icons.public, size: 20);
                },
              );
            }
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
                        return Icon(Icons.public, size: 20);
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
                        return Icon(Icons.public, size: 20);
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
    );
  }
}

Future<void> addAppToUser(AppData app) async {
  await Databaserefs.appsRef.doc(Auth().currentUser!.uid).set({
    'apps': FieldValue.arrayUnion([app.docId]),
  }, SetOptions(merge: true));
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
          useNetworkImage: doc.data()['useNetworkImage'],
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
