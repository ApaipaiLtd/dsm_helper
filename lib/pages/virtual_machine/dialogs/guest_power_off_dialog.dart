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

class GuestPowerOffDialog {
  static Future<bool?> show(BuildContext context, {required Guests guest, required String action}) async {
    Utils.vibrate(FeedbackType.warning);
    return await showGlassDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            action == "reboot" ? "重新启动" : "确认关机",
            textAlign: TextAlign.center,
          ),
          content: Text(
            action == "reboot"
                ? "虚拟机${guest.name}将重新启动，是否确定要继续？"
                : action == "poweroff"
                    ? "如果您强制关闭虚拟机${guest.name}，可能出现数据丟失或文件系统错误。是否确定继续？"
                    : "虚拟机${guest.name}将关闭。是否确定要继续？",
          ),
          actions: [
            Row(
              children: [
                Expanded(
                  child: CupertinoButton(
                    onPressed: () async {
                      var hide = showWeuiLoadingToast(context: context);
                      bool? res = await guest.power(action);
                      hide();
                      if (res == true) {
                        Utils.toast("已发送${action == "reboot" ? "重新启动" : "关机"}请求");
                        context.pop(true);
                      } else {
                        Utils.toast("${action == "reboot" ? "重新启动" : "关机"}请求发送失败");
                      }
                    },
                    color: AppTheme.of(context)?.errorColor,
                    borderRadius: BorderRadius.circular(15),
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      action == "reboot"
                          ? "重新启动"
                          : action == "poweroff"
                              ? "强制关机"
                              : "关机",
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
