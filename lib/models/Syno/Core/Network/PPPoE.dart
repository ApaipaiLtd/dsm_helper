import 'package:dsm_helper/models/base_model.dart';
import 'package:dsm_helper/pages/control_panel/info/enums/network_nif_status_enum.dart';

/// devs : ["ovs_eth0","ovs_eth1"]
/// guest_enabled : false
/// ifname : "pppoe"
/// ip : "115.171.59.59"
/// ipv6 : ["240e:82:1780:5b8:f6b5:20ff:fe08:7ef7/64","fe80::f6b5:20ff:fe08:7ef7/10"]
/// is_default_gateway : 1
/// mask : "255.255.255.255"
/// mtu_config : "1492"
/// password : "********"
/// real_ifname : "ovs_eth0"
/// status : "connected"
/// type : "pppoe"
/// use_dhcp : true
/// username : "01014744605"

class PPPoEs implements BaseModel {
  List<PPPoE>? pppoes;

  PPPoEs({this.pppoes});

  PPPoEs.fromJson(dynamic json) {
    if (json != null) {
      pppoes = [];
      json.forEach((v) {
        pppoes?.add(PPPoE.fromJson(v));
      });
    }
  }

  @override
  String? api = "SYNO.Core.Network.PPPoE";

  @override
  Map<String, dynamic>? data;

  @override
  String? method = "list";

  @override
  int? version = 1;

  @override
  fromJson(json) {
    return PPPoEs.fromJson(json);
  }
}

class PPPoE {
  PPPoE({
    this.devs,
    this.guestEnabled,
    this.ifname,
    this.ip,
    this.ipv6,
    this.isDefaultGateway,
    this.mask,
    this.mtuConfig,
    this.password,
    this.realIfname,
    this.status,
    this.type,
    this.useDhcp,
    this.username,
  });

  PPPoE.fromJson(dynamic json) {
    devs = json['devs'] != null ? json['devs'].cast<String>() : [];
    guestEnabled = json['guest_enabled'];
    ifname = json['ifname'];
    ip = json['ip'];
    ipv6 = json['ipv6'] != null ? json['ipv6'].cast<String>() : [];
    isDefaultGateway = json['is_default_gateway'];
    mask = json['mask'];
    mtuConfig = json['mtu_config'];
    password = json['password'];
    realIfname = json['real_ifname'];
    status = json['status'];
    type = json['type'];
    useDhcp = json['use_dhcp'];
    username = json['username'];
  }
  List<String>? devs;
  bool? guestEnabled;
  String? ifname;
  String? ip;
  List<String>? ipv6;
  num? isDefaultGateway;
  String? mask;
  String? mtuConfig;
  String? password;
  String? realIfname;
  String? status;
  NetworkStatusEnum get statusEnum => NetworkStatusEnum.fromValue(status ?? 'unknown');
  String? type;
  bool? useDhcp;
  String? username;
  PPPoE copyWith({
    List<String>? devs,
    bool? guestEnabled,
    String? ifname,
    String? ip,
    List<String>? ipv6,
    num? isDefaultGateway,
    String? mask,
    String? mtuConfig,
    String? password,
    String? realIfname,
    String? status,
    String? type,
    bool? useDhcp,
    String? username,
  }) =>
      PPPoE(
        devs: devs ?? this.devs,
        guestEnabled: guestEnabled ?? this.guestEnabled,
        ifname: ifname ?? this.ifname,
        ip: ip ?? this.ip,
        ipv6: ipv6 ?? this.ipv6,
        isDefaultGateway: isDefaultGateway ?? this.isDefaultGateway,
        mask: mask ?? this.mask,
        mtuConfig: mtuConfig ?? this.mtuConfig,
        password: password ?? this.password,
        realIfname: realIfname ?? this.realIfname,
        status: status ?? this.status,
        type: type ?? this.type,
        useDhcp: useDhcp ?? this.useDhcp,
        username: username ?? this.username,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['devs'] = devs;
    map['guest_enabled'] = guestEnabled;
    map['ifname'] = ifname;
    map['ip'] = ip;
    map['ipv6'] = ipv6;
    map['is_default_gateway'] = isDefaultGateway;
    map['mask'] = mask;
    map['mtu_config'] = mtuConfig;
    map['password'] = password;
    map['real_ifname'] = realIfname;
    map['status'] = status;
    map['type'] = type;
    map['use_dhcp'] = useDhcp;
    map['username'] = username;
    return map;
  }
}
