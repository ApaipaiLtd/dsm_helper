import 'package:dsm_helper/models/photos/folder_model.dart';
import 'package:dsm_helper/pages/photos/widgets/photo_item_widget.dart';
import 'package:dsm_helper/pages/photos/widgets/thumbnail_card.dart';
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
  ScrollController pathScrollController = ScrollController();
  bool loading = true;
  List<FolderModel> folders = [];
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
      folders = [];
      FolderModel root = await FolderModel.fetch(additional: ['access_permission'], isTeam: isTeam);
      folders.add(root);
      fetchFolderDetail(root);
    } catch (e) {
      debugPrint(e);
    }
  }

  Future fetchFolderDetail(FolderModel folder) async {
    setState(() {
      loading = true;
    });
    await Future.wait([
      folder.fetchFolders(additional: isTeam ? ["sharing_info", "access_permission", "thumbnail", "password_verified"] : ["thumbnail"], isTeam: isTeam),
      folder.fetchPhotos(additional: ["thumbnail", "resolution", "orientation", "video_convert", "video_meta"], isTeam: isTeam),
    ]);
    Future.delayed(Duration(milliseconds: 200)).then((_) {
      print(pathScrollController.position.maxScrollExtent);
      pathScrollController.animateTo(pathScrollController.position.maxScrollExtent, duration: Duration(milliseconds: 200), curve: Curves.ease);
    });
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (folderWidth == null) {
      folderWidth = (MediaQuery.of(context).size.width - 82) / 3;
    }
    return Stack(
      children: [
        if (folders.length > 0)
          Column(
            children: [
              Container(
                height: 30,
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                child: ListView.separated(
                  controller: pathScrollController,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, i) {
                    return GestureDetector(
                      onTap: () {
                        fetchFolderDetail(folders[i]);
                        setState(() {
                          folders = folders.sublist(0, i + 1);
                        });
                      },
                      child: Text(
                        folders[i].lastName == "/" ? "全部" : folders[i].lastName,
                        style: TextStyle(color: Color(0xff212121), fontWeight: i == folders.length - 1 ? FontWeight.bold : FontWeight.normal),
                      ),
                    );
                  },
                  itemCount: folders.length,
                  separatorBuilder: (context, i) {
                    return Text(
                      ">",
                      style: TextStyle(color: Color(0xff414b55)),
                    );
                  },
                ),
              ),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  children: [
                    Wrap(
                      runSpacing: 20,
                      spacing: 20,
                      children: [
                        ...folders.last.folders.map((folder) {
                          return _buildFolderItem(folder);
                        }).toList(),
                        ...folders.last.photos.map((photo) {
                          return PhotoItemWidget(
                            photo,
                            folders.last.photos,
                            width: folderWidth,
                            isTeam: isTeam,
                          );
                        }).toList(),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        if (loading)
          Center(
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
      ],
    );
  }

  Widget _buildFolderItem(FolderModel folder) {
    return GestureDetector(
      onTap: () {
        setState(() {
          folders.add(folder);
        });
        fetchFolderDetail(folder);
      },
      child: SizedBox(
        width: folderWidth,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ThumbnailCard(
              folder.additional.thumbnail,
              width: folderWidth,
              folderId: folder.id,
              isTeam: isTeam,
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              "${folder.lastName}",
              style: TextStyle(fontSize: 14),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
