import 'package:dsm_helper/themes/app_theme.dart';
import 'package:dsm_helper/utils/extensions/navigator_ext.dart';
import 'package:dsm_helper/utils/utils.dart';
import 'package:dsm_helper/widgets/glass/glass_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';

class SshDialog {
  static Future<bool?> show({required BuildContext context, bool enable = false}) async {
    Utils.vibrate(FeedbackType.warning);
    return await showGlassDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            "${enable ? '开启' : '关闭'}",
            textAlign: TextAlign.center,
          ),
          content: Text(
            "确认要${enable ? '开启' : '关闭'}SSH吗？",
          ),
          actions: [
            Row(
              children: [
                Expanded(
                  child: CupertinoButton(
                    onPressed: () async {
                      context.pop(enable);
                    },
                    color: AppTheme.of(context)?.errorColor,
                    borderRadius: BorderRadius.circular(15),
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      "${enable ? '开启' : '关闭'}SSH",
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
