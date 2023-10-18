import 'package:dsm_helper/apis/api.dart';

/// account : "yaoshuwei"
/// device_id : "gM4De7c5C3-rtaJ0X-JRr-mBgsefCqHkvoIw4-NLI5m-3wVTfrZMeLLw783JOiR6OPUVaIchg9uRy5M0aDzmPA"
/// ik_message : ""
/// is_portal_port : false
/// sid : "jGm0RS1X0YxlzxFbu5Gm6LWSrULiNjL7ZPbfYzvJshEHwZQN2PvTpH5wjc1YRnEvGj9df3-Vh4D2WN1eAQ5s4A"
/// synotoken : "--------"

class Auth {
  Auth({
    this.account,
    this.deviceId,
    this.ikMessage,
    this.isPortalPort,
    this.sid,
    this.synotoken,
  });

  static Future<Auth> login({required String account, required String password, String optCode = ""}) async {
    DsmResponse res = await Api.dsm.entry<Auth>(
      "SYNO.API.Auth",
      "login",
      data: {
        "account": account,
        "passwd": password,
        "otp_code": optCode,
        "version": 4,
        "api": "SYNO.API.Auth",
        "method": "login",
        "session": "FileStation",
        "enable_device_token": "yes",
        "enable_sync_token": "yes",
      },
      parameters: {
        "api": "SYNO.API.Auth",
      },
      parser: Auth.fromJson,
    );
    return res.data;
  }

  static Future<bool> logout() async {
    DsmResponse res = await Api.dsm.entry("SYNO.API.Auth", "logout", version: 7, parameters: {"api": "SYNO.API.Auth"});
    return res.success!;
  }

  static Future<bool> forget() async {
    DsmResponse res = await Api.dsm.entry("SYNO.Core.TrustDevice", "delete", version: 1);
    return res.success!;
  }

  Auth.fromJson(dynamic json) {
    account = json['account'];
    deviceId = json['device_id'];
    ikMessage = json['ik_message'];
    isPortalPort = json['is_portal_port'];
    sid = json['sid'];
    synotoken = json['synotoken'];
  }
  String? account;
  String? deviceId;
  String? ikMessage;
  bool? isPortalPort;
  String? sid;
  String? synotoken;
  Auth copyWith({
    String? account,
    String? deviceId,
    String? ikMessage,
    bool? isPortalPort,
    String? sid,
    String? synotoken,
  }) =>
      Auth(
        account: account ?? this.account,
        deviceId: deviceId ?? this.deviceId,
        ikMessage: ikMessage ?? this.ikMessage,
        isPortalPort: isPortalPort ?? this.isPortalPort,
        sid: sid ?? this.sid,
        synotoken: synotoken ?? this.synotoken,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['account'] = account;
    map['device_id'] = deviceId;
    map['ik_message'] = ikMessage;
    map['is_portal_port'] = isPortalPort;
    map['sid'] = sid;
    map['synotoken'] = synotoken;
    return map;
  }
}
