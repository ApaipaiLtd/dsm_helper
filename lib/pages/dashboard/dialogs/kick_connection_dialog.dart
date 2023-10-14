import 'package:dsm_helper/models/Syno/Core/CurrentConnection.dart';
import 'package:dsm_helper/themes/app_theme.dart';
import 'package:dsm_helper/utils/extensions/navigator_ext.dart';
import 'package:dsm_helper/utils/utils.dart';
import 'package:dsm_helper/widgets/custom_dialog/custom_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';

class KickConnectDialog {
  static Future<bool?> show({required BuildContext context, required UserItems user}) async {
    Utils.vibrate(FeedbackType.warning);
    return await showCustomDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            "终止连接",
            textAlign: TextAlign.center,
          ),
          content: Text(
            "是否确定要终止${user.who}的连接？",
          ),
          actions: [
            Row(
              children: [
                Expanded(
                  child: CupertinoButton(
                    onPressed: () async {
                      context.pop(true);
                    },
                    color: AppTheme.of(context)?.errorColor,
                    borderRadius: BorderRadius.circular(15),
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      "终止连接",
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
