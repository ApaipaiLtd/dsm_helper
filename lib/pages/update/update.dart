import 'package:dsm_helper/pages/dashboard/widgets/widget_card.dart';
import 'package:dsm_helper/themes/app_theme.dart';
import 'package:dsm_helper/utils/utils.dart';
import 'package:dsm_helper/widgets/animation_progress_bar.dart';
import 'package:dsm_helper/widgets/glass/glass_app_bar.dart';
import 'package:dsm_helper/widgets/glass/glass_scaffold.dart';

import 'package:easy_app_installer/easy_app_installer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class Update extends StatefulWidget {
  final Map data;
  final bool direct;
  Update(this.data, {this.direct = false});
  @override
  _UpdateState createState() => _UpdateState();
}

class _UpdateState extends State<Update> {
  bool downloading = false;
  double progress = 0;
  bool loading = true;
  String fileName = "";
  @override
  void initState() {
    fileName = "dsm_helper-${widget.data['buildVersionNo']}.apk";
    if (widget.direct) {
      download();
    }
    super.initState();
  }

  download() async {
    // 检查安装应用权限
    // if (!await Permission.requestInstallPackages.request().isGranted) {
    //   Utils.toast("权限不足，无法安装更新");
    // }
    setState(() {
      downloading = true;
    });
    try {
      /// 仅支持将APK下载到沙盒目录下
      /// 当前这个示例最终生成的文件路径就是 '/data/user/0/$applicationPackageName/files/updateApk/new.apk'
      /// 如果连续调用此方法，并且参数传递的完全一致，那么Native端将拒绝执行后续任务，直到下载中的任务执行完毕。
      await EasyAppInstaller.instance.downloadAndInstallApk(
        fileUrl: widget.data['downloadURL'],
        fileDirectory: "apk",
        fileName: fileName,
        onDownloadingListener: (progress) {
          setState(() {
            this.progress = progress / 100;
          });
        },
      );
    } catch (e) {
      Utils.toast("下载失败");
    }
    setState(() {
      downloading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GlassScaffold(
      appBar: GlassAppBar(
        title: Text("软件更新"),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: <Widget>[
                SizedBox(
                  height: 50,
                ),
                Image.asset(
                  "assets/logo.png",
                  width: 80,
                  height: 80,
                ),
                SizedBox(
                  height: 30,
                ),
                Center(
                  child: Text(
                    "v${widget.data['buildVersion']} build ${widget.data['buildVersionNo']}",
                    style: TextStyle(
                      color: AppTheme.of(context)?.placeholderColor,
                      fontSize: 16,
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                WidgetCard(
                  title: "更新日志",
                  body: Container(
                    child: Text(
                      "${widget.data['buildUpdateDescription'] == "" ? "暂无更新日志" : widget.data['buildUpdateDescription']}",
                      style: TextStyle(color: AppTheme.of(context)?.placeholderColor),
                    ),
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              launchUrlString(widget.data['downloadURL'], mode: LaunchMode.externalApplication);
            },
            child: Text(
              "使用浏览器下载",
              style: TextStyle(color: AppTheme.of(context)?.placeholderColor, decoration: TextDecoration.underline, fontSize: 14),
            ),
          ),
          SafeArea(
            top: false,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: !downloading
                  ? CupertinoButton(
                      onPressed: () {
                        download();
                      },
                      color: AppTheme.of(context)?.primaryColor,
                      borderRadius: BorderRadius.circular(15),
                      child: Text(
                        "下载更新",
                        style: TextStyle(fontSize: 18),
                      ),
                    )
                  : Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: FAProgressBar(
                          backgroundColor: Colors.transparent,
                          progressColor: Colors.blue,
                          currentValue: (progress * 100).ceil(),
                          size: 64,
                          borderRadius: BorderRadius.circular(20),
                          displayText: '%',
                          displayTextStyle: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
