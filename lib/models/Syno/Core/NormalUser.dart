import 'package:dsm_helper/apis/api.dart';

/// OTP_enable : false
/// OTP_enforced : false
/// disallowchpasswd : false
/// editable : true
/// email : ""
/// fullname : ""
/// password_last_change : 19475
/// username : "yaoshuwei"

class NormalUser {
  NormalUser({
    this.otpEnable,
    this.otpEnforced,
    this.disallowchpasswd,
    this.editable,
    this.email,
    this.fullname,
    this.passwordLastChange,
    this.username,
  });

  static Future<NormalUser> get() async {
    DsmResponse res = await Api.dsm.entry("SYNO.Core.NormalUser", "get", version: 1, post: false, parser: NormalUser.fromJson);
    return res.data;
  }

  static Future<bool?> set(Map<String, dynamic> data) async {
    DsmResponse res = await Api.dsm.entry("SYNO.Core.NormalUser", "set", version: 2, data: data);
    return res.success;
  }

  NormalUser.fromJson(dynamic json) {
    otpEnable = json['OTP_enable'];
    otpEnforced = json['OTP_enforced'];
    disallowchpasswd = json['disallowchpasswd'];
    editable = json['editable'];
    email = json['email'];
    fullname = json['fullname'];
    passwordLastChange = json['password_last_change'];
    username = json['username'];
  }
  bool? otpEnable;
  bool? otpEnforced;
  bool? disallowchpasswd;
  bool? editable;
  String? email;
  String? fullname;
  num? passwordLastChange;
  String? username;
  NormalUser copyWith({
    bool? oTPEnable,
    bool? oTPEnforced,
    bool? disallowchpasswd,
    bool? editable,
    String? email,
    String? fullname,
    num? passwordLastChange,
    String? username,
  }) =>
      NormalUser(
        otpEnable: oTPEnable ?? this.otpEnable,
        otpEnforced: oTPEnforced ?? this.otpEnforced,
        disallowchpasswd: disallowchpasswd ?? this.disallowchpasswd,
        editable: editable ?? this.editable,
        email: email ?? this.email,
        fullname: fullname ?? this.fullname,
        passwordLastChange: passwordLastChange ?? this.passwordLastChange,
        username: username ?? this.username,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['OTP_enable'] = otpEnable;
    map['OTP_enforced'] = otpEnforced;
    map['disallowchpasswd'] = disallowchpasswd;
    map['editable'] = editable;
    map['email'] = email;
    map['fullname'] = fullname;
    map['password_last_change'] = passwordLastChange;
    map['username'] = username;
    return map;
  }
}
