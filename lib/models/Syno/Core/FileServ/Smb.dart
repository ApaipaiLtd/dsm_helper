import 'package:dsm_helper/models/base_model.dart';

/// disable_shadow_copy : false
/// disable_strict_allocate : false
/// enable_access_based_share_enum : false
/// enable_adserver : null
/// enable_aio_read : false
/// enable_delete_vetofiles : false
/// enable_dirsort : false
/// enable_durable_handles : false
/// enable_enhance_log : false
/// enable_fruit_locking : false
/// enable_local_master_browser : false
/// enable_mask : false
/// enable_msdfs : false
/// enable_multichannel : false
/// enable_ntlmv1_auth : false
/// enable_op_lock : true
/// enable_reset_on_zero_vc : false
/// enable_samba : true
/// enable_server_signing : 0
/// enable_smb2_leases : true
/// enable_strict_sync : false
/// enable_symlink : true
/// enable_syno_catia : true
/// enable_synotify : true
/// enable_vetofile : false
/// enable_widelink : false
/// offline_files_support : false
/// smb_encrypt_transport : 1
/// smb_max_protocol : 3
/// smb_min_protocol : 1
/// syno_wildcard_search : false
/// vetofile : ""
/// wins : ""
/// workgroup : "WORKGROUP"

class Smb extends BaseModel {
  Smb({
    this.disableShadowCopy,
    this.disableStrictAllocate,
    this.enableAccessBasedShareEnum,
    this.enableAdserver,
    this.enableAioRead,
    this.enableDeleteVetofiles,
    this.enableDirsort,
    this.enableDurableHandles,
    this.enableEnhanceLog,
    this.enableFruitLocking,
    this.enableLocalMasterBrowser,
    this.enableMask,
    this.enableMsdfs,
    this.enableMultichannel,
    this.enableNtlmv1Auth,
    this.enableOpLock,
    this.enableResetOnZeroVc,
    this.enableSamba,
    this.enableServerSigning,
    this.enableSmb2Leases,
    this.enableStrictSync,
    this.enableSymlink,
    this.enableSynoCatia,
    this.enableSynotify,
    this.enableVetofile,
    this.enableWidelink,
    this.offlineFilesSupport,
    this.smbEncryptTransport,
    this.smbMaxProtocol,
    this.smbMinProtocol,
    this.synoWildcardSearch,
    this.vetofile,
    this.wins,
    this.workgroup,
  });

  Smb.fromJson(dynamic json) {
    disableShadowCopy = json['disable_shadow_copy'];
    disableStrictAllocate = json['disable_strict_allocate'];
    enableAccessBasedShareEnum = json['enable_access_based_share_enum'];
    enableAdserver = json['enable_adserver'];
    enableAioRead = json['enable_aio_read'];
    enableDeleteVetofiles = json['enable_delete_vetofiles'];
    enableDirsort = json['enable_dirsort'];
    enableDurableHandles = json['enable_durable_handles'];
    enableEnhanceLog = json['enable_enhance_log'];
    enableFruitLocking = json['enable_fruit_locking'];
    enableLocalMasterBrowser = json['enable_local_master_browser'];
    enableMask = json['enable_mask'];
    enableMsdfs = json['enable_msdfs'];
    enableMultichannel = json['enable_multichannel'];
    enableNtlmv1Auth = json['enable_ntlmv1_auth'];
    enableOpLock = json['enable_op_lock'];
    enableResetOnZeroVc = json['enable_reset_on_zero_vc'];
    enableSamba = json['enable_samba'];
    enableServerSigning = json['enable_server_signing'];
    enableSmb2Leases = json['enable_smb2_leases'];
    enableStrictSync = json['enable_strict_sync'];
    enableSymlink = json['enable_symlink'];
    enableSynoCatia = json['enable_syno_catia'];
    enableSynotify = json['enable_synotify'];
    enableVetofile = json['enable_vetofile'];
    enableWidelink = json['enable_widelink'];
    offlineFilesSupport = json['offline_files_support'];
    smbEncryptTransport = json['smb_encrypt_transport'];
    smbMaxProtocol = json['smb_max_protocol'];
    smbMinProtocol = json['smb_min_protocol'];
    synoWildcardSearch = json['syno_wildcard_search'];
    vetofile = json['vetofile'];
    wins = json['wins'];
    workgroup = json['workgroup'];
  }

  String? api = "SYNO.Core.FileServ.SMB";
  String? method = "get";
  int? version = 3;

