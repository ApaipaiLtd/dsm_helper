import 'package:dsm_helper/apis/api.dart';
import 'package:dsm_helper/pages/control_panel/users/enums/user_expired_enum.dart';

/// offset : 0
/// total : 4
/// users : [{"2fa_status":false,"description":"System default user","email":"","expired":"now","name":"admin"},{"2fa_status":false,"description":"Guest","email":"","expired":"now","name":"guest"},{"2fa_status":false,"description":"","email":"","expired":"normal","name":"jinx"},{"2fa_status":false,"description":"","email":"","expired":"normal","name":"yaoshuwei"}]

class SynoUser {
  SynoUser({
    this.offset,
    this.total,
    this.users,
  });

  static Future<SynoUser> list() async {
    DsmResponse res = await Api.dsm.entry("SYNO.Core.User", "list", version: 1, data: {
      "offset": 0,
      "limit": -1,
      "additional": '["email","description","expired","2fa_status"]',
      "type": "local",
    });
    return res.data;
  }

  SynoUser.fromJson(dynamic json) {
    offset = json['offset'];
    total = json['total'];
    if (json['users'] != null) {
      users = [];
      json['users'].forEach((v) {
        users?.add(Users.fromJson(v));
      });
    }
  }
  num? offset;
  num? total;
  List<Users>? users;
  SynoUser copyWith({
    num? offset,
    num? total,
    List<Users>? users,
  }) =>
      SynoUser(
        offset: offset ?? this.offset,
        total: total ?? this.total,
        users: users ?? this.users,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['offset'] = offset;
    map['total'] = total;
    if (users != null) {
      map['users'] = users?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// 2fa_status : false
/// description : "System default user"
/// email : ""
/// expired : "now"
/// name : "admin"

class Users {
  Users({
    this.faStatus,
    this.description,
    this.email,
    this.expired,
    this.name,
  });

  Users.fromJson(dynamic json) {
    faStatus = json['2fa_status'];
    description = json['description'];
    email = json['email'];
    expired = json['expired'];
    name = json['name'];
  }
  bool? faStatus;
  String? description;
  String? email;
  String? expired;
  UserExpiredEnum get expiredEnum => UserExpiredEnum.fromValue(expired);
  String? name;
  Users copyWith({
    bool? faStatus,
    String? description,
    String? email,
    String? expired,
    String? name,
  }) =>
      Users(
        faStatus: faStatus ?? this.faStatus,
        description: description ?? this.description,
        email: email ?? this.email,
        expired: expired ?? this.expired,
        name: name ?? this.name,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['2fa_status'] = faStatus;
    map['description'] = description;
    map['email'] = email;
    map['expired'] = expired;
    map['name'] = name;
    return map;
  }
}
