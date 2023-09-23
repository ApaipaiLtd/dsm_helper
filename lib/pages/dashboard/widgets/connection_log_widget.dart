import 'package:dsm_helper/models/Syno/Core/CurrentConnection.dart';
import 'package:dsm_helper/pages/dashboard/widgets/widget_card.dart';
import 'package:dsm_helper/themes/app_theme.dart';
import 'package:dsm_helper/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ConnectionLogWidget extends StatelessWidget {
  final CurrentConnection connectedUsers;
  const ConnectionLogWidget(this.connectedUsers, {super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> children = connectedUsers.items!.map((item) => _buildUserItem(context, item)).toList();
    return WidgetCard(
      title: "已连接用户",
      // icon: Image.asset(
      //   "assets/icons/user.png",
      //   width: 26,
      //   height: 26,
      // ),
      body: connectedUsers.items != null && connectedUsers.items!.length > 0
          ? Column(
              children: children.expand((element) => [element, if (element != children.last) Container(margin: EdgeInsets.symmetric(horizontal: 16), color: Colors.black12, height: 0.5)]).toList(),
            )
          : Center(
              child: Text(
                "暂无日志",
                style: TextStyle(color: AppTheme.of(context)?.placeholderColor),
              ),
            ),
    );
  }

  Widget _buildUserItem(BuildContext context, UserItems user) {
    DateTime loginTime = DateTime.parse(user.time!.toString().replaceAll("/", "-"));
    DateTime currentTime = DateTime.now();
    var timeLong = Utils.timeLong(currentTime.difference(loginTime).inSeconds);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Row(
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
                      style: TextStyle(fontSize: 16, color: Colors.black45),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "${timeLong.hours.toString().padLeft(2, "0")}:${timeLong.minutes.toString().padLeft(2, "0")}:${timeLong.seconds.toString().padLeft(2, "0")}",
                      style: TextStyle(fontSize: 16, color: Color(0xFF2A82E4)),
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
            onPressed: () async {
              if (user.running) {
                return;
              }
              showCupertinoModalPopup(
                context: context,
                builder: (context) {
                  return Material(
                    color: Colors.transparent,
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(color: Theme.of(context).scaffoldBackgroundColor, borderRadius: BorderRadius.vertical(top: Radius.circular(22))),
                      child: SafeArea(
                        top: false,
                        child: Padding(
                          padding: EdgeInsets.all(20),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text(
                                "终止连接",
                                style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              Text(
                                "确认要终止此连接？",
                                style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.w400),
                              ),
                              SizedBox(
                                height: 22,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: CupertinoButton(
                                      onPressed: () async {
                                        // Navigator.of(context).pop();
                                        // setState(() {
                                        //   user['running'] = true;
                                        // });
                                        // var res = await Api.kickConnection({"who": user['who'], "from": user['from']});
                                        // setState(() {
                                        //   user['running'] = false;
                                        // });
                                        //
                                        // if (res['success']) {
                                        //   Utils.toast("连接已终止");
                                        // }
                                      },
                                      color: Theme.of(context).scaffoldBackgroundColor,
                                      borderRadius: BorderRadius.circular(25),
                                      padding: EdgeInsets.symmetric(vertical: 10),
                                      child: Text(
                                        "终止连接",
                                        style: TextStyle(fontSize: 18, color: Colors.redAccent),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 16,
                                  ),
                                  Expanded(
                                    child: CupertinoButton(
                                      onPressed: () async {
                                        Navigator.of(context).pop();
                                      },
                                      color: Theme.of(context).scaffoldBackgroundColor,
                                      borderRadius: BorderRadius.circular(25),
                                      padding: EdgeInsets.symmetric(vertical: 10),
                                      child: Text(
                                        "取消",
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 8,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            },
            padding: EdgeInsets.zero,
            child: SizedBox(
              width: 30,
              height: 30,
              child: user.running
                  ? CupertinoActivityIndicator()
                  : Image.asset(
                      "assets/icons/remove_circle_fill.png",
                      width: 30,
                      height: 30,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
