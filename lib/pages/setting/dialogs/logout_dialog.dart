import 'package:cool_ui/cool_ui.dart';
import 'package:dsm_helper/models/Syno/Api/auth.dart';
import 'package:dsm_helper/pages/server/select_server.dart';
import 'package:dsm_helper/themes/app_theme.dart';
import 'package:dsm_helper/utils/extensions/navigator_ext.dart';
import 'package:dsm_helper/utils/utils.dart';
import 'package:dsm_helper/widgets/glass/glass_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:fluwx/fluwx.dart';
import 'package:sp_util/sp_util.dart';

class LogoutConfirmDialog extends StatefulWidget {
  final bool otpEnable;
  const LogoutConfirmDialog(this.otpEnable, {super.key});

  @override
  State<LogoutConfirmDialog> createState() => _LogoutConfirmDialogState();
}

class _LogoutConfirmDialogState extends State<LogoutConfirmDialog> {
  bool forget = false;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        "退出登录",
        textAlign: TextAlign.center,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("确定要退出当前账号吗？"),
          // if (widget.otpEnable)
          Padding(
            padding: EdgeInsets.only(top: 14),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  forget = !forget;
                });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: forget ? AppTheme.of(context)?.primaryColor : Theme.of(context).disabledColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    width: 20,
                    height: 20,
                    alignment: Alignment.center,
                    child: forget
                        ? Image.asset(
                            "assets/icons/check.png",
                            width: 13,
                            height: 13,
                          )
                        : null,
                  ),
                  SizedBox(width: 10),
                  Text(
                    "取消记住本设备",
                    style: TextStyle(color: AppTheme.of(context)?.placeholderColor),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      actions: [
        Row(
          children: [
            Expanded(
              child: CupertinoButton(
                onPressed: () async {
                  var hide = showWeuiLoadingToast(context: context);
                  try {
                    if (forget) {
                      await Auth.forget();
                    }
                    await Auth.logout();
                  } catch (e) {}
                  hide();
                  // Utils.removeStorage("smid");
                  context.push(SelectServer(), name: "select_server", replace: true);
                },
                color: AppTheme.of(context)?.errorColor,
                borderRadius: BorderRadius.circular(15),
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  "退出登录",
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
  }
}

class LogoutDialog {
  static Future<bool?> show({required BuildContext context, bool otpEnable = true}) async {
    Utils.vibrate(FeedbackType.warning);
    return await showGlassDialog(
      context: context,
      builder: (context) {
        return LogoutConfirmDialog(otpEnable);
      },
    );
  }
}
