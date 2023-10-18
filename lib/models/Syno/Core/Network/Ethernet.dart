import 'package:dsm_helper/models/base_model.dart';
import 'package:dsm_helper/pages/control_panel/info/enums/network_nif_status_enum.dart';

/// block : 0
/// dns : "192.168.8.1"
/// duplex : true
/// enable_ha_ip : false
/// enable_vlan : false
/// gateway : "192.168.8.1"
/// ha_local_ip : ""
/// ha_local_mask : ""
/// ifname : "ovs_eth1"
/// ip : "192.168.8.3"
/// ipv6 : ["240e:82:1702:560a:2e0:42ff:fe68:1ed6/64","240e:82:1702:5607:2e0:42ff:fe68:1ed6/64","240e:82:1702:5606::3/128","240e:82:1702:5606:2e0:42ff:fe68:1ed6/64","fe80::2e0:42ff:fe68:1ed6/64"]
/// is_default_gateway : false
/// is_main_ha_ip : false
/// mask : "255.255.255.0"
/// max_supported_speed : 2500
/// mtu : 1500
/// mtu_config : 1500
/// nat : false
/// speed : 2500
/// status : "connected"
/// type : "ovseth"
/// use_dhcp : true
/// vlan_id : 0
class Ethernets implements BaseModel {
  List<Ethernet>? ethernets;

  Ethernets({this.ethernets});

  Ethernets.fromJson(dynamic json) {
    if (json != null) {
      ethernets = [];
      json.forEach((v) {
        ethernets?.add(Ethernet.fromJson(v));
      });
    }
  }

  @override
  String? api = "SYNO.Core.Network.Ethernet";

  @override
  Map<String, dynamic>? data;

  @override
  String? method = "list";

  @override
  int? version = 1;

  @override
  fromJson(json) {
    return Ethernets.fromJson(json);
  }
}

class Ethernet {
  Ethernet({
    this.block,
    this.dns,
    this.duplex,
    this.enableHaIp,
    this.enableVlan,
    this.gateway,
    this.haLocalIp,
    this.haLocalMask,
    this.ifname,
    this.ip,
    this.ipv6,
    this.isDefaultGateway,
    this.isMainHaIp,
    this.mask,
    this.maxSupportedSpeed,
    this.mtu,
    this.mtuConfig,
    this.nat,
    this.speed,
    this.status,
    this.type,
    this.useDhcp,
    this.vlanId,
  });

  Ethernet.fromJson(dynamic json) {
    block = json['block'];
    dns = json['dns'];
    duplex = json['duplex'];
    enableHaIp = json['enable_ha_ip'];
    enableVlan = json['enable_vlan'];
    gateway = json['gateway'];
    haLocalIp = json['ha_local_ip'];
    haLocalMask = json['ha_local_mask'];
    ifname = json['ifname'];
    ip = json['ip'];
    ipv6 = json['ipv6'] != null ? json['ipv6'].cast<String>() : [];
    isDefaultGateway = json['is_default_gateway'];
    isMainHaIp = json['is_main_ha_ip'];
    mask = json['mask'];
    maxSupportedSpeed = json['max_supported_speed'];
    mtu = json['mtu'];
    mtuConfig = json['mtu_config'];
    nat = json['nat'];
    speed = json['speed'];
    status = json['status'];
    type = json['type'];
    useDhcp = json['use_dhcp'];
    vlanId = json['vlan_id'];
  }
  num? block;
  String? dns;
  bool? duplex;
  bool? enableHaIp;
  bool? enableVlan;
  String? gateway;
  String? haLocalIp;
  String? haLocalMask;
  String? ifname;
  String? ip;
  List<String>? ipv6;
  bool? isDefaultGateway;
  bool? isMainHaIp;
  String? mask;
  num? maxSupportedSpeed;
  num? mtu;
  num? mtuConfig;
  bool? nat;
  num? speed;
  String? status;
  NetworkStatusEnum get statusEnum => NetworkStatusEnum.fromValue(status ?? 'unknown');
  String? type;
  bool? useDhcp;
  num? vlanId;
  Ethernet copyWith({
    num? block,
    String? dns,
    bool? duplex,
    bool? enableHaIp,
    bool? enableVlan,
    String? gateway,
    String? haLocalIp,
    String? haLocalMask,
    String? ifname,
    String? ip,
    List<String>? ipv6,
    bool? isDefaultGateway,
    bool? isMainHaIp,
    String? mask,
    num? maxSupportedSpeed,
    num? mtu,
    num? mtuConfig,
    bool? nat,
    num? speed,
    String? status,
    String? type,
    bool? useDhcp,
    num? vlanId,
  }) =>
      Ethernet(
        block: block ?? this.block,
        dns: dns ?? this.dns,
        duplex: duplex ?? this.duplex,
        enableHaIp: enableHaIp ?? this.enableHaIp,
        enableVlan: enableVlan ?? this.enableVlan,
        gateway: gateway ?? this.gateway,
        haLocalIp: haLocalIp ?? this.haLocalIp,
        haLocalMask: haLocalMask ?? this.haLocalMask,
        ifname: ifname ?? this.ifname,
        ip: ip ?? this.ip,
        ipv6: ipv6 ?? this.ipv6,
        isDefaultGateway: isDefaultGateway ?? this.isDefaultGateway,
        isMainHaIp: isMainHaIp ?? this.isMainHaIp,
        mask: mask ?? this.mask,
        maxSupportedSpeed: maxSupportedSpeed ?? this.maxSupportedSpeed,
        mtu: mtu ?? this.mtu,
        mtuConfig: mtuConfig ?? this.mtuConfig,
        nat: nat ?? this.nat,
        speed: speed ?? this.speed,
        status: status ?? this.status,
        type: type ?? this.type,
        useDhcp: useDhcp ?? this.useDhcp,
        vlanId: vlanId ?? this.vlanId,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['block'] = block;
    map['dns'] = dns;
    map['duplex'] = duplex;
    map['enable_ha_ip'] = enableHaIp;
    map['enable_vlan'] = enableVlan;
    map['gateway'] = gateway;
    map['ha_local_ip'] = haLocalIp;
    map['ha_local_mask'] = haLocalMask;
    map['ifname'] = ifname;
    map['ip'] = ip;
    map['ipv6'] = ipv6;
    map['is_default_gateway'] = isDefaultGateway;
    map['is_main_ha_ip'] = isMainHaIp;
    map['mask'] = mask;
    map['max_supported_speed'] = maxSupportedSpeed;
    map['mtu'] = mtu;
    map['mtu_config'] = mtuConfig;
    map['nat'] = nat;
    map['speed'] = speed;
    map['status'] = status;
    map['type'] = type;
    map['use_dhcp'] = useDhcp;
    map['vlan_id'] = vlanId;
    return map;
  }
}
