import 'dart:math';
import 'dart:ui';

import 'package:cool_ui/cool_ui.dart';
import 'package:dsm_helper/apis/api.dart';
import 'package:dsm_helper/apis/dsm_api/dsm_api.dart';
import 'package:dsm_helper/apis/dsm_api/dsm_exception.dart';
import 'package:dsm_helper/apis/dsm_api/dsm_response.dart';
import 'package:dsm_helper/database/table_extention.dart';
import 'package:dsm_helper/database/tables.dart';
import 'package:dsm_helper/models/Syno/Api/auth.dart';
import 'package:dsm_helper/models/Syno/FileStation/FileStationList.dart';
import 'package:dsm_helper/models/api_model.dart';
import 'package:dsm_helper/pages/home.dart';
import 'package:dsm_helper/pages/login/login_new.dart';
import 'package:dsm_helper/pages/server/add_server.dart';
import 'package:dsm_helper/themes/app_theme.dart';
import 'package:dsm_helper/utils/db_utils.dart';
import 'package:dsm_helper/utils/extensions/media_query_ext.dart';
import 'package:dsm_helper/utils/extensions/navigator_ext.dart';
import 'package:dsm_helper/utils/utils.dart' hide Api;
import 'package:dsm_helper/widgets/button.dart';
import 'package:dsm_helper/widgets/custom_dialog/custom_dialog.dart';
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
              context.push(AddServer());
            },
            child: Image.asset(
              "assets/icons/plus_circle.png",
              width: 24,
              height: 24,
            ),
          ),
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
      margin: EdgeInsets.only(left: 16, right: 16, top: 20),
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
                ),
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                  child: Container(
                    width: width,
                    height: height,
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
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
                                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.white),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                  ],
                                  Row(
                                    children: [
                                      Icon(
                                        server.ssl ? Icons.lock_outline : Icons.lock_open,
                                        color: server.ssl ? Colors.green : Colors.white,
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
                                        style: TextStyle(color: Colors.white),
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
                                                context.push(AddServer(
                                                  server: server,
                                                ));
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
                                                showCustomDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return AlertDialog(
                                                      title: Text(
                                                        "删除服务器",
                                                        textAlign: TextAlign.center,
                                                      ),
                                                      content: Text("确定删除此服务器？"),
                                                      actionsOverflowDirection: VerticalDirection.up,
                                                      actions: [
                                                        Row(
                                                          children: [
                                                            Expanded(
                                                              child: Button(
                                                                color: Colors.red,
                                                                child: Text("删除"),
                                                                onPressed: () {
                                                                  DbUtils.db.deleteServer(server);
                                                                  // 删除服务器下关联账户
                                                                  DbUtils.db.deleteAccountByServerId(server.id);
                                                                  Navigator.of(context).pop();
                                                                },
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 10,
                                                            ),
                                                            Expanded(
                                                              child: Button(
                                                                child: Text("取消"),
                                                                onPressed: () {
                                                                  Navigator.of(context).pop();
                                                                },
                                                              ),
                                                            ),
                                                          ],
                                                        )
                                                      ],
                                                    );
                                                  },
                                                );
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
                        Row(
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
                      ],
                    ),
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
            // 重新登录
            Map<String, dynamic> data = {
              "account": account.account,
              "passwd": account.password,
              "otp_code": "",
              "version": 4,
              "api": "SYNO.API.Auth",
              "method": "login",
              "session": "FileStation",
              "enable_device_token": "yes",
              "enable_sync_token": "yes",
            };
            DsmResponse res = await Api.dsm.entry<Auth>(
              "SYNO.API.Auth",
              "login",
              data: data,
              parameters: {
                "api": "SYNO.API.Auth",
              },
              parser: Auth.fromJson,
            );
            if (res.success ?? false) {
              Auth authModel = res.data;
              DbUtils.db.updateAccount(account.copyWith(
                sid: authModel.sid!,
              ));
              await Api.dsm.init(server.url, deviceId: authModel.deviceId, sid: authModel.sid);
              hide();
              context.push(Home(), replace: true);
            } else if (res.error?['code'] == 400) {
              Utils.toast("用户名/密码有误");
            } else if (res.error?['code'] == 403) {
            } else if (res.error?['code'] == 404) {
              Utils.toast("错误的验证代码。请再试一次。");
            } else if (res.error?['code'] == 414) {
              // 需要二次验证
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
                showCustomDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text(
                        "删除账号",
                        textAlign: TextAlign.center,
                      ),
                      content: Text("确定删除账号：${account.account}？"),
                      actionsOverflowDirection: VerticalDirection.up,
                      actions: [
                        Row(
                          children: [
                            Expanded(
                              child: Button(
                                color: Colors.red,
                                child: Text("删除"),
                                onPressed: () {
                                  DbUtils.db.deleteAccount(account);
                                  Navigator.of(context).pop();
                                },
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Button(
                                child: Text("取消"),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ),
                          ],
                        )
                      ],
                    );
                  },
                );
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

class CurvePainter extends CustomPainter {
  final double? angle;
  final List<Color>? colors;

  CurvePainter({this.colors, this.angle = 140});

  @override
  void paint(Canvas canvas, Size size) {
    List<Color> colorsList = [];
    if (colors != null) {
      colorsList = colors ?? [];
    } else {
      colorsList.addAll([Colors.white, Colors.white]);
    }

    final shadowPaint = Paint()
      ..color = Colors.black.withOpacity(0.4)
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 12;
    final shadowPaintCenter = Offset(size.width / 2, size.height / 2);
    final shadowPaintRadius = min(size.width / 2, size.height / 2) - (14 / 2);
    canvas.drawArc(Rect.fromCircle(center: shadowPaintCenter, radius: shadowPaintRadius), degreeToRadius(278), degreeToRadius(360 - (365 - angle!)), false, shadowPaint);

    shadowPaint.color = Colors.grey.withOpacity(0.3);
    shadowPaint.strokeWidth = 14;
    canvas.drawArc(Rect.fromCircle(center: shadowPaintCenter, radius: shadowPaintRadius), degreeToRadius(278), degreeToRadius(360 - (365 - angle!)), false, shadowPaint);

    shadowPaint.color = Colors.grey.withOpacity(0.2);
    shadowPaint.strokeWidth = 18;
    canvas.drawArc(Rect.fromCircle(center: shadowPaintCenter, radius: shadowPaintRadius), degreeToRadius(278), degreeToRadius(360 - (365 - angle!)), false, shadowPaint);

    shadowPaint.color = Colors.grey.withOpacity(0.1);
    shadowPaint.strokeWidth = 20;
    canvas.drawArc(Rect.fromCircle(center: shadowPaintCenter, radius: shadowPaintRadius), degreeToRadius(278), degreeToRadius(360 - (365 - angle!)), false, shadowPaint);

    final rect = Rect.fromLTWH(0.0, 0.0, size.width, size.width);
    final gradient = SweepGradient(
      startAngle: degreeToRadius(268),
      endAngle: degreeToRadius(270.0 + 360),
      tileMode: TileMode.repeated,
      colors: colorsList,
    );
    final paint = Paint()
      ..shader = gradient.createShader(rect)
      ..strokeCap = StrokeCap.round // StrokeCap.round is not recommended.
      ..style = PaintingStyle.stroke
      ..strokeWidth = 12;
    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width / 2, size.height / 2) - (14 / 2);

    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), degreeToRadius(278), degreeToRadius(360 - (365 - angle!)), false, paint);

    const gradient1 = SweepGradient(
      tileMode: TileMode.repeated,
      colors: [Colors.white, Colors.white],
    );

    var cPaint = Paint();
    cPaint
      ..shader = gradient1.createShader(rect)
      ..color = Colors.white
      ..strokeWidth = 12 / 2;
    canvas.save();

    final centerToCircle = size.width / 2;
    canvas.save();

    canvas.translate(centerToCircle, centerToCircle);
    canvas.rotate(degreeToRadius(angle! + 2));

    canvas.save();
    canvas.translate(0.0, -centerToCircle + 14 / 2);
    canvas.drawCircle(const Offset(0, 0), 14 / 5, cPaint);

    canvas.restore();
    canvas.restore();
    canvas.restore();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

  double degreeToRadius(double degree) {
    var radius = (pi / 180) * degree;
    return radius;
  }
}
