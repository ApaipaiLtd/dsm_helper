import 'package:dsm_helper/models/Syno/Core/Desktop/InitData.dart';
import 'package:dsm_helper/models/Syno/Core/System.dart';
import 'package:dsm_helper/pages/control_panel/info/widgets/usb_dev_item_widget.dart';
import 'package:dsm_helper/pages/dashboard/widgets/widget_card.dart';
import 'package:dsm_helper/providers/init_data_provider.dart';
import 'package:dsm_helper/providers/system_info_provider.dart';
import 'package:dsm_helper/themes/app_theme.dart';
import 'package:dsm_helper/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CommonTab extends StatelessWidget {
  const CommonTab({super.key});

  @override
  Widget build(BuildContext context) {
    System system = context.read<SystemInfoProvider>().systemInfo;
    InitDataModel initData = context.watch<InitDataProvider>().initData;
    return ListView(
      children: [
        WidgetCard(
          title: "基本信息",
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "服务器名称",
                style: TextStyle(color: AppTheme.of(context)?.placeholderColor, fontSize: 13),
              ),
              Text(
                "${initData.session?.hostname}",
                style: TextStyle(fontSize: 16),
              ),
              Divider(indent: 0, endIndent: 0, height: 20),
              Text(
                "DSM版本",
                style: TextStyle(color: AppTheme.of(context)?.placeholderColor, fontSize: 13),
              ),
              Text(
                "${system.firmwareVer}",
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
        WidgetCard(
          title: "硬件信息",
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "产品序列号",
                style: TextStyle(color: AppTheme.of(context)?.placeholderColor, fontSize: 13),
              ),
              Text(
                "${system.serial ?? '-'}",
                style: TextStyle(fontSize: 16),
              ),
              Divider(indent: 0, endIndent: 0, height: 20),
              Text(
                "产品型号",
                style: TextStyle(color: AppTheme.of(context)?.placeholderColor, fontSize: 13),
              ),
              Text(
                "${system.model ?? '-'}",
                style: TextStyle(fontSize: 16),
              ),
              Divider(indent: 0, endIndent: 0, height: 20),
              Text(
                "CPU",
                style: TextStyle(color: AppTheme.of(context)?.placeholderColor, fontSize: 13),
              ),
              Text(
                "${system.cpuVendor} ${system.cpuFamily} ${system.cpuSeries}",
                style: TextStyle(fontSize: 16),
              ),
              Divider(indent: 0, endIndent: 0, height: 20),
              Text(
                "CPU核心",
                style: TextStyle(color: AppTheme.of(context)?.placeholderColor, fontSize: 13),
              ),
              Text(
                "${system.cpuCores}核 @ ${(system.cpuClockSpeed! / 1000).toStringAsFixed(2)}GHz",
                style: TextStyle(fontSize: 16),
              ),
              Divider(indent: 0, endIndent: 0, height: 20),
              Text(
                "物理内存",
                style: TextStyle(color: AppTheme.of(context)?.placeholderColor, fontSize: 13),
              ),
              Text(
                "${system.ramSize}MB",
                style: TextStyle(fontSize: 16),
              ),
              Divider(indent: 0, endIndent: 0, height: 20),
              Text(
                "DSM版本",
                style: TextStyle(color: AppTheme.of(context)?.placeholderColor, fontSize: 13),
              ),
              Text(
                "${system.firmwareVer}",
                style: TextStyle(fontSize: 16),
              ),
              Divider(indent: 0, endIndent: 0, height: 20),
              Text(
                "散热状态",
                style: TextStyle(color: AppTheme.of(context)?.placeholderColor, fontSize: 13),
              ),
              Text(
                "${system.sysTemp}℃ ${system.temperatureWarning == null ? (system.sysTemp! > 80 ? "警告" : "正常") : (system.temperatureWarning! ? "警告" : "正常")}",
                style: TextStyle(color: system.temperatureWarning == null ? (system.sysTemp! > 80 ? AppTheme.of(context)?.errorColor : AppTheme.of(context)?.successColor) : (system.temperatureWarning! ? AppTheme.of(context)?.errorColor : AppTheme.of(context)?.successColor), fontSize: 16),
              ),
            ],
          ),
        ),
        if (system.usbDev != null && system.usbDev!.length > 0)
          WidgetCard(
            title: "外接设备",
            body: Column(
              children: system.usbDev!.map((dev) => UsbDeviceItem(dev, isLast: system.usbDev!.last == dev)).toList(),
            ),
          ),
        WidgetCard(
          title: "时间信息",
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "服务器地址",
                style: TextStyle(color: AppTheme.of(context)?.placeholderColor, fontSize: 13),
              ),
              Text(
                "${system.ntpServer} ${system.enabledNtp! ? "" : "(暂未启用)"}",
                style: TextStyle(fontSize: 16),
              ),
              Divider(indent: 0, endIndent: 0, height: 20),
              Text(
                "时区",
                style: TextStyle(color: AppTheme.of(context)?.placeholderColor, fontSize: 13),
              ),
              Text(
                "${system.timeZoneDesc}",
                style: TextStyle(fontSize: 16),
              ),
              Divider(indent: 0, endIndent: 0, height: 20),
              Text(
                "系统时间",
                style: TextStyle(color: AppTheme.of(context)?.placeholderColor, fontSize: 13),
              ),
              Text(
                "${system.time}",
                style: TextStyle(fontSize: 16),
              ),
              Divider(indent: 0, endIndent: 0, height: 20),
              Text(
                "运行时间",
                style: TextStyle(color: AppTheme.of(context)?.placeholderColor, fontSize: 13),
              ),
              Text(
                "${Utils.parseOpTime(system.upTime!)}",
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
