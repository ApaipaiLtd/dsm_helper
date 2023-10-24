import 'package:cool_ui/cool_ui.dart';
import 'package:dsm_helper/models/Syno/FileStation/FileStationList.dart';
import 'package:dsm_helper/models/Syno/Virtualization/VirtualizationGuest.dart';
import 'package:dsm_helper/themes/app_theme.dart';
import 'package:dsm_helper/utils/extensions/navigator_ext.dart';
import 'package:dsm_helper/utils/utils.dart';
import 'package:dsm_helper/widgets/glass/glass_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';

class GuestSaveDialog {
  static Future<bool?> show(BuildContext context, {required Guests guest}) async {
    Utils.vibrate(FeedbackType.warning);
    return await showGlassDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            "暂停虚拟机",
            textAlign: TextAlign.center,
          ),
          content: Text(
            "是否确定要暂停虚拟机${guest.name}？",
          ),
          actions: [
            Row(
              children: [
                Expanded(
                  child: CupertinoButton(
                    onPressed: () async {
                      var hide = showWeuiLoadingToast(context: context);
                      String? res = await guest.save();
                      hide();
                      if (res == true) {
                        Utils.toast("已发送暂停请求");
                        context.pop(true);
                      } else {
                        Utils.toast("暂停请求发送失败");
                      }
                    },
                    color: AppTheme.of(context)?.errorColor,
                    borderRadius: BorderRadius.circular(15),
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      "暂停",
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
