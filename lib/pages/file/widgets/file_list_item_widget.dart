import 'dart:ui';

import 'package:cool_ui/cool_ui.dart';
import 'package:dsm_helper/apis/api.dart';
import 'package:dsm_helper/models/Syno/FileStation/FileStationList.dart';
import 'package:dsm_helper/pages/file/detail.dart';
import 'package:dsm_helper/pages/file/dialogs/delete_favorite_dialog.dart';
import 'package:dsm_helper/pages/file/dialogs/delete_file_dialog.dart';
import 'package:dsm_helper/pages/file/dialogs/rename_file_dialog.dart';
import 'package:dsm_helper/pages/file/share.dart';
import 'package:dsm_helper/themes/app_theme.dart';
import 'package:dsm_helper/utils/extensions/navigator_ext.dart';
import 'package:dsm_helper/utils/utils.dart' hide Api;
import 'package:dsm_helper/widgets/file_icon.dart';
import 'package:extended_text/extended_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kumi_popup_window/kumi_popup_window.dart';

class FileListItemWidget extends StatelessWidget {
  final FileItem file;
  final bool remote;
  final bool favorite;
  final bool shareFolder;
  final bool multiSelectMode;
  final bool selected;
  final Function()? onLongPress;
  final Function()? onTap;
  const FileListItemWidget(
    this.file, {
    this.remote = false,
    this.favorite = false,
    this.multiSelectMode = false,
    this.selected = false,
    this.shareFolder = false,
    this.onLongPress,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    GlobalKey actionButtonKey = GlobalKey();
    Widget fileInfo = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ExtendedText(
          file.name!,
          style: TextStyle(fontSize: 16, color: file.additional?.mountPointType == "remotefail" ? AppTheme.of(context)?.placeholderColor : null),
          overflowWidget: TextOverflowWidget(
            position: TextOverflowPosition.middle,
            align: TextOverflowAlign.right,
            child: Text(
              "…",
              style: TextStyle(color: Colors.grey),
            ),
          ),
          maxLines: 2,
        ),
        SizedBox(
          height: 2,
        ),
        Text.rich(
          TextSpan(
            children: [
              if (file.additional != null || (file.additional?.time != null && file.additional?.time?.mtime != null))
                TextSpan(
                  text: DateTime.fromMillisecondsSinceEpoch(file.additional!.time!.mtime! * 1000).format("Y/m/d H:i:s"),
                ),
              if (file.isdir == false) TextSpan(text: " · ${Utils.formatSize(file.additional!.size!, showByte: true)}"),
            ],
            style: TextStyle(fontSize: 12, color: AppTheme.of(context)?.placeholderColor),
          ),
        ),
        if (remote)
          Text(
            file.path!,
            style: TextStyle(fontSize: 12, color: AppTheme.of(context)?.placeholderColor),
          ),
      ],
    );
    Widget actionButton = multiSelectMode
        ? Container(
            width: 52,
            height: 52,
            alignment: Alignment.center,
            child: Container(
              decoration: BoxDecoration(
                color: selected ? AppTheme.of(context)?.primaryColor : Theme.of(context).disabledColor,
                borderRadius: BorderRadius.circular(10),
              ),
              width: 20,
              height: 20,
              alignment: Alignment.center,
              child: selected
                  ? Image.asset(
                      "assets/icons/check.png",
                      width: 13,
                      height: 13,
                    )
                  : null,
            ),
          )
        : CupertinoButton(
            key: actionButtonKey,
            onPressed: () {
              // fileAction(file, remote: remote);
              showPopupWindow(
                context,
                gravity: KumiPopupGravity.leftTop,
                bgColor: Colors.transparent,
                clickOutDismiss: true,
                clickBackDismiss: true,
                customAnimation: false,
                customPop: false,
                customPage: false,
                underStatusBar: true,
                underAppBar: true,
                needSafeDisplay: true,
                offsetX: 30,
                offsetY: 30,
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
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                            child: fileInfo,
                          ),
                          Divider(height: 1),
                          if (shareFolder) ...[
                            PopupMenuItem(
                              onTap: () async {
                                context.push(FileDetail(file), rootNavigator: true);
                              },
                              child: Row(
                                children: [
                                  Image.asset(
                                    "assets/icons/info_file.png",
                                    width: 20,
                                    height: 20,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text("属性"),
                                ],
                              ),
                            ),
                            if (file.additional?.realPath?.startsWith("/volumeUSB") ?? false)
                              PopupMenuItem(
                                child: Row(
                                  children: [
                                    Image.asset(
                                      "assets/icons/eject.png",
                                      width: 20,
                                      height: 20,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text("弹出"),
                                  ],
                                ),
                              ),
                          ] else if (favorite) ...[
                            PopupMenuItem(
                              onTap: () async {
                                bool? res = await RenameFileDialog.show(context: context, file: file);
                                if (res == true) {}
                              },
                              child: Row(
                                children: [
                                  Image.asset(
                                    "assets/icons/rename.png",
                                    width: 20,
                                    height: 20,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text("重命名"),
                                ],
                              ),
                            ),
                            PopupMenuItem(
                              onTap: () async {
                                bool? res = await DeleteFavoriteDialog.show(context: context, favorite: file);
                                if (res == true) {}
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
                                    "取消收藏",
                                    style: TextStyle(color: AppTheme.of(context)?.errorColor),
                                  ),
                                ],
                              ),
                            ),
                          ] else ...[
                            PopupMenuItem(
                              onTap: () async {
                                context.push(FileDetail(file), rootNavigator: true);
                              },
                              child: Row(
                                children: [
                                  Image.asset(
                                    "assets/icons/info_file.png",
                                    width: 20,
                                    height: 20,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text("属性"),
                                ],
                              ),
                            ),
                            PopupMenuItem(
                              child: Row(
                                children: [
                                  Image.asset(
                                    "assets/icons/download_cloud.png",
                                    width: 20,
                                    height: 20,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text("下载"),
                                ],
                              ),
                            ),
                            PopupMenuItem(
                              onTap: () {
                                context.push(Share(paths: [file.path!]), name: "share", rootNavigator: true);
                              },
                              child: Row(
                                children: [
                                  Image.asset(
                                    "assets/icons/share.png",
                                    width: 20,
                                    height: 20,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text("共享"),
                                ],
                              ),
                            ),
                            if (file.isdir == true)
                              PopupMenuItem(
                                onTap: () {
                                  context.push(Share(paths: [file.path!], fileRequest: true), name: "share", rootNavigator: true);
                                },
                                child: Row(
                                  children: [
                                    Image.asset(
                                      "assets/icons/upload_cloud.png",
                                      width: 20,
                                      height: 20,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text("文件请求"),
                                  ],
                                ),
                              ),
                            PopupMenuItem(
                              onTap: () async {
                                var hide = showWeuiLoadingToast(context: context);
                                try {
                                  var res = await file.addFavorite();
                                  if (res.success == true) {
                                    Utils.toast("添加收藏成功");
                                  } else if (res.error != null) {
                                    if (res.error!['code'] == 800) {
                                      Utils.toast('添加收藏失败：“${file.path!}”已经被添加至“收藏夹”');
                                    } else {
                                      Utils.toast("添加收藏失败");
                                    }
                                  } else {
                                    Utils.toast("添加收藏失败");
                                  }
                                } finally {
                                  hide();
                                }
                              },
                              child: Row(
                                children: [
                                  Image.asset(
                                    "assets/icons/star.png",
                                    width: 20,
                                    height: 20,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text("添加收藏"),
                                ],
                              ),
                            ),
                            if (!remote)
                              PopupMenuItem(
                                onTap: () async {
                                  var hide = showWeuiLoadingToast(context: context);
                                  String taskId = await FileItem.compress([file], destFolderPath: "${file.ownerPath}/${file.fileName}.zip");
                                  hide();
                                  if (taskId.isNotEmpty) {
                                    Utils.toast("压缩任务创建成功");
                                  }
                                },
                                child: Row(
                                  children: [
                                    Image.asset(
                                      "assets/icons/archive.png",
                                      width: 20,
                                      height: 20,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("压缩到"),
                                          ExtendedText(
                                            "${file.fileName}.zip",
                                            maxLines: 1,
                                            overflowWidget: TextOverflowWidget(
                                              position: TextOverflowPosition.middle,
                                              align: TextOverflowAlign.right,
                                              child: Text(
                                                "…",
                                                style: TextStyle(color: Colors.grey),
                                              ),
                                            ),
                                            style: TextStyle(color: AppTheme.of(context)?.placeholderColor, fontSize: 12),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            if (file.fileType == FileTypeEnum.zip && !remote)
                              PopupMenuItem(
                                onTap: () async {
                                  var hide = showWeuiLoadingToast(context: context);
                                  String taskId = await file.extract(destFolderPath: "${file.ownerPath}/${file.fileName}", createSubfolder: true);
                                  hide();
                                  if (taskId.isNotEmpty) {
                                    Utils.toast("解压任务创建成功");
                                  }
                                },
                                child: Row(
                                  children: [
                                    Image.asset(
                                      "assets/icons/unzip.png",
                                      width: 20,
                                      height: 20,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("解压到"),
                                          ExtendedText(
                                            "${file.fileName}",
                                            maxLines: 1,
                                            overflowWidget: TextOverflowWidget(
                                              position: TextOverflowPosition.middle,
                                              align: TextOverflowAlign.right,
                                              child: Text(
                                                "…",
                                                style: TextStyle(color: Colors.grey),
                                              ),
                                            ),
                                            style: TextStyle(color: AppTheme.of(context)?.placeholderColor, fontSize: 12),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            PopupMenuItem(
                              onTap: () async {
                                bool? res = await RenameFileDialog.show(context: context, file: file);
                                if (res == true) {}
                              },
                              child: Row(
                                children: [
                                  Image.asset(
                                    "assets/icons/rename.png",
                                    width: 20,
                                    height: 20,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text("重命名"),
                                ],
                              ),
                            ),
                            PopupMenuItem(
                              onTap: () async {
                                String? res = await DeleteFileDialog.show(context: context, files: [file]);
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
                        ],
                      ),
                    ),
                  );
                },
              );
            },
            child: Image.asset(
              "assets/icons/more_horizontal.png",
              width: 20,
              height: 20,
            ),
          );
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onLongPress: onLongPress,
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
        child: Row(
          children: [
            Hero(
              tag: Api.dsm.baseUrl! + "/webapi/entry.cgi?path=${Uri.encodeComponent(file.path!)}&size=original&api=SYNO.FileStation.Thumb&method=get&version=2&_sid=${Api.dsm.sid!}&animate=true",
              child: FileIcon(file.fileType, thumb: file.path!, size: 30, thumbSize: 40),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: fileInfo,
            ),
            SizedBox(
              width: 10,
            ),
            actionButton,
          ],
        ),
      ),
    );
  }
}
