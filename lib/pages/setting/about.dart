import 'dart:io';
import 'package:dsm_helper/models/Syno/FileStation/Sharing.dart';
import 'package:dsm_helper/pages/common/browser.dart';
import 'package:dsm_helper/pages/setting/license.dart';
import 'package:dsm_helper/pages/setting/open_source.dart';
import 'package:dsm_helper/themes/app_theme.dart';
import 'package:dsm_helper/utils/extensions/navigator_ext.dart';
import 'package:dsm_helper/utils/utils.dart';
import 'package:dsm_helper/widgets/glass/glass_app_bar.dart';
import 'package:dsm_helper/widgets/glass/glass_scaffold.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher_string.dart';

class About extends StatefulWidget {
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  bool checking = false;
  PackageInfo? packageInfo;
  TapGestureRecognizer _licenseRecognizer = TapGestureRecognizer();
  TapGestureRecognizer _privacyRecognizer = TapGestureRecognizer();
  @override
  void initState() {
    getInfo();
    super.initState();
  }

  getInfo() async {
    packageInfo = await PackageInfo.fromPlatform();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GlassScaffold(
      appBar: GlassAppBar(
        title: Text(
          "关于${Utils.appName}",
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: <Widget>[
                SizedBox(
                  height: 70,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        "assets/logo.png",
                        width: 80,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "${Utils.appName}",
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "${packageInfo!.version} build:${packageInfo!.buildNumber}",
                      style: TextStyle(
                        color: AppTheme.of(context)?.placeholderColor,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                if (Utils.notReviewAccount) ...[
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                        padding: EdgeInsets.all(15),
                        child: Column(
                          children: Utils.groups.channel!.map((channel) {
                            return Padding(
                              padding: EdgeInsets.symmetric(vertical: 5),
                              child: Row(
                                children: [
                                  Image.asset(
                                    "assets/icons/qq.png",
                                    width: 20,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    channel.displayName,
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  Spacer(),
                                  CupertinoButton(
                                    color: Theme.of(context).scaffoldBackgroundColor,
                                    borderRadius: BorderRadius.circular(20),
                                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                                    onPressed: () {
                                      launchUrlString(channel.key!, mode: LaunchMode.externalApplication);
                                    },
                                    child: Text("加入"),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        )),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                        padding: EdgeInsets.all(15),
                        child: Column(
                          children: Utils.groups.qq!.map((qq) {
                            return Padding(
                              padding: EdgeInsets.symmetric(vertical: 5),
                              child: Row(
                                children: [
                                  Image.asset(
                                    "assets/icons/qq.png",
                                    width: 20,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    qq.displayName,
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  Spacer(),
                                  CupertinoButton(
                                    color: Theme.of(context).scaffoldBackgroundColor,
                                    borderRadius: BorderRadius.circular(20),
                                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                                    onPressed: () {
                                      launchUrlString('mqqopensdkapi://bizAgent/qm/qr?url=http%3A%2F%2Fqm.qq.com%2Fcgi-bin%2Fqm%2Fqr%3Ffrom%3Dapp%26p%3Dandroid%26jump_from%3Dwebapi%26k%3D${qq.key}');
                                    },
                                    child: Text("加群"),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        )),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(15),
                      child: Column(
                        children: Utils.groups.wechat!.map((wechat) {
                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: 5),
                            child: Row(
                              children: [
                                Image.asset(
                                  "assets/icons/wechat.png",
                                  width: 20,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  wechat.displayName,
                                  style: TextStyle(fontSize: 16),
                                ),
                                Spacer(),
                                CupertinoButton(
                                  color: Theme.of(context).scaffoldBackgroundColor,
                                  borderRadius: BorderRadius.circular(20),
                                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                                  onPressed: () {
                                    ClipboardData data = new ClipboardData(text: wechat.name!);
                                    Clipboard.setData(data);
                                    Utils.toast("已复制到剪贴板");
                                  },
                                  child: Text("复制"),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
                SizedBox(
                  height: 20,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Row(
                      children: [
                        Image.asset(
                          "assets/icons/gitee.png",
                          width: 20,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "${Utils.appName}开源地址",
                          style: TextStyle(fontSize: 16),
                        ),
                        Spacer(),
                        CupertinoButton(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          borderRadius: BorderRadius.circular(20),
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                          onPressed: () {
                            Navigator.of(context).push(CupertinoPageRoute(builder: (context) {
                              return Browser(
                                url: "https://gitee.com/apaipai/dsm_helper",
                              );
                            }));
                          },
                          child: Text("查看"),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Row(
                      children: [
                        FlutterLogo(
                          size: 20,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Powered by Flutter",
                          style: TextStyle(fontSize: 16),
                        ),
                        Spacer(),
                        CupertinoButton(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          borderRadius: BorderRadius.circular(20),
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                          onPressed: () {
                            Navigator.of(context).push(
                              CupertinoPageRoute(builder: (context) {
                                return Browser(
                                  title: "Flutter官网",
                                  url: "https://flutter.dev",
                                );
                              }),
                            );
                          },
                          child: Text("官网"),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Row(
                      children: [
                        Image.asset(
                          "assets/icons/pub.png",
                          width: 20,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "开源插件",
                          style: TextStyle(fontSize: 16),
                        ),
                        Spacer(),
                        CupertinoButton(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          borderRadius: BorderRadius.circular(20),
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                          onPressed: () {
                            Navigator.of(context).push(
                              CupertinoPageRoute(
                                  builder: (context) {
                                    return OpenSource();
                                  },
                                  settings: RouteSettings(name: "open_source")),
                            );
                          },
                          child: Text("详情"),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
          Column(
            children: [
              Text(
                "©2020-${DateTime.now().year} 青岛阿派派软件有限公司",
                style: TextStyle(fontSize: 14, color: AppTheme.of(context)?.placeholderColor),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      context.push(License(), name: "license");
                    },
                    child: Text(
                      "用户协议",
                      style: TextStyle(fontSize: 14, color: AppTheme.of(context)?.placeholderColor),
                    ),
                  ),
                  Container(
                    height: 10,
                    width: 1,
                    color: AppTheme.of(context)?.placeholderColor,
                    margin: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  ),
                  GestureDetector(
                    onTap: () {
                      context.push(
                          Browser(
                            url: '${Utils.appUrl}/privacy',
                            title: "隐私政策",
                          ),
                          name: "license");
                    },
                    child: Text(
                      "隐私政策",
                      style: TextStyle(fontSize: 14, color: AppTheme.of(context)?.placeholderColor),
                    ),
                  ),
                ],
              ),
              if (Platform.isAndroid)
                Padding(
                  padding: EdgeInsets.all(20),
                  child: CupertinoButton(
                    onPressed: () async {
                      if (checking) {
                        return;
                      }
                      setState(() {
                        checking = true;
                      });
                      await Utils.checkUpdate(true, context, force: true);
                      setState(() {
                        checking = false;
                      });
                    },
                    // margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    padding: EdgeInsets.symmetric(vertical: 20),
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(20),

                    child: checking
                        ? Center(
                            child: CupertinoActivityIndicator(
                              radius: 13,
                            ),
                          )
                        : Text(
                            "检查更新",
                            style: TextStyle(fontSize: 18, color: AppTheme.of(context)?.primaryColor),
                          ),
                  ),
                ),
            ],
          )
        ],
      ),
    );
  }
}
