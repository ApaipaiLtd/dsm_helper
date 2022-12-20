import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:android_intent_plus/android_intent.dart';
import 'package:better_player/better_player.dart';
import 'package:dsm_helper/util/function.dart';
import 'package:dsm_helper/widgets/neu_back_button.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:neumorphic/neumorphic.dart';
import 'package:xml2json/xml2json.dart';

class VideoPlayer extends StatefulWidget {
  final String name;
  final String url;
  final String cover;
  final String nfo;
  final bool network;
  VideoPlayer({@required this.url, this.name, this.cover, this.nfo, this.network: true});

  @override
  _VideoPlayerState createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  BetterPlayerController _betterPlayerController;
  StreamController<bool> _placeholderStreamController = StreamController.broadcast();
  bool _showPlaceholder = true;
  bool fullScreen = false;
  _VideoPlayerState();
  String description = "";
  String date = "";
  String year = '';
  List actors = [];
  Map nfoDetail;
  // @override
  // void initState() {
  //   super.initState();
  //
  //   player.setDataSource(widget.url, autoPlay: true);
  //   player.addListener(() {
  //     FijkValue value = player.value;
  //     print(value.size);
  //     if (mounted) {
  //       setState(() {
  //         fullScreen = value.fullScreen;
  //       });
  //     }
  //   });
  //
  // }
  @override
  initState() {
    BetterPlayerConfiguration betterPlayerConfiguration = BetterPlayerConfiguration(
      fit: BoxFit.contain,
      autoPlay: true,
      autoDispose: true,
      looping: false,
      placeholder: _buildVideoPlaceholder(),
      showPlaceholderUntilPlay: true,
      allowedScreenSleep: false,
      translations: [
        BetterPlayerTranslations(
          languageCode: 'zh',
          overflowMenuPlaybackSpeed: "播放速度",
          overflowMenuSubtitles: "字幕",
          overflowMenuAudioTracks: "音频",
          overflowMenuQuality: "质量",
        )
      ],
    );
    BetterPlayerDataSource dataSource = BetterPlayerDataSource(
      widget.network ? BetterPlayerDataSourceType.network : BetterPlayerDataSourceType.file,
      widget.url,
    );
    _betterPlayerController = BetterPlayerController(betterPlayerConfiguration);
    _betterPlayerController.setupDataSource(dataSource);
    _betterPlayerController.setBetterPlayerControlsConfiguration(BetterPlayerControlsConfiguration(
      controlBarColor: Colors.black26,
    ));
    _betterPlayerController.addEventsListener((event) {
      if (event.betterPlayerEventType == BetterPlayerEventType.play) {
        _setPlaceholderVisibleState(false);
      }
    });
    parseNfo();
    super.initState();
  }

  void _setPlaceholderVisibleState(bool hidden) {
    _placeholderStreamController.add(hidden);
    _showPlaceholder = hidden;
  }

  ///_placeholderStreamController is used only to refresh video placeholder
  ///widget.
  Widget _buildVideoPlaceholder() {
    return StreamBuilder<bool>(
      stream: _placeholderStreamController.stream,
      builder: (context, snapshot) {
        if (_showPlaceholder && widget.cover.isNotBlank) {
          if (widget.cover.startsWith("http")) {
            return ExtendedImage.network(widget.cover);
          } else {
            return ExtendedImage.network(Util.baseUrl + "/webapi/entry.cgi?path=${Uri.encodeComponent(widget.cover)}&size=original&api=SYNO.FileStation.Thumb&method=get&version=2&_sid=${Util.sid}&animate=true");
          }
        } else {
          return SizedBox();
        }
      },
    );
  }

  parseNfo() async {
    if (widget.nfo != null) {
      final myTransformer = Xml2Json();
      String nfoUrl = Util.baseUrl + "/fbdownload/info.nfo?dlink=%22${Util.utf8Encode(widget.nfo)}%22&_sid=%22${Util.sid}%22&mode=open";
      var res = await Util.get(nfoUrl, decode: false);
      try {
        myTransformer.parse(res);
        var json = jsonDecode(myTransformer.toParker());
        setState(() {
          nfoDetail = json['episodedetails'] ?? json['movie'];
          description = nfoDetail['plot'];
          date = nfoDetail['dateadded'];
          actors = nfoDetail['actor'];
          year = nfoDetail['year'];
        });
      } catch (e) {}
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name ?? '视频播放'),
        leading: AppBackButton(context),
        actions: [
          if (Platform.isAndroid)
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
                  // player.pause();
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
          // Container(
          //   width: MediaQuery.of(context).size.width,
          //   height: MediaQuery.of(context).size.width * 9 / 16,
          //   alignment: Alignment.center,
          //   child: FijkView(
          //     width: MediaQuery.of(context).size.width,
          //     height: MediaQuery.of(context).size.width * 9 / 16,
          //     fit: FijkFit.contain,
          //     player: player,
          //     color: Colors.black,
          //     cover: widget.cover != null ? ExtendedNetworkImageProvider(Util.baseUrl + "/webapi/entry.cgi?path=${Uri.encodeComponent(widget.cover)}&size=original&api=SYNO.FileStation.Thumb&method=get&version=2&_sid=${Util.sid}&animate=true") : null,
          //   ),
          // ),
          AspectRatio(
            aspectRatio: 16 / 9,
            child: BetterPlayer(
              controller: _betterPlayerController,
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                // Text("${widget.url}"),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Text("注意：视频播放器目前并不稳定，如遇到黑屏、无声、卡顿等任何问题，请点击右上角按钮使用第三方播放器播放！（iOS暂不支持）"),
                ),
                if (widget.nfo != null && nfoDetail != null)
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text("以下信息来源于同文件夹下NFO文件，仅做参考："),
                  ),
                SizedBox(
                  height: 20,
                ),
                if (description.isNotBlank)
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: Text(description),
                  ),
                SizedBox(
                  height: 10,
                ),
                if (year.isNotBlank)
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: Text("年份：$year"),
                  ),
                SizedBox(
                  height: 10,
                ),
                if (date.isNotBlank)
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: Text("添加时间：$date"),
                  ),
                SizedBox(
                  height: 20,
                ),
                if (actors.length > 0)
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: Text("演员表："),
                  ),
                ...actors.map(
                  (e) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: Text("${e['role']}"),
                        ),
                        Expanded(
                          child: Text("${e['name']}"),
                        ),
                        Expanded(
                          child: Text("${e['type']}"),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _placeholderStreamController.close();
  }
}
