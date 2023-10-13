import 'package:dsm_helper/pages/applications/application_enums.dart';
import 'package:dsm_helper/pages/applications/widgets/application_item_widget.dart';
import 'package:dsm_helper/providers/init_data_provider.dart';
import 'package:dsm_helper/utils/extensions/media_query_ext.dart';
import 'package:dsm_helper/widgets/glass/glass_app_bar.dart';
import 'package:dsm_helper/widgets/glass/glass_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Applications extends StatefulWidget {
  const Applications({super.key});

  @override
  State<Applications> createState() => _ApplicationsState();
}

class _ApplicationsState extends State<Applications> {
  @override
  Widget build(BuildContext context) {
    InitDataProvider initDataProvider = context.watch<InitDataProvider>();
    List<String> applications = initDataProvider.initData.userSettings?.desktop?.validAppviewOrder ?? initDataProvider.initData.userSettings?.desktop?.appviewOrder ?? [];
    applications = applications.where((element) => ApplicationEnum.values.any((enums) => enums.packageName == element)).toList();
    return GlassScaffold(
      appBar: GlassAppBar(
        title: Text("应用"),
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: context.width ~/ 120),
          itemBuilder: (context, i) {
            return ApplicationItemWidget(applications[i]);
          },
          itemCount: applications.length,
        ),
      ),
    );
  }
}
