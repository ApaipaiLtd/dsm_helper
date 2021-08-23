import 'package:android_intent/android_intent.dart';
import 'package:dsm_helper/widgets/neu_back_button.dart';
import 'package:fijkplayer/fijkplayer.dart';
import 'package:flutter/material.dart';
import 'package:neumorphic/neumorphic.dart';

class VideoPlayer extends StatefulWidget {
  final String name;
  final String url;

  VideoPlayer({@required this.url, this.name});

  @override
  _VideoPlayerState createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  final FijkPlayer player = FijkPlayer();
  bool fullScreen = false;
  _VideoPlayerState();

  @override
  void initState() {
    super.initState();
    player.setDataSource(widget.url, autoPlay: true);
    player.addListener(() {
      FijkValue value = player.value;
      setState(() {
        fullScreen = value.fullScreen;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name ?? '视频播放'),
        leading: AppBackButton(context),
        actions: [
          Padding(
            padding: EdgeInsets.only(left: 0, top: 8, bottom: 8, right: 8),
            child: NeuButton(
              decoration: NeumorphicDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.all(10),
              bevel: 5,
              onPressed: () async {
                AndroidIntent intent = AndroidIntent(
                  action: 'action_view',
                  data: widget.url,
                  arguments: {},
                  type: "video/*",
                );
                await intent.launch();
              },
              child: Image.asset(
                "assets/icons/player.png",
                width: 20,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.width,
            alignment: Alignment.center,
            child: FijkView(
              player: player,
              color: fullScreen
                  ? Colors.black
                  : Theme.of(context).scaffoldBackgroundColor,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text("注意：视频播放器目前并不稳定，如遇到黑屏、无声、卡顿等任何问题，请点击右上角按钮使用第三方播放器播放！")
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    player.release();
  }
}
