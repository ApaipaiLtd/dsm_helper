import 'package:dsm_helper/widgets/glass/glass_app_bar.dart';
import 'package:dsm_helper/widgets/glass/glass_scaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  final String folder;
  Search(this.folder);
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController folderController = TextEditingController();
  List<String> folders = [];
  String pattern = "";
  bool recursive = true;
  bool searchContent = false;

  @override
  void initState() {
    setState(() {
      folders.add(widget.folder);
      folderController.value = TextEditingValue(text: widget.folder);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GlassScaffold(
      appBar: GlassAppBar(
        title: Text("搜索文件"),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: ListView(
          children: [
            TextField(
              onChanged: (v) => pattern = v,
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                labelText: '关键字',
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    searchContent = !searchContent;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  height: 60,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: Row(
                    children: [
                      Text("启用文件内容搜索"),
                      Spacer(),
                      if (searchContent)
                        Icon(
                          CupertinoIcons.checkmark_alt,
                          color: Color(0xffff9813),
                        ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(20),
              ),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: TextField(
                controller: folderController,
                enabled: false,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  labelText: '所在位置',
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            CupertinoButton(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(20),
              onPressed: () {
                Navigator.of(context).pop({"folders": folders, "pattern": pattern, "search_content": searchContent});
                // Navigator.of(context).push(CupertinoPageRoute(
                //     builder: (context) {
                //       return SearchResult(
                //         folders,
                //         pattern,
                //         searchContent: searchContent,
                //       );
                //     },
                //     settings: RouteSettings(name: "search_result")));
              },
              child: Text(
                ' 搜索 ',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
