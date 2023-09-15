import 'package:dsm_helper/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';

class LogSetting extends StatefulWidget {
  final String protocol;
  LogSetting(this.protocol);
  @override
  _LogSettingState createState() => _LogSettingState();
}

class _LogSettingState extends State<LogSetting> {
  late Map setting;
  bool loading = true;
  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    var res = await Api.fileServiceLog(widget.protocol);
    if (res['success']) {
      setState(() {
        setting = res['data'];
        loading = false;
      });
    } else {
      Utils.toast("获取失败，code：${res['error']['code']}");
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("日志设置"),
      ),
      body: loading
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
                    padding: EdgeInsets.all(20),
                    children: [
                      GestureDetector(
                        onTap: () async {
                          setState(() {
                            setting['create'] = setting['create'] == "1" ? "0" : "1";
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                          decoration: BoxDecoration(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: [
                              Text(
                                '创建',
                                style: TextStyle(fontSize: 18),
                              ),
                              Spacer(),
                              if (setting['create'] == "1")
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
                        onTap: () async {
                          setState(() {
                            setting['write'] = setting['write'] == "1" ? "0" : "1";
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                          decoration: BoxDecoration(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: [
                              Text(
                                '写入',
                                style: TextStyle(fontSize: 18),
                              ),
                              Spacer(),
                              if (setting['write'] == "1")
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
                        onTap: () async {
                          setState(() {
                            setting['move'] = setting['move'] == "1" ? "0" : "1";
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                          decoration: BoxDecoration(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: [
                              Text(
                                '移动',
                                style: TextStyle(fontSize: 18),
                              ),
                              Spacer(),
                              if (setting['move'] == "1")
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
                        onTap: () async {
                          setState(() {
                            setting['delete'] = setting['delete'] == "1" ? "0" : "1";
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                          decoration: BoxDecoration(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: [
                              Text(
                                '删除',
                                style: TextStyle(fontSize: 18),
                              ),
                              Spacer(),
                              if (setting['delete'] == "1")
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
                        onTap: () async {
                          setState(() {
                            setting['read'] = setting['read'] == "1" ? "0" : "1";
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                          decoration: BoxDecoration(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: [
                              Text(
                                '读取',
                                style: TextStyle(fontSize: 18),
                              ),
                              Spacer(),
                              if (setting['read'] == "1")
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
                        onTap: () async {
                          setState(() {
                            setting['rename'] = setting['rename'] == "1" ? "0" : "1";
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                          decoration: BoxDecoration(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: [
                              Text(
                                '重命名',
                                style: TextStyle(fontSize: 18),
                              ),
                              Spacer(),
                              if (setting['rename'] == "1")
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
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: CupertinoButton(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(20),
                    onPressed: () async {
                      var res = await Api.fileServiceLogSave(widget.protocol, setting);
                      print(res);
                      if (res['success']) {
                        Utils.vibrate(FeedbackType.light);
                        Utils.toast("应用成功");
                        Navigator.of(context).pop();
                      } else {
                        Utils.vibrate(FeedbackType.warning);
                        Utils.toast("应用失败，code:${res['error']['code']}");
                      }
                    },
                    child: Text(
                      ' 应用 ',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
