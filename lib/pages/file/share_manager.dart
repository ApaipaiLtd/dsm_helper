import 'package:dsm_helper/models/Syno/FileStation/Sharing.dart';
import 'package:dsm_helper/pages/file/dialogs/clear_invalid_share_dialog.dart';
import 'package:dsm_helper/pages/file/enums/share_link_status_enums.dart';
import 'package:dsm_helper/pages/file/share.dart';
import 'package:dsm_helper/themes/app_theme.dart';
import 'package:dsm_helper/utils/extensions/navigator_ext.dart';
import 'package:dsm_helper/widgets/file_icon.dart';
import 'package:dsm_helper/widgets/glass/glass_app_bar.dart';
import 'package:dsm_helper/widgets/glass/glass_scaffold.dart';
import 'package:dsm_helper/widgets/label.dart';
import 'package:dsm_helper/widgets/loading_widget.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

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
    setState(() {
      loading = true;
    });
    try {
      sharing = await Sharing.list();
      setState(() {
        loading = false;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GlassScaffold(
      appBar: GlassAppBar(
        title: Text("共享链接管理"),
        actions: [
          CupertinoButton(
            child: Image.asset(
              "assets/icons/clean.png",
              width: 24,
              height: 24,
            ),
            onPressed: () async {
              bool? res = await ClearInvalidShareDialog.show(context: context);
              if (res == true) {
                getData();
              }
            },
          )
        ],
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

  Widget _buildLinkItem(ShareLinks link) {
    return Slidable(
      key: ValueKey(link.id!),
      child: GestureDetector(
        onTap: () {
          context.push(Share(shareLink: link), name: "share").then((res) {
            if (res == true) {
              getData();
            }
          });
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
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          link.name!,
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            link.enableUpload! ? Label("文件请求", Colors.lightBlueAccent, fill: true) : Label("共享链接", Colors.greenAccent, fill: true),
                            SizedBox(width: 5),
                            Label(
                              link.statusEnum != ShareLinkStatusEnum.unknown ? link.statusEnum.label : link.status!,
                              link.statusEnum.color,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      endActionPane: ActionPane(
        extentRatio: 0.2,
        motion: ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (context) {},
            flex: 2,
            backgroundColor: AppTheme.of(context)?.errorColor ?? Colors.red,
            foregroundColor: Colors.white,
            icon: Icons.delete_outline_outlined,
            label: '删除',
          ),
        ],
      ),
    );
  }
}
