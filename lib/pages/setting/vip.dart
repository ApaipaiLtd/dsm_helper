import 'dart:async';

import 'package:cool_ui/cool_ui.dart';
import 'package:dsm_helper/pages/setting/vip_login.dart';
import 'package:dsm_helper/pages/setting/vip_record.dart';
import 'package:dsm_helper/themes/app_theme.dart';
import 'package:dsm_helper/util/function.dart';
import 'package:dsm_helper/widgets/neu_back_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluwx/fluwx.dart';
import 'package:neumorphic/neumorphic.dart';
import 'package:pangle_flutter/pangle_flutter.dart';

class Vip extends StatefulWidget {
  const Vip({Key key}) : super(key: key);

  @override
  State<Vip> createState() => _VipState();
}

class _VipState extends State<Vip> {
  DateTime noAdTime;
  DateTime vipExpireTime;
  DateTime lastVideoTime;
  bool isLogin = false;
  bool isForever = false;
  String outTradeNo = "";
  String userToken = "";
  Timer timer;
  @override
  void initState() {
    weChatResponseEventHandler.distinct((a, b) => a == b).listen(wechatListener);
    initData();

    super.initState();
  }

  void wechatListener(res) {
    if (res is WeChatAuthResponse) {
      setState(() {
        login(res.code);
      });
    } else if (res is WeChatPaymentResponse) {
      setState(() {
        if (res.isSuccessful) {
          checkPayment();
        } else {
          if (res.errCode == -2) {
            Util.toast("已取消支付");
          } else {
            Util.toast(res.errStr.isNotBlank ? res.errStr : '支付失败');
          }
        }
      });
    }
  }

