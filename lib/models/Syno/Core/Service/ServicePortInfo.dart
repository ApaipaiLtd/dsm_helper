import 'package:dsm_helper/models/base_model.dart';

/// port_info : [{"desc":"rsync","dst_port":["873"],"name":"rsync","port_id":"netbkp","protocol":"tcp","src_port":null},{"desc":"网络多功能事务机","dst_port":["3240-3259"],"name":"网络多功能事务机","port_id":"mfp","protocol":"tcp","src_port":null},{"desc":"NTP 服务","dst_port":["123"],"name":"NTP","port_id":"ntp","protocol":"udp","src_port":null},{"desc":"反向代理服务器","dst_port":["5080"],"name":"HTTP","port_id":"ReverseProxy_5080","protocol":"tcp","src_port":null},{"desc":"管理用户接口、File Station、Audio Station、Surveillance Station、Download Station、CMS","dst_port":["5000"],"name":"DSM (HTTP)","port_id":"dms","protocol":"tcp","src_port":null},{"desc":"管理用户接口、File Station、Audio Station、Surveillance Station、Download Station、CMS","dst_port":["5001"],"name":"DSM (HTTPS)","port_id":"dms_https","protocol":"tcp","src_port":null},{"desc":"Web Station 和 Web 邮件","dst_port":["80"],"name":"HTTP","port_id":"http","protocol":"tcp","src_port":null},{"desc":"Web Station 和 Web 邮件","dst_port":["443"],"name":"HTTPS","port_id":"https","protocol":"tcp","src_port":null},{"desc":"UPNP IGD","dst_port":["55001","55002"],"name":"UPNP IGD","port_id":"upnp_igd","protocol":"tcp","src_port":null},{"desc":"Emby Web UI","dst_port":["8096","8920"],"name":"Emby Server","port_id":"EmbyServer","protocol":"tcp","src_port":["8096","8920"]},{"desc":"Hybrid Share","dst_port":["26500-26700"],"name":"Hybrid Share","port_id":"HybridShare","protocol":"tcp","src_port":null},{"desc":"Share Snapshot Replication","dst_port":["5566"],"name":"Share Snapshot Replication","port_id":"btrfs_snapshot_replication","protocol":"tcp","src_port":null},{"desc":"Windows 文件服务器","dst_port":["137","138","139","445"],"name":"CIFS","port_id":"cifs","protocol":"all","src_port":["137","138"]},{"desc":"WS-Discovery","dst_port":["5357"],"name":"WS-Transfer","port_id":"ws_transfer_port","protocol":"tcp","src_port":null},{"desc":"WS-Discovery","dst_port":["3702"],"name":"WS-Discovery","port_id":"ws_discovery_port","protocol":"udp","src_port":null},{"desc":"iSCSI Service","dst_port":["3260","3261","3262"],"name":"iSCSI Service","port_id":"iscsitrg","protocol":"tcp","src_port":null},{"desc":"Advanced LUN replication","dst_port":["3261"],"name":"Advanced LUN replication","port_id":"lunreplication","protocol":"tcp","src_port":null},{"desc":"Windows ODX","dst_port":["3263"],"name":"Windows ODX","port_id":"windowsODX","protocol":"tcp","src_port":null},{"desc":"Virtual Machine Manager Remote Storage","dst_port":["3264"],"name":"Virtual Machine Manager Remote Storage","port_id":"rodsp_vdisk","protocol":"tcp","src_port":null},{"desc":"Synology Storage Console","dst_port":["3265"],"name":"Synology Storage Console","port_id":"storage_console","protocol":"tcp","src_port":null},{"desc":"Synology Drive Server","dst_port":["6690"],"name":"Synology Drive Server","port_id":"cloudstation","protocol":"tcp","src_port":null},{"desc":"Tailscale VPN","dst_port":["41641"],"name":"Tailscale","port_id":"Tailscale","protocol":"udp","src_port":["41641"]},{"desc":"Virtual Machine Manager","dst_port":["2379-2382","2385","16509","16514","30200-30299","30300"],"name":"Virtual Machine Manager","port_id":"synoccc","protocol":"tcp","src_port":null},{"desc":"WebDAV Server","dst_port":["5005"],"name":"WebDAV Server","port_id":"webdav_http","protocol":"tcp","src_port":null},{"desc":"WebDAV Server","dst_port":["5006"],"name":"WebDAV Server(SSL)","port_id":"webdavs_https","protocol":"tcp","src_port":null},{"desc":"Docker ChatGPT","dst_port":["8899"],"name":"Docker(TCP)","port_id":"ChatGPT_tcp","protocol":"tcp","src_port":null},{"desc":"Docker ShellngnPro","dst_port":["2222"],"name":"Docker(TCP)","port_id":"ShellngnPro_tcp","protocol":"tcp","src_port":null},{"desc":"Docker chinesesubfinder","dst_port":["19035","19037"],"name":"Docker(TCP)","port_id":"chinesesubfinder_tcp","protocol":"tcp","src_port":null},{"desc":"Docker clash","dst_port":["7890","7891","9090"],"name":"Docker(TCP)","port_id":"clash_tcp","protocol":"tcp","src_port":null},{"desc":"Docker emby","dst_port":["7096","7920"],"name":"Docker(TCP)","port_id":"emby_tcp","protocol":"tcp","src_port":null},{"desc":"Docker emby","dst_port":["2900","8359"],"name":"Docker(UDP)","port_id":"emby_udp","protocol":"udp","src_port":null},{"desc":"Docker jackett","dst_port":["9117"],"name":"Docker(TCP)","port_id":"jackett_tcp","protocol":"tcp","src_port":null},{"desc":"Docker jellyfin","dst_port":["9096","9920"],"name":"Docker(TCP)","port_id":"jellyfin_tcp","protocol":"tcp","src_port":null},{"desc":"Docker nas-tools","dst_port":["3000"],"name":"Docker(TCP)","port_id":"nas-tools_tcp","protocol":"tcp","src_port":null},{"desc":"Docker qbittorrent","dst_port":["5581","52000"],"name":"Docker(TCP)","port_id":"qbittorrent_tcp","protocol":"tcp","src_port":null},{"desc":"Docker qbittorrent","dst_port":["52000"],"name":"Docker(UDP)","port_id":"qbittorrent_udp","protocol":"udp","src_port":null},{"desc":"Docker qinglong","dst_port":["5700"],"name":"Docker(TCP)","port_id":"qinglong_tcp","protocol":"tcp","src_port":null},{"desc":"Docker radarr","dst_port":["7878"],"name":"Docker(TCP)","port_id":"radarr_tcp","protocol":"tcp","src_port":null},{"desc":"Docker redis","dst_port":["6379"],"name":"Docker(TCP)","port_id":"redis_tcp","protocol":"tcp","src_port":null},{"desc":"Docker sonarr","dst_port":["11111"],"name":"Docker(TCP)","port_id":"sonarr_tcp","protocol":"tcp","src_port":null},{"desc":"Docker webssh","dst_port":["2233"],"name":"Docker(TCP)","port_id":"webssh_tcp","protocol":"tcp","src_port":null},{"desc":"Docker yunzai-bot","dst_port":["50831"],"name":"Docker(TCP)","port_id":"yunzai-bot_tcp","protocol":"tcp","src_port":null},{"desc":"网络打印机，Apple 无线打印","dst_port":["631"],"name":"IPP","port_id":"ipp","protocol":"tcp","src_port":null},{"desc":"网络打印机","dst_port":["515"],"name":"LPR","port_id":"lpr","protocol":"tcp","src_port":null},{"desc":"VisualStation","dst_port":["19999"],"name":"搜索 VisualStation","port_id":"vs60","protocol":"udp","src_port":null},{"desc":"Bonjour","dst_port":["5353"],"name":"Bonjour 服务","port_id":"bonjour","protocol":"udp","src_port":null},{"desc":"SNMP 服务","dst_port":["161"],"name":"SNMP","port_id":"snmp","protocol":"udp","src_port":null},{"desc":"FTP 文件服务器","dst_port":["21","55536-55899"],"name":"FTP","port_id":"ftp","protocol":"tcp","src_port":null},{"desc":"与 Mac 分享文件","dst_port":["548"],"name":"AFP","port_id":"afp","protocol":"tcp","src_port":null},{"desc":"Mac/Linux 文件服务器","dst_port":["111","662","892","2049","4045"],"name":"NFS","port_id":"nfs","protocol":"all","src_port":null},{"desc":"Synology Assistant, 网络备份","dst_port":["1234","9997","9998","9999"],"name":"搜索 DiskStation","port_id":"findhostd","protocol":"udp","src_port":null},{"desc":"UPS 服务器","dst_port":["3493"],"name":"不断电系统","port_id":"ups_server","protocol":"tcp","src_port":null},{"desc":"加密的终端服务（包括加密的 rsync 和 SFTP）","dst_port":["22"],"name":"SSH","port_id":"ssh","protocol":"tcp","src_port":null},{"desc":"未加密终端机服务","dst_port":["23"],"name":"Telnet","port_id":"telnet","protocol":"tcp","src_port":null}]

