import 'package:dsm_helper/models/base_model.dart';

/// enable : false
/// portnum : 22

class Sftp extends BaseModel {
  Sftp({
    this.enable,
    this.portnum,
  });

  Sftp.fromJson(dynamic json) {
    enable = json['enable'];
    portnum = json['portnum'];
  }

  String? api = "SYNO.Core.FileServ.FTP.SFTP";
  String? method = "get";
  int? version = 1;

  bool? enable;
  int? portnum;
  Sftp copyWith({
    bool? enable,
    int? portnum,
  }) =>
      Sftp(
        enable: enable ?? this.enable,
        portnum: portnum ?? this.portnum,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['enable'] = enable;
    map['portnum'] = portnum;
    return map;
  }

  @override
  fromJson(json) {
    return Sftp.fromJson(json);
  }
}
