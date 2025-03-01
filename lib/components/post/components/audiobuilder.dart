import 'dart:math';

import 'package:bitnet/components/container/imagewithtext.dart';
import 'package:bitnet/components/loaders/loaders.dart';
import 'package:bitnet/components/post/components/postfile_model.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'dart:async';
import 'package:rxdart/rxdart.dart';

class AdjustSpeedContainer extends StatelessWidget {
  final Widget child;
  const AdjustSpeedContainer({
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
        child: child,
      ),
    );
  }
}


class AudioBuilderLocal extends StatefulWidget {
  final PostFile postfile;
  const AudioBuilderLocal({
    Key? key,
    required this.postfile,
  }) : super(key: key);

  @override
  State<AudioBuilderLocal> createState() => AudioBuilderLocalState();
}

class AudioBuilderLocalState extends State<AudioBuilderLocal>
    with WidgetsBindingObserver {
  bool isPlaying = false;
  final player = AudioPlayer();

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    try {
      player.setUrl(widget.postfile.file!.path);
    } catch (e) {
      print("Error loading audio source: $e");
    }
    player.playbackEventStream.listen((event) {},
        onError: (Object e, StackTrace stackTrace) {
          print('A stream error occurred: $e');
        });
    super.initState();
  }

  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    player.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      // Release the player's resources when not in use. We use "stop" so that
      // if the app resumes later, it will still remember what position to
      // resume from.
      player.stop();
    }
  }

  Stream<PositionData> get _positionDataStream =>
      Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
          player.positionStream,
          player.bufferedPositionStream,
          player.durationStream,
              (position, bufferedPosition, duration) => PositionData(
              position, bufferedPosition, duration ?? Duration.zero));

  @override
  Widget build(BuildContext context) {
    //alignment container is needed because container doesnt
    // know where to start to paint inside reordable listview otherwise
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        padding: const EdgeInsets.symmetric(
          horizontal: 10.0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            AudioControlButton(player),
            AdjustSpeedContainer(
              child: StreamBuilder<double>(
                stream: player.speedStream,
                builder: (context, snapshot) => GestureDetector(
                  child: Text("${snapshot.data?.toStringAsFixed(1)}x",
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  onTap: () {
                    showSliderDialog(
                      context: context,
                      title: "Adjust speed",
                      divisions: 10,
                      min: 0.5,
                      max: 2.0,
                      value: player.speed,
                      stream: player.speedStream,
                      onChanged: player.setSpeed,
                    );
                  },
                ),
              ),
            ),
            StreamBuilder<PositionData>(
              stream: _positionDataStream,
              builder: (context, snapshot) {
                final positionData = snapshot.data;
                return AudioSeekBar(
                  duration: positionData?.duration ?? Duration.zero,
                  position: positionData?.position ?? Duration.zero,
                  bufferedPosition:
                  positionData?.bufferedPosition ?? Duration.zero,
                  onChangeEnd: player.seek,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class AudioBuilderNetwork extends StatefulWidget {
  final String url;
  const AudioBuilderNetwork({
    Key? key,
    required this.url,
  }) : super(key: key);

  @override
  State<AudioBuilderNetwork> createState() => AudioBuilderNetworkState();
}

class AudioBuilderNetworkState extends State<AudioBuilderNetwork>
    with WidgetsBindingObserver {
  bool isPlaying = false;
  final player = AudioPlayer();

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    try {
      player.setUrl(widget.url);
    } catch (e) {
      print("Error loading audio source: $e");
    }
    player.playbackEventStream.listen((event) {},
        onError: (Object e, StackTrace stackTrace) {
          print('A stream error occurred: $e');
        });
    super.initState();
  }

  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    player.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      player.stop();
    }
  }

  Stream<PositionData> get _positionDataStream =>
      Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
          player.positionStream,
          player.bufferedPositionStream,
          player.durationStream,
              (position, bufferedPosition, duration) => PositionData(
              position, bufferedPosition, duration ?? Duration.zero));

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      child: Container(
        width: MediaQuery.of(context).size.width * 1,
        padding: const EdgeInsets.symmetric(
          horizontal: 10.0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            AudioControlButton(player),
            AdjustSpeedContainer(
              child: StreamBuilder<double>(
                stream: player.speedStream,
                builder: (context, snapshot) => GestureDetector(
                  child: Text("${snapshot.data?.toStringAsFixed(1)}x",
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  onTap: () {
                    showSliderDialog(
                      context: context,
                      title: "Adjust speed",
                      divisions: 10,
                      min: 0.5,
                      max: 2.0,
                      value: player.speed,
                      stream: player.speedStream,
                      onChanged: player.setSpeed,
                    );
                  },
                ),
              ),
            ),
            StreamBuilder<PositionData>(
              stream: _positionDataStream,
              builder: (context, snapshot) {
                final positionData = snapshot.data;
                return AudioSeekBar(
                  duration: positionData?.duration ?? Duration.zero,
                  position: positionData?.position ?? Duration.zero,
                  bufferedPosition:
                  positionData?.bufferedPosition ?? Duration.zero,
                  onChangeEnd: player.seek,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class AudioControlButton extends StatelessWidget {
  final AudioPlayer player;

  const AudioControlButton(this.player);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        StreamBuilder<PlayerState>(
        stream: player.playerStateStream,
        builder: (context, snapshot) {
          final playerState = snapshot.data;
          final processingState = playerState?.processingState;
          final playing = playerState?.playing;
          if (processingState == ProcessingState.loading ||
              processingState == ProcessingState.buffering) {
            return avatarGlowProgressAudio(context);
          } else if (playing != true) {
            return AudioButton(
              onTap: player.play,
              iconData: Icons.play_arrow_rounded,
            );
          } else if (processingState != ProcessingState.completed) {
            return AudioButton(
              onTap: player.pause,
              iconData: Icons.pause_rounded,
            );
          } else {
            return AudioButton(
              onTap: () => player.seek(Duration.zero),
              iconData: Icons.replay_rounded,
            );
          }
        },
      )
      ],
    );
  }

}

class AudioButton extends StatelessWidget {
  final VoidCallback onTap;
  final IconData iconData;

  const AudioButton({required this.onTap, required this.iconData, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, right: 10.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(40.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Icon(
              iconData,
              size: 20,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
      ),
    );
  }
}


class AudioComponentShape extends SliderComponentShape {
  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) => Size.zero;

  @override
  void paint(
      PaintingContext context,
      Offset center, {
        required Animation<double> activationAnimation,
        required Animation<double> enableAnimation,
        required bool isDiscrete,
        required TextPainter labelPainter,
        required RenderBox parentBox,
        required SliderThemeData sliderTheme,
        required TextDirection textDirection,
        required double value,
        required double textScaleFactor,
        required Size sizeWithOverflow,
      }) {}
}

class AudioSeekBar extends StatefulWidget {
  final Duration duration;
  final Duration position;
  final Duration bufferedPosition;
  final ValueChanged<Duration>? onChanged;
  final ValueChanged<Duration>? onChangeEnd;

  const AudioSeekBar({
    required this.duration,
    required this.position,
    required this.bufferedPosition,
    this.onChanged,
    this.onChangeEnd,
  });

  @override
  _AudioSeekBarState createState() => _AudioSeekBarState();
}

class _AudioSeekBarState extends State<AudioSeekBar> {
  double? _dragValue;
  late SliderThemeData _sliderThemeData;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _sliderThemeData = SliderTheme.of(context).copyWith(
        trackHeight: 1.0,
        thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6.0));
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.only(right: 20.0),
            height: 20,
            child: SliderTheme(
              data: _sliderThemeData.copyWith(
                thumbShape: AudioComponentShape(),
                activeTrackColor: Colors.grey,
                inactiveTrackColor: Colors.grey,
              ),
              child: ExcludeSemantics(
                child: Slider(
                  min: 0.0,
                  max: widget.duration.inMilliseconds.toDouble(),
                  value: min(widget.bufferedPosition.inMilliseconds.toDouble(),
                      widget.duration.inMilliseconds.toDouble()),
                  onChanged: (value) {
                    setState(() {
                      _dragValue = value;
                    });
                    if (widget.onChanged != null) {
                      widget.onChanged!(Duration(milliseconds: value.round()));
                    }
                  },
                  onChangeEnd: (value) {
                    if (widget.onChangeEnd != null) {
                      widget
                          .onChangeEnd!(Duration(milliseconds: value.round()));
                    }
                    _dragValue = null;
                  },
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(right: 20.0),
            height: 20,
            child: SliderTheme(
              data: _sliderThemeData.copyWith(
                inactiveTrackColor: Colors.transparent,
              ),
              child: Slider(
                activeColor: Colors.orange,
                thumbColor: Colors.orange,
                min: 0.0,
                max: widget.duration.inMilliseconds.toDouble(),
                value: min(
                    _dragValue ?? widget.position.inMilliseconds.toDouble(),
                    widget.duration.inMilliseconds.toDouble()),
                onChanged: (value) {
                  setState(() {
                    _dragValue = value;
                  });
                  if (widget.onChanged != null) {
                    widget.onChanged!(Duration(milliseconds: value.round()));
                  }
                },
                onChangeEnd: (value) {
                  if (widget.onChangeEnd != null) {
                    widget.onChangeEnd!(Duration(milliseconds: value.round()));
                  }
                  _dragValue = null;
                },
              ),
            ),
          ),
          Positioned(
            right: 0.0,
            bottom: 2.5,
            child: Text(
                RegExp(r'((^0*[1-9]\d*:)?\d{2}:\d{2})\.\d+$')
                    .firstMatch("$_remaining")
                    ?.group(1) ??
                    '$_remaining',
                style: Theme.of(context).textTheme.bodySmall),
          ),
        ],
      ),
    );
  }
  Duration get _remaining => widget.duration - widget.position;
}

class PositionData {
  final Duration position;
  final Duration bufferedPosition;
  final Duration duration;

  PositionData(this.position, this.bufferedPosition, this.duration);
}


void showSliderDialog({
  required BuildContext context,
  required String title,
  required int divisions,
  required double min,
  required double max,
  String valueSuffix = '',
  // TODO: Replace these two by ValueStream.
  required double value,
  required Stream<double> stream,
  required ValueChanged<double> onChanged,
}) {
  showDialog<void>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title, textAlign: TextAlign.center),
      content: StreamBuilder<double>(
        stream: stream,
        builder: (context, snapshot) => Container(
          height: 100.0,
          child: Column(
            children: [
              Text('${snapshot.data?.toStringAsFixed(1)}$valueSuffix',
                  style: const TextStyle(
                      fontFamily: 'Fixed',
                      fontWeight: FontWeight.bold,
                      fontSize: 24.0)),
              Slider(
                divisions: divisions,
                min: min,
                max: max,
                value: snapshot.data ?? value,
                onChanged: onChanged,
              ),
            ],
          ),
        ),
      ),
    ),
  );
}