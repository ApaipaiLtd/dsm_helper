import 'package:dsm_helper/utils/extensions/navigator_ext.dart';
import 'package:dsm_helper/utils/utils.dart';
import 'package:dsm_helper/widgets/button.dart';
import 'package:dsm_helper/widgets/glass/glass_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sp_util/sp_util.dart';
import 'package:url_launcher/url_launcher_string.dart';

class FirstLaunchDialog {
  static show(BuildContext context) async {
    bool firstLaunch = SpUtil.getBool("first_launch_channel", defValue: true)!;
    if (firstLaunch && Utils.notReviewAccount) {
      showGlassDialog(
        context: context,
        builder: (context) {
          return Material(
            color: Colors.transparent,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 50),
                  decoration: BoxDecoration(
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
                        Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                          child: Text("前往'设置-关闭广告'页面，即可关闭开屏广告。"),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
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
                                          "${channel.displayName}",
                                          style: TextStyle(fontSize: 16),
                                        ),
                                        Spacer(),
                                        Button(
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
                                          "${wechat.displayName}",
                                          style: TextStyle(fontSize: 16),
                                        ),
                                        Spacer(),
                                        Button(
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
                              )),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Button(
                                onPressed: () async {
                                  context.pop();
                                  SpUtil.putBool("first_launch_channel", false);
                                },
                                child: Text(
                                  "我知道了",
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
}
