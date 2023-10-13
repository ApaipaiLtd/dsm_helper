import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:dsm_helper/pages/common/select_local_folder.dart';
import 'package:dsm_helper/pages/file/select_folder.dart';
import 'package:dsm_helper/themes/app_theme.dart';
import 'package:dsm_helper/utils/utils.dart';
import 'package:dsm_helper/widgets/file_icon.dart';
import 'package:dsm_helper/widgets/glass/glass_app_bar.dart';
import 'package:dsm_helper/widgets/glass/glass_scaffold.dart';
import 'package:dsm_helper/widgets/label.dart';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'package:permission_handler/permission_handler.dart';

import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class Upload extends StatefulWidget {
  final String path;
  final List<String>? selectedFilesPath;
  Upload(this.path, {this.selectedFilesPath});
  @override
  _UploadState createState() => _UploadState();
}

class UploadItem {
  String path;
  String subPath;
  String name;
  int fileSize;
  int uploadSize;
  UploadStatus status;
  late CancelToken cancelToken;
  UploadItem(this.path, this.name, {this.subPath = "", this.fileSize = 0, this.uploadSize = 0, this.status = UploadStatus.wait}) {
    cancelToken = CancelToken();
  }
}

class _UploadState extends State<Upload> {
  String savePath = "";
  List<UploadItem> uploads = [];
  @override
  void initState() {
    setState(() {
      savePath = widget.path;
    });
    if (widget.selectedFilesPath != null) {
      uploads = widget.selectedFilesPath!.map((filePath) {
        File file = File(filePath);
        return UploadItem(
          filePath,
          filePath.split("/").last,
          fileSize: file.lengthSync(),
        );
      }).toList();
      setState(() {});
    }
    super.initState();
  }

  Widget _buildUploadStatus(UploadItem upload) {
    if (upload.status == UploadStatus.complete) {
      return Label(
        "上传完成",
        Colors.lightGreen,
        fill: true,
        fontSize: 10,
        height: 22,
      );
    } else if (upload.status == UploadStatus.failed) {
      return Label(
        "上传失败",
        Colors.redAccent,
        fill: true,
        fontSize: 10,
        height: 22,
      );
    } else if (upload.status == UploadStatus.canceled) {
      return Label(
        "取消上传",
        Colors.redAccent,
        fill: true,
        fontSize: 10,
        height: 22,
      );
    } else if (upload.status == UploadStatus.running) {
      return Label(
        "${(upload.uploadSize / (upload.fileSize == 0 ? 1 : upload.fileSize) * 100).toStringAsFixed(2)}%",
        Colors.lightBlueAccent,
        fill: true,
        fontSize: 10,
        height: 22,
      );
    } else if (upload.status == UploadStatus.wait) {
      return Label(
        "等待上传",
        Colors.lightBlueAccent,
        fill: true,
        fontSize: 10,
        height: 22,
      );
    } else {
      return Container();
    }
  }

