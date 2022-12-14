import 'package:draggable_scrollbar/draggable_scrollbar.dart';
import 'package:dsm_helper/models/photos/photo_model.dart';
import 'package:dsm_helper/models/photos/timeline_model.dart';
import 'package:dsm_helper/pages/common/image_preview.dart';
import 'package:dsm_helper/pages/common/video_player.dart';
import 'package:dsm_helper/widgets/cupertino_image.dart';
import 'package:dsm_helper/widgets/transparent_router.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neumorphic/neumorphic.dart';

class Timeline extends StatefulWidget {
  const Timeline(this.isTeam, {this.type, this.geocodingId, this.generalTagId, this.recentlyAdd: false, Key key}) : super(key: key);
  final bool isTeam;
  final String type;
  final int geocodingId;
  final int generalTagId;
  final bool recentlyAdd;
  @override
  State<Timeline> createState() => TimelineState();
}

class TimelineState extends State<Timeline> {
  ScrollController _scrollController = ScrollController();
  bool loading = true;
  double photoWidth;
  List<TimelineModel> timelines = [];
  List<Day> days = [];
  List<int> itemTypes = [];
  bool isTeam = false;
  @override
  void initState() {
    isTeam = widget.isTeam;
    getData(isTeam: isTeam);
    super.initState();
  }

  Future getData({bool isTeam}) async {
    setState(() {
      this.isTeam = isTeam;
      loading = true;
    });
    days = [];
    timelines = await TimelineModel.fetch(
      isTeam: isTeam,
      type: widget.type,
      itemTypes: itemTypes,
      geocodingId: widget.geocodingId,
      generalTagId: widget.generalTagId,
      recentlyAdd: widget.recentlyAdd,
    );
    for (var timeline in timelines) {
      days.addAll(timeline.days);
    }
    for (int i = 0; i < days.length; i++) {
      int rowCount = (days[i].itemCount / 4).ceil();
      double height = 40 + rowCount * photoWidth + (rowCount - 1) * 2;
      days[i].startPosition = i == 0 ? 0 : days[i - 1].endPosition;
      days[i].endPosition = days[i].startPosition + height;
    }
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (photoWidth == null) {
      photoWidth = (MediaQuery.of(context).size.width - 6) / 4;
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
        : days.length > 0
            ? DraggableScrollbar.semicircle(
                labelTextBuilder: (position) {
                  var line = days.where((day) => day.startPosition <= position && day.endPosition >= position).toList();
                  if (line.length > 0) {
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "${line[0].month}月",
                            style: TextStyle(fontSize: 30),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("${line[0].day.toString().padLeft(2, "0")}日"),
                              Text("${line[0].year}"),
                            ],
                          )
                        ],
                      ),
                    );
                  } else {
                    return null;
                  }
                },
                labelConstraints: BoxConstraints(minHeight: 60, maxHeight: 60, minWidth: 140, maxWidth: 140),
                controller: _scrollController,
                child: ListView.builder(
                  controller: _scrollController,
                  itemBuilder: (context, i) {
                    return _buildTimelineItem(days[i]);
                  },
                  itemCount: days.length,
                ),
              )
            : Center(
                child: Text("无项目"),
              );
  }

  Widget _buildTimelineItem(Day day) {
    if (day.photos == null) {
      day
          .fetchPhotos(
        isTeam: isTeam,
        type: widget.type,
        itemTypes: itemTypes,
        geocodingId: widget.geocodingId,
        generalTagId: widget.generalTagId,
        recentlyAdd: widget.recentlyAdd,
      )
          .then((_) {
        setState(() {});
      });
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          alignment: Alignment.centerLeft,
          height: 40,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Text(
                "${day.year}-${day.month.toString().padLeft(2, "0")}-${day.day.toString().padLeft(2, "0")}",
              ),
              // if (line['location'] != null && ((line['location']['first_level'] != null && line['location']['first_level'] != ""))) Text("   ${line['location']['first_level']}"),
              // if (line['location'] != null && ((line['location']['second_level'] != null && line['location']['second_level'].length > 0))) Text("${line['location']['second_level'].join(",")}"),
            ],
          ),
        ),
        Wrap(
          spacing: 2,
          runSpacing: 2,
          children: day.photos == null
              ? List.generate(day.itemCount, (index) {
                  return Container(
                    color: Color(0xffE9E9E9),
                    width: photoWidth,
                    height: photoWidth,
                  );
                })
              : day.photos.map((item) {
                  return _buildPhotoItem(item, day.photos);
                }).toList(),
        ),
      ],
    );
  }

  Widget _buildPhotoItem(PhotoModel photo, List<PhotoModel> photos) {
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
        width: photoWidth,
        height: photoWidth,
        child: Stack(
          children: [
            Hero(
              tag: photo,
              child: CupertinoExtendedImage(
                photo.thumbUrl(isTeam: isTeam),
                width: photoWidth,
                height: photoWidth,
                fit: BoxFit.cover,
                placeholder: Container(
                  width: photoWidth,
                  height: photoWidth,
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
      ),
    );
  }
}
