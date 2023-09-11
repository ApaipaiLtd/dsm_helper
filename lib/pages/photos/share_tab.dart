import 'package:dsm_helper/models/photos/album_model.dart';
import 'package:dsm_helper/pages/photos/album_page.dart';
import 'package:dsm_helper/widgets/cupertino_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ShareTab extends StatefulWidget {
  const ShareTab({super.key});

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
            padding: EdgeInsets.symmetric(horizontal: 20),
            itemBuilder: (context, i) {
              AlbumModel album = albums[i];
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(CupertinoPageRoute(builder: (context) {
                    return AlbumPage(album);
                  }));
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Stack(
                      children: [
                        Hero(
                          tag: album.additional!.thumbnail!,
                          child: CupertinoExtendedImage(
                            album.additional!.thumbnail!.thumbUrl(),
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
                                    album.name!,
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  Row(
                                    children: [
                                      if (album.shared!) ...[
                                        if (album.additional!.sharingInfo!.enablePassword!)
                                          Icon(
                                            CupertinoIcons.lock,
                                            color: Colors.white,
                                            size: 16,
                                          ),
                                        Text(album.shareText),
                                        Text("，"),
                                      ],
                                      Text("${album.itemCount}张照片"),
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
