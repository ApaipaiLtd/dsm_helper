import 'package:dsm_helper/apis/api.dart';
import 'package:dsm_helper/models/Syno/Core/ExternalDevice/Storage/Device.dart';
import 'package:dsm_helper/pages/control_panel/external_device/dialogs/eject_external_device_dialog.dart';
import 'package:dsm_helper/pages/control_panel/external_device/enums/device_status_enum.dart';
import 'package:dsm_helper/pages/control_panel/external_device/enums/partition_status_enums.dart';
import 'package:dsm_helper/pages/dashboard/widgets/widget_card.dart';
import 'package:dsm_helper/themes/app_theme.dart';
import 'package:dsm_helper/utils/utils.dart' hide Api;
import 'package:dsm_helper/widgets/dot_widget.dart';
import 'package:dsm_helper/widgets/empty_widget.dart';
import 'package:dsm_helper/widgets/glass/glass_app_bar.dart';
import 'package:dsm_helper/widgets/glass/glass_scaffold.dart';
import 'package:dsm_helper/widgets/label.dart';
import 'package:dsm_helper/widgets/line_progress_bar.dart';
import 'package:dsm_helper/widgets/loading_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExternalDevice extends StatefulWidget {
  @override
  _ExternalDeviceState createState() => _ExternalDeviceState();
}

