import 'package:dsm_helper/apis/api.dart';

/// cpu : {"15min_load":163,"1min_load":141,"5min_load":234,"device":"System","other_load":3,"system_load":3,"user_load":7}
/// disk : {"disk":[{"device":"sda","display_name":"Drive 1","read_access":0,"read_byte":0,"type":"internal","utilization":7,"write_access":24,"write_byte":458410},{"device":"sdc","display_name":"Drive 3","read_access":0,"read_byte":0,"type":"internal","utilization":2,"write_access":38,"write_byte":594517},{"device":"sdf","display_name":"Drive 6","read_access":0,"read_byte":0,"type":"internal","utilization":2,"write_access":0,"write_byte":0}],"total":{"device":"total","read_access":0,"read_byte":0,"utilization":3,"write_access":62,"write_byte":1052927}}
/// memory : {"avail_real":443220,"avail_swap":4610020,"buffer":16888,"cached":4283888,"device":"Memory","memory_size":8388608,"real_usage":40,"si_disk":0,"so_disk":0,"swap_usage":33,"total_real":8025040,"total_swap":6913964}
/// network : [{"device":"total","rx":10332,"tx":28418},{"device":"eth0","rx":10332,"tx":28418}]
/// time : 1694654230

class Utilization {
  Utilization({
    this.cpu,
    this.disk,
    this.memory,
    this.network,
    this.time,
  });

  static Future<Utilization> get() async {
    DsmResponse res = await Api.dsm.entry(
      "SYNO.Core.System.Utilization",
      "get",
      parser: Utilization.fromJson,
      data: {
        "type": "current",
        "resource": ["cpu", "memory", "network", "lun", "disk", "space"],
      },
    );
    return res.data;
  }

  Utilization.fromJson(dynamic json) {
    cpu = json['cpu'] != null ? Cpu.fromJson(json['cpu']) : null;
    disk = json['disk'] != null ? Disk.fromJson(json['disk']) : null;
    memory = json['memory'] != null ? Memory.fromJson(json['memory']) : null;
    if (json['network'] != null) {
      network = [];
      json['network'].forEach((v) {
        network?.add(Network.fromJson(v));
      });
    }
    time = json['time'];
  }
  Cpu? cpu;
  Disk? disk;
  Memory? memory;
  List<Network>? network;
  num? time;
  Utilization copyWith({
    Cpu? cpu,
    Disk? disk,
    Memory? memory,
    List<Network>? network,
    num? time,
  }) =>
      Utilization(
        cpu: cpu ?? this.cpu,
        disk: disk ?? this.disk,
        memory: memory ?? this.memory,
        network: network ?? this.network,
        time: time ?? this.time,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (cpu != null) {
      map['cpu'] = cpu?.toJson();
    }
    if (disk != null) {
      map['disk'] = disk?.toJson();
    }
    if (memory != null) {
      map['memory'] = memory?.toJson();
    }
    if (network != null) {
      map['network'] = network?.map((v) => v.toJson()).toList();
    }
    map['time'] = time;
    return map;
  }
}

/// device : "total"
/// rx : 10332
/// tx : 28418

class Network {
  Network({
    this.device,
    this.rx,
    this.tx,
  });

  Network.fromJson(dynamic json) {
    device = json['device'];
    rx = json['rx'];
    tx = json['tx'];
  }
  String? device;
  int? rx;
  int? tx;
  Network copyWith({
    String? device,
    int? rx,
    int? tx,
  }) =>
      Network(
        device: device ?? this.device,
        rx: rx ?? this.rx,
        tx: tx ?? this.tx,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['device'] = device;
    map['rx'] = rx;
    map['tx'] = tx;
    return map;
  }
}

/// avail_real : 443220
/// avail_swap : 4610020
/// buffer : 16888
/// cached : 4283888
/// device : "Memory"
/// memory_size : 8388608
/// real_usage : 40
/// si_disk : 0
/// so_disk : 0
/// swap_usage : 33
/// total_real : 8025040
/// total_swap : 6913964

class Memory {
  Memory({
    this.availReal,
    this.availSwap,
    this.buffer,
    this.cached,
    this.device,
    this.memorySize,
    this.realUsage,
    this.siDisk,
    this.soDisk,
    this.swapUsage,
    this.totalReal,
    this.totalSwap,
  });

