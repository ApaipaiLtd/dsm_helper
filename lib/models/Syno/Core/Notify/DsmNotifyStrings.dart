import 'package:dsm_helper/apis/api.dart';

/// level : "NOTIFICATION_ERROR"
/// msg : "数据上传失败。请启动支持中心以联系 Synology 技术支持"
/// title : "Synology Active Insight"

class DsmNotifyStrings {
  DsmNotifyStrings({
    this.level,
    this.msg,
    this.title,
  });

  static Future<Map<String, DsmNotifyStrings>> get() async {
    DsmResponse res = await Api.dsm.entry("SYNO.Core.DSMNotify.Strings", "get", data: {"lang": "chs", "pkgName": ""}, parser: (data) {
      Map<String, DsmNotifyStrings> strings = {};
      for (String key in data.keys) {
        strings[key] = DsmNotifyStrings.fromJson(data[key]);
      }
      return strings;
    });
    return res.data;
  }

  DsmNotifyStrings.fromJson(dynamic json) {
    level = json['level'];
    msg = json['msg'];
    title = json['title'];
  }
  String? level;
  String? msg;
  String? title;
  DsmNotifyStrings copyWith({
    String? level,
    String? msg,
    String? title,
  }) =>
      DsmNotifyStrings(
        level: level ?? this.level,
        msg: msg ?? this.msg,
        title: title ?? this.title,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['level'] = level;
    map['msg'] = msg;
    map['title'] = title;
    return map;
  }
}
