/// devices : [{"dev_id":"sdq","dev_title":"USB Disk 1","dev_type":"usbDisk","partitions":[{"dev_fstype":"exfat","filesystem":"","name_id":"sdq1","partition_title":"USB Disk 1 Partition 1","share_name":"","status":"normal","total_size_mb":29999,"used_size_mb":0},{"dev_fstype":"vfat","filesystem":"","name_id":"sdq2","partition_title":"USB Disk 1 Partition 2","share_name":"","status":"normal","total_size_mb":32,"used_size_mb":0}],"product":"Teclast CoolFlash","status":"init"}]

class Device {
  Device({
    this.devices,
  });

  Device.fromJson(dynamic json) {
    if (json['devices'] != null) {
      devices = [];
      json['devices'].forEach((v) {
        devices?.add(Devices.fromJson(v));
      });
    }
  }
  List<Devices>? devices;
  Device copyWith({
    List<Devices>? devices,
  }) =>
      Device(
        devices: devices ?? this.devices,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (devices != null) {
      map['devices'] = devices?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// dev_id : "sdq"
/// dev_title : "USB Disk 1"
/// dev_type : "usbDisk"
/// partitions : [{"dev_fstype":"exfat","filesystem":"","name_id":"sdq1","partition_title":"USB Disk 1 Partition 1","share_name":"","status":"normal","total_size_mb":29999,"used_size_mb":0},{"dev_fstype":"vfat","filesystem":"","name_id":"sdq2","partition_title":"USB Disk 1 Partition 2","share_name":"","status":"normal","total_size_mb":32,"used_size_mb":0}]
/// product : "Teclast CoolFlash"
/// status : "init"

class Devices {
  Devices({
    this.devId,
    this.devTitle,
    this.devType,
    this.partitions,
    this.product,
    this.status,
  });

  Devices.fromJson(dynamic json) {
    devId = json['dev_id'];
    devTitle = json['dev_title'];
    devType = json['dev_type'];
    if (json['partitions'] != null) {
      partitions = [];
      json['partitions'].forEach((v) {
        partitions?.add(Partitions.fromJson(v));
      });
    }
    product = json['product'];
    status = json['status'];
  }
  String? devId;
  String? devTitle;
  String? devType;
  List<Partitions>? partitions;
  String? product;
  String? status; // init 初始化中 normal 正常运作
  Devices copyWith({
    String? devId,
    String? devTitle,
    String? devType,
    List<Partitions>? partitions,
    String? product,
    String? status,
  }) =>
      Devices(
        devId: devId ?? this.devId,
        devTitle: devTitle ?? this.devTitle,
        devType: devType ?? this.devType,
        partitions: partitions ?? this.partitions,
        product: product ?? this.product,
        status: status ?? this.status,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['dev_id'] = devId;
    map['dev_title'] = devTitle;
    map['dev_type'] = devType;
    if (partitions != null) {
      map['partitions'] = partitions?.map((v) => v.toJson()).toList();
    }
    map['product'] = product;
    map['status'] = status;
    return map;
  }
}

/// dev_fstype : "exfat"
/// filesystem : ""
/// name_id : "sdq1"
/// partition_title : "USB Disk 1 Partition 1"
/// share_name : ""
/// status : "normal"
/// total_size_mb : 29999
/// used_size_mb : 0

class Partitions {
  Partitions({
    this.devFstype,
    this.filesystem,
    this.nameId,
    this.partitionTitle,
    this.shareName,
    this.status,
    this.totalSizeMb,
    this.usedSizeMb,
  });

  Partitions.fromJson(dynamic json) {
    devFstype = json['dev_fstype'];
    filesystem = json['filesystem'];
    nameId = json['name_id'];
    partitionTitle = json['partition_title'];
    shareName = json['share_name'];
    status = json['status'];
    totalSizeMb = json['total_size_mb'];
    usedSizeMb = json['used_size_mb'];
  }
  String? devFstype;
  String? filesystem;
  String? nameId;
  String? partitionTitle;
  String? shareName;
  String? status;
  num? totalSizeMb;
  num? usedSizeMb;
  Partitions copyWith({
    String? devFstype,
    String? filesystem,
    String? nameId,
    String? partitionTitle,
    String? shareName,
    String? status,
    num? totalSizeMb,
    num? usedSizeMb,
  }) =>
      Partitions(
        devFstype: devFstype ?? this.devFstype,
        filesystem: filesystem ?? this.filesystem,
        nameId: nameId ?? this.nameId,
        partitionTitle: partitionTitle ?? this.partitionTitle,
        shareName: shareName ?? this.shareName,
        status: status ?? this.status,
        totalSizeMb: totalSizeMb ?? this.totalSizeMb,
        usedSizeMb: usedSizeMb ?? this.usedSizeMb,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['dev_fstype'] = devFstype;
    map['filesystem'] = filesystem;
    map['name_id'] = nameId;
    map['partition_title'] = partitionTitle;
    map['share_name'] = shareName;
    map['status'] = status;
    map['total_size_mb'] = totalSizeMb;
    map['used_size_mb'] = usedSizeMb;
    return map;
  }
}
