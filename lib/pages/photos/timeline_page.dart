import 'package:dsm_helper/pages/photos/timeline.dart';

import 'package:flutter/material.dart';

class TimelinePage extends StatefulWidget {
  const TimelinePage({this.title, this.type, this.geocodingId, this.generalTagId, this.isTeam = false, this.recentlyAdd = false, super.key});
  final String? title;
  final String? type;
  final num? geocodingId;
  final bool isTeam;
  final int? generalTagId;
  final bool recentlyAdd;
  @override
  State<TimelinePage> createState() => _TimelinePageState();
}

class _TimelinePageState extends State<TimelinePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title!),
      ),
      body: Timeline(
        widget.isTeam,
        type: widget.type!,
        geocodingId: widget.geocodingId!,
        generalTagId: widget.generalTagId!,
        recentlyAdd: widget.recentlyAdd,
      ),
    );
  }
}
