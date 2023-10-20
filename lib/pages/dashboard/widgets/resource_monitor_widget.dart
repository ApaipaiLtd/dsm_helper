import 'package:dsm_helper/models/Syno/Core/System.dart';
import 'package:dsm_helper/models/Syno/Core/System/Utilization.dart';
import 'package:dsm_helper/pages/dashboard/widgets/widget_card.dart';
import 'package:dsm_helper/pages/resource_monitor/performance.dart';
import 'package:dsm_helper/pages/resource_monitor/resource_monitor.dart';
import 'package:dsm_helper/providers/system_info_provider.dart';
import 'package:dsm_helper/providers/utilization_provider.dart';
import 'package:dsm_helper/themes/app_theme.dart';
import 'package:dsm_helper/utils/extensions/navigator_ext.dart';
import 'package:dsm_helper/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart' hide CornerStyle;
import 'package:syncfusion_flutter_gauges/gauges.dart';

class ResourceMonitorWidget extends StatelessWidget {
  const ResourceMonitorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    UtilizationProvider utilizationProvider = context.read<UtilizationProvider>();
    Utilization utilization = utilizationProvider.utilization;
    List<Network> networks = utilizationProvider.networks;
    System system = context.read<SystemInfoProvider>().systemInfo;
    return WidgetCard(
      onTap: () {
        context.push(ResourceMonitor(), name: "resource_monitor");
      },
      // icon: Image.asset(
      //   "assets/icons/resources.png",
      //   width: 26,
      //   height: 26,
      // ),
      // title: "资源监控",
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  width: 120,
                  height: 120,
                  child: GestureDetector(
                    onTap: () {
                      context.push(Performance(tabIndex: 2), name: "performance");
                    },
                    behavior: HitTestBehavior.opaque,
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
                                          text: '${utilization.cpu?.totalLoad ?? '-'}',
                                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                                        ),
                                        TextSpan(
                                          text: '%',
                                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10, color: Colors.black45),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    "CPU",
                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10, color: Colors.black45),
                                  ),
                                ],
                              ),
                            ),
                          ],
                          pointers: <GaugePointer>[
                            RangePointer(
                              enableAnimation: true,
                              animationDuration: 1000,
                              value: (utilization.cpu?.totalLoad ?? 0).toDouble(),
                              width: 8,
                              cornerStyle: CornerStyle.bothCurve,
                              gradient: SweepGradient(colors: (utilization.cpu?.totalLoad ?? 0) < 80 ? [Color(0xFF00BAAD), Color(0xFF4BD6CD)] : [AppTheme.of(context)!.errorColor!, AppTheme.of(context)!.warningColor!]),
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
              ),
              Expanded(
                child: SizedBox(
                  width: 120,
                  height: 120,
                  child: GestureDetector(
                    onTap: () {
                      context.push(Performance(tabIndex: 2), name: "performance");
                    },
                    behavior: HitTestBehavior.opaque,
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
                                          text: '${utilization.memory?.realUsage ?? '-'}',
                                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                                        ),
                                        TextSpan(
                                          text: '%',
                                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10, color: Colors.black45),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    "RAM",
                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10, color: Colors.black45),
                                  ),
                                ],
                              ),
                            ),
                          ],
                          pointers: <GaugePointer>[
                            RangePointer(
                              enableAnimation: true,
                              animationDuration: 1000,
                              value: (utilization.memory?.realUsage ?? 0).toDouble(),
                              width: 8,
                              cornerStyle: CornerStyle.bothCurve,
                              gradient: SweepGradient(colors: (utilization.memory?.realUsage ?? 0) < 80 ? [AppTheme.of(context)!.primaryColor!, Color(0xFF75ACFF)] : [AppTheme.of(context)!.errorColor!, AppTheme.of(context)!.warningColor!]),
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
              ),
              // Expanded(child: SizedBox()),
            ],
          ),
          Divider(
            indent: 0,
            endIndent: 0,
          ),
          SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () {
              context.push(Performance(tabIndex: 3), name: "performance");
            },
            child: Row(
              children: [
                Image.asset(
                  "assets/icons/temperature.png",
                  width: 16,
                  height: 16,
                ),
                Text(
                  "${system.sysTemp ?? '-'}℃",
                  style: TextStyle(color: AppTheme.of(context)?.successColor),
                ),
                Spacer(),
                Image.asset(
                  "assets/icons/arrow_down.png",
                  width: 20,
                  height: 20,
                ),
                Text(
                  utilization.network == null ? '-' : Utils.formatSize(utilization.network!.first.tx!, showByte: true) + "/S",
                  style: TextStyle(color: AppTheme.of(context)?.primaryColor),
                ),
                SizedBox(width: 20),
                Image.asset(
                  "assets/icons/arrow_up.png",
                  width: 20,
                  height: 20,
                ),
                Text(
                  utilization.network == null ? '-' : Utils.formatSize(utilization.network!.first.rx!, showByte: true) + "/S",
                  style: TextStyle(color: AppTheme.of(context)?.successColor),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              context.push(Performance(tabIndex: 3), name: "performance");
            },
            child: SizedBox(
              height: 150,
              child: SfCartesianChart(
                plotAreaBorderWidth: 0,
                primaryXAxis: NumericAxis(edgeLabelPlacement: EdgeLabelPlacement.shift, isVisible: false, interval: 1, majorGridLines: const MajorGridLines(width: 0)),
                primaryYAxis: NumericAxis(
                  // labelFormat: '{value}',
                  axisLine: const AxisLine(width: 0),
                  majorTickLines: const MajorTickLines(color: Colors.transparent),
                  interval: Utils.chartInterval(utilizationProvider.maxNetworkSpeed),
                  axisLabelFormatter: (args) {
                    return ChartAxisLabel(Utils.formatSize(args.value, fixed: 0), TextStyle());
                  },
                ),
                enableAxisAnimation: true,
                series: <AreaSeries<Network, num>>[
                  AreaSeries<Network, num>(
                    animationDuration: 1000,
                    dataSource: networks,
                    xValueMapper: (Network network, _) => networks.indexOf(network),
                    yValueMapper: (Network network, _) => network.tx,
                    // dataLabelSettings: DataLabelSettings(),
                    // width: 2,
                    name: '上传',
                    markerSettings: const MarkerSettings(isVisible: false),
                    // color: Colors.lightBlue,
                    borderWidth: 2,
                    borderColor: AppTheme.of(context)?.primaryColor,
                    gradient: LinearGradient(colors: [Colors.white, Color(0xFFD5E4F5)], begin: Alignment.bottomCenter, end: Alignment.topCenter),
                  ),
                  AreaSeries<Network, num>(
                    animationDuration: 1000,
                    dataSource: networks,
                    // width: 2,
                    name: '下载',
                    xValueMapper: (Network network, _) => networks.indexOf(network),
                    yValueMapper: (Network network, _) => network.rx,
                    markerSettings: const MarkerSettings(isVisible: false),
                    color: Colors.lightGreen,
                    borderColor: Color(0xFF43CF7C),
                    borderWidth: 2,
                    gradient: LinearGradient(colors: [Color(0x0CCCCCCC), Color(0x2343CF7C)], begin: Alignment.bottomCenter, end: Alignment.topCenter),
                  )
                ],
                tooltipBehavior: TooltipBehavior(enable: true, shared: true),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
