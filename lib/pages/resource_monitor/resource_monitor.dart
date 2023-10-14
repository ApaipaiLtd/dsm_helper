import 'package:dsm_helper/widgets/glass/glass_app_bar.dart';
import 'package:dsm_helper/widgets/glass/glass_scaffold.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ResourceMonitor extends StatefulWidget {
  ResourceMonitor({this.tabIndex = 0, super.key});
  final int tabIndex;
  @override
  _ResourceMonitorState createState() => _ResourceMonitorState();
}

class _ResourceMonitorState extends State<ResourceMonitor> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this, initialIndex: widget.tabIndex);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GlassScaffold(
      appBar: GlassAppBar(
        title: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: [
            Tab(text: "性能"),
            Tab(text: "任务管理器"),
            Tab(text: "连接"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Container(),
          Container(),
          Container(),
        ],
      ),
    );
  }
}
