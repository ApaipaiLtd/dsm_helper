import 'dart:convert';

import 'package:dsm_helper/apis/api.dart';
import 'package:dsm_helper/apis/dsm_api/dsm_exception.dart';
import 'package:dsm_helper/models/Syno/Core/Storage/Volume.dart';

/// shares : [{"desc":"","enable_recycle_bin":false,"enable_share_compress":false,"enable_share_cow":true,"enc_auto_mount":false,"encryption":0,"force_readonly_reason":"","hidden":false,"is_aclmode":true,"is_applying_settings":false,"is_block_snap_action":false,"is_c2_share":false,"is_cluster_share":false,"is_cold_storage_share":false,"is_exfat_share":false,"is_force_readonly":false,"is_missing_share":false,"is_offline_share":false,"is_share_moving":false,"is_support_acl":true,"is_sync_share":false,"is_usb_share":false,"name":"docker","quota_value":0,"recycle_bin_admin_only":false,"share_quota_logical_size":10124.75390625,"share_quota_status":"v1","share_quota_used":10124.75390625,"support_action":511,"support_compression_ratio":false,"support_snapshot":true,"task_id":"","unite_permission":false,"uuid":"772aceda-1aaa-4e71-b45b-119e4fb48c49","vol_path":"/volume3"},{"desc":"","enable_recycle_bin":false,"enable_share_compress":false,"enable_share_cow":true,"enc_auto_mount":false,"encryption":0,"force_readonly_reason":"","hidden":false,"is_aclmode":true,"is_applying_settings":false,"is_block_snap_action":false,"is_c2_share":false,"is_cluster_share":false,"is_cold_storage_share":false,"is_exfat_share":false,"is_force_readonly":false,"is_missing_share":false,"is_offline_share":false,"is_share_moving":false,"is_support_acl":true,"is_sync_share":false,"is_usb_share":false,"name":"Download","quota_value":0,"recycle_bin_admin_only":false,"share_quota_logical_size":0,"share_quota_status":"v1","share_quota_used":0,"support_action":511,"support_compression_ratio":false,"support_snapshot":true,"task_id":"","unite_permission":false,"uuid":"fe44c533-edf4-464c-921f-369bdd317fd7","vol_path":"/volume4"},{"desc":"","enable_recycle_bin":false,"enable_share_compress":false,"enable_share_cow":false,"enc_auto_mount":false,"encryption":0,"force_readonly_reason":"","hidden":false,"is_aclmode":true,"is_applying_settings":false,"is_block_snap_action":false,"is_c2_share":false,"is_cluster_share":false,"is_cold_storage_share":false,"is_exfat_share":false,"is_force_readonly":false,"is_missing_share":false,"is_offline_share":false,"is_share_moving":false,"is_support_acl":true,"is_sync_share":false,"is_usb_share":false,"name":"Downloads","quota_value":10240,"recycle_bin_admin_only":false,"share_quota_logical_size":1.078125,"share_quota_status":"v1","share_quota_used":1.078125,"support_action":511,"support_compression_ratio":false,"support_snapshot":true,"task_id":"","unite_permission":false,"uuid":"94190d50-f7b7-4906-80b6-206bbf8f8428","vol_path":"/volume3"},{"desc":"homes contains all users' home","enable_recycle_bin":false,"enable_share_compress":false,"enable_share_cow":true,"enc_auto_mount":false,"encryption":0,"force_readonly_reason":"","hidden":false,"is_aclmode":true,"is_applying_settings":false,"is_block_snap_action":false,"is_c2_share":false,"is_cluster_share":false,"is_cold_storage_share":false,"is_exfat_share":false,"is_force_readonly":false,"is_missing_share":false,"is_offline_share":false,"is_share_moving":false,"is_support_acl":true,"is_sync_share":false,"is_usb_share":false,"name":"homes","quota_value":0,"recycle_bin_admin_only":false,"share_quota_logical_size":24047,"share_quota_status":"v1","share_quota_used":24047,"support_action":511,"support_compression_ratio":false,"support_snapshot":true,"task_id":"","unite_permission":false,"uuid":"2c58ca52-f7e6-4846-ad4f-f2dd67122000","vol_path":"/volume3"},{"desc":"","enable_recycle_bin":false,"enable_share_compress":false,"enable_share_cow":false,"enc_auto_mount":false,"encryption":0,"force_readonly_reason":"","hidden":false,"is_aclmode":true,"is_applying_settings":false,"is_block_snap_action":false,"is_c2_share":false,"is_cluster_share":false,"is_cold_storage_share":false,"is_exfat_share":false,"is_force_readonly":false,"is_missing_share":false,"is_offline_share":false,"is_share_moving":false,"is_support_acl":true,"is_sync_share":false,"is_usb_share":false,"name":"Others","quota_value":0,"recycle_bin_admin_only":false,"share_quota_logical_size":351701.4375,"share_quota_status":"v1","share_quota_used":351701.4375,"support_action":511,"support_compression_ratio":false,"support_snapshot":true,"task_id":"","unite_permission":false,"uuid":"6392a3a4-8591-49e6-87f1-17ca4ee620cc","vol_path":"/volume4"},{"desc":"System default shared folder","enable_recycle_bin":false,"enable_share_compress":false,"enable_share_cow":true,"enc_auto_mount":false,"encryption":0,"force_readonly_reason":"","hidden":false,"is_aclmode":true,"is_applying_settings":false,"is_block_snap_action":false,"is_c2_share":false,"is_cluster_share":false,"is_cold_storage_share":false,"is_exfat_share":false,"is_force_readonly":false,"is_missing_share":false,"is_offline_share":false,"is_share_moving":false,"is_support_acl":true,"is_sync_share":false,"is_usb_share":false,"name":"photo","quota_value":0,"recycle_bin_admin_only":false,"share_quota_logical_size":2662891,"share_quota_status":"v1","share_quota_used":2662891,"support_action":511,"support_compression_ratio":false,"support_snapshot":true,"task_id":"","unite_permission":false,"uuid":"5de7070c-8d31-4edc-b729-1b5a74fffb15","vol_path":"/volume3"},{"desc":"","enable_recycle_bin":false,"enable_share_compress":false,"enable_share_cow":false,"enc_auto_mount":false,"encryption":0,"force_readonly_reason":"","hidden":false,"is_aclmode":true,"is_applying_settings":false,"is_block_snap_action":false,"is_c2_share":false,"is_cluster_share":false,"is_cold_storage_share":false,"is_exfat_share":false,"is_force_readonly":false,"is_missing_share":false,"is_offline_share":false,"is_share_moving":false,"is_support_acl":true,"is_sync_share":false,"is_usb_share":false,"name":"下载","quota_value":0,"recycle_bin_admin_only":false,"share_quota_logical_size":1113645.875,"share_quota_status":"v1","share_quota_used":1113645.875,"support_action":511,"support_compression_ratio":false,"support_snapshot":true,"task_id":"","unite_permission":false,"uuid":"2836be6b-3799-4c22-ba46-5ddf3f5f0fec","vol_path":"/volume4"},{"desc":"","enable_recycle_bin":false,"enable_share_compress":false,"enable_share_cow":false,"enc_auto_mount":false,"encryption":0,"force_readonly_reason":"","hidden":false,"is_aclmode":true,"is_applying_settings":false,"is_block_snap_action":false,"is_c2_share":false,"is_cluster_share":false,"is_cold_storage_share":false,"is_exfat_share":false,"is_force_readonly":false,"is_missing_share":false,"is_offline_share":false,"is_share_moving":false,"is_support_acl":true,"is_sync_share":false,"is_usb_share":false,"name":"图片空间","quota_value":0,"recycle_bin_admin_only":false,"share_quota_logical_size":1952.72265625,"share_quota_status":"v1","share_quota_used":1952.72265625,"support_action":511,"support_compression_ratio":false,"support_snapshot":true,"task_id":"","unite_permission":false,"uuid":"c8881238-6957-409a-8547-093f79606222","vol_path":"/volume3"},{"desc":"","enable_recycle_bin":false,"enable_share_compress":false,"enable_share_cow":false,"enc_auto_mount":false,"encryption":0,"force_readonly_reason":"","hidden":false,"is_aclmode":true,"is_applying_settings":false,"is_block_snap_action":false,"is_c2_share":false,"is_cluster_share":false,"is_cold_storage_share":false,"is_exfat_share":false,"is_force_readonly":false,"is_missing_share":false,"is_offline_share":false,"is_share_moving":false,"is_support_acl":true,"is_sync_share":false,"is_usb_share":false,"name":"影视","quota_value":0,"recycle_bin_admin_only":false,"share_quota_logical_size":4994268.5,"share_quota_status":"v1","share_quota_used":4994268.5,"support_action":511,"support_compression_ratio":false,"support_snapshot":true,"task_id":"","unite_permission":false,"uuid":"fecb8efe-de3f-48e3-b29b-0ff321219732","vol_path":"/volume4"},{"desc":"","enable_recycle_bin":false,"enable_share_compress":false,"enable_share_cow":false,"enc_auto_mount":false,"encryption":0,"force_readonly_reason":"","hidden":false,"is_aclmode":true,"is_applying_settings":false,"is_block_snap_action":false,"is_c2_share":false,"is_cluster_share":false,"is_cold_storage_share":false,"is_exfat_share":false,"is_force_readonly":false,"is_missing_share":false,"is_offline_share":false,"is_share_moving":false,"is_support_acl":true,"is_sync_share":false,"is_usb_share":false,"name":"视频","quota_value":0,"recycle_bin_admin_only":false,"share_quota_logical_size":4095597.5,"share_quota_status":"v1","share_quota_used":4095597.5,"support_action":511,"support_compression_ratio":false,"support_snapshot":true,"task_id":"","unite_permission":false,"uuid":"4af1e5d7-4aaf-4153-b50f-adc7503609ae","vol_path":"/volume4"}]
/// total : 10

