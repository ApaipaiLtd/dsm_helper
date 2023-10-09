import 'package:dsm_helper/models/base_model.dart';

/// enable_nfs : false
/// enable_nfs_v4 : false
/// enabled_minor_ver : 0
/// nfs_v4_domain : ""
/// read_size : 8192
/// support_encrypt_share : 1
/// support_major_ver : 4
/// support_minor_ver : 1
/// unix_pri_enable : true
/// write_size : 8192

class Nfs extends BaseModel {
  Nfs({
    this.enableNfs,
    this.enableNfsV4,
    this.enabledMinorVer,
    this.nfsV4Domain,
    this.readSize,
    this.supportEncryptShare,
    this.supportMajorVer,
    this.supportMinorVer,
    this.unixPriEnable,
    this.writeSize,
  });

  Nfs.fromJson(dynamic json) {
    enableNfs = json['enable_nfs'];
    enableNfsV4 = json['enable_nfs_v4'];
    enabledMinorVer = json['enabled_minor_ver'];
    nfsV4Domain = json['nfs_v4_domain'];
    readSize = json['read_size'];
    supportEncryptShare = json['support_encrypt_share'];
    supportMajorVer = json['support_major_ver'];
    supportMinorVer = json['support_minor_ver'];
    unixPriEnable = json['unix_pri_enable'];
    writeSize = json['write_size'];
  }

  String? api = "SYNO.Core.FileServ.NFS";
  String? method = "get";
  int? version = 2;

  bool? enableNfs;
  bool? enableNfsV4;
  int? enabledMinorVer;
  String? nfsV4Domain;
  int? readSize;
  int? supportEncryptShare;
  int? supportMajorVer;
  int? supportMinorVer;
  bool? unixPriEnable;
  int? writeSize;
  Nfs copyWith({
    bool? enableNfs,
    bool? enableNfsV4,
    int? enabledMinorVer,
    String? nfsV4Domain,
    int? readSize,
    int? supportEncryptShare,
    int? supportMajorVer,
    int? supportMinorVer,
    bool? unixPriEnable,
    int? writeSize,
  }) =>
      Nfs(
        enableNfs: enableNfs ?? this.enableNfs,
        enableNfsV4: enableNfsV4 ?? this.enableNfsV4,
        enabledMinorVer: enabledMinorVer ?? this.enabledMinorVer,
        nfsV4Domain: nfsV4Domain ?? this.nfsV4Domain,
        readSize: readSize ?? this.readSize,
        supportEncryptShare: supportEncryptShare ?? this.supportEncryptShare,
        supportMajorVer: supportMajorVer ?? this.supportMajorVer,
        supportMinorVer: supportMinorVer ?? this.supportMinorVer,
        unixPriEnable: unixPriEnable ?? this.unixPriEnable,
        writeSize: writeSize ?? this.writeSize,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['enable_nfs'] = enableNfs;
    map['enable_nfs_v4'] = enableNfsV4;
    map['enabled_minor_ver'] = enabledMinorVer;
    map['nfs_v4_domain'] = nfsV4Domain;
    map['read_size'] = readSize;
    map['support_encrypt_share'] = supportEncryptShare;
    map['support_major_ver'] = supportMajorVer;
    map['support_minor_ver'] = supportMinorVer;
    map['unix_pri_enable'] = unixPriEnable;
    map['write_size'] = writeSize;
    return map;
  }

  @override
  fromJson(json) {
    return Nfs.fromJson(json);
  }
}
