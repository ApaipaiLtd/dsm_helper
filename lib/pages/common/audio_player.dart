import 'dart:math';

import 'package:dsm_helper/providers/audio_player_provider.dart';
import 'package:dsm_helper/themes/app_theme.dart';
import 'package:dsm_helper/widgets/neu_back_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart' as ja;
import 'package:neumorphic/neumorphic.dart';
import 'package:provider/provider.dart';

class AudioPlayer extends StatefulWidget {
  AudioPlayer({this.name, this.url, Key key}) : super(key: key);
  final String name;
  final String url;
  @override
  State<AudioPlayer> createState() => _AudioPlayerState();
}

class _AudioPlayerState extends State<AudioPlayer> {
  ja.AudioPlayer player = ja.AudioPlayer();
  String title = "";
  @override
  void initState() {
    var audioPlayerProvider = context.read<AudioPlayerProvider>();
    player = audioPlayerProvider.player;
    if (widget.url != null) {
      title = widget.name ?? "";
      if (audioPlayerProvider.url != widget.url) {
        audioPlayerProvider.setUrl(widget.url, title);
        setSource();
      }
    } else {
      title = audioPlayerProvider.name;
    }
    setState(() {});
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  setSource() async {
    await player.setUrl(widget.url);
    await player.play();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: AppBackButton(context),
        title: Text(title),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Image.asset(
                      "assets/music_cover.png",
                      width: 300,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(title),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            ControlButtons(player),
            SeekBar(
              player: player,
              onChangeEnd: (newPosition) {
                player.seek(newPosition);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class PositionData {
  final Duration position;
  final Duration bufferedPosition;
  final Duration duration;

  PositionData(this.position, this.bufferedPosition, this.duration);
}

class ControlButtons extends StatelessWidget {
  final ja.AudioPlayer player;

  const ControlButtons(this.player, {Key key}) : super(key: key);
  void showSliderDialog({
    @required BuildContext context,
    @required String title,
    @required int divisions,
    @required double min,
    @required double max,
    String valueSuffix = '',
    // TODO: Replace these two by ValueStream.
    @required double value,
    @required Stream<double> stream,
    @required ValueChanged<double> onChanged,
  }) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title, textAlign: TextAlign.center),
        content: StreamBuilder<double>(
          stream: stream,
          builder: (context, snapshot) => SizedBox(
            height: 100.0,
            child: Column(
              children: [
                Text('${snapshot.data?.toStringAsFixed(1)}$valueSuffix', style: const TextStyle(fontFamily: 'Fixed', fontWeight: FontWeight.bold, fontSize: 24.0)),
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

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        NeuButton(
          child: const Icon(Icons.volume_up),
          decoration: NeumorphicDecoration(
            shape: BoxShape.circle,
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
          bevel: 10,
          onPressed: () {
            showSliderDialog(
              context: context,
              title: "音量",
              divisions: 10,
              min: 0.0,
              max: 1.0,
              value: player.volume,
              stream: player.volumeStream,
              onChanged: player.setVolume,
            );
          },
        ),
        // StreamBuilder<ja.SequenceState>(
        //   stream: player.sequenceStateStream,
        //   builder: (context, snapshot) => IconButton(
        //     icon: const Icon(Icons.skip_previous),
        //     onPressed: player.hasPrevious ? player.seekToPrevious : null,
        //   ),
        // ),
        SizedBox(
          width: 30,
        ),
        StreamBuilder<ja.PlayerState>(
          stream: player.playerStateStream,
          builder: (context, snapshot) {
            final playerState = snapshot.data;
            final processingState = playerState?.processingState;
            final playing = playerState?.playing;
            if (processingState == ja.ProcessingState.loading || processingState == ja.ProcessingState.buffering) {
              return NeuButton(
                child: const CupertinoActivityIndicator(
                  radius: 32,
                ),
                decoration: NeumorphicDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).scaffoldBackgroundColor,
                ),
                bevel: 10,
                onPressed: player.play,
              );
            } else if (playing != true) {
              return NeuButton(
                child: const Icon(
                  Icons.play_arrow,
                  size: 64,
                ),
                decoration: NeumorphicDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).scaffoldBackgroundColor,
                ),
                bevel: 10,
                onPressed: player.play,
              );
            } else if (processingState != ja.ProcessingState.completed) {
              return NeuButton(
                child: const Icon(
                  Icons.pause,
                  size: 64,
                ),
                decoration: NeumorphicDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).scaffoldBackgroundColor,
                ),
                bevel: 10,
                onPressed: player.pause,
              );
            } else {
              return NeuButton(
                child: const Icon(
                  Icons.play_arrow,
                  size: 64,
                ),
                decoration: NeumorphicDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).scaffoldBackgroundColor,
                ),
                bevel: 10,
                onPressed: () => player.seek(Duration.zero, index: player.effectiveIndices.first),
              );
            }
          },
        ),
        // StreamBuilder<ja.SequenceState>(
        //   stream: player.sequenceStateStream,
        //   builder: (context, snapshot) => IconButton(
        //     icon: const Icon(Icons.skip_next),
        //     onPressed: player.hasNext ? player.seekToNext : null,
        //   ),
        // ),
        SizedBox(
          width: 30,
        ),
        StreamBuilder<double>(
          stream: player.speedStream,
          builder: (context, snapshot) => NeuButton(
            child: Text("${snapshot.data?.toStringAsFixed(1)}x", style: const TextStyle(fontWeight: FontWeight.bold)),
            decoration: NeumorphicDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
            bevel: 10,
            onPressed: () {
              showSliderDialog(
                context: context,
                title: "速度",
                divisions: 10,
                min: 0.5,
                max: 1.5,
                value: player.speed,
                stream: player.speedStream,
                onChanged: player.setSpeed,
              );
            },
          ),
        ),
      ],
    );
  }
}

