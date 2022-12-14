import 'package:dsm_helper/models/photos/photo_model.dart';
import 'package:dsm_helper/pages/common/image_preview.dart';
import 'package:dsm_helper/pages/common/video_player.dart';
import 'package:dsm_helper/widgets/cupertino_image.dart';
import 'package:dsm_helper/widgets/transparent_router.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PhotoItemWidget extends StatelessWidget {
  const PhotoItemWidget(this.photo, this.photos, {this.isTeam, this.showName: true, @required this.width, Key key}) : super(key: key);
  final PhotoModel photo;
  final List<PhotoModel> photos;
  final bool isTeam;
  final double width;
  final bool showName;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (photo.type == 'video') {
          Navigator.of(context).push(CupertinoPageRoute(builder: (context) {
            return VideoPlayer(
              url: photo.videoUrl(isTeam: isTeam),
              cover: photo.thumbUrl(isTeam: isTeam),
            );
          }));
        } else {
          Navigator.of(context).push(TransparentPageRoute(
            pageBuilder: (context, _, __) {
              return ImagePreview(
                photos.map((photo) => photo.thumbUrl(size: 'xl', isTeam: isTeam)).toList(),
                photos.indexOf(photo),
                tag: photo,
              );
            },
          ));
        }
      },
      child: Container(
        width: width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Hero(
                  tag: photo,
                  child: CupertinoExtendedImage(
                    photo.thumbUrl(isTeam: isTeam),
                    width: width,
                    height: width,
                    fit: BoxFit.cover,
                    boxShape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(10),
                    placeholder: Container(
                      color: Color(0xffE9E9E9),
                    ),
                  ),
                ),
                if (photo.type == "video")
                  Align(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.play_circle_fill,
                          color: Colors.white,
                          size: 40,
                        ),
                        SizedBox(height: 5),
                        Text(
                          "${photo.additional.videoMeta.hours.toString().padLeft(2, "0")}:${photo.additional.videoMeta.minutes.toString().padLeft(2, "0")}:${photo.additional.videoMeta.seconds.toString().padLeft(2, "0")}",
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ],
                    ),
                  )
              ],
            ),
            if (showName)
              Text(
                photo.filename,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
          ],
        ),
      ),
    );
  }
}
