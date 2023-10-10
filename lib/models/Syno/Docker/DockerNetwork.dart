import 'package:dsm_helper/apis/api.dart';

/// network : [{"containers":["emby","qbittorrent","qinglong","ChatGPT","chinesesubfinder","moviepilot","sonarr","jackett","radarr","ShellngnPro","clash","nas-tools","webssh","jellyfin","yunzai-bot","redis"],"driver":"bridge","enable_ipv6":false,"gateway":"172.17.0.1","id":"53dd2cab2cb028a9c7d00d6d2922fdb63cc34fb1b1d1e6c6a5ff8be00f83203e","iprange":"","name":"bridge","subnet":"172.17.0.0/16"}]

class DockerNetwork {
  DockerNetwork({
    this.network,
  });

  static Future<DockerNetwork> list({int page = 1, String keyword = "official"}) async {
    DsmResponse res = await Api.dsm.entry(
      "SYNO.Docker.Network",
      "list",
      version: 1,
      parser: DockerNetwork.fromJson,
    );
    return res.data;
  }

  DockerNetwork.fromJson(dynamic json) {
    if (json['network'] != null) {
      network = [];
      json['network'].forEach((v) {
        network?.add(Network.fromJson(v));
      });
    }
  }
  List<Network>? network;
  DockerNetwork copyWith({
    List<Network>? network,
  }) =>
      DockerNetwork(
        network: network ?? this.network,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (network != null) {
      map['network'] = network?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// containers : ["emby","qbittorrent","qinglong","ChatGPT","chinesesubfinder","moviepilot","sonarr","jackett","radarr","ShellngnPro","clash","nas-tools","webssh","jellyfin","yunzai-bot","redis"]
/// driver : "bridge"
/// enable_ipv6 : false
/// gateway : "172.17.0.1"
/// id : "53dd2cab2cb028a9c7d00d6d2922fdb63cc34fb1b1d1e6c6a5ff8be00f83203e"
/// iprange : ""
/// name : "bridge"
/// subnet : "172.17.0.0/16"

class Network {
  Network({
    this.containers,
    this.driver,
    this.enableIpv6,
    this.gateway,
    this.id,
    this.iprange,
    this.name,
    this.subnet,
  });

  Network.fromJson(dynamic json) {
    containers = json['containers'] != null ? json['containers'].cast<String>() : [];
    driver = json['driver'];
    enableIpv6 = json['enable_ipv6'];
    gateway = json['gateway'];
    id = json['id'];
    iprange = json['iprange'];
    name = json['name'];
    subnet = json['subnet'];
  }
  List<String>? containers;
  String? driver;
  bool? enableIpv6;
  String? gateway;
  String? id;
  String? iprange;
  String? name;
  String? subnet;
  Network copyWith({
    List<String>? containers,
    String? driver,
    bool? enableIpv6,
    String? gateway,
    String? id,
    String? iprange,
    String? name,
    String? subnet,
  }) =>
      Network(
        containers: containers ?? this.containers,
        driver: driver ?? this.driver,
        enableIpv6: enableIpv6 ?? this.enableIpv6,
        gateway: gateway ?? this.gateway,
        id: id ?? this.id,
        iprange: iprange ?? this.iprange,
        name: name ?? this.name,
        subnet: subnet ?? this.subnet,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['containers'] = containers;
    map['driver'] = driver;
    map['enable_ipv6'] = enableIpv6;
    map['gateway'] = gateway;
    map['id'] = id;
    map['iprange'] = iprange;
    map['name'] = name;
    map['subnet'] = subnet;
    return map;
  }
}
