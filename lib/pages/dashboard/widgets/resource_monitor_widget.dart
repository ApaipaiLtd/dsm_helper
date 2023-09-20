import 'package:dsm_helper/models/Syno/Core/System/Utilization.dart';
import 'package:dsm_helper/pages/resource_monitor/performance.dart';
import 'package:dsm_helper/pages/resource_monitor/resource_monitor.dart';
import 'package:dsm_helper/providers/utilization_provider.dart';
import 'package:dsm_helper/themes/app_theme.dart';
import 'package:dsm_helper/utils/utils.dart';
import 'package:dsm_helper/widgets/animation_progress_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ResourceMonitorWidget extends StatelessWidget {
  const ResourceMonitorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    UtilizationProvider utilizationProvider = context.read<UtilizationProvider>();
    Utilization utilization = utilizationProvider.utilization;
    List<Network> network = utilizationProvider.network;
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(CupertinoPageRoute(builder: (context) {
          return ResourceMonitor();
        }));
      },
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
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(CupertinoPageRoute(
                      builder: (context) {
                        return Performance(
                          tabIndex: 1,
                        );
                      },
                      settings: RouteSettings(name: "performance")));
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 60,
                        child: Text("CPU："),
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: FAProgressBar(
                            backgroundColor: Colors.transparent,
                            changeColorValue: 90,
                            changeProgressColor: Colors.red,
                            progressColor: Colors.blue,
                            displayTextStyle: TextStyle(color: AppTheme.of(context)?.progressColor, fontSize: 12),
                            currentValue: utilization.cpu!.totalLoad,
                            displayText: '%',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(CupertinoPageRoute(
                      builder: (context) {
                        return Performance(
                          tabIndex: 2,
                        );
                      },
                      settings: RouteSettings(name: "performance")));
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      SizedBox(width: 60, child: Text("RAM：")),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: FAProgressBar(
                            backgroundColor: Colors.transparent,
                            changeColorValue: 90,
                            changeProgressColor: Colors.red,
                            progressColor: Colors.blue,
                            displayTextStyle: TextStyle(color: AppTheme.of(context)?.progressColor, fontSize: 12),
                            currentValue: utilization.memory!.realUsage!.toInt(),
                            displayText: '%',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(CupertinoPageRoute(
                      builder: (context) {
                        return Performance(
                          tabIndex: 3,
                        );
                      },
                      settings: RouteSettings(name: "performance")));
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      SizedBox(width: 60, child: Text("网络：")),
                      Icon(
                        Icons.upload_sharp,
                        color: Colors.blue,
                      ),
                      Text(
                        Utils.formatSize(utilization.network!.first.tx!) + "/S",
                        style: TextStyle(color: Colors.blue),
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Icon(
                        Icons.download_sharp,
                        color: Colors.green,
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
                  Navigator.of(context).push(CupertinoPageRoute(
                      builder: (context) {
                        return Performance(
                          tabIndex: 3,
                        );
                      },
                      settings: RouteSettings(name: "performance")));
                },
                child: AspectRatio(
                  aspectRatio: 1.70,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        // child: LineChart(
                        //   LineChartData(
                        //     lineTouchData: LineTouchData(
                        //       touchTooltipData: LineTouchTooltipData(
                        //         tooltipBgColor: Colors.white.withOpacity(0.6),
                        //         tooltipRoundedRadius: 20,
                        //         fitInsideHorizontally: true,
                        //         fitInsideVertically: true,
                        //         getTooltipItems: (List<LineBarSpot> items) {
                        //           return items.map((LineBarSpot touchedSpot) {
                        //             final textStyle = TextStyle(
                        //               color: touchedSpot.bar.color,
                        //               // color: touchedSpot.bar.colors[0],
                        //               fontWeight: FontWeight.bold,
                        //               fontSize: 14,
                        //             );
                        //             return LineTooltipItem('${touchedSpot.bar.color == Colors.blue ? "上传" : "下载"}:${Utils.formatSize(touchedSpot.y.floor())}', textStyle);
                        //           }).toList();
                        //         },
                        //       ),
                        //     ),
                        //     gridData: FlGridData(
                        //       show: false,
                        //     ),
                        //     titlesData: FlTitlesData(
                        //       show: true,
                        //       bottomTitles: AxisTitles(
                        //         sideTitles: SideTitles(
                        //           showTitles: false,
                        //           reservedSize: 22,
                        //         ),
                        //       ),
                        //       topTitles: AxisTitles(
                        //         sideTitles: SideTitles(showTitles: false),
                        //       ),
                        //       rightTitles: AxisTitles(
                        //         sideTitles: SideTitles(showTitles: false),
                        //       ),
                        //       leftTitles: AxisTitles(
                        //         sideTitles: SideTitles(
                        //           showTitles: true,
                        //           // getTextStyles: (value, _) => const TextStyle(
                        //           //   color: Color(0xff67727d),
                        //           //   fontSize: 12,
                        //           // ),
                        //           // getTitles: chartTitle,
                        //           getTitlesWidget: (value, _) {
                        //             return Text(Utils.formatSize(value, fixed: 0),
                        //                 style: TextStyle(
                        //                   color: Color(0xff67727d),
                        //                   fontSize: 12,
                        //                 ));
                        //           },
                        //           reservedSize: 35,
                        //           interval: Utils.chartInterval(maxNetworkSpeed),
                        //         ),
                        //       ),
                        //     ),
                        //     // maxY: 20,
                        //     minY: 0,
                        //     borderData: FlBorderData(show: true, border: Border.all(color: Colors.black12, width: 1)),
                        //     lineBarsData: [
                        //       LineChartBarData(
                        //         spots: networks.map((network) {
                        //           return FlSpot(networks.indexOf(network).toDouble(), network['tx'].toDouble());
                        //         }).toList(),
                        //         isCurved: true,
                        //         color: Colors.blue,
                        //         barWidth: 2,
                        //         isStrokeCapRound: true,
                        //         dotData: FlDotData(
                        //           show: false,
                        //         ),
                        //         belowBarData: BarAreaData(
                        //           show: true,
                        //           color: Colors.blue.withOpacity(0.2),
                        //         ),
                        //       ),
                        //       LineChartBarData(
                        //         spots: networks.map((network) {
                        //           return FlSpot(networks.indexOf(network).toDouble(), network['rx'].toDouble());
                        //         }).toList(),
                        //         isCurved: true,
                        //         color: Colors.green,
                        //         barWidth: 2,
                        //         isStrokeCapRound: true,
                        //         dotData: FlDotData(
                        //           show: false,
                        //         ),
                        //         belowBarData: BarAreaData(
                        //           show: true,
                        //           color: Colors.green.withOpacity(0.2),
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                      ),
                    ),
                  ),
                ),
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
