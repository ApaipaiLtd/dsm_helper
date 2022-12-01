import 'package:dsm_helper/models/photos/photo_model.dart';
import 'package:dsm_helper/pages/common/image_preview.dart';
import 'package:dsm_helper/pages/common/video_player.dart';
import 'package:dsm_helper/widgets/cupertino_image.dart';
import 'package:dsm_helper/widgets/transparent_router.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PhotoItemWidget extends StatelessWidget {
  const PhotoItemWidget(this.photo, this.photos, {this.isTeam, @required this.width, Key key}) : super(key: key);
  final PhotoModel photo;
  final List<PhotoModel> photos;
  final bool isTeam;
  final double width;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (photo.type == 'video') {
          Navigator.of(context).push(CupertinoPageRoute(builder: (context) {
            //http://pan.apaipai.top:5000/webapi/entry.cgi?item_id=%5B2%5D&api=%22SYNO.Foto.Download%22&method=%22download%22&version=1&SynoToken=YFzOPk0MYT3cw
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
                    // "http://pan.fmtol.com:5000/webapi/entry.cgi?id=${photo['additional']['thumbnail']['unit_id']}&cache_key=%22${photo['additional']['thumbnail']['cache_key']}%22&type=%22unit%22&size=%22sm%22&api=%22${Util.version == 7 ? "Foto" : "Photo"}.Thumbnail%22&method=%22get%22&version=1&_sid=${Util.sid}",
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
