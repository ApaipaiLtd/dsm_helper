import 'package:dsm_helper/apis/api.dart';

/// finished : true
/// num_dir : 2
/// num_file : 4
/// total_size : 16004352

class DirSize {
  DirSize({
    this.finished,
    this.numDir,
    this.numFile,
    this.totalSize,
  });

  static Future<DirSize> result(String taskId) async {
    DsmResponse res = await Api.dsm.entry(
      "SYNO.FileStation.DirSize",
      "status",
      version: 2,
      data: {"taskid": taskId},
      parser: DirSize.fromJson,
    );
    return res.data;
  }

  DirSize.fromJson(dynamic json) {
    finished = json['finished'];
    numDir = json['num_dir'];
    numFile = json['num_file'];
    totalSize = json['total_size'];
  }
  bool? finished;
  int? numDir;
  int? numFile;
  int? totalSize;
  DirSize copyWith({
    bool? finished,
    int? numDir,
    int? numFile,
    int? totalSize,
  }) =>
      DirSize(
        finished: finished ?? this.finished,
        numDir: numDir ?? this.numDir,
        numFile: numFile ?? this.numFile,
        totalSize: totalSize ?? this.totalSize,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['finished'] = finished;
    map['num_dir'] = numDir;
    map['num_file'] = numFile;
    map['total_size'] = totalSize;
    return map;
  }
}
