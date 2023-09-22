import 'package:dio/dio.dart';
import 'package:dsm_helper/models/Syno/Core/System/Utilization.dart';
import 'package:dsm_helper/pages/dashboard/widgets/widget_card.dart';
import 'package:dsm_helper/pages/resource_monitor/performance.dart';
import 'package:dsm_helper/pages/resource_monitor/resource_monitor.dart';
import 'package:dsm_helper/providers/utilization_provider.dart';
import 'package:dsm_helper/themes/app_theme.dart';
import 'package:dsm_helper/utils/utils.dart';
import 'package:dsm_helper/widgets/animation_progress_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart' hide CornerStyle;
import 'package:syncfusion_flutter_gauges/gauges.dart';

class ResourceMonitorWidget extends StatelessWidget {
  const ResourceMonitorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size.width);
    UtilizationProvider utilizationProvider = context.read<UtilizationProvider>();
    Utilization utilization = utilizationProvider.utilization;
    List<Network> networks = utilizationProvider.networks;
    return WidgetCard(
      onTap: () {
        Navigator.of(context).push(CupertinoPageRoute(builder: (context) {
          return ResourceMonitor();
        }));
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
                      Navigator.of(context).push(
                        CupertinoPageRoute(
                          builder: (context) {
                            return Performance(
                              tabIndex: 2,
                            );
                          },
                          settings: RouteSettings(name: "performance"),
                        ),
                      );
                    },
                    behavior: HitTestBehavior.opaque,
                    child: SfRadialGauge(
                      enableLoadingAnimation: true,
                      axes: <RadialAxis>[
                        RadialAxis(
                          showLabels: false,
                          showTicks: false,
                          radiusFactor: 0.8,
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
                                          text: '${utilization.cpu!.totalLoad}',
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
                              value: utilization.cpu!.totalLoad.toDouble(),
                              width: 8,
                              cornerStyle: CornerStyle.bothCurve,
                              color: Color(0xFFF67280),
                              gradient: SweepGradient(colors: <Color>[Color(0xFF00BAAD), Color(0xFF4BD6CD)], stops: <double>[0.25, 0.75]),
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
                      Navigator.of(context).push(
                        CupertinoPageRoute(
                          builder: (context) {
                            return Performance(
                              tabIndex: 2,
                            );
                          },
                          settings: RouteSettings(name: "performance"),
                        ),
                      );
                    },
                    behavior: HitTestBehavior.opaque,
                    child: SfRadialGauge(
                      enableLoadingAnimation: true,
                      axes: <RadialAxis>[
                        RadialAxis(
                          showLabels: false,
                          showTicks: false,
                          radiusFactor: 0.8,
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
                                          text: '${utilization.memory!.realUsage}',
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
                              value: utilization.memory!.realUsage!.toDouble(),
                              width: 8,
                              cornerStyle: CornerStyle.bothCurve,
                              color: Color(0xFFF67280),
                              gradient: SweepGradient(colors: <Color>[Color(0xFF2A82E4), Color(0xFF75ACFF)], stops: <double>[0.25, 0.75]),
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
          // GestureDetector(
          //   onTap: () {
          //     Navigator.of(context).push(
          //       CupertinoPageRoute(
          //         builder: (context) {
          //           return Performance(
          //             tabIndex: 1,
          //           );
          //         },
          //         settings: RouteSettings(name: "performance"),
          //       ),
          //     );
          //   },
          //   child: Padding(
          //     padding: EdgeInsets.symmetric(horizontal: 20),
          //     child: Row(
          //       children: [
          //         SizedBox(
          //           width: 60,
          //           child: Text("CPU："),
          //         ),
          //         Expanded(
          //           child: Container(
          //             decoration: BoxDecoration(
          //               color: Theme.of(context).scaffoldBackgroundColor,
          //               borderRadius: BorderRadius.circular(8),
          //             ),
          //             child: FAProgressBar(
          //               backgroundColor: Colors.transparent,
          //               changeColorValue: 90,
          //               changeProgressColor: Colors.red,
          //               progressColor: Colors.blue,
          //               displayTextStyle: TextStyle(color: AppTheme.of(context)?.progressColor, fontSize: 12),
          //               currentValue: utilization.cpu!.totalLoad,
          //               displayText: '%',
          //             ),
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          // SizedBox(
          //   height: 10,
          // ),
          // GestureDetector(
          //   onTap: () {
          //     Navigator.of(context).push(
          //       CupertinoPageRoute(
          //         builder: (context) {
          //           return Performance(
          //             tabIndex: 2,
          //           );
          //         },
          //         settings: RouteSettings(name: "performance"),
          //       ),
          //     );
          //   },
          //   child: Padding(
          //     padding: EdgeInsets.symmetric(horizontal: 20),
          //     child: Row(
          //       children: [
          //         SizedBox(width: 60, child: Text("RAM：")),
          //         Expanded(
          //           child: Container(
          //             decoration: BoxDecoration(
          //               color: Theme.of(context).scaffoldBackgroundColor,
          //               borderRadius: BorderRadius.circular(8),
          //             ),
          //             child: FAProgressBar(
          //               backgroundColor: Colors.transparent,
          //               changeColorValue: 90,
          //               changeProgressColor: Colors.red,
          //               progressColor: Colors.blue,
          //               displayTextStyle: TextStyle(color: AppTheme.of(context)?.progressColor, fontSize: 12),
          //               currentValue: utilization.memory!.realUsage!.toInt(),
          //               displayText: '%',
          //             ),
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                CupertinoPageRoute(
                  builder: (context) {
                    return Performance(
                      tabIndex: 3,
                    );
                  },
                  settings: RouteSettings(name: "performance"),
                ),
              );
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Image.asset(
                    "assets/icons/arrow_down.png",
                    width: 20,
                    height: 20,
                  ),
                  Text(
                    Utils.formatSize(utilization.network!.first.tx!) + "/S",
                    style: TextStyle(color: Colors.blue),
                  ),
                  Spacer(),
                  Image.asset(
                    "assets/icons/arrow_up.png",
                    width: 20,
                    height: 20,
                  ),
                  Text(
                    Utils.formatSize(utilization.network!.first.rx!) + "/S",
                    style: TextStyle(color: Colors.green),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                CupertinoPageRoute(
                  builder: (context) {
                    return Performance(
                      tabIndex: 3,
                    );
                  },
                  settings: RouteSettings(name: "performance"),
                ),
              );
            },
            child: AspectRatio(
              aspectRatio: 2.2,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: SfCartesianChart(
                  plotAreaBorderWidth: 0,
                  primaryXAxis: NumericAxis(edgeLabelPlacement: EdgeLabelPlacement.shift, isVisible: false, interval: 1, majorGridLines: const MajorGridLines(width: 0)),
                  primaryYAxis: NumericAxis(
                    labelFormat: '{value}',
                    axisLine: const AxisLine(width: 0),
                    majorTickLines: const MajorTickLines(color: Colors.transparent),
                  ),
                  series: <LineSeries<Network, num>>[
                    LineSeries<Network, num>(
                      animationDuration: 1000,
                      dataSource: networks,
                      xValueMapper: (Network network, _) => networks.indexOf(network),
                      yValueMapper: (Network network, _) => network.tx,
                      width: 2,
                      name: '上传',
                      markerSettings: const MarkerSettings(isVisible: false),
                      color: Colors.blue,
                    ),
                    LineSeries<Network, num>(
                      animationDuration: 1000,
                      dataSource: networks,
                      width: 2,
                      name: '下载',
                      xValueMapper: (Network network, _) => networks.indexOf(network),
                      yValueMapper: (Network network, _) => network.rx,
                      markerSettings: const MarkerSettings(isVisible: false),
                      color: Colors.green,
                    )
                  ],
                  tooltipBehavior: TooltipBehavior(enable: true, shared: true),
                ),
              ),
            ),
          ),
        ],
      ),
    );
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Image.asset(
                    "assets/icons/resources.png",
                    width: 26,
                    height: 26,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "资源监控",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            if (utilization != null) ...[
              SizedBox(
                height: 10,
              ),
            ] else
              SizedBox(
                height: 300,
                child: Center(child: Text("数据加载失败")),
              ),
          ],
        ),
      ),
    );
  }
}
