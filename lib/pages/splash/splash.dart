import 'package:dsm_helper/apis/api.dart';
import 'package:dsm_helper/apis/dsm_api/dsm_api.dart';
import 'package:dsm_helper/database/tables.dart';
import 'package:dsm_helper/models/api_model.dart';
import 'package:dsm_helper/pages/login/login.dart';
import 'package:dsm_helper/pages/server/select_server.dart';
import 'package:dsm_helper/utils/db_utils.dart';
import 'package:dsm_helper/utils/extensions/navigator_ext.dart';
import 'package:dsm_helper/utils/utils.dart' hide Api;
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../server/add_server.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    queryServers();
    super.initState();
  }

  queryServers() async {
    List<Server> servers = await DbUtils.db.select(DbUtils.db.servers).get();
    if (servers.isEmpty) {
      context.push(AddServer(), replace: true);
      return;
    }
    // 查询账号
    List<Account> accounts = await DbUtils.db.select(DbUtils.db.accounts).get();
    if (accounts.isEmpty) {
      if (servers.length == 1) {
        Api.dsm = DsmApi(baseUrl: '${servers.first.ssl ? 'https' : 'http'}://${servers.first.domain}:${servers.first.port}');
        try {
          ApiModel.apiInfo = await ApiModel.info();
          // context.push(Login(servers.first), replace: true);
        } catch (e) {
          Utils.toast("${servers.first.domain}无法访问");
        }
      }
      context.push(SelectServer(), replace: true);
    } else {
      // 判断是否默认登录
      context.push(SelectServer(), replace: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: LoadingAnimationWidget.fourRotatingDots(color: Theme.of(context).primaryColor, size: 30),
      ),
    );
  }
}
