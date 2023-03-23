import 'package:dsm_helper/models/photos/album_model.dart';
import 'package:dsm_helper/models/photos/general_tag_model.dart';
import 'package:dsm_helper/models/photos/geocoding_model.dart';
import 'package:dsm_helper/models/photos/photo_model.dart';
import 'package:dsm_helper/pages/photos/album_page.dart';
import 'package:dsm_helper/pages/photos/general_tag_page.dart';
import 'package:dsm_helper/pages/photos/geocoding_page.dart';
import 'package:dsm_helper/pages/photos/timeline_page.dart';
import 'package:dsm_helper/pages/photos/widgets/thumbnail_card.dart';
import 'package:dsm_helper/widgets/cupertino_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AlbumTab extends StatefulWidget {
  const AlbumTab(this.isTeam, {Key key}) : super(key: key);
  final bool isTeam;
  @override
  State<AlbumTab> createState() => AlbumTabState();
}

class AlbumTabState extends State<AlbumTab> {
  bool isTeam = false;
  List<AlbumModel> albums = [];
  List<PhotoModel> recentlyAdds = [];
  List<PhotoModel> videos = [];
  List<GeocodingModel> geocodings = [];
  List<GeneralTagModel> generalTags = [];
  double albumWidth;
  @override
  void initState() {
    isTeam = widget.isTeam;
    getData(isTeam: isTeam);
    getAlbum();
    super.initState();
  }

  getData({bool isTeam: false}) {
    this.isTeam = isTeam;
    setState(() {
      recentlyAdds = [];
      videos = [];
      geocodings = [];
      generalTags = [];
    });
    getRecently();
    getVideos();
    getGeocoding();
    getGeneral();
  }

  getAlbum() async {
    albums = await AlbumModel.fetch(additional: ["sharing_info", "thumbnail"], limit: 100, isTeam: isTeam);
    debugPrint("相册：${albums.length}");
    setState(() {});
  }

  getRecently() async {
    recentlyAdds = await PhotoModel.recentlyAdd(limit: 4, isTeam: isTeam, additional: ['thumbnail'], type: 'photo');
    debugPrint("最近添加：${recentlyAdds.length}");
    setState(() {});
  }

  getVideos() async {
    videos = await PhotoModel.fetch(limit: 4, isTeam: isTeam, additional: ['thumbnail'], type: 'video');
    debugPrint("视频：${recentlyAdds.length}");
    setState(() {});
  }

  getShares() async {}
  getGeocoding() async {
    geocodings = await GeocodingModel.fetch(limit: 4, isTeam: isTeam, additional: ['thumbnail']);
    debugPrint("位置：${recentlyAdds.length}");
    setState(() {});
  }

  getGeneral() async {
    generalTags = await GeneralTagModel.fetch(limit: 4, isTeam: isTeam, additional: ['thumbnail']);
    debugPrint("标签：${recentlyAdds.length}");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (albumWidth == null) {
      albumWidth = (MediaQuery.of(context).size.width - 82) / 3;
    }
    return ListView(
      padding: EdgeInsets.all(20),
      children: [
        Wrap(
          runSpacing: 20,
          spacing: 20,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(CupertinoPageRoute(builder: (context) {
                  return GeocodingPage(isTeam);
                }));
              },
              behavior: HitTestBehavior.opaque,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ThumbnailCard(
                    geocodings.map((e) => e.additional.thumbnail).toList(),
                    width: albumWidth,
                    isTeam: isTeam,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "位置",
                    style: TextStyle(fontSize: 14),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(CupertinoPageRoute(builder: (context) {
                  return GeneralTagPage(isTeam);
                }));
              },
              behavior: HitTestBehavior.opaque,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ThumbnailCard(
                    generalTags.map((e) => e.additional.thumbnail).toList(),
                    width: albumWidth,
                    isTeam: isTeam,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "标签",
                    style: TextStyle(fontSize: 14),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(CupertinoPageRoute(builder: (context) {
                  return TimelinePage(title: "视频", type: 'video', isTeam: widget.isTeam);
                }));
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ThumbnailCard(
                    videos.map((e) => e.additional.thumbnail).toList(),
                    width: albumWidth,
                    isTeam: isTeam,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "视频",
                    style: TextStyle(fontSize: 14),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(CupertinoPageRoute(builder: (context) {
                  return TimelinePage(title: "最近添加", isTeam: widget.isTeam, recentlyAdd: true);
                }));
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ThumbnailCard(
                    recentlyAdds.map((e) => e.additional.thumbnail).toList(),
                    width: albumWidth,
                    isTeam: isTeam,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "最近添加",
                    style: TextStyle(fontSize: 14),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        ...albums.map((e) {
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(CupertinoPageRoute(builder: (context) {
                return AlbumPage(
                  e,
                  isTeam: isTeam,
                );
              }));
            },
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Stack(
                  children: [
                    Hero(
                      tag: e.additional.thumbnail,
                      child: CupertinoExtendedImage(
                        e.additional.thumbnail.thumbUrl(),
                        width: MediaQuery.of(context).size.width - 40,
                        height: 200,
                        fit: BoxFit.cover,
                        placeholder: Container(
                          color: Color(0xffE9E9E9),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 0,
                      bottom: 0,
                      child: Container(
                        width: MediaQuery.of(context).size.width - 40,
                        padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.transparent, Colors.black26],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                        child: DefaultTextStyle(
                          style: TextStyle(color: Colors.white),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                e.name,
                                style: TextStyle(fontSize: 16),
                              ),
                              Row(
                                children: [
                                  if (e.shared) ...[
                                    if (e.additional.sharingInfo.enablePassword)
                                      Icon(
                                        CupertinoIcons.lock,
                                        color: Colors.white,
                                        size: 16,
                                      ),
                                    Text(e.shareText),
                                    Text("，"),
                                  ],
                                  Text("${e.itemCount}张照片"),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ],
    );
  }
}
