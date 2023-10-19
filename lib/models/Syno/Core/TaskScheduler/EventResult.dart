import 'package:dsm_helper/apis/api.dart';
import 'package:dsm_helper/models/Syno/Core/TaskScheduler/EventResultFile.dart';

/// result : [{"event_fire_time":"2023-10-19 15:01:42","exit_info":{"exit_code":0,"exit_type":"normal"},"extra":{},"pid":28207,"result_id":2,"run_time_env":{},"start_time":"2023-10-19 15:01:42","stop_time":"2023-10-19 15:01:42","task_name":"event","trigger_event":"on_demand"}]

class EventResult {
  EventResult({
    this.result,
  });

  static Future<EventResult> resultList(String taskName) async {
    DsmResponse res = await Api.dsm.entry(
      "SYNO.Core.EventScheduler",
      "result_list",
      version: 1,
      data: {
        "task_name": taskName,
      },
      parser: EventResult.fromJson,
    );
    return res.data;
  }

  EventResult.fromJson(dynamic json) {
    if (json != null) {
      result = [];
      json.forEach((v) {
        result?.add(Result.fromJson(v));
      });
    }
  }
  List<Result>? result;
  EventResult copyWith({
    List<Result>? result,
  }) =>
      EventResult(
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

/// event_fire_time : "2023-10-19 15:01:42"
/// exit_info : {"exit_code":0,"exit_type":"normal"}
/// extra : {}
/// pid : 28207
/// result_id : 2
/// run_time_env : {}
/// start_time : "2023-10-19 15:01:42"
/// stop_time : "2023-10-19 15:01:42"
/// task_name : "event"
/// trigger_event : "on_demand"

class Result {
  Result({
    this.eventFireTime,
    this.exitInfo,
    this.extra,
    this.pid,
    this.resultId,
    this.runTimeEnv,
    this.startTime,
    this.stopTime,
    this.taskName,
    this.triggerEvent,
  });

  Future<EventResultFile> getResultFile() async {
    return await EventResultFile.getFile(resultId!);
  }

  Result.fromJson(dynamic json) {
    eventFireTime = json['event_fire_time'];
    exitInfo = json['exit_info'] != null ? ExitInfo.fromJson(json['exit_info']) : null;
    extra = json['extra'];
    pid = json['pid'];
    resultId = json['result_id'];
    runTimeEnv = json['run_time_env'];
    startTime = json['start_time'];
    stopTime = json['stop_time'];
    taskName = json['task_name'];
    triggerEvent = json['trigger_event'];
  }
  String? eventFireTime;
  ExitInfo? exitInfo;
  dynamic extra;
  num? pid;
  num? resultId;
  dynamic runTimeEnv;
  String? startTime;
  String? stopTime;
  String? taskName;
  String? triggerEvent;
  Result copyWith({
    String? eventFireTime,
    ExitInfo? exitInfo,
    dynamic extra,
    num? pid,
    num? resultId,
    dynamic runTimeEnv,
    String? startTime,
    String? stopTime,
    String? taskName,
    String? triggerEvent,
  }) =>
      Result(
        eventFireTime: eventFireTime ?? this.eventFireTime,
        exitInfo: exitInfo ?? this.exitInfo,
        extra: extra ?? this.extra,
        pid: pid ?? this.pid,
        resultId: resultId ?? this.resultId,
        runTimeEnv: runTimeEnv ?? this.runTimeEnv,
        startTime: startTime ?? this.startTime,
        stopTime: stopTime ?? this.stopTime,
        taskName: taskName ?? this.taskName,
        triggerEvent: triggerEvent ?? this.triggerEvent,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['event_fire_time'] = eventFireTime;
    if (exitInfo != null) {
      map['exit_info'] = exitInfo?.toJson();
    }
    map['extra'] = extra;
    map['pid'] = pid;
    map['result_id'] = resultId;
    map['run_time_env'] = runTimeEnv;
    map['start_time'] = startTime;
    map['stop_time'] = stopTime;
    map['task_name'] = taskName;
    map['trigger_event'] = triggerEvent;
    return map;
  }
}

/// exit_code : 0
/// exit_type : "normal"

class ExitInfo {
  ExitInfo({
    this.exitCode,
    this.exitType,
  });

  ExitInfo.fromJson(dynamic json) {
    exitCode = json['exit_code'];
    exitType = json['exit_type'];
  }
  num? exitCode;
  String? exitType;
  ExitInfo copyWith({
    num? exitCode,
    String? exitType,
  }) =>
      ExitInfo(
        exitCode: exitCode ?? this.exitCode,
        exitType: exitType ?? this.exitType,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['exit_code'] = exitCode;
    map['exit_type'] = exitType;
    return map;
  }
}
