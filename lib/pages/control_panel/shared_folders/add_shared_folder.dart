import 'dart:math';

import 'package:dio/dio.dart';
import 'package:dsm_helper/apis/api.dart';
import 'package:dsm_helper/apis/dsm_api/dsm_exception.dart';
import 'package:dsm_helper/models/Syno/Core/Share.dart';
import 'package:dsm_helper/models/Syno/Core/Storage/Volume.dart';
import 'package:dsm_helper/pages/dashboard/widgets/widget_card.dart';
import 'package:dsm_helper/themes/app_theme.dart';
import 'package:dsm_helper/utils/extensions/navigator_ext.dart';
import 'package:dsm_helper/utils/utils.dart' hide Api;
import 'package:dsm_helper/widgets/glass/glass_app_bar.dart';
import 'package:dsm_helper/widgets/glass/glass_scaffold.dart';
import 'package:dsm_helper/widgets/loading_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';

class AddSharedFolders extends StatefulWidget {
  final List<Volumes> volumes;
  final Shares? folder;
  final String? nameOrg;
  AddSharedFolders(this.volumes, {this.folder, this.nameOrg});
  @override
  _AddSharedFoldersState createState() => _AddSharedFoldersState();
}

class _AddSharedFoldersState extends State<AddSharedFolders> {
  TextEditingController nameController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController shareQuotaController = TextEditingController();
  List<String> units = ["TB", "GB", "MB"];
  int selectedUnitIndex = 1;
  bool creating = false;
  String oldName = "";
  String name = "";
  String desc = "";
  int selectedVolumeIndex = 0;
  bool hidden = false;
  bool hideUnreadable = false;
  bool recycleBin = false;
  bool recycleBinAdminOnly = false;
  bool enableShareCow = false;
  bool enableShareCompress = false;
  bool encryption = false;
  String password = "";
  String confirmPassword = "";
  bool enableShareQuota = false;
  num? shareQuotaUsed;
  String shareQuota = "";
  bool loading = false;
  @override
  void initState() {
    if (widget.nameOrg != null) {
      for (var i = 0; i < widget.volumes.length; i++) {
        if (widget.volumes[i].volumePath == widget.folder!.volPath) {
          selectedVolumeIndex = i;
          break;
        }
      }
      enableShareCow = widget.folder!.enableShareCow!;
      enableShareCompress = widget.folder!.enableShareCompress!;
    } else if (widget.folder != null) {
      getFolderDetail(widget.folder!.name!);
    }
    super.initState();
  }

  getFolderDetail(String folderName) async {
    setState(() {
      loading = true;
    });
    try {
      Shares folder = await Shares.detail(folderName);
      nameController.text = name = oldName = folder.name ?? '';
      descController.text = desc = folder.desc ?? '';
      hidden = folder.hidden ?? false;
      hideUnreadable = folder.hideUnreadable ?? false;

      recycleBin = folder.enableRecycleBin ?? false;
      recycleBinAdminOnly = folder.recycleBinAdminOnly ?? false;
      encryption = folder.encryption == 1;
      if (folder.quotaValue != null && folder.quotaValue! > 0) {
        enableShareQuota = true;
        if (folder.quotaValue! < 1024) {
          selectedUnitIndex = 2;
          shareQuota = "${folder.quotaValue ?? 0}";
        } else if (folder.quotaValue! < 1024 * 1024) {
          selectedUnitIndex = 1;
          shareQuota = "${folder.quotaValue! ~/ 1024}";
        } else {
          selectedUnitIndex = 0;
          shareQuota = "${folder.quotaValue! ~/ (1024 * 1024)}";
        }
        shareQuotaController.text = shareQuota;
      }

      enableShareCow = folder.enableShareCow ?? false;
      enableShareCompress = folder.enableShareCompress ?? false;

      shareQuotaUsed = folder.shareQuotaUsed;

      for (var i = 0; i < widget.volumes.length; i++) {
        if (widget.volumes[i].volumePath == folder.volPath) {
          selectedVolumeIndex = i;
          break;
        }
      }

      setState(() {
        loading = false;
      });
    } catch (e) {
      // if (res['error']['code'] == 402) {
      //   Utils.toast("此共享文件夹不存在");
      // } else {
      print(e);
      Utils.toast("加载失败");
      // }

      Navigator.of(context).pop();
    }
  }

