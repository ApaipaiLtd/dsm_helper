import 'package:dsm_helper/apis/api.dart';
import 'package:dsm_helper/pages/virtual_machine/enums/guest_status_enums.dart';
import 'package:dsm_helper/pages/virtual_machine/enums/guest_status_type_enums.dart';

/// hosts : [{"cpu_commit_ratio":2,"cpu_num":4,"cpu_num_physical":4,"cpu_pin_num":0,"cpu_usage":39,"cpu_vendor":"intel","free_cpu_core":4,"free_cpu_ghz":4.87024,"free_cpu_pin":2,"free_ram_size":1024468,"free_ram_size_for_guest":1024468,"host_id":"a95d06e8-8e5a-41fa-8ccc-5d285efad62b","http_port":5000,"https_port":5001,"ip":"127.0.0.1","ipList":["192.168.0.100"],"model":"DS918+","name":"ChallengerV","package_version":"2.6.1-12139","rs_package_version":"1.2.2-0352","status":"running","status_type":"healthy","sys_reserved_ram_size":1572864,"total_cpu_num":8,"total_ram_size":8025040,"version":"7.1.1-42962 Update 5","vm_reserved_ram_size":4387792,"vm_save_repo":"ChallengerV - VM Storage 1"}]
/// is_freeze : false
/// max_host_num : 7

class VirtualizationHost {
  VirtualizationHost({
    this.hosts,
    this.isFreeze,
    this.maxHostNum,
  });

  static Future<VirtualizationHost> list() async {
    DsmResponse res = await Api.dsm.entry("SYNO.Virtualization.Host", "list", version: 1, parser: VirtualizationHost.fromJson);
    return res.data;
  }

  VirtualizationHost.fromJson(dynamic json) {
    if (json['hosts'] != null) {
      hosts = [];
      json['hosts'].forEach((v) {
        hosts?.add(Hosts.fromJson(v));
      });
    }
    isFreeze = json['is_freeze'];
    maxHostNum = json['max_host_num'];
  }
  List<Hosts>? hosts;
  bool? isFreeze;
  num? maxHostNum;
  VirtualizationHost copyWith({
    List<Hosts>? hosts,
    bool? isFreeze,
    num? maxHostNum,
  }) =>
      VirtualizationHost(
        hosts: hosts ?? this.hosts,
        isFreeze: isFreeze ?? this.isFreeze,
        maxHostNum: maxHostNum ?? this.maxHostNum,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (hosts != null) {
      map['hosts'] = hosts?.map((v) => v.toJson()).toList();
    }
    map['is_freeze'] = isFreeze;
    map['max_host_num'] = maxHostNum;
    return map;
  }
}

/// cpu_commit_ratio : 2
/// cpu_num : 4
/// cpu_num_physical : 4
/// cpu_pin_num : 0
/// cpu_usage : 39
/// cpu_vendor : "intel"
/// free_cpu_core : 4
/// free_cpu_ghz : 4.87024
/// free_cpu_pin : 2
/// free_ram_size : 1024468
/// free_ram_size_for_guest : 1024468
/// host_id : "a95d06e8-8e5a-41fa-8ccc-5d285efad62b"
/// http_port : 5000
/// https_port : 5001
/// ip : "127.0.0.1"
/// ipList : ["192.168.0.100"]
/// model : "DS918+"
/// name : "ChallengerV"
/// package_version : "2.6.1-12139"
/// rs_package_version : "1.2.2-0352"
/// status : "running"
/// status_type : "healthy"
/// sys_reserved_ram_size : 1572864
/// total_cpu_num : 8
/// total_ram_size : 8025040
/// version : "7.1.1-42962 Update 5"
/// vm_reserved_ram_size : 4387792
/// vm_save_repo : "ChallengerV - VM Storage 1"

class Hosts {
  Hosts({
    this.cpuCommitRatio,
    this.cpuNum,
    this.cpuNumPhysical,
    this.cpuPinNum,
    this.cpuUsage,
    this.cpuVendor,
    this.freeCpuCore,
    this.freeCpuGhz,
    this.freeCpuPin,
    this.freeRamSize,
    this.freeRamSizeForGuest,
    this.hostId,
    this.httpPort,
    this.httpsPort,
    this.ip,
    this.ipList,
    this.model,
    this.name,
    this.packageVersion,
    this.rsPackageVersion,
    this.status,
    this.statusType,
    this.sysReservedRamSize,
    this.totalCpuNum,
    this.totalRamSize,
    this.version,
    this.vmReservedRamSize,
    this.vmSaveRepo,
  });

