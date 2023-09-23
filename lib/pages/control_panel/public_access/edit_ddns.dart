import 'package:cool_ui/cool_ui.dart';
import 'package:dsm_helper/utils/utils.dart';
import 'package:dsm_helper/utils/neu_picker.dart';
import 'package:dsm_helper/widgets/label.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';

class EditDdns extends StatefulWidget {
  final Map? ddns;
  final List extIp;
  final List providers;
  const EditDdns(this.providers, {this.extIp = const [], this.ddns, super.key});

  @override
  _EditDdnsState createState() => _EditDdnsState();
}

class _EditDdnsState extends State<EditDdns> {
  TextEditingController _hostnameController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();
  Map ddns = {};
  Map statusStr = {
    "service_ddns_normal": "正常",
    "service_ddns_error_unknown": "联机失败",
    "loading": "加载中",
    "disabled": "已停用",
  };
  @override
  void initState() {
    if (widget.ddns != null) {
      setState(() {
        ddns.addAll(widget.ddns!);
      });
      _hostnameController.value = TextEditingValue(text: ddns['hostname']);
      _usernameController.value = TextEditingValue(text: ddns['username']);
    } else {
      ddns = {"enable": true, "heartbeat": false, "net": "DEFAULT", "ip": "-", "ipv6": "-"};
      if (widget.extIp.length > 0) {
        ddns['ip'] = widget.extIp.first['ip'];
        ddns['ipv6'] = widget.extIp.first['ipv6'];
      }
    }
    if (ddns['ip'] == "0.0.0.0") {
      ddns["ip"] = "-";
    }
    if (ddns['ipv6'] == "0:0:0:0:0:0:0:0") {
      ddns['ipv6'] = "-";
    }
    super.initState();
  }

  deleteDdns() async {
    Utils.vibrate(FeedbackType.warning);
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
                    "确认删除",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Text(
                    "确认要删除以下DDNS？",
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
                            var res = await Api.ddnsDelete(widget.ddns!['id']);
                            print(res);
                            if (res['success']) {
                              Utils.toast("DDNS删除成功");
                              Navigator.of(context).pop(true);
                            } else {
                              Utils.toast("删除失败，代码:${res['error']['code']}");
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
                        width: 20,
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

  bool checkForm() {
    if (ddns['provider'] == null || ddns['provider'] == "") {
      Utils.toast("请选择服务供应商");
      return false;
    } else if (ddns['hostname'] == null || ddns['hostname'] == "") {
      Utils.toast("请输入主机名称");
      return false;
    } else if (ddns['username'] == null || ddns['username'] == "") {
      Utils.toast("请输入用户名/电子邮件");
      return false;
    } else if (widget.ddns == null && (ddns['passwd'] == null || ddns['passwd'] == "")) {
      Utils.toast("请输入密码/密钥");
      return false;
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("DDNS"),
        actions: [
          if (widget.ddns != null)
            Padding(
              padding: EdgeInsets.only(right: 10, top: 8, bottom: 8),
              child: CupertinoButton(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(10),
                padding: EdgeInsets.all(10),
                onPressed: deleteDdns,
                child: Image.asset(
                  "assets/icons/delete.png",
                  width: 30,
                ),
              ),
            ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(20),
              children: [
                if (widget.ddns != null) ...[
                  GestureDetector(
                    onTap: () async {
                      setState(() {
                        ddns['enable'] = !ddns['enable'];
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: EdgeInsets.all(20),
                      child: Row(
                        children: [
                          Text("启用支持DDNS"),
                          Spacer(),
                          if (ddns['enable'])
                            Icon(
                              CupertinoIcons.checkmark_alt,
                              color: Color(0xffff9813),
                              size: 22,
                            ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
                GestureDetector(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                    if (widget.ddns != null) {
                      return;
                    }
                    showCupertinoModalPopup(
                      context: context,
                      builder: (context) {
                        return NeuPicker(
                          widget.providers.map((e) => e['provider'] as String).toList(),
                          value: widget.providers.indexWhere((element) => element['provider'] == ddns['provider']),
                          onConfirm: (v) {
                            setState(() {
                              ddns['provider'] = widget.providers[v]['provider'];
                              print(ddns['provider']);
                            });
                          },
                        );
                      },
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: EdgeInsets.all(20),
                    child: Row(
                      children: [
                        Text("服务供应商"),
                        Spacer(),
                        Text("${ddns['provider'] != null && ddns['provider'] != "" ? widget.providers.where((element) => element['provider'] == ddns['provider']).first['provider'] : "请选择"}"),
                      ],
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
                    controller: _hostnameController,
                    onChanged: (v) => ddns['hostname'] = v,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      labelText: '主机名称',
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
                    controller: _usernameController,
                    onChanged: (v) => ddns['username'] = v,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      labelText: '用户名/电子邮件',
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
                    onChanged: (v) => ddns['passwd'] = v,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      labelText: '密码/密钥',
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
                  padding: EdgeInsets.all(20),
                  child: Row(
                    children: [
                      Text("外部地址(ipv4):"),
                      Spacer(),
                      Text("${ddns['ip']}"),
                    ],
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
                  padding: EdgeInsets.all(20),
                  child: Row(
                    children: [
                      Text("外部地址(ipv6):"),
                      Spacer(),
                      Text("${ddns['ipv6']}"),
                    ],
                  ),
                ),
                //statusStr[ddns['status']] ?? ddns['status']
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: EdgeInsets.all(20),
                        child: Row(
                          children: [
                            Text("状态:"),
                            SizedBox(
                              width: 10,
                            ),
                            if (ddns['status'] != null)
                              Label(
                                statusStr[ddns['status']] ?? ddns['status'],
                                ddns['status'] == "service_ddns_normal" ? Colors.green : Colors.red,
                                fill: true,
                              ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    CupertinoButton(
                      onPressed: () async {
                        if (checkForm()) {
                          var hide = showWeuiLoadingToast(context: context, message: Text("测试中，请稍后"), backButtonClose: true, alignment: Alignment.center);
                          var res = await Api.ddnsTest(ddns);
                          hide();
                          print(res);
                          if (res['success']) {
                            setState(() {
                              ddns['status'] = res['data']['status'];
                            });
                          } else {
                            Utils.toast("测试失败，${res['error']['errors']},code:${res['error']['code']}");
                          }
                        }
                      },
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(20),
                      padding: EdgeInsets.all(20),
                      child: Text("测试联机"),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: CupertinoButton(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(20),
                onPressed: () async {
                  if (checkForm()) {
                    var res = await Api.ddnsSave(ddns);
                    if (res['success']) {
                      Utils.toast("保存成功");
                      Navigator.of(context).pop(true);
                    } else {
                      Utils.toast("保存失败,代码${res['error']['code']}");
                    }
                  }
                },
                child: Text(
                  ' 保存 ',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
