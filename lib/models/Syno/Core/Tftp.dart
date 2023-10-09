/// enable : false
/// enable_log : false
/// endip : "255.255.255.255"
/// permission : "r"
/// root_path : ""
/// startip : "0.0.0.0"
/// timeout : 3

class Tftp {
  Tftp({
    this.enable,
    this.enableLog,
    this.endip,
    this.permission,
    this.rootPath,
    this.startip,
    this.timeout,
  });

  Tftp.fromJson(dynamic json) {
    enable = json['enable'];
    enableLog = json['enable_log'];
    endip = json['endip'];
    permission = json['permission'];
    rootPath = json['root_path'];
    startip = json['startip'];
    timeout = json['timeout'];
  }
  bool? enable;
  bool? enableLog;
  String? endip;
  String? permission;
  String? rootPath;
  String? startip;
  int? timeout;
  Tftp copyWith({
    bool? enable,
    bool? enableLog,
    String? endip,
    String? permission,
    String? rootPath,
    String? startip,
    int? timeout,
  }) =>
      Tftp(
        enable: enable ?? this.enable,
        enableLog: enableLog ?? this.enableLog,
        endip: endip ?? this.endip,
        permission: permission ?? this.permission,
        rootPath: rootPath ?? this.rootPath,
        startip: startip ?? this.startip,
        timeout: timeout ?? this.timeout,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['enable'] = enable;
    map['enable_log'] = enableLog;
    map['endip'] = endip;
    map['permission'] = permission;
    map['root_path'] = rootPath;
    map['startip'] = startip;
    map['timeout'] = timeout;
    return map;
  }
}
