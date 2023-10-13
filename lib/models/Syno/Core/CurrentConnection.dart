import 'dart:convert';

import 'package:dsm_helper/apis/api.dart';

/// items : [{"can_be_kicked":true,"descr":"DiskStation Manager","from":"221.3.93.20","pid":1,"protocol":"HTTP/HTTPS","time":"2023/09/11 17:57:20","type":"HTTP/HTTPS","user_can_be_disabled":true,"who":"yaoshuwei"},{"can_be_kicked":true,"descr":"DiskStation Manager","from":"17.232.89.36","pid":1,"protocol":"HTTP/HTTPS","time":"2023/09/11 17:26:13","type":"HTTP/HTTPS","user_can_be_disabled":true,"who":"jinx"},{"can_be_kicked":true,"descr":"DiskStation Manager","from":"58.240.94.146","pid":1,"protocol":"HTTP/HTTPS","time":"2023/09/10 14:20:08","type":"HTTP/HTTPS","user_can_be_disabled":true,"who":"jinx"},{"can_be_kicked":true,"descr":"DiskStation Manager","from":"113.120.111.165","pid":1,"protocol":"HTTP/HTTPS","time":"2023/09/04 19:38:03","type":"HTTP/HTTPS","user_can_be_disabled":true,"who":"yaoshuwei"}]
/// systime : "Thu Sep 14 09:21:30 2023\n"
/// total : 4

class CurrentConnection {
  CurrentConnection({
    this.items,
    this.systime,
    this.total,
  });

  static Future<CurrentConnection> get() async {
    DsmResponse res = await Api.dsm.entry(
      "SYNO.Core.CurrentConnection",
      "get",
      parser: CurrentConnection.fromJson,
      version: 1,
      data: {
        "start": 0,
        "limit": 50,
        "sort_by": "time",
        "sort_direction": "DESC",
        "offset": 0,
        "action": "enum",
      },
    );
    return res.data;
  }

  CurrentConnection.fromJson(dynamic json) {
    if (json['items'] != null) {
      items = [];
      json['items'].forEach((v) {
        items?.add(UserItems.fromJson(v));
      });
    }
    systime = json['systime'];
    total = json['total'];
  }
  List<UserItems>? items;
  String? systime;
  num? total;
  CurrentConnection copyWith({
    List<UserItems>? items,
    String? systime,
    num? total,
  }) =>
      CurrentConnection(
        items: items ?? this.items,
        systime: systime ?? this.systime,
        total: total ?? this.total,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (items != null) {
      map['items'] = items?.map((v) => v.toJson()).toList();
    }
    map['systime'] = systime;
    map['total'] = total;
    return map;
  }
}

/// can_be_kicked : true
/// descr : "DiskStation Manager"
/// from : "221.3.93.20"
/// pid : 1
/// protocol : "HTTP/HTTPS"
/// time : "2023/09/11 17:57:20"
/// type : "HTTP/HTTPS"
/// user_can_be_disabled : true
/// who : "yaoshuwei"

class UserItems {
  UserItems({
    this.canBeKicked,
    this.descr,
    this.from,
    this.pid,
    this.protocol,
    this.time,
    this.type,
    this.userCanBeDisabled,
    this.who,
  });

  Future<bool?> kickConnection() async {
    DsmResponse res = await Api.dsm.entry(
      "SYNO.Core.CurrentConnection",
      'kick_connection',
      version: 1,
      data: {
        "http_conn": jsonEncode([
          {
            "who": who,
            "from": from,
          }
        ]),
        "service_conn": '[]',
      },
    );
    return res.success;
  }

  UserItems.fromJson(dynamic json) {
    canBeKicked = json['can_be_kicked'];
    descr = json['descr'];
    from = json['from'];
    pid = json['pid'];
    protocol = json['protocol'];
    time = json['time'];
    type = json['type'];
    userCanBeDisabled = json['user_can_be_disabled'];
    who = json['who'];
  }
  bool? canBeKicked;
  String? descr;
  String? from;
  num? pid;
  String? protocol;
  String? time;
  String? type;
  bool? userCanBeDisabled;
  String? who;
  bool running = false;
  UserItems copyWith({
    bool? canBeKicked,
    String? descr,
    String? from,
    num? pid,
    String? protocol,
    String? time,
    String? type,
    bool? userCanBeDisabled,
    String? who,
  }) =>
      UserItems(
        canBeKicked: canBeKicked ?? this.canBeKicked,
        descr: descr ?? this.descr,
        from: from ?? this.from,
        pid: pid ?? this.pid,
        protocol: protocol ?? this.protocol,
        time: time ?? this.time,
        type: type ?? this.type,
        userCanBeDisabled: userCanBeDisabled ?? this.userCanBeDisabled,
        who: who ?? this.who,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['can_be_kicked'] = canBeKicked;
    map['descr'] = descr;
    map['from'] = from;
    map['pid'] = pid;
    map['protocol'] = protocol;
    map['time'] = time;
    map['type'] = type;
    map['user_can_be_disabled'] = userCanBeDisabled;
    map['who'] = who;
    return map;
  }
}
