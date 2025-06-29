import 'package:bitnet/components/post/post_header.dart';
import 'package:flutter/material.dart';

import 'package:flutter/scheduler.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

// import '../enums/player_state.dart';
// import '../utils/youtube_meta_data.dart';
// import '../utils/youtube_player_controller.dart';

/// A raw TIKTOK player widget which interacts with the underlying webview inorder to play YouTube videos.
/// Trying to recreate youtube player but for tiktoks
/// https://github.com/sarbagyastha/youtube_player_flutter/blob/master/packages/youtube_player_flutter/lib/src/player/raw_youtube_player.dart
import 'package:flutter/services.dart';

/// A widget to play or stream YouTube videos using the official [YouTube IFrame Player API](https://developers.google.com/youtube/iframe_api_reference).
///
/// In order to play live videos, set `isLive` property to true in [YoutubePlayerFlags].
///
///
/// Using YoutubePlayer widget:
///
/// ```dart
/// YoutubePlayer(
///    context: context,
///    initialVideoId: "iLnmTe5Q2Qw",
///    flags: YoutubePlayerFlags(
///      autoPlay: true,
///      showVideoProgressIndicator: true,
///    ),
///    videoProgressIndicatorColor: Colors.amber,
///    progressColors: ProgressColors(
///      playedColor: Colors.amber,
///      handleColor: Colors.amberAccent,
///    ),
///    onPlayerInitialized: (controller) {
///      _controller = controller..addListener(listener);
///    },
///)
/// ```
///
class ShortsPlayer extends StatefulWidget {
  /// Sets [Key] as an identification to underlying web view associated to the player.
  final Key? key;

  /// A [YoutubePlayerController] to control the player.
  final YoutubePlayerController controller;

  /// {@template youtube_player_flutter.width}
  /// Defines the width of the player.
  ///
  /// Default is devices's width.
  /// {@endtemplate}
  final double? width;

  /// {@template youtube_player_flutter.aspectRatio}
  /// Defines the aspect ratio to be assigned to the player. This property along with [width] calculates the player size.
  ///
  /// Default is 16 / 9.
  /// {@endtemplate}
  final double aspectRatio;

  /// {@template youtube_player_flutter.controlsTimeOut}
  /// The duration for which controls in the player will be visible.
  ///
  /// Default is 3 seconds.
  /// {@endtemplate}
  final Duration controlsTimeOut;

  /// {@template youtube_player_flutter.bufferIndicator}
  /// Overrides the default buffering indicator for the player.
  /// {@endtemplate}
  final Widget? bufferIndicator;

  /// {@template youtube_player_flutter.progressColors}
  /// Overrides default colors of the progress bar, takes [ProgressColors].
  /// {@endtemplate}
  final ProgressBarColors progressColors;

  /// {@template youtube_player_flutter.progressIndicatorColor}
  /// Overrides default color of progress indicator shown below the player(if enabled).
  /// {@endtemplate}
  final Color progressIndicatorColor;

  /// {@template youtube_player_flutter.onReady}
  /// Called when player is ready to perform control methods like:
  /// play(), pause(), load(), cue(), etc.
  /// {@endtemplate}
  final VoidCallback? onReady;

  /// {@template youtube_player_flutter.onEnded}
  /// Called when player had ended playing a video.
  ///
  /// Returns [YoutubeMetaData] for the video that has just ended playing.
  /// {@endtemplate}
  final void Function(YoutubeMetaData metaData)? onEnded;

  /// {@template youtube_player_flutter.liveUIColor}
  /// Overrides color of Live UI when enabled.
  /// {@endtemplate}
  final Color liveUIColor;

  /// {@template youtube_player_flutter.topActions}
  /// Adds custom top bar widgets.
  /// {@endtemplate}
  final List<Widget>? topActions;

  /// {@template youtube_player_flutter.bottomActions}
  /// Adds custom bottom bar widgets.
  /// {@endtemplate}
  final List<Widget>? bottomActions;

  /// {@template youtube_player_flutter.actionsPadding}
  /// Defines padding for [topActions] and [bottomActions].
  ///
  /// Default is EdgeInsets.all(8.0).
  /// {@endtemplate}
  final EdgeInsetsGeometry actionsPadding;

