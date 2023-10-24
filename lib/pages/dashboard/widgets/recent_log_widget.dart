import 'package:dsm_helper/models/Syno/Core/SyslogClient/Status.dart';
import 'package:dsm_helper/pages/dashboard/widgets/widget_card.dart';
import 'package:dsm_helper/pages/log_center/log_center.dart';
import 'package:dsm_helper/providers/setting_provider.dart';
import 'package:dsm_helper/utils/extensions/navigator_ext.dart';
import 'package:dsm_helper/widgets/empty_widget.dart';
import 'package:dsm_helper/widgets/loading_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timelines/timelines.dart';

class RecentLogWidget extends StatefulWidget {
  const RecentLogWidget({super.key});

  @override
  State<RecentLogWidget> createState() => _RecentLogWidgetState();
}

class _RecentLogWidgetState extends State<RecentLogWidget> with AutomaticKeepAliveClientMixin {
  bool loading = true;
  bool error = false;
  SynoClientStatus latestLog = SynoClientStatus();

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData({bool loop = true}) async {
    try {
      latestLog = await SynoClientStatus.get();
      setState(() {
        loading = false;
      });
    } catch (e) {
      // 如果首次加载失败，则显示错误信息，否则不显示
      if (loading) {
        setState(() {
          error = true;
        });
      }
    }
    if (loop && mounted) {
      int refreshDuration = context.read<SettingProvider>().refreshDuration;
      Future.delayed(Duration(seconds: refreshDuration)).then((_) {
        getData();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return WidgetCard(
      onTap: () {
        context.push(LogCenter(), name: "log_center");
      },
      title: "最新日志",
      // icon: Image.asset(
      //   "assets/icons/log.png",
      //   width: 26,
      //   height: 26,
      // ),
      bodyPadding: EdgeInsets.symmetric(vertical: 14),
      body: Column(
        children: [
          SizedBox(
            height: 300,
            child: loading
                ? Center(
                    child: LoadingWidget(
                      size: 30,
                    ),
                  )
                : error
                    ? EmptyWidget(
                        text: "数据加载失败",
                        size: 100,
                      )
                    : latestLog.logs != null && latestLog.logs!.length > 0
                        ? CupertinoScrollbar(
                            child: Timeline.tileBuilder(
                              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                              theme: TimelineThemeData(
                                nodePosition: 0,
                                color: Color(0xff989898),
                                indicatorTheme: IndicatorThemeData(
                                  position: 0,
                                  size: 14.0,
                                ),
                                connectorTheme: ConnectorThemeData(
                                  thickness: 1,
                                ),
                              ),
                              builder: TimelineTileBuilder.connected(
                                connectionDirection: ConnectionDirection.before,
                                contentsAlign: ContentsAlign.basic,
                                contentsBuilder: (context, index) => Padding(
                                  padding: const EdgeInsets.only(left: 14.0, bottom: 18),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${latestLog.logs![index].ldate} ${latestLog.logs![index].ltime}",
                                        style: TextStyle(fontSize: 16, height: 1),
                                      ),
                                      SizedBox(
                                        height: 3,
                                      ),
                                      Text(
                                        "${latestLog.logs![index].msg}",
                                        style: TextStyle(fontSize: 13, color: Colors.black54),
                                      ),
                                    ],
                                  ),
                                ),
                                indicatorBuilder: (_, index) {
                                  return DotIndicator(
                                    color: latestLog.logs![index].prio == "warning" ? Color(0xFFF58414) : Color(0x3C3C3C43),
                                  );
                                },
                                connectorBuilder: (_, index, ___) => DashedLineConnector(
                                  color: Color(0x3C3C3C43),
                                ),
                                itemCount: latestLog.logs!.length,
                              ),
                            ),
                          )
                        : EmptyWidget(
                            text: "暂无日志",
                          ),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
