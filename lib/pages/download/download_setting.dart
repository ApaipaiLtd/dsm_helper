import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dsm_helper/pages/common/select_local_folder.dart';
import 'package:dsm_helper/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sp_util/sp_util.dart';

class DownloadSetting extends StatefulWidget {
  @override
  _DownloadSettingState createState() => _DownloadSettingState();
}

class _DownloadSettingState extends State<DownloadSetting> {
  String downloadPath = '';
  @override
  void initState() {
    Utils.getDownloadPath().then((value) {
      setState(() {
        downloadPath = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("下载选项"),
      ),
      body: ListView(
        padding: EdgeInsets.all(20.0),
        children: [
          if (Platform.isAndroid) ...[
            CupertinoButton(
              onPressed: () async {
                DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
                AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
                if (Platform.isAndroid && androidInfo.version.sdkInt >= 30) {
                  bool permission = false;
                  permission = await Permission.manageExternalStorage.request().isGranted;
                  if (!permission) {
                    Utils.toast("安卓11以上需授权文件管理权限");
                    return;
                  }
                } else {
                  bool permission = false;
                  permission = await Permission.storage.request().isGranted;
                  if (!permission) {
                    Utils.toast("请先授权APP访问存储权限");
                    return;
                  }
                }

                showCupertinoModalPopup<List<FileSystemEntity>>(
                  context: context,
                  builder: (context) {
                    return SelectLocalFolder(
                      multi: false,
                      folder: true,
                    );
                  },
                ).then((res) {
                  if (res != null && res.length == 1) {
                    setState(() {
                      downloadPath = res[0].path;
                      Utils.downloadSavePath = res[0].path;
                      SpUtil.putString("download_save_path", res[0].path);
                    });
                  }
                });
              },
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(20),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "下载位置",
                          style: TextStyle(fontSize: 12),
                        ),
                        Text(
                          downloadPath,
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ],
      ),
    );
  }
}