  Widget _buildUploadItem(UploadItem upload) {
    FileTypeEnum fileType = Utils.fileType(upload.path);
    // String path = file['path'];
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0, left: 20, right: 20),
      child: CupertinoButton(
        onPressed: () async {},
        // margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        padding: EdgeInsets.symmetric(vertical: 20),
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(20),
        child: Row(
          children: [
            SizedBox(
              width: 20,
            ),
            Hero(
              tag: upload.path,
              child: FileIcon(
                fileType,
                thumb: upload.path,
                network: false,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${upload.name}",
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  if (upload.subPath.isNotBlank)
                    Text(
                      upload.subPath,
                      style: TextStyle(fontSize: 12, color: AppTheme.of(context)?.placeholderColor),
                    ),
                  SizedBox(
                    height: 5,
                  ),
                  _buildUploadStatus(upload),
                ],
              ),
            ),
            SizedBox(
              width: 10,
            ),
            AnimatedSwitcher(
              duration: Duration(milliseconds: 200),
              child: CupertinoButton(
                onPressed: () {
                  showCupertinoModalPopup(
                    context: context,
                    builder: (context) {
                      return Material(
                        color: Colors.transparent,
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(22),
                          decoration: BoxDecoration(color: Theme.of(context).scaffoldBackgroundColor, borderRadius: BorderRadius.vertical(top: Radius.circular(22))),
                          child: SafeArea(
                            top: false,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text(
                                  "选择操作",
                                  style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.w500),
                                ),
                                if (upload.status == UploadStatus.failed) ...[
                                  SizedBox(
                                    height: 22,
                                  ),
                                  CupertinoButton(
                                    onPressed: () async {
                                      setState(() {
                                        upload.status = UploadStatus.wait;
                                      });
                                      Navigator.of(context).pop();
                                    },
                                    color: Theme.of(context).scaffoldBackgroundColor,
                                    borderRadius: BorderRadius.circular(25),
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    child: Text(
                                      "重试",
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ),
                                ],
                                SizedBox(
                                  height: 22,
                                ),
                                CupertinoButton(
                                  onPressed: () async {
                                    setState(() {
                                      uploads.remove(upload);
                                    });
                                    Navigator.of(context).pop();
                                  },
                                  color: Theme.of(context).scaffoldBackgroundColor,
                                  borderRadius: BorderRadius.circular(25),
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  child: Text(
                                    "取消上传",
                                    style: TextStyle(fontSize: 18, color: Colors.redAccent),
                                  ),
                                ),
                                SizedBox(
                                  height: 16,
                                ),
                                CupertinoButton(
                                  onPressed: () async {
                                    Navigator.of(context).pop();
                                  },
                                  color: Theme.of(context).scaffoldBackgroundColor,
                                  borderRadius: BorderRadius.circular(25),
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
                      );
                    },
                  );
                },
                padding: EdgeInsets.only(left: 5, right: 3, top: 4, bottom: 4),
                color: Color(0xfff0f0f0),
                borderRadius: BorderRadius.circular(20),
                child: Icon(
                  CupertinoIcons.right_chevron,
                  size: 18,
                ),
              ),
            ),
            SizedBox(
              width: 20,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GlassScaffold(
      appBar: GlassAppBar(
        title: Text("文件上传"),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(20),
              child: CupertinoButton(
                onPressed: () {
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
                        savePath = res[0];
                      });
                    }
                  });
                },
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "上传位置",
                        style: TextStyle(color: AppTheme.of(context)?.placeholderColor, fontSize: 13),
                      ),
                      Text(
                        savePath == "" ? "请选择上传位置" : savePath,
                        style: TextStyle(fontSize: 16, color: Theme.of(context).primaryColor),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: uploads.length > 0
                  ? ListView.builder(
                      itemBuilder: (context, i) {
                        return _buildUploadItem(uploads[i]);
                      },
                      itemCount: uploads.length,
                    )
                  : Center(
                      child: Text(
                        "暂无待上传文件",
                        style: TextStyle(color: AppTheme.of(context)?.placeholderColor),
                      ),
                    ),
            ),
            SafeArea(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Row(
                  children: [
                    Expanded(
                      child: CupertinoButton(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        borderRadius: BorderRadius.circular(50),
                        onPressed: () async {
                          showCupertinoModalPopup(
                            context: context,
                            builder: (context) {
                              return Material(
                                color: Colors.transparent,
                                child: Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.all(22),
                                  decoration: BoxDecoration(color: Theme.of(context).scaffoldBackgroundColor, borderRadius: BorderRadius.vertical(top: Radius.circular(22))),
                                  child: SafeArea(
                                    top: false,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Text(
                                          "选择添加方式",
                                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                                        ),
                                        SizedBox(
                                          height: 12,
                                        ),
                                        CupertinoButton(
                                          onPressed: () async {
                                            Navigator.of(context).pop();
                                            final List<AssetEntity>? assets = await AssetPicker.pickAssets(context, pickerConfig: AssetPickerConfig(maxAssets: 1000));
                                            if (assets != null && assets.length > 0) {
                                              assets.forEach((asset) {
                                                asset.file.then((file) {
                                                  setState(() {
                                                    uploads.add(UploadItem(file!.path, file.path.split("/").last));
                                                  });
                                                });
                                              });
                                            } else {
                                              debugPrint("未选择文件");
                                            }
                                          },
                                          color: Theme.of(context).scaffoldBackgroundColor,
                                          borderRadius: BorderRadius.circular(25),
                                          padding: EdgeInsets.symmetric(vertical: 10),
                                          child: Text(
                                            "上传图片",
                                            style: TextStyle(fontSize: 18),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        CupertinoButton(
                                          onPressed: () async {
                                            Navigator.of(context).pop();
                                            DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
                                            if (Platform.isAndroid) {
                                              AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
                                              if (androidInfo.version.sdkInt >= 30) {
                                                bool permission = false;
                                                permission = await Permission.manageExternalStorage.request().isGranted;
                                                if (!permission) {
                                                  Utils.toast("安卓11需授权文件管理权限");
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
                                              showCupertinoModalBottomSheet<List<FileSystemEntity>>(
                                                context: context,
                                                builder: (context) {
                                                  return SelectLocalFolder(
                                                    multi: true,
                                                    folder: false,
                                                  );
                                                },
                                              ).then((res) {
                                                if (res != null && res.length > 0) {
                                                  res.forEach((entry) {
                                                    if (FileSystemEntity.isFileSync(entry.path)) {
                                                      setState(() {
                                                        uploads.add(UploadItem(entry.path, entry.path.split("/").last));
                                                      });
                                                    } else {
                                                      Directory directory = Directory(entry.path);
                                                      directory.list(recursive: true).forEach((element) {
                                                        if (!element.path.split("/").last.startsWith(".")) {
                                                          if (FileSystemEntity.isFileSync(element.path)) {
                                                            List<String> slice = element.path.replaceFirst("${entry.path}/", "").split("/");
                                                            setState(() {
                                                              uploads.add(UploadItem(element.path, slice.last, subPath: slice.getRange(0, slice.length - 1).join("/")));
                                                            });
                                                          }
                                                        }
                                                      });
                                                    }
                                                  });
                                                }
                                                // if (res != null && res.length == 1) {
                                                //   setState(() {
                                                //     downloadPath = res[0];
                                                //     Utils.downloadSavePath = res[0];
                                                //     Utils.setStorage("download_save_path", res[0]);
                                                //   });
                                                // }
                                              });
                                            } else {
                                              FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: true);

                                              if (result != null) {
                                                setState(() {
                                                  uploads.addAll(result.files.map((file) {
                                                    return UploadItem(file.path!, file.name, fileSize: file.size);
                                                  }).toList());
                                                });
                                              } else {
                                                // User canceled the picker
                                              }
                                            }
                                          },
                                          color: Theme.of(context).scaffoldBackgroundColor,
                                          borderRadius: BorderRadius.circular(25),
                                          padding: EdgeInsets.symmetric(vertical: 10),
                                          child: Text(
                                            "上传文件",
                                            style: TextStyle(fontSize: 18),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        CupertinoButton(
                                          onPressed: () async {
                                            Navigator.of(context).pop();
                                          },
                                          color: Theme.of(context).scaffoldBackgroundColor,
                                          borderRadius: BorderRadius.circular(25),
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
                              );
                            },
                          );
                        },
                        child: Text("添加文件"),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: CupertinoButton(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        borderRadius: BorderRadius.circular(50),
                        onPressed: () async {
                          if (savePath.isBlank) {
                            Utils.vibrate(FeedbackType.warning);
                            Utils.toast("请选择上传位置");
                            return;
                          }
                          // return;
                          for (int i = 0; i < uploads.length; i++) {
                            UploadItem upload = uploads[i];
                            if (upload.status != UploadStatus.wait) {
                              continue;
                            }
                            //上传文件
                            setState(() {
                              upload.status = UploadStatus.running;
                            });
                            // print("上传路径：$savePath${upload.subPath.isNotBlank ? "/${upload.subPath}" : ""}");
                            var res = await Api.upload("$savePath${upload.subPath.isNotBlank ? "/${upload.subPath}" : ""}", upload.path, upload.cancelToken, (progress, total) {
                              setState(() {
                                upload.uploadSize = progress;
                                upload.fileSize = total;
                              });
                            });
                            print(res);
                            if (res['success']) {
                              setState(() {
                                upload.status = UploadStatus.complete;
                              });
                            } else {
                              setState(() {
                                upload.status = UploadStatus.failed;
                              });
                            }
                          }
                        },
                        child: Text("开始上传"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
