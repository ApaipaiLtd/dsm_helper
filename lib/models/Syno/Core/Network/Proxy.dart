import 'package:dsm_helper/models/base_model.dart';

/// enable : false
/// enable_auth : false
/// enable_bypass : true
/// enable_different_host : false
/// http_host : ""
/// http_port : "80"
/// https_host : ""
/// https_port : "80"
/// password : "\t\t\t\t\t\t\t\t"
/// username : ""

class Proxy implements BaseModel {
  Proxy({
    this.enable,
    this.enableAuth,
    this.enableBypass,
    this.enableDifferentHost,
    this.httpHost,
    this.httpPort,
    this.httpsHost,
    this.httpsPort,
    this.password,
    this.username,
  });

  Proxy.fromJson(dynamic json) {
    enable = json['enable'];
    enableAuth = json['enable_auth'];
    enableBypass = json['enable_bypass'];
    enableDifferentHost = json['enable_different_host'];
    httpHost = json['http_host'];
    httpPort = json['http_port'];
    httpsHost = json['https_host'];
    httpsPort = json['https_port'];
    password = json['password'];
    username = json['username'];
  }
  bool? enable;
  bool? enableAuth;
  bool? enableBypass;
  bool? enableDifferentHost;
  String? httpHost;
  String? httpPort;
  String? httpsHost;
  String? httpsPort;
  String? password;
  String? username;
  Proxy copyWith({
    bool? enable,
    bool? enableAuth,
    bool? enableBypass,
    bool? enableDifferentHost,
    String? httpHost,
    String? httpPort,
    String? httpsHost,
    String? httpsPort,
    String? password,
    String? username,
  }) =>
      Proxy(
        enable: enable ?? this.enable,
        enableAuth: enableAuth ?? this.enableAuth,
        enableBypass: enableBypass ?? this.enableBypass,
        enableDifferentHost: enableDifferentHost ?? this.enableDifferentHost,
        httpHost: httpHost ?? this.httpHost,
        httpPort: httpPort ?? this.httpPort,
        httpsHost: httpsHost ?? this.httpsHost,
        httpsPort: httpsPort ?? this.httpsPort,
        password: password ?? this.password,
        username: username ?? this.username,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['enable'] = enable;
    map['enable_auth'] = enableAuth;
    map['enable_bypass'] = enableBypass;
    map['enable_different_host'] = enableDifferentHost;
    map['http_host'] = httpHost;
    map['http_port'] = httpPort;
    map['https_host'] = httpsHost;
    map['https_port'] = httpsPort;
    map['password'] = password;
    map['username'] = username;
    return map;
  }

  @override
  String? api = "SYNO.Core.Network.Proxy";

  @override
  Map<String, dynamic>? data;

  @override
  String? method = "get";

  @override
  int? version = 1;

  @override
  fromJson(json) {
    return Proxy.fromJson(json);
  }
}
