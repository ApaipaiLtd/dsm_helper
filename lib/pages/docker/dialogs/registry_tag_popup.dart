import 'dart:ui';

import 'package:dsm_helper/models/Syno/Docker/DockerRegistry.dart';
import 'package:dsm_helper/models/Syno/Docker/Registry/RegistryTag.dart';
import 'package:dsm_helper/utils/extensions/media_query_ext.dart';
import 'package:dsm_helper/utils/extensions/navigator_ext.dart';
import 'package:dsm_helper/widgets/empty_widget.dart';
import 'package:dsm_helper/widgets/loading_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RegistryTagList extends StatefulWidget {
  final DockerRegistryData registry;
  const RegistryTagList(this.registry, {super.key});

  @override
  State<RegistryTagList> createState() => _RegistryTagListState();
}

class _RegistryTagListState extends State<RegistryTagList> {
  bool loading = true;
  List<RegistryTag> tags = [];
  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    tags = await RegistryTag.tags(repo: widget.registry.name!);
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(22))),
        child: SafeArea(
          top: false,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  "选择标签",
                  style: Theme.of(context).appBarTheme.titleTextStyle,
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: context.height * 0.4,
                  child: loading
                      ? LoadingWidget(size: 30)
                      : tags.isNotEmpty
                          ? ListView.separated(
                              padding: EdgeInsets.zero,
                              itemCount: tags.length,
                              itemBuilder: (context, i) {
                                return GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  onTap: () {
                                    context.pop(tags[i].tag!);
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(vertical: 12),
                                    child: Text(
                                      tags[i].tag!,
                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                    ),
                                  ),
                                );
                              },
                              separatorBuilder: (context, i) {
                                return Divider(
                                  height: 1,
                                  indent: 0,
                                  endIndent: 0,
                                );
                              },
                            )
                          : EmptyWidget(
                              size: 150,
                              text: "未查询到标签",
                            ),
                ),
                SizedBox(
                  height: 16,
                ),
                Container(
                  width: double.infinity,
                  child: CupertinoButton(
                    onPressed: () async {
                      Navigator.of(context).pop();
                    },
                    color: Theme.of(context).disabledColor,
                    borderRadius: BorderRadius.circular(15),
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      "关闭",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SelectRegistryTagPopup {
  static Future<String?> show({required BuildContext context, required DockerRegistryData registry}) async {
    return await showCupertinoModalPopup(
      context: context,
      // barrierColor: Colors.black12,
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      builder: (context) {
        return RegistryTagList(registry);
      },
    );
  }
}