class ServicePortInfo implements BaseModel {
  ServicePortInfo({this.portInfo, List<String> serviceId = const []}) {
    data = {
      "service_id": serviceId,
    };
  }

  String? api = "SYNO.Core.Service.PortInfo";
  String? method = "load";
  int? version = 1;

  ServicePortInfo.fromJson(dynamic json) {
    if (json['port_info'] != null) {
      portInfo = [];
      json['port_info'].forEach((v) {
        portInfo?.add(PortInfo.fromJson(v));
      });
    }
  }
  List<PortInfo>? portInfo;
  ServicePortInfo copyWith({
    List<PortInfo>? portInfo,
  }) =>
      ServicePortInfo(
        portInfo: portInfo ?? this.portInfo,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (portInfo != null) {
      map['port_info'] = portInfo?.map((v) => v.toJson()).toList();
    }
    return map;
  }

  @override
  fromJson(json) {
    return ServicePortInfo.fromJson(json);
  }

  @override
  Map<String, dynamic>? data;
}

/// desc : "rsync"
/// dst_port : ["873"]
/// name : "rsync"
/// port_id : "netbkp"
/// protocol : "tcp"
/// src_port : null

class PortInfo {
  PortInfo({
    this.desc,
    this.dstPort,
    this.name,
    this.portId,
    this.protocol,
    this.srcPort,
    this.status,
  });

  PortInfo.fromJson(dynamic json) {
    desc = json['desc'];
    dstPort = json['dst_port'] != null ? json['dst_port'].cast<String>() : [];
    name = json['name'];
    portId = json['port_id'];
    protocol = json['protocol'];
    srcPort = json['src_port'];
    status = json['status'];
  }
  String? desc;
  List<String>? dstPort;
  String? name;
  String? portId;
  String? protocol;
  String? status;
  dynamic srcPort;
  PortInfo copyWith({
    String? desc,
    List<String>? dstPort,
    String? name,
    String? portId,
    String? protocol,
    String? status,
    dynamic srcPort,
  }) =>
      PortInfo(
        desc: desc ?? this.desc,
        dstPort: dstPort ?? this.dstPort,
        name: name ?? this.name,
        portId: portId ?? this.portId,
        protocol: protocol ?? this.protocol,
        srcPort: srcPort ?? this.srcPort,
        status: status ?? this.status,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['desc'] = desc;
    map['dst_port'] = dstPort;
    map['name'] = name;
    map['port_id'] = portId;
    map['protocol'] = protocol;
    map['src_port'] = srcPort;
    map['status'] = status;
    return map;
  }
}
