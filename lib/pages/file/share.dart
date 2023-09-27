import 'dart:convert';

import 'package:dsm_helper/models/Syno/FileStation/Sharing.dart';
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
        expireTimes = shareLink!.expireTimes == 0 ? "" : shareLink!.expireTimes.toString();
        if (shareLink!.dateExpired != null && shareLink!.dateExpired != "") {
          dateExpired = DateTime.parse(shareLink!.dateExpired!);
        }
        if (shareLink!.dateAvailable != null && shareLink!.dateAvailable != "") {
          dateAvailable = DateTime.parse(shareLink!.dateAvailable!);
        }
        String dateExpiredStr = dateExpired == null ? "" : dateExpired!.format("Y-m-d H:i");
        String dateAvailableStr = dateAvailable == null ? "" : dateAvailable!.format("Y-m-d H:i");
        expireTimesController = TextEditingController.fromValue(TextEditingValue(text: expireTimes));
        dateExpiredController = TextEditingController.fromValue(TextEditingValue(text: dateExpiredStr));
        dateAvailableController = TextEditingController.fromValue(TextEditingValue(text: dateAvailableStr));
        if (shareLink!.enableUpload!) {
          requestName = shareLink!.requestName!;
          requestNameController = TextEditingController.fromValue(TextEditingValue(text: requestName));
          requestInfo = shareLink!.requestInfo!;
          requestInfoController = TextEditingController.fromValue(TextEditingValue(text: requestInfo));
        }
      });
    }

    super.initState();
  }

  deleteShare() async {
    var res = await Api.deleteShare([shareLink!.id!]);
    if (res['success']) {
      Utils.toast("取消共享成功");
      Navigator.of(context).pop();
    }
  }

  getData() async {
    // if (widget.fileRequest) {
    //   requestName = SpUtil.getString("account", defValue: "")!;
    //   requestInfo = "嗨，我的朋友！请将文件上传到此处。";
    // }
    // var res = await Api.createShare(widget.paths!, fileRequest: widget.fileRequest, requestName: requestName, requestInfo: requestInfo);
    // if (res['success']) {
    //   setState(() {
    //     loading = false;
    //     shareLink = res['data']['links'][0];
    //     expireTimes = res['data']['links'][0]['expire_times'] == 0 ? "" : res['data']['links'][0]['expire_times'].toString();
    //     if (shareLink['date_expired'] != "") {
    //       dateExpired = DateTime.parse(shareLink['date_expired']);
    //     }
    //     if (shareLink['date_available'] != "") {
    //       dateAvailable = DateTime.parse(shareLink['date_available']);
    //     }
    //     String endTimeStr = dateExpired?.format("Y-m-d H:i") ?? "";
    //     String startTimeStr = dateAvailable?.format("Y-m-d H:i") ?? "";
    //     expireTimesController = TextEditingController.fromValue(TextEditingValue(text: expireTimes));
    //     dateExpiredController = TextEditingController.fromValue(TextEditingValue(text: endTimeStr));
    //     dateAvailableController = TextEditingController.fromValue(TextEditingValue(text: startTimeStr));
    //     if (shareLink['enable_upload']) {
    //       requestName = shareLink['request_name'];
    //       requestNameController = TextEditingController.fromValue(TextEditingValue(text: requestName));
    //       requestInfo = shareLink['request_info'];
    //       requestInfoController = TextEditingController.fromValue(TextEditingValue(text: requestInfo));
    //     }
    //   });
    // }
  }

  Widget _buildLinkItem(ShareLinks link) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Image.memory(
              Base64Decoder().convert(link.qrcode!.split(",")[1]),
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
          Text(
            link.path!,
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Row(
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
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(10),
                    padding: EdgeInsets.all(5),
                    child: SizedBox(
                      width: 20,
                      height: 20,
                      child: Image.asset(
                        "assets/icons/copy.png",
                        width: 20,
                      ),
                    ),
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
              DatePicker.showDateTimePicker(
                context,
                showTitleActions: true,
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
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(20),
              ),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: TextField(
                controller: dateExpiredController,
                decoration: InputDecoration(
                  enabled: false,
                  border: InputBorder.none,
                  labelText: "设置停止时间",
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
              DatePicker.showDateTimePicker(
                context,
                showTitleActions: true,
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
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(20),
              ),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: TextField(
                controller: dateAvailableController,
                decoration: InputDecoration(
                  enabled: false,
                  border: InputBorder.none,
                  labelText: "设置开始时间",
                ),
              ),
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
              controller: expireTimesController,
              keyboardType: TextInputType.number,
              onChanged: (v) => expireTimes = v,
              decoration: InputDecoration(
                border: InputBorder.none,
                labelText: '允许访问的数量',
              ),
            ),
          ),
          if (link.enableUpload == true) ...[
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
                controller: requestNameController,
                onChanged: (v) => requestName = v,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  labelText: '您的姓名',
                ),
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
                controller: requestInfoController,
                onChanged: (v) => requestInfo = v,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  labelText: '信息',
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GlassScaffold(
      appBar: GlassAppBar(
        title: Text(widget.fileRequest ? "创建文件请求" : "共享文件"),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: loading
            ? Center(
                child: LoadingWidget(size: 30),
              )
            : Column(
                children: [
                  Expanded(
                    child: ListView(
                      children: [
                        _buildLinkItem(shareLink!),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Row(
                      children: [
                        Expanded(
                          child: CupertinoButton(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            borderRadius: BorderRadius.circular(50),
                            onPressed: () async {
                              // List<String> id = [];
                              // List<String> url = [];
                              // id.add(shareLink['id']);
                              // url.add(shareLink['url']);
                              // var res = await Api.editShare(shareLink['path'], id, url, dateExpired, dateAvailable, expireTimes, fileRequest: shareLink['enable_upload'], requestName: requestName, requestInfo: requestInfo);
                              // if (res['success']) {
                              //   Utils.toast("保存成功");
                              // }
                            },
                            child: Text("保存修改"),
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
                                              "确认取消",
                                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                                            ),
                                            SizedBox(
                                              height: 12,
                                            ),
                                            Text(
                                              "确认要取消此共享链接？",
                                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
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
                                                      deleteShare();
                                                    },
                                                    color: Theme.of(context).scaffoldBackgroundColor,
                                                    borderRadius: BorderRadius.circular(25),
                                                    padding: EdgeInsets.symmetric(vertical: 10),
                                                    child: Text(
                                                      "取消共享",
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
                            },
                            child: Text("取消共享"),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
