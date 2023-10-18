import 'package:dsm_helper/themes/app_theme.dart';
import 'package:dsm_helper/utils/extensions/navigator_ext.dart';
import 'package:dsm_helper/utils/utils.dart';
import 'package:dsm_helper/widgets/glass/glass_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:fluwx/fluwx.dart';
import 'package:sp_util/sp_util.dart';

class FeedbackDialog {
  static Future<bool?> show({required BuildContext context}) async {
    Utils.vibrate(FeedbackType.warning);
    return await showGlassDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            "问题反馈",
            textAlign: TextAlign.center,
          ),
          content: Text("您将进入“阿派派软件”微信小程序进行问题反馈。是否确定要继续？"),
          actions: [
            Row(
              children: [
                Expanded(
                  child: CupertinoButton(
                    onPressed: () async {
                      context.pop();
                      SpUtil.putBool("feedback_confirm", true);
                      Fluwx().open(target: MiniProgram(username: "gh_6c07712ef0fb"));
                    },
                    color: AppTheme.of(context)?.errorColor,
                    borderRadius: BorderRadius.circular(15),
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      "进入小程序",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: CupertinoButton(
                    onPressed: () async {
                      context.pop();
                    },
                    color: Theme.of(context).disabledColor,
                    borderRadius: BorderRadius.circular(15),
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      "取消",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
