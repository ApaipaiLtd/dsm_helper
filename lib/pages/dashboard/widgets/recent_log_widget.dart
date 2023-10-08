import 'package:dsm_helper/models/Syno/Core/SyslogClient/Status.dart';
import 'package:dsm_helper/pages/dashboard/widgets/widget_card.dart';
import 'package:dsm_helper/pages/log_center/log_center.dart';
import 'package:dsm_helper/themes/app_theme.dart';
import 'package:dsm_helper/widgets/empty_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:timelines/timelines.dart';

class RecentLogWidget extends StatelessWidget {
  final SynoClientStatus latestLog;
  const RecentLogWidget(this.latestLog, {super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetCard(
      onTap: () {
        Navigator.of(context).push(
          CupertinoPageRoute(
            builder: (context) {
              return LogCenter();
            },
            settings: RouteSettings(name: "log_center"),
          ),
        );
      },
      title: "最新日志",
      // icon: Image.asset(
      //   "assets/icons/log.png",
      //   width: 26,
      //   height: 26,
      // ),
      body: Column(
        children: [
          SizedBox(
            height: 300,
            child: latestLog.logs != null && latestLog.logs!.length > 0
                ? CupertinoScrollbar(
                    child: Timeline.tileBuilder(
                      padding: EdgeInsets.symmetric(vertical: 10),
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
                    // child: ListView.builder(
                    //   itemBuilder: (context, i) {
                    //     return _buildLogItem(context, latestLog.logs![i]);
                    //   },
                    //   itemCount: latestLog.logs!.length,
                    // ),
                  )
                : EmptyWidget(
                    text: "暂无日志",
                  ),
          ),
        ],
      ),
    );
  }
}
