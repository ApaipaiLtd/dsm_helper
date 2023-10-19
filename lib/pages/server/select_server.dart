import 'dart:ui';

import 'package:cool_ui/cool_ui.dart';
import 'package:dsm_helper/apis/api.dart';
import 'package:dsm_helper/apis/dsm_api/dsm_api.dart';
import 'package:dsm_helper/database/table_extension.dart';
import 'package:dsm_helper/database/tables.dart';
import 'package:dsm_helper/models/Syno/Api/auth.dart';
import 'package:dsm_helper/models/Syno/FileStation/FileStationList.dart';
import 'package:dsm_helper/models/api_model.dart';
import 'package:dsm_helper/pages/home.dart';
import 'package:dsm_helper/pages/login/login.dart';
import 'package:dsm_helper/pages/server/add_server.dart';
import 'package:dsm_helper/pages/server/dialogs/delete_account_dialog.dart';
import 'package:dsm_helper/pages/server/dialogs/delete_server_dialog.dart';
import 'package:dsm_helper/themes/app_theme.dart';
import 'package:dsm_helper/utils/db_utils.dart';
import 'package:dsm_helper/utils/extensions/media_query_ext.dart';
import 'package:dsm_helper/utils/extensions/navigator_ext.dart';
import 'package:dsm_helper/utils/utils.dart' hide Api;
import 'package:dsm_helper/widgets/button.dart';
import 'package:dsm_helper/widgets/glass/glass_dialog.dart';
import 'package:dsm_helper/widgets/glass/glass_app_bar.dart';
import 'package:dsm_helper/widgets/glass/glass_scaffold.dart';
import 'package:dsm_helper/widgets/page_body_widget.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kumi_popup_window/kumi_popup_window.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class SelectServer extends StatefulWidget {
  const SelectServer({super.key});

  @override
  State<SelectServer> createState() => _SelectServerState();
}

class _SelectServerState extends State<SelectServer> {
  List<Server> servers = [];
  List<Account> accounts = [];
  bool hide = false;
  @override
  void initState() {
    queryServers();
    super.initState();
  }

