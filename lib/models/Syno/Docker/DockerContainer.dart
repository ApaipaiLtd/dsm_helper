import 'package:dsm_helper/models/Syno/Docker/Container/ContainerResource.dart';
import 'package:dsm_helper/models/base_model.dart';
import 'package:dsm_helper/pages/docker/enums/docker_status_enum.dart';

/// containers : [{"State":{"Dead":false,"Error":"","ExitCode":0,"FinishedAt":"2023-10-06T11:51:17.428663331+08:00","FinishedTs":1696564277,"OOMKilled":false,"Paused":false,"Pid":24831,"Restarting":false,"Running":true,"StartedAt":"2023-10-06T10:55:42.610619799Z","StartedTs":1696589742,"Status":"running"},"cmd":"/init","created":1692757028,"enable_service_portal":false,"exporting":false,"finish_time":1696564277,"id":"96c9f8825e8b5c4d62585d166bb357149d04aed314f5ef6fe409cdd5fb3ab5b1","image":"lovechen/embyserver:latest","is_ddsm":false,"is_package":false,"name":"emby","services":null,"status":"running","up_status":"Up 22 hours","up_time":1696589742},{"State":{"Dead":false,"Error":"","ExitCode":0,"FinishedAt":"2023-10-06T11:51:17.310896043+08:00","FinishedTs":1696564277,"OOMKilled":false,"Paused":false,"Pid":25204,"Restarting":false,"Running":true,"StartedAt":"2023-10-06T10:55:47.19214882Z","StartedTs":1696589747,"Status":"running"},"cmd":"/init","created":1692756642,"enable_service_portal":false,"exporting":false,"finish_time":1696564277,"id":"c2475629986b213e6f557b999ea850790d2ef748f5d2a8d45f509f8176fe7205","image":"linuxserver/qbittorrent:latest","is_ddsm":false,"is_package":false,"name":"qbittorrent","services":null,"status":"running","up_status":"Up 22 hours","up_time":1696589747},{"State":{"Dead":false,"Error":"","ExitCode":0,"FinishedAt":"2023-10-06T11:51:17.427776566+08:00","FinishedTs":1696564277,"Health":{"FailingStreak":0,"Log":[{"End":"2023-10-07T17:06:13.494262019+08:00","ExitCode":0,"Output":"{\"code\":200,\"data\":{\"status\":1}}","Start":"2023-10-07T17:06:13.36344703+08:00"},{"End":"2023-10-07T17:06:18.701329827+08:00","ExitCode":0,"Output":"{\"code\":200,\"data\":{\"status\":1}}","Start":"2023-10-07T17:06:18.571155764+08:00"},{"End":"2023-10-07T17:06:23.912355433+08:00","ExitCode":0,"Output":"{\"code\":200,\"data\":{\"status\":1}}","Start":"2023-10-07T17:06:23.78379732+08:00"},{"End":"2023-10-07T17:06:29.117796672+08:00","ExitCode":0,"Output":"{\"code\":200,\"data\":{\"status\":1}}","Start":"2023-10-07T17:06:28.982746032+08:00"},{"End":"2023-10-07T17:06:34.326893205+08:00","ExitCode":0,"Output":"{\"code\":200,\"data\":{\"status\":1}}","Start":"2023-10-07T17:06:34.192647223+08:00"}],"Status":"healthy"},"OOMKilled":false,"Paused":false,"Pid":25302,"Restarting":false,"Running":true,"StartedAt":"2023-10-06T10:55:49.662836379Z","StartedTs":1696589749,"Status":"running"},"cmd":"./docker/docker-entrypoint.sh","created":1692755214,"enable_service_portal":false,"exporting":false,"finish_time":1696564277,"id":"102e7c98c8412153979499cebc703d562916a34cf3136771bba2efda5c4d6741","image":"whyour/qinglong:latest","is_ddsm":false,"is_package":false,"name":"qinglong","services":null,"status":"running","up_status":"Up 22 hours (healthy)","up_time":1696589749},{"State":{"Dead":false,"Error":"","ExitCode":137,"FinishedAt":"2023-09-27T05:48:33.446473421Z","FinishedTs":1695793713,"OOMKilled":false,"Paused":false,"Pid":0,"Restarting":false,"Running":false,"StartedAt":"2023-09-08T09:30:21.65790614Z","StartedTs":1694165421,"Status":"exited"},"cmd":"bin/startup.sh","created":1692754747,"enable_service_portal":false,"exporting":false,"finish_time":1695793713,"id":"f24e838188f63b968ac6a6e053ae029cad145c12712736abc880da6e02e0140e","image":"pengzhile/pandora:latest","is_ddsm":false,"is_package":false,"name":"ChatGPT","services":null,"status":"stopped","up_status":"Exited (137) 10 days ago","up_time":1694165421},{"State":{"Dead":false,"Error":"","ExitCode":255,"FinishedAt":"2023-10-06T11:51:17.492601605+08:00","FinishedTs":1696564277,"OOMKilled":false,"Paused":false,"Pid":0,"Restarting":false,"Running":false,"StartedAt":"2023-09-04T01:09:27.70675159Z","StartedTs":1693789767,"Status":"exited"},"cmd":"tini entrypoint.sh","created":1690942061,"enable_service_portal":false,"exporting":false,"finish_time":1696564277,"id":"d57ef8ab36d985fa22733850da0688b0cea54dafdfb4c19a5e79bd7bbe271985","image":"allanpk716/chinesesubfinder:latest","is_ddsm":false,"is_package":false,"name":"chinesesubfinder","services":null,"status":"stopped","up_status":"Exited (255) 29 hours ago","up_time":1693789767},{"State":{"Dead":false,"Error":"","ExitCode":0,"FinishedAt":"2023-08-02T01:41:58.26144345Z","FinishedTs":1690940518,"OOMKilled":false,"Paused":false,"Pid":0,"Restarting":false,"Running":false,"StartedAt":"2023-08-01T08:42:53.94676577Z","StartedTs":1690879373,"Status":"exited"},"cmd":"/app/start.sh","created":1690879348,"enable_service_portal":false,"exporting":false,"finish_time":1690940518,"id":"1b01815c9fc505753ffbb57dc49d5f1f27d957b69cb7c0222a3815a6200fc438","image":"jxxghp/moviepilot:latest","is_ddsm":false,"is_package":false,"name":"moviepilot","services":null,"status":"stopped","up_status":"Exited (0) 2 months ago","up_time":1690879373},{"State":{"Dead":false,"Error":"","ExitCode":0,"FinishedAt":"2023-08-01T07:42:24.262526413Z","FinishedTs":1690875744,"OOMKilled":false,"Paused":false,"Pid":0,"Restarting":false,"Running":false,"StartedAt":"2023-08-01T07:39:10.949274242Z","StartedTs":1690875550,"Status":"exited"},"cmd":"/init","created":1690875321,"enable_service_portal":false,"exporting":false,"finish_time":1690875744,"id":"b288c52991a90af86766e2de61459c1ddec56263974aca83df197dfcf2ea6d05","image":"linuxserver/sonarr:4.0.0-develop","is_ddsm":false,"is_package":false,"name":"sonarr","services":null,"status":"stopped","up_status":"Exited (0) 2 months ago","up_time":1690875550},{"State":{"Dead":false,"Error":"","ExitCode":0,"FinishedAt":"2023-08-23T01:42:19.721171654Z","FinishedTs":1692754939,"OOMKilled":false,"Paused":false,"Pid":0,"Restarting":false,"Running":false,"StartedAt":"2023-08-01T00:49:10.314494859Z","StartedTs":1690850950,"Status":"exited"},"cmd":"/init","created":1690850947,"enable_service_portal":false,"exporting":false,"finish_time":1692754939,"id":"de0bc8a817b810147fc7b08f1c8bde4f64404086086d800e80be75163ecee103","image":"linuxserver/jackett:latest","is_ddsm":false,"is_package":false,"name":"jackett","services":null,"status":"stopped","up_status":"Exited (0) 6 weeks ago","up_time":1690850950},{"State":{"Dead":false,"Error":"","ExitCode":0,"FinishedAt":"2023-08-02T01:42:12.056402589Z","FinishedTs":1690940532,"OOMKilled":false,"Paused":false,"Pid":0,"Restarting":false,"Running":false,"StartedAt":"2023-07-31T09:13:32.964986014Z","StartedTs":1690794812,"Status":"exited"},"cmd":"/init","created":1690794810,"enable_service_portal":false,"exporting":false,"finish_time":1690940532,"id":"9adb75b8b6680e98d913f68dae44ec7a8943720470fd012f5cc8c958ddc256e0","image":"linuxserver/radarr:latest","is_ddsm":false,"is_package":false,"name":"radarr","services":null,"status":"stopped","up_status":"Exited (0) 2 months ago","up_time":1690794812},{"State":{"Dead":false,"Error":"","ExitCode":255,"FinishedAt":"2023-10-06T11:51:17.428371095+08:00","FinishedTs":1696564277,"OOMKilled":false,"Paused":false,"Pid":0,"Restarting":false,"Running":false,"StartedAt":"2023-09-04T01:09:48.181877357Z","StartedTs":1693789788,"Status":"exited"},"cmd":"docker-entrypoint.sh /bin/sh -c 'node bundle.js'","created":1690790277,"enable_service_portal":false,"exporting":false,"finish_time":1696564277,"id":"26aecac4650cde00a7b6a7d3057d51f495e041be4367cf4c5aaeb051f37c141e","image":"shellngn/pro:latest","is_ddsm":false,"is_package":false,"name":"ShellngnPro","services":null,"status":"stopped","up_status":"Exited (255) 29 hours ago","up_time":1693789788},{"State":{"Dead":false,"Error":"","ExitCode":0,"FinishedAt":"2023-10-06T11:51:17.428664687+08:00","FinishedTs":1696564277,"OOMKilled":false,"Paused":false,"Pid":23833,"Restarting":false,"Running":true,"StartedAt":"2023-10-06T10:54:26.226291327Z","StartedTs":1696589666,"Status":"running"},"cmd":"/clash","created":1684305292,"enable_service_portal":false,"exporting":false,"finish_time":1696564277,"id":"a42a040393472acc22e89ec4959f3bde0b11cd6c0a51351b544e49928c0d527d","image":"dreamacro/clash:latest","is_ddsm":false,"is_package":false,"name":"clash","services":null,"status":"running","up_status":"Up 22 hours","up_time":1696589666},{"State":{"Dead":false,"Error":"","ExitCode":0,"FinishedAt":"2023-10-06T18:33:29.701965543+08:00","FinishedTs":1696588409,"OOMKilled":false,"Paused":false,"Pid":17481,"Restarting":false,"Running":true,"StartedAt":"2023-10-06T10:33:41.451730788Z","StartedTs":1696588421,"Status":"running"},"cmd":"/init","created":1683537741,"enable_service_portal":false,"exporting":false,"finish_time":1696588409,"id":"034e9e6d03f4b97a0226b4fa4c49895acbf66de6d61cccabc3a46e9fd0240b77","image":"challengerv/nas-tools-unlock:latest","is_ddsm":false,"is_package":false,"name":"nas-tools","services":null,"status":"running","up_status":"Up 23 hours","up_time":1696588421},{"State":{"Dead":false,"Error":"","ExitCode":0,"FinishedAt":"2023-06-25T03:12:13.158663329Z","FinishedTs":1687662733,"OOMKilled":false,"Paused":false,"Pid":0,"Restarting":false,"Running":false,"StartedAt":"2023-06-12T03:28:50.746839817Z","StartedTs":1686540530,"Status":"exited"},"cmd":"npm start","created":1683112416,"enable_service_portal":false,"exporting":false,"finish_time":1687662733,"id":"ea491a26f896d66e43ec67a67e42e46641f28787aba23c8955e59998d807d9c8","image":"psharkey/webssh2:latest","is_ddsm":false,"is_package":false,"name":"webssh","services":null,"status":"stopped","up_status":"Exited (0) 3 months ago","up_time":1686540530},{"State":{"Dead":false,"Error":"","ExitCode":0,"FinishedAt":"2023-10-06T18:33:29.708865241+08:00","FinishedTs":1696588409,"Health":{"FailingStreak":0,"Log":[{"End":"2023-10-07T17:04:21.034195603+08:00","ExitCode":0,"Output":"  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current\n                                 Dload  Upload   Total   Spent    Left  Speed\n\r  0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0\r100     7    0     7    0     0   2333      0 --:--:-- --:--:-- --:--:--  2333\nHealthy","Start":"2023-10-07T17:04:20.883374112+08:00"},{"End":"2023-10-07T17:04:51.262565187+08:00","ExitCode":0,"Output":"  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current\n                                 Dload  Upload   Total   Spent    Left  Speed\n\r  0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0\r100     7    0     7 Healthy   0     0   1750      0 --:--:-- --:--:-- --:--:--  1750\n","Start":"2023-10-07T17:04:51.107984248+08:00"},{"End":"2023-10-07T17:05:21.535184521+08:00","ExitCode":0,"Output":"  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current\n                                 Dload  Upload   Total   Spent    Left  Speed\n\r  0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0\r100     7    0     7    0     0   1166      0 --:--:-- --:--:-- --:--:--  1400\nHealthy","Start":"2023-10-07T17:05:21.332640085+08:00"},{"End":"2023-10-07T17:05:51.778783054+08:00","ExitCode":0,"Output":"  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current\n                                 Dload  Upload   Total   Spent    Left  Speed\n\r  0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0\r100     7    0     7    0     0    875      0 --:--:-- --:--:-- --:--:--   875\nHealthy","Start":"2023-10-07T17:05:51.618322515+08:00"},{"End":"2023-10-07T17:06:22.000513193+08:00","ExitCode":0,"Output":"  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current\n                                 Dload  Upload   Total   Spent    Left  Speed\n\r  0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0\r100     7    0     7    0     0   1750      0 --:--:-- --:--:-- --:--:--  2333\nHealthy","Start":"2023-10-07T17:06:21.842707364+08:00"}],"Status":"healthy"},"OOMKilled":false,"Paused":false,"Pid":17400,"Restarting":false,"Running":true,"StartedAt":"2023-10-06T10:33:40.582409626Z","StartedTs":1696588420,"Status":"running"},"cmd":"/jellyfin/jellyfin","created":1682756551,"enable_service_portal":false,"exporting":false,"finish_time":1696588409,"id":"e4ffccaabc86190aa11939e8b96c3c342e8b6df53698eacc9f72b51e253bac75","image":"jellyfin/jellyfin:latest","is_ddsm":false,"is_package":false,"name":"jellyfin","services":null,"status":"running","up_status":"Up 23 hours (healthy)","up_time":1696588420},{"State":{"Dead":false,"Error":"","ExitCode":137,"FinishedAt":"2023-07-31T07:57:04.425693351Z","FinishedTs":1690790224,"OOMKilled":false,"Paused":false,"Pid":0,"Restarting":false,"Running":false,"StartedAt":"2023-07-29T16:29:36.788309912Z","StartedTs":1690648176,"Status":"exited"},"cmd":"/app/Yunzai-Bot/entrypoint.sh","created":1682752754,"enable_service_portal":false,"exporting":false,"finish_time":1690790224,"id":"88821db32b4e9481ba640358424a279bf35dc6843e38cbbdb32477a44899dbe5","image":"sirly/yunzai-bot:latest","is_ddsm":false,"is_package":false,"name":"yunzai-bot","services":null,"status":"stopped","up_status":"Exited (137) 2 months ago","up_time":1690648176},{"State":{"Dead":false,"Error":"","ExitCode":0,"FinishedAt":"2023-07-31T07:56:49.992997351Z","FinishedTs":1690790209,"OOMKilled":false,"Paused":false,"Pid":0,"Restarting":false,"Running":false,"StartedAt":"2023-07-29T16:29:34.905286714Z","StartedTs":1690648174,"Status":"exited"},"cmd":"docker-entrypoint.sh redis-server","created":1682750995,"enable_service_portal":false,"exporting":false,"finish_time":1690790209,"id":"801ade26d2e66a8dec7b8c8258ae66abb6ccc4e2c02d584e0bd3463daff07042","image":"redis:latest","is_ddsm":false,"is_package":false,"name":"redis","services":null,"status":"stopped","up_status":"Exited (0) 2 months ago","up_time":1690648174}]
/// limit : 16
/// offset : 0
/// total : 16

