import 'package:dsm_helper/apis/api.dart';
import 'package:dsm_helper/apis/dsm_api/dsm_response.dart';
import 'package:dsm_helper/models/Syno/Core/System/Utilization.dart';
import 'package:dsm_helper/models/Syno/Docker/Container/ContainerResource.dart';
import 'package:dsm_helper/models/Syno/Docker/DockerContainer.dart' hide State;
import 'package:dsm_helper/pages/docker/detail.dart';
import 'package:dsm_helper/pages/docker/enums/docker_status_enum.dart';
import 'package:dsm_helper/providers/utilization_provider.dart';
import 'package:dsm_helper/themes/app_theme.dart';
import 'package:dsm_helper/utils/extensions/datetime_ext.dart';
import 'package:dsm_helper/utils/extensions/navigator_ext.dart';
import 'package:dsm_helper/widgets/label.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class ContainerPage extends StatefulWidget {
  const ContainerPage({super.key});

  @override
  State<ContainerPage> createState() => _ContainerPageState();
}

class _ContainerPageState extends State<ContainerPage> {
  DockerContainer containers = DockerContainer();
  ContainerResource resource = ContainerResource();
  bool loading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  getData() async {
    List<DsmResponse> batchRes = await Api.dsm.batch(apis: [DockerContainer(), ContainerResource()]);
    batchRes.forEach((element) {
      switch (element.data.runtimeType.toString()) {
        case "DockerContainer":
          containers = element.data;
          break;
        case "ContainerResource":
          setState(() {
            resource = element.data;
          });
      }
    });
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    UtilizationProvider utilizationProvider = context.read<UtilizationProvider>();
    Utilization utilization = utilizationProvider.utilization;
    return ListView(
      padding: EdgeInsets.all(20),
      children: [
        Row(
          children: [
            Expanded(
              child: SizedBox(
                width: 120,
                height: 120,
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
            Expanded(
              child: SizedBox(
                width: 120,
                height: 120,
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
        SizedBox(
          height: 20,
        ),
        ...containers.containers!.map(_buildContainerItem).toList(),
      ],
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
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(20),
        ),
        margin: EdgeInsets.only(bottom: 20),
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              container.name!,
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                            ),
                            Spacer(),
                            Label(container.statusEnum.label, container.statusEnum.color),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                container.image!,
                                style: TextStyle(fontSize: 12, color: Colors.grey),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            if (container.statusEnum == DockerStatusEnum.running)
                              Text(
                                DateTime.fromMillisecondsSinceEpoch(container.upTime! * 1000).timeAgo,
                                style: TextStyle(fontSize: 12, color: Colors.grey),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 20,
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
                    child: Container(
                      padding: EdgeInsets.all(10),
                      // margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      // padding: EdgeInsets.symmetric(vertical: 20),
                      decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      // child: powerLoading[container['id']] == null || powerLoading[container['id']]!
                      //     ? CupertinoActivityIndicator()
                      //     : Image.asset(
                      //         "assets/icons/shutdown.png",
                      //         width: 20,
                      //       ),
                    ),
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
                              Text("CPU"),
                              Spacer(),
                              Text(
                                "${container.toStringAsFixed(2)}%",
                                style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: FAProgressBar(
                              backgroundColor: Colors.transparent,
                              changeColorValue: 90,
                              changeProgressColor: Colors.red,
                              progressColor: Colors.blue,
                              size: 20,
                              displayText: "%",
                              currentValue: (container['cpu']).ceil(),
                            ),
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
                              Text("内存"),
                              Spacer(),
                              Text(
                                "${Utils.formatSize(container['memory'], fixed: 0)}",
                                style: TextStyle(color: Colors.green, fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: FAProgressBar(
                              backgroundColor: Colors.transparent,
                              changeColorValue: 90,
                              changeProgressColor: Colors.red,
                              progressColor: Colors.green,
                              size: 20,
                              displayText: "%",
                              currentValue: container['memoryPercent'].ceil(),
                            ),
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
}
