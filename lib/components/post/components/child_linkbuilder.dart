import 'package:bitnet/components/post/components/audiobuilder.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

/// A widget to display playback speed changing button.
/// customized from https://github.com/sarbagyastha/youtube_player_flutter/blob/master/packages/youtube_player_flutter/lib/src/widgets/playback_speed_button.dart
class PlaybackSpeedButtonCustom extends StatefulWidget {
  /// Overrides the default [YoutubePlayerController].
  final YoutubePlayerController? controller;
  final double? fontSize;

  /// Defines icon for the button.

  /// Creates [PlaybackSpeedButtonCustom] widget.
  const PlaybackSpeedButtonCustom({this.controller, this.fontSize});

  @override
  _PlaybackSpeedButtonCustomState createState() =>
      _PlaybackSpeedButtonCustomState();
}

class _PlaybackSpeedButtonCustomState extends State<PlaybackSpeedButtonCustom> {
  late YoutubePlayerController _controller;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final controller = YoutubePlayerController.of(context);
    if (controller == null) {
      assert(
        widget.controller != null,
        '\n\nNo controller could be found in the provided context.\n\n'
        'Try passing the controller explicitly.',
      );
      _controller = widget.controller!;
    } else {
      _controller = controller;
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<double>(
      onSelected: _controller.setPlaybackRate,
      child: Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 8.0, 0.0, 8.0),
          child: AdjustSpeedContainer(
            child: Text(
              "${_controller.value.playbackRate}x",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: widget.fontSize ?? 14.0),
            ),
          )),
      tooltip: 'PlayBack Rate',
      itemBuilder: (context) => [
        _popUpItem('2.0x', PlaybackRate.twice),
        _popUpItem('1.75x', PlaybackRate.oneAndAThreeQuarter),
        _popUpItem('1.5x', PlaybackRate.oneAndAHalf),
        _popUpItem('1.25x', PlaybackRate.oneAndAQuarter),
        _popUpItem('Normal', PlaybackRate.normal),
        _popUpItem('0.75x', PlaybackRate.threeQuarter),
        _popUpItem('0.5x', PlaybackRate.half),
        _popUpItem('0.25x', PlaybackRate.quarter),
      ],
    );
  }

  PopupMenuEntry<double> _popUpItem(String text, double rate) {
    return CheckedPopupMenuItem(
      checked: _controller.value.playbackRate == rate,
      child: Text(text),
      value: rate,
    );
  }
}
