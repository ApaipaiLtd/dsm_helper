import 'package:cool_ui/cool_ui.dart';
import 'package:dsm_helper/apis/api.dart';
import 'package:dsm_helper/apis/dsm_api/dsm_api.dart';
import 'package:dsm_helper/database/table_extension.dart';
import 'package:dsm_helper/database/tables.dart';
import 'package:dsm_helper/models/api_model.dart';
import 'package:dsm_helper/models/synology/qcid_model.dart' hide Server;
import 'package:dsm_helper/pages/login/login.dart';
import 'package:dsm_helper/utils/db_utils.dart';
import 'package:dsm_helper/utils/extensions/datetime_ext.dart';
import 'package:dsm_helper/utils/extensions/navigator_ext.dart';
import 'package:dsm_helper/utils/utils.dart' hide Api, DateTimeExt;
import 'package:dsm_helper/widgets/button.dart';
import 'package:dsm_helper/widgets/glass/glass_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddServer extends StatefulWidget {
  const AddServer({this.server, super.key});
  final Server? server;
  @override
  State<AddServer> createState() => _AddServerState();
}

class _AddServerState extends State<AddServer> {
  final TextEditingController _domainController = TextEditingController();
  final TextEditingController _portController = TextEditingController();
  final TextEditingController _remarkController = TextEditingController();

  bool ssl = false;
  bool checkSsl = false;
  String domain = "";
  String port = "";
  String qcid = "";
  String remark = '';
  bool loading = false;
  bool get isQcid => !domain.contains(".") && !domain.contains("[");
  int get realPort => port.isEmpty
      ? ssl
          ? 5001
          : 5000
      : int.parse(port);
  @override
  void initState() {
    if (widget.server != null) {
      setState(() {
        ssl = widget.server!.ssl;
        checkSsl = widget.server!.checkSsl;
        domain = widget.server!.domain;
        _domainController.text = domain;
        if ((ssl && widget.server!.port != 5001) || (!ssl && widget.server!.port != 5000)) {
          port = widget.server!.port.toString();
          _portController.text = port;
        }

        remark = widget.server!.remark;
        _remarkController.text = remark;
        qcid = widget.server!.qcid;
      });
    }
    super.initState();
  }

  submit() async {
    if (domain.isEmpty) {
      Utils.toast("请输入网址/IP/QC ID");
      return;
    }
    setState(() {
      loading = true;
    });

    if (!isQcid) {
      // 网址、IP
      try {
        Api.dsm = DsmApi(baseUrl: '${ssl ? 'https' : 'http'}://$domain:$realPort');
        ApiModel.apiInfo = await ApiModel.info();
        if (widget.server == null) {
          navToLogin();
        } else {
          DbUtils.db.updateServer(widget.server!.copyWith(
            ssl: ssl,
            checkSsl: checkSsl,
            domain: domain,
            port: realPort,
            remark: remark,
            qcid: qcid,
          ));
          context.pop();
        }
      } catch (e) {
        Utils.toast("服务器连接失败");
      } finally {
        setState(() {
          loading = false;
        });
      }
    } else {
      // QCID
      getRealHostByQcId();
    }
  }

