import 'package:dsm_helper/pages/applications/application_enums.dart';
import 'package:dsm_helper/pages/common/browser.dart';
import 'package:dsm_helper/themes/app_theme.dart';
import 'package:dsm_helper/utils/extensions/navigator_ext.dart';
import 'package:dsm_helper/widgets/button.dart';
import 'package:flutter/material.dart';

class ApplicationItemWidget extends StatelessWidget {
  final String packageName;
  const ApplicationItemWidget(this.packageName, {super.key});

  @override
  Widget build(BuildContext context) {
    ApplicationEnum applicationEnum = ApplicationEnum.formPackageName(packageName);
    return Button(
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.zero,
      color: AppTheme.of(context)?.cardColor,
      borderRadius: 22,
      onPressed: () {
        if (applicationEnum == ApplicationEnum.xunlei) {
          context.push(Browser(title: "迅雷-远程设备", url: "https://pan.xunlei.com/yc"));
        } else {
          context.pushNamed("/${applicationEnum.icon}");
        }
      },
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/applications/${applicationEnum.iconFolder == null ? '7/' : ''}${applicationEnum.icon}.png",
                  height: 45,
                  width: 45,
                  fit: BoxFit.contain,
                ),
                SizedBox(
                  height: 32,
                  child: Center(
                    child: Text(
                      applicationEnum.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 12, color: Theme.of(context).primaryColor),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // if (appNotify != null && appNotify!['SYNO.SDS.AdminCenter.Application'] != null)
          //   Positioned(
          //     right: 30,
          //     child: Badge(
          //       appNotify!['SYNO.SDS.AdminCenter.Application']['unread'],
          //       size: 20,
          //     ),
          //   ),
        ],
      ),
    );
  }
}
