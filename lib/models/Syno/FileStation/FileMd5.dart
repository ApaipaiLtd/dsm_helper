import 'package:dsm_helper/apis/api.dart';

/// finished : true
/// md5 : "b9af29de56d8a8d4f4abec843e1e5bd9"

class FileMd5 {
  FileMd5({
    this.finished,
    this.md5,
  });

  static Future<FileMd5> result(String taskId) async {
    DsmResponse res = await Api.dsm.entry(
      "SYNO.FileStation.MD5",
      "status",
      version: 2,
      data: {"taskid": taskId},
      parser: FileMd5.fromJson,
    );
    return res.data;
  }

  FileMd5.fromJson(dynamic json) {
    finished = json['finished'];
    md5 = json['md5'];
  }
  bool? finished;
  String? md5;
  FileMd5 copyWith({
    bool? finished,
    String? md5,
  }) =>
      FileMd5(
        finished: finished ?? this.finished,
        md5: md5 ?? this.md5,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['finished'] = finished;
    map['md5'] = md5;
    return map;
  }
}
