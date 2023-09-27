import 'dart:convert';

import 'package:dsm_helper/utils/utils.dart';
import 'package:dsm_helper/widgets/glass/glass_app_bar.dart';
import 'package:dsm_helper/widgets/glass/glass_scaffold.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:sp_util/sp_util.dart';

class Share extends StatefulWidget {
  final List<String>? paths;
  final Map? link;
  final bool fileRequest;
  Share({this.paths, this.link, this.fileRequest = false});
  @override
  _ShareState createState() => _ShareState();
}

class _ShareState extends State<Share> {
  bool loading = true;
  Map link = {};
  DateTime? startTime;
  DateTime? endTime;
  String times = "0";
  String requestName = "";
  String requestInfo = "";
  TextEditingController timesController = TextEditingController();
  TextEditingController endTimeController = TextEditingController();
  TextEditingController startTimeController = TextEditingController();
  TextEditingController requestNameController = TextEditingController();
  TextEditingController requestInfoController = TextEditingController();

  @override
  void initState() {
    if (widget.paths != null) {
      getData();
    } else {
      setState(() {
        loading = false;
        link = widget.link!;
        times = link['expire_times'] == 0 ? "" : link['expire_times'].toString();
        if (link['date_expired'] != "") {
          endTime = DateTime.parse(link['date_expired']);
        }
        if (link['date_available'] != "") {
          startTime = DateTime.parse(link['date_available']);
        }
        String endTimeStr = endTime == null ? "" : endTime!.format("Y-m-d H:i");
        String startTimeStr = startTime == null ? "" : startTime!.format("Y-m-d H:i");
        timesController = TextEditingController.fromValue(TextEditingValue(text: times));
        endTimeController = TextEditingController.fromValue(TextEditingValue(text: endTimeStr));
        startTimeController = TextEditingController.fromValue(TextEditingValue(text: startTimeStr));
        if (link['enable_upload']) {
          requestName = link['request_name'];
          requestNameController = TextEditingController.fromValue(TextEditingValue(text: requestName));
          requestInfo = link['request_info'];
          requestInfoController = TextEditingController.fromValue(TextEditingValue(text: requestInfo));
        }
      });
    }

    super.initState();
  }

  deleteShare() async {
    var res = await Api.deleteShare([link['id']]);
    if (res['success']) {
      Utils.toast("取消共享成功");
      Navigator.of(context).pop();
    }
  }

  getData() async {
    if (widget.fileRequest) {
      requestName = SpUtil.getString("account", defValue: "")!;
      requestInfo = "嗨，我的朋友！请将文件上传到此处。";
    }
    var res = await Api.createShare(widget.paths!, fileRequest: widget.fileRequest, requestName: requestName, requestInfo: requestInfo);
    if (res['success']) {
      setState(() {
        loading = false;
        link = res['data']['links'][0];
        times = res['data']['links'][0]['expire_times'] == 0 ? "" : res['data']['links'][0]['expire_times'].toString();
        if (link['date_expired'] != "") {
          endTime = DateTime.parse(link['date_expired']);
        }
        if (link['date_available'] != "") {
          startTime = DateTime.parse(link['date_available']);
        }
        String endTimeStr = endTime?.format("Y-m-d H:i") ?? "";
        String startTimeStr = startTime?.format("Y-m-d H:i") ?? "";
        timesController = TextEditingController.fromValue(TextEditingValue(text: times));
        endTimeController = TextEditingController.fromValue(TextEditingValue(text: endTimeStr));
        startTimeController = TextEditingController.fromValue(TextEditingValue(text: startTimeStr));
        if (link['enable_upload']) {
          requestName = link['request_name'];
          requestNameController = TextEditingController.fromValue(TextEditingValue(text: requestName));
          requestInfo = link['request_info'];
          requestInfoController = TextEditingController.fromValue(TextEditingValue(text: requestInfo));
        }
      });
    }
  }

  Widget _buildLinkItem(link) {
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
              Base64Decoder().convert(link['qrcode'].split(",")[1]),
              height: 150,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            link['name'],
            style: TextStyle(fontSize: 26),
          ),
          Text(
            link['path'],
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
                      "${link['url']}",
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  CupertinoButton(
                    onPressed: () async {
                      ClipboardData data = new ClipboardData(text: link['url']);
                      Clipboard.setData(data);
                      Utils.toast("已复制到剪贴板");
                    },
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(10),
                    padding: EdgeInsets.all(5),
                    child: SizedBox(
                      width: 20,
                      height: 20,
                      child: Icon(
                        Icons.copy,
                        color: Color(0xffff9813),
                        size: 16,
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
                    endTime = date;
                  });
                  endTimeController.text = endTime!.format("Y-m-d H:i");
                },
                currentTime: endTime ?? DateTime.now(),
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
                controller: endTimeController,
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
                    startTime = date;
                  });
                  startTimeController.text = startTime!.format("Y-m-d H:i");
                },
                currentTime: startTime ?? DateTime.now(),
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
                controller: startTimeController,
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
              controller: timesController,
              keyboardType: TextInputType.number,
              onChanged: (v) => times = v,
              decoration: InputDecoration(
                border: InputBorder.none,
                labelText: '允许访问的数量',
              ),
            ),
          ),
          if (link['enable_upload']) ...[
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
                child: Container(
                  padding: EdgeInsets.all(50),
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: CupertinoActivityIndicator(
                    radius: 14,
                  ),
                ),
              )
            : Column(
                children: [
                  Expanded(
                    child: ListView(
                      children: [
                        _buildLinkItem(link),
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
                              List<String> id = [];
                              List<String> url = [];
                              id.add(link['id']);
                              url.add(link['url']);
                              var res = await Api.editShare(link['path'], id, url, endTime, startTime, times, fileRequest: link['enable_upload'], requestName: requestName, requestInfo: requestInfo);
                              if (res['success']) {
                                Utils.toast("保存成功");
                              }
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