class DockerContainer extends BaseModel {
  DockerContainer({
    this.containers,
    this.limit,
    this.offset,
    this.total,
  });

  fromJson(dynamic json) {
    return DockerContainer.fromJson(json);
  }

  String? api = "SYNO.Docker.Container";
  String? method = "list";
  int? version = 1;
  Map<String, dynamic>? data = {
    "limit": -1,
    "offset": 0,
    "type": 'all',
  };

  DockerContainer.fromJson(dynamic json) {
    if (json['containers'] != null) {
      containers = [];
      json['containers'].forEach((v) {
        containers?.add(Containers.fromJson(v));
      });
    }
    limit = json['limit'];
    offset = json['offset'];
    total = json['total'];
  }
  List<Containers>? containers;
  int? limit;
  int? offset;
  int? total;

  DockerContainer copyWith({
    List<Containers>? containers,
    int? limit,
    int? offset,
    int? total,
  }) =>
      DockerContainer(
        containers: containers ?? this.containers,
        limit: limit ?? this.limit,
        offset: offset ?? this.offset,
        total: total ?? this.total,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (containers != null) {
      map['containers'] = containers?.map((v) => v.toJson()).toList();
    }
    map['limit'] = limit;
    map['offset'] = offset;
    map['total'] = total;
    return map;
  }
}

