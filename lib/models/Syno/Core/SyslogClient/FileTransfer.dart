import 'dart:convert';

import 'package:dsm_helper/models/base_model.dart';

/// afp : false
/// cifs : true
/// filestation : false
/// ftp : false
/// tftp : false
/// webdav : false

class FileTransfer extends BaseModel {
  FileTransfer({
    this.afp,
    this.cifs,
    this.filestation,
    this.ftp,
    this.tftp,
    this.webdav,
  });

  FileTransfer.fromJson(dynamic json) {
    afp = json['afp'];
    cifs = json['cifs'];
    filestation = json['filestation'];
    ftp = json['ftp'];
    tftp = json['tftp'];
    webdav = json['webdav'];
  }

  String? api = "SYNO.Core.SyslogClient.FileTransfer";
  String? method = "get";
  int? version = 1;

  bool? afp;
  bool? cifs;
  bool? filestation;
  bool? ftp;
  bool? tftp;
  bool? webdav;
  FileTransfer copyWith({
    bool? afp,
    bool? cifs,
    bool? filestation,
    bool? ftp,
    bool? tftp,
    bool? webdav,
  }) =>
      FileTransfer(
        afp: afp ?? this.afp,
        cifs: cifs ?? this.cifs,
        filestation: filestation ?? this.filestation,
        ftp: ftp ?? this.ftp,
        tftp: tftp ?? this.tftp,
        webdav: webdav ?? this.webdav,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['afp'] = afp;
    map['cifs'] = cifs;
    map['filestation'] = filestation;
    map['ftp'] = ftp;
    map['tftp'] = tftp;
    map['webdav'] = webdav;
    return map;
  }

  @override
  fromJson(json) {
    return FileTransfer.fromJson(json);
  }

  @override
  toString() {
    return jsonEncode(toJson());
  }
}
