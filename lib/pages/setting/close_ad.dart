import 'package:cool_ui/cool_ui.dart';
import 'package:dsm_helper/util/function.dart';
import 'package:dsm_helper/widgets/neu_back_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neumorphic/neumorphic.dart';
import 'package:pangle_flutter/pangle_flutter.dart';

class CloseAd extends StatefulWidget {
  const CloseAd({Key key}) : super(key: key);

  @override
  State<CloseAd> createState() => _CloseAdState();
}

class _CloseAdState extends State<CloseAd> {
  DateTime noAdTime;
  DateTime lastVideoTime;
  @override
  void initState() {
    Util.getStorage("no_ad_time").then((res) {
      if (res.isNotBlank) {
        setState(() {
          noAdTime = DateTime.parse(res);
        });
      }
    });
    Util.getStorage("last_video_time").then((res) {
      if (res.isNotBlank) {
        setState(() {
          lastVideoTime = DateTime.parse(res);
        });
      }
    });
    super.initState();
  }

  playVideo() async {
    Navigator.of(context).pop();
    var hide = showWeuiLoadingToast(context: context, message: Text("广告加载中"));
    try {
      PangleResult result = await pangle.loadRewardedVideoAd(
        iOS: IOSRewardedVideoConfig(slotId: "946681116"),
        android: AndroidRewardedVideoConfig(slotId: "946681017"),
      );
      if (result.code == 0) {
        if (noAdTime == null) {
          noAdTime = DateTime.now();
        }
        setState(() {
          noAdTime = noAdTime.add(Duration(days: 3));
        });
        lastVideoTime = DateTime.now();
        Util.toast("恭喜您成功获得3天免广告特权");
        Util.setStorage("no_ad_time", noAdTime.format("Y-m-d H:i:s"));
        Util.setStorage("last_video_time", lastVideoTime.format("Y-m-d H:i:s"));
      }
    } catch (e) {
      Util.toast("广告播放失败");
    } finally {
      hide();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: AppBackButton(context),
        title: Text("关闭广告"),
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          NeuCard(
            decoration: NeumorphicDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(20),
            ),
            bevel: 20,
            curveType: CurveType.flat,
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("广告状态："),
                  if (noAdTime == null)
                    Text("未关闭")
                  else
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(text: "关闭至"),
                          TextSpan(text: "${noAdTime.format("Y-m-d H:i:s")}", style: TextStyle(color: Colors.red)),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text("${Util.appName}是一款开源免费的APP，作者花费大量时间开发${Util.appName}，但是为爱发电终究无法维持最初的激情。\n为了能继续将${Util.appName}做强做好，在近期的版本中加入了开屏广告以获取一些微薄的收入。当然广告会让很多朋友（包括作者自己）反感，所以加入了一些措施来关闭开屏广告，希望大家能够理解和支持。"),
          SizedBox(
            height: 30,
          ),
          NeuCard(
            decoration: NeumorphicDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(20),
            ),
            bevel: 20,
            curveType: CurveType.flat,
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("关闭3天"),
                  Spacer(),
                  NeuButton(
                    onPressed: () {
                      if (lastVideoTime != null && lastVideoTime.isSameDay(DateTime.now())) {
                        Util.toast("今天已经领取过，明天再来吧~");
                        return;
                      }
                      showCupertinoDialog(
                        context: context,
                        builder: (context) {
                          return Material(
                            color: Colors.transparent,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                NeuCard(
                                  width: double.infinity,
                                  margin: EdgeInsets.symmetric(horizontal: 50),
                                  curveType: CurveType.emboss,
                                  bevel: 5,
                                  decoration: NeumorphicDecoration(
                                    color: Theme.of(context).scaffoldBackgroundColor,
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(20),
                                    child: Column(
                                      children: [
                                        Text(
                                          "关闭3天广告",
                                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                                        ),
                                        SizedBox(
                                          height: 16,
                                        ),
                                        NeuCard(
                                          decoration: NeumorphicDecoration(
                                            color: Theme.of(context).scaffoldBackgroundColor,
                                            borderRadius: BorderRadius.circular(20),
                                          ),
                                          bevel: 20,
                                          curveType: CurveType.flat,
                                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                          child: Text("通过观看视频广告，可关闭3天开屏广告"),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: NeuButton(
                                                onPressed: playVideo,
                                                decoration: NeumorphicDecoration(
                                                  color: Theme.of(context).scaffoldBackgroundColor,
                                                  borderRadius: BorderRadius.circular(25),
                                                ),
                                                bevel: 20,
                                                padding: EdgeInsets.symmetric(vertical: 10),
                                                child: Text(
                                                  "观看广告",
                                                  style: TextStyle(fontSize: 18),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 16,
                                            ),
                                            Expanded(
                                              child: NeuButton(
                                                onPressed: () async {
                                                  Navigator.of(context).pop();
                                                },
                                                decoration: NeumorphicDecoration(
                                                  color: Theme.of(context).scaffoldBackgroundColor,
                                                  borderRadius: BorderRadius.circular(25),
                                                ),
                                                bevel: 20,
                                                padding: EdgeInsets.symmetric(vertical: 10),
                                                child: Text(
                                                  "取消",
                                                  style: TextStyle(fontSize: 18),
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    decoration: NeumorphicDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    bevel: 5,
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 7),
                    child: Text(
                      "领取",
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          NeuCard(
            decoration: NeumorphicDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(20),
            ),
            bevel: 20,
            curveType: CurveType.flat,
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("关闭7天"),
                  Spacer(),
                  Text("敬请期待"),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          NeuCard(
            decoration: NeumorphicDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(20),
            ),
            bevel: 20,
            curveType: CurveType.flat,
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("关闭1个月"),
                  Spacer(),
                  Text("敬请期待"),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          NeuCard(
            decoration: NeumorphicDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(20),
            ),
            bevel: 20,
            curveType: CurveType.flat,
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("永久关闭"),
                  Spacer(),
                  Text("敬请期待"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
