import 'package:dsm_helper/apis/api.dart';

/// result : [{"exit_code":0,"exit_type":"normal","script_in":"","script_out":"","start_time":"2023-10-19 15:04:07","stop_time":"2023-10-19 15:04:07"}]

class TaskResult {
  TaskResult({
    this.result,
  });

  static Future<TaskResult> view(int id) async {
    DsmResponse res = await Api.dsm.entry(
      "SYNO.Core.TaskScheduler",
      "view",
      version: 1,
      data: {
        "id": id,
      },
      parser: TaskResult.fromJson,
    );
    return res.data;
  }

  TaskResult.fromJson(dynamic json) {
    if (json != null) {
      result = [];
      json.forEach((v) {
        result?.add(TaskResultItem.fromJson(v));
      });
    }
  }
  List<TaskResultItem>? result;
  TaskResult copyWith({
    List<TaskResultItem>? result,
  }) =>
      TaskResult(
        result: result ?? this.result,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (result != null) {
      map['result'] = result?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// exit_code : 0
/// exit_type : "normal"
/// script_in : ""
/// script_out : ""
/// start_time : "2023-10-19 15:04:07"
/// stop_time : "2023-10-19 15:04:07"

class TaskResultItem {
  TaskResultItem({
    this.exitCode,
    this.exitType,
    this.scriptIn,
    this.scriptOut,
    this.startTime,
    this.stopTime,
  });

  TaskResultItem.fromJson(dynamic json) {
    exitCode = json['exit_code'];
    exitType = json['exit_type'];
    scriptIn = json['script_in'];
    scriptOut = json['script_out'];
    startTime = json['start_time'];
    stopTime = json['stop_time'];
  }
  num? exitCode;
  String? exitType;
  String? scriptIn;
  String? scriptOut;
  String? startTime;
  String? stopTime;
  TaskResultItem copyWith({
    num? exitCode,
    String? exitType,
    String? scriptIn,
    String? scriptOut,
    String? startTime,
    String? stopTime,
  }) =>
      TaskResultItem(
        exitCode: exitCode ?? this.exitCode,
        exitType: exitType ?? this.exitType,
        scriptIn: scriptIn ?? this.scriptIn,
        scriptOut: scriptOut ?? this.scriptOut,
        startTime: startTime ?? this.startTime,
        stopTime: stopTime ?? this.stopTime,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['exit_code'] = exitCode;
    map['exit_type'] = exitType;
    map['script_in'] = scriptIn;
    map['script_out'] = scriptOut;
    map['start_time'] = startTime;
    map['stop_time'] = stopTime;
    return map;
  }
}
