import 'package:dsm_helper/apis/api.dart';
import 'package:dsm_helper/models/Syno/Core/System/Utilization.dart';
import 'package:dsm_helper/models/Syno/Docker/Container/ContainerResource.dart';
import 'package:dsm_helper/models/Syno/Docker/DockerContainer.dart' hide State;
import 'package:dsm_helper/pages/docker/detail.dart';
import 'package:dsm_helper/pages/docker/enums/docker_status_enum.dart';
import 'package:dsm_helper/providers/utilization_provider.dart';
import 'package:dsm_helper/themes/app_theme.dart';
import 'package:dsm_helper/utils/extensions/navigator_ext.dart';
import 'package:dsm_helper/utils/utils.dart' hide Api;
import 'package:dsm_helper/widgets/dot_widget.dart';
import 'package:dsm_helper/widgets/line_progress_bar.dart';
import 'package:dsm_helper/widgets/loading_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class ContainerPage extends StatefulWidget {
  const ContainerPage({super.key});

  @override
  State<ContainerPage> createState() => _ContainerPageState();
}

class _ContainerPageState extends State<ContainerPage> with AutomaticKeepAliveClientMixin {
  DockerContainer containers = DockerContainer();
  ContainerResource resource = ContainerResource();
  bool loading = true;
  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    List<DsmResponse> batchRes = await Api.dsm.batch(apis: [DockerContainer(), ContainerResource()]);
    batchRes.forEach((element) {
      print(element.data.runtimeType.toString());
      switch (element.data.runtimeType.toString()) {
        case "DockerContainer":
          containers = element.data;
          containers.containers!.sort((a, b) => a.name!.compareTo(b.name!));
          break;
        case "ContainerResource":
          resource = element.data;
      }
    });
    setState(() {
      containers.containers!.forEach((container) {
        container.resource = resource.resources!.firstWhere((element) => element.name == container.name);
      });
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    UtilizationProvider utilizationProvider = context.read<UtilizationProvider>();
    Utilization utilization = utilizationProvider.utilization;
    return loading
        ? LoadingWidget(
            size: 30,
          )
        : Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: ListView(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 140,
                        padding: EdgeInsets.symmetric(vertical: 14),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(22),
                        ),
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
                                  gradient: SweepGradient(colors: <Color>[Color(0xFF00BAAD), Color(0xFF4BD6CD)]),
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
                    SizedBox(width: 20),
                    Expanded(
                      child: Container(
                        height: 140,
                        padding: EdgeInsets.symmetric(vertical: 14),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(22),
                        ),
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
                                  gradient: SweepGradient(colors: <Color>[AppTheme.of(context)!.primaryColor!, Color(0xFF75ACFF)]),
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
                    // Expanded(child: SizedBox()),
                  ],
                ),
                SizedBox(height: 20),
                ...containers.containers!.map(_buildContainerItem).toList(),
              ],
            ),
          );
  }

  Widget _buildContainerItem(Containers container) {
    // if (powerLoading[container['id']] == null) {
    //   powerLoading[container['id']] = false;
    // }
    return GestureDetector(
      onTap: () {
        context.push(ContainerDetail(container.name!), name: 'docker_container_detail');
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
        ),
        margin: EdgeInsets.only(bottom: 10),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 6),
                        child: DotWidget(
                          color: container.statusEnum.color,
                        ),
                      ),
                      Text(
                        container.statusEnum.label,
                        style: TextStyle(color: container.statusEnum.color, fontSize: 13),
                      ),
                      SizedBox(width: 10),
                      if (container.statusEnum == DockerStatusEnum.running)
                        Text(
                          DateTime.fromMillisecondsSinceEpoch(container.upTime! * 1000).timeAgo,
                          style: TextStyle(fontSize: 13, color: Colors.grey),
                        ),
                      Spacer(),
                      SizedBox(
                        height: 10,
                        child: Transform.scale(
                          scale: 0.8,
                          child: CupertinoSwitch(
                            value: container.statusEnum == DockerStatusEnum.running,
                            onChanged: (v) {},
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          // if (powerLoading[container['id']] == null || powerLoading[container['id']]!) {
                          //   return;
                          // }

                          // showCupertinoModalPopup(
                          //   context: context,
                          //   builder: (context) {
                          //     return Material(
                          //       color: Colors.transparent,
                          //       child: Container(
                          //         width: double.infinity,
                          //         padding: EdgeInsets.all(22),
                          //         decoration: BoxDecoration(color: Theme.of(context).scaffoldBackgroundColor, borderRadius: BorderRadius.vertical(top: Radius.circular(22))),
                          //         child: SafeArea(
                          //           top: false,
                          //           child: Column(
                          //             mainAxisSize: MainAxisSize.min,
                          //             children: <Widget>[
                          //               Text(
                          //                 "选择操作",
                          //                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                          //               ),
                          //               SizedBox(
                          //                 height: 12,
                          //               ),
                          //               if (container['status'] == "stopped") ...[
                          //                 CupertinoButton(
                          //                   onPressed: () async {
                          //                     Navigator.of(context).pop();
                          //                     power(container, "start");
                          //                   },
                          //                   color: Theme.of(context).scaffoldBackgroundColor,
                          //                   borderRadius: BorderRadius.circular(25),
                          //                   padding: EdgeInsets.symmetric(vertical: 10),
                          //                   child: Text(
                          //                     "启动",
                          //                     style: TextStyle(fontSize: 18),
                          //                   ),
                          //                 ),
                          //                 SizedBox(
                          //                   height: 22,
                          //                 ),
                          //                 CupertinoButton(
                          //                   onPressed: () async {
                          //                     Navigator.of(context).pop();
                          //                     power(container, "delete", preserveProfile: true);
                          //                   },
                          //                   color: Theme.of(context).scaffoldBackgroundColor,
                          //                   borderRadius: BorderRadius.circular(25),
                          //                   padding: EdgeInsets.symmetric(vertical: 10),
                          //                   child: Text(
                          //                     "清除",
                          //                     style: TextStyle(fontSize: 18, color: Colors.redAccent),
                          //                   ),
                          //                 ),
                          //                 SizedBox(
                          //                   height: 22,
                          //                 ),
                          //                 CupertinoButton(
                          //                   onPressed: () async {
                          //                     Navigator.of(context).pop();
                          //                     power(container, "delete", preserveProfile: false);
                          //                   },
                          //                   color: Theme.of(context).scaffoldBackgroundColor,
                          //                   borderRadius: BorderRadius.circular(25),
                          //                   padding: EdgeInsets.symmetric(vertical: 10),
                          //                   child: Text(
                          //                     "删除",
                          //                     style: TextStyle(fontSize: 18, color: Colors.redAccent),
                          //                   ),
                          //                 ),
                          //               ] else ...[
                          //                 CupertinoButton(
                          //                   onPressed: () async {
                          //                     Navigator.of(context).pop();
                          //                     power(container, "stop");
                          //                   },
                          //                   color: Theme.of(context).scaffoldBackgroundColor,
                          //                   borderRadius: BorderRadius.circular(25),
                          //                   padding: EdgeInsets.symmetric(vertical: 10),
                          //                   child: Text(
                          //                     "停止",
                          //                     style: TextStyle(fontSize: 18, color: Colors.redAccent),
                          //                   ),
                          //                 ),
                          //                 SizedBox(
                          //                   height: 22,
                          //                 ),
                          //                 CupertinoButton(
                          //                   onPressed: () async {
                          //                     Navigator.of(context).pop();
                          //                     power(container, "signal");
                          //                   },
                          //                   color: Theme.of(context).scaffoldBackgroundColor,
                          //                   borderRadius: BorderRadius.circular(25),
                          //                   padding: EdgeInsets.symmetric(vertical: 10),
                          //                   child: Text(
                          //                     "强制停止",
                          //                     style: TextStyle(fontSize: 18, color: Colors.redAccent),
                          //                   ),
                          //                 ),
                          //                 SizedBox(
                          //                   height: 22,
                          //                 ),
                          //                 CupertinoButton(
                          //                   onPressed: () async {
                          //                     Navigator.of(context).pop();
                          //                     power(container, "restart");
                          //                   },
                          //                   color: Theme.of(context).scaffoldBackgroundColor,
                          //                   borderRadius: BorderRadius.circular(25),
                          //                   padding: EdgeInsets.symmetric(vertical: 10),
                          //                   child: Text(
                          //                     "重新启动",
                          //                     style: TextStyle(fontSize: 18, color: Colors.redAccent),
                          //                   ),
                          //                 ),
                          //               ],
                          //               SizedBox(
                          //                 height: 8,
                          //               ),
                          //             ],
                          //           ),
                          //         ),
                          //       ),
                          //     );
                          //   },
                          // );
                        },
                        child: Image.asset(
                          "assets/icons/more_vertical.png",
                          width: 20,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    container.name!,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    container.image!,
                    style: TextStyle(fontSize: 12, color: AppTheme.of(context)?.placeholderColor),
                  ),
                ],
              ),
              if (container.statusEnum == DockerStatusEnum.running) ...[
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                "CPU",
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              Spacer(),
                              Text(
                                "${container.resource?.cpu == null ? '-' : container.resource!.cpu!.toStringAsFixed(2)}%",
                                style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          LineProgressBar(
                            value: container.resource?.cpu ?? 0,
                            backgroundColor: Theme.of(context).dividerColor,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                "内存",
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              Spacer(),
                              Text(
                                "${Utils.formatSize(container.resource?.memory ?? 0, fixed: 0)}",
                                style: TextStyle(color: Colors.green, fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          LineProgressBar(
                            value: container.resource?.memoryPercent ?? 0,
                            backgroundColor: Theme.of(context).dividerColor,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
