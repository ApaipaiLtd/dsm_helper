import 'dart:math';

import 'package:dsm_helper/util/function.dart';
import 'package:dsm_helper/widgets/neu_back_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:neumorphic/neumorphic.dart';

class AddSharedFolders extends StatefulWidget {
  final List volumes;
  final Map folder;
  AddSharedFolders(this.volumes, {this.folder});
  @override
  _AddSharedFoldersState createState() => _AddSharedFoldersState();
}

class _AddSharedFoldersState extends State<AddSharedFolders> {
  TextEditingController volumeController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController shareQuotaController = TextEditingController();
  List<String> units = ["TB", "GB", "MB"];
  int selectedUnitIndex = 1;
  TextEditingController unitController = TextEditingController();
  bool creating = false;
  String oldName;
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
  num shareQuotaUsed;
  String shareQuota = "";
  bool loading = false;
  @override
  void initState() {
    if (widget.folder != null) {
      getFolderDetail(widget.folder['name']);
    }

    volumeController.text = "${widget.volumes[selectedVolumeIndex]['display_name']}(可用容量：${Util.formatSize(int.parse(widget.volumes[selectedVolumeIndex]['size_free_byte']))}) - ${widget.volumes[selectedVolumeIndex]['fs_type']}";
    unitController.text = units[selectedUnitIndex];
    super.initState();
  }

  getFolderDetail(String folderName) async {
    setState(() {
      loading = true;
    });
    var res = await Api.shareDetail(folderName);
    if (res['success']) {
      var folder = res['data'];
      nameController.text = name = oldName = folder['name'];
      descController.text = desc = folder['desc'];
      hidden = folder['hidden'];
      hideUnreadable = folder['hide_unreadable'];

      recycleBin = folder['enable_recycle_bin'];
      recycleBinAdminOnly = folder['recycle_bin_admin_only'];
      encryption = folder['encryption'] == 1;
      if (folder['quota_value'] > 0) {
        enableShareQuota = true;
        if (folder['quota_value'] < 1024) {
          selectedUnitIndex = 2;
          shareQuota = "${folder['quota_value']}";
        } else if (folder['quota_value'] < 1024 * 1024) {
          selectedUnitIndex = 1;
          shareQuota = "${folder['quota_value'] ~/ 1024}";
        } else {
          selectedUnitIndex = 0;
          shareQuota = "${folder['quota_value'] ~/ (1024 * 1024)}";
        }
        unitController.text = units[selectedUnitIndex];
        shareQuotaController.text = shareQuota;
      }

      enableShareCow = folder['enable_share_cow'];
      enableShareCompress = folder['enable_share_compress'];

      shareQuotaUsed = folder['share_quota_used'];

      for (var i = 0; i < widget.volumes.length; i++) {
        if (widget.volumes[i]['volume_path'] == folder['vol_path']) {
          selectedVolumeIndex = i;
          volumeController.text = "${widget.volumes[selectedVolumeIndex]['display_name']}(可用容量：${Util.formatSize(int.parse(widget.volumes[selectedVolumeIndex]['size_free_byte']))}) - ${widget.volumes[selectedVolumeIndex]['fs_type']}";
          break;
        }
      }

      setState(() {
        loading = false;
      });
    } else {
      if (res['error']['code'] == 402) {
        Util.toast("此共享文件夹不存在");
      } else {
        Util.toast("加载失败，code: ${res['error']['code']}");
      }

      Navigator.of(context).pop();
    }
  }

