import 'dart:async';

import 'package:dsm_helper/models/Syno/FileStation/DirSize.dart';
import 'package:dsm_helper/models/Syno/FileStation/FileMd5.dart';
import 'package:dsm_helper/models/Syno/FileStation/FileStationList.dart';
import 'package:dsm_helper/pages/dashboard/widgets/widget_card.dart';
import 'package:dsm_helper/themes/app_theme.dart';
import 'package:dsm_helper/utils/utils.dart';
import 'package:dsm_helper/widgets/glass/glass_app_bar.dart';
import 'package:dsm_helper/widgets/glass/glass_scaffold.dart';
import 'package:dsm_helper/widgets/loading_widget.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FileDetail extends StatefulWidget {
  final FileItem file;
  FileDetail(this.file);
  @override
  _FileDetailState createState() => _FileDetailState();
}

class _FileDetailState extends State<FileDetail> {
  Timer? dirSizeTimer;
  Timer? md5Timer;
  bool dirSizeLoading = false;
  bool diskSizeLoading = false;
  bool md5Loading = false;
  int? diskSize;
  FileMd5? md5;
  DirSize? dirSize;
  @override
  void initState() {
    if (widget.file.isdir == true) {
      getDirSize();
    } else {
      getDiskSize();
    }
    super.initState();
  }

  @override
  dispose() {
    dirSizeTimer?.cancel();
    md5Timer?.cancel();
    super.dispose();
  }

  getDirSize() async {
    setState(() {
      dirSizeLoading = true;
    });
    String taskId = await widget.file.dirSize();
    if (taskId.isNotEmpty) {
      dirSizeTimer = Timer.periodic(Duration(seconds: 2), (timer) async {
        dirSize = await DirSize.result(taskId);

        if (dirSize!.finished == true) {
          dirSizeLoading = false;

          dirSizeTimer?.cancel();
        }
        setState(() {});
      });
    }
  }

  getDiskSize() async {
    setState(() {
      diskSizeLoading = true;
    });
    diskSize = await widget.file.diskSize();
    setState(() {
      diskSizeLoading = false;
    });
  }