class Share {
  Share({
    this.shares,
    this.total,
  });

  static Future<Share> list() async {
    DsmResponse res = await Api.dsm.entry(
      "SYNO.Core.Share",
      "list",
      version: 1,
      data: {
        "additional": jsonEncode([
          "hidden",
          "encryption",
          "is_aclmode",
          "unite_permission",
          "is_support_acl",
          "is_sync_share",
          "is_force_readonly",
          "force_readonly_reason",
          "recyclebin",
          "is_share_moving",
          "is_cluster_share",
          "is_exfat_share",
          "is_c2_share",
          "is_cold_storage_share",
          "is_missing_share",
          "is_offline_share",
          "support_snapshot",
          "share_quota",
          "enable_share_compress",
          "enable_share_cow",
          "include_cold_storage_share",
          "is_cold_storage_share",
          "include_missing_share",
          "is_missing_share",
          "include_offline_share",
          "is_offline_share"
        ]),
      },
      parser: Share.fromJson,
    );
    return res.data;
  }

  Share.fromJson(dynamic json) {
    if (json['shares'] != null) {
      shares = [];
      json['shares'].forEach((v) {
        shares?.add(Shares.fromJson(v));
      });
    }
    total = json['total'];
  }
  List<Shares>? shares;
  int? total;
  Share copyWith({
    List<Shares>? shares,
    int? total,
  }) =>
      Share(
        shares: shares ?? this.shares,
        total: total ?? this.total,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (shares != null) {
      map['shares'] = shares?.map((v) => v.toJson()).toList();
    }
    map['total'] = total;
    return map;
  }
}