  Memory.fromJson(dynamic json) {
    availReal = json['avail_real'];
    availSwap = json['avail_swap'];
    buffer = json['buffer'];
    cached = json['cached'];
    device = json['device'];
    memorySize = json['memory_size'];
    realUsage = json['real_usage'];
    siDisk = json['si_disk'];
    soDisk = json['so_disk'];
    swapUsage = json['swap_usage'];
    totalReal = json['total_real'];
    totalSwap = json['total_swap'];
  }
  num? availReal;
  num? availSwap;
  num? buffer;
  num? cached;
  String? device;
  num? memorySize;
  num? realUsage;
  num? siDisk;
  num? soDisk;
  num? swapUsage;
  num? totalReal;
  num? totalSwap;
  Memory copyWith({
    num? availReal,
    num? availSwap,
    num? buffer,
    num? cached,
    String? device,
    num? memorySize,
    num? realUsage,
    num? siDisk,
    num? soDisk,
    num? swapUsage,
    num? totalReal,
    num? totalSwap,
  }) =>
      Memory(
        availReal: availReal ?? this.availReal,
        availSwap: availSwap ?? this.availSwap,
        buffer: buffer ?? this.buffer,
        cached: cached ?? this.cached,
        device: device ?? this.device,
        memorySize: memorySize ?? this.memorySize,
        realUsage: realUsage ?? this.realUsage,
        siDisk: siDisk ?? this.siDisk,
        soDisk: soDisk ?? this.soDisk,
        swapUsage: swapUsage ?? this.swapUsage,
        totalReal: totalReal ?? this.totalReal,
        totalSwap: totalSwap ?? this.totalSwap,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['avail_real'] = availReal;
    map['avail_swap'] = availSwap;
    map['buffer'] = buffer;
    map['cached'] = cached;
    map['device'] = device;
    map['memory_size'] = memorySize;
    map['real_usage'] = realUsage;
    map['si_disk'] = siDisk;
    map['so_disk'] = soDisk;
    map['swap_usage'] = swapUsage;
    map['total_real'] = totalReal;
    map['total_swap'] = totalSwap;
    return map;
  }
}

/// disk : [{"device":"sda","display_name":"Drive 1","read_access":0,"read_byte":0,"type":"internal","utilization":7,"write_access":24,"write_byte":458410},{"device":"sdc","display_name":"Drive 3","read_access":0,"read_byte":0,"type":"internal","utilization":2,"write_access":38,"write_byte":594517},{"device":"sdf","display_name":"Drive 6","read_access":0,"read_byte":0,"type":"internal","utilization":2,"write_access":0,"write_byte":0}]
/// total : {"device":"total","read_access":0,"read_byte":0,"utilization":3,"write_access":62,"write_byte":1052927}

class Disk {
  Disk({
    this.disk,
    this.total,
  });

  Disk.fromJson(dynamic json) {
    if (json['disk'] != null) {
      disk = [];
      json['disk'].forEach((v) {
        disk?.add(DiskInfo.fromJson(v));
      });
    }
    total = json['total'] != null ? Total.fromJson(json['total']) : null;
  }
  List<DiskInfo>? disk;
  Total? total;
  Disk copyWith({
    List<DiskInfo>? disk,
    Total? total,
  }) =>
      Disk(
        disk: disk ?? this.disk,
        total: total ?? this.total,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (disk != null) {
      map['disk'] = disk?.map((v) => v.toJson()).toList();
    }
    if (total != null) {
      map['total'] = total?.toJson();
    }
    return map;
  }
}

/// device : "total"
/// read_access : 0
/// read_byte : 0
/// utilization : 3
/// write_access : 62
/// write_byte : 1052927

class Total {
  Total({
    this.device,
    this.readAccess,
    this.readByte,
    this.utilization,
    this.writeAccess,
    this.writeByte,
  });