  Hosts.fromJson(dynamic json) {
    cpuCommitRatio = json['cpu_commit_ratio'];
    cpuNum = json['cpu_num'];
    cpuNumPhysical = json['cpu_num_physical'];
    cpuPinNum = json['cpu_pin_num'];
    cpuUsage = json['cpu_usage'];
    cpuVendor = json['cpu_vendor'];
    freeCpuCore = json['free_cpu_core'];
    freeCpuGhz = json['free_cpu_ghz'];
    freeCpuPin = json['free_cpu_pin'];
    freeRamSize = json['free_ram_size'];
    freeRamSizeForGuest = json['free_ram_size_for_guest'];
    hostId = json['host_id'];
    httpPort = json['http_port'];
    httpsPort = json['https_port'];
    ip = json['ip'];
    ipList = json['ipList'] != null ? json['ipList'].cast<String>() : [];
    model = json['model'];
    name = json['name'];
    packageVersion = json['package_version'];
    rsPackageVersion = json['rs_package_version'];
    status = json['status'];
    statusType = json['status_type'];
    sysReservedRamSize = json['sys_reserved_ram_size'];
    totalCpuNum = json['total_cpu_num'];
    totalRamSize = json['total_ram_size'];
    version = json['version'];
    vmReservedRamSize = json['vm_reserved_ram_size'];
    vmSaveRepo = json['vm_save_repo'];
  }
  num? cpuCommitRatio;
  num? cpuNum;
  num? cpuNumPhysical;
  num? cpuPinNum;
  num? cpuUsage;
  String? cpuVendor;
  num? freeCpuCore;
  num? freeCpuGhz;
  num? freeCpuPin;
  num? freeRamSize;
  num? freeRamSizeForGuest;
  String? hostId;
  num? httpPort;
  num? httpsPort;
  String? ip;
  List<String>? ipList;
  String? model;
  String? name;
  String? packageVersion;
  String? rsPackageVersion;
  String? status;
  String? statusType;
  GuestStatusEnum get statusEnum => GuestStatusEnum.fromValue(status ?? 'unknown');
  GuestStatusTypeEnum get statusTypeEnum => GuestStatusTypeEnum.fromValue(statusType ?? 'unknown');
  num? sysReservedRamSize;
  num? totalCpuNum;
  num? totalRamSize;
  String? version;
  num? vmReservedRamSize;
  String? vmSaveRepo;
  Hosts copyWith({
    num? cpuCommitRatio,
    num? cpuNum,
    num? cpuNumPhysical,
    num? cpuPinNum,
    num? cpuUsage,
    String? cpuVendor,
    num? freeCpuCore,
    num? freeCpuGhz,
    num? freeCpuPin,
    num? freeRamSize,
    num? freeRamSizeForGuest,
    String? hostId,
    num? httpPort,
    num? httpsPort,
    String? ip,
    List<String>? ipList,
    String? model,
    String? name,
    String? packageVersion,
    String? rsPackageVersion,
    String? status,
    String? statusType,
    num? sysReservedRamSize,
    num? totalCpuNum,
    num? totalRamSize,
    String? version,
    num? vmReservedRamSize,
    String? vmSaveRepo,
  }) =>
      Hosts(
        cpuCommitRatio: cpuCommitRatio ?? this.cpuCommitRatio,
        cpuNum: cpuNum ?? this.cpuNum,
        cpuNumPhysical: cpuNumPhysical ?? this.cpuNumPhysical,
        cpuPinNum: cpuPinNum ?? this.cpuPinNum,
        cpuUsage: cpuUsage ?? this.cpuUsage,
        cpuVendor: cpuVendor ?? this.cpuVendor,
        freeCpuCore: freeCpuCore ?? this.freeCpuCore,
        freeCpuGhz: freeCpuGhz ?? this.freeCpuGhz,
        freeCpuPin: freeCpuPin ?? this.freeCpuPin,
        freeRamSize: freeRamSize ?? this.freeRamSize,
        freeRamSizeForGuest: freeRamSizeForGuest ?? this.freeRamSizeForGuest,
        hostId: hostId ?? this.hostId,
        httpPort: httpPort ?? this.httpPort,
        httpsPort: httpsPort ?? this.httpsPort,
        ip: ip ?? this.ip,
        ipList: ipList ?? this.ipList,
        model: model ?? this.model,
        name: name ?? this.name,
        packageVersion: packageVersion ?? this.packageVersion,
        rsPackageVersion: rsPackageVersion ?? this.rsPackageVersion,
        status: status ?? this.status,
        statusType: statusType ?? this.statusType,
        sysReservedRamSize: sysReservedRamSize ?? this.sysReservedRamSize,
        totalCpuNum: totalCpuNum ?? this.totalCpuNum,
        totalRamSize: totalRamSize ?? this.totalRamSize,
        version: version ?? this.version,
        vmReservedRamSize: vmReservedRamSize ?? this.vmReservedRamSize,
        vmSaveRepo: vmSaveRepo ?? this.vmSaveRepo,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['cpu_commit_ratio'] = cpuCommitRatio;
    map['cpu_num'] = cpuNum;
    map['cpu_num_physical'] = cpuNumPhysical;
    map['cpu_pin_num'] = cpuPinNum;
    map['cpu_usage'] = cpuUsage;
    map['cpu_vendor'] = cpuVendor;
    map['free_cpu_core'] = freeCpuCore;
    map['free_cpu_ghz'] = freeCpuGhz;
    map['free_cpu_pin'] = freeCpuPin;
    map['free_ram_size'] = freeRamSize;
    map['free_ram_size_for_guest'] = freeRamSizeForGuest;
    map['host_id'] = hostId;
    map['http_port'] = httpPort;
    map['https_port'] = httpsPort;
    map['ip'] = ip;
    map['ipList'] = ipList;
    map['model'] = model;
    map['name'] = name;
    map['package_version'] = packageVersion;
    map['rs_package_version'] = rsPackageVersion;
    map['status'] = status;
    map['status_type'] = statusType;
    map['sys_reserved_ram_size'] = sysReservedRamSize;
    map['total_cpu_num'] = totalCpuNum;
    map['total_ram_size'] = totalRamSize;
    map['version'] = version;
    map['vm_reserved_ram_size'] = vmReservedRamSize;
    map['vm_save_repo'] = vmSaveRepo;
    return map;
  }
}
