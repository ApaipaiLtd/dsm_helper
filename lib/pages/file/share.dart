import 'dart:convert';

import 'package:cool_ui/cool_ui.dart';
import 'package:dsm_helper/models/Syno/FileStation/Sharing.dart';
import 'package:dsm_helper/pages/dashboard/widgets/widget_card.dart';
import 'package:dsm_helper/pages/file/dialogs/cancel_share_dialog.dart';
import 'package:dsm_helper/themes/app_theme.dart';
import 'package:dsm_helper/utils/extensions/navigator_ext.dart';
import 'package:dsm_helper/utils/utils.dart';
import 'package:dsm_helper/widgets/glass/glass_app_bar.dart';
import 'package:dsm_helper/widgets/glass/glass_scaffold.dart';
import 'package:dsm_helper/widgets/loading_widget.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:sp_util/sp_util.dart';

class Share extends StatefulWidget {
  final List<String>? paths;
  final ShareLinks? shareLink;
  final bool fileRequest;
  Share({this.paths, this.shareLink, this.fileRequest = false});
  @override
  _ShareState createState() => _ShareState();
}

class _ShareState extends State<Share> {
  bool loading = true;
  ShareLinks? shareLink;
  DateTime? dateAvailable;
  DateTime? dateExpired;
  String expireTimes = "0";
  String requestName = "";
  String requestInfo = "";
  Uint8List? qrCodeBytes;
  TextEditingController expireTimesController = TextEditingController();
  TextEditingController dateExpiredController = TextEditingController();
  TextEditingController dateAvailableController = TextEditingController();
  TextEditingController requestNameController = TextEditingController();
  TextEditingController requestInfoController = TextEditingController();

  @override
  void initState() {
    if (widget.paths != null) {
      getData();
    } else if (widget.shareLink != null) {
      setState(() {
        loading = false;
        shareLink = widget.shareLink;
        setData(shareLink!);
      });
    }
    super.initState();
  }

  setData(ShareLinks shareLink) {
    expireTimes = shareLink.expireTimes == 0 ? "" : shareLink.expireTimes.toString();
    if (shareLink.dateExpired != null && shareLink.dateExpired != "") {
      dateExpired = DateTime.parse(shareLink.dateExpired!);
    }
    if (shareLink.dateAvailable != null && shareLink.dateAvailable != "") {
      dateAvailable = DateTime.parse(shareLink.dateAvailable!);
    }
    qrCodeBytes = Base64Decoder().convert(shareLink.qrcode!.split(",")[1]);
    String dateExpiredStr = dateExpired == null ? "" : dateExpired!.format("Y-m-d H:i");
    String dateAvailableStr = dateAvailable == null ? "" : dateAvailable!.format("Y-m-d H:i");
    expireTimesController = TextEditingController.fromValue(TextEditingValue(text: expireTimes));
    dateExpiredController = TextEditingController.fromValue(TextEditingValue(text: dateExpiredStr));
    dateAvailableController = TextEditingController.fromValue(TextEditingValue(text: dateAvailableStr));
    if (shareLink.enableUpload!) {
      requestName = shareLink.requestName!;
      requestNameController = TextEditingController.fromValue(TextEditingValue(text: requestName));
      requestInfo = shareLink.requestInfo!;
      requestInfoController = TextEditingController.fromValue(TextEditingValue(text: requestInfo));
    }
  }

  getData() async {
    if (widget.fileRequest) {
      requestName = SpUtil.getString("account", defValue: "")!;
      requestInfo = "嗨，我的朋友！请将文件上传到此处。";
    }
    var res = await Sharing.create(paths: widget.paths!, fileRequest: widget.fileRequest, requestName: requestName, requestInfo: requestInfo);
    setState(() {
      loading = false;
      if (res.links != null && res.links!.length > 0) {
        shareLink = res.links!.first;
        setData(shareLink!);
      }
    });
  }

