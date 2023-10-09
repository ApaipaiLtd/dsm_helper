import 'dart:async';
import 'dart:ui';

import 'package:dsm_helper/models/Syno/Core/Share.dart';
import 'package:dsm_helper/models/Syno/Core/Storage/Volume.dart';
import 'package:dsm_helper/models/Syno/FileStation/Sharing.dart';
import 'package:dsm_helper/pages/control_panel/shared_folders/add_shared_folder.dart';
import 'package:dsm_helper/themes/app_theme.dart';
import 'package:dsm_helper/utils/extensions/navigator_ext.dart';
import 'package:dsm_helper/utils/utils.dart';
import 'package:dsm_helper/widgets/custom_dialog/custom_dialog.dart';
import 'package:dsm_helper/widgets/empty_widget.dart';
import 'package:dsm_helper/widgets/file_icon.dart';
import 'package:dsm_helper/widgets/glass/glass_app_bar.dart';
import 'package:dsm_helper/widgets/glass/glass_scaffold.dart';
import 'package:dsm_helper/widgets/loading_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kumi_popup_window/kumi_popup_window.dart';

class SharedFolders extends StatefulWidget {
  @override
  _SharedFoldersState createState() => _SharedFoldersState();
}

class _SharedFoldersState extends State<SharedFolders> {
  bool loading = true;
  Share share = Share();
  Volume volume = Volume();
  Timer? timer;
  @override
  void initState() {
    getVolumes();
    super.initState();
  }

  getVolumes() async {
    setState(() {
      loading = true;
    });
    volume = await Volume.list();
    getShares();
  }

  getShares() async {
    share = await Share.list();
    setState(() {
      loading = false;
    });
    share.shares!.forEach((folder) {
      folder.volume = volume.volumes!.firstWhere((element) => element.volumePath == folder.volPath);
    });
  }

