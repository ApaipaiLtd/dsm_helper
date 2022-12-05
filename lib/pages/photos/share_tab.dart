import 'package:dsm_helper/models/photos/album_model.dart';
import 'package:dsm_helper/pages/photos/album_page.dart';
import 'package:dsm_helper/widgets/cupertino_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neumorphic/neumorphic.dart';

class ShareTab extends StatefulWidget {
  const ShareTab({Key key}) : super(key: key);

  @override
  State<ShareTab> createState() => _ShareTabState();
}

class _ShareTabState extends State<ShareTab> {
  bool loading = true;
  List<AlbumModel> albums = [];
  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    albums = await AlbumModel.fetch(additional: ["thumbnail", "sharing_info"], shared: true, sortBy: 'share_modify_time');
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
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
        : ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 20),
            itemBuilder: (context, i) {
              AlbumModel e = albums[i];
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(CupertinoPageRoute(builder: (context) {
                    return AlbumPage(e);
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
            },
            itemCount: albums.length,
          );
  }
}