/// desc : ""
/// enable_recycle_bin : false
/// enable_share_compress : false
/// enable_share_cow : true
/// enc_auto_mount : false
/// encryption : 0
/// force_readonly_reason : ""
/// hidden : false
/// is_aclmode : true
/// is_applying_settings : false
/// is_block_snap_action : false
/// is_c2_share : false
/// is_cluster_share : false
/// is_cold_storage_share : false
/// is_exfat_share : false
/// is_force_readonly : false
/// is_missing_share : false
/// is_offline_share : false
/// is_share_moving : false
/// is_support_acl : true
/// is_sync_share : false
/// is_usb_share : false
/// name : "docker"
/// quota_value : 0
/// recycle_bin_admin_only : false
/// share_quota_logical_size : 10124.75390625
/// share_quota_status : "v1"
/// share_quota_used : 10124.75390625
/// support_action : 511
/// support_compression_ratio : false
/// support_snapshot : true
/// task_id : ""
/// unite_permission : false
/// uuid : "772aceda-1aaa-4e71-b45b-119e4fb48c49"
/// vol_path : "/volume3"

class Shares {
  Shares({
    this.desc,
    this.enableRecycleBin,
    this.enableShareCompress,
    this.enableShareCow,
    this.encAutoMount,
    this.encryption,
    this.forceReadonlyReason,
    this.hidden,
    this.hideUnreadable,
    this.isAclmode,
    this.isApplyingSettings,
    this.isBlockSnapAction,
    this.isC2Share,
    this.isClusterShare,
    this.isColdStorageShare,
    this.isExfatShare,
    this.isForceReadonly,
    this.isMissingShare,
    this.isOfflineShare,
    this.isShareMoving,
    this.isSupportAcl,
    this.isSyncShare,
    this.isUsbShare,
    this.name,
    this.quotaValue,
    this.recycleBinAdminOnly,
    this.shareQuotaLogicalSize,
    this.shareQuotaStatus,
    this.shareQuotaUsed,
    this.supportAction,
    this.supportCompressionRatio,
    this.supportSnapshot,
    this.taskId,
    this.unitePermission,
    this.uuid,
    this.volPath,
  });