  /// {@template youtube_player_flutter.thumbnail}
  /// Thumbnail to show when player is loading.
  ///
  /// If not set, default thumbnail of the video is shown.
  /// {@endtemplate}
  final Widget? thumbnail;

  /// {@template youtube_player_flutter.showVideoProgressIndicator}
  /// Defines whether to show or hide progress indicator below the player.
  ///
  /// Default is false.
  /// {@endtemplate}
  final bool showVideoProgressIndicator;

  /// Creates [ShortsPlayer] widget.
  const ShortsPlayer({
    this.key,
    required this.controller,
    this.width,
    this.aspectRatio = 9 / 16,
    this.controlsTimeOut = const Duration(seconds: 3),
    this.bufferIndicator,
    Color? progressIndicatorColor,
    ProgressBarColors? progressColors,
    this.onReady,
    this.onEnded,
    this.liveUIColor = Colors.red,
    this.topActions,
    this.bottomActions,
    this.actionsPadding = const EdgeInsets.all(8.0),
    this.thumbnail,
    this.showVideoProgressIndicator = false,
  })  : progressColors = progressColors ?? const ProgressBarColors(),
        progressIndicatorColor = progressIndicatorColor ?? Colors.red;

  /// Converts fully qualified YouTube Url to video id.
  ///
  /// If videoId is passed as url then no conversion is done.
  static String? convertUrlToId(String url, {bool trimWhitespaces = true}) {
    if (!url.contains("http") && (url.length == 11)) return url;
    if (trimWhitespaces) url = url.trim();

    for (var exp in [
      RegExp(
          r"^https:\/\/(?:www\.|m\.)?youtube\.com\/shorts\/([_\-a-zA-Z0-9]{11}).*$"),
      RegExp(
          r"^https:\/\/(?:www\.|m\.)?youtube(?:-nocookie)?\.com\/embed\/([_\-a-zA-Z0-9]{11}).*$"),
      RegExp(r"^https:\/\/youtu\.be\/([_\-a-zA-Z0-9]{11}).*$")
    ]) {
      Match? match = exp.firstMatch(url);
      if (match != null && match.groupCount >= 1) return match.group(1);
    }

    return null;
  }

  /// Grabs YouTube video's thumbnail for provided video id.
  static String getThumbnail({
    required String videoId,
    String quality = ThumbnailQuality.standard,
    bool webp = true,
  }) =>
      webp
          ? 'https://i3.ytimg.com/vi_webp/$videoId/$quality.webp'
          : 'https://i3.ytimg.com/vi/$videoId/$quality.jpg';

  @override
  _ShortsPlayerState createState() => _ShortsPlayerState();
}

class _ShortsPlayerState extends State<ShortsPlayer> {
  late YoutubePlayerController controller;

  late double _aspectRatio;
  bool _initialLoad = true;

  @override
  void initState() {
    super.initState();
    controller = widget.controller..addListener(listener);
    _aspectRatio = widget.aspectRatio;
  }

  @override
  void didUpdateWidget(ShortsPlayer oldWidget) {
    super.didUpdateWidget(oldWidget);
    oldWidget.controller.removeListener(listener);
    widget.controller.addListener(listener);
  }

