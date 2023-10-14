import 'package:dsm_helper/apis/api.dart';

/// num_of_event : 149
/// time_to_resume : 0

class SynologyDriveIndex {
  SynologyDriveIndex({
    this.numOfEvent,
    this.timeToResume,
  });

  static Future<SynologyDriveIndex> result(String taskId) async {
    DsmResponse res = await Api.dsm.entry(
      "SYNO.SynologyDrive.Index",
      "get_native_client_status",
      version: 1,
      parser: SynologyDriveIndex.fromJson,
    );
    return res.data;
  }

  SynologyDriveIndex.fromJson(dynamic json) {
    numOfEvent = json['num_of_event'];
    timeToResume = json['time_to_resume'];
  }
  num? numOfEvent;
  num? timeToResume;
  SynologyDriveIndex copyWith({
    num? numOfEvent,
    num? timeToResume,
  }) =>
      SynologyDriveIndex(
        numOfEvent: numOfEvent ?? this.numOfEvent,
        timeToResume: timeToResume ?? this.timeToResume,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['num_of_event'] = numOfEvent;
    map['time_to_resume'] = timeToResume;
    return map;
  }
}
