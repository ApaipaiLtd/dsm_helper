import 'package:dsm_helper/models/Syno/Core/CurrentConnection.dart';
import 'package:dsm_helper/pages/dashboard/dialogs/kick_connection_dialog.dart';
import 'package:dsm_helper/pages/dashboard/widgets/widget_card.dart';
import 'package:dsm_helper/providers/setting_provider.dart';
import 'package:dsm_helper/themes/app_theme.dart';
import 'package:dsm_helper/utils/utils.dart';
import 'package:dsm_helper/widgets/empty_widget.dart';
import 'package:dsm_helper/widgets/loading_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ConnectionLogWidget extends StatefulWidget {
  const ConnectionLogWidget({super.key});

  @override
  State<ConnectionLogWidget> createState() => _ConnectionLogWidgetState();
}

class _ConnectionLogWidgetState extends State<ConnectionLogWidget> with AutomaticKeepAliveClientMixin {
  CurrentConnection connectedUsers = CurrentConnection();
  bool loading = true;
  bool error = false;
  @override
  void initState() {
    getData();
    super.initState();
  }

  getData({bool loop = true}) async {
    try {
      connectedUsers = await CurrentConnection.get();
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
    late Widget cardBody;
    if (loading) {
      cardBody = SizedBox(height: 100, child: Center(child: LoadingWidget(size: 30)));
    } else if (error) {
      cardBody = EmptyWidget(
        text: "数据加载失败",
        size: 100,
      );
    } else {
      List<Widget> children = connectedUsers.items?.map((item) => _buildUserItem(context, item)).toList() ?? [];
      if (children.isEmpty) {
        cardBody = EmptyWidget(
          text: "暂无已连接用户",
          size: 100,
        );
      } else {
        cardBody = Column(
          children: children.expand((element) => [element, if (element != children.last) Divider()]).toList(),
        );
      }
    }
    return WidgetCard(
      title: "已连接用户",
      // icon: Image.asset(
      //   "assets/icons/user.png",
      //   width: 26,
      //   height: 26,
      // ),
      body: cardBody,
    );
  }

  Widget _buildUserItem(BuildContext context, UserItems user) {
    DateTime loginTime = DateTime.parse(user.time!.toString().replaceAll("/", "-"));
    DateTime currentTime = DateTime.now();
    var timeLong = Utils.timeLong(currentTime.difference(loginTime).inSeconds);
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${user.who}",
                style: TextStyle(fontSize: 16),
                overflow: TextOverflow.ellipsis,
              ),
              Row(
                children: [
                  Text(
                    "${user.type}",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 14, color: AppTheme.of(context)?.placeholderColor),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "${timeLong.hours.toString().padLeft(2, "0")}:${timeLong.minutes.toString().padLeft(2, "0")}:${timeLong.seconds.toString().padLeft(2, "0")}",
                    style: TextStyle(fontSize: 14, color: AppTheme.of(context)?.primaryColor),
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.right,
                  )
                ],
              )
            ],
          ),
        ),
        SizedBox(
          width: 5,
        ),
        CupertinoButton(
          onPressed: user.running || user.canBeKicked == false
              ? null
              : () async {
                  bool? res = await KickConnectDialog.show(context: context, user: user);
                  if (res == true) {
                    setState(() {
                      user.running = true;
                    });
                    bool? result = await user.kickConnection();
                    if (result == true) {
                      getData(loop: false);
                    }
                  }
                },
          padding: EdgeInsets.zero,
          child: user.running
              ? LoadingWidget(
                  size: 24,
                )
              : Image.asset(
                  "assets/icons/remove_circle_fill.png",
                  width: 24,
                  height: 24,
                ),
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
