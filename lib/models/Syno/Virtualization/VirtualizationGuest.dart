import 'package:dsm_helper/apis/api.dart';
import 'package:dsm_helper/pages/virtual_machine/enums/guest_status_enums.dart';
import 'package:dsm_helper/pages/virtual_machine/enums/guest_status_type_enums.dart';

/// canHA : false
/// canMove : true
/// guests : [{"additional":{"gsnap_supported":{"is_host_alive":true,"is_supported":true}},"autorun":0,"birth_info":{"desc":"","from":"vmm","method":"create"},"boot_from":"disk","can_ha":true,"cpu_passthru":true,"cpu_pin_num":0,"cpu_weight":256,"desc":"","dsm_version":"DSM 7.2-64570 Update 3","guest_id":"5791b53f-6770-41b7-b4a7-b58de9399ff0","ha_status":"","ha_status_detail":"","ha_status_type":"","host_id":"a95d06e8-8e5a-41fa-8ccc-5d285efad62b","host_name":"ChallengerV","host_net_ifs":["a95d06e8-8e5a-41fa-8ccc-5d285efad62b_eth0"],"host_ram_size":8388608,"http_port":5000,"https_enable":true,"https_port":5001,"https_redirect":false,"hyperv_enlighten":false,"ip":"192.168.0.135","is_acting":false,"is_general_vm":false,"is_online":true,"is_replica_support":true,"is_rs_install":true,"iso_images":["unmounted","unmounted"],"kb_layout":"Default","max_disk_latency":0,"name":"DSM7.2","ram_used":4318692,"repo_id":"d924a622-85d6-4ecf-bee4-52a2e8ba76a5","repo_name":"ChallengerV - VM Storage 1","snap_num":0,"status":"running","status_desc":"","status_type":"healthy","total_disk_iops":1,"total_disk_throughput":0,"total_net_receive":8507,"total_net_send":19,"usb_device_name":null,"usbs":["unmounted","unmounted","unmounted","unmounted"],"use_ovmf":false,"vcpu_num":4,"vcpu_usage":60,"vdisk_num":3,"video_card":"cirrus","vram_size":4194304}]
/// is_freeze : false

class VirtualizationGuest {
  VirtualizationGuest({
    this.canHA,
    this.canMove,
    this.guests,
    this.isFreeze,
  });

  static Future<VirtualizationGuest> list() async {
    DsmResponse res = await Api.dsm.entry("SYNO.Virtualization.Guest", "list", version: 1, parser: VirtualizationGuest.fromJson);
    return res.data;
  }

  VirtualizationGuest.fromJson(dynamic json) {
    canHA = json['canHA'];
    canMove = json['canMove'];
    if (json['guests'] != null) {
      guests = [];
      json['guests'].forEach((v) {
        guests?.add(Guests.fromJson(v));
      });
    }
    isFreeze = json['is_freeze'];
  }
  bool? canHA;
  bool? canMove;
  List<Guests>? guests;
  bool? isFreeze;
  VirtualizationGuest copyWith({
    bool? canHA,
    bool? canMove,
    List<Guests>? guests,
    bool? isFreeze,
  }) =>
      VirtualizationGuest(
        canHA: canHA ?? this.canHA,
        canMove: canMove ?? this.canMove,
        guests: guests ?? this.guests,
        isFreeze: isFreeze ?? this.isFreeze,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['canHA'] = canHA;
    map['canMove'] = canMove;
    if (guests != null) {
      map['guests'] = guests?.map((v) => v.toJson()).toList();
    }
    map['is_freeze'] = isFreeze;
    return map;
  }
}

