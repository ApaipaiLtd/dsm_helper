import 'package:dsm_helper/models/Syno/Docker/DockerLog.dart';
import 'package:dsm_helper/widgets/empty_widget.dart';
import 'package:dsm_helper/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:timelines/timelines.dart';

class LogPage extends StatefulWidget {
  const LogPage({super.key});

  @override
  State<LogPage> createState() => _LogPageState();
}

class _LogPageState extends State<LogPage> with AutomaticKeepAliveClientMixin {
  bool loading = true;
  DockerLog dockerLog = DockerLog();
  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    dockerLog = await DockerLog.list();
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return loading
        ? LoadingWidget(size: 30)
        : dockerLog.logs != null && dockerLog.logs!.isNotEmpty
            ? Padding(
                padding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                child: Timeline.tileBuilder(
                  // padding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
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
                            "${dockerLog.logs![index].time}",
                            style: TextStyle(fontSize: 16, height: 1),
                          ),
                          SizedBox(
                            height: 3,
                          ),
                          Text(
                            "${dockerLog.logs![index].event}",
                            style: TextStyle(fontSize: 13, color: Colors.black54),
                          ),
                        ],
                      ),
                    ),
                    indicatorBuilder: (_, index) {
                      return DotIndicator(
                        color: dockerLog.logs![index].levelEnum.color,
                      );
                    },
                    connectorBuilder: (_, index, ___) => DashedLineConnector(
                      color: Color(0x3C3C3C43),
                    ),
                    itemCount: dockerLog.logs!.length,
                  ),
                ),
              )
            : EmptyWidget(
                text: "暂无日志",
              );
  }

  @override
  bool get wantKeepAlive => true;
}
