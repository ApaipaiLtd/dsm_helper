import 'package:dsm_helper/models/photos/album_model.dart';
import 'package:dsm_helper/models/photos/folder_model.dart';
import 'package:dsm_helper/models/photos/general_tag_model.dart';
import 'package:dsm_helper/models/photos/geocoding_model.dart';
import 'package:dsm_helper/models/photos/photo_model.dart';
import 'package:dsm_helper/pages/photos/widgets/thumbnail_card.dart';
import 'package:dsm_helper/widgets/cupertino_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neumorphic/neumorphic.dart';

class Folder extends StatefulWidget {
  const Folder(this.isTeam, {Key key}) : super(key: key);
  final bool isTeam;
  @override
  State<Folder> createState() => FolderState();
}

class FolderState extends State<Folder> {
  bool loading = true;
  FolderModel root;
  bool isTeam = false;
  double folderWidth;
  @override
  void initState() {
    isTeam = widget.isTeam;
    getData(isTeam: isTeam);
    super.initState();
  }

  Future getData({bool isTeam: false}) async {
    this.isTeam = isTeam;
    try {
      root = await FolderModel.fetch(additional: ['access_permission'], isTeam: isTeam);
      await root.fetchFolders(additional: ["thumbnail"], isTeam: isTeam);
      setState(() {
        loading = false;
      });
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    if (folderWidth == null) {
      folderWidth = (MediaQuery.of(context).size.width - 80) / 3;
    }
    return loading
        ? Center(
            child: NeuCard(
              padding: EdgeInsets.all(50),
              curveType: CurveType.flat,
              decoration: NeumorphicDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(20),
              ),
              bevel: 20,
              child: CupertinoActivityIndicator(
                radius: 14,
              ),
            ),
          )
        : Container(
            child: ListView(
              padding: EdgeInsets.all(20),
              children: [
                Wrap(
                  runSpacing: 20,
                  spacing: 20,
                  children: root.folders.map((folder) {
                    return _buildFolderItem(folder);
                  }).toList(),
                ),
              ],
            ),
          );
  }

  Widget _buildFolderItem(FolderModel folder) {
    return GestureDetector(
      onTap: () {
        // Navigator.of(context).push(CupertinoPageRoute(
        //   builder: (context) {
        //     return Timeline(
        //       "视频",
        //       category: "Timeline",
        //       type: "video",
        //     );
        //   },
        // ));
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ThumbnailCard(folder.id, folder.additional.thumbnail, width: folderWidth),
          SizedBox(
            height: 5,
          ),
          Text(
            "${folder.lastName}",
            style: TextStyle(fontSize: 14),
            maxLines: 1,
          ),
        ],
      ),
    );
  }
}
