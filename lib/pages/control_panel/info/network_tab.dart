import 'package:dsm_helper/models/Syno/Core/System/SystemNetwork.dart';
import 'package:dsm_helper/pages/control_panel/info/widgets/network_nif_item_widget.dart';
import 'package:dsm_helper/pages/dashboard/widgets/widget_card.dart';
import 'package:dsm_helper/themes/app_theme.dart';
import 'package:dsm_helper/widgets/loading_widget.dart';
import 'package:flutter/material.dart';

class NetworkTab extends StatefulWidget {
  const NetworkTab({super.key});

  @override
  State<NetworkTab> createState() => _NetworkTabState();
}

class _NetworkTabState extends State<NetworkTab> with AutomaticKeepAliveClientMixin {
  SystemNetwork systemNetwork = SystemNetwork();
  bool loading = true;
  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    systemNetwork = await SystemNetwork.info();
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return loading
        ? Center(
            child: LoadingWidget(
              size: 30,
            ),
          )
        : ListView(
            children: [
              WidgetCard(
                title: "基本信息",
                body: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "系统名称",
                      style: TextStyle(color: AppTheme.of(context)?.placeholderColor, fontSize: 13),
                    ),
                    Text(
                      "${systemNetwork.hostname}",
                      style: TextStyle(fontSize: 16),
                    ),
                    Divider(indent: 0, endIndent: 0, height: 20),
                    Text(
                      "域名服务器(DNS)",
                      style: TextStyle(color: AppTheme.of(context)?.placeholderColor, fontSize: 13),
                    ),
                    Text(
                      "${systemNetwork.dns}",
                      style: TextStyle(fontSize: 16),
                    ),
                    Divider(indent: 0, endIndent: 0, height: 20),
                    Text(
                      "默认网关(Gateway)",
                      style: TextStyle(color: AppTheme.of(context)?.placeholderColor, fontSize: 13),
                    ),
                    Text(
                      "${systemNetwork.gateway}",
                      style: TextStyle(fontSize: 16),
                    ),
                    Divider(indent: 0, endIndent: 0, height: 20),
                    Text(
                      "工作群组",
                      style: TextStyle(color: AppTheme.of(context)?.placeholderColor, fontSize: 13),
                    ),
                    Text(
                      "${systemNetwork.workgroup}",
                      style: TextStyle(fontSize: 16),
                    ),
                    Divider(indent: 0, endIndent: 0, height: 20),
                    Text(
                      "WINS服务器",
                      style: TextStyle(color: AppTheme.of(context)?.placeholderColor, fontSize: 13),
                    ),
                    Text(
                      "${systemNetwork.wins == null || systemNetwork.wins == '' ? '尚未设置' : systemNetwork.wins}",
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
              if (systemNetwork.nif != null && systemNetwork.nif!.length > 0) ...List.generate(systemNetwork.nif!.length, (index) => NetworkNifItemWidget(systemNetwork.nif![index], index)),
            ],
          );
  }

  @override
  bool get wantKeepAlive => true;
}
