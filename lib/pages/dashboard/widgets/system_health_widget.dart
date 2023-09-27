import 'package:dsm_helper/apis/api.dart';
import 'package:dsm_helper/models/Syno/Core/Desktop/InitData.dart';
import 'package:dsm_helper/models/Syno/Core/System.dart';
import 'package:dsm_helper/pages/control_panel/info/info.dart';
import 'package:dsm_helper/pages/dashboard/widgets/widget_card.dart';
import 'package:dsm_helper/providers/init_data_provider.dart';
import 'package:dsm_helper/providers/system_info_provider.dart';
import 'package:dsm_helper/providers/wallpaper.dart';
import 'package:dsm_helper/utils/utils.dart' hide Api;
import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SystemHealthWidget extends StatelessWidget {
  const SystemHealthWidget({super.key});

  @override
  Widget build(BuildContext context) {
    System system = context.watch<SystemInfoProvider>().systemInfo;
    InitDataModel initData = context.watch<InitDataProvider>().initData;
    bool showWallpaper = context.watch<WallpaperProvider>().showWallpaper;
    return WidgetCard(
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 5),
        child: Row(
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/icons/system_name.png",
                    width: 20,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "系统名称",
                        style: TextStyle(color: Color(0x99000000), fontSize: 16),
                      ),
                      Text(
                        "${initData.session?.hostname}",
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              height: 30,
              width: 1,
              margin: EdgeInsets.symmetric(horizontal: 16),
              color: Theme.of(context).dividerTheme.color,
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/icons/system_up_time.png",
                    width: 20,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "运行时间",
                        style: TextStyle(color: Color(0x99000000), fontSize: 16),
                      ),
                      Text(
                        "${Utils.parseOpTime(system.upTime!)}",
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
    return GestureDetector(
      onTap: () {
        if (Utils.notReviewAccount)
          Navigator.of(context).push(CupertinoPageRoute(builder: (context) {
            return SystemInfo(0);
          }));
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Stack(
          children: [
            if (showWallpaper && initData.userSettings?.desktop?.wallpaper != null && (initData.userSettings!.desktop!.wallpaper!.customizeBackground! || initData.userSettings!.desktop!.wallpaper!.customizeBackground!))
              ExtendedImage.network(
                "${Api.dsm.baseUrl}/webapi/entry.cgi?api=SYNO.Core.PersonalSettings&method=wallpaper&version=1&path=%22%22&retina=true&_sid=${Api.dsm.sid}",
                height: 170,
                width: double.infinity,
                fit: BoxFit.cover,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(20),
              ),
            if (Theme.of(context).brightness == Brightness.dark)
              Container(
                height: 170,
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Padding(
                padding: EdgeInsets.all(20),
                child: DefaultTextStyle(
                  style: TextStyle(
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        color: Color.fromARGB(80, 0, 0, 0),
                        blurRadius: 5,
                      )
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            "assets/icons/info.png",
                            width: 26,
                            height: 26,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "系统状态",
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      if (system.model != null)
                        Padding(
                          padding: EdgeInsets.only(top: 5),
                          child: Row(
                            children: [
                              Text("产品型号："),
                              Text("${system.model}"),
                            ],
                          ),
                        ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Text("系统名称："),
                          Text("${initData.session?.hostname}"),
                        ],
                      ),
                      if (system.sysTemp != null)
                        Padding(
                          padding: EdgeInsets.only(top: 5),
                          child: Row(
                            children: [
                              Text("散热状态："),
                              Text(
                                "${system.sysTemp}℃ ${system.temperatureWarning == null ? (system.sysTemp! > 80 ? "警告" : "正常") : (system.temperatureWarning! ? "警告" : "正常")}",
                                style: TextStyle(color: system.temperatureWarning == null ? (system.sysTemp! > 80 ? Colors.red : Colors.green) : (system.temperatureWarning! ? Colors.red : Colors.green)),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      if (system.upTime != null && system.upTime != "")
                        Padding(
                          padding: EdgeInsets.only(top: 5),
                          child: Row(
                            children: [
                              Text("运行时间："),
                              Text("${Utils.parseOpTime(system.upTime!)}"),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
