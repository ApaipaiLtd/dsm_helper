import 'package:dsm_helper/models/Syno/FileStation/Sharing.dart';
import 'package:dsm_helper/pages/file/enums/share_link_status_enums.dart';
import 'package:dsm_helper/pages/file/share.dart';
import 'package:dsm_helper/utils/extensions/navigator_ext.dart';
import 'package:dsm_helper/utils/utils.dart';
import 'package:dsm_helper/widgets/file_icon.dart';
import 'package:dsm_helper/widgets/glass/glass_app_bar.dart';
import 'package:dsm_helper/widgets/glass/glass_scaffold.dart';
import 'package:dsm_helper/widgets/label.dart';
import 'package:dsm_helper/widgets/loading_widget.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ShareManager extends StatefulWidget {
  @override
  _ShareManagerState createState() => _ShareManagerState();
}

class _ShareManagerState extends State<ShareManager> {
  bool loading = true;
  Sharing sharing = Sharing();
  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    // try {
    sharing = await Sharing.list();
    setState(() {
      loading = false;
    });
    // } catch (e) {
    //   print(e);
    // }
  }

  Widget _buildLinkItem(ShareLinks link) {
    return GestureDetector(
      onTap: () {
        context.push(Share(shareLink: link), name: "share");
      },
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                FileIcon(
                  link.fileType,
                  thumb: link.path!,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  link.name!,
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Label(
                  link.statusEnum.label,
                  link.statusEnum == ShareLinkStatusEnum.valid
                      ? Colors.green
                      : link.statusEnum == ShareLinkStatusEnum.expired
                          ? Colors.red
                          : Colors.grey,
                ),
                SizedBox(
                  width: 5,
                ),
                link.enableUpload!
                    ? Label(
                        "文件请求",
                        Colors.lightBlueAccent,
                        fill: true,
                      )
                    : Label(
                        "共享链接",
                        Colors.greenAccent,
                        fill: true,
                      ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GlassScaffold(
      appBar: GlassAppBar(
        title: Text("共享链接管理"),
      ),
      body: loading
          ? Center(
              child: LoadingWidget(size: 30),
            )
          : ListView.builder(
              itemBuilder: (context, i) {
                return _buildLinkItem(sharing.links![i]);
              },
              itemCount: sharing.links!.length,
            ),
    );
  }
}
