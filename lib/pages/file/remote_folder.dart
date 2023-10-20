import 'package:dsm_helper/pages/dashboard/widgets/widget_card.dart';
import 'package:dsm_helper/pages/file/select_folder.dart';
import 'package:dsm_helper/themes/app_theme.dart';
import 'package:dsm_helper/utils/utils.dart';
import 'package:dsm_helper/widgets/bubble_tab_indicator.dart';
import 'package:dsm_helper/widgets/button.dart';
import 'package:dsm_helper/widgets/glass/glass_app_bar.dart';
import 'package:dsm_helper/widgets/glass/glass_scaffold.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';

class RemoteFolder extends StatefulWidget {
  @override
  _RemoteFolderState createState() => _RemoteFolderState();
}

class _RemoteFolderState extends State<RemoteFolder> with SingleTickerProviderStateMixin {
  TabController? _tabController;
  String serverIp = "";
  String mountPoint = "";
  bool autoMount = false;
  String account = "";
  String passwd = "";
  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GlassScaffold(
      appBar: GlassAppBar(
        title: Text("装载远程文件夹"),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: [
            Tab(
              text: "CIFS",
            ),
            Tab(
              text: "NFS",
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          ListView(
            children: [
              WidgetCard(
                body: Column(
                  children: [
                    TextField(
                      onChanged: (v) => serverIp = v,
                      decoration: InputDecoration(labelText: '远程文件夹', hintText: r"示例:\\192.168.1.1\share"),
                    ),
                    TextField(
                      onChanged: (v) => account = v,
                      decoration: InputDecoration(
                        labelText: '账号',
                      ),
                    ),
                    TextField(
                      onChanged: (v) => passwd = v,
                      decoration: InputDecoration(
                        labelText: '密码',
                      ),
                    ),
                    CupertinoButton(
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        showCupertinoModalPopup(
                          context: context,
                          builder: (context) {
                            return SelectFolder(
                              multi: false,
                            );
                          },
                        ).then((res) {
                          if (res != null && res.length == 1) {
                            setState(() {
                              mountPoint = res[0];
                            });
                          }
                        });
                      },
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(20),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "装载到",
                                  style: TextStyle(fontSize: 12),
                                ),
                                SizedBox(
                                  height: 20,
                                  child: Text(
                                    mountPoint == "" ? "选择装载到文件夹" : mountPoint,
                                    style: TextStyle(fontSize: 16, color: mountPoint == "" ? Colors.grey : null),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "开机时自动装载",
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                          child: Transform.scale(
                            scale: 0.8,
                            child: CupertinoSwitch(
                              value: autoMount,
                              onChanged: (v) {
                                setState(() {
                                  autoMount = v;
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Button(
                      color: AppTheme.of(context)?.primaryColor,
                      onPressed: () async {
                        if (mountPoint == "") {
                          Utils.toast("请选择保存位置");
                          Utils.vibrate(FeedbackType.impact);
                          return;
                        }
                        if (serverIp.trim() == "") {
                          Utils.toast("请输入远程文件夹地址");
                          return;
                        }
                        var res = await Api.mountFolder(serverIp, account, passwd, mountPoint, autoMount);
                        if (res['success']) {
                          Utils.toast("装载成功");
                          Utils.vibrate(FeedbackType.light);
                        } else {
                          Utils.vibrate(FeedbackType.warning);
                          if (res['error']['code'] == 436) {
                            Utils.toast("远程文件夹地址有误");
                          } else {
                            Utils.toast("装载失败，代码${res['error']['code']}");
                          }
                        }
                      },
                      child: Text(
                        ' 装载 ',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Center(
            child: Text("开发中"),
          ),
        ],
      ),
    );
  }
}