  navToLogin() async {
    // 判断是否存在
    List<Server> res = await (DbUtils.db.select(DbUtils.db.servers)..where((server) => server.domain.equals(domain))).get();
    if (res.length > 0) {
      showGlassDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("提示"),
            content: Text("服务器$domain已存在，请直接登录或者返回选择已有账号"),
            actionsOverflowDirection: VerticalDirection.up,
            actions: [
              Row(
                children: [
                  Expanded(
                    child: Button(
                      child: Text("确定"),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Button(
                      child: Text("登录"),
                      onPressed: () async {
                        Navigator.of(context).pop();
                        Server server = res[0];
                        var hide = showWeuiLoadingToast(context: context);
                        Api.dsm = DsmApi(baseUrl: server.url);
                        ApiModel.apiInfo = await ApiModel.info();
                        hide();
                        context.push(Login(res[0]), replace: true);
                      },
                    ),
                  ),
                ],
              )
            ],
          );
        },
      );
      return;
    }
    Server server = await DbUtils.db.into(DbUtils.db.servers).insertReturning(
          ServersCompanion.insert(
            ssl: ssl,
            groupId: 1,
            domain: domain,
            port: realPort,
            qcid: qcid,
            checkSsl: checkSsl,
            remark: remark,
            macAddress: '',
            createTime: DateTime.now().secondsSinceEpoch,
          ),
        );
    context.push(Login(server), replace: true);
  }

  getRealHostByQcId() async {
    try {
      List<String> qcAddresses = await QcidModel.getRealHostByQcId(domain);
      String? validQcAddress = await QcidModel.pingpong(qcAddresses, ssl);
      if (validQcAddress != null) {
        Uri uri = Uri.parse("${ssl ? 'https://' : "http://"}$validQcAddress");
        domain = uri.host;
        port = "${uri.port}";
        navToLogin();
      } else {
        Utils.toast("QuickConnect访问错误");
      }

      // for (String address in qcAddresses) {
      //   QcidModel.pingpong(address).then((res) {
      //     if (!valid && res == true) {
      //       valid = true;
      //     }
      //   });
      // }
      setState(() {
        loading = false;
      });
    } on FormatException catch (e) {
      Utils.toast(e.message);
      setState(() {
        loading = false;
      });
    } catch (e) {
      print(e);
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.server == null ? '添加' : '修改'}服务器"),
        actions: [
          CupertinoButton(
            onPressed: () {
              showGlassDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text("输入示例"),
                    content: Text("网址：example.domain.com\nIPv4：192.168.0.100\nIPv6：[aaaa:bbbb:cccc:dddd]\nQCID：quick connect id"),
                    actions: [
                      Button(
                        child: Text("我知道了"),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            },
            child: Icon(
              Icons.help,
              size: 24,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              children: [
                Image.asset(
                  "assets/devices/ds_923+.png",
                  width: 200,
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    Button(
                      child: Text(
                        "HTTPS",
                        strutStyle: StrutStyle(
                          forceStrutHeight: true,
                        ),
                      ),
                      color: ssl ? Colors.green : null,
                      fill: ssl,
                      borderColor: ssl ? Colors.green : Colors.black,
                      icon: Icon(
                        ssl ? Icons.lock_outline : Icons.lock_open,
                        color: ssl ? Colors.white : Colors.black,
                        size: 16,
                      ),
                      onPressed: () {
                        setState(() {
                          ssl = !ssl;
                        });
                      },
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Button(
                      child: Text(
                        "校验SSL证书",
                        strutStyle: StrutStyle(
                          forceStrutHeight: true,
                        ),
                      ),
                      disabled: !ssl,
                      color: checkSsl ? Colors.green : null,
                      fill: checkSsl,
                      borderColor: checkSsl ? Colors.green : Colors.black,
                      icon: Icon(
                        checkSsl ? Icons.check_circle : Icons.check_circle_outline,
                        color: checkSsl ? Colors.white : Colors.black,
                        size: 16,
                      ),
                      onPressed: () {
                        setState(() {
                          checkSsl = !checkSsl;
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        onChanged: (v) => setState(() {
                          domain = v;
                        }),
                        controller: _domainController,
                        keyboardType: TextInputType.url,
                        decoration: InputDecoration(
                          hintText: "网址/IP/QC ID",
                          iconColor: Colors.red,
                          suffixIcon: domain.isNotEmpty
                              ? GestureDetector(
                                  child: Icon(Icons.highlight_remove),
                                  onTap: () {
                                    setState(() {
                                      domain = '';
                                      _domainController.clear();
                                    });
                                  },
                                )
                              : null,
                          // suffixIconColor: Colors.red,
                        ),
                      ),
                    ),
                    if (!isQcid) ...[
                      SizedBox(
                        width: 20,
                      ),
                      SizedBox(
                        width: 90,
                        child: TextField(
                          controller: _portController,
                          onChanged: (v) => port = v,
                          maxLength: 5,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: ssl ? "5001" : "5000",
                            counterText: '',
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  onChanged: (v) => setState(() {
                    remark = v;
                  }),
                  controller: _remarkController,
                  keyboardType: TextInputType.url,
                  decoration: InputDecoration(
                    hintText: "备注",
                    iconColor: Colors.red,
                    suffixIcon: remark.isNotEmpty
                        ? GestureDetector(
                            child: Icon(Icons.highlight_remove),
                            onTap: () {
                              setState(() {
                                remark = '';
                                _remarkController.clear();
                              });
                            },
                          )
                        : null,
                    // suffixIconColor: Colors.red,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Button(
                  child: Text(widget.server == null ? "下一步" : '保存'),
                  loading: loading,
                  onPressed: submit,
                  disabled: domain.isEmpty,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