/// additional : {"gsnap_supported":{"is_host_alive":true,"is_supported":true}}
/// autorun : 0
/// birth_info : {"desc":"","from":"vmm","method":"create"}
/// boot_from : "disk"
/// can_ha : true
/// cpu_passthru : true
/// cpu_pin_num : 0
/// cpu_weight : 256
/// desc : ""
/// dsm_version : "DSM 7.2-64570 Update 3"
/// guest_id : "5791b53f-6770-41b7-b4a7-b58de9399ff0"
/// ha_status : ""
/// ha_status_detail : ""
/// ha_status_type : ""
/// host_id : "a95d06e8-8e5a-41fa-8ccc-5d285efad62b"
/// host_name : "ChallengerV"
/// host_net_ifs : ["a95d06e8-8e5a-41fa-8ccc-5d285efad62b_eth0"]
/// host_ram_size : 8388608
/// http_port : 5000
/// https_enable : true
/// https_port : 5001
/// https_redirect : false
/// hyperv_enlighten : false
/// ip : "192.168.0.135"
/// is_acting : false
/// is_general_vm : false
/// is_online : true
/// is_replica_support : true
/// is_rs_install : true
/// iso_images : ["unmounted","unmounted"]
/// kb_layout : "Default"
/// max_disk_latency : 0
/// name : "DSM7.2"
/// ram_used : 4318692
/// repo_id : "d924a622-85d6-4ecf-bee4-52a2e8ba76a5"
/// repo_name : "ChallengerV - VM Storage 1"
/// snap_num : 0
/// status : "running"
/// status_desc : ""
/// status_type : "healthy"
/// total_disk_iops : 1
/// total_disk_throughput : 0
/// total_net_receive : 8507
/// total_net_send : 19
/// usb_device_name : null
/// usbs : ["unmounted","unmounted","unmounted","unmounted"]
/// use_ovmf : false
/// vcpu_num : 4
/// vcpu_usage : 60
/// vdisk_num : 3
/// video_card : "cirrus"
/// vram_size : 4194304

class Guests {
  Guests({
    this.additional,
    this.autorun,
    this.birthInfo,
    this.bootFrom,
    this.canHa,
    this.cpuPassthru,
    this.cpuPinNum,
    this.cpuWeight,
    this.desc,
    this.dsmVersion,
    this.guestId,
    this.haStatus,
    this.haStatusDetail,
    this.haStatusType,
    this.hostId,
    this.hostName,
    this.hostNetIfs,
    this.hostRamSize,
    this.httpPort,
    this.httpsEnable,
    this.httpsPort,
    this.httpsRedirect,
    this.hypervEnlighten,
    this.ip,
    this.isActing,
    this.isGeneralVm,
    this.isOnline,
    this.isReplicaSupport,
    this.isRsInstall,
    this.isoImages,
    this.kbLayout,
    this.maxDiskLatency,
    this.name,
    this.ramUsed,
    this.repoId,
    this.repoName,
    this.snapNum,
    this.status,
    this.statusDesc,
    this.statusType,
    this.totalDiskIops,
    this.totalDiskThroughput,
    this.totalNetReceive,
    this.totalNetSend,
    this.usbDeviceName,
    this.usbs,
    this.useOvmf,
    this.vcpuNum,
    this.vcpuUsage,
    this.vdiskNum,
    this.videoCard,
    this.vramSize,
  });

  Future<bool?> power(String action) async {
    DsmResponse res = await Api.dsm.entry(
      "SYNO.Virtualization.Guest.Action",
      "pwr_ctl",
      version: 1,
      data: {
        "guest_id": '"$guestId"',
        "action": action,
      },
    );
    return res.success;
  }

  Future<bool?> canSave() async {
    DsmResponse res = await Api.dsm.entry(
      "SYNO.Virtualization.Guest.Action",
      "can_save",
      version: 1,
      data: {
        "guest_ids": '["$guestId"]',
      },
    );
    return res.success;
  }

  Future<String?> save() async {
    DsmResponse res = await Api.dsm.entry(
      "SYNO.Virtualization.Guest.Action",
      "save",
      version: 1,
      data: {
        "guest_id": '"$guestId"',
        "synovmm_ui_id": "",
      },
    );
    if (res.success == true) {
      return res.data?['task_id'];
    }
    return null;
  }

  Future<String?> restore() async {
    DsmResponse res = await Api.dsm.entry(
      "SYNO.Virtualization.Guest.Action",
      "restore",
      version: 1,
      data: {
        "guest_id": '"$guestId"',
        "synovmm_ui_id": "",
      },
    );
    if (res.success == true) {
      return res.data?['task_id'];
    }
    return null;
  }

