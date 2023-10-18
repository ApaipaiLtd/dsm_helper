import 'package:cool_ui/cool_ui.dart';
import 'package:dsm_helper/models/Syno/Core/Share.dart';
import 'package:dsm_helper/themes/app_theme.dart';
import 'package:dsm_helper/utils/extensions/navigator_ext.dart';
import 'package:dsm_helper/utils/utils.dart';
import 'package:dsm_helper/widgets/glass/glass_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';

class DeleteShareFolderDialog {
  static Future<bool?> show({required BuildContext context, required Shares share}) async {
    Utils.vibrate(FeedbackType.warning);
    return await showGlassDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            "删除共享文件夹：${share.name}",
            textAlign: TextAlign.center,
          ),
          content: Text(
            "我了解所选共享文件夹将被删除。以下项目也会被移除且无法恢复：\n-共享文件夹的所有快照",
          ),
          actions: [
            Row(
              children: [
                Expanded(
                  child: CupertinoButton(
                    onPressed: () async {
                      var hide = showWeuiLoadingToast(context: context);
                      bool? res = await share.delete();
                      hide();
                      if (res == true) {
                        Utils.vibrate(FeedbackType.success);
                        Utils.toast("删除共享文件夹成功");
                        context.pop(true);
                      } else {
                        Utils.vibrate(FeedbackType.error);
                        Utils.toast("删除失败");
                      }
                    },
                    color: AppTheme.of(context)?.errorColor,
                    borderRadius: BorderRadius.circular(15),
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      "确认删除",
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
