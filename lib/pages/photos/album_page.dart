import 'package:dsm_helper/models/photos/album_model.dart';
import 'package:dsm_helper/models/photos/photo_model.dart';
import 'package:dsm_helper/pages/photos/widgets/photo_item_widget.dart';
import 'package:dsm_helper/widgets/cupertino_image.dart';
import 'package:dsm_helper/widgets/neu_back_button.dart';
import 'package:flutter/material.dart';

class AlbumPage extends StatefulWidget {
  const AlbumPage(this.album, {this.isTeam: false, Key key}) : super(key: key);
  final AlbumModel album;
  final bool isTeam;
  @override
  State<AlbumPage> createState() => _AlbumPageState();
}

class _AlbumPageState extends State<AlbumPage> {
  double photoWidth;
  List<PhotoModel> photos = [];
  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    photos = await PhotoModel.fetch(
      additional: ["thumbnail", "resolution", "orientation", "video_convert", "video_meta", "provider_user_id"],
      albumId: widget.album.id,
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (photoWidth == null) {
      photoWidth = (MediaQuery.of(context).size.width - 16) / 4;
    }
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              leading: AppBackButton(
                context,
                bevel: 0,
              ),
              pinned: true,
              elevation: 0,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  "${widget.album.name}",
                  style: TextStyle(color: Theme.of(context).appBarTheme.titleTextStyle.color, shadows: [BoxShadow(color: Colors.white, offset: Offset(1, 1), blurRadius: 5, spreadRadius: 5)]),
                ),
                centerTitle: true,
                background: Hero(
                  tag: widget.album.additional.thumbnail,
                  child: CupertinoExtendedImage(
                    widget.album.additional.thumbnail.thumbUrl(size: 'lg'),
                    fit: BoxFit.cover,
                    height: 200,
                    placeholder: CupertinoExtendedImage(
                      widget.album.additional.thumbnail.thumbUrl(size: 'sm'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              expandedHeight: 200.0,
            )
          ];
        },
        body: GridView.builder(
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4, mainAxisSpacing: 2, crossAxisSpacing: 2),
          itemBuilder: (context, i) {
            if (photos.length > 0) {
              return PhotoItemWidget(
                photos[i],
                photos,
                showName: false,
                width: photoWidth,
                isTeam: widget.isTeam,
              );
            } else {
              return Container(
                color: Color(0xffE9E9E9),
                width: photoWidth,
                height: photoWidth,
              );
            }
          },
          itemCount: photos.length > 0 ? photos.length : widget.album.itemCount,
        ),
        // body: ListView(
        //   padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        //   children: [
        //     Wrap(
        //       spacing: 2,
        //       runSpacing: 2,
        //       children: photos.length == 0
        //           ? List.generate(widget.album.itemCount, (index) {
        //               return Container(
        //                 color: Color(0xffE9E9E9),
        //                 width: photoWidth,
        //                 height: photoWidth,
        //               );
        //             })
        //           : photos.map((item) {
        //               return PhotoItemWidget(
        //                 item,
        //                 photos,
        //                 showName: false,
        //                 width: photoWidth,
        //                 isTeam: widget.isTeam,
        //               );
        //             }).toList(),
        //     ),
        //     SizedBox(
        //       height: 20,
        //     ),
        //   ],
        // ),
      ),
    );
  }
}
