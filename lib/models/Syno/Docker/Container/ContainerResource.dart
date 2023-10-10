import 'package:dsm_helper/models/base_model.dart';

/// resources : [{"cpu":0.07500000298023224,"memory":794316800,"memoryPercent":9.665995597839355,"name":"emby"},{"cpu":0.10000000149011612,"memory":2882625536,"memoryPercent":35.0785026550293,"name":"qbittorrent"},{"cpu":2.875,"memory":520192000,"memoryPercent":6.330186367034912,"name":"qinglong"},{"cpu":0,"memory":0,"memoryPercent":0,"name":"ChatGPT"},{"cpu":0,"memory":0,"memoryPercent":0,"name":"chinesesubfinder"},{"cpu":0,"memory":0,"memoryPercent":0,"name":"moviepilot"},{"cpu":0,"memory":0,"memoryPercent":0,"name":"sonarr"},{"cpu":0,"memory":0,"memoryPercent":0,"name":"jackett"},{"cpu":0,"memory":0,"memoryPercent":0,"name":"radarr"},{"cpu":0,"memory":0,"memoryPercent":0,"name":"ShellngnPro"},{"cpu":0,"memory":20983808,"memoryPercent":0.2553507387638092,"name":"clash"},{"cpu":0.07500000298023224,"memory":546095104,"memoryPercent":6.645400047302246,"name":"nas-tools"},{"cpu":0,"memory":0,"memoryPercent":0,"name":"webssh"},{"cpu":0.05000000074505806,"memory":533385216,"memoryPercent":6.490734100341797,"name":"jellyfin"},{"cpu":0,"memory":0,"memoryPercent":0,"name":"yunzai-bot"},{"cpu":0,"memory":0,"memoryPercent":0,"name":"redis"}]

class ContainerResource extends BaseModel {
  ContainerResource({
    this.resources,
  });

  fromJson(dynamic json) {
    return ContainerResource.fromJson(json);
  }

  ContainerResource.fromJson(dynamic json) {
    if (json['resources'] != null) {
      resources = [];
      json['resources'].forEach((v) {
        resources?.add(Resources.fromJson(v));
      });
    }
  }
  List<Resources>? resources;

  String? api = "SYNO.Docker.Container.Resource";
  String? method = "get";
  int? version = 1;

  ContainerResource copyWith({
    List<Resources>? resources,
  }) =>
      ContainerResource(
        resources: resources ?? this.resources,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (resources != null) {
      map['resources'] = resources?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// cpu : 0.07500000298023224
/// memory : 794316800
/// memoryPercent : 9.665995597839355
/// name : "emby"

class Resources {
  Resources({
    this.cpu,
    this.memory,
    this.memoryPercent,
    this.name,
  });

  Resources.fromJson(dynamic json) {
    cpu = json['cpu'];
    memory = json['memory'];
    memoryPercent = json['memoryPercent'];
    name = json['name'];
  }
  num? cpu;
  int? memory;
  num? memoryPercent;
  String? name;
  Resources copyWith({
    num? cpu,
    int? memory,
    num? memoryPercent,
    String? name,
  }) =>
      Resources(
        cpu: cpu ?? this.cpu,
        memory: memory ?? this.memory,
        memoryPercent: memoryPercent ?? this.memoryPercent,
        name: name ?? this.name,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['cpu'] = cpu;
    map['memory'] = memory;
    map['memoryPercent'] = memoryPercent;
    map['name'] = name;
    return map;
  }
}