  void listener() async {
    if (controller.value.isReady && _initialLoad) {
      _initialLoad = false;
      if (controller.flags.autoPlay) controller.play();
      if (controller.flags.mute) controller.mute();
      widget.onReady?.call();
      if (controller.flags.controlsVisibleAtStart) {
        controller.updateValue(
          controller.value.copyWith(isControlsVisible: true),
        );
      }
    }
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    controller.removeListener(listener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 0,
      color: Colors.black,
      child: InheritedYoutubePlayer(
        controller: controller,
        child: Container(
          color: Colors.black,
          width: widget.width ?? MediaQuery.of(context).size.width,
          child: _buildPlayer(
            errorWidget: Container(
              color: Colors.black87,
              padding:
                  const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Row(
                    children: [
                      Icon(
                        Icons.error_outline,
                        color: Colors.white,
                      ),
                      SizedBox(width: 5.0),
                      Expanded(
                        child: Text(
                          'An Error occured, please try again later.',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w300,
                            fontSize: 15.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    'Error Code: ${controller.value.errorCode}',
                    style: const TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildUploadButton() {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        margin: const EdgeInsets.only(top: 5.0),
        width: 120,
        height: 35,
        decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.4),
            borderRadius: const BorderRadius.all(Radius.circular(20))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              children: <Widget>[
                Icon(
                  Icons.check_circle,
                  size: 20,
                  color: Colors.white.withOpacity(0.8),
                ),
                const Padding(padding: EdgeInsets.symmetric(horizontal: 5.0)),
                Text(
                  "POST",
                  style: Theme.of(context).textTheme.titleMedium,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlayer({required Widget errorWidget}) {
    return AspectRatio(
      aspectRatio: _aspectRatio,
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          Transform.scale(
            scale: 16 / 11,
            child: RawShortsPlayer(
              key: widget.key,
              onEnded: (YoutubeMetaData metaData) {
                if (controller.flags.loop) {
                  controller.load(controller.metadata.videoId,
                      startAt: controller.flags.startAt,
                      endAt: controller.flags.endAt);
                }
                widget.onEnded?.call(metaData);
              },
            ),
          ),
          if (!controller.flags.hideThumbnail)
            AnimatedOpacity(
              opacity: controller.value.isPlaying ? 0 : 1,
              duration: const Duration(milliseconds: 300),
              child: widget.thumbnail ?? _thumbnail,
            ),
          if (!controller.value.isFullScreen &&
              !controller.flags.hideControls &&
              controller.value.position > const Duration(milliseconds: 100) &&
              !controller.value.isControlsVisible &&
              widget.showVideoProgressIndicator &&
              !controller.flags.isLive)
            Positioned.fill(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: buildUploadButton(),
                ),
              ),
            ),
          if (!controller.value.isFullScreen &&
              !controller.flags.hideControls &&
              controller.value.position > const Duration(milliseconds: 100) &&
              !controller.value.isControlsVisible &&
              widget.showVideoProgressIndicator &&
              !controller.flags.isLive)
            const Positioned(
              top: 10.0,
              left: 15.0,
              right: 15.0,
              child: PostHeader(
                ownerId: 'yourself',
                postId: 'nopostid',
                username: '',
                displayName: '',
              ),
            ),
          if (!controller.value.isFullScreen &&
              !controller.flags.hideControls &&
              controller.value.position > const Duration(milliseconds: 100) &&
              !controller.value.isControlsVisible &&
              widget.showVideoProgressIndicator &&
              !controller.flags.isLive)
            Positioned(
              bottom: -7.0,
              left: -7.0,
              right: -7.0,
              child: IgnorePointer(
                ignoring: true,
                child: ProgressBar(
                  colors: widget.progressColors.copyWith(
                    handleColor: Colors.transparent,
                  ),
                ),
              ),
            ),
          if (!controller.flags.hideControls) ...[
            TouchShutter(
              disableDragSeek: controller.flags.disableDragSeek,
              timeOut: widget.controlsTimeOut,
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: AnimatedOpacity(
                opacity: !controller.flags.hideControls &&
                        controller.value.isControlsVisible
                    ? 1
                    : 0,
                duration: const Duration(milliseconds: 300),
                child: controller.flags.isLive
                    ? LiveBottomBar(
                        liveUIColor: widget.liveUIColor,
                        showLiveFullscreenButton: false,
                      )
                    : Padding(
                        padding: widget.bottomActions == null
                            ? const EdgeInsets.all(0.0)
                            : widget.actionsPadding,
                        child: Row(
                          children: widget.bottomActions ??
                              [
                                const SizedBox(width: 14.0),
                                CurrentPosition(),
                                const SizedBox(width: 8.0),
                                ProgressBar(
                                  isExpanded: true,
                                  colors: widget.progressColors,
                                ),
                                RemainingDuration(),
                                const PlaybackSpeedButton(),
                                FullScreenButton(),
                              ],
                        ),
                      ),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: AnimatedOpacity(
                opacity: !controller.flags.hideControls &&
                        controller.value.isControlsVisible
                    ? 1
                    : 0,
                duration: const Duration(milliseconds: 300),
                child: Padding(
                  padding: widget.actionsPadding,
                  child: Row(
                    children: widget.topActions ?? [Container()],
                  ),
                ),
              ),
            ),
          ],
          if (!controller.flags.hideControls)
            Center(
              child: PlayPauseButton(),
            ),
          if (controller.value.hasError) errorWidget,
        ],
      ),
    );
  }

  Widget get _thumbnail => Transform.scale(
        scale: 16 / 11,
        child: Image.network(
          ShortsPlayer.getThumbnail(
            videoId: controller.metadata.videoId.isEmpty
                ? controller.initialVideoId
                : controller.metadata.videoId,
          ),
          fit: BoxFit.cover,
          loadingBuilder: (_, child, progress) =>
              progress == null ? child : Container(color: Colors.black),
          errorBuilder: (context, _, __) => Image.network(
            ShortsPlayer.getThumbnail(
              videoId: controller.metadata.videoId.isEmpty
                  ? controller.initialVideoId
                  : controller.metadata.videoId,
              webp: false,
            ),
            fit: BoxFit.cover,
            loadingBuilder: (_, child, progress) =>
                progress == null ? child : Container(color: Colors.black),
            errorBuilder: (context, _, __) => Container(),
          ),
        ),
      );
}

class ShortsPlayerBuilder extends StatefulWidget {
  /// The actual [ShortsPlayer].
  final ShortsPlayer player;

  /// Builds the widget below this [builder].
  final Widget Function(BuildContext, Widget) builder;

  /// Callback to notify that the player has entered fullscreen.
  final VoidCallback? onEnterFullScreen;

  /// Callback to notify that the player has exited fullscreen.
  final VoidCallback? onExitFullScreen;

  /// Builder for [ShortsPlayer] that supports switching between fullscreen and normal mode.
  const ShortsPlayerBuilder({
    Key? key,
    required this.player,
    required this.builder,
    this.onEnterFullScreen,
    this.onExitFullScreen,
  }) : super(key: key);

  @override
  _ShortsPlayerBuilderState createState() => _ShortsPlayerBuilderState();
}

class _ShortsPlayerBuilderState extends State<ShortsPlayerBuilder>
    with WidgetsBindingObserver {
  final GlobalKey playerKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    final physicalSize = SchedulerBinding.instance.window.physicalSize;
    final controller = widget.player.controller;
    if (physicalSize.width > physicalSize.height) {
      controller.updateValue(controller.value.copyWith(isFullScreen: true));
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
      widget.onEnterFullScreen?.call();
    } else {
      controller.updateValue(controller.value.copyWith(isFullScreen: false));
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
          overlays: SystemUiOverlay.values);
      widget.onExitFullScreen?.call();
    }
    super.didChangeMetrics();
  }

  @override
  Widget build(BuildContext context) {
    final _player = Container(
      key: playerKey,
      child: PopScope(
        canPop: false, // We'll handle pop manually
        onPopInvoked: (bool didPop) {
          if (didPop) return; // Already popped, do nothing

          final controller = widget.player.controller;
          if (controller.value.isFullScreen) {
            widget.player.controller.toggleFullScreenMode();
          } else {
            Navigator.of(context).pop();
          }
        },
        child: widget.player,
      ),
    );
    final child = widget.builder(context, _player);
    return OrientationBuilder(
      builder: (context, orientation) =>
          orientation == Orientation.portrait ? child : _player,
    );
  }
}

class RawShortsPlayer extends StatefulWidget {
  /// Sets [Key] as an identification to underlying web view associated to the player.
  final Key? key;

  /// {@macro youtube_player_flutter.onEnded}
  final void Function(YoutubeMetaData metaData)? onEnded;

  /// Creates a [RawShortsPlayer] widget.
  const RawShortsPlayer({
    this.key,
    this.onEnded,
  });

  @override
  _RawShortsPlayerState createState() => _RawShortsPlayerState();
}

class _RawShortsPlayerState extends State<RawShortsPlayer>
    with WidgetsBindingObserver {
  YoutubePlayerController? controller;
  PlayerState? _cachedPlayerState;
  bool _isPlayerReady = false;
  bool _onLoadStopCalled = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        if (_cachedPlayerState != null &&
            _cachedPlayerState == PlayerState.playing) {
          controller?.play();
        }
        break;
      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.paused:
        _cachedPlayerState = controller!.value.playerState;
        controller?.pause();
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    controller = YoutubePlayerController.of(context);
    return IgnorePointer(
      ignoring: true,
      child: InAppWebView(
        key: widget.key,
        initialData: InAppWebViewInitialData(
          data: player,
          baseUrl: WebUri.uri(Uri.parse('https://www.youtube.com')),
          encoding: 'utf-8',
          mimeType: 'text/html',
        ),
        initialOptions: InAppWebViewGroupOptions(
          crossPlatform: InAppWebViewOptions(
            userAgent: userAgent,
            mediaPlaybackRequiresUserGesture: false,
            transparentBackground: true,
            disableContextMenu: true,
            supportZoom: false,
            disableHorizontalScroll: false,
            disableVerticalScroll: false,
            useShouldOverrideUrlLoading: true,
          ),
          ios: IOSInAppWebViewOptions(
            allowsInlineMediaPlayback: true,
            allowsAirPlayForMediaPlayback: true,
            allowsPictureInPictureMediaPlayback: true,
          ),
          android: AndroidInAppWebViewOptions(
            useWideViewPort: false,
            useHybridComposition: controller!.flags.useHybridComposition,
          ),
        ),
        onWebViewCreated: (webController) {
          controller!.updateValue(
            controller!.value.copyWith(webViewController: webController),
          );
          webController
            ..addJavaScriptHandler(
              handlerName: 'Ready',
              callback: (_) {
                _isPlayerReady = true;
                if (_onLoadStopCalled) {
                  controller!.updateValue(
                    controller!.value.copyWith(isReady: true),
                  );
                }
              },
            )
            ..addJavaScriptHandler(
              handlerName: 'StateChange',
              callback: (args) {
                switch (args.first as int) {
                  case -1:
                    controller!.updateValue(
                      controller!.value.copyWith(
                        playerState: PlayerState.unStarted,
                        isLoaded: true,
                      ),
                    );
                    break;
                  case 0:
                    widget.onEnded?.call(controller!.metadata);
                    controller!.updateValue(
                      controller!.value.copyWith(
                        playerState: PlayerState.ended,
                      ),
                    );
                    break;
                  case 1:
                    controller!.updateValue(
                      controller!.value.copyWith(
                        playerState: PlayerState.playing,
                        isPlaying: true,
                        hasPlayed: true,
                        errorCode: 0,
                      ),
                    );
                    break;
                  case 2:
                    controller!.updateValue(
                      controller!.value.copyWith(
                        playerState: PlayerState.paused,
                        isPlaying: false,
                      ),
                    );
                    break;
                  case 3:
                    controller!.updateValue(
                      controller!.value.copyWith(
                        playerState: PlayerState.buffering,
                      ),
                    );
                    break;
                  case 5:
                    controller!.updateValue(
                      controller!.value.copyWith(
                        playerState: PlayerState.cued,
                      ),
                    );
                    break;
                  default:
                    throw Exception("Invalid player state obtained.");
                }
              },
            )
            ..addJavaScriptHandler(
              handlerName: 'PlaybackQualityChange',
              callback: (args) {
                controller!.updateValue(
                  controller!.value
                      .copyWith(playbackQuality: args.first as String),
                );
              },
            )
            ..addJavaScriptHandler(
              handlerName: 'PlaybackRateChange',
              callback: (args) {
                final num rate = args.first;
                controller!.updateValue(
                  controller!.value.copyWith(playbackRate: rate.toDouble()),
                );
              },
            )
            ..addJavaScriptHandler(
              handlerName: 'Errors',
              callback: (args) {
                controller!.updateValue(
                  controller!.value.copyWith(errorCode: args.first as int),
                );
              },
            )
            ..addJavaScriptHandler(
              handlerName: 'VideoData',
              callback: (args) {
                controller!.updateValue(
                  controller!.value.copyWith(
                      metaData: YoutubeMetaData.fromRawData(args.first)),
                );
              },
            )
            ..addJavaScriptHandler(
              handlerName: 'VideoTime',
              callback: (args) {
                final position = args.first * 1000;
                final num buffered = args.last;
                controller!.updateValue(
                  controller!.value.copyWith(
                    position: Duration(milliseconds: position.floor()),
                    buffered: buffered.toDouble(),
                  ),
                );
              },
            );
        },
        onLoadStop: (_, __) {
          _onLoadStopCalled = true;
          if (_isPlayerReady) {
            controller!.updateValue(
              controller!.value.copyWith(isReady: true),
            );
          }
        },
      ),
    );
  }

  String get player => '''
    <!DOCTYPE html>
    <html>
    <head>
        <style>
            html,
            body {
                margin: 0;
                padding: 0;
                background-color: #000000;
                overflow: hidden;
                position: fixed;
                height: 100%;
                width: 100%;
                pointer-events: none;
            }
        </style>
        <meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no'>
    </head>
    <body>
        <div id="player"></div>
        <script>
            var tag = document.createElement('script');
            tag.src = "https://www.youtube.com/iframe_api";
            var firstScriptTag = document.getElementsByTagName('script')[0];
            firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);
            var player;
            var timerId;
            function onYouTubeIframeAPIReady() {
                player = new YT.Player('player', {
                    height: '100%',
                    width: '100%',
                    videoId: '${controller!.initialVideoId}',
                    playerVars: {
                        'controls': 0,
                        'playsinline': 1,
                        'enablejsapi': 1,
                        'fs': 0,
                        'rel': 0,
                        'showinfo': 0,
                        'iv_load_policy': 3,
                        'modestbranding': 1,
                        'cc_load_policy': ${boolean(value: controller!.flags.enableCaption)},
                        'cc_lang_pref': '${controller!.flags.captionLanguage}',
                        'autoplay': ${boolean(value: controller!.flags.autoPlay)},
                        'start': ${controller!.flags.startAt},
                        'end': ${controller!.flags.endAt}
                    },
                    events: {
                        onReady: function(event) { window.flutter_inappwebview.callHandler('Ready'); },
                        onStateChange: function(event) { sendPlayerStateChange(event.data); },
                        onPlaybackQualityChange: function(event) { window.flutter_inappwebview.callHandler('PlaybackQualityChange', event.data); },
                        onPlaybackRateChange: function(event) { window.flutter_inappwebview.callHandler('PlaybackRateChange', event.data); },
                        onError: function(error) { window.flutter_inappwebview.callHandler('Errors', error.data); }
                    },
                });
            }
            function sendPlayerStateChange(playerState) {
                clearTimeout(timerId);
                window.flutter_inappwebview.callHandler('StateChange', playerState);
                if (playerState == 1) {
                    startSendCurrentTimeInterval();
                    sendVideoData(player);
                }
            }
            function sendVideoData(player) {
                var videoData = {
                    'duration': player.getDuration(),
                    'title': player.getVideoData().title,
                    'author': player.getVideoData().author,
                    'videoId': player.getVideoData().video_id
                };
                window.flutter_inappwebview.callHandler('VideoData', videoData);
            }
            function startSendCurrentTimeInterval() {
                timerId = setInterval(function () {
                    window.flutter_inappwebview.callHandler('VideoTime', player.getCurrentTime(), player.getVideoLoadedFraction());
                }, 100);
            }
            function play() {
                player.playVideo();
                return '';
            }
            function pause() {
                player.pauseVideo();
                return '';
            }
            function loadById(loadSettings) {
                player.loadVideoById(loadSettings);
                return '';
            }
            function cueById(cueSettings) {
                player.cueVideoById(cueSettings);
                return '';
            }
            function loadPlaylist(playlist, index, startAt) {
                player.loadPlaylist(playlist, 'playlist', index, startAt);
                return '';
            }
            function cuePlaylist(playlist, index, startAt) {
                player.cuePlaylist(playlist, 'playlist', index, startAt);
                return '';
            }
            function mute() {
                player.mute();
                return '';
            }
            function unMute() {
                player.unMute();
                return '';
            }
            function setVolume(volume) {
                player.setVolume(volume);
                return '';
            }
            function seekTo(position, seekAhead) {
                player.seekTo(position, seekAhead);
                return '';
            }
            function setSize(width, height) {
                player.setSize(width, height);
                return '';
            }
            function setPlaybackRate(rate) {
                player.setPlaybackRate(rate);
                return '';
            }
            function setTopMargin(margin) {
                document.getElementById("player").style.marginTop = margin;
                return '';
            }
        </script>
    </body>
    </html>
  ''';

  String boolean({required bool value}) => value == true ? "'1'" : "'0'";

  String get userAgent => controller!.flags.forceHD
      ? 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.90 Safari/537.36'
      : '';
}
