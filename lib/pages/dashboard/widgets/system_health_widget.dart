import 'package:dsm_helper/models/Syno/Core/Desktop/InitData.dart';
import 'package:dsm_helper/models/Syno/Core/System.dart';
import 'package:dsm_helper/pages/dashboard/widgets/widget_card.dart';
import 'package:dsm_helper/providers/init_data_provider.dart';
import 'package:dsm_helper/providers/system_info_provider.dart';
import 'package:dsm_helper/utils/utils.dart' hide Api;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SystemHealthWidget extends StatelessWidget {
  const SystemHealthWidget({super.key});

  @override
  Widget build(BuildContext context) {
    System system = context.watch<SystemInfoProvider>().systemInfo;
    InitDataModel initData = context.watch<InitDataProvider>().initData;
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
                        "${system.upTime != null ? Utils.parseOpTime(system.upTime!) : '-'}",
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
  }
}
