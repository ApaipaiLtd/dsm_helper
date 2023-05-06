import 'package:dsm_helper/pages/photos/album_tab.dart';
import 'package:dsm_helper/pages/photos/folder.dart';
import 'package:dsm_helper/pages/photos/photo_tab.dart';
import 'package:dsm_helper/pages/photos/share_tab.dart';
import 'package:dsm_helper/pages/photos/timeline.dart';
import 'package:dsm_helper/widgets/neu_back_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neumorphic/neumorphic.dart';

class Photos extends StatefulWidget {
  const Photos({Key key}) : super(key: key);

  @override
  State<Photos> createState() => _PhotosState();
}

class _PhotosState extends State<Photos> {
  int currentIndex = 0;
  bool isTeam = false;
  bool isTimeline = true;
  GlobalKey<TimelineState> timelineKey = GlobalKey();
  GlobalKey<FolderState> folderKey = GlobalKey();
  GlobalKey<AlbumTabState> albumTabKey = GlobalKey();
  @override
  void initState() {
    // 获取
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: AppBackButton(context),
        title: NeuSwitch(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          thumbColor: Theme.of(context).scaffoldBackgroundColor,
          children: {
            0: Text("图片"),
            1: Text("相册"),
            2: Text("共享"),
          },
          groupValue: currentIndex,
          onValueChanged: (v) {
            setState(() {
              currentIndex = v;
            });
          },
        ),
        actions: [
          if (currentIndex != 2)
            Padding(
              padding: EdgeInsets.only(right: 10, top: 8, bottom: 8),
              child: NeuButton(
                onPressed: () {
                  showCupertinoModalPopup(
                    context: context,
                    builder: (context) {
                      return Material(
                        color: Colors.transparent,
                        child: NeuCard(
                          width: double.infinity,
                          // padding: EdgeInsets.all(22),
                          bevel: 5,
                          curveType: CurveType.emboss,
                          decoration: NeumorphicDecoration(color: Theme.of(context).scaffoldBackgroundColor, borderRadius: BorderRadius.vertical(top: Radius.circular(22))),
                          child: SafeArea(
                            top: false,
                            child: Padding(
                              padding: EdgeInsets.all(22),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  NeuButton(
                                    onPressed: () async {
                                      setState(() {
                                        isTeam = !isTeam;
                                      });
                                      if (isTimeline) {
                                        timelineKey.currentState.getData(isTeam: isTeam);
                                      } else {
                                        folderKey.currentState.getData(isTeam: isTeam);
                                      }
                                      albumTabKey.currentState.getData(isTeam: isTeam);
                                      Navigator.of(context).pop();
                                    },
                                    decoration: NeumorphicDecoration(
                                      color: Theme.of(context).scaffoldBackgroundColor,
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    bevel: 5,
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    child: Text(
                                      "切换到${isTeam ? '个人空间' : '共享空间'}",
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 16,
                                  ),
                                  if (currentIndex == 0) ...[
                                    NeuButton(
                                      onPressed: () async {
                                        Navigator.of(context).pop();
                                        setState(() {
                                          isTimeline = !isTimeline;
                                        });
                                        if (isTimeline) {
                                          timelineKey.currentState.getData(isTeam: isTeam);
                                        } else {
                                          folderKey.currentState.getData(isTeam: isTeam);
                                        }
                                      },
                                      decoration: NeumorphicDecoration(
                                        color: Theme.of(context).scaffoldBackgroundColor,
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                      bevel: 5,
                                      padding: EdgeInsets.symmetric(vertical: 10),
                                      child: Text(
                                        "切换到${isTimeline ? '文件夹' : '时间线'}视图",
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 16,
                                    ),
                                  ],
                                  NeuButton(
                                    onPressed: () async {
                                      Navigator.of(context).pop();
                                    },
                                    decoration: NeumorphicDecoration(
                                      color: Theme.of(context).scaffoldBackgroundColor,
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    bevel: 5,
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    child: Text(
                                      "取消",
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
                padding: EdgeInsets.all(10),
                decoration: NeumorphicDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                bevel: 5,
                child: Image.asset(
                  "assets/icons/actions.png",
                  width: 20,
                  height: 20,
                ),
              ),
            ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: IndexedStack(
              index: currentIndex,
              children: [
                PhotoTab(
                  isTeam,
                  isTimeline,
                  timelineKey: timelineKey,
                  folderKey: folderKey,
                ),
                AlbumTab(
                  isTeam,
                  key: albumTabKey,
                ),
                ShareTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
