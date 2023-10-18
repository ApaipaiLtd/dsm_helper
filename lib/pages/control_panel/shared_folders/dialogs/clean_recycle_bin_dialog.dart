import 'package:cool_ui/cool_ui.dart';
import 'package:dsm_helper/apis/dsm_api/dsm_exception.dart';
import 'package:dsm_helper/models/Syno/Core/Share.dart';
import 'package:dsm_helper/themes/app_theme.dart';
import 'package:dsm_helper/utils/extensions/navigator_ext.dart';
import 'package:dsm_helper/utils/utils.dart';
import 'package:dsm_helper/widgets/glass/glass_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';

class CleanRecycleBinDialog {
  static Future<bool?> show({required BuildContext context, required Shares share}) async {
    Utils.vibrate(FeedbackType.warning);
    return await showGlassDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            "清空回收站：${share.name}",
            textAlign: TextAlign.center,
          ),
          content: Text(
            "共享文件夹的回收站将被清空。是否确定要继续？",
          ),
          actions: [
            Row(
              children: [
                Expanded(
                  child: CupertinoButton(
                    onPressed: () async {
                      var hide = showWeuiLoadingToast(context: context);
                      try {
                        bool? res = await share.cleanRecycleBin();
                        hide();
                        if (res == false) {
                          Utils.vibrate(FeedbackType.success);
                          Utils.toast("回收站已清空");
                          context.pop();
                        } else {
                          Utils.vibrate(FeedbackType.error);
                          Utils.toast("清空回收站中…");
                          context.pop();
                        }
                      } on DsmException catch (e) {
                        hide();
                        Utils.toast(e.message);
                      } finally {
                        hide();
                      }
                    },
                    color: AppTheme.of(context)?.warningColor,
                    borderRadius: BorderRadius.circular(15),
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      "是",
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
                      "否",
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