  Guests.fromJson(dynamic json) {
    additional = json['additional'] != null ? Additional.fromJson(json['additional']) : null;
    autorun = json['autorun'];
    birthInfo = json['birth_info'] != null ? BirthInfo.fromJson(json['birth_info']) : null;
    bootFrom = json['boot_from'];
    canHa = json['can_ha'];
    cpuPassthru = json['cpu_passthru'];
    cpuPinNum = json['cpu_pin_num'];
    cpuWeight = json['cpu_weight'];
    desc = json['desc'];
    dsmVersion = json['dsm_version'];
    guestId = json['guest_id'];
    haStatus = json['ha_status'];
    haStatusDetail = json['ha_status_detail'];
    haStatusType = json['ha_status_type'];
    hostId = json['host_id'];
    hostName = json['host_name'];
    hostNetIfs = json['host_net_ifs'] != null ? json['host_net_ifs'].cast<String>() : [];
    hostRamSize = json['host_ram_size'];
    httpPort = json['http_port'];
    httpsEnable = json['https_enable'];
    httpsPort = json['https_port'];
    httpsRedirect = json['https_redirect'];
    hypervEnlighten = json['hyperv_enlighten'];
    ip = json['ip'];
    isActing = json['is_acting'];
    isGeneralVm = json['is_general_vm'];
    isOnline = json['is_online'];
    isReplicaSupport = json['is_replica_support'];
    isRsInstall = json['is_rs_install'];
    isoImages = json['iso_images'] != null ? json['iso_images'].cast<String>() : [];
    kbLayout = json['kb_layout'];
    maxDiskLatency = json['max_disk_latency'];
    name = json['name'];
    ramUsed = json['ram_used'];
    repoId = json['repo_id'];
    repoName = json['repo_name'];
    snapNum = json['snap_num'];
    status = json['status'];
    statusDesc = json['status_desc'];
    statusType = json['status_type'];
    totalDiskIops = json['total_disk_iops'];
    totalDiskThroughput = json['total_disk_throughput'];
    totalNetReceive = json['total_net_receive'];
    totalNetSend = json['total_net_send'];
    usbDeviceName = json['usb_device_name'];
    usbs = json['usbs'] != null ? json['usbs'].cast<String>() : [];
    useOvmf = json['use_ovmf'];
    vcpuNum = json['vcpu_num'];
    vcpuUsage = json['vcpu_usage'] == "" ? 0 : json['vcpu_usage'];
    vdiskNum = json['vdisk_num'];
    videoCard = json['video_card'];
    vramSize = json['vram_size'];
  }
  Additional? additional;
  num? autorun;
  BirthInfo? birthInfo;
  String? bootFrom;
  bool? canHa;
  bool? cpuPassthru;
  num? cpuPinNum;
  num? cpuWeight;
  String? desc;
  String? dsmVersion;
  String? guestId;
  String? haStatus;
  String? haStatusDetail;
  String? haStatusType;
  String? hostId;
  String? hostName;
  List<String>? hostNetIfs;
  num? hostRamSize;
  num? httpPort;
  bool? httpsEnable;
  num? httpsPort;
  bool? httpsRedirect;
  bool? hypervEnlighten;
  String? ip;
  bool? isActing;
  bool? isGeneralVm;
  bool? isOnline;
  bool? isReplicaSupport;
  bool? isRsInstall;
  List<String>? isoImages;
  String? kbLayout;
  num? maxDiskLatency;
  String? name;
  num? ramUsed;
  String? repoId;
  String? repoName;
  num? snapNum;
  String? status;
  GuestStatusEnum get statusEnum => GuestStatusEnum.fromValue(status ?? 'unknown');
  String? statusDesc;
  String? statusType;
  GuestStatusTypeEnum get statusTypeEnum => GuestStatusTypeEnum.fromValue(statusType ?? 'unknown');
  num? totalDiskIops;
  num? totalDiskThroughput;
  num? totalNetReceive;
  num? totalNetSend;
  dynamic usbDeviceName;
  List<String>? usbs;
  bool? useOvmf;
  num? vcpuNum;
  num? vcpuUsage;
  num? vdiskNum;
  String? videoCard;
  num? vramSize;
  Guests copyWith({
    Additional? additional,
    num? autorun,
    BirthInfo? birthInfo,
    String? bootFrom,
    bool? canHa,
    bool? cpuPassthru,
    num? cpuPinNum,
    num? cpuWeight,
    String? desc,
    String? dsmVersion,
    String? guestId,
    String? haStatus,
    String? haStatusDetail,
    String? haStatusType,
    String? hostId,
    String? hostName,
    List<String>? hostNetIfs,
    num? hostRamSize,
    num? httpPort,
    bool? httpsEnable,
    num? httpsPort,
    bool? httpsRedirect,
    bool? hypervEnlighten,
    String? ip,
    bool? isActing,
    bool? isGeneralVm,
    bool? isOnline,
    bool? isReplicaSupport,
    bool? isRsInstall,
    List<String>? isoImages,
    String? kbLayout,
    num? maxDiskLatency,
    String? name,
    num? ramUsed,
    String? repoId,
    String? repoName,
    num? snapNum,
    String? status,
    String? statusDesc,
    String? statusType,
    num? totalDiskIops,
    num? totalDiskThroughput,
    num? totalNetReceive,
    num? totalNetSend,
    dynamic usbDeviceName,
    List<String>? usbs,
    bool? useOvmf,
    num? vcpuNum,
    num? vcpuUsage,
    num? vdiskNum,
    String? videoCard,
    num? vramSize,
  }) =>
      Guests(
        additional: additional ?? this.additional,
        autorun: autorun ?? this.autorun,
        birthInfo: birthInfo ?? this.birthInfo,
        bootFrom: bootFrom ?? this.bootFrom,
        canHa: canHa ?? this.canHa,
        cpuPassthru: cpuPassthru ?? this.cpuPassthru,
        cpuPinNum: cpuPinNum ?? this.cpuPinNum,
        cpuWeight: cpuWeight ?? this.cpuWeight,
        desc: desc ?? this.desc,
        dsmVersion: dsmVersion ?? this.dsmVersion,
        guestId: guestId ?? this.guestId,
        haStatus: haStatus ?? this.haStatus,
        haStatusDetail: haStatusDetail ?? this.haStatusDetail,
        haStatusType: haStatusType ?? this.haStatusType,
        hostId: hostId ?? this.hostId,
        hostName: hostName ?? this.hostName,
        hostNetIfs: hostNetIfs ?? this.hostNetIfs,
        hostRamSize: hostRamSize ?? this.hostRamSize,
        httpPort: httpPort ?? this.httpPort,
        httpsEnable: httpsEnable ?? this.httpsEnable,
        httpsPort: httpsPort ?? this.httpsPort,
        httpsRedirect: httpsRedirect ?? this.httpsRedirect,
        hypervEnlighten: hypervEnlighten ?? this.hypervEnlighten,
        ip: ip ?? this.ip,
        isActing: isActing ?? this.isActing,
        isGeneralVm: isGeneralVm ?? this.isGeneralVm,
        isOnline: isOnline ?? this.isOnline,
        isReplicaSupport: isReplicaSupport ?? this.isReplicaSupport,
        isRsInstall: isRsInstall ?? this.isRsInstall,
        isoImages: isoImages ?? this.isoImages,
        kbLayout: kbLayout ?? this.kbLayout,
        maxDiskLatency: maxDiskLatency ?? this.maxDiskLatency,
        name: name ?? this.name,
        ramUsed: ramUsed ?? this.ramUsed,
        repoId: repoId ?? this.repoId,
        repoName: repoName ?? this.repoName,
        snapNum: snapNum ?? this.snapNum,
        status: status ?? this.status,
        statusDesc: statusDesc ?? this.statusDesc,
        statusType: statusType ?? this.statusType,
        totalDiskIops: totalDiskIops ?? this.totalDiskIops,
        totalDiskThroughput: totalDiskThroughput ?? this.totalDiskThroughput,
        totalNetReceive: totalNetReceive ?? this.totalNetReceive,
        totalNetSend: totalNetSend ?? this.totalNetSend,
        usbDeviceName: usbDeviceName ?? this.usbDeviceName,
        usbs: usbs ?? this.usbs,
        useOvmf: useOvmf ?? this.useOvmf,
        vcpuNum: vcpuNum ?? this.vcpuNum,
        vcpuUsage: vcpuUsage ?? this.vcpuUsage,
        vdiskNum: vdiskNum ?? this.vdiskNum,
        videoCard: videoCard ?? this.videoCard,
        vramSize: vramSize ?? this.vramSize,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (additional != null) {
      map['additional'] = additional?.toJson();
    }
    map['autorun'] = autorun;
    if (birthInfo != null) {
      map['birth_info'] = birthInfo?.toJson();
    }
    map['boot_from'] = bootFrom;
    map['can_ha'] = canHa;
    map['cpu_passthru'] = cpuPassthru;
    map['cpu_pin_num'] = cpuPinNum;
    map['cpu_weight'] = cpuWeight;
    map['desc'] = desc;
    map['dsm_version'] = dsmVersion;
    map['guest_id'] = guestId;
    map['ha_status'] = haStatus;
    map['ha_status_detail'] = haStatusDetail;
    map['ha_status_type'] = haStatusType;
    map['host_id'] = hostId;
    map['host_name'] = hostName;
    map['host_net_ifs'] = hostNetIfs;
    map['host_ram_size'] = hostRamSize;
    map['http_port'] = httpPort;
    map['https_enable'] = httpsEnable;
    map['https_port'] = httpsPort;
    map['https_redirect'] = httpsRedirect;
    map['hyperv_enlighten'] = hypervEnlighten;
    map['ip'] = ip;
    map['is_acting'] = isActing;
    map['is_general_vm'] = isGeneralVm;
    map['is_online'] = isOnline;
    map['is_replica_support'] = isReplicaSupport;
    map['is_rs_install'] = isRsInstall;
    map['iso_images'] = isoImages;
    map['kb_layout'] = kbLayout;
    map['max_disk_latency'] = maxDiskLatency;
    map['name'] = name;
    map['ram_used'] = ramUsed;
    map['repo_id'] = repoId;
    map['repo_name'] = repoName;
    map['snap_num'] = snapNum;
    map['status'] = status;
    map['status_desc'] = statusDesc;
    map['status_type'] = statusType;
    map['total_disk_iops'] = totalDiskIops;
    map['total_disk_throughput'] = totalDiskThroughput;
    map['total_net_receive'] = totalNetReceive;
    map['total_net_send'] = totalNetSend;
    map['usb_device_name'] = usbDeviceName;
    map['usbs'] = usbs;
    map['use_ovmf'] = useOvmf;
    map['vcpu_num'] = vcpuNum;
    map['vcpu_usage'] = vcpuUsage;
    map['vdisk_num'] = vdiskNum;
    map['video_card'] = videoCard;
    map['vram_size'] = vramSize;
    return map;
  }
}

