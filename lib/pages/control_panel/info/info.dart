import 'package:dsm_helper/pages/control_panel/info/common_tab.dart';
import 'package:dsm_helper/pages/control_panel/info/network_tab.dart';
import 'package:dsm_helper/pages/control_panel/info/service_tab.dart';
import 'package:dsm_helper/pages/control_panel/info/storage_tab.dart';
import 'package:dsm_helper/widgets/glass/glass_app_bar.dart';
import 'package:dsm_helper/widgets/glass/glass_scaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SystemInfo extends StatefulWidget {
  final int index;
  SystemInfo(this.index);
  @override
  _SystemInfoState createState() => _SystemInfoState();
}

class _SystemInfoState extends State<SystemInfo> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(initialIndex: widget.index, length: 5, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GlassScaffold(
      appBar: GlassAppBar(
        title: Text("信息中心"),
        bottom: TabBar(
          isScrollable: true,
          controller: _tabController,
          tabs: [
            Tab(
              child: Text("常规"),
            ),
            Tab(
              child: Text("网络"),
            ),
            Tab(
              child: Text("存储"),
            ),
            Tab(
              child: Text("服务"),
            ),
            Tab(
              child: Text("设备分析"),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          CommonTab(),
          NetworkTab(),
          StorageTab(),
          ServiceTab(),
          Center(
            child: Text("待开发"),
          ),
        ],
      ),
    );
  }
}
