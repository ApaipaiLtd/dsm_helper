import 'package:dsm_helper/models/Syno/Docker/DockerImage.dart';
import 'package:dsm_helper/themes/app_theme.dart';
import 'package:dsm_helper/utils/utils.dart';
import 'package:dsm_helper/widgets/label.dart';
import 'package:dsm_helper/widgets/loading_widget.dart';
import 'package:extended_text/extended_text.dart';
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
        : SafeArea(
            top: false,
            child: ListView.separated(
              padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
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
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
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
                Label(Utils.formatSize(image.size!, fixed: 0, format: 1000), AppTheme.of(context)?.successColor ?? Colors.green),
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
    );
  }

  @override
  bool get wantKeepAlive => true;
}
