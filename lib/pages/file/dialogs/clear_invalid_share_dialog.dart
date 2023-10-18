import 'package:cool_ui/cool_ui.dart';
import 'package:dsm_helper/models/Syno/FileStation/Sharing.dart';
import 'package:dsm_helper/themes/app_theme.dart';
import 'package:dsm_helper/utils/extensions/navigator_ext.dart';
import 'package:dsm_helper/utils/utils.dart';
import 'package:dsm_helper/widgets/glass/glass_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';

class ClearInvalidShareDialog {
  static Future<bool?> show({required BuildContext context}) async {
    Utils.vibrate(FeedbackType.warning);
    return await showGlassDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            "清除无效链接",
            textAlign: TextAlign.center,
          ),
          content: Text(
            "确认删除所有无效和过期的无效链接？",
          ),
          actions: [
            Row(
              children: [
                Expanded(
                  child: CupertinoButton(
                    onPressed: () async {
                      var hide = showWeuiLoadingToast(context: context);
                      bool? res = await Sharing.clearInvalid();
                      hide();
                      if (res == true) {
                        Utils.toast("所有坏链和过期链接已被删除");
                        context.pop(true);
                      } else {
                        Utils.toast("清除失败");
                      }
                    },
                    color: AppTheme.of(context)?.errorColor,
                    borderRadius: BorderRadius.circular(15),
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      "清除",
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
                      Navigator.of(context).pop();
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
