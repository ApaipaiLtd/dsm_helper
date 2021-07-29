import 'package:dsm_helper/util/function.dart';
import 'package:dsm_helper/widgets/neu_back_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neumorphic/neumorphic.dart';

class Logout extends StatefulWidget {
  const Logout({Key key}) : super(key: key);

  @override
  _LogoutState createState() => _LogoutState();
}

class _LogoutState extends State<Logout> {
  String content = "";
  bool read = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: AppBackButton(context),
        title: Text("注销账号"),
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                read = !read;
                Util.setStorage("read", read ? "1" : "0");
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: read ? Color(0xffff9813) : Colors.grey),
                  ),
                  height: 20,
                  width: 20,
                  alignment: Alignment.center,
                  child: read
                      ? Icon(
                          CupertinoIcons.checkmark_alt,
                          color: Color(0xffff9813),
                          size: 16,
                        )
                      : SizedBox(),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(text: "我已知悉账号注销后，所有与此账号有关的文件、操作记录等信息将被删除并永久无法恢复，我已备份好重要文件，因账号注销造成的损失与群晖助手无关。"),
                      ],
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          NeuButton(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              decoration: NeumorphicDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(20),
              ),
              onPressed: () {
                Util.toast("我们已收到您的账号注销申请，将在3个工作日内处理。");
                Navigator.of(context).pop();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "申请注销",
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