  checkPayment() async {
    var hide = showWeuiLoadingToast(context: context, backButtonClose: true);
    timer = Timer.periodic(Duration(seconds: 1), (_) async {
      var res = await Util.post("${Util.appUrl}/payment/check", data: {"out_trade_no": outTradeNo});
      if (res['code'] == 1) {
        Util.toast("支付成功");
        timer.cancel();
        initData(tips: true);
        hide();
      }
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  initData({bool tips = false}) async {
    String noAdTimeStr = await Util.getStorage("no_ad_time");
    if (noAdTimeStr.isNotBlank) {
      noAdTime = DateTime.parse(noAdTimeStr);
      if (noAdTime.isBefore(DateTime.now())) {
        Util.removeStorage("no_ad_time");
        noAdTime = null;
      }
    }
    String lastVideoTimeStr = await Util.getStorage("last_video_time");
    if (lastVideoTimeStr.isNotBlank) {
      setState(() {
        lastVideoTime = DateTime.parse(lastVideoTimeStr);
      });
    }
    userToken = await Util.getStorage("user_token");
    if (userToken.isNotBlank) {
      var res = await Util.post("${Util.appUrl}/vip/info", data: {"token": userToken});
      if (res['code'] == 1) {
        isLogin = true;
        if (res['data']['is_forever'] == 1) {
          isForever = Util.vipForever = true;
        }
        // isForever = Util.vipForever = true;
        if (res['data']['vip_expire_time'] != null) {
          Util.vipExpireTime = vipExpireTime = DateTime.parse(res['data']['vip_expire_time']);
          if (noAdTime == null) {
            if (vipExpireTime.isAfter(DateTime.now())) {
              noAdTime = vipExpireTime;
            }
          } else {
            if (vipExpireTime.isAfter(noAdTime)) {
              noAdTime = vipExpireTime;
            }
          }
        }
      }
    }
    setState(() {});
  }

  login(String code) async {
    var hide = showWeuiLoadingToast(context: context);
    try {
      var res = await Util.post("${Util.appUrl}/login/app", data: {"code": code});
      if (res['code'] == 1) {
        Util.setStorage("user_openid", res['data']['openid']);
        Util.setStorage("user_token", res['data']['token']);
        setState(() {
          isLogin = true;
        });
        Util.toast("登录成功");
        initData();
      } else {
        Util.toast(res['msg']);
      }
    } catch (e) {
      Util.toast("登录失败：${e.message}");
    } finally {
      hide();
    }
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

  close3() {
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
  }

  close7() {
    if (!isLogin) {
      loginDialog();
    } else {
      String code = "";
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
                          "积分兑换",
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Text(
                          '关注群晖助手公众号，在聊天窗口回复"10006"获取兑换码',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
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
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                          child: TextField(
                            onChanged: (v) => code = v,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "请输入兑换码",
                              labelText: "兑换码",
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: NeuButton(
                                onPressed: () async {
                                  if (code.trim() == "") {
                                    Util.toast("请输入兑换码");
                                    return;
                                  }
                                  var res = await Util.post("${Util.appUrl}/vip/exchange", data: {"token": userToken, "code": code.trim()});
                                  if (res['code'] == 0) {
                                    Util.toast(res['msg']);
                                  } else {
                                    Util.toast("成功兑换7天免广告特权");
                                    initData(tips: true);
                                    Navigator.of(context).pop();
                                  }
                                },
                                decoration: NeumorphicDecoration(
                                  color: Theme.of(context).scaffoldBackgroundColor,
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                bevel: 20,
                                padding: EdgeInsets.symmetric(vertical: 10),
                                child: Text(
                                  "兑换",
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
    }
  }

  wxLogin() {
    sendWeChatAuth(scope: "snsapi_userinfo");
  }

  loginDialog({bool alert: true}) {
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
                        "温馨提示",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Text(
                        alert ? "为了防止APP卸载后开通记录丢失，此功能需登录账号后使用" : "请选择登录方式",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: NeuButton(
                              onPressed: () async {
                                wxLogin();
                                Navigator.of(context).pop();
                              },
                              decoration: NeumorphicDecoration(
                                color: Theme.of(context).scaffoldBackgroundColor,
                                borderRadius: BorderRadius.circular(25),
                              ),
                              bevel: 20,
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Image.asset(
                                "assets/icons/wechat.png",
                                width: 25,
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
                                Navigator.of(context).push(CupertinoPageRoute(builder: (context) {
                                  return VipLogin();
                                })).then((res) {
                                  if (res != null && res) {
                                    initData();
                                  }
                                });
                              },
                              decoration: NeumorphicDecoration(
                                color: Theme.of(context).scaffoldBackgroundColor,
                                borderRadius: BorderRadius.circular(25),
                              ),
                              bevel: 20,
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Text(
                                "账号登录",
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
  }

  Future<void> closeAd(String type) async {
    if (!isLogin) {
      loginDialog();
    } else if (isForever) {
      Util.toast("您已开通永久免广告特权，无需继续购买");
    } else {
      var hide = showWeuiLoadingToast(context: context);

      try {
        await payOrder(type);
      } finally {
        hide();
      }
    }
  }

  payOrder(String type) async {
    var res = await Util.post("${Util.appUrl}/payment/wechat", data: {"token": userToken, "type": type});
    if (res['code'] == 1) {
      var data = res['data'];
      outTradeNo = data['out_trade_no'];
      payWithWeChat(appId: data['appid'], partnerId: data['partnerid'], prepayId: data['prepayid'], packageValue: data['package'], nonceStr: data['noncestr'], timeStamp: int.parse(data['timestamp']), sign: data['sign']);
    } else {
      Util.toast(res['msg']);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: AppBackButton(context),
        title: Text("关闭广告"),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 10, top: 8, bottom: 8),
            child: NeuButton(
              decoration: NeumorphicDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.all(10),
              bevel: 5,
              onPressed: () {
                if (!isLogin) {
                  loginDialog(alert: false);
                } else {
                  Navigator.of(context).push(CupertinoPageRoute(builder: (context) {
                    return VipRecord();
                  }));
                }
              },
              child: Text(
                isLogin ? "开通记录" : "恢复购买",
                style: TextStyle(color: AppTheme.of(context).titleColor),
              ),
            ),
          ),
        ],
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
                  if (noAdTime == null && isForever == false)
                    Text("未关闭")
                  else if (isForever)
                    Text("永久关闭", style: TextStyle(color: Colors.red))
                  else if (noAdTime != null)
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
          if (isForever)
            Text(
              "您已开通永久免广告特权，为给您带来更清爽的体验，已为您隐藏设置页面的关闭广告入口，您可以点击设置页面右上角齿轮找到关闭广告页面。",
              style: TextStyle(color: Colors.red),
            )
          else if (vipExpireTime != null && vipExpireTime.difference(DateTime.now()).inDays > 7)
            Text(
              "您的免广告剩余时长大于7天，为给您带来更清爽的体验，已为您隐藏设置页面的关闭广告入口，您可以点击设置页面右上角齿轮找到关闭广告页面。",
              style: TextStyle(color: Colors.red),
            )
          else
            Text("${Util.appName}是一款开源免费的APP，作者花费大量时间开发${Util.appName}，但是为爱发电终究无法维持最初的激情。\n为了能继续将${Util.appName}做强做好，在近期的版本中加入了开屏广告以获取一些微薄的收入。当然广告会让很多朋友（包括作者自己）反感，所以加入了一些措施来关闭开屏广告，希望大家能够理解和支持。"),
          NoAdButton(
            "关闭3天",
            price: "观看广告",
            onPressed: close3,
          ),
          SizedBox(
            height: 20,
          ),
          if (!isForever) ...[
            Text("注意：以下方式购买的免广告时长与关闭3天不累加，将取最长时间作为实际免广告时长。"),
            NoAdButton(
              "关闭7天",
              price: "200积分",
              onPressed: close7,
            ),
            NoAdButton(
              "关闭1月",
              price: "￥1.99", //￥1.99
              onPressed: () {
                closeAd("month");
              },
            ),
            NoAdButton(
              "关闭1年",
              price: "￥14.99", // ￥14.99
              onPressed: () {
                closeAd("year");
              },
            ),
            NoAdButton(
              "永久关闭",
              price: "￥29.99", // ￥29.99
              onPressed: () {
                closeAd("forever");
              },
            ),
          ],
        ],
      ),
    );
  }
}

class NoAdButton extends StatelessWidget {
  const NoAdButton(this.title, {this.price, this.onPressed, Key key}) : super(key: key);
  final String title;
  final String price;
  final Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return NeuCard(
      decoration: NeumorphicDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      margin: EdgeInsets.only(top: 20),
      bevel: 20,
      curveType: CurveType.flat,
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title),
            Spacer(),
            NeuButton(
              onPressed: onPressed,
              decoration: NeumorphicDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(20),
              ),
              bevel: 5,
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 7),
              child: Text(
                price,
                style: TextStyle(fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
