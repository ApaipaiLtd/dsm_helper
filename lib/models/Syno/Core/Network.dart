/// arp_ignore : true
/// dns_manual : false
/// dns_primary : "192.168.0.1"
/// dns_secondary : "fe80::ca5b:a0ff:fee7:d820"
/// enable_windomain : false
/// gateway : "192.168.0.1"
/// gateway_info : {"ifname":"ovs_eth0","ip":"192.168.0.100","mask":"255.255.255.0","status":"connected","type":"ovseth","use_dhcp":false}
/// ipv4_first : false
/// multi_gateway : false
/// server_name : "ChallengerV"
/// v6gateway : "fe80::ca5b:a0ff:fee7:d820"

class Network {
  Network({
    this.arpIgnore,
    this.dnsManual,
    this.dnsPrimary,
    this.dnsSecondary,
    this.enableWindomain,
    this.gateway,
    this.gatewayInfo,
    this.ipv4First,
    this.multiGateway,
    this.serverName,
    this.v6gateway,
  });

  Network.fromJson(dynamic json) {
    arpIgnore = json['arp_ignore'];
    dnsManual = json['dns_manual'];
    dnsPrimary = json['dns_primary'];
    dnsSecondary = json['dns_secondary'];
    enableWindomain = json['enable_windomain'];
    gateway = json['gateway'];
    gatewayInfo = json['gateway_info'] != null ? GatewayInfo.fromJson(json['gateway_info']) : null;
    ipv4First = json['ipv4_first'];
    multiGateway = json['multi_gateway'];
    serverName = json['server_name'];
    v6gateway = json['v6gateway'];
  }
  bool? arpIgnore;
  bool? dnsManual;
  String? dnsPrimary;
  String? dnsSecondary;
  bool? enableWindomain;
  String? gateway;
  GatewayInfo? gatewayInfo;
  bool? ipv4First;
  bool? multiGateway;
  String? serverName;
  String? v6gateway;
  Network copyWith({
    bool? arpIgnore,
    bool? dnsManual,
    String? dnsPrimary,
    String? dnsSecondary,
    bool? enableWindomain,
    String? gateway,
    GatewayInfo? gatewayInfo,
    bool? ipv4First,
    bool? multiGateway,
    String? serverName,
    String? v6gateway,
  }) =>
      Network(
        arpIgnore: arpIgnore ?? this.arpIgnore,
        dnsManual: dnsManual ?? this.dnsManual,
        dnsPrimary: dnsPrimary ?? this.dnsPrimary,
        dnsSecondary: dnsSecondary ?? this.dnsSecondary,
        enableWindomain: enableWindomain ?? this.enableWindomain,
        gateway: gateway ?? this.gateway,
        gatewayInfo: gatewayInfo ?? this.gatewayInfo,
        ipv4First: ipv4First ?? this.ipv4First,
        multiGateway: multiGateway ?? this.multiGateway,
        serverName: serverName ?? this.serverName,
        v6gateway: v6gateway ?? this.v6gateway,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['arp_ignore'] = arpIgnore;
    map['dns_manual'] = dnsManual;
    map['dns_primary'] = dnsPrimary;
    map['dns_secondary'] = dnsSecondary;
    map['enable_windomain'] = enableWindomain;
    map['gateway'] = gateway;
    if (gatewayInfo != null) {
      map['gateway_info'] = gatewayInfo?.toJson();
    }
    map['ipv4_first'] = ipv4First;
    map['multi_gateway'] = multiGateway;
    map['server_name'] = serverName;
    map['v6gateway'] = v6gateway;
    return map;
  }
}

/// ifname : "ovs_eth0"
/// ip : "192.168.0.100"
/// mask : "255.255.255.0"
/// status : "connected"
/// type : "ovseth"
/// use_dhcp : false

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
