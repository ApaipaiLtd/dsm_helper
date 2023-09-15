import 'package:dsm_helper/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:gesture_password_widget/gesture_password_widget.dart';
import 'package:sp_util/sp_util.dart';

class GesturePasswordPage extends StatefulWidget {
  GesturePasswordPage({super.key, this.title});

  final String? title;

  @override
  _GesturePasswordPageState createState() => new _GesturePasswordPageState();
}

class _GesturePasswordPageState extends State<GesturePasswordPage> {
  int step = 1;
  String newPassword = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('设置密码'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(
              height: 40,
            ),
            Text(
              step == 1 ? "请绘制图案" : "请再绘制一遍",
              style: TextStyle(fontSize: 26),
            ),
            SizedBox(
              height: 80,
            ),
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.width * 0.9,
                child: GesturePasswordWidget(
                  // attribute: ItemAttribute(normalColor: Colors.grey, selectedColor: Colors.blue, lineStrokeWidth: 4),
                  onComplete: (s) {
                    if (step == 1) {
                      Utils.vibrate(FeedbackType.light);
                      setState(() {
                        newPassword = s.join("");
                        step = 2;
                      });
                    } else if (step == 2) {
                      if (s.join("") == newPassword) {
                        Utils.vibrate(FeedbackType.success);
                        SpUtil.putString("gesture_password", newPassword);
                        Navigator.of(context).pop(true);
                      } else {
                        Utils.toast("两次图案不一致，请重新设置");
                        Utils.vibrate(FeedbackType.warning);
                        setState(() {
                          step = 1;
                          newPassword = "";
                        });
                      }
                    }
                  },
                  // failCallback: () {
                  //   Utils.toast("至少连接4个点");
                  //   Utils.vibrate(FeedbackType.warning);
                  //   miniGesturePassword.currentState?.setSelected('');
                  // },
                  // selectedCallback: (str) {
                  //   miniGesturePassword.currentState?.setSelected(str);
                  // },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