  deleteFolder(String folder) {
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
                    "删除共享文件夹",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Text(
                    "我已了解所选共享文件夹及其快照将被永久删除并无法恢复",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400, color: Colors.red),
                  ),
                  SizedBox(
                    height: 22,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: CupertinoButton(
                          onPressed: () async {
                            Navigator.of(context).pop();
                            var res = await Api.deleteSharedFolder([folder]);
                            print(res);
                            if (res['success']) {
                              Utils.toast("共享文件夹删除成功");
                              getShares();
                            } else {
                              Utils.toast("共享文件夹删除出错");
                            }
                          },
                          color: Theme.of(context).scaffoldBackgroundColor,
                          borderRadius: BorderRadius.circular(25),
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            "确认删除",
                            style: TextStyle(fontSize: 18, color: Colors.redAccent),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: CupertinoButton(
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
  }

  Widget _buildFolderItem(Shares folder) {
    GlobalKey actionButtonKey = GlobalKey();
    return Container(
      margin: EdgeInsets.only(top: 16.0, left: 16, right: 14),
      padding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Row(
            children: [
              folder.encryption == null || folder.encryption == 0
                  ? FileIcon(
                      FileTypeEnum.folder,
                      width: 30,
                    )
                  : Image.asset(
                      "assets/icons/folder_locked.png",
                      width: 30,
                      height: 30,
                    ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      folder.name!,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "${folder.volume?.displayName}${folder.volume?.description ?? ""}",
                      style: TextStyle(fontSize: 12, color: AppTheme.of(context)?.placeholderColor),
                    ),
                  ],
                ),
              ),
              CupertinoButton(
                key: actionButtonKey,
                onPressed: () {
                  showPopupWindow(
                    context,
                    gravity: KumiPopupGravity.leftBottom,
                    bgColor: Colors.transparent,
                    clickOutDismiss: true,
                    clickBackDismiss: true,
                    customAnimation: false,
                    customPop: false,
                    customPage: false,
                    underStatusBar: true,
                    underAppBar: true,
                    needSafeDisplay: true,
                    offsetX: 0,
                    offsetY: -70,
                    // curve: Curves.easeInSine,
                    duration: Duration(milliseconds: 200),
                    targetRenderBox: actionButtonKey.currentContext!.findRenderObject() as RenderBox,
                    childFun: (pop) {
                      return BackdropFilter(
                        key: GlobalKey(),
                        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                        child: Container(
                          width: 220,
                          padding: EdgeInsets.symmetric(vertical: 8),
                          margin: EdgeInsets.only(top: 50),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(23),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              PopupMenuItem(
                                onTap: () {
                                  context.push(AddSharedFolders([], folder: folder), name: "add_shared_folders");
                                },
                                child: Row(
                                  children: [
                                    Image.asset(
                                      "assets/icons/pencil.png",
                                      width: 20,
                                      height: 20,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text("编辑"),
                                  ],
                                ),
                              ),
                              if (folder.supportSnapshot!)
                                PopupMenuItem(
                                  onTap: () async {
                                    Navigator.of(context).pop();
                                  },
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        "assets/icons/delete.png",
                                        width: 20,
                                        height: 20,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "克隆",
                                      ),
                                    ],
                                  ),
                                ),
                              if (folder.enableRecycleBin == true)
                                PopupMenuItem(
                                  onTap: () async {
                                    Api.cleanRecycleBin(folder.name!).then((res) {
                                      if (res['success']) {
                                        Utils.toast("请求已发送");
                                      }
                                    });
                                  },
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        "assets/icons/delete.png",
                                        width: 20,
                                        height: 20,
                                        color: AppTheme.of(context)?.warningColor,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "清空回收站",
                                        style: TextStyle(color: AppTheme.of(context)?.warningColor),
                                      ),
                                    ],
                                  ),
                                ),
                              PopupMenuItem(
                                onTap: () async {
                                  deleteFolder(folder.name!);
                                },
                                child: Row(
                                  children: [
                                    Image.asset(
                                      "assets/icons/delete.png",
                                      width: 20,
                                      height: 20,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "删除",
                                      style: TextStyle(color: AppTheme.of(context)?.errorColor),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                padding: EdgeInsets.zero,
                minSize: 0,
                child: Image.asset(
                  "assets/icons/more_vertical.png",
                  width: 20,
                  height: 20,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (folder.unitePermission != null) ...[
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "高级权限：${folder.unitePermission! ? "已启动" : "已停用"}",
                        style: TextStyle(fontSize: 12, color: Theme.of(context).textTheme.headlineSmall?.color),
                      ),
                    ],
                    if (folder.enableRecycleBin != null) ...[
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "回收站：${folder.enableRecycleBin! ? "已启动" : "已停用"}",
                        style: TextStyle(fontSize: 12, color: Theme.of(context).textTheme.headlineSmall?.color),
                      ),
                    ],
                    if (folder.quotaValue != null) ...[
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "共享文件夹配额：${folder.quotaValue! > 0 ? Utils.formatSize(folder.quotaValue! * 1024 * 1024) : "已停用"}",
                        style: TextStyle(fontSize: 12, color: Theme.of(context).textTheme.headlineSmall?.color),
                      ),
                    ],
                    if (folder.shareQuotaUsed != null) ...[
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "共享文件夹大小：${Utils.formatSize(folder.shareQuotaUsed! * 1024 * 1024)}",
                        style: TextStyle(fontSize: 12, color: Theme.of(context).textTheme.headlineSmall?.color),
                      ),
                    ],
                    if (folder.enableShareCompress != null) ...[
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "文件压缩：${folder.enableShareCompress! ? "已启动" : "已禁用"}",
                        style: TextStyle(fontSize: 12, color: Theme.of(context).textTheme.headlineSmall?.color),
                      ),
                    ],
                    if (folder.enableShareCow != null) ...[
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "数据完整性保护：${folder.enableShareCow! ? "已启动" : "已禁用"}",
                        style: TextStyle(fontSize: 12, color: Theme.of(context).textTheme.headlineSmall?.color),
                      ),
                    ],
                  ],
                ),
              ),
              SizedBox(
                width: 10,
              ),
              if (folder.isShareMoving == true) Text("移动中")
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GlassScaffold(
      appBar: GlassAppBar(
        title: Text("共享文件夹"),
        actions: [
          CupertinoButton(
            onPressed: () async {
              context.push(AddSharedFolders([]), name: "add_shared_folders").then((res) {
                if (res == true) {
                  getShares();
                }
              });
            },
            child: Icon(Icons.add),
          )
        ],
      ),
      body: loading
          ? Center(
              child: LoadingWidget(
                size: 30,
              ),
            )
          : share.shares != null && share.shares!.length > 0
              ? ListView.builder(
                  itemBuilder: (context, i) {
                    return _buildFolderItem(share.shares![i]);
                  },
                  itemCount: share.shares!.length,
                )
              : EmptyWidget(
                  text: "暂无共享文件夹",
                ),
    );
  }
}
