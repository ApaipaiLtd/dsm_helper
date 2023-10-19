import 'package:dsm_helper/utils/extensions/navigator_ext.dart';
import 'package:dsm_helper/widgets/button.dart';
import 'package:dsm_helper/widgets/glass/glass_dialog.dart';
import 'package:flutter/material.dart';

class DeleteServerDialog {
  static Future<bool?> show(BuildContext context) async {
    return await showGlassDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            "删除服务器",
            textAlign: TextAlign.center,
          ),
          content: Text("确定删除此服务器？"),
          actionsOverflowDirection: VerticalDirection.up,
          actions: [
            Row(
              children: [
                Expanded(
                  child: Button(
                    color: Colors.red,
                    child: Text("删除"),
                    onPressed: () {
                      context.pop(true);
                    },
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Button(
                    child: Text("取消"),
                    onPressed: () {
                      context.pop();
                    },
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
