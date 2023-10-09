import 'package:dsm_helper/apis/api.dart';

/// offset : 0
/// total : 3
/// volumes : [{"atime_checked":false,"atime_opt":"relatime","container":"internal","crashed":false,"deduped":false,"description":"","display_name":"存储空间 1","fs_type":"btrfs","location":"internal","pool_path":"reuse_1","raid_type":"shr_without_disk_protect","readonly":false,"single_volume":false,"size_free_byte":"13429136093184","size_total_byte":"13429160144896","status":"normal","volume_attribute":"generic","volume_id":1,"volume_path":"/volume1","volume_quota_status":"v2","volume_quota_update_progress":-1},{"atime_checked":false,"atime_opt":"relatime","container":"internal","crashed":false,"deduped":false,"description":"","display_name":"存储空间 3","fs_type":"btrfs","location":"internal","pool_path":"reuse_3","raid_type":"shr_without_disk_protect","readonly":false,"single_volume":true,"size_free_byte":"36847812608","size_total_byte":"2875817492480","status":"attention","volume_attribute":"generic","volume_id":3,"volume_path":"/volume3","volume_quota_status":"v1","volume_quota_update_progress":-1},{"atime_checked":false,"atime_opt":"relatime","container":"internal","crashed":false,"deduped":false,"description":"","display_name":"存储空间 4","fs_type":"btrfs","location":"internal","pool_path":"reuse_4","raid_type":"shr_without_disk_protect","readonly":false,"single_volume":true,"size_free_byte":"164999397376","size_total_byte":"11515377745920","status":"attention","volume_attribute":"generic","volume_id":4,"volume_path":"/volume4","volume_quota_status":"v1","volume_quota_update_progress":-1}]

class Volume {
  Volume({
    this.offset,
    this.total,
    this.volumes,
  });

  static Future<Volume> list() async {
    DsmResponse res = await Api.dsm.entry(
      "SYNO.Core.Storage.Volume",
      "list",
      version: 1,
      data: {
        "limit": -1,
        "offset": 0,
        "location": "internal",
      },
      parser: Volume.fromJson,
    );
    return res.data;
  }

