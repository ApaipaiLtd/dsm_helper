import 'package:dsm_helper/pages/download_station/select_file.dart';
import 'package:dsm_helper/pages/file/select_folder.dart';
import 'package:dsm_helper/utils/utils.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';

class AddDownloadTask extends StatefulWidget {
  final String? torrentPath;
  AddDownloadTask({this.torrentPath});
  @override
  _AddDownloadTaskState createState() => _AddDownloadTaskState();
}

class _AddDownloadTaskState extends State<AddDownloadTask> {
  String saveFolder = "";
  String torrentPath = "";
  String url = "";
  @override
  void initState() {
    if (widget.torrentPath != null) {
      setState(() {
        torrentPath = widget.torrentPath!;
      });
    }
    getData();
    super.initState();
  }

  getData() async {
    var res = await Api.downloadLocation();
    if (res['success']) {
      setState(() {
        saveFolder = res['data']['default_destination'];
      });
    } else {
      Utils.vibrate(FeedbackType.warning);
      Utils.toast("获取默认保存位置失败");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("创建下载任务"),
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          CupertinoButton(
            onPressed: () {
              FocusScope.of(context).unfocus();
              showCupertinoModalPopup(
                context: context,
                builder: (context) {
                  return SelectFolder(
                    multi: false,
                  );
                },
              ).then((res) {
                if (res != null && res.length == 1) {
                  setState(() {
                    saveFolder = res[0].substring(1);
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
                        "保存位置",
                        style: TextStyle(fontSize: 12),
                      ),
                      SizedBox(
                        height: 20,
                        child: Text(
                          saveFolder == "" ? "选择保存位置" : saveFolder,
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
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
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(20),
            ),
            
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: TextField(
              onChanged: (v) => url = v,
              decoration: InputDecoration(
                border: InputBorder.none,
                labelText: '下载链接',
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          CupertinoButton(
            onPressed: () async {
              FocusScope.of(context).unfocus();
              FilePickerResult? _pickedFile = await FilePicker.platform.pickFiles();
              if (_pickedFile != null && _pickedFile.count > 0) {
                String path = _pickedFile.paths[0]!;
                String ext = path.split(".").last;
                if (["torrent", "nbz", "txt"].contains(ext)) {
                  setState(() {
                    torrentPath = path;
                  });
                } else {
                  Utils.toast("无效的种子文件");
                }
              }
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
                        "种子文件",
                        style: TextStyle(fontSize: 12),
                      ),
                      Text(
                        torrentPath == "" ? "选择种子文件" : torrentPath,
                        maxLines: null,
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
          CupertinoButton(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(20),
            onPressed: () async {
              if (saveFolder == "") {
                Utils.toast("请选择保存位置");
                Utils.vibrate(FeedbackType.impact);
                return;
              }
              if (url.trim() == "" && torrentPath == "") {
                Utils.toast("请输入下载链接或选择种子文件");
                return;
              }
              var res;
              if (torrentPath != "") {
                res = await Api.downloadTaskCreate(saveFolder, "file", filePath: torrentPath);
                if (res['success']) {
                  Navigator.of(context).push(CupertinoPageRoute(builder: (context) {
                    return SelectFile(res['data']['list_id'], saveFolder);
                  }));
                } else {
                  Utils.toast("创建任务失败，code：${res['error']['code']}");
                }
              } else {
                if (url.trim() == "") {
                  Utils.toast("请输入下载链接");
                  Utils.vibrate(FeedbackType.light);
                  return;
                }
                res = await Api.downloadTaskCreate(saveFolder, "url", url: url);
                if (res['success']) {
                  Utils.toast("创建任务成功");
                  Navigator.of(context).pop(true);
                } else {
                  Utils.toast("创建任务失败，code：${res['error']['code']}");
                }
              }
            },
            child: Text(
              ' 创建 ',
              style: TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}
