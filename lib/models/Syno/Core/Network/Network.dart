import 'package:dsm_helper/models/base_model.dart';
import 'package:dsm_helper/pages/control_panel/network/enums/interface_type_enums.dart';

/// arp_ignore : true
/// dns_manual : false
/// dns_primary : "219.141.140.10"
/// dns_secondary : "192.168.1.1"
/// enable_ip_conflict_detect : true
/// enable_windomain : false
/// gateway : "115.171.56.1"
/// gateway_info : {"ifname":"pppoe","ip":"115.171.59.59","mask":"255.255.255.255","status":"connected","type":"pppoe","use_dhcp":true}
/// ipv4_first : true
/// multi_gateway : true
/// server_name : "Synology"
/// use_dhcp_domain : true
/// v6gateway : "fe80::2e0:b4ff:fe59:ff34"

class CoreNetwork implements BaseModel {
  CoreNetwork({
    this.arpIgnore,
    this.dnsManual,
    this.dnsPrimary,
    this.dnsSecondary,
    this.enableIpConflictDetect,
    this.enableWindomain,
    this.gateway,
    this.gatewayInfo,
    this.ipv4First,
    this.multiGateway,
    this.serverName,
    this.useDhcpDomain,
    this.v6gateway,
  });

  CoreNetwork.fromJson(dynamic json) {
    arpIgnore = json['arp_ignore'];
    dnsManual = json['dns_manual'];
    dnsPrimary = json['dns_primary'];
    dnsSecondary = json['dns_secondary'];
    enableIpConflictDetect = json['enable_ip_conflict_detect'];
    enableWindomain = json['enable_windomain'];
    gateway = json['gateway'];
    gatewayInfo = json['gateway_info'] != null ? GatewayInfo.fromJson(json['gateway_info']) : null;
    ipv4First = json['ipv4_first'];
    multiGateway = json['multi_gateway'];
    serverName = json['server_name'];
    useDhcpDomain = json['use_dhcp_domain'];
    v6gateway = json['v6gateway'];
  }
  bool? arpIgnore;
  bool? dnsManual;
  String? dnsPrimary;
  String? dnsSecondary;
  bool? enableIpConflictDetect;
  bool? enableWindomain;
  String? gateway;
  GatewayInfo? gatewayInfo;
  bool? ipv4First;
  bool? multiGateway;
  String? serverName;
  bool? useDhcpDomain;
  String? v6gateway;
  CoreNetwork copyWith({
    bool? arpIgnore,
    bool? dnsManual,
    String? dnsPrimary,
    String? dnsSecondary,
    bool? enableIpConflictDetect,
    bool? enableWindomain,
    String? gateway,
    GatewayInfo? gatewayInfo,
    bool? ipv4First,
    bool? multiGateway,
    String? serverName,
    bool? useDhcpDomain,
    String? v6gateway,
  }) =>
      CoreNetwork(
        arpIgnore: arpIgnore ?? this.arpIgnore,
        dnsManual: dnsManual ?? this.dnsManual,
        dnsPrimary: dnsPrimary ?? this.dnsPrimary,
        dnsSecondary: dnsSecondary ?? this.dnsSecondary,
        enableIpConflictDetect: enableIpConflictDetect ?? this.enableIpConflictDetect,
        enableWindomain: enableWindomain ?? this.enableWindomain,
        gateway: gateway ?? this.gateway,
        gatewayInfo: gatewayInfo ?? this.gatewayInfo,
        ipv4First: ipv4First ?? this.ipv4First,
        multiGateway: multiGateway ?? this.multiGateway,
        serverName: serverName ?? this.serverName,
        useDhcpDomain: useDhcpDomain ?? this.useDhcpDomain,
        v6gateway: v6gateway ?? this.v6gateway,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['arp_ignore'] = arpIgnore;
    map['dns_manual'] = dnsManual;
    map['dns_primary'] = dnsPrimary;
    map['dns_secondary'] = dnsSecondary;
    map['enable_ip_conflict_detect'] = enableIpConflictDetect;
    map['enable_windomain'] = enableWindomain;
    map['gateway'] = gateway;
    if (gatewayInfo != null) {
      map['gateway_info'] = gatewayInfo?.toJson();
    }
    map['ipv4_first'] = ipv4First;
    map['multi_gateway'] = multiGateway;
    map['server_name'] = serverName;
    map['use_dhcp_domain'] = useDhcpDomain;
    map['v6gateway'] = v6gateway;
    return map;
  }

  @override
  String? api = "SYNO.Core.Network";

  @override
  Map<String, dynamic>? data;

  @override
  String? method = "get";

  @override
  int? version = 1;

  @override
  fromJson(json) {
    return CoreNetwork.fromJson(json);
  }
}

/// ifname : "pppoe"
/// ip : "115.171.59.59"
/// mask : "255.255.255.255"
/// status : "connected"
/// type : "pppoe"
/// use_dhcp : true

class GatewayInfo {
  GatewayInfo({
    this.ifname,
    this.ip,
    this.mask,
    this.status,
    this.type,
    this.useDhcp,
  });

  GatewayInfo.fromJson(dynamic json) {
    ifname = json['ifname'];
    ip = json['ip'];
    mask = json['mask'];
    status = json['status'];
    type = json['type'];
    useDhcp = json['use_dhcp'];
  }
  String? ifname;
  InterfaceTypeEnum get ifnameEnum => InterfaceTypeEnum.fromValue(ifname ?? 'unknown');
  String? ip;
  String? mask;
  String? status;
  String? type;
  bool? useDhcp;
  GatewayInfo copyWith({
    String? ifname,
    String? ip,
    String? mask,
    String? status,
    String? type,
    bool? useDhcp,
  }) =>
      GatewayInfo(
        ifname: ifname ?? this.ifname,
        ip: ip ?? this.ip,
        mask: mask ?? this.mask,
        status: status ?? this.status,
        type: type ?? this.type,
        useDhcp: useDhcp ?? this.useDhcp,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ifname'] = ifname;
    map['ip'] = ip;
    map['mask'] = mask;
    map['status'] = status;
    map['type'] = type;
    map['use_dhcp'] = useDhcp;
    return map;
  }
}