  Total.fromJson(dynamic json) {
    device = json['device'];
    readAccess = json['read_access'];
    readByte = json['read_byte'];
    utilization = json['utilization'];
    writeAccess = json['write_access'];
    writeByte = json['write_byte'];
  }
  String? device;
  num? readAccess;
  num? readByte;
  num? utilization;
  num? writeAccess;
  num? writeByte;
  Total copyWith({
    String? device,
    num? readAccess,
    num? readByte,
    num? utilization,
    num? writeAccess,
    num? writeByte,
  }) =>
      Total(
        device: device ?? this.device,
        readAccess: readAccess ?? this.readAccess,
        readByte: readByte ?? this.readByte,
        utilization: utilization ?? this.utilization,
        writeAccess: writeAccess ?? this.writeAccess,
        writeByte: writeByte ?? this.writeByte,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['device'] = device;
    map['read_access'] = readAccess;
    map['read_byte'] = readByte;
    map['utilization'] = utilization;
    map['write_access'] = writeAccess;
    map['write_byte'] = writeByte;
    return map;
  }
}

/// device : "sda"
/// display_name : "Drive 1"
/// read_access : 0
/// read_byte : 0
/// type : "internal"
/// utilization : 7
/// write_access : 24
/// write_byte : 458410

class DiskInfo {
  DiskInfo({
    this.device,
    this.displayName,
    this.readAccess,
    this.readByte,
    this.type,
    this.utilization,
    this.writeAccess,
    this.writeByte,
  });

  DiskInfo.fromJson(dynamic json) {
    device = json['device'];
    displayName = json['display_name'];
    readAccess = json['read_access'];
    readByte = json['read_byte'];
    type = json['type'];
    utilization = json['utilization'];
    writeAccess = json['write_access'];
    writeByte = json['write_byte'];
  }
  String? device;
  String? displayName;
  num? readAccess;
  num? readByte;
  String? type;
  num? utilization;
  num? writeAccess;
  num? writeByte;
  DiskInfo copyWith({
    String? device,
    String? displayName,
    num? readAccess,
    num? readByte,
    String? type,
    num? utilization,
    num? writeAccess,
    num? writeByte,
  }) =>
      DiskInfo(
        device: device ?? this.device,
        displayName: displayName ?? this.displayName,
        readAccess: readAccess ?? this.readAccess,
        readByte: readByte ?? this.readByte,
        type: type ?? this.type,
        utilization: utilization ?? this.utilization,
        writeAccess: writeAccess ?? this.writeAccess,
        writeByte: writeByte ?? this.writeByte,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['device'] = device;
    map['display_name'] = displayName;
    map['read_access'] = readAccess;
    map['read_byte'] = readByte;
    map['type'] = type;
    map['utilization'] = utilization;
    map['write_access'] = writeAccess;
    map['write_byte'] = writeByte;
    return map;
  }
}

/// 15min_load : 163
/// 1min_load : 141
/// 5min_load : 234
/// device : "System"
/// other_load : 3
/// system_load : 3
/// user_load : 7

class Cpu {
  Cpu({
    this.minLoad15,
    this.minLoad1,
    this.minLoad5,
    this.device,
    this.otherLoad,
    this.systemLoad,
    this.userLoad,
  });

  Cpu.fromJson(dynamic json) {
    minLoad15 = json['15min_load'];
    minLoad1 = json['1min_load'];
    minLoad5 = json['5min_load'];
    device = json['device'];
    otherLoad = json['other_load'];
    systemLoad = json['system_load'];
    userLoad = json['user_load'];
  }
  num? minLoad15;
  num? minLoad1;
  num? minLoad5;
  String? device;
  num? otherLoad;
  num? systemLoad;
  num? userLoad;

  int get totalLoad => ((userLoad ?? 0) + (systemLoad ?? 0) + (otherLoad ?? 0)).toInt();

  Cpu copyWith({
    num? minLoad15,
    num? minLoad1,
    num? minLoad5,
    String? device,
    num? otherLoad,
    num? systemLoad,
    num? userLoad,
  }) =>
      Cpu(
        minLoad15: minLoad15 ?? this.minLoad15,
        minLoad1: minLoad1 ?? this.minLoad1,
        minLoad5: minLoad5 ?? this.minLoad5,
        device: device ?? this.device,
        otherLoad: otherLoad ?? this.otherLoad,
        systemLoad: systemLoad ?? this.systemLoad,
        userLoad: userLoad ?? this.userLoad,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['15min_load'] = minLoad15;
    map['1min_load'] = minLoad1;
    map['5min_load'] = minLoad5;
    map['device'] = device;
    map['other_load'] = otherLoad;
    map['system_load'] = systemLoad;
    map['user_load'] = userLoad;
    return map;
  }
}
