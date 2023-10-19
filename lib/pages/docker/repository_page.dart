import 'package:dsm_helper/models/Syno/Docker/DockerRegistry.dart';
import 'package:dsm_helper/themes/app_theme.dart';
import 'package:dsm_helper/widgets/loading_widget.dart';
import 'package:extended_text/extended_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'dialogs/registry_tag_popup.dart';

class RepositoryPage extends StatefulWidget {
  const RepositoryPage({super.key});

  @override
  State<RepositoryPage> createState() => _RepositoryPageState();
}

class _RepositoryPageState extends State<RepositoryPage> with AutomaticKeepAliveClientMixin {
  bool loading = true;
  DockerRegistry dockerRegistry = DockerRegistry();
  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    dockerRegistry = await DockerRegistry.search();
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return loading
        ? LoadingWidget(size: 30)
        : Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: ListView.separated(
              itemCount: dockerRegistry.data!.length,
              itemBuilder: (context, i) {
                return _buildImageItem(dockerRegistry.data![i]);
              },
              separatorBuilder: (context, i) {
                return SizedBox(height: 10);
              },
            ),
          );
  }

  Widget _buildImageItem(DockerRegistryData registry) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: ExtendedText(
                        "${registry.name}",
                        maxLines: 1,
                        overflowWidget: TextOverflowWidget(
                          position: TextOverflowPosition.middle,
                          align: TextOverflowAlign.right,
                          child: Text(
                            "…",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    if (registry.isOfficial == true)
                      Padding(
                        padding: EdgeInsets.only(left: 5),
                        child: Image.asset(
                          "assets/icons/official.png",
                          width: 16,
                          color: AppTheme.of(context)?.primaryColor,
                        ),
                      ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: Icon(
                        Icons.star,
                        color: Color(0xffffbc00),
                        size: 20,
                      ),
                    ),
                    Text("${registry.starCount}"),
                  ],
                ),
                if (registry.description != null && registry.description != '') ...[
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "${registry.description}",
                    style: TextStyle(
                      color: AppTheme.of(context)?.placeholderColor,
                    ),
                  )
                ],
              ],
            ),
          ),
          CupertinoButton(
            child: Image.asset(
              "assets/icons/download_cloud.png",
              width: 24,
              color: AppTheme.of(context)?.primaryColor,
            ),
            padding: EdgeInsets.zero,
            onPressed: () async {
              String? tag = await SelectRegistryTagPopup.show(context: context, registry: registry);
              if (tag != null && tag.isNotEmpty) {
                registry.pullStart(tag);
              }
            },
          )
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
