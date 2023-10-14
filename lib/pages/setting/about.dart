import 'dart:io';
import 'package:dsm_helper/pages/common/browser.dart';
import 'package:dsm_helper/pages/setting/license.dart';
import 'package:dsm_helper/pages/setting/open_source.dart';
import 'package:dsm_helper/themes/app_theme.dart';
import 'package:dsm_helper/utils/extensions/navigator_ext.dart';
import 'package:dsm_helper/utils/utils.dart';
import 'package:dsm_helper/widgets/glass/glass_app_bar.dart';
import 'package:dsm_helper/widgets/glass/glass_scaffold.dart';
import 'package:dsm_helper/widgets/loading_widget.dart';

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
                  height: 50,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/logo.png",
                      width: 80,
                      height: 80,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "${Utils.appName}",
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "v${packageInfo?.version} build:${packageInfo?.buildNumber}",
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
                      color: Colors.white,
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
                                    color: AppTheme.of(context)?.primaryColor,
                                    borderRadius: BorderRadius.circular(15),
                                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                    minSize: 0,
                                    onPressed: () {
                                      launchUrlString(channel.key!, mode: LaunchMode.externalApplication);
                                    },
                                    child: Text(
                                      "加入",
                                      style: TextStyle(fontSize: 14),
                                    ),
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
                      color: Colors.white,
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
                                    color: AppTheme.of(context)?.primaryColor,
                                    borderRadius: BorderRadius.circular(15),
                                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                    minSize: 0,
                                    onPressed: () {
                                      launchUrlString('mqqopensdkapi://bizAgent/qm/qr?url=http%3A%2F%2Fqm.qq.com%2Fcgi-bin%2Fqm%2Fqr%3Ffrom%3Dapp%26p%3Dandroid%26jump_from%3Dwebapi%26k%3D${qq.key}');
                                    },
                                    child: Text(
                                      "加群",
                                      style: TextStyle(fontSize: 14),
                                    ),
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
                      color: Colors.white,
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
                                  color: AppTheme.of(context)?.primaryColor,
                                  borderRadius: BorderRadius.circular(15),
                                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                  minSize: 0,
                                  onPressed: () {
                                    ClipboardData data = new ClipboardData(text: wechat.name!);
                                    Clipboard.setData(data);
                                    Utils.toast("已复制到剪贴板");
                                  },
                                  child: Text(
                                    "复制",
                                    style: TextStyle(fontSize: 14),
                                  ),
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
                    color: Colors.white,
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
                          color: AppTheme.of(context)?.primaryColor,
                          borderRadius: BorderRadius.circular(15),
                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          minSize: 0,
                          onPressed: () {
                            Navigator.of(context).push(CupertinoPageRoute(builder: (context) {
                              return Browser(
                                url: "https://gitee.com/apaipai/dsm_helper",
                              );
                            }));
                          },
                          child: Text(
                            "查看",
                            style: TextStyle(fontSize: 14),
                          ),
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
                    color: Colors.white,
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
                          color: AppTheme.of(context)?.primaryColor,
                          borderRadius: BorderRadius.circular(15),
                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          minSize: 0,
                          onPressed: () {
                            context.push(Browser(title: "Flutter官网", url: "https://flutter.dev"), name: "open_source");
                          },
                          child: Text(
                            "官网",
                            style: TextStyle(fontSize: 14),
                          ),
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
                    color: Colors.white,
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
                          color: AppTheme.of(context)?.primaryColor,
                          borderRadius: BorderRadius.circular(15),
                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          minSize: 0,
                          onPressed: () {
                            context.push(OpenSource(), name: "open_source");
                          },
                          child: Text(
                            "详情",
                            style: TextStyle(fontSize: 14),
                          ),
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
          SizedBox(height: 10),
          SafeArea(
            top: false,
            child: Column(
              children: [
                Text(
                  "Copyright © 2020-${DateTime.now().year} 青岛阿派派软件有限公司",
                  style: TextStyle(fontSize: 12, color: AppTheme.of(context)?.placeholderColor),
                ),
                SizedBox(height: 5),
                GestureDetector(
                  onTap: () {
                    context.push(Browser(url: "https://beian.miit.gov.cn/"));
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "ICP备案号：鲁ICP备2021022006号-4A",
                        style: TextStyle(fontSize: 12, color: AppTheme.of(context)?.placeholderColor),
                      ),
                      Icon(
                        CupertinoIcons.right_chevron,
                        size: 12,
                        color: AppTheme.of(context)?.placeholderColor,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        context.push(License(), name: "license");
                      },
                      child: Text(
                        "用户协议",
                        style: TextStyle(fontSize: 12, color: AppTheme.of(context)?.placeholderColor),
                      ),
                    ),
                    Container(
                      height: 10,
                      width: 1,
                      color: AppTheme.of(context)?.placeholderColor,
                      margin: EdgeInsets.symmetric(horizontal: 14),
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
                        style: TextStyle(fontSize: 12, color: AppTheme.of(context)?.placeholderColor),
                      ),
                    ),
                  ],
                ),
                if (Platform.isAndroid)
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    margin: EdgeInsets.only(top: 10),
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
                      color: AppTheme.of(context)?.primaryColor,
                      borderRadius: BorderRadius.circular(15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (checking) ...[
                            LoadingWidget(
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                          ],
                          Text("检查更新")
                        ],
                      ),
                    ),
                  ),
                SizedBox(height: 14),
              ],
            ),
          )
        ],
      ),
    );
  }
}