/// desc : ""
/// from : "vmm"
/// method : "create"

class BirthInfo {
  BirthInfo({
    this.desc,
    this.from,
    this.method,
  });

  BirthInfo.fromJson(dynamic json) {
    desc = json['desc'];
    from = json['from'];
    method = json['method'];
  }
  String? desc;
  String? from;
  String? method;
  BirthInfo copyWith({
    String? desc,
    String? from,
    String? method,
  }) =>
      BirthInfo(
        desc: desc ?? this.desc,
        from: from ?? this.from,
        method: method ?? this.method,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['desc'] = desc;
    map['from'] = from;
    map['method'] = method;
    return map;
  }
}

/// gsnap_supported : {"is_host_alive":true,"is_supported":true}

class Additional {
  Additional({
    this.gsnapSupported,
  });

  Additional.fromJson(dynamic json) {
    gsnapSupported = json['gsnap_supported'] != null ? GsnapSupported.fromJson(json['gsnap_supported']) : null;
  }
  GsnapSupported? gsnapSupported;
  Additional copyWith({
    GsnapSupported? gsnapSupported,
  }) =>
      Additional(
        gsnapSupported: gsnapSupported ?? this.gsnapSupported,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (gsnapSupported != null) {
      map['gsnap_supported'] = gsnapSupported?.toJson();
    }
    return map;
  }
}

/// is_host_alive : true
/// is_supported : true

class GsnapSupported {
  GsnapSupported({
    this.isHostAlive,
    this.isSupported,
  });

  GsnapSupported.fromJson(dynamic json) {
    isHostAlive = json['is_host_alive'];
    isSupported = json['is_supported'];
  }
  bool? isHostAlive;
  bool? isSupported;
  GsnapSupported copyWith({
    bool? isHostAlive,
    bool? isSupported,
  }) =>
      GsnapSupported(
        isHostAlive: isHostAlive ?? this.isHostAlive,
        isSupported: isSupported ?? this.isSupported,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['is_host_alive'] = isHostAlive;
    map['is_supported'] = isSupported;
    return map;
  }
}