  bool? disableShadowCopy;
  bool? disableStrictAllocate;
  bool? enableAccessBasedShareEnum;
  bool? enableAdserver;
  bool? enableAioRead;
  bool? enableDeleteVetofiles;
  bool? enableDirsort;
  bool? enableDurableHandles;
  bool? enableEnhanceLog;
  bool? enableFruitLocking;
  bool? enableLocalMasterBrowser;
  bool? enableMask;
  bool? enableMsdfs;
  bool? enableMultichannel;
  bool? enableNtlmv1Auth;
  bool? enableOpLock;
  bool? enableResetOnZeroVc;
  bool? enableSamba;
  int? enableServerSigning;
  bool? enableSmb2Leases;
  bool? enableStrictSync;
  bool? enableSymlink;
  bool? enableSynoCatia;
  bool? enableSynotify;
  bool? enableVetofile;
  bool? enableWidelink;
  bool? offlineFilesSupport;
  int? smbEncryptTransport;
  int? smbMaxProtocol;
  int? smbMinProtocol;
  bool? synoWildcardSearch;
  String? vetofile;
  String? wins;
  String? workgroup;
  Smb copyWith({
    bool? disableShadowCopy,
    bool? disableStrictAllocate,
    bool? enableAccessBasedShareEnum,
    bool? enableAdserver,
    bool? enableAioRead,
    bool? enableDeleteVetofiles,
    bool? enableDirsort,
    bool? enableDurableHandles,
    bool? enableEnhanceLog,
    bool? enableFruitLocking,
    bool? enableLocalMasterBrowser,
    bool? enableMask,
    bool? enableMsdfs,
    bool? enableMultichannel,
    bool? enableNtlmv1Auth,
    bool? enableOpLock,
    bool? enableResetOnZeroVc,
    bool? enableSamba,
    int? enableServerSigning,
    bool? enableSmb2Leases,
    bool? enableStrictSync,
    bool? enableSymlink,
    bool? enableSynoCatia,
    bool? enableSynotify,
    bool? enableVetofile,
    bool? enableWidelink,
    bool? offlineFilesSupport,
    int? smbEncryptTransport,
    int? smbMaxProtocol,
    int? smbMinProtocol,
    bool? synoWildcardSearch,
    String? vetofile,
    String? wins,
    String? workgroup,
  }) =>
      Smb(
        disableShadowCopy: disableShadowCopy ?? this.disableShadowCopy,
        disableStrictAllocate: disableStrictAllocate ?? this.disableStrictAllocate,
        enableAccessBasedShareEnum: enableAccessBasedShareEnum ?? this.enableAccessBasedShareEnum,
        enableAdserver: enableAdserver ?? this.enableAdserver,
        enableAioRead: enableAioRead ?? this.enableAioRead,
        enableDeleteVetofiles: enableDeleteVetofiles ?? this.enableDeleteVetofiles,
        enableDirsort: enableDirsort ?? this.enableDirsort,
        enableDurableHandles: enableDurableHandles ?? this.enableDurableHandles,
        enableEnhanceLog: enableEnhanceLog ?? this.enableEnhanceLog,
        enableFruitLocking: enableFruitLocking ?? this.enableFruitLocking,
        enableLocalMasterBrowser: enableLocalMasterBrowser ?? this.enableLocalMasterBrowser,
        enableMask: enableMask ?? this.enableMask,
        enableMsdfs: enableMsdfs ?? this.enableMsdfs,
        enableMultichannel: enableMultichannel ?? this.enableMultichannel,
        enableNtlmv1Auth: enableNtlmv1Auth ?? this.enableNtlmv1Auth,
        enableOpLock: enableOpLock ?? this.enableOpLock,
        enableResetOnZeroVc: enableResetOnZeroVc ?? this.enableResetOnZeroVc,
        enableSamba: enableSamba ?? this.enableSamba,
        enableServerSigning: enableServerSigning ?? this.enableServerSigning,
        enableSmb2Leases: enableSmb2Leases ?? this.enableSmb2Leases,
        enableStrictSync: enableStrictSync ?? this.enableStrictSync,
        enableSymlink: enableSymlink ?? this.enableSymlink,
        enableSynoCatia: enableSynoCatia ?? this.enableSynoCatia,
        enableSynotify: enableSynotify ?? this.enableSynotify,
        enableVetofile: enableVetofile ?? this.enableVetofile,
        enableWidelink: enableWidelink ?? this.enableWidelink,
        offlineFilesSupport: offlineFilesSupport ?? this.offlineFilesSupport,
        smbEncryptTransport: smbEncryptTransport ?? this.smbEncryptTransport,
        smbMaxProtocol: smbMaxProtocol ?? this.smbMaxProtocol,
        smbMinProtocol: smbMinProtocol ?? this.smbMinProtocol,
        synoWildcardSearch: synoWildcardSearch ?? this.synoWildcardSearch,
        vetofile: vetofile ?? this.vetofile,
        wins: wins ?? this.wins,
        workgroup: workgroup ?? this.workgroup,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['disable_shadow_copy'] = disableShadowCopy;
    map['disable_strict_allocate'] = disableStrictAllocate;
    map['enable_access_based_share_enum'] = enableAccessBasedShareEnum;
    map['enable_adserver'] = enableAdserver;
    map['enable_aio_read'] = enableAioRead;
    map['enable_delete_vetofiles'] = enableDeleteVetofiles;
    map['enable_dirsort'] = enableDirsort;
    map['enable_durable_handles'] = enableDurableHandles;
    map['enable_enhance_log'] = enableEnhanceLog;
    map['enable_fruit_locking'] = enableFruitLocking;
    map['enable_local_master_browser'] = enableLocalMasterBrowser;
    map['enable_mask'] = enableMask;
    map['enable_msdfs'] = enableMsdfs;
    map['enable_multichannel'] = enableMultichannel;
    map['enable_ntlmv1_auth'] = enableNtlmv1Auth;
    map['enable_op_lock'] = enableOpLock;
    map['enable_reset_on_zero_vc'] = enableResetOnZeroVc;
    map['enable_samba'] = enableSamba;
    map['enable_server_signing'] = enableServerSigning;
    map['enable_smb2_leases'] = enableSmb2Leases;
    map['enable_strict_sync'] = enableStrictSync;
    map['enable_symlink'] = enableSymlink;
    map['enable_syno_catia'] = enableSynoCatia;
    map['enable_synotify'] = enableSynotify;
    map['enable_vetofile'] = enableVetofile;
    map['enable_widelink'] = enableWidelink;
    map['offline_files_support'] = offlineFilesSupport;
    map['smb_encrypt_transport'] = smbEncryptTransport;
    map['smb_max_protocol'] = smbMaxProtocol;
    map['smb_min_protocol'] = smbMinProtocol;
    map['syno_wildcard_search'] = synoWildcardSearch;
    map['vetofile'] = vetofile;
    map['wins'] = wins;
    map['workgroup'] = workgroup;
    return map;
  }

  @override
  fromJson(json) {
    return Smb.fromJson(json);
  }
}
