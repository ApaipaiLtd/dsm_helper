import 'dart:convert';
import 'dart:ui';
import 'package:dsm_helper/models/Syno/Core/Notify.dart';
import 'package:dsm_helper/utils/utils.dart' hide Api;
import 'package:dsm_helper/utils/strings.dart';
import 'package:dsm_helper/widgets/empty_widget.dart';
import 'package:dsm_helper/widgets/expansion_container.dart';
import 'package:dsm_helper/widgets/page_body_widget.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:html/parser.dart';

class Notify extends StatefulWidget {
  final DsmNotify notifies;
  Notify(this.notifies);
  @override
  _NotifyState createState() => _NotifyState();
}

class _NotifyState extends State<Notify> {
  Map<String, List<DsmNotifyItems>> notifyGroups = {};

  @override
  void initState() {
    parseNotify();
    super.initState();
  }

  parseNotify() {
    if (widget.notifies.items != null) {}
    widget.notifies.items!.forEach((notify) {
      List<String> msgs = notify.msg ?? [];
      List<String> msgContent = [];
      String title = "";
      List<String> titles = notify.title!.split(":");
      if (true) {
        if (Utils.notifyStrings[notify.title!] != null) {
          // print(Utils.notifyStrings[notify['title']]);
          title = Utils.notifyStrings[notify.title]!.title!;

          for (String content in msgs) {
            Map msgMap = json.decode(content);
            String replaceContent = Utils.notifyStrings[notify.title]!.msg!;

            replaceContent = replaceContent.replaceAll("%LINK_BEGIN%", "").replaceAll("%LINK_END%", "").replaceAll("%PRE_APP_LINK%", "").replaceAll("%POST_APP_LINK%", "");

            // if (replaceContent.contains("<a")) {
            //   var document = parse(replaceContent);
            //
            //   replaceContent = parse(document.body?.text).documentElement?.text ?? '';
            // }
            // replaceContent.replaceAll(RegExp(r'<[^>]*>|&[^;]+;'), '');

            msgMap.forEach((key, value) {
              replaceContent = replaceContent.replaceAll(key, value);
            });
            msgContent.add(replaceContent);
          }
        } else {
          print("未找到");
          title = (notify.className == "" ? notify.title : notify.className) ?? '';
          msgContent = msgs;
        }
      } else {
        //判断是否在string内
        if (webManagerStrings[titles[0]] != null && webManagerStrings[titles[0]][titles[1]] != null) {
          if (webManagerStrings[titles[0]][titles[1]] != null) {
            title = webManagerStrings[titles[0]][titles[1]];
          }
          msgContent = msgs;
        } else if (Utils.strings[notify.className] != null) {
          if (Utils.strings[notify.className][titles[0]] != null && Utils.strings[notify.className][titles[0]][titles[1]] != null) {
            title = Utils.strings[notify.className][titles[0]][titles[1]];
          } else if (Utils.strings[notify.className] != null && Utils.strings[notify.className]['common'] != null && Utils.strings[notify.className]['common']['displayname'] != null) {
            title = Utils.strings[notify.className]['common']['displayname'];
          }
          msgContent = msgs;
        } else {
          print("未找到");
          title = (notify.className == "" ? notify.title : notify.className) ?? '';
          msgContent = msgs;
        }
      }
      notify.contents = msgContent;
      if (notifyGroups[title] == null) {
        notifyGroups[title] = [notify];
      } else {
        notifyGroups[title]?.add(notify);
      }
    });
    setState(() {});
  }

  Widget _buildNotifyGroup(groupName, List<DsmNotifyItems> notifies) {
    return Container(
      child: ExpansionContainer(
        title: Text(
          "$groupName （${notifies.length}）",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          overflow: TextOverflow.ellipsis,
        ),
        showFirst: true,
        first: _buildNotifyItem(notifies.first),
        children: notifies.map((_buildNotifyItem)).toList(),
      ),
    );
  }

  Widget _buildNotifyItem(DsmNotifyItems notify) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            DateTime.fromMillisecondsSinceEpoch(notify.time! * 1000).timeAgo,
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
          Column(
            children: notify.contents.map((msg) {
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
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: Text(
            "消息",
          ),
          backgroundColor: Colors.transparent,
          notificationPredicate: (_) {
            return false;
          },
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          flexibleSpace: ClipRRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                color: Colors.transparent, // 设置模糊背景的颜色和透明度
              ),
            ),
          ),
          actions: [
            CupertinoButton(
              onPressed: () async {
                // var res = await Api.clearNotify();
                // if (res['success']) {
                //   Utils.toast("清除成功");
                //   Navigator.of(context).pop(true);
                // }
              },
              child: Image.asset(
                "assets/icons/clean.png",
                width: 20,
                height: 20,
              ),
            ),
          ],
        ),
        body: PageBodyWidget(
          body: widget.notifies.items != null && widget.notifies.items!.isNotEmpty
              ? ListView(
                  children: notifyGroups.keys.map((key) {
                    return _buildNotifyGroup(key, notifyGroups[key]!);
                  }).toList(),
                )
              : EmptyWidget(
                  text: "暂无数据",
                ),
        ));
  }
}
