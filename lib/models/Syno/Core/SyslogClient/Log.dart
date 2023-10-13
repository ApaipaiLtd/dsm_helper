import 'package:dsm_helper/apis/api.dart';
import 'package:dsm_helper/models/base_model.dart';

/// errorCount : 0
/// infoCount : 0
/// items : [{"cmd":"write","descr":"/监控/xiaomi_camera_videos/50ec5058c51c/2021041421/32M34S_1618407154.mp4","filesize":"63.94 KB","ip":"192.168.0.131","isdir":"false","logtype":"SMB","orginalLogType":"smbxfer","time":"2021/04/14 21:34:56","username":"admin"},{"cmd":"create","descr":"/监控/xiaomi_camera_videos/50ec5058c51c/2021041421/32M34S_1618407154.mp4","filesize":"0 Bytes","ip":"192.168.0.131","isdir":"false","logtype":"SMB","orginalLogType":"smbxfer","time":"2021/04/14 21:34:56","username":"admin"},{"cmd":"write","descr":"/监控/xiaomi_camera_videos/50ec5058c51c/2021041421/31M34S_1618407094.mp4","filesize":"63.94 KB","ip":"192.168.0.131","isdir":"false","logtype":"SMB","orginalLogType":"smbxfer","time":"2021/04/14 21:34:49","username":"admin"},{"cmd":"create","descr":"/监控/xiaomi_camera_videos/50ec5058c51c/2021041421/31M34S_1618407094.mp4","filesize":"0 Bytes","ip":"192.168.0.131","isdir":"false","logtype":"SMB","orginalLogType":"smbxfer","time":"2021/04/14 21:34:48","username":"admin"},{"cmd":"write","descr":"/监控/xiaomi_camera_videos/50ec5058c51c/2021041421/30M34S_1618407034.mp4","filesize":"63.94 KB","ip":"192.168.0.131","isdir":"false","logtype":"SMB","orginalLogType":"smbxfer","time":"2021/04/14 21:34:42","username":"admin"},{"cmd":"create","descr":"/监控/xiaomi_camera_videos/50ec5058c51c/2021041421/30M34S_1618407034.mp4","filesize":"0 Bytes","ip":"192.168.0.131","isdir":"false","logtype":"SMB","orginalLogType":"smbxfer","time":"2021/04/14 21:34:42","username":"admin"},{"cmd":"write","descr":"/监控/xiaomi_camera_videos/50ec5058c51c/2021041421/29M34S_1618406974.mp4","filesize":"63.94 KB","ip":"192.168.0.131","isdir":"false","logtype":"SMB","orginalLogType":"smbxfer","time":"2021/04/14 21:34:33","username":"admin"},{"cmd":"create","descr":"/监控/xiaomi_camera_videos/50ec5058c51c/2021041421/29M34S_1618406974.mp4","filesize":"0 Bytes","ip":"192.168.0.131","isdir":"false","logtype":"SMB","orginalLogType":"smbxfer","time":"2021/04/14 21:34:33","username":"admin"},{"cmd":"write","descr":"/监控/xiaomi_camera_videos/50ec5058c51c/2021041421/28M34S_1618406914.mp4","filesize":"63.94 KB","ip":"192.168.0.131","isdir":"false","logtype":"SMB","orginalLogType":"smbxfer","time":"2021/04/14 21:34:26","username":"admin"},{"cmd":"create","descr":"/监控/xiaomi_camera_videos/50ec5058c51c/2021041421/28M34S_1618406914.mp4","filesize":"0 Bytes","ip":"192.168.0.131","isdir":"false","logtype":"SMB","orginalLogType":"smbxfer","time":"2021/04/14 21:34:26","username":"admin"}]
/// total : 10
/// warnCount : 0

class SyslogClientLog extends BaseModel {
  SyslogClientLog({
    this.errorCount,
    this.infoCount,
    this.items,
    this.total,
    this.warnCount,
  });

