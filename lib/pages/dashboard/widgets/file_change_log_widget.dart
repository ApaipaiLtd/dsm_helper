import 'package:dsm_helper/models/Syno/Core/SyslogClient/Log.dart';
import 'package:dsm_helper/pages/dashboard/widgets/widget_card.dart';
import 'package:dsm_helper/themes/app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:timelines/timelines.dart';

class FileChangeLogWidget extends StatelessWidget {
  final SyslogClientLog fileLogs;
  const FileChangeLogWidget(this.fileLogs, {super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetCard(
      title: "文件更改日志",
      /*icon: Image.asset(
        "assets/icons/file_change.png",
        width: 26,
        height: 26,
      ),*/
      body: SizedBox(
        height: 300,
        child: fileLogs.items != null && fileLogs.items!.isNotEmpty
            ? CupertinoScrollbar(
                child: Timeline.tileBuilder(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
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
                            "${fileLogs.items![index].time}",
                            style: TextStyle(fontSize: 16, height: 1),
                          ),
                          SizedBox(
                            height: 3,
                          ),
                          Text(
                            "${fileLogs.items![index].descr}",
                            style: TextStyle(fontSize: 13, color: Colors.black54),
                          ),
                        ],
                      ),
                    ),
                    indicatorBuilder: (_, index) {
                      return DotIndicator(
                        color: Colors.transparent,
                        child: Image.asset(
                          "assets/icons/${fileLogs.items![index].cmd}.png",
                          width: 14,
                          height: 14,
                        ),
                      );
                    },
                    connectorBuilder: (_, index, ___) => DashedLineConnector(
                      color: Color(0x3C3C3C43),
                    ),
                    itemCount: 10,
                  ),
                ),
                // child: ListView.builder(
                //   itemBuilder: (context, i) {
                //     return _buildFileLogItem(fileLogs.items![i]);
                //   },
                //   itemCount: fileLogs.items!.length,
                // ),
              )
            : Center(
                child: Text(
                  "暂无日志",
                  style: TextStyle(color: AppTheme.of(context)?.placeholderColor),
                ),
              ),
      ),
    );
  }
}