/// State : {"Dead":false,"Error":"","ExitCode":0,"FinishedAt":"2023-10-06T11:51:17.428663331+08:00","FinishedTs":1696564277,"OOMKilled":false,"Paused":false,"Pid":24831,"Restarting":false,"Running":true,"StartedAt":"2023-10-06T10:55:42.610619799Z","StartedTs":1696589742,"Status":"running"}
/// cmd : "/init"
/// created : 1692757028
/// enable_service_portal : false
/// exporting : false
/// finish_time : 1696564277
/// id : "96c9f8825e8b5c4d62585d166bb357149d04aed314f5ef6fe409cdd5fb3ab5b1"
/// image : "lovechen/embyserver:latest"
/// is_ddsm : false
/// is_package : false
/// name : "emby"
/// services : null
/// status : "running"
/// up_status : "Up 22 hours"
/// up_time : 1696589742

class Containers {
  Containers({
    this.state,
    this.cmd,
    this.created,
    this.enableServicePortal,
    this.exporting,
    this.finishTime,
    this.id,
    this.image,
    this.isDdsm,
    this.isPackage,
    this.name,
    this.services,
    this.status,
    this.upStatus,
    this.upTime,
  });

  Containers.fromJson(dynamic json) {
    state = json['State'] != null ? State.fromJson(json['State']) : null;
    cmd = json['cmd'];
    created = json['created'];
    enableServicePortal = json['enable_service_portal'];
    exporting = json['exporting'];
    finishTime = json['finish_time'];
    id = json['id'];
    image = json['image'];
    isDdsm = json['is_ddsm'];
    isPackage = json['is_package'];
    name = json['name'];
    services = json['services'];
    status = json['status'];
    upStatus = json['up_status'];
    upTime = json['up_time'];
  }
  State? state;
  String? cmd;
  int? created;
  bool? enableServicePortal;
  bool? exporting;
  int? finishTime;
  String? id;
  String? image;
  bool? isDdsm;
  bool? isPackage;
  String? name;
  dynamic services;
  String? status;
  DockerStatusEnum get statusEnum => DockerStatusEnum.fromValue(status!);
  String? upStatus;
  int? upTime;
  Resources? resource;
  Containers copyWith({
    State? state,
    String? cmd,
    int? created,
    bool? enableServicePortal,
    bool? exporting,
    int? finishTime,
    String? id,
    String? image,
    bool? isDdsm,
    bool? isPackage,
    String? name,
    dynamic services,
    String? status,
    String? upStatus,
    int? upTime,
  }) =>
      Containers(
        state: state ?? this.state,
        cmd: cmd ?? this.cmd,
        created: created ?? this.created,
        enableServicePortal: enableServicePortal ?? this.enableServicePortal,
        exporting: exporting ?? this.exporting,
        finishTime: finishTime ?? this.finishTime,
        id: id ?? this.id,
        image: image ?? this.image,
        isDdsm: isDdsm ?? this.isDdsm,
        isPackage: isPackage ?? this.isPackage,
        name: name ?? this.name,
        services: services ?? this.services,
        status: status ?? this.status,
        upStatus: upStatus ?? this.upStatus,
        upTime: upTime ?? this.upTime,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (state != null) {
      map['State'] = state?.toJson();
    }
    map['cmd'] = cmd;
    map['created'] = created;
    map['enable_service_portal'] = enableServicePortal;
    map['exporting'] = exporting;
    map['finish_time'] = finishTime;
    map['id'] = id;
    map['image'] = image;
    map['is_ddsm'] = isDdsm;
    map['is_package'] = isPackage;
    map['name'] = name;
    map['services'] = services;
    map['status'] = status;
    map['up_status'] = upStatus;
    map['up_time'] = upTime;
    return map;
  }
}