  static Future<SyslogClientLog> list() async {
    DsmResponse res = await Api.dsm.entry(
      "SYNO.Core.SyslogClient.Log",
      "list",
      version: 1,
      parser: SyslogClientLog.fromJson,
      data: {
        "start": 0,
        "limit": 50,
        "target": "LOCAL",
        "logtype": "ftp,filestation,webdav,cifs,tftp,afp",
        "dir": "desc",
      },
    );
    return res.data;
  }

  SyslogClientLog.fromJson(dynamic json) {
    errorCount = json['errorCount'];
    infoCount = json['infoCount'];
    if (json['items'] != null) {
      items = [];
      json['items'].forEach((v) {
        items?.add(SyslogClientLogItem.fromJson(v));
      });
    }
    total = json['total'];
    warnCount = json['warnCount'];
  }
  fromJson(dynamic json) {
    return SyslogClientLog.fromJson(json);
  }

  num? errorCount;
  num? infoCount;
  List<SyslogClientLogItem>? items;
  num? total;
  num? warnCount;

  String? api = "SYNO.Core.SyslogClient.Log";
  String? method = "list";
  int? version = 1;

  Map<String, dynamic>? data = {
    "start": 0,
    "limit": 50,
    "target": "LOCAL",
    "logtype": "ftp,filestation,webdav,cifs,tftp,afp",
    "dir": "desc",
  };

  SyslogClientLog copyWith({
    num? errorCount,
    num? infoCount,
    List<SyslogClientLogItem>? items,
    num? total,
    num? warnCount,
  }) =>
      SyslogClientLog(
        errorCount: errorCount ?? this.errorCount,
        infoCount: infoCount ?? this.infoCount,
        items: items ?? this.items,
        total: total ?? this.total,
        warnCount: warnCount ?? this.warnCount,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['errorCount'] = errorCount;
    map['infoCount'] = infoCount;
    if (items != null) {
      map['items'] = items?.map((v) => v.toJson()).toList();
    }
    map['total'] = total;
    map['warnCount'] = warnCount;
    return map;
  }
}

/// cmd : "write"
/// descr : "/监控/xiaomi_camera_videos/50ec5058c51c/2021041421/32M34S_1618407154.mp4"
/// filesize : "63.94 KB"
/// ip : "192.168.0.131"
/// isdir : "false"
/// logtype : "SMB"
/// orginalLogType : "smbxfer"
/// time : "2021/04/14 21:34:56"
/// username : "admin"

class SyslogClientLogItem {
  SyslogClientLogItem({
    this.cmd,
    this.descr,
    this.filesize,
    this.ip,
    this.isdir,
    this.logtype,
    this.orginalLogType,
    this.time,
    this.username,
  });

  SyslogClientLogItem.fromJson(dynamic json) {
    cmd = json['cmd'];
    descr = json['descr'];
    filesize = json['filesize'];
    ip = json['ip'];
    isdir = json['isdir'];
    logtype = json['logtype'];
    orginalLogType = json['orginalLogType'];
    time = json['time'];
    username = json['username'];
  }
  String? cmd;
  String? descr;
  String? filesize;
  String? ip;
  String? isdir;
  String? logtype;
  String? orginalLogType;
  String? time;
  String? username;
  SyslogClientLogItem copyWith({
    String? cmd,
    String? descr,
    String? filesize,
    String? ip,
    String? isdir,
    String? logtype,
    String? orginalLogType,
    String? time,
    String? username,
  }) =>
      SyslogClientLogItem(
        cmd: cmd ?? this.cmd,
        descr: descr ?? this.descr,
        filesize: filesize ?? this.filesize,
        ip: ip ?? this.ip,
        isdir: isdir ?? this.isdir,
        logtype: logtype ?? this.logtype,
        orginalLogType: orginalLogType ?? this.orginalLogType,
        time: time ?? this.time,
        username: username ?? this.username,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['cmd'] = cmd;
    map['descr'] = descr;
    map['filesize'] = filesize;
    map['ip'] = ip;
    map['isdir'] = isdir;
    map['logtype'] = logtype;
    map['orginalLogType'] = orginalLogType;
    map['time'] = time;
    map['username'] = username;
    return map;
  }
}