class SeekBar extends StatefulWidget {
  final ja.AudioPlayer player;
  final ValueChanged<Duration> onChanged;
  final ValueChanged<Duration> onChangeEnd;

  const SeekBar({
    Key key,
    @required this.player,
    this.onChanged,
    this.onChangeEnd,
  }) : super(key: key);

  @override
  SeekBarState createState() => SeekBarState();
}

class HiddenThumbComponentShape extends SliderComponentShape {
  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) => Size.zero;

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    @required Animation<double> activationAnimation,
    @required Animation<double> enableAnimation,
    @required bool isDiscrete,
    @required TextPainter labelPainter,
    @required RenderBox parentBox,
    @required SliderThemeData sliderTheme,
    @required TextDirection textDirection,
    @required double value,
    @required double textScaleFactor,
    @required Size sizeWithOverflow,
  }) {}
}

class SeekBarState extends State<SeekBar> {
  double _dragValue;
  SliderThemeData _sliderThemeData;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _sliderThemeData = SliderTheme.of(context).copyWith(
      trackHeight: 2.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SliderTheme(
          data: _sliderThemeData.copyWith(
            thumbShape: HiddenThumbComponentShape(),
            activeTrackColor: Colors.blue.shade100,
            inactiveTrackColor: Colors.grey.shade300,
          ),
          child: ExcludeSemantics(
            child: StreamBuilder(
              stream: widget.player.bufferedPositionStream,
              builder: (BuildContext context, AsyncSnapshot<Duration> snapshot) {
                Duration _duration = widget.player.duration ?? Duration.zero;
                Duration _position = snapshot.data ?? Duration.zero;
                return Slider(
                  min: 0.0,
                  max: _duration.inMilliseconds.toDouble(),
                  value: min(_position.inMilliseconds.toDouble(), _duration.inMilliseconds.toDouble()),
                  onChanged: (value) {
                    setState(() {
                      _dragValue = value;
                    });
                    widget.onChanged?.call(Duration(milliseconds: value.round()));
                  },
                  onChangeEnd: (value) {
                    widget.onChangeEnd?.call(Duration(milliseconds: value.round()));
                    _dragValue = null;
                  },
                );
              },
            ),
          ),
        ),
        StreamBuilder(
          stream: widget.player.positionStream,
          builder: (BuildContext context, AsyncSnapshot<Duration> snapshot) {
            Duration _duration = widget.player.duration ?? Duration.zero;
            Duration _position = snapshot.data ?? Duration.zero;
            Duration _remaining = _duration - _position;
            return Column(
              children: [
                Slider(
                  min: 0.0,
                  max: _duration.inMilliseconds.toDouble(),
                  value: min(_dragValue ?? _position.inMilliseconds.toDouble(), _duration.inMilliseconds.toDouble()),
                  onChanged: (value) {
                    setState(() {
                      _dragValue = value;
                    });
                    widget.onChanged?.call(Duration(milliseconds: value.round()));
                  },
                  onChangeEnd: (value) {
                    widget.onChangeEnd?.call(Duration(milliseconds: value.round()));
                    _dragValue = null;
                  },
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(RegExp(r'((^0*[1-9]\d*:)?\d{2}:\d{2})\.\d+$').firstMatch("$_position")?.group(1) ?? '$_position', style: TextStyle(color: AppTheme.of(context).placeholderColor, fontSize: 12)),
                      Text(RegExp(r'((^0*[1-9]\d*:)?\d{2}:\d{2})\.\d+$').firstMatch("$_remaining")?.group(1) ?? '$_remaining', style: TextStyle(color: AppTheme.of(context).placeholderColor, fontSize: 12))
                    ],
                  ),
                )
              ],
            );
          },
        ),
      ],
    );
  }
}