  Widget _buildLinkItem(ShareLinks link) {
    return Column(
      children: [
        if (qrCodeBytes != null)
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.memory(
              qrCodeBytes!,
              height: 150,
            ),
          ),
        SizedBox(
          height: 20,
        ),
        Text(
          link.name!,
          style: TextStyle(fontSize: 26),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          link.path!,
          style: TextStyle(color: AppTheme.of(context)?.placeholderColor, fontSize: 14),
        ),
        WidgetCard(
          title: "链接设置",
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "共享链接：",
                style: TextStyle(fontSize: 14, color: AppTheme.of(context)?.placeholderColor),
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "${link.url}",
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  CupertinoButton(
                    onPressed: () async {
                      ClipboardData data = new ClipboardData(text: link.url!);
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
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                  DatePicker.showDateTimePicker(
                    context,
                    showTitleActions: true,
                    maxTime: dateExpired,
                    onConfirm: (date) {
                      setState(() {
                        dateAvailable = date;
                      });
                      dateAvailableController.text = dateAvailable!.format("Y-m-d H:i");
                    },
                    currentTime: dateAvailable ?? DateTime.now(),
                    locale: LocaleType.zh,
                  );
                },
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "起始时间：",
                        style: TextStyle(fontSize: 14, color: AppTheme.of(context)?.placeholderColor),
                      ),
                      Text(
                        dateAvailable == null ? '未设置' : dateAvailable!.format("Y-m-d H:i:s"),
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
              Divider(indent: 0, endIndent: 0, height: 20),
              GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                  DatePicker.showDateTimePicker(
                    context,
                    showTitleActions: true,
                    minTime: dateAvailable ?? DateTime.now(),
                    onConfirm: (date) {
                      setState(() {
                        dateExpired = date;
                      });
                      dateExpiredController.text = dateExpired!.format("Y-m-d H:i");
                    },
                    currentTime: dateExpired ?? DateTime.now(),
                    locale: LocaleType.zh,
                  );
                },
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "停止时间：",
                        style: TextStyle(fontSize: 14, color: AppTheme.of(context)?.placeholderColor),
                      ),
                      Text(
                        dateExpired == null ? '未设置' : dateExpired!.format("Y-m-d H:i:s"),
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
              Divider(indent: 0, endIndent: 0, height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "允许访问的次数：",
                    style: TextStyle(fontSize: 14, color: AppTheme.of(context)?.placeholderColor),
                  ),
                  TextField(
                    controller: expireTimesController,
                    keyboardType: TextInputType.number,
                    onChanged: (v) => expireTimes = v,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: InputDecoration(
                      isDense: true,
                      border: InputBorder.none,
                      hintText: '允许访问的次数',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        if (link.enableUpload == true)
          WidgetCard(
            title: "消息自定义",
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: requestNameController,
                  onChanged: (v) => requestName = v,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: '您的姓名',
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: requestInfoController,
                  onChanged: (v) => requestInfo = v,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: '信息',
                  ),
                ),
              ],
            ),
          )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GlassScaffold(
      appBar: GlassAppBar(
        title: Text(widget.fileRequest || (shareLink?.enableUpload ?? false) ? "文件请求" : "共享文件"),
        actions: [
          CupertinoButton(
            child: Image.asset(
              "assets/icons/delete.png",
              width: 24,
              height: 24,
            ),
            onPressed: () async {
              bool? res = await CancelShareDialog.show(context: context, share: shareLink!);
              if (res == true) {
                context.pop(true);
              }
            },
          ),
          SizedBox(
            width: double.infinity,
          ),
          CupertinoButton(
            child: Image.asset(
              "assets/icons/save.png",
              width: 24,
              height: 24,
            ),
            onPressed: () async {
              var hide = showWeuiLoadingToast(context: context);
              bool? res = await shareLink!.edit(dateExpired: dateExpired, dateAvailable: dateAvailable, expireTimes: expireTimes, requestName: requestName, requestInfo: requestInfo);
              hide();
              if (res == true) {
                Utils.toast("保存成功");
              }
            },
          ),
        ],
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: loading
            ? Center(
                child: LoadingWidget(size: 30),
              )
            : ListView(
                children: [
                  _buildLinkItem(shareLink!),
                ],
              ),
      ),
    );
  }
}