  Future<bool?> delete() async {
    DsmResponse res = await Api.dsm.entry("SYNO.Core.Share", "delete", data: {"name": name});
    return res.success;
  }

  Future<bool?> cleanRecycleBin() async {
    DsmResponse res = await Api.dsm.entry("SYNO.Core.RecycleBin", "start", data: {"id": name});
    if (res.success == true) {
      return res.data['is_cleaning'];
    } else {
      throw DsmException(0, "请求失败");
    }
  }

  static Future<Shares> detail(String name) async {
    DsmResponse res = await Api.dsm.entry(
      "SYNO.Core.Share",
      "get",
      data: {
        "name": '"$name"',
        "additional": jsonEncode([
          "hidden",
          "recyclebin",
          "advance_setting",
          "encryption",
          "is_cluster_share",
          "is_cold_storage_share",
          "enable_snapshot_browsing",
          "share_quota",
          "enable_share_cow",
          "enable_share_compress",
        ]),
      },
      version: 1,
      parser: Shares.fromJson,
    );
    return res.data;
  }

  static Future<DsmResponse> add(
    String name,
    String volPath,
    String desc, {
    String oldName = "",
    bool encryption = false,
    String password = "",
    bool recycleBin = false,
    bool recycleBinAdminOnly = false,
    bool hidden = false,
    bool hideUnreadable = false,
    bool enableShareCow = false,
    bool enableShareCompress = false,
    bool enableShareQuota = false,
    String shareQuota = "",
    String? nameOrg,
    String method = "create",
  }) async {
    //"{"name":"test","vol_path":"/volume3","desc":"test","hidden":true,"enable_recycle_bin":true,"recycle_bin_admin_only":true,"hide_unreadable":true,"enable_share_cow":true,"enable_share_compress":true,"share_quota":1024,"name_org":""}"
    Map shareInfo = {
      "name": "$name",
      "vol_path": volPath,
      "desc": desc,
      "name_org": nameOrg ?? '',
      "enable_recycle_bin": recycleBin,
      "recycle_bin_admin_only": recycleBinAdminOnly,
      "encryption": encryption,
      "hidden": hidden,
      "hide_unreadable": hideUnreadable,
      "enable_share_cow": enableShareCow,
      "enable_share_compress": enableShareCow && enableShareCompress,
      if (encryption) 'enc_passwd': password,
      'share_quota': enableShareQuota ? num.parse(shareQuota) : 0
    };

    DsmResponse res = await Api.dsm.entry("SYNO.Core.Share", "$method", version: 1, data: {
      "shareinfo": jsonEncode(shareInfo),
      "name": '"${oldName.isNotEmpty ? oldName : name}"',
    });
    return res;
  }

