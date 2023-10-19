import 'package:cool_ui/cool_ui.dart';
import 'package:dsm_helper/apis/dsm_api/dsm_response.dart';
import 'package:dsm_helper/models/Syno/Docker/DockerImage.dart';
import 'package:dsm_helper/themes/app_theme.dart';
import 'package:dsm_helper/utils/utils.dart';
import 'package:dsm_helper/widgets/label.dart';
import 'package:dsm_helper/widgets/loading_widget.dart';
import 'package:extended_text/extended_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImagePage extends StatefulWidget {
  const ImagePage({super.key});

  @override
  State<ImagePage> createState() => _ImagePageState();
}

class _ImagePageState extends State<ImagePage> with AutomaticKeepAliveClientMixin {
  bool loading = true;
  DockerImage dockerImage = DockerImage();
  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    dockerImage = await DockerImage.list();
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return loading
        ? LoadingWidget(
            size: 30,
          )
        : Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: ListView.separated(
              itemCount: dockerImage.images!.length,
              itemBuilder: (context, i) {
                return _buildImageItem(dockerImage.images![i]);
              },
              separatorBuilder: (context, i) {
                return SizedBox(height: 10);
              },
            ),
          );
  }

  Widget _buildImageItem(Images image) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.of(context)?.cardColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ExtendedText(
                    "${image.repository}",
                    maxLines: 2,
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
                  SizedBox(height: 5),
                  Row(
                    children: [
                      if (image.tags != null)
                        ...image.tags!.map(
                          (tag) => Padding(padding: EdgeInsets.only(right: 5), child: Label(tag, AppTheme.of(context)?.primaryColor ?? Colors.blue)),
                        ),
                      Label(Utils.formatSize(image.size!, fixed: 0), AppTheme.of(context)?.successColor ?? Colors.green),
                    ],
                  ),
                  if (image.description != null && image.description != '') ...[
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "${image.description}",
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
                "assets/icons/delete.png",
                width: 24,
              ),
              padding: EdgeInsets.zero,
              onPressed: () async {
                var hide = showWeuiLoadingToast(context: context, message: Text("删除中"));

                DsmResponse res = await image.delete();
                var data = res.data['image_objects'][image.repository][image.tags![0]];
                if (data['error'] == 1200) {
                  Utils.toast("镜像删除成功");
                } else if (data['error'] == 1400) {
                  Utils.toast("容器${data['containers'].join(",")}正在使用此镜像，无法删除");
                } else if (data['error'] == 1401) {
                  Utils.toast("镜像不存在");
                }
                hide();
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
