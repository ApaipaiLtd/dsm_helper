import 'package:dsm_helper/apis/api.dart';
import 'package:dsm_helper/pages/docker/enums/docker_log_level_enum.dart';

/// error_count : 6
/// info_count : 0
/// limit : 6
/// logs : [{"event":"Create container moviepilot failed.","level":"err","log_type":"dockerlog","time":"2023/08/01 16:42:13","user":"yaoshuwei"},{"event":"Start container qinglong failed: {\"message\":\"OCI runtime create failed: container_linux.go:367: starting container process caused: exec: \\\"./docker/docker-entrypoint.sh\\\": stat ./docker/docker-entrypoint.sh: no such file or directory: unknown\"}.","level":"err","log_type":"dockerlog","time":"2023/05/15 21:54:52","user":"yaoshuwei"},{"event":"Start container qinglong failed: {\"message\":\"OCI runtime create failed: container_linux.go:367: starting container process caused: exec: \\\"./docker/docker-entrypoint.sh\\\": stat ./docker/docker-entrypoint.sh: no such file or directory: unknown\"}.","level":"err","log_type":"dockerlog","time":"2023/05/15 21:53:50","user":"yaoshuwei"},{"event":"Start container emby failed: {\"message\":\"driver failed programming external connectivity on endpoint emby (12021316f89a73f96be8cf861506e4ec8c728d1d4151a1d07e860658fa99ccf4): Error starting userland proxy: listen udp4 0.0.0.0:1900: bind: address already in use\"}.","level":"err","log_type":"dockerlog","time":"2023/04/29 17:13:17","user":"yaoshuwei"},{"event":"Start container emby failed: {\"message\":\"driver failed programming external connectivity on endpoint emby (fa6a0c3c31d4ae7cdebb9a90986fadf115caf99a1a38469264f959fce3a84daf): Error starting userland proxy: listen udp4 0.0.0.0:7359: bind: address already in use\"}.","level":"err","log_type":"dockerlog","time":"2023/04/29 17:12:33","user":"yaoshuwei"},{"event":"Signal container yunzai-bot failed: {\"message\":\"Cannot kill container: yunzai-bot: Container 88821db32b4e9481ba640358424a279bf35dc6843e38cbbdb32477a44899dbe5 is not running\"}.","level":"err","log_type":"dockerlog","time":"2023/04/29 15:21:41","user":"yaoshuwei"}]
/// offset : 0
/// total : 6
/// warn_count : 0

class DockerLog {
  DockerLog({
    this.errorCount,
    this.infoCount,
    this.limit,
    this.logs,
    this.offset,
    this.total,
    this.warnCount,
  });

  static Future<DockerLog> list({String logLevel = ""}) async {
    DsmResponse res = await Api.dsm.entry(
      "SYNO.Docker.Log",
      "list",
      version: 1,
      parser: DockerLog.fromJson,
      data: {
        "limit": 1000,
        "offset": 0,
        "sort_by": '"time"',
        "sort_dir": '"DESC"',
        "loglevel": '"$logLevel"',
        "filter_content": '""',
        "datefrom": 0,
        "dateto": 0,
        "action": '"load"',
      },
    );
    return res.data;
  }

  DockerLog.fromJson(dynamic json) {
    errorCount = json['error_count'];
    infoCount = json['info_count'];
    limit = json['limit'];
    if (json['logs'] != null) {
      logs = [];
      json['logs'].forEach((v) {
        logs?.add(Logs.fromJson(v));
      });
    }
    offset = json['offset'];
    total = json['total'];
    warnCount = json['warn_count'];
  }
  num? errorCount;
  num? infoCount;
  num? limit;
  List<Logs>? logs;
  num? offset;
  num? total;
  num? warnCount;
  DockerLog copyWith({
    num? errorCount,
    num? infoCount,
    num? limit,
    List<Logs>? logs,
    num? offset,
    num? total,
    num? warnCount,
  }) =>
      DockerLog(
        errorCount: errorCount ?? this.errorCount,
        infoCount: infoCount ?? this.infoCount,
        limit: limit ?? this.limit,
        logs: logs ?? this.logs,
        offset: offset ?? this.offset,
        total: total ?? this.total,
        warnCount: warnCount ?? this.warnCount,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['error_count'] = errorCount;
    map['info_count'] = infoCount;
    map['limit'] = limit;
    if (logs != null) {
      map['logs'] = logs?.map((v) => v.toJson()).toList();
    }
    map['offset'] = offset;
    map['total'] = total;
    map['warn_count'] = warnCount;
    return map;
  }
}

/// event : "Create container moviepilot failed."
/// level : "err"
/// log_type : "dockerlog"
/// time : "2023/08/01 16:42:13"
/// user : "yaoshuwei"

class Logs {
  Logs({
    this.event,
    this.level,
    this.logType,
    this.time,
    this.user,
  });

  Logs.fromJson(dynamic json) {
    event = json['event'];
    level = json['level'];
    logType = json['log_type'];
    time = json['time'];
    user = json['user'];
  }
  String? event;
  String? level;
  DockerLogLevelEnum get levelEnum => DockerLogLevelEnum.fromValue(level!);
  String? logType;
  String? time;
  String? user;
  Logs copyWith({
    String? event,
    String? level,
    String? logType,
    String? time,
    String? user,
  }) =>
      Logs(
        event: event ?? this.event,
        level: level ?? this.level,
        logType: logType ?? this.logType,
        time: time ?? this.time,
        user: user ?? this.user,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['event'] = event;
    map['level'] = level;
    map['log_type'] = logType;
    map['time'] = time;
    map['user'] = user;
    return map;
  }
}