  Volume.fromJson(dynamic json) {
    offset = json['offset'];
    total = json['total'];
    if (json['volumes'] != null) {
      volumes = [];
      json['volumes'].forEach((v) {
        volumes?.add(Volumes.fromJson(v));
      });
    }
  }
  int? offset;
  int? total;
  List<Volumes>? volumes;
  Volume copyWith({
    int? offset,
    int? total,
    List<Volumes>? volumes,
  }) =>
      Volume(
        offset: offset ?? this.offset,
        total: total ?? this.total,
        volumes: volumes ?? this.volumes,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['offset'] = offset;
    map['total'] = total;
    if (volumes != null) {
      map['volumes'] = volumes?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// atime_checked : false
/// atime_opt : "relatime"
/// container : "internal"
/// crashed : false
/// deduped : false
/// description : ""
/// display_name : "存储空间 1"
/// fs_type : "btrfs"
/// location : "internal"
/// pool_path : "reuse_1"
/// raid_type : "shr_without_disk_protect"
/// readonly : false
/// single_volume : false
/// size_free_byte : "13429136093184"
/// size_total_byte : "13429160144896"
/// status : "normal"
/// volume_attribute : "generic"
/// volume_id : 1
/// volume_path : "/volume1"
/// volume_quota_status : "v2"
/// volume_quota_update_progress : -1

class Volumes {
  Volumes({
    this.atimeChecked,
    this.atimeOpt,
    this.container,
    this.crashed,
    this.deduped,
    this.description,
    this.displayName,
    this.fsType,
    this.location,
    this.poolPath,
    this.raidType,
    this.readonly,
    this.singleVolume,
    this.sizeFreeByte,
    this.sizeTotalByte,
    this.status,
    this.volumeAttribute,
    this.volumeId,
    this.volumePath,
    this.volumeQuotaStatus,
    this.volumeQuotaUpdateProgress,
  });

  Volumes.fromJson(dynamic json) {
    atimeChecked = json['atime_checked'];
    atimeOpt = json['atime_opt'];
    container = json['container'];
    crashed = json['crashed'];
    deduped = json['deduped'];
    description = json['description'];
    displayName = json['display_name'];
    fsType = json['fs_type'];
    location = json['location'];
    poolPath = json['pool_path'];
    raidType = json['raid_type'];
    readonly = json['readonly'];
    singleVolume = json['single_volume'];
    sizeFreeByte = json['size_free_byte'];
    sizeTotalByte = json['size_total_byte'];
    status = json['status'];
    volumeAttribute = json['volume_attribute'];
    volumeId = json['volume_id'];
    volumePath = json['volume_path'];
    volumeQuotaStatus = json['volume_quota_status'];
    volumeQuotaUpdateProgress = json['volume_quota_update_progress'];
  }
  bool? atimeChecked;
  String? atimeOpt;
  String? container;
  bool? crashed;
  bool? deduped;
  String? description;
  String? displayName;
  String? fsType;
  String? location;
  String? poolPath;
  String? raidType;
  bool? readonly;
  bool? singleVolume;
  String? sizeFreeByte;
  String? sizeTotalByte;
  String? status;
  String? volumeAttribute;
  int? volumeId;
  String? volumePath;
  String? volumeQuotaStatus;
  int? volumeQuotaUpdateProgress;
  Volumes copyWith({
    bool? atimeChecked,
    String? atimeOpt,
    String? container,
    bool? crashed,
    bool? deduped,
    String? description,
    String? displayName,
    String? fsType,
    String? location,
    String? poolPath,
    String? raidType,
    bool? readonly,
    bool? singleVolume,
    String? sizeFreeByte,
    String? sizeTotalByte,
    String? status,
    String? volumeAttribute,
    int? volumeId,
    String? volumePath,
    String? volumeQuotaStatus,
    int? volumeQuotaUpdateProgress,
  }) =>
      Volumes(
        atimeChecked: atimeChecked ?? this.atimeChecked,
        atimeOpt: atimeOpt ?? this.atimeOpt,
        container: container ?? this.container,
        crashed: crashed ?? this.crashed,
        deduped: deduped ?? this.deduped,
        description: description ?? this.description,
        displayName: displayName ?? this.displayName,
        fsType: fsType ?? this.fsType,
        location: location ?? this.location,
        poolPath: poolPath ?? this.poolPath,
        raidType: raidType ?? this.raidType,
        readonly: readonly ?? this.readonly,
        singleVolume: singleVolume ?? this.singleVolume,
        sizeFreeByte: sizeFreeByte ?? this.sizeFreeByte,
        sizeTotalByte: sizeTotalByte ?? this.sizeTotalByte,
        status: status ?? this.status,
        volumeAttribute: volumeAttribute ?? this.volumeAttribute,
        volumeId: volumeId ?? this.volumeId,
        volumePath: volumePath ?? this.volumePath,
        volumeQuotaStatus: volumeQuotaStatus ?? this.volumeQuotaStatus,
        volumeQuotaUpdateProgress: volumeQuotaUpdateProgress ?? this.volumeQuotaUpdateProgress,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['atime_checked'] = atimeChecked;
    map['atime_opt'] = atimeOpt;
    map['container'] = container;
    map['crashed'] = crashed;
    map['deduped'] = deduped;
    map['description'] = description;
    map['display_name'] = displayName;
    map['fs_type'] = fsType;
    map['location'] = location;
    map['pool_path'] = poolPath;
    map['raid_type'] = raidType;
    map['readonly'] = readonly;
    map['single_volume'] = singleVolume;
    map['size_free_byte'] = sizeFreeByte;
    map['size_total_byte'] = sizeTotalByte;
    map['status'] = status;
    map['volume_attribute'] = volumeAttribute;
    map['volume_id'] = volumeId;
    map['volume_path'] = volumePath;
    map['volume_quota_status'] = volumeQuotaStatus;
    map['volume_quota_update_progress'] = volumeQuotaUpdateProgress;
    return map;
  }
}
