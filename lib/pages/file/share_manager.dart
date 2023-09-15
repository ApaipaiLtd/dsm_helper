import 'package:dsm_helper/pages/file/share.dart';
import 'package:dsm_helper/utils/utils.dart';
import 'package:dsm_helper/widgets/file_icon.dart';
import 'package:dsm_helper/widgets/label.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class ShareManager extends StatefulWidget {
  @override
  _ShareManagerState createState() => _ShareManagerState();
}

class _ShareManagerState extends State<ShareManager> {
  List links = [];
  bool loading = true;
  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    var res = await Api.listShare();
    print(res);
    if (res['success']) {
      setState(() {
        loading = false;
        links = res['data']['links'];
      });
    }
  }

  Widget _buildLinkItem(link) {
    FileTypeEnum fileType = Utils.fileType(link['path']);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: CupertinoButton(
        onPressed: () {
          Navigator.of(context)
              .push(CupertinoPageRoute(
                  builder: (context) {
                    return Share(
                      link: link,
                    );
                  },
                  settings: RouteSettings(name: "share")))
              .then((res) {
            setState(() {
              loading = true;
            });
            getData();
          });
        },
        padding: EdgeInsets.all(22),

          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                link['isFolder']
                    ? Image.asset(
                        "assets/icons/folder.png",
                        width: 20,
                      )
                    : FileIcon(
                        fileType,
                        thumb: link['path'],
                      ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  link['name'],
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
                    link['status'] == "valid"
                        ? "有效"
                        : link['status'] == "expired"
                            ? "过期"
                            : link['status'] == "inactive"
                                ? "未生效"
                                : link['status'],
                    link['status'] == "valid" ? Colors.green : Colors.red),
                SizedBox(
                  width: 5,
                ),
                link['enable_upload']
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
    return Scaffold(
      appBar: AppBar(

        title: Text(
          "共享链接管理",
        ),
      ),
      body: loading
          ? Center(
              child: Container(
                padding: EdgeInsets.all(50),
                
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(20),
                ),

                child: CupertinoActivityIndicator(
                  radius: 14,
                ),
              ),
            )
          : ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              itemBuilder: (context, i) {
                return _buildLinkItem(links[i]);
              },
              itemCount: links.length,
            ),
    );
  }
}
