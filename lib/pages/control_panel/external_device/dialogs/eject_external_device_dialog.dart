import 'package:cool_ui/cool_ui.dart';
import 'package:dsm_helper/models/Syno/Core/ExternalDevice/Storage/Device.dart';
import 'package:dsm_helper/models/Syno/Core/Share.dart';
import 'package:dsm_helper/pages/dashboard/bus/eject_external_device_bus.dart';
import 'package:dsm_helper/themes/app_theme.dart';
import 'package:dsm_helper/utils/bus/bus.dart';
import 'package:dsm_helper/utils/extensions/navigator_ext.dart';
import 'package:dsm_helper/utils/utils.dart';
import 'package:dsm_helper/widgets/glass/glass_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';

class EjectExternalDeviceDialog {
  static Future<bool?> show({required BuildContext context, required ExternalDevices device}) async {
    Utils.vibrate(FeedbackType.warning);
    return await showGlassDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            "弹出外接设备${device.devTitle}",
            textAlign: TextAlign.center,
          ),
          content: Text(
            "您确定要弹出此设备吗？",
          ),
          actions: [
            Row(
              children: [
                Expanded(
                  child: CupertinoButton(
                    onPressed: () async {
                      var hide = showWeuiLoadingToast(context: context);
                      bool? res = await device.eject();
                      hide();
                      if (res == true) {
                        Utils.vibrate(FeedbackType.success);
                        Utils.toast("弹出成功");
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
                      "确认弹出",
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
                      bus.fire(EjectExternalDeviceEvent());
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
