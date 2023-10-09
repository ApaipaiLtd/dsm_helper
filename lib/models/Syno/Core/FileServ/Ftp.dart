import 'package:dsm_helper/models/base_model.dart';

/// custom_port : "55536:55899"
/// custom_port_range : false
/// enable_ascii : false
/// enable_fips : false
/// enable_flow_ctrl : false
/// enable_ftp : false
/// enable_ftps : false
/// enable_fxp : false
/// ext_ip : ""
/// max_conn_per_ip : 0
/// maxdownloadrate : 0
/// maxuploadrate : 0
/// modify_time_std : "utc"
/// portnum : 21
/// timeout : 300
/// use_ext_ip : false
/// utf8_mode : 1

class Ftp extends BaseModel {
  Ftp({
    this.customPort,
    this.customPortRange,
    this.enableAscii,
    this.enableFips,
    this.enableFlowCtrl,
    this.enableFtp,
    this.enableFtps,
    this.enableFxp,
    this.extIp,
    this.maxConnPerIp,
    this.maxdownloadrate,
    this.maxuploadrate,
    this.modifyTimeStd,
    this.portnum,
    this.timeout,
    this.useExtIp,
    this.utf8Mode,
  });

  Ftp.fromJson(dynamic json) {
    customPort = json['custom_port'];
    customPortRange = json['custom_port_range'];
    enableAscii = json['enable_ascii'];
    enableFips = json['enable_fips'];
    enableFlowCtrl = json['enable_flow_ctrl'];
    enableFtp = json['enable_ftp'];
    enableFtps = json['enable_ftps'];
    enableFxp = json['enable_fxp'];
    extIp = json['ext_ip'];
    maxConnPerIp = json['max_conn_per_ip'];
    maxdownloadrate = json['maxdownloadrate'];
    maxuploadrate = json['maxuploadrate'];
    modifyTimeStd = json['modify_time_std'];
    portnum = json['portnum'];
    timeout = json['timeout'];
    useExtIp = json['use_ext_ip'];
    utf8Mode = json['utf8_mode'];
  }

  String? api = "SYNO.Core.FileServ.FTP";
  String? method = "get";
  int? version = 3;

  String? customPort;
  bool? customPortRange;
  bool? enableAscii;
  bool? enableFips;
  bool? enableFlowCtrl;
  bool? enableFtp;
  bool? enableFtps;
  bool? enableFxp;
  String? extIp;
  int? maxConnPerIp;
  int? maxdownloadrate;
  int? maxuploadrate;
  String? modifyTimeStd;
  int? portnum;
  int? timeout;
  bool? useExtIp;
  int? utf8Mode;
  Ftp copyWith({
    String? customPort,
    bool? customPortRange,
    bool? enableAscii,
    bool? enableFips,
    bool? enableFlowCtrl,
    bool? enableFtp,
    bool? enableFtps,
    bool? enableFxp,
    String? extIp,
    int? maxConnPerIp,
    int? maxdownloadrate,
    int? maxuploadrate,
    String? modifyTimeStd,
    int? portnum,
    int? timeout,
    bool? useExtIp,
    int? utf8Mode,
  }) =>
      Ftp(
        customPort: customPort ?? this.customPort,
        customPortRange: customPortRange ?? this.customPortRange,
        enableAscii: enableAscii ?? this.enableAscii,
        enableFips: enableFips ?? this.enableFips,
        enableFlowCtrl: enableFlowCtrl ?? this.enableFlowCtrl,
        enableFtp: enableFtp ?? this.enableFtp,
        enableFtps: enableFtps ?? this.enableFtps,
        enableFxp: enableFxp ?? this.enableFxp,
        extIp: extIp ?? this.extIp,
        maxConnPerIp: maxConnPerIp ?? this.maxConnPerIp,
        maxdownloadrate: maxdownloadrate ?? this.maxdownloadrate,
        maxuploadrate: maxuploadrate ?? this.maxuploadrate,
        modifyTimeStd: modifyTimeStd ?? this.modifyTimeStd,
        portnum: portnum ?? this.portnum,
        timeout: timeout ?? this.timeout,
        useExtIp: useExtIp ?? this.useExtIp,
        utf8Mode: utf8Mode ?? this.utf8Mode,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['custom_port'] = customPort;
    map['custom_port_range'] = customPortRange;
    map['enable_ascii'] = enableAscii;
    map['enable_fips'] = enableFips;
    map['enable_flow_ctrl'] = enableFlowCtrl;
    map['enable_ftp'] = enableFtp;
    map['enable_ftps'] = enableFtps;
    map['enable_fxp'] = enableFxp;
    map['ext_ip'] = extIp;
    map['max_conn_per_ip'] = maxConnPerIp;
    map['maxdownloadrate'] = maxdownloadrate;
    map['maxuploadrate'] = maxuploadrate;
    map['modify_time_std'] = modifyTimeStd;
    map['portnum'] = portnum;
    map['timeout'] = timeout;
    map['use_ext_ip'] = useExtIp;
    map['utf8_mode'] = utf8Mode;
    return map;
  }

  @override
  fromJson(json) {
    return Ftp.fromJson(json);
  }
}
