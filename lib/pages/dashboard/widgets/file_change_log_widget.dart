import 'package:dsm_helper/models/Syno/Core/SyslogClient/Log.dart';
import 'package:dsm_helper/pages/dashboard/widgets/widget_card.dart';
import 'package:dsm_helper/providers/setting_provider.dart';
import 'package:dsm_helper/widgets/empty_widget.dart';
import 'package:dsm_helper/widgets/loading_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timelines/timelines.dart';

class FileChangeLogWidget extends StatefulWidget {
  const FileChangeLogWidget({super.key});

  @override
  State<FileChangeLogWidget> createState() => _FileChangeLogWidgetState();
}

class _FileChangeLogWidgetState extends State<FileChangeLogWidget> with AutomaticKeepAliveClientMixin {
  bool loading = true;
  bool error = false;
  SyslogClientLog fileLogs = SyslogClientLog();

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData({bool loop = true}) async {
    try {
      fileLogs = await SyslogClientLog.list();
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
      title: "文件更改日志",
      /*icon: Image.asset(
        "assets/icons/file_change.png",
        width: 26,
        height: 26,
      ),*/
      body: SizedBox(
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
                : fileLogs.items != null && fileLogs.items!.isNotEmpty
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
                    : EmptyWidget(
                        text: "暂无日志",
                      ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
