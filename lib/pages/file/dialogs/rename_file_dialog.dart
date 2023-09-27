import 'package:cool_ui/cool_ui.dart';
import 'package:dsm_helper/models/Syno/FileStation/FileStationList.dart';
import 'package:dsm_helper/themes/app_theme.dart';
import 'package:dsm_helper/utils/extensions/navigator_ext.dart';
import 'package:dsm_helper/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RenameFileDialog {
  static Future<bool?> show({required BuildContext context, required FileItem file}) async {
    TextEditingController nameController = TextEditingController(text: file.name!);
    String name = file.name!;
    return await showCupertinoDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('重命名“${file.name!}”', textAlign: TextAlign.center),
          content: TextField(
            onChanged: (v) => name = v,
            controller: nameController,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "请输入新的名称",
              labelText: "文件名",
            ),
          ),
          actions: [
            Row(
              children: [
                Expanded(
                  child: CupertinoButton(
                    onPressed: () async {
                      if (name.trim() == "") {
                        Utils.toast("请输入新文件名");
                        return;
                      }
                      var hide = showWeuiLoadingToast(context: context);
                      try {
                        await file.rename(file.path!, name);
                        context.pop(true);
                      } on FormatException catch (e) {
                        Utils.toast(e.message);
                      } catch (e) {
                        Utils.toast("重命名文件夹失败");
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
            )
          ],
        );
      },
    );
  }
}