  Shares.fromJson(dynamic json) {
    desc = json['desc'];
    enableRecycleBin = json['enable_recycle_bin'];
    enableShareCompress = json['enable_share_compress'];
    enableShareCow = json['enable_share_cow'];
    encAutoMount = json['enc_auto_mount'];
    encryption = json['encryption'];
    forceReadonlyReason = json['force_readonly_reason'];
    hidden = json['hidden'];
    hidden = json['hide_unreadable'];
    isAclmode = json['is_aclmode'];
    isApplyingSettings = json['is_applying_settings'];
    isBlockSnapAction = json['is_block_snap_action'];
    isC2Share = json['is_c2_share'];
    isClusterShare = json['is_cluster_share'];
    isColdStorageShare = json['is_cold_storage_share'];
    isExfatShare = json['is_exfat_share'];
    isForceReadonly = json['is_force_readonly'];
    isMissingShare = json['is_missing_share'];
    isOfflineShare = json['is_offline_share'];
    isShareMoving = json['is_share_moving'];
    isSupportAcl = json['is_support_acl'];
    isSyncShare = json['is_sync_share'];
    isUsbShare = json['is_usb_share'];
    name = json['name'];
    quotaValue = json['quota_value'];
    recycleBinAdminOnly = json['recycle_bin_admin_only'];
    shareQuotaLogicalSize = json['share_quota_logical_size'];
    shareQuotaStatus = json['share_quota_status'];
    shareQuotaUsed = json['share_quota_used'];
    supportAction = json['support_action'];
    supportCompressionRatio = json['support_compression_ratio'];
    supportSnapshot = json['support_snapshot'];
    taskId = json['task_id'];
    unitePermission = json['unite_permission'];
    uuid = json['uuid'];
    volPath = json['vol_path'];
  }
  String? desc;
  bool? enableRecycleBin;
  bool? enableShareCompress;
  bool? enableShareCow;
  bool? encAutoMount;
  int? encryption;
  String? forceReadonlyReason;
  bool? hidden;
  bool? hideUnreadable;
  bool? isAclmode;
  bool? isApplyingSettings;
  bool? isBlockSnapAction;
  bool? isC2Share;
  bool? isClusterShare;
  bool? isColdStorageShare;
  bool? isExfatShare;
  bool? isForceReadonly;
  bool? isMissingShare;
  bool? isOfflineShare;
  bool? isShareMoving;
  bool? isSupportAcl;
  bool? isSyncShare;
  bool? isUsbShare;
  String? name;
  num? quotaValue;
  bool? recycleBinAdminOnly;
  num? shareQuotaLogicalSize;
  String? shareQuotaStatus;
  num? shareQuotaUsed;
  num? supportAction;
  bool? supportCompressionRatio;
  bool? supportSnapshot;
  String? taskId;
  bool? unitePermission;
  String? uuid;
  String? volPath;
  Volumes? volume;
  Shares copyWith({
    String? desc,
    bool? enableRecycleBin,
    bool? enableShareCompress,
    bool? enableShareCow,
    bool? encAutoMount,
    int? encryption,
    String? forceReadonlyReason,
    bool? hidden,
    bool? isAclmode,
    bool? isApplyingSettings,
    bool? isBlockSnapAction,
    bool? isC2Share,
    bool? isClusterShare,
    bool? isColdStorageShare,
    bool? isExfatShare,
    bool? isForceReadonly,
    bool? isMissingShare,
    bool? isOfflineShare,
    bool? isShareMoving,
    bool? isSupportAcl,
    bool? isSyncShare,
    bool? isUsbShare,
    String? name,
    num? quotaValue,
    bool? recycleBinAdminOnly,
    num? shareQuotaLogicalSize,
    String? shareQuotaStatus,
    num? shareQuotaUsed,
    num? supportAction,
    bool? supportCompressionRatio,
    bool? supportSnapshot,
    String? taskId,
    bool? unitePermission,
    String? uuid,
    String? volPath,
  }) =>
      Shares(
        desc: desc ?? this.desc,
        enableRecycleBin: enableRecycleBin ?? this.enableRecycleBin,
        enableShareCompress: enableShareCompress ?? this.enableShareCompress,
        enableShareCow: enableShareCow ?? this.enableShareCow,
        encAutoMount: encAutoMount ?? this.encAutoMount,
        encryption: encryption ?? this.encryption,
        forceReadonlyReason: forceReadonlyReason ?? this.forceReadonlyReason,
        hidden: hidden ?? this.hidden,
        isAclmode: isAclmode ?? this.isAclmode,
        isApplyingSettings: isApplyingSettings ?? this.isApplyingSettings,
        isBlockSnapAction: isBlockSnapAction ?? this.isBlockSnapAction,
        isC2Share: isC2Share ?? this.isC2Share,
        isClusterShare: isClusterShare ?? this.isClusterShare,
        isColdStorageShare: isColdStorageShare ?? this.isColdStorageShare,
        isExfatShare: isExfatShare ?? this.isExfatShare,
        isForceReadonly: isForceReadonly ?? this.isForceReadonly,
        isMissingShare: isMissingShare ?? this.isMissingShare,
        isOfflineShare: isOfflineShare ?? this.isOfflineShare,
        isShareMoving: isShareMoving ?? this.isShareMoving,
        isSupportAcl: isSupportAcl ?? this.isSupportAcl,
        isSyncShare: isSyncShare ?? this.isSyncShare,
        isUsbShare: isUsbShare ?? this.isUsbShare,
        name: name ?? this.name,
        quotaValue: quotaValue ?? this.quotaValue,
        recycleBinAdminOnly: recycleBinAdminOnly ?? this.recycleBinAdminOnly,
        shareQuotaLogicalSize: shareQuotaLogicalSize ?? this.shareQuotaLogicalSize,
        shareQuotaStatus: shareQuotaStatus ?? this.shareQuotaStatus,
        shareQuotaUsed: shareQuotaUsed ?? this.shareQuotaUsed,
        supportAction: supportAction ?? this.supportAction,
        supportCompressionRatio: supportCompressionRatio ?? this.supportCompressionRatio,
        supportSnapshot: supportSnapshot ?? this.supportSnapshot,
        taskId: taskId ?? this.taskId,
        unitePermission: unitePermission ?? this.unitePermission,
        uuid: uuid ?? this.uuid,
        volPath: volPath ?? this.volPath,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['desc'] = desc;
    map['enable_recycle_bin'] = enableRecycleBin;
    map['enable_share_compress'] = enableShareCompress;
    map['enable_share_cow'] = enableShareCow;
    map['enc_auto_mount'] = encAutoMount;
    map['encryption'] = encryption;
    map['force_readonly_reason'] = forceReadonlyReason;
    map['hidden'] = hidden;
    map['is_aclmode'] = isAclmode;
    map['is_applying_settings'] = isApplyingSettings;
    map['is_block_snap_action'] = isBlockSnapAction;
    map['is_c2_share'] = isC2Share;
    map['is_cluster_share'] = isClusterShare;
    map['is_cold_storage_share'] = isColdStorageShare;
    map['is_exfat_share'] = isExfatShare;
    map['is_force_readonly'] = isForceReadonly;
    map['is_missing_share'] = isMissingShare;
    map['is_offline_share'] = isOfflineShare;
    map['is_share_moving'] = isShareMoving;
    map['is_support_acl'] = isSupportAcl;
    map['is_sync_share'] = isSyncShare;
    map['is_usb_share'] = isUsbShare;
    map['name'] = name;
    map['quota_value'] = quotaValue;
    map['recycle_bin_admin_only'] = recycleBinAdminOnly;
    map['share_quota_logical_size'] = shareQuotaLogicalSize;
    map['share_quota_status'] = shareQuotaStatus;
    map['share_quota_used'] = shareQuotaUsed;
    map['support_action'] = supportAction;
    map['support_compression_ratio'] = supportCompressionRatio;
    map['support_snapshot'] = supportSnapshot;
    map['task_id'] = taskId;
    map['unite_permission'] = unitePermission;
    map['uuid'] = uuid;
    map['vol_path'] = volPath;
    return map;
  }
}
