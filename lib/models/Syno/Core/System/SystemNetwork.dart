import 'package:dsm_helper/apis/api.dart';
import 'package:dsm_helper/pages/control_panel/info/enums/network_nif_status_enum.dart';

/// dns : "192.168.0.1"
/// enabled_domain : false
/// enabled_samba : true
/// gateway : "192.168.0.1"
/// hostname : "ChallengerV"
/// nif : [{"addr":"192.168.0.100","duplex":true,"id":"ovs_eth0","ipv6":[{"addr":"fe80::211:32ff:fe82:6e3f","prefix_len":64,"scope":"link"},{"addr":"240e:346:e6c:3600:211:32ff:fe82:6e3f","prefix_len":64,"scope":"global"},{"addr":"240e:346:e6c:3600::e9d","prefix_len":128,"scope":"global"}],"mac":"00-11-32-82-6E-3F","mask":"255.255.255.0","mtu":1500,"speed":1000,"status":"connected","type":"ovseth","use_dhcp":false}]
/// wins : ""
/// workgroup : "WORKGROUP"

class SystemNetwork {
  SystemNetwork({
    this.dns,
    this.enabledDomain,
    this.enabledSamba,
    this.gateway,
    this.hostname,
    this.nif,
    this.wins,
    this.workgroup,
  });

  static Future<SystemNetwork> info() async {
    DsmResponse res = await Api.dsm.entry("SYNO.Core.System", "info", version: 1, parser: SystemNetwork.fromJson, data: {
      "type": "network",
    });
    return res.data;
  }

  SystemNetwork.fromJson(dynamic json) {
    dns = json['dns'];
    enabledDomain = json['enabled_domain'];
    enabledSamba = json['enabled_samba'];
    gateway = json['gateway'];
    hostname = json['hostname'];
    if (json['nif'] != null) {
      nif = [];
      json['nif'].forEach((v) {
        nif?.add(Nif.fromJson(v));
      });
    }
    wins = json['wins'];
    workgroup = json['workgroup'];
  }
  String? dns;
  bool? enabledDomain;
  bool? enabledSamba;
  String? gateway;
  String? hostname;
  List<Nif>? nif;
  String? wins;
  String? workgroup;
  SystemNetwork copyWith({
    String? dns,
    bool? enabledDomain,
    bool? enabledSamba,
    String? gateway,
    String? hostname,
    List<Nif>? nif,
    String? wins,
    String? workgroup,
  }) =>
      SystemNetwork(
        dns: dns ?? this.dns,
        enabledDomain: enabledDomain ?? this.enabledDomain,
        enabledSamba: enabledSamba ?? this.enabledSamba,
        gateway: gateway ?? this.gateway,
        hostname: hostname ?? this.hostname,
        nif: nif ?? this.nif,
        wins: wins ?? this.wins,
        workgroup: workgroup ?? this.workgroup,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['dns'] = dns;
    map['enabled_domain'] = enabledDomain;
    map['enabled_samba'] = enabledSamba;
    map['gateway'] = gateway;
    map['hostname'] = hostname;
    if (nif != null) {
      map['nif'] = nif?.map((v) => v.toJson()).toList();
    }
    map['wins'] = wins;
    map['workgroup'] = workgroup;
    return map;
  }
}

/// addr : "192.168.0.100"
/// duplex : true
/// id : "ovs_eth0"
/// ipv6 : [{"addr":"fe80::211:32ff:fe82:6e3f","prefix_len":64,"scope":"link"},{"addr":"240e:346:e6c:3600:211:32ff:fe82:6e3f","prefix_len":64,"scope":"global"},{"addr":"240e:346:e6c:3600::e9d","prefix_len":128,"scope":"global"}]
/// mac : "00-11-32-82-6E-3F"
/// mask : "255.255.255.0"
/// mtu : 1500
/// speed : 1000
/// status : "connected"
/// type : "ovseth"
/// use_dhcp : false

class Nif {
  Nif({
    this.addr,
    this.duplex,
    this.id,
    this.ipv6,
    this.mac,
    this.mask,
    this.mtu,
    this.speed,
    this.status,
    this.type,
    this.useDhcp,
  });

  Nif.fromJson(dynamic json) {
    addr = json['addr'];
    duplex = json['duplex'];
    id = json['id'];
    if (json['ipv6'] != null) {
      ipv6 = [];
      json['ipv6'].forEach((v) {
        ipv6?.add(Ipv6.fromJson(v));
      });
    }
    mac = json['mac'];
    mask = json['mask'];
    mtu = json['mtu'];
    speed = json['speed'];
    status = json['status'];
    type = json['type'];
    useDhcp = json['use_dhcp'];
  }
  String? addr;
  bool? duplex;
  String? id;
  List<Ipv6>? ipv6;
  String? mac;
  String? mask;
  num? mtu;
  num? speed;
  String? status;
  NetworkStatusEnum get statusEnum => NetworkStatusEnum.fromValue(status ?? 'unknown');
  String? type;
  bool? useDhcp;
  Nif copyWith({
    String? addr,
    bool? duplex,
    String? id,
    List<Ipv6>? ipv6,
    String? mac,
    String? mask,
    num? mtu,
    num? speed,
    String? status,
    String? type,
    bool? useDhcp,
  }) =>
      Nif(
        addr: addr ?? this.addr,
        duplex: duplex ?? this.duplex,
        id: id ?? this.id,
        ipv6: ipv6 ?? this.ipv6,
        mac: mac ?? this.mac,
        mask: mask ?? this.mask,
        mtu: mtu ?? this.mtu,
        speed: speed ?? this.speed,
        status: status ?? this.status,
        type: type ?? this.type,
        useDhcp: useDhcp ?? this.useDhcp,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['addr'] = addr;
    map['duplex'] = duplex;
    map['id'] = id;
    if (ipv6 != null) {
      map['ipv6'] = ipv6?.map((v) => v.toJson()).toList();
    }
    map['mac'] = mac;
    map['mask'] = mask;
    map['mtu'] = mtu;
    map['speed'] = speed;
    map['status'] = status;
    map['type'] = type;
    map['use_dhcp'] = useDhcp;
    return map;
  }
}

/// addr : "fe80::211:32ff:fe82:6e3f"
/// prefix_len : 64
/// scope : "link"

class Ipv6 {
  Ipv6({
    this.addr,
    this.prefixLen,
    this.scope,
  });

  Ipv6.fromJson(dynamic json) {
    addr = json['addr'];
    prefixLen = json['prefix_len'];
    scope = json['scope'];
  }
  String? addr;
  num? prefixLen;
  String? scope;
  Ipv6 copyWith({
    String? addr,
    num? prefixLen,
    String? scope,
  }) =>
      Ipv6(
        addr: addr ?? this.addr,
        prefixLen: prefixLen ?? this.prefixLen,
        scope: scope ?? this.scope,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['addr'] = addr;
    map['prefix_len'] = prefixLen;
    map['scope'] = scope;
    return map;
  }
}
