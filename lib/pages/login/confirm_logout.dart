import 'package:dsm_helper/util/function.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sp_util/sp_util.dart';


class ConfirmLogout extends StatefulWidget {
  final bool otpEnable;
  ConfirmLogout(this.otpEnable);
  @override
  _ConfirmLogoutState createState() => _ConfirmLogoutState();
}

class _ConfirmLogoutState extends State<ConfirmLogout> {
  bool forget = false;
  @override
  Widget build(BuildContext context) {
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
                  "退出登录",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 12,
                ),
                Text(
                  "确认要退出登录当前账号吗？",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  height: 22,
                ),
                if (widget.otpEnable) ...[
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        forget = !forget;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        borderRadius: BorderRadius.circular(20),
                      ),

                      height: 60,
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      child: Row(
                        children: [
                          Text("取消记住本设备"),
                          Spacer(),
                          if (forget)
                            Icon(
                              CupertinoIcons.checkmark_alt,
                              color: Color(0xffff9813),
                            ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 22,
                  ),
                ],
                Row(
                  children: [
                    Expanded(
                      child: CupertinoButton(
                        onPressed: () async {
                          if (forget) {
                            Api.trustDevice("delete");
                          }
                          SpUtil.remove("sid");
                          // Util.removeStorage("smid");
                          Navigator.of(context).pushNamedAndRemoveUntil("/login", (route) => false);
                        },
                          color: Theme.of(context).scaffoldBackgroundColor,
                          borderRadius: BorderRadius.circular(25),

                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          "退出登录",
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
  }
}
