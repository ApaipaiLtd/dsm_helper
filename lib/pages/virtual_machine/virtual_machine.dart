import 'package:dsm_helper/pages/virtual_machine/guest_tab.dart';
import 'package:dsm_helper/pages/virtual_machine/host_tab.dart';
import 'package:dsm_helper/pages/virtual_machine/storage_tab.dart';
import 'package:dsm_helper/pages/virtual_machine/summary_tab.dart';
import 'package:dsm_helper/widgets/glass/glass_app_bar.dart';
import 'package:dsm_helper/widgets/glass/glass_scaffold.dart';
import 'package:flutter/material.dart';

class VirtualMachine extends StatefulWidget {
  @override
  _VirtualMachineState createState() => _VirtualMachineState();
}

class _VirtualMachineState extends State<VirtualMachine> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 7, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GlassScaffold(
      appBar: GlassAppBar(
        title: Text("Virtual Machine Manager"),
        bottom: TabBar(
          isScrollable: true,
          controller: _tabController,
          tabs: [
            Tab(text: "概述"),
            Tab(text: "虚拟机"),
            Tab(text: "集群"),
            Tab(text: "存储"),
            Tab(text: "网络"),
            Tab(text: "映像"),
            Tab(text: "日志"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          SummaryTab(),
          GuestTab(),
          HostTab(),
          StorageTab(),
          Placeholder(),
          Placeholder(),
          Placeholder(),
        ],
      ),
    );
  }
}