class _ExternalDeviceState extends State<ExternalDevice> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  Device esatas = Device();
  Device usbs = Device();
  bool loading = true;
  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    getData();
    super.initState();
  }

  List<ExternalDevices> get devices => (usbs.devices ?? []) + (esatas.devices ?? []);

  getData() async {
    try {
      List<DsmResponse> batchRes = await Api.dsm.batch(apis: [Device(api: "SYNO.Core.ExternalDevice.Storage.USB"), Device(api: "SYNO.Core.ExternalDevice.Storage.eSATA")]);
      usbs = batchRes[0].data;
      esatas = batchRes[1].data;
      setState(() {
        loading = false;
      });
    } catch (e) {
      Utils.toast("获取外接设备失败");
    }
  }

  Widget _buildPartitionItem(Partitions partition) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xffEFEFEF),
        borderRadius: BorderRadius.circular(20),
      ),
      margin: EdgeInsets.only(top: 14),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${partition.partitionTitle}",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5),
          Row(
            children: [
              DotWidget(
                size: 10,
                color: partition.statusEnum.color,
              ),
              SizedBox(width: 5),
              Text(
                partition.statusEnum != PartitionStatusEnum.unknown ? partition.statusEnum.label : (partition.status ?? '-'),
                style: TextStyle(fontSize: 12, color: partition.statusEnum.color),
              ),
              SizedBox(width: 10),
              Text(
                "${partition.shareName == null || partition.shareName == '' ? '未共享' : partition.shareName}",
                style: TextStyle(fontSize: 13, color: AppTheme.of(context)?.placeholderColor),
              ),
            ],
          ),
          SizedBox(height: 5),
          Text(
            "${partition.usedPercent.toStringAsFixed(1)}%",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5),
          LineProgressBar(value: partition.usedPercent),
          SizedBox(height: 5),
          DefaultTextStyle(
            style: TextStyle(fontSize: 12),
            child: Row(
              children: [
                Text(
                  "已用 ${partition.usedSizeMb != null ? Utils.formatSize(partition.usedSizeMb! * 1024 * 1024, showByte: true) : '--'} ",
                  style: TextStyle(color: partition.usedPercent > 80 ? AppTheme.of(context)?.errorColor : AppTheme.of(context)?.primaryColor),
                ),
                Text(
                  "/ ${partition.totalSizeMb != null ? Utils.formatSize(partition.totalSizeMb! * 1024 * 1024, showByte: true) : '--'}",
                  style: TextStyle(color: AppTheme.of(context)?.placeholderColor),
                ),
                Spacer(),
                Text(
                  "可用：${Utils.formatSize(partition.freeSizeMb * 1024 * 1024)}",
                  style: TextStyle(color: AppTheme.of(context)?.successColor),
                ),
              ],
            ),
          ),
          // Row(
          //   children: [
          //     Container(
          //       margin: EdgeInsets.all(10),
          //       decoration: BoxDecoration(
          //         color: Theme.of(context).scaffoldBackgroundColor,
          //         borderRadius: BorderRadius.circular(80),
          //         // color: Colors.red,
          //       ),
          //       padding: EdgeInsets.all(5),
          //       child: CircularPercentIndicator(
          //         radius: 40,
          //         // progressColor: Colors.lightBlueAccent,
          //         animation: true,
          //         linearGradient: LinearGradient(
          //           colors: partition['used_size_mb'] / partition['total_size_mb'] <= 0.9
          //               ? [
          //                   Colors.blue,
          //                   Colors.blueAccent,
          //                 ]
          //               : [
          //                   Colors.red,
          //                   Colors.orangeAccent,
          //                 ],
          //         ),
          //         animateFromLastPercent: true,
          //         circularStrokeCap: CircularStrokeCap.round,
          //         lineWidth: 12,
          //         backgroundColor: Colors.black12,
          //         percent: partition['used_size_mb'] / partition['total_size_mb'],
          //         center: Text(
          //           "${(partition['used_size_mb'] / partition['total_size_mb'] * 100).toStringAsFixed(0)}%",
          //           style: TextStyle(color: partition['used_size_mb'] / partition['total_size_mb'] <= 0.9 ? Colors.blue : Colors.red, fontSize: 22),
          //         ),
          //       ),
          //     ),
          //     SizedBox(
          //       width: 10,
          //     ),
          //     Expanded(
          //       child: Column(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           Row(
          //             children: [
          //               Text(
          //                 "${partition['share_name']}",
          //                 style: TextStyle(fontWeight: FontWeight.w600),
          //               ),
          //               SizedBox(
          //                 width: 10,
          //               ),
          //               Label(
          //                 partition['filesystem'] ?? partition['dev_fstype'],
          //                 Colors.blue,
          //                 fill: true,
          //               )
          //             ],
          //           ),
          //           SizedBox(
          //             height: 5,
          //           ),
          //           Text("已用：${Utils.formatSize(partition['used_size_mb'] * 1024 * 1024)}"),
          //           SizedBox(
          //             height: 5,
          //           ),
          //           Text("可用：${Utils.formatSize(partition['total_size_mb'] * 1024 * 1024 - partition['used_size_mb'] * 1024 * 1024)}"),
          //           SizedBox(
          //             height: 5,
          //           ),
          //           Text("容量：${Utils.formatSize(partition['total_size_mb'] * 1024 * 1024)}"),
          //         ],
          //       ),
          //     )
          //   ],
          // )
        ],
      ),
    );
  }

  Widget _buildDeviceItem(ExternalDevices device) {
    return WidgetCard(
      title: "${device.devTitle}",
      icon: Row(
        children: [
          device.statusEnum != DeviceStatusEnum.unknown
              ? Label(
                  device.statusEnum.label,
                  device.statusEnum.color,
                  fill: true,
                )
              : Label(
                  device.status ?? '-',
                  device.statusEnum.color,
                  fill: true,
                ),
          SizedBox(width: 10),
          CupertinoButton(
            child: Image.asset(
              "assets/icons/eject.png",
              width: 24,
              color: AppTheme.of(context)?.warningColor,
            ),
            padding: EdgeInsets.zero,
            onPressed: () {
              EjectExternalDeviceDialog.show(context: context, device: device);
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "制造商",
            style: TextStyle(color: AppTheme.of(context)?.placeholderColor, fontSize: 13),
          ),
          Text(
            "${device.producer ?? '-'}",
            style: TextStyle(fontSize: 16),
          ),
          Divider(indent: 0, endIndent: 0, height: 20),
          Text(
            "产品名称",
            style: TextStyle(color: AppTheme.of(context)?.placeholderColor, fontSize: 13),
          ),
          Text(
            "${device.product ?? '-'}",
            style: TextStyle(fontSize: 16),
          ),
          if (device.partitions != null) ...device.partitions!.map(_buildPartitionItem).toList(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GlassScaffold(
      appBar: GlassAppBar(
        title: Text("外接设备"),
        bottom: TabBar(
          isScrollable: true,
          controller: _tabController,
          tabs: [
            Tab(
              text: "外接设备",
            ),
            Tab(
              text: "打印机",
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          loading
              ? Center(
                  child: LoadingWidget(size: 30),
                )
              : devices.length > 0
                  ? ListView.separated(
                      itemBuilder: (context, i) {
                        return _buildDeviceItem(devices[i]);
                      },
                      separatorBuilder: (context, i) {
                        return SizedBox(
                          height: 20,
                        );
                      },
                      itemCount: devices.length,
                    )
                  : EmptyWidget(
                      text: "暂无外接设备",
                    ),
          Center(
            child: Text("未开发"),
          ),
        ],
      ),
    );
  }
}
