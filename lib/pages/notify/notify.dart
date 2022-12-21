import 'dart:convert';

import 'package:cool_ui/cool_ui.dart';
import 'package:dsm_helper/themes/app_theme.dart';
import 'package:dsm_helper/util/function.dart';
import 'package:dsm_helper/util/strings.dart';
import 'package:dsm_helper/widgets/expansion_container.dart';
import 'package:dsm_helper/widgets/neu_back_button.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:neumorphic/neumorphic.dart';

class Notify extends StatefulWidget {
  final List notifies;
  Notify(this.notifies);
  @override
  _NotifyState createState() => _NotifyState();
}

class _NotifyState extends State<Notify> {
  Map<String, List> notifyGroups = {};
  @override
  void initState() {
    widget.notifies.forEach((notify) {
      List msgs = notify['msg'];
      List msgContent = [];
      String title = "";
      List<String> titles = notify['title'].split(":");
      if (Util.version == 7) {
        if (Util.notifyStrings[notify['title']] != null) {
          // print(Util.notifyStrings[notify['title']]);
          title = Util.notifyStrings[notify['title']]['title'];

          for (String content in msgs) {
            Map msgMap = json.decode(content);
            String replaceContent = Util.notifyStrings[notify['title']]['msg'];

            replaceContent = replaceContent.replaceAll("%LINK_BEGIN%", "").replaceAll("%LINK_END%", "").replaceAll("%PRE_APP_LINK%", "").replaceAll("%POST_APP_LINK%", "");

            if (replaceContent.contains("<a")) {
              var document = parse(replaceContent);

              replaceContent = parse(document.body.text).documentElement.text;
            }

            msgMap.forEach((key, value) {
              replaceContent = replaceContent.replaceAll(key, value);
            });
            msgContent.add(replaceContent);
          }
        } else {
          print("未找到");
          title = notify['className'] == "" ? notify['title'] : notify['className'];
          msgContent = msgs;
        }
      } else {
        //判断是否在string内
        if (webManagerStrings[titles[0]] != null && webManagerStrings[titles[0]][titles[1]] != null) {
          if (webManagerStrings[titles[0]][titles[1]] != null) {
            title = webManagerStrings[titles[0]][titles[1]];
          }
          msgContent = msgs;
        } else if (Util.strings[notify['className']] != null) {
          if (Util.strings[notify['className']][titles[0]] != null && Util.strings[notify['className']][titles[0]][titles[1]] != null) {
            title = Util.strings[notify['className']][titles[0]][titles[1]];
          } else if (Util.strings[notify['className']] != null && Util.strings[notify['className']]['common'] != null && Util.strings[notify['className']]['common']['displayname'] != null) {
            title = Util.strings[notify['className']]['common']['displayname'];
          }
          msgContent = msgs;
        } else {
          print("未找到");
          title = notify['className'] == "" ? notify['title'] : notify['className'];
          msgContent = msgs;
        }
      }
      notify['contents'] = msgContent;
      if (notifyGroups[title] == null) {
        notifyGroups[title] = [notify];
      } else {
        notifyGroups[title].add(notify);
      }
    });
    setState(() {});
    super.initState();
  }

  Widget _buildNotifyGroup(groupName, List group) {
    return NeuCard(
      decoration: NeumorphicDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.only(left: 20, right: 20, top: 20),
      bevel: 10,
      curveType: CurveType.flat,
      child: ExpansionContainer(
        title: Text(
          "$groupName （${group.length}）",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          overflow: TextOverflow.ellipsis,
        ),
        showFirst: true,
        first: _buildNotifyItem(group.first),
        children: group.map((_buildNotifyItem)).toList(),
      ),
    );
  }

  Widget _buildNotifyItem(notify) {
    return NeuCard(
      width: double.infinity,
      decoration: NeumorphicDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: EdgeInsets.all(15),
      bevel: 10,
      curveType: CurveType.flat,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            DateTime.fromMillisecondsSinceEpoch(notify['time'] * 1000).timeAgo,
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
          Column(
            children: (notify['contents'] as List).map((msg) {
              return Text(msg);
            }).toList(),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: AppBackButton(context),
        title: Text(
          "消息",
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: widget.notifies.length > 0
                ? ListView(
                    children: notifyGroups.keys.map((key) {
                      return _buildNotifyGroup(key, notifyGroups[key]);
                    }).toList(),
                  )
                : Center(
                    child: Text(
                      "暂无消息",
                      style: TextStyle(color: AppTheme.of(context).placeholderColor),
                    ),
                  ),
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: Row(
              children: [
                Expanded(
                  child: NeuButton(
                    decoration: NeumorphicDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    onPressed: () async {
                      var res = await Api.clearNotify();
                      if (res['success']) {
                        Util.toast("清除成功");
                        Navigator.of(context).pop(true);
                      }
                    },
                    child: Text("全部清除"),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
