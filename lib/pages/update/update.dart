import 'package:dio/dio.dart';
import 'package:dsm_helper/themes/app_theme.dart';
import 'package:dsm_helper/util/function.dart';
import 'package:dsm_helper/widgets/animation_progress_bar.dart';
import 'package:dsm_helper/widgets/neu_back_button.dart';
import 'package:easy_app_installer/easy_app_installer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neumorphic/neumorphic.dart';
import 'package:open_file/open_file.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher_string.dart';

class Update extends StatefulWidget {
  final Map data;
  final bool direct;
  Update(this.data, {this.direct: false});
  @override
  _UpdateState createState() => _UpdateState();
}

class _UpdateState extends State<Update> {
  bool downloading = false;
  CancelToken cancelToken = CancelToken();
  double progress = 0;
  bool loading = true;
  String fileName = "";
  String filePath = "";
  int downloadedSize = 0;
  int totalSize = 0;
  @override
  void initState() {
    fileName = "dsm_helper-${widget.data['build']}.apk";
    if (widget.direct) {
      download();
    }
    super.initState();
  }

  download() async {
    setState(() {
      downloading = true;
    });
    try {
      /// 仅支持将APK下载到沙盒目录下
      /// 当前这个示例最终生成的文件路径就是 '/data/user/0/$applicationPackageName/files/updateApk/new.apk'
      /// 如果连续调用此方法，并且参数传递的完全一致，那么Native端将拒绝执行后续任务，直到下载中的任务执行完毕。
      await EasyAppInstaller.instance.downloadAndInstallApk(
        fileUrl: widget.data['url'],
        fileDirectory: "apk",
        fileName: fileName,
        onDownloadingListener: (progress) {
          setState(() {
            this.progress = progress / 100;
          });
        },
      );
    } catch (e) {
      Util.toast("下载失败");
    }
    setState(() {
      downloading = false;
    });
  }

  install() async {
    //检查安装权限
    bool hasPermission = await Permission.requestInstallPackages.request().isGranted;
    print("install permission: $hasPermission");
    if (!hasPermission) {
      showCupertinoModalPopup(
        context: context,
        builder: (context) {
          return Material(
            color: Colors.transparent,
            child: NeuCard(
              width: double.infinity,
              padding: EdgeInsets.all(22),
              bevel: 5,
              curveType: CurveType.emboss,
              decoration: NeumorphicDecoration(color: Theme.of(context).scaffoldBackgroundColor, borderRadius: BorderRadius.vertical(top: Radius.circular(22))),
              child: SafeArea(
                top: false,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      "更新失败",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Text(
                      "权限不足，无法自动安装更新，请使用浏览器下载更新",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      height: 22,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: NeuButton(
                            onPressed: () async {
                              Navigator.of(context).pop();
                              launchUrlString(widget.data['url'], mode: LaunchMode.externalApplication);
                            },
                            decoration: NeumorphicDecoration(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              borderRadius: BorderRadius.circular(25),
                            ),
                            bevel: 5,
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              "使用浏览器下载",
                              style: TextStyle(fontSize: 18, color: Colors.redAccent),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20,
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
                            bevel: 5,
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              "取消",
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    } else {
      await OpenFile.open(filePath);
    }
  }

  cancel() {
    setState(() {
      downloading = false;
      progress = 0;
    });
    cancelToken.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: AppBackButton(context),
        title: Text(
          "软件更新",
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
                Center(
                  child: NeuCard(
                    bevel: 20,
                    curveType: CurveType.flat,
                    decoration: NeumorphicDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(60),
                    ),
                    child: CircleAvatar(
                      backgroundImage: AssetImage(
                        "assets/logo.png",
                      ),
                      radius: 60,
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Column(
                  children: [
                    Text(
                      "新版本 v${widget.data['version']} build ${widget.data['build']}",
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "更新时间：${DateTime.fromMillisecondsSinceEpoch(widget.data['update_time'] * 1000).format("Y-m-d H:i")}",
                      style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "安装包大小：${Util.formatSize(widget.data['size'])}",
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
                SizedBox(
                  height: 40,
                ),
                NeuCard(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 25),
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  curveType: CurveType.flat,
                  decoration: NeumorphicDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "更新日志：",
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "${widget.data['note'] ?? "暂无更新日志"}",
                        style: TextStyle(color: AppTheme.of(context).placeholderColor),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              launchUrlString(widget.data['url'], mode: LaunchMode.externalApplication);
            },
            child: Text(
              "使用浏览器下载",
              style: TextStyle(color: Colors.grey, decoration: TextDecoration.underline, fontSize: 14),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          if (!downloading)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: NeuButton(
                onPressed: () {
                  download();
                },
                // margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                padding: EdgeInsets.symmetric(vertical: 20),
                decoration: NeumorphicDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                bevel: 20,
                child: Text(
                  "开始下载",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          if (downloading)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: NeuCard(
                curveType: CurveType.flat,
                bevel: 10,
                decoration: NeumorphicDecoration(
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
          SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