/// Dead : false
/// Error : ""
/// ExitCode : 0
/// FinishedAt : "2023-10-06T11:51:17.428663331+08:00"
/// FinishedTs : 1696564277
/// OOMKilled : false
/// Paused : false
/// Pid : 24831
/// Restarting : false
/// Running : true
/// StartedAt : "2023-10-06T10:55:42.610619799Z"
/// StartedTs : 1696589742
/// Status : "running"

class State {
  State({
    this.dead,
    this.error,
    this.exitCode,
    this.finishedAt,
    this.finishedTs,
    this.oOMKilled,
    this.paused,
    this.pid,
    this.restarting,
    this.running,
    this.startedAt,
    this.startedTs,
    this.status,
  });

  State.fromJson(dynamic json) {
    dead = json['Dead'];
    error = json['Error'];
    exitCode = json['ExitCode'];
    finishedAt = json['FinishedAt'];
    finishedTs = json['FinishedTs'];
    oOMKilled = json['OOMKilled'];
    paused = json['Paused'];
    pid = json['Pid'];
    restarting = json['Restarting'];
    running = json['Running'];
    startedAt = json['StartedAt'];
    startedTs = json['StartedTs'];
    status = json['Status'];
  }
  bool? dead;
  String? error;
  int? exitCode;
  String? finishedAt;
  int? finishedTs;
  bool? oOMKilled;
  bool? paused;
  int? pid;
  bool? restarting;
  bool? running;
  String? startedAt;
  int? startedTs;
  String? status;
  State copyWith({
    bool? dead,
    String? error,
    int? exitCode,
    String? finishedAt,
    int? finishedTs,
    bool? oOMKilled,
    bool? paused,
    int? pid,
    bool? restarting,
    bool? running,
    String? startedAt,
    int? startedTs,
    String? status,
  }) =>
      State(
        dead: dead ?? this.dead,
        error: error ?? this.error,
        exitCode: exitCode ?? this.exitCode,
        finishedAt: finishedAt ?? this.finishedAt,
        finishedTs: finishedTs ?? this.finishedTs,
        oOMKilled: oOMKilled ?? this.oOMKilled,
        paused: paused ?? this.paused,
        pid: pid ?? this.pid,
        restarting: restarting ?? this.restarting,
        running: running ?? this.running,
        startedAt: startedAt ?? this.startedAt,
        startedTs: startedTs ?? this.startedTs,
        status: status ?? this.status,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Dead'] = dead;
    map['Error'] = error;
    map['ExitCode'] = exitCode;
    map['FinishedAt'] = finishedAt;
    map['FinishedTs'] = finishedTs;
    map['OOMKilled'] = oOMKilled;
    map['Paused'] = paused;
    map['Pid'] = pid;
    map['Restarting'] = restarting;
    map['Running'] = running;
    map['StartedAt'] = startedAt;
    map['StartedTs'] = startedTs;
    map['Status'] = status;
    return map;
  }
}
