import 'dart:convert';

import 'package:dsm_helper/themes/app_theme.dart';
import 'package:dsm_helper/utils/extensions/navigator_ext.dart';
import 'package:dsm_helper/utils/utils.dart';
import 'package:dsm_helper/widgets/empty_widget.dart';
import 'package:dsm_helper/widgets/glass/glass_app_bar.dart';
import 'package:dsm_helper/widgets/glass/glass_scaffold.dart';
import 'package:dsm_helper/widgets/loading_widget.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sp_util/sp_util.dart';

import 'add_server.dart';
import 'ssh.dart';

class SelectTerminalServer extends StatefulWidget {
  @override
  _SelectTerminalServerState createState() => _SelectTerminalServerState();
}

class _SelectTerminalServerState extends State<SelectTerminalServer> {
  bool loading = true;
  List servers = [];
  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    String str = SpUtil.getString("terminal_servers")!;
    setState(() {
      loading = false;
      if (str.isNotBlank) {
        servers = json.decode(str);
      } else {
        servers = [];
      }
    });
    print(servers);
  }

  Widget _buildServerItem(int index) {
    var server = servers[index];
    return Padding(
      padding: EdgeInsets.only(bottom: 20),
      child: CupertinoButton(
        onPressed: () async {
          Navigator.of(context).push(
            CupertinoPageRoute(
              builder: (context) {
                return Ssh(server['host'], server['port'], server['account'], server['password']);
              },
              settings: RouteSettings(name: "ssh_client"),
            ),
          );
        },
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(20),
        padding: EdgeInsets.zero,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${server['account']}",
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "${server['host']}:${server['port']}",
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              CupertinoButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(CupertinoPageRoute(
                          builder: (context) {
                            return AddServer(index: index);
                          },
                          settings: RouteSettings(name: "add_ssh_server")))
                      .then((value) {
                    getData();
                  });
                },
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(10),
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Image.asset(
                  "assets/icons/edit.png",
                  width: 20,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              CupertinoButton(
                onPressed: () {
                  setState(() {
                    servers.remove(server);
                  });

                  SpUtil.putString("terminal_servers", jsonEncode(servers));
                  Utils.toast("删除成功");
                },
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(10),
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Image.asset(
                  "assets/icons/delete.png",
                  width: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GlassScaffold(
      appBar: GlassAppBar(
        title: Text("选择服务器"),
        actions: [
          CupertinoButton(
            onPressed: () {
              context.push(AddServer(), name: 'add_terminal_server').then((res) {
                getData();
              });
            },
            child: Image.asset(
              "assets/icons/plus_circle.png",
              width: 24,
            ),
          )
        ],
      ),
      body: loading
          ? Center(
              child: LoadingWidget(
                size: 30,
              ),
            )
          : servers.length > 0
              ? ListView.builder(
                  padding: EdgeInsets.all(20),
                  itemBuilder: (context, i) {
                    return _buildServerItem(i);
                  },
                  itemCount: servers.length,
                )
              : Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      EmptyWidget(
                        text: "未添加服务器",
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: 200,
                        child: CupertinoButton(
                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                          color: AppTheme.of(context)?.primaryColor,
                          borderRadius: BorderRadius.circular(15),
                          onPressed: () {
                            context.push(AddServer(), name: 'add_terminal_server').then((res) {
                              getData();
                            });
                          },
                          child: Text(
                            '添加',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }
}
