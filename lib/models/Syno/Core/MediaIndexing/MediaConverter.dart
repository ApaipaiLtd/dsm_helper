import 'package:dsm_helper/apis/api.dart';

/// duration : 1
/// manual_action_by_user : "none"
/// mode : "always"
/// pause_time_left : -1
/// photo_remain : 0
/// photo_total : 0
/// resume_time : 0
/// start : {"hour":0}
/// status : "idle"
/// thumb_complete : 0
/// thumb_remain : 0
/// thumb_total : 0
/// video_remain : 0
/// video_total : 0
/// week : [false,false,false,false,false,false,false]

class MediaConverter {
  MediaConverter({
    this.duration,
    this.manualActionByUser,
    this.mode,
    this.pauseTimeLeft,
    this.photoRemain,
    this.photoTotal,
    this.resumeTime,
    this.start,
    this.status,
    this.thumbComplete,
    this.thumbRemain,
    this.thumbTotal,
    this.videoRemain,
    this.videoTotal,
    this.week,
  });

  static Future<MediaConverter> convertStatus() async {
    ///webapi/entry.cgi/SYNO.Core.MediaIndexing.MediaConverter
    DsmResponse res = await Api.dsm.entry("SYNO.Core.MediaIndexing.MediaConverter", "status", version: 2);
    return res.data;
  }

  MediaConverter.fromJson(dynamic json) {
    duration = json['duration'];
    manualActionByUser = json['manual_action_by_user'];
    mode = json['mode'];
    pauseTimeLeft = json['pause_time_left'];
    photoRemain = json['photo_remain'];
    photoTotal = json['photo_total'];
    resumeTime = json['resume_time'];
    start = json['start'] != null ? Start.fromJson(json['start']) : null;
    status = json['status'];
    thumbComplete = json['thumb_complete'];
    thumbRemain = json['thumb_remain'];
    thumbTotal = json['thumb_total'];
    videoRemain = json['video_remain'];
    videoTotal = json['video_total'];
    week = json['week'] != null ? json['week'].cast<bool>() : [];
  }
  num? duration;
  String? manualActionByUser;
  String? mode;
  num? pauseTimeLeft;
  num? photoRemain;
  num? photoTotal;
  num? resumeTime;
  Start? start;
  String? status;
  num? thumbComplete;
  num? thumbRemain;
  num? thumbTotal;
  num? videoRemain;
  num? videoTotal;
  List<bool>? week;
  MediaConverter copyWith({
    num? duration,
    String? manualActionByUser,
    String? mode,
    num? pauseTimeLeft,
    num? photoRemain,
    num? photoTotal,
    num? resumeTime,
    Start? start,
    String? status,
    num? thumbComplete,
    num? thumbRemain,
    num? thumbTotal,
    num? videoRemain,
    num? videoTotal,
    List<bool>? week,
  }) =>
      MediaConverter(
        duration: duration ?? this.duration,
        manualActionByUser: manualActionByUser ?? this.manualActionByUser,
        mode: mode ?? this.mode,
        pauseTimeLeft: pauseTimeLeft ?? this.pauseTimeLeft,
        photoRemain: photoRemain ?? this.photoRemain,
        photoTotal: photoTotal ?? this.photoTotal,
        resumeTime: resumeTime ?? this.resumeTime,
        start: start ?? this.start,
        status: status ?? this.status,
        thumbComplete: thumbComplete ?? this.thumbComplete,
        thumbRemain: thumbRemain ?? this.thumbRemain,
        thumbTotal: thumbTotal ?? this.thumbTotal,
        videoRemain: videoRemain ?? this.videoRemain,
        videoTotal: videoTotal ?? this.videoTotal,
        week: week ?? this.week,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['duration'] = duration;
    map['manual_action_by_user'] = manualActionByUser;
    map['mode'] = mode;
    map['pause_time_left'] = pauseTimeLeft;
    map['photo_remain'] = photoRemain;
    map['photo_total'] = photoTotal;
    map['resume_time'] = resumeTime;
    if (start != null) {
      map['start'] = start?.toJson();
    }
    map['status'] = status;
    map['thumb_complete'] = thumbComplete;
    map['thumb_remain'] = thumbRemain;
    map['thumb_total'] = thumbTotal;
    map['video_remain'] = videoRemain;
    map['video_total'] = videoTotal;
    map['week'] = week;
    return map;
  }
}

/// hour : 0

class Start {
  Start({
    this.hour,
  });

  Start.fromJson(dynamic json) {
    hour = json['hour'];
  }
  num? hour;
  Start copyWith({
    num? hour,
  }) =>
      Start(
        hour: hour ?? this.hour,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['hour'] = hour;
    return map;
  }
}
