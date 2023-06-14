import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:android_intent_plus/android_intent.dart';
import 'package:dsm_helper/util/function.dart';
import 'package:dsm_helper/widgets/neu_back_button.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:fplayer/fplayer.dart';
import 'package:neumorphic/neumorphic.dart';
import 'package:url_launcher/url_launcher_string.dart';
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
  final FPlayer player = FPlayer();
  bool fullScreen = false;
  _VideoPlayerState();
  String description = "";
  String date = "";
  String year = '';
  List actors = [];
  Map nfoDetail;

  int seekTime = 100000;
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
  void startPlay() async {
    // 视频播放相关配置
    await player.setOption(FOption.hostCategory, "enable-snapshot", 1);
    await player.setOption(FOption.hostCategory, "request-screen-on", 1);
    await player.setOption(FOption.hostCategory, "request-audio-focus", 1);
    await player.setOption(FOption.playerCategory, "reconnect", 20);
    await player.setOption(FOption.playerCategory, "framedrop", 20);
    await player.setOption(FOption.playerCategory, "enable-accurate-seek", 1);
    await player.setOption(FOption.playerCategory, "mediacodec", 1);
    await player.setOption(FOption.playerCategory, "packet-buffering", 0);
    await player.setOption(FOption.playerCategory, "soundtouch", 1);

    // 播放传入的视频
    setVideoUrl(widget.url);

    // 播放视频列表的第一个视频
    // setVideoUrl(videoList[videoIndex].url);
  }

  Future<void> setVideoUrl(String url) async {
    try {
      await player.setDataSource(url, autoPlay: true, showCover: true);
    } catch (error) {
      print("播放-异常: $error");
      return;
    }
  }

  // 倍速列表
  Map<String, double> speedList = {
    "2.0": 2.0,
    "1.5": 1.5,
    "1.0": 1.0,
    "0.5": 0.5,
  };
  @override
  initState() {
    // BetterPlayerConfiguration betterPlayerConfiguration = BetterPlayerConfiguration(
    //   fit: BoxFit.contain,
    //   autoPlay: true,
    //   autoDispose: true,
    //   looping: false,
    //   placeholder: _buildVideoPlaceholder(),
    //   showPlaceholderUntilPlay: true,
    //   allowedScreenSleep: false,
    //   translations: [
    //     BetterPlayerTranslations(
    //       languageCode: 'zh',
    //       overflowMenuPlaybackSpeed: "播放速度",
    //       overflowMenuSubtitles: "字幕",
    //       overflowMenuAudioTracks: "音频",
    //       overflowMenuQuality: "质量",
    //     )
    //   ],
    // );
    // BetterPlayerDataSource dataSource = BetterPlayerDataSource(
    //   widget.network ? BetterPlayerDataSourceType.network : BetterPlayerDataSourceType.file,
    //   widget.url,
    // );
    // _betterPlayerController = BetterPlayerController(betterPlayerConfiguration);
    // _betterPlayerController.setupDataSource(dataSource);
    // _betterPlayerController.setBetterPlayerControlsConfiguration(BetterPlayerControlsConfiguration(
    //   controlBarColor: Colors.black26,
    // ));
    // _betterPlayerController.addEventsListener((event) {
    //   if (event.betterPlayerEventType == BetterPlayerEventType.play) {
    //     _setPlaceholderVisibleState(false);
    //   }
    // });
    parseNfo();
    startPlay();
    super.initState();
  }

  // void _setPlaceholderVisibleState(bool hidden) {
  //   _placeholderStreamController.add(hidden);
  //   _showPlaceholder = hidden;
  // }

  ///_placeholderStreamController is used only to refresh video placeholder
  ///widget.
  // Widget _buildVideoPlaceholder() {
  //   return StreamBuilder<bool>(
  //     stream: _placeholderStreamController.stream,
  //     builder: (context, snapshot) {
  //       if (_showPlaceholder && widget.cover.isNotBlank) {
  //         if (widget.cover.startsWith("http")) {
  //           return ExtendedImage.network(widget.cover);
  //         } else {
  //           return ExtendedImage.network(Util.baseUrl + "/webapi/entry.cgi?path=${Uri.encodeComponent(widget.cover)}&size=original&api=SYNO.FileStation.Thumb&method=get&version=2&_sid=${Util.sid}&animate=true");
  //         }
  //       } else {
  //         return SizedBox();
  //       }
  //     },
  //   );
  // }

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
                if (Platform.isAndroid) {
                  AndroidIntent intent = AndroidIntent(
                    action: 'action_view',
                    data: widget.url,
                    arguments: {},
                    type: "video/*",
                  );
                  await intent.launch();
                } else {
                  launchUrlString("vlc://${widget.url}");
                }
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
          FView(
            player: player,
            width: double.infinity,
            height: MediaQuery.of(context).size.width * 9 / 16,
            color: Colors.black,
            fsFit: FFit.contain, // 全屏模式下的填充
            fit: FFit.contain, // 正常模式下的填充
            cover: widget.cover != null ? ExtendedNetworkImageProvider(Util.baseUrl + "/webapi/entry.cgi?path=${Uri.encodeComponent(widget.cover)}&size=original&api=SYNO.FileStation.Thumb&method=get&version=2&_sid=${Util.sid}&animate=true") : null,

            panelBuilder: fPanelBuilder(
              // 单视频配置
              title: widget.name,
              // subTitle: '视频副标题',
              // 右下方截屏按钮
              isSnapShot: false,
              // 右上方按钮组开关
              isRightButton: false,
              // 右上方按钮组
              // rightButtonList: [
              //   InkWell(
              //     onTap: () {},
              //     child: Container(
              //       padding: const EdgeInsets.all(10),
              //       decoration: BoxDecoration(
              //         color: Theme.of(context).primaryColorLight,
              //         borderRadius: const BorderRadius.vertical(
              //           top: Radius.circular(5),
              //         ),
              //       ),
              //       child: Icon(
              //         Icons.favorite,
              //         color: Theme.of(context).primaryColor,
              //       ),
              //     ),
              //   ),
              //   InkWell(
              //     onTap: () {},
              //     child: Container(
              //       padding: const EdgeInsets.all(10),
              //       decoration: BoxDecoration(
              //         color: Theme.of(context).primaryColorLight,
              //         borderRadius: const BorderRadius.vertical(
              //           bottom: Radius.circular(5),
              //         ),
              //       ),
              //       child: Icon(
              //         Icons.thumb_up,
              //         color: Theme.of(context).primaryColor,
              //       ),
              //     ),
              //   )
              // ],
              // 字幕功能：待内核提供api
              // caption: true,
              // 视频列表开关
              isVideos: false,
              // 视频列表列表
              // videoList: videoList,
              // 当前视频索引
              // videoIndex: videoIndex,
              // 全屏模式下点击播放下一集视频按钮
              // playNextVideoFun: () {
              //   setState(() {
              //     videoIndex += 1;
              //   });
              // },
              settingFun: () {
                print('设置按钮点击事件');
              },
              // 自定义倍速列表
              speedList: speedList,
              // 清晰度开关
              // isResolution: true,
              // 自定义清晰度列表
              // resolutionList: resolutionList,
              // 视频播放错误点击刷新回调
              // onError: () async {
              //   await player.reset();
              //   setVideoUrl(videoList[videoIndex].url);
              // },
              // 视频播放完成回调
              // onVideoEnd: () async {
              //   var index = videoIndex + 1;
              //   if (index < videoList.length) {
              //     await player.reset();
              //     setState(() {
              //       videoIndex = index;
              //     });
              //     setVideoUrl(videoList[index].url);
              //   }
              // },
              onVideoTimeChange: () {
                // 视频时间变动则触发一次，可以保存视频播放历史
              },
              // onVideoPrepared: () async {
              //   // 视频初始化完毕，如有历史记录时间段则可以触发快进
              //   try {
              //     if (seekTime >= 1) {
              //       /// seekTo必须在FState.prepared
              //       print('seekTo');
              //       await player.seekTo(seekTime);
              //       // print("视频快进-$seekTime");
              //       seekTime = 0;
              //     }
              //   } catch (error) {
              //     print("视频初始化完快进-异常: $error");
              //   }
              // },
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                // Text("${widget.url}"),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    "注意：视频播放器目前并不稳定，如遇到黑屏、无声、卡顿等任何问题，请点击右上角按钮使用第三方播放器播放！${Platform.isIOS ? '(仅支持vlc player，请确保已安装)' : ''}",
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
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
                if (actors != null && actors.length > 0) ...[
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
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() async {
    super.dispose();
    // try {
    //   await ScreenBrightness().resetScreenBrightness();
    // } catch (e) {
    //   print(e);
    //   throw 'Failed to reset brightness';
    // }
    player.release();
    // _placeholderStreamController.close();
  }
}