  _save() async {
    FocusScope.of(context).unfocus();
    if (name.trim() == "") {
      Utils.toast("请输入共享文件夹名称");
      return;
    }
    if (encryption) {
      if (password.length < 8) {
        Utils.toast("加密密钥最短为8位");
        return;
      }
      if (password != confirmPassword) {
        Utils.toast("加密密钥和确认密钥不一致");
        return;
      }
    }
    if (enableShareQuota) {
      if (shareQuotaController.text.trim() == "") {
        Utils.toast("请输入共享文件夹配额");
        return;
      }
      try {
        shareQuota = "${int.parse(shareQuotaController.text) * pow(1024, 2 - selectedUnitIndex)}";
      } catch (e) {
        Utils.toast("共享文件夹配额仅支持输入整数");
        return;
      }
    }
    setState(() {
      creating = true;
    });

    try {
      DsmResponse res = await Shares.add(
        name,
        widget.volumes[selectedVolumeIndex].volumePath!,
        desc,
        oldName: oldName,
        encryption: encryption,
        password: password,
        recycleBin: recycleBin,
        recycleBinAdminOnly: recycleBinAdminOnly,
        hidden: hidden,
        hideUnreadable: hideUnreadable,
        enableShareCow: enableShareCow,
        enableShareQuota: enableShareQuota,
        enableShareCompress: enableShareCompress,
        shareQuota: shareQuota,
        method: widget.nameOrg != null
            ? 'clone'
            : widget.folder != null
                ? 'set'
                : 'create',
        nameOrg: widget.nameOrg,
      );
      if (res.success!) {
        Utils.vibrate(FeedbackType.success);
        Utils.toast("${widget.nameOrg != null ? '克隆' : widget.folder != null ? '修改' : '新增'}共享文件夹成功");
        context.pop(true);
      }
    } on DsmException catch (e) {
      Utils.vibrate(FeedbackType.error);
      Utils.toast("${widget.nameOrg != null ? '克隆' : widget.folder != null ? '修改' : '新增'}共享文件夹失败，错误代码：${e.code}");
    } on DioException catch (e) {
      Utils.vibrate(FeedbackType.error);
      Utils.toast("${widget.nameOrg != null ? '克隆' : widget.folder != null ? '修改' : '新增'}共享文件夹失败，${e.response?.statusCode == 502 ? "原因：参数未加密" : "原因：网络错误，代码：${e.response?.statusCode}"}");
    } finally {
      setState(() {
        creating = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GlassScaffold(
      appBar: GlassAppBar(
        title: Text("${widget.nameOrg != null ? '克隆' : widget.folder != null ? '修改' : '新增'}共享文件夹"),
        actions: [
          CupertinoButton(
            child: creating
                ? LoadingWidget(
                    size: 20,
                  )
                : Image.asset(
                    "assets/icons/save.png",
                    width: 24,
                  ),
            onPressed: creating ? null : _save,
          ),
        ],
      ),
      body: loading
          ? Center(
              child: LoadingWidget(
                size: 30,
              ),
            )
          : ListView(
              children: <Widget>[
                WidgetCard(
                  title: "设置基本信息",
                  body: Column(
                    children: [
                      TextField(
                        controller: nameController,
                        onChanged: (v) => name = v,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          labelText: '名称',
                        ),
                      ),
                      TextField(
                        controller: descController,
                        onChanged: (v) => desc = v,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          labelText: '描述',
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          FocusScope.of(context).unfocus();
                          if (widget.nameOrg != null) {
                            return;
                          }
                          showCupertinoModalPopup(
                            context: context,
                            builder: (context) {
                              return Material(
                                color: Colors.transparent,
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(color: Theme.of(context).scaffoldBackgroundColor, borderRadius: BorderRadius.vertical(top: Radius.circular(22))),
                                  child: SafeArea(
                                    top: false,
                                    child: Padding(
                                      padding: EdgeInsets.all(20),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Text(
                                            "选择所在位置",
                                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                                          ),
                                          SizedBox(
                                            height: 12,
                                          ),
                                          ...widget.volumes.map((volume) {
                                            return Padding(
                                              padding: EdgeInsets.only(bottom: 14),
                                              child: GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    selectedVolumeIndex = widget.volumes.indexOf(volume);
                                                  });
                                                  context.pop();
                                                },
                                                behavior: HitTestBehavior.opaque,
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius: BorderRadius.circular(22),
                                                  ),
                                                  width: double.infinity,
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text("${volume.displayName}： ${volume.fsType}"),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Text(
                                                        "可用容量：${Utils.formatSize(int.parse(volume.sizeFreeByte!))}",
                                                        style: TextStyle(color: AppTheme.of(context)?.placeholderColor, fontSize: 14),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          }).toList(),
                                          SizedBox(
                                            width: double.infinity,
                                            child: CupertinoButton(
                                              onPressed: () async {
                                                Navigator.of(context).pop();
                                              },
                                              color: Theme.of(context).dividerColor,
                                              borderRadius: BorderRadius.circular(15),
                                              padding: EdgeInsets.symmetric(vertical: 10),
                                              child: Text("取消"),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "所在位置",
                                    style: TextStyle(color: AppTheme.of(context)?.placeholderColor, fontSize: 13),
                                  ),
                                  Text(
                                    "${widget.volumes[selectedVolumeIndex].displayName}(可用容量：${Utils.formatSize(int.parse(widget.volumes[selectedVolumeIndex].sizeFreeByte!))}) - ${widget.volumes[selectedVolumeIndex].fsType}",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                            Icon(
                              CupertinoIcons.right_chevron,
                              size: 16,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "在“网上邻居”隐藏此共享文件夹",
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                            child: Transform.scale(
                              scale: 0.8,
                              child: CupertinoSwitch(
                                value: hidden,
                                onChanged: (v) {
                                  setState(() {
                                    hidden = v;
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "对没有权限的用户隐藏子文件夹和文件",
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                            child: Transform.scale(
                              scale: 0.8,
                              child: CupertinoSwitch(
                                value: hideUnreadable,
                                onChanged: (v) {
                                  setState(() {
                                    hideUnreadable = v;
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "启用回收站",
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                            child: Transform.scale(
                              scale: 0.8,
                              child: CupertinoSwitch(
                                value: recycleBin,
                                onChanged: (v) {
                                  setState(() {
                                    recycleBin = v;
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      if (recycleBin) ...[
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "只允许管理者访问",
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                              child: Transform.scale(
                                scale: 0.8,
                                child: CupertinoSwitch(
                                  value: recycleBinAdminOnly,
                                  onChanged: (v) {
                                    setState(() {
                                      recycleBinAdminOnly = v;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
                if (widget.nameOrg == null)
                  WidgetCard(
                    title: "加密",
                    body: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "加密共享此文件夹",
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                              child: Transform.scale(
                                scale: 0.8,
                                child: CupertinoSwitch(
                                  value: encryption,
                                  onChanged: (v) {
                                    setState(() {
                                      encryption = v;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        if (encryption) ...[
                          SizedBox(height: 20),
                          TextField(
                            onChanged: (v) => password = v,
                            obscureText: true,
                            controller: passwordController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              labelText: '加密密钥',
                            ),
                          ),
                          TextField(
                            onChanged: (v) => confirmPassword = v,
                            obscureText: true,
                            controller: confirmPasswordController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              labelText: '确认密钥',
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                if (widget.volumes[selectedVolumeIndex].fsType == "btrfs")
                  WidgetCard(
                    title: "高级设置",
                    body: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "启用数据总和检查码以实现高级数据完整性",
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                              child: Transform.scale(
                                scale: 0.8,
                                child: CupertinoSwitch(
                                  value: enableShareCow,
                                  onChanged: widget.nameOrg == null
                                      ? (v) {
                                          setState(() {
                                            enableShareCow = v;
                                          });
                                        }
                                      : null,
                                ),
                              ),
                            ),
                          ],
                        ),
                        if (enableShareCow) ...[
                          SizedBox(height: 20),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "启用文件压缩",
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                                child: Transform.scale(
                                  scale: 0.8,
                                  child: CupertinoSwitch(
                                    value: enableShareCompress,
                                    onChanged: (v) {
                                      setState(() {
                                        enableShareCompress = v;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "启用共享文件夹配额",
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                              child: Transform.scale(
                                scale: 0.8,
                                child: CupertinoSwitch(
                                  value: enableShareQuota,
                                  onChanged: (v) {
                                    setState(() {
                                      enableShareQuota = v;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        if (enableShareQuota) ...[
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: TextField(
                                  onChanged: (v) => shareQuota = v,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                  controller: shareQuotaController,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    labelText: '共享文件夹配额',
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                flex: 1,
                                child: GestureDetector(
                                  onTap: () {
                                    FocusScope.of(context).unfocus();
                                    showCupertinoModalPopup(
                                      context: context,
                                      builder: (context) {
                                        return Material(
                                          color: Colors.transparent,
                                          child: Container(
                                            width: double.infinity,
                                            decoration: BoxDecoration(color: Theme.of(context).scaffoldBackgroundColor, borderRadius: BorderRadius.vertical(top: Radius.circular(22))),
                                            child: SafeArea(
                                              top: false,
                                              child: Padding(
                                                padding: EdgeInsets.all(20),
                                                child: Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: <Widget>[
                                                    Text(
                                                      "选择单位",
                                                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                                                    ),
                                                    SizedBox(
                                                      height: 12,
                                                    ),
                                                    ...units.map((unit) {
                                                      return Padding(
                                                        padding: EdgeInsets.only(bottom: 20),
                                                        child: CupertinoButton(
                                                          onPressed: () {
                                                            setState(() {
                                                              selectedUnitIndex = units.indexOf(unit);
                                                            });
                                                            Navigator.of(context).pop();
                                                          },
                                                          color: Theme.of(context).scaffoldBackgroundColor,
                                                          borderRadius: BorderRadius.circular(25),
                                                          padding: EdgeInsets.symmetric(vertical: 20),
                                                          child: Container(
                                                            width: double.infinity,
                                                            child: Text(
                                                              "$unit",
                                                              textAlign: TextAlign.center,
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    }).toList(),
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
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).scaffoldBackgroundColor,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                                    child: Text(units[selectedUnitIndex]),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ],
                    ),
                  ),
              ],
            ),
    );
  }
}