  getFileMd5() async {
    setState(() {
      md5Loading = true;
    });
    String taskId = await widget.file.md5();
    if (taskId.isNotEmpty) {
      md5Timer = Timer.periodic(Duration(seconds: 1), (timer) async {
        try {
          md5 = await FileMd5.result(taskId);

          if (md5!.finished == true) {
            setState(() {
              md5Loading = false;
            });
            md5Timer?.cancel();
          }
        } catch (e) {
          Utils.toast("获取MD5失败");
          setState(() {
            md5Loading = false;
          });
          md5Timer?.cancel();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GlassScaffold(
      appBar: GlassAppBar(
        title: Text(
          widget.file.name!,
        ),
      ),
      body: ListView(
        children: [
          WidgetCard(
            title: "常规",
            body: Container(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "名称",
                              style: TextStyle(color: AppTheme.of(context)?.placeholderColor, fontSize: 13),
                            ),
                            Text(
                              widget.file.name!,
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                      CupertinoButton(
                        onPressed: () async {
                          ClipboardData data = new ClipboardData(text: widget.file.name!);
                          Clipboard.setData(data);
                          Utils.toast("已复制到剪贴板");
                        },
                        padding: EdgeInsets.zero,
                        child: Image.asset(
                          "assets/icons/copy.png",
                          width: 20,
                        ),
                      ),
                    ],
                  ),
                  Divider(indent: 0, endIndent: 0, height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "位置",
                              style: TextStyle(color: AppTheme.of(context)?.placeholderColor, fontSize: 13),
                            ),
                            Text(
                              "${widget.file.additional?.realPath}",
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                      CupertinoButton(
                        onPressed: () async {
                          ClipboardData data = ClipboardData(text: widget.file.path!);
                          Clipboard.setData(data);
                          Utils.toast("已复制到剪贴板");
                        },
                        padding: EdgeInsets.zero,
                        child: Image.asset(
                          "assets/icons/copy.png",
                          width: 20,
                        ),
                      ),
                    ],
                  ),
                  Divider(indent: 0, endIndent: 0, height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "大小",
                              style: TextStyle(color: AppTheme.of(context)?.placeholderColor, fontSize: 13),
                            ),
                            if (widget.file.isdir == true)
                              Text(
                                "${Utils.formatSize(dirSize?.totalSize ?? 0, showByte: true)}；${dirSize?.numDir ?? 0}个目录；${dirSize?.numFile ?? 0}个文件",
                                style: TextStyle(fontSize: 16),
                              )
                            else
                              Text(
                                "${Utils.formatSize(widget.file.additional!.size!, showByte: true)}",
                                style: TextStyle(fontSize: 16),
                              ),
                          ],
                        ),
                      ),
                      if (dirSizeLoading)
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: LoadingWidget(
                            size: 20,
                          ),
                        ),
                    ],
                  ),
                  Divider(indent: 0, endIndent: 0, height: 20),
                  if (!widget.file.isdir!) ...[
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "磁盘容量",
                                style: TextStyle(color: AppTheme.of(context)?.placeholderColor, fontSize: 13),
                              ),
                              Text(
                                "${diskSize == null ? '--' : Utils.formatSize(diskSize!, showByte: true)}",
                                style: TextStyle(fontSize: 16),
                              )
                            ],
                          ),
                        ),
                        if (diskSizeLoading)
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12),
                            child: LoadingWidget(
                              size: 20,
                            ),
                          ),
                      ],
                    ),
                    Divider(indent: 0, endIndent: 0, height: 20),
                  ],
                  Text(
                    "创建日期",
                    style: TextStyle(color: AppTheme.of(context)?.placeholderColor, fontSize: 13),
                  ),
                  Text(
                    "${DateTime.fromMillisecondsSinceEpoch((widget.file.additional?.time?.ctime ?? 0) * 1000).format("Y-m-d H:i:s")}",
                    style: TextStyle(fontSize: 16),
                  ),
                  Divider(indent: 0, endIndent: 0, height: 20),
                  Text(
                    "修改日期",
                    style: TextStyle(color: AppTheme.of(context)?.placeholderColor, fontSize: 13),
                  ),
                  Text(
                    "${DateTime.fromMillisecondsSinceEpoch((widget.file.additional?.time?.mtime ?? 0) * 1000).format("Y-m-d H:i:s")}",
                    style: TextStyle(fontSize: 16),
                  ),
                  if (!widget.file.isdir!) ...[
                    Divider(indent: 0, endIndent: 0, height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "MD5",
                                style: TextStyle(color: AppTheme.of(context)?.placeholderColor, fontSize: 13),
                              ),
                              Text(
                                "${md5?.md5 ?? '--'}",
                                style: TextStyle(fontSize: 16),
                              )
                            ],
                          ),
                        ),
                        if (md5Loading)
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12),
                            child: LoadingWidget(
                              size: 20,
                            ),
                          )
                        else if (md5 == null)
                          CupertinoButton(
                            child: Icon(
                              Icons.refresh,
                              size: 20,
                            ),
                            padding: EdgeInsets.zero,
                            onPressed: getFileMd5,
                          )
                        else
                          CupertinoButton(
                            onPressed: () async {
                              ClipboardData data = new ClipboardData(text: md5!.md5!);
                              Clipboard.setData(data);
                              Utils.toast("已复制到剪贴板");
                            },
                            padding: EdgeInsets.zero,
                            child: Image.asset(
                              "assets/icons/copy.png",
                              width: 20,
                            ),
                          ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ),
          if (widget.file.additional?.owner?.user != null && widget.file.additional?.owner?.user != '')
            WidgetCard(
              title: "拥有者",
              body: SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "拥有者",
                      style: TextStyle(color: AppTheme.of(context)?.placeholderColor, fontSize: 13),
                    ),
                    Text(
                      "${widget.file.additional?.owner?.user ?? '--'}",
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