  queryServers() async {
    // servers = await DbUtils.db.select(DbUtils.db.servers).get();
    DbUtils.db.select(DbUtils.db.servers).watch().listen((event) {
      if (mounted) {
        setState(() {
          servers = event;
        });
      }
    });
    DbUtils.db.select(DbUtils.db.accounts).watch().listen((event) {
      if (mounted) {
        setState(() {
          accounts = event;
        });
      }
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GlassScaffold(
      appBar: GlassAppBar(
        title: Text("服务器/账号"),
        actions: [
          CupertinoButton(
            onPressed: () {
              setState(() {
                hide = !hide;
              });
            },
            child: Image.asset(
              "assets/icons/${hide ? "eye_slash" : "eye"}.png",
              width: 24,
              height: 24,
            ),
          ),
          CupertinoButton(
            onPressed: () {
              context.push(AddServer());
            },
            child: Image.asset(
              "assets/icons/plus_circle.png",
              width: 24,
              height: 24,
            ),
          ),
        ],
      ),
      body: PageBodyWidget(
        body: ListView.builder(
          itemBuilder: (context, i) {
            return _buildServerItem(servers[i]);
          },
          itemCount: servers.length,
        ),
      ),
    );
  }

  Widget _buildServerItem(Server server) {
    GlobalKey actionButtonKey = GlobalKey();
    double width = context.width - 32;
    double height = width / 16 * 9;
    List<Account> serverAccounts = accounts.where((account) => account.serverId == server.id).toList();
    return Container(
      margin: EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
      // padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              if (server.backgroundImage != null)
                ExtendedImage.network(
                  server.backgroundImage!,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
                  width: width,
                  height: height,
                  fit: BoxFit.cover,
                )
              else
                ExtendedImage.asset(
                  "assets/default_login_background.jpg",
                  height: context.width / 16 * 9,
                  width: context.width,
                  fit: BoxFit.cover,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
                ),
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
                child: Container(
                  width: width,
                  height: height,
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      SizedBox(height: 10),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (server.hostname != null) ...[
                                  Text(
                                    server.hostname!,
                                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                      color: Colors.white,
                                      shadows: [BoxShadow(color: Colors.black, spreadRadius: 30, blurRadius: 15)],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                ],
                                Row(
                                  children: [
                                    Icon(
                                      server.ssl ? Icons.lock_outline : Icons.lock_open,
                                      color: server.ssl ? AppTheme.of(context)?.successColor : Colors.white,
                                      size: 16,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      hide
                                          ? '**********'
                                          : server.qcid.isNotEmpty
                                              ? server.qcid
                                              : "${server.domain}:${server.port}",
                                      style: TextStyle(
                                        color: Colors.white,
                                        shadows: [BoxShadow(color: Colors.black, spreadRadius: 30, blurRadius: 15)],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          CupertinoButton(
                            key: actionButtonKey,
                            onPressed: () {
                              showPopupWindow(
                                context,
                                gravity: KumiPopupGravity.leftBottom,
                                bgColor: Colors.transparent,
                                clickOutDismiss: true,
                                clickBackDismiss: true,
                                customAnimation: false,
                                customPop: false,
                                customPage: false,
                                underStatusBar: true,
                                underAppBar: true,
                                needSafeDisplay: true,
                                offsetX: 30,
                                offsetY: -80,
                                // curve: Curves.easeInSine,
                                duration: Duration(milliseconds: 200),
                                targetRenderBox: actionButtonKey.currentContext!.findRenderObject() as RenderBox,
                                childFun: (pop) {
                                  return BackdropFilter(
                                    key: GlobalKey(),
                                    filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                                    child: Container(
                                      width: 220,
                                      padding: EdgeInsets.symmetric(vertical: 8),
                                      margin: EdgeInsets.only(top: 50),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(23),
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          PopupMenuItem(
                                            onTap: () {
                                              context.push(AddServer(server: server), name: "add_server");
                                            },
                                            child: Row(
                                              children: [
                                                Image.asset(
                                                  "assets/icons/pencil.png",
                                                  width: 20,
                                                  height: 20,
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Text("编辑"),
                                              ],
                                            ),
                                          ),
                                          PopupMenuItem(
                                            onTap: () async {
                                              var hide = showWeuiLoadingToast(context: context);
                                              Api.dsm = DsmApi(baseUrl: server.url);
                                              ApiModel.apiInfo = await ApiModel.info();
                                              hide();
                                              context.push(Login(server));
                                            },
                                            child: Row(
                                              children: [
                                                Image.asset(
                                                  "assets/icons/plus_circle.png",
                                                  width: 20,
                                                  height: 20,
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Text("添加用户"),
                                              ],
                                            ),
                                          ),
                                          PopupMenuItem(
                                            onTap: () async {
                                              DeleteServerDialog.show(context).then((res) {
                                                if (res == true) {
                                                  DbUtils.db.deleteServer(server);
                                                  // 删除服务器下关联账户
                                                  DbUtils.db.deleteAccountByServerId(server.id);
                                                }
                                              });
                                            },
                                            child: Row(
                                              children: [
                                                Image.asset(
                                                  "assets/icons/delete.png",
                                                  width: 20,
                                                  height: 20,
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  "删除服务器",
                                                  style: TextStyle(color: AppTheme.of(context)?.errorColor),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                            minSize: 0,
                            color: Colors.black26,
                            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                            child: Image.asset(
                              "assets/icons/more_vertical.png",
                              width: 20,
                              height: 20,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              children: [
                                Expanded(
                                  child: SizedBox(
                                    width: 100,
                                    height: 100,
                                    child: SfRadialGauge(
                                      animationDuration: 1000,
                                      enableLoadingAnimation: true,
                                      axes: <RadialAxis>[
                                        RadialAxis(
                                          showLabels: false,
                                          showTicks: false,
                                          // radiusFactor: 0.8,
                                          maximum: 100,
                                          axisLineStyle: AxisLineStyle(cornerStyle: CornerStyle.bothCurve, thickness: 8),
                                          annotations: <GaugeAnnotation>[
                                            GaugeAnnotation(
                                              angle: 90,
                                              positionFactor: 0.4,
                                              widget: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: <Widget>[
                                                  Image.asset(
                                                    "assets/icons/cpu_line.png",
                                                    width: 24,
                                                    height: 24,
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text.rich(
                                                    TextSpan(
                                                      children: [
                                                        TextSpan(
                                                          text: '50',
                                                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: Colors.white),
                                                        ),
                                                        TextSpan(
                                                          text: '%',
                                                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10, color: Colors.white54),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Text(
                                                    "CPU",
                                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10, color: Colors.white54),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                          pointers: <GaugePointer>[
                                            RangePointer(
                                              enableAnimation: true,
                                              animationDuration: 1000,
                                              value: 50.toDouble(),
                                              width: 8,
                                              cornerStyle: CornerStyle.bothCurve,
                                              gradient: SweepGradient(colors: <Color>[Color(0xFF00BAAD), Color(0xFF4BD6CD)]),
                                            ),
                                            // MarkerPointer(
                                            //   value: utilization.cpu!.totalLoad.toDouble() - 3,
                                            //   color: Colors.white,
                                            //   markerType: MarkerType.circle,
                                            // ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: SizedBox(
                                    width: 100,
                                    height: 100,
                                    child: SfRadialGauge(
                                      animationDuration: 1000,
                                      enableLoadingAnimation: true,
                                      axes: <RadialAxis>[
                                        RadialAxis(
                                          showLabels: false,
                                          showTicks: false,
                                          // radiusFactor: 0.8,
                                          maximum: 100,
                                          axisLineStyle: AxisLineStyle(cornerStyle: CornerStyle.bothCurve, thickness: 8),
                                          annotations: <GaugeAnnotation>[
                                            GaugeAnnotation(
                                              angle: 90,
                                              positionFactor: 0.4,
                                              widget: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: <Widget>[
                                                  Image.asset(
                                                    "assets/icons/memory.png",
                                                    width: 24,
                                                    height: 24,
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text.rich(
                                                    TextSpan(
                                                      children: [
                                                        TextSpan(
                                                          text: '50',
                                                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: Colors.white),
                                                        ),
                                                        TextSpan(
                                                          text: '%',
                                                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10, color: Colors.white54),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Text(
                                                    "RAM",
                                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10, color: Colors.white54),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                          pointers: <GaugePointer>[
                                            RangePointer(
                                              enableAnimation: true,
                                              animationDuration: 1000,
                                              value: 50.toDouble(),
                                              width: 8,
                                              cornerStyle: CornerStyle.bothCurve,
                                              gradient: SweepGradient(colors: <Color>[AppTheme.of(context)!.primaryColor!, Color(0xFF75ACFF)]),
                                            ),
                                            // MarkerPointer(
                                            //   value: utilization.cpu!.totalLoad.toDouble() - 3,
                                            //   color: Colors.white,
                                            //   markerType: MarkerType.circle,
                                            // ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 90,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Image.asset(
                                            "assets/icons/arrow_down.png",
                                            width: 20,
                                            height: 20,
                                          ),
                                          Text(
                                            Utils.formatSize(10000) + "/S",
                                            style: TextStyle(color: AppTheme.of(context)?.primaryColor),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Image.asset(
                                            "assets/icons/arrow_up.png",
                                            width: 20,
                                            height: 20,
                                          ),
                                          Text(
                                            Utils.formatSize(10000) + "/S",
                                            style: TextStyle(color: Color(0xFF1BB357)),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 16),
                                      Row(
                                        children: [
                                          Image.asset(
                                            "assets/icons/temperature.png",
                                            width: 20,
                                            height: 20,
                                          ),
                                          Text(
                                            "50℃",
                                            style: TextStyle(color: Color(0xFF43CF7C)),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Column(
              children: serverAccounts.map((account) => _buildAccountItem(account, server)).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAccountItem(Account account, Server server) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () async {
        var hide = showWeuiLoadingToast(context: context);
        Api.dsm = DsmApi(baseUrl: server.url, deviceId: account.deviceId, sid: account.sid);
        ApiModel.apiInfo = await ApiModel.info();
        try {
          await FileStationList.shareList();
          hide();
          context.push(Home(), replace: true);
        } on DsmException catch (e) {
          if (e.code == 119) {
            try {
              Auth authModel = await Auth.login(account: account.account, password: account.password);
              DbUtils.db.updateAccount(account.copyWith(
                sid: authModel.sid!,
              ));
              Api.dsm = DsmApi(baseUrl: server.url, deviceId: account.deviceId, sid: account.sid);
              hide();
              context.push(Home(), replace: true);
            } on DsmException catch (e) {
              if (e.code == 400) {
                Utils.toast("用户名/密码有误");
              } else if (e.code == 403) {
              } else if (e.code == 404) {
                Utils.toast("错误的验证代码。请再试一次。");
              } else if (e.code == 414) {
                // 需要二次验证
              }
            }
          }
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          children: [
            Expanded(
              child: Text(account.account),
            ),
            CupertinoButton(
              minSize: 0,
              onPressed: () {
                DeleteAccountDialog.show(context, account: account).then((res) {
                  DbUtils.db.deleteAccount(account);
                });
              },
              padding: EdgeInsets.zero,
              child: Image.asset("assets/icons/remove_circle_fill.png", width: 20),
            ),
          ],
        ),
      ),
    );
  }
}
