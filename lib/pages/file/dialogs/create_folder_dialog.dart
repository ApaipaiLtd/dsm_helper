import 'package:cool_ui/cool_ui.dart';
import 'package:dsm_helper/models/Syno/FileStation/FileStationList.dart';
import 'package:dsm_helper/themes/app_theme.dart';
import 'package:dsm_helper/utils/extensions/navigator_ext.dart';
import 'package:dsm_helper/utils/utils.dart';
import 'package:dsm_helper/widgets/glass/glass_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';

class CreateFolderDialog {
  static Future<bool?> show({required BuildContext context, required String path}) async {
    return await showGlassDialog(
      context: context,
      builder: (context) {
        String name = "";
        return AlertDialog(
          title: Text("新建文件夹"),
          content: TextField(
            onChanged: (v) => name = v,
            autofocus: true,
            decoration: InputDecoration(
              border: UnderlineInputBorder(),
              hintText: "请输入文件夹名",
            ),
          ),
          actions: [
            Row(
              children: [
                Expanded(
                  child: CupertinoButton(
                    onPressed: () async {
                      if (name.trim() == "") {
                        Utils.toast("请输入文件夹名");
                        return;
                      }

                      var hide = showWeuiLoadingToast(context: context);
                      try {
                        Utils.vibrate(FeedbackType.light);
                        await FileItem.createFolder(path, name);
                        Utils.toast("新建文件夹成功");
                        context.pop(true);
                      } on FormatException catch (e) {
                        Utils.toast(e.message);
                        Utils.vibrate(FeedbackType.warning);
                      } catch (e) {
                        Utils.toast("新建文件夹失败");
                        Utils.vibrate(FeedbackType.warning);
                      }
                      hide();
                    },
                    color: AppTheme.of(context)?.primaryColor,
                    borderRadius: BorderRadius.circular(15),
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      "确定",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
                SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: CupertinoButton(
                    onPressed: () async {
                      context.pop(false);
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