  _save() async {
    FocusScope.of(context).unfocus();
    print(name);
    if (name.trim() == "") {
      Util.toast("请输入共享文件夹名称");
      return;
    }
    if (encryption) {
      if (password.length < 8) {
        Util.toast("加密密钥最短为8位");
        return;
      }
      if (password != confirmPassword) {
        Util.toast("加密密钥和确认密钥不一致");
        return;
      }
    }
    if (enableShareQuota) {
      if (shareQuotaController.text.trim() == "") {
        Util.toast("请输入共享文件夹配额");
        return;
      }
      try {
        shareQuota = "${int.parse(shareQuotaController.text) * pow(1024, 2 - selectedUnitIndex)}";
      } catch (e) {
        Util.toast("共享文件夹配额仅支持输入整数");
        return;
      }
    }
    setState(() {
      creating = true;
    });

    var res = await Api.addSharedFolder(
      name,
      widget.volumes[1]['volume_path'],
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
      method: widget.folder != null ? 'set' : 'create',
    );

    setState(() {
      creating = false;
    });
    print(res);
    if (res['success']) {
      Util.toast("${widget.folder != null ? '修改' : '新增'}共享文件夹成功");
      Navigator.of(context).pop(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: AppBackButton(context),
        title: Text(
          "${widget.folder != null ? '修改' : '新增'}共享文件夹",
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: EdgeInsets.all(20),
                children: <Widget>[
                  SizedBox(
                    height: 20,
                  ),
                  NeuCard(
                    decoration: NeumorphicDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    bevel: 20,
                    curveType: CurveType.flat,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: TextField(
                      controller: nameController,
                      onChanged: (v) => name = v,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        labelText: '名称',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  NeuCard(
                    decoration: NeumorphicDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    bevel: 20,
                    curveType: CurveType.flat,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: TextField(
                      controller: descController,
                      onChanged: (v) => desc = v,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        labelText: '描述',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      FocusScope.of(context).unfocus();
                      showCupertinoModalPopup(
                        context: context,
                        builder: (context) {
                          return Material(
                            color: Colors.transparent,
                            child: NeuCard(
                              width: double.infinity,
                              bevel: 20,
                              curveType: CurveType.emboss,
                              decoration: NeumorphicDecoration(color: Theme.of(context).scaffoldBackgroundColor, borderRadius: BorderRadius.vertical(top: Radius.circular(22))),
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
                                          padding: EdgeInsets.only(bottom: 20),
                                          child: NeuButton(
                                            onPressed: () {
                                              setState(() {
                                                selectedVolumeIndex = widget.volumes.indexOf(volume);
                                              });
                                              volumeController.value = TextEditingValue(text: "${widget.volumes[selectedVolumeIndex]['display_name']}(可用容量：${Util.formatSize(int.parse(widget.volumes[selectedVolumeIndex]['size_free_byte']))}) - ${widget.volumes[selectedVolumeIndex]['fs_type']}");
                                              Navigator.of(context).pop();
                                            },
                                            decoration: NeumorphicDecoration(
                                              color: Theme.of(context).scaffoldBackgroundColor,
                                              borderRadius: BorderRadius.circular(25),
                                            ),
                                            bevel: 20,
                                            padding: EdgeInsets.symmetric(vertical: 10),
                                            child: Container(
                                              padding: EdgeInsets.only(left: 20),
                                              width: double.infinity,
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text("${volume['display_name']}(可用容量：${Util.formatSize(int.parse(volume['size_free_byte']))}) - ${volume['fs_type']}"),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    "${volume['description']}",
                                                    style: TextStyle(color: Colors.grey),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                      NeuButton(
                                        onPressed: () async {
                                          Navigator.of(context).pop();
                                        },
                                        decoration: NeumorphicDecoration(
                                          color: Theme.of(context).scaffoldBackgroundColor,
                                          borderRadius: BorderRadius.circular(25),
                                        ),
                                        bevel: 20,
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
                    child: NeuCard(
                      decoration: NeumorphicDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      bevel: 20,
                      curveType: CurveType.flat,
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      child: TextField(
                        controller: volumeController,
                        decoration: InputDecoration(
                          enabled: false,
                          border: InputBorder.none,
                          labelText: "所在位置",
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      FocusScope.of(context).unfocus();
                      setState(() {
                        hidden = !hidden;
                      });
                    },
                    child: NeuCard(
                      decoration: NeumorphicDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      curveType: hidden ? CurveType.emboss : CurveType.flat,
                      bevel: 20,
                      height: 60,
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      child: Row(
                        children: [
                          Text("在“网上邻居”隐藏此共享文件夹"),
                          Spacer(),
                          if (hidden)
                            Icon(
                              CupertinoIcons.checkmark_alt,
                              color: Color(0xffff9813),
                            ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      FocusScope.of(context).unfocus();
                      setState(() {
                        hideUnreadable = !hideUnreadable;
                      });
                    },
                    child: NeuCard(
                      decoration: NeumorphicDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      curveType: hideUnreadable ? CurveType.emboss : CurveType.flat,
                      bevel: 20,
                      height: 60,
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      child: Row(
                        children: [
                          Text("对没有权限的用户隐藏子文件夹和文件"),
                          Spacer(),
                          if (hideUnreadable)
                            Icon(
                              CupertinoIcons.checkmark_alt,
                              color: Color(0xffff9813),
                            ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: GestureDetector(
                          onTap: () {
                            FocusScope.of(context).unfocus();
                            setState(() {
                              recycleBin = !recycleBin;
                            });
                          },
                          child: NeuCard(
                            decoration: NeumorphicDecoration(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            curveType: recycleBin ? CurveType.emboss : CurveType.flat,
                            bevel: 20,
                            height: 60,
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "启用回收站",
                                    overflow: TextOverflow.clip,
                                    maxLines: 1,
                                  ),
                                ),
                                if (recycleBin)
                                  Icon(
                                    CupertinoIcons.checkmark_alt,
                                    color: Color(0xffff9813),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        flex: 4,
                        child: GestureDetector(
                          onTap: () {
                            FocusScope.of(context).unfocus();
                            if (recycleBin) {
                              setState(() {
                                recycleBinAdminOnly = !recycleBinAdminOnly;
                              });
                            }
                          },
                          child: NeuCard(
                            decoration: NeumorphicDecoration(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            curveType: !recycleBin
                                ? CurveType.convex
                                : recycleBinAdminOnly
                                    ? CurveType.emboss
                                    : CurveType.flat,
                            bevel: 20,
                            height: 60,
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "只允许管理员访问",
                                    overflow: TextOverflow.clip,
                                    maxLines: 1,
                                  ),
                                ),
                                if (recycleBinAdminOnly)
                                  Icon(
                                    CupertinoIcons.checkmark_alt,
                                    color: Color(0xffff9813),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      FocusScope.of(context).unfocus();
                      setState(() {
                        encryption = !encryption;
                      });
                    },
                    child: NeuCard(
                      decoration: NeumorphicDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      curveType: encryption ? CurveType.emboss : CurveType.flat,
                      bevel: 20,
                      height: 60,
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      child: Row(
                        children: [
                          Text("加密共享此文件夹"),
                          Spacer(),
                          if (encryption)
                            Icon(
                              CupertinoIcons.checkmark_alt,
                              color: Color(0xffff9813),
                            ),
                        ],
                      ),
                    ),
                  ),
                  if (encryption) ...[
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: NeuCard(
                            decoration: NeumorphicDecoration(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            bevel: 20,
                            curveType: CurveType.flat,
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                            child: TextField(
                              onChanged: (v) => password = v,
                              obscureText: true,
                              controller: passwordController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                labelText: '加密密钥',
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: NeuCard(
                            decoration: NeumorphicDecoration(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            bevel: 20,
                            curveType: CurveType.flat,
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                            child: TextField(
                              onChanged: (v) => confirmPassword = v,
                              obscureText: true,
                              controller: confirmPasswordController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                labelText: '确认密钥',
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      FocusScope.of(context).unfocus();
                      if (widget.volumes[selectedVolumeIndex]['fs_type'] == "btrfs") {
                        setState(() {
                          enableShareCow = !enableShareCow;
                        });
                      }
                    },
                    child: NeuCard(
                      decoration: NeumorphicDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      curveType: widget.volumes[selectedVolumeIndex]['fs_type'] != "btrfs"
                          ? CurveType.convex
                          : enableShareCow
                              ? CurveType.emboss
                              : CurveType.flat,
                      bevel: 20,
                      height: 60,
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      child: Row(
                        children: [
                          Text("启用数据总和检查码以实现高级数据完整性"),
                          Spacer(),
                          if (enableShareCow)
                            Icon(
                              CupertinoIcons.checkmark_alt,
                              color: Color(0xffff9813),
                            ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      FocusScope.of(context).unfocus();
                      if (widget.volumes[selectedVolumeIndex]['fs_type'] == "btrfs") {
                        setState(() {
                          enableShareCompress = !enableShareCompress;
                        });
                      }
                    },
                    child: NeuCard(
                      decoration: NeumorphicDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      curveType: widget.volumes[selectedVolumeIndex]['fs_type'] != "btrfs"
                          ? CurveType.convex
                          : enableShareCompress
                              ? CurveType.emboss
                              : CurveType.flat,
                      bevel: 20,
                      height: 60,
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      child: Row(
                        children: [
                          Text("启用文件压缩"),
                          Spacer(),
                          if (enableShareCompress)
                            Icon(
                              CupertinoIcons.checkmark_alt,
                              color: Color(0xffff9813),
                            ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      FocusScope.of(context).unfocus();
                      if (widget.volumes[selectedVolumeIndex]['fs_type'] == "btrfs") {
                        setState(() {
                          enableShareQuota = !enableShareQuota;
                        });
                      }
                    },
                    child: NeuCard(
                      decoration: NeumorphicDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      curveType: widget.volumes[selectedVolumeIndex]['fs_type'] != "btrfs"
                          ? CurveType.convex
                          : enableShareQuota
                              ? CurveType.emboss
                              : CurveType.flat,
                      bevel: 20,
                      height: 60,
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      child: Row(
                        children: [
                          Text("启用共享文件夹配额"),
                          if (shareQuotaUsed != null)
                            Text(
                              "(已使用${Util.formatSize((shareQuotaUsed * 1024 * 1024).toInt())})",
                              style: TextStyle(color: Colors.blue),
                            ),
                          Spacer(),
                          if (enableShareQuota)
                            Icon(
                              CupertinoIcons.checkmark_alt,
                              color: Color(0xffff9813),
                            ),
                        ],
                      ),
                    ),
                  ),
                  if (enableShareQuota) ...[
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: NeuCard(
                            decoration: NeumorphicDecoration(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            bevel: 20,
                            curveType: CurveType.flat,
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
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
                                    child: NeuCard(
                                      width: double.infinity,
                                      bevel: 20,
                                      curveType: CurveType.emboss,
                                      decoration: NeumorphicDecoration(color: Theme.of(context).scaffoldBackgroundColor, borderRadius: BorderRadius.vertical(top: Radius.circular(22))),
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
                                                  child: NeuButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        selectedUnitIndex = units.indexOf(unit);
                                                      });
                                                      unitController.value = TextEditingValue(text: units[selectedUnitIndex]);
                                                      Navigator.of(context).pop();
                                                    },
                                                    decoration: NeumorphicDecoration(
                                                      color: Theme.of(context).scaffoldBackgroundColor,
                                                      borderRadius: BorderRadius.circular(25),
                                                    ),
                                                    bevel: 20,
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
                                              NeuButton(
                                                onPressed: () async {
                                                  Navigator.of(context).pop();
                                                },
                                                decoration: NeumorphicDecoration(
                                                  color: Theme.of(context).scaffoldBackgroundColor,
                                                  borderRadius: BorderRadius.circular(25),
                                                ),
                                                bevel: 20,
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
                            child: NeuCard(
                              decoration: NeumorphicDecoration(
                                color: Theme.of(context).scaffoldBackgroundColor,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              bevel: 20,
                              curveType: CurveType.flat,
                              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                              child: TextField(
                                controller: unitController,
                                decoration: InputDecoration(
                                  enabled: false,
                                  border: InputBorder.none,
                                  labelText: "单位",
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ],
              ),
            ),
            SafeArea(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: NeuButton(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  decoration: NeumorphicDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  onPressed: _save,
                  child: creating
                      ? Center(
                          child: CupertinoActivityIndicator(
                            radius: 13,
                          ),
                        )
                      : Text(
                          ' 保存 ',
                          style: TextStyle(fontSize: 18),
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
