import 'package:dsm_helper/pages/photos/folder.dart';
import 'package:dsm_helper/pages/photos/timeline.dart';
import 'package:flutter/material.dart';

class PhotoTab extends StatelessWidget {
  const PhotoTab(this.isTeam, this.isTimeline, {this.timelineKey, this.folderKey, Key key}) : super(key: key);
  final bool isTimeline;
  final bool isTeam;
  final GlobalKey<TimelineState> timelineKey;
  final GlobalKey<FolderState> folderKey;
  @override
  Widget build(BuildContext context) {
    if (isTimeline) {
      return Timeline(
        isTeam,
        key: timelineKey,
      );
    } else {
      return Folder(
        isTeam,
        key: folderKey,
      );
    }
  }
}
