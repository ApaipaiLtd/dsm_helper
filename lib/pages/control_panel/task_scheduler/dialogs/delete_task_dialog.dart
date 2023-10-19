import 'package:dsm_helper/models/Syno/Core/CurrentConnection.dart';
import 'package:dsm_helper/models/Syno/Core/TaskScheduler.dart';
import 'package:dsm_helper/themes/app_theme.dart';
import 'package:dsm_helper/utils/extensions/navigator_ext.dart';
import 'package:dsm_helper/utils/utils.dart';
import 'package:dsm_helper/widgets/button.dart';
import 'package:dsm_helper/widgets/glass/glass_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';

class DeleteTaskDialog {
  static Future<bool?> show({required BuildContext context, required Tasks task}) async {
    Utils.vibrate(FeedbackType.warning);
    return await showGlassDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            "删除任务",
            textAlign: TextAlign.center,
          ),
          content: Text(
            "是否确定删除${task.name}？",
          ),
          actions: [
            Row(
              children: [
                Expanded(
                  child: Button(
                    onPressed: () async {
                      context.pop(true);
                    },
                    color: AppTheme.of(context)?.errorColor,
                    child: Text("删除任务"),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Button(
                    onPressed: () async {
                      context.pop();
                    },
                    color: Theme.of(context).disabledColor,
                    child: Text(
                      "取消",
                      // style: TextStyle(color: Colors.black),
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
