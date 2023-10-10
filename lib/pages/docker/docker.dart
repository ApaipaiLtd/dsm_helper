import 'package:dsm_helper/pages/docker/image_page.dart';
import 'package:dsm_helper/pages/docker/log_page.dart';
import 'package:dsm_helper/pages/docker/network_page.dart';
import 'package:dsm_helper/pages/docker/repository_page.dart';
import 'package:dsm_helper/utils/utils.dart';
import 'package:dsm_helper/widgets/glass/glass_app_bar.dart';
import 'package:dsm_helper/widgets/glass/glass_scaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'container_page.dart';

class Docker extends StatefulWidget {
  final String title;
  Docker({this.title = 'Docker'});
  @override
  _DockerState createState() => _DockerState();
}

class _DockerState extends State<Docker> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 5, vsync: this);
    // getImage();
    super.initState();
  }

  // getImage() async {
  //   var res = await Api.dockerImageInfo();
  //   Log.logger.info(res);
  //   setState(() {
  //     imageLoading = false;
  //   });
  //   if (res['success']) {
  //     List result = res['data']['result'];
  //     result.forEach((item) {
  //       if (item['success'] == true) {
  //         switch (item['api']) {
  //           case "SYNO.Docker.Image":
  //             setState(() {
  //               images = item['data']['images'];
  //               images.sort((a, b) {
  //                 return a['repository'].compareTo(b['repository']);
  //               });
  //             });
  //             break;
  //           case "SYNO.Docker.Registry":
  //             setState(() {
  //               registries = item['data']['registries'];
  //             });
  //             break;
  //         }
  //       }
  //     });
  //   }
  // }

  power(container, String action, {bool? preserveProfile}) async {
    if (action == "signal" || action == "delete") {
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
                      "确认操作",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Text(
                      action == "signal"
                          ? "是否确定要强制停止容器？所有未保存的数据将丢失！"
                          : preserveProfile == true
                              ? "容器 ${container['name']} 将被清除。清除后，容器中的所有数据将丢失。是否确定继续？"
                              : "容器 ${container['name']} 将被删除。删除后，容器中的所有数据将丢失。是否确定继续？",
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
                              setState(() {
                                // powerLoading[container['id']] = true;
                              });
                              var res = await Api.dockerPower(container['name'], action, preserveProfile: preserveProfile);
                              if (res['success']) {
                                Utils.toast("请求发送成功");
                                // getContainer();
                              } else {
                                Utils.toast("请求发送失败，代码：${res['error']['code']}");
                              }
                              setState(() {
                                // powerLoading[container['id']] = false;
                              });
                            },
                            color: Theme.of(context).scaffoldBackgroundColor,
                            borderRadius: BorderRadius.circular(25),
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              "确认",
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
    } else {
      setState(() {
        // powerLoading[container['id']] = true;
      });
      var res = await Api.dockerPower(container['name'], action);
      if (res['success']) {
        Utils.toast("请求发送成功");
        // getContainer();
      } else {
        Utils.toast("请求发送失败，代码：${res['error']['code']}");
      }
      setState(() {
        // powerLoading[container['id']] = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GlassScaffold(
      appBar: GlassAppBar(
        title: Text(widget.title),
        bottom: TabBar(
          isScrollable: true,
          controller: _tabController,
          tabs: [
            Tab(
              child: Text("容器"),
            ),
            Tab(
              child: Text("镜像"),
            ),
            Tab(
              child: Text("注册表"),
            ),
            Tab(
              child: Text("网络"),
            ),
            Tab(
              child: Text("日志"),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          ContainerPage(),
          ImagePage(),
          RepositoryPage(),
          NetworkPage(),
          LogPage(),
        ],
      ),
    );
  }
}
