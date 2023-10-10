import 'package:dsm_helper/apis/api.dart';

/// data : [{"description":"Official build of Nginx.","downloads":8514367430,"is_automated":false,"is_official":true,"name":"nginx","registry":"https://registry.hub.docker.com","star_count":19093},{"description":"DEPRECATED; The official build of CentOS.","downloads":1130623323,"is_automated":false,"is_official":true,"name":"centos","registry":"https://registry.hub.docker.com","star_count":7647},{"description":"Official Docker builds of Fedora","downloads":114110147,"is_automated":false,"is_official":true,"name":"fedora","registry":"https://registry.hub.docker.com","star_count":1166},{"description":"Official Docker builds of Oracle Linux.","downloads":32784401,"is_automated":false,"is_official":true,"name":"oraclelinux","registry":"https://registry.hub.docker.com","star_count":1020},{"description":"Official Images for OpenJDK binaries built by Eclipse Temurin.","downloads":74595177,"is_automated":false,"is_official":true,"name":"eclipse-temurin","registry":"https://registry.hub.docker.com","star_count":427},{"description":"The official build of Rocky Linux.","downloads":28639309,"is_automated":false,"is_official":true,"name":"rockylinux","registry":"https://registry.hub.docker.com","star_count":183},{"description":"Official docker build of Clear Linux OS for Intel Architecture","downloads":6798299,"is_automated":false,"is_official":true,"name":"clearlinux","registry":"https://registry.hub.docker.com","star_count":167},{"description":"The official build of AlmaLinux OS.","downloads":4415114,"is_automated":false,"is_official":true,"name":"almalinux","registry":"https://registry.hub.docker.com","star_count":127},{"description":"Official IBM® SDK, Java™ Technology Edition Docker Image.","downloads":12860736,"is_automated":false,"is_official":true,"name":"ibmjava","registry":"https://registry.hub.docker.com","star_count":123},{"description":"The official Docker image of Eggdrop- IRC's oldest actively-developed bot!","downloads":2775244,"is_automated":false,"is_official":true,"name":"eggdrop","registry":"https://registry.hub.docker.com","star_count":77},{"description":"DEPRECATED; The Official Docker Image of Express Gateway, an API Gateway for APIs and Microservices","downloads":2366649,"is_automated":false,"is_official":true,"name":"express-gateway","registry":"https://registry.hub.docker.com","star_count":74},{"description":"The official build of ALT Linux.","downloads":661370,"is_automated":false,"is_official":true,"name":"alt","registry":"https://registry.hub.docker.com","star_count":56},{"description":"Official containers for Scientific Linux(SL)","downloads":590006,"is_automated":false,"is_official":true,"name":"sl","registry":"https://registry.hub.docker.com","star_count":51},{"description":"Official SapMachine Docker Image, SAP's build of OpenJDK.","downloads":21703225,"is_automated":false,"is_official":true,"name":"sapmachine","registry":"https://registry.hub.docker.com","star_count":46},{"description":"Official Mageia base image","downloads":1604469,"is_automated":false,"is_official":true,"name":"mageia","registry":"https://registry.hub.docker.com","star_count":44},{"description":"IBM Semeru Runtimes Official Images for OpenJDK and Eclipse OpenJ9 binaries.","downloads":3077559,"is_automated":false,"is_official":true,"name":"ibm-semeru-runtimes","registry":"https://registry.hub.docker.com","star_count":35},{"description":"The official build of ClefOS.","downloads":691115,"is_automated":false,"is_official":true,"name":"clefos","registry":"https://registry.hub.docker.com","star_count":23},{"description":"Official build of NGINX Unit: Universal Web App Server","downloads":88144,"is_automated":false,"is_official":true,"name":"unit","registry":"https://registry.hub.docker.com","star_count":15},{"description":"The official Grafana docker container","downloads":4337787856,"is_automated":false,"is_official":false,"name":"grafana/grafana","registry":"https://registry.hub.docker.com","star_count":2771},{"description":"Official Confluence Server image – create, organise and discuss work with your team.","downloads":66010605,"is_automated":true,"is_official":false,"name":"atlassian/confluence-server","registry":"https://registry.hub.docker.com","star_count":579},{"description":"The official image of netdata - the open-source, real-time, performance and health monitoring.","downloads":425967302,"is_automated":false,"is_official":false,"name":"netdata/netdata","registry":"https://registry.hub.docker.com","star_count":495},{"description":"Official Docker image for JetBrains YouTrack","downloads":60050895,"is_automated":false,"is_official":false,"name":"jetbrains/youtrack","registry":"https://registry.hub.docker.com","star_count":231},{"description":"Official Docker image for JetBrains Upsource","downloads":2340759,"is_automated":false,"is_official":false,"name":"jetbrains/upsource","registry":"https://registry.hub.docker.com","star_count":136},{"description":" The official Docker image for Mattermost Team Edition.","downloads":64019789,"is_automated":false,"is_official":false,"name":"mattermost/mattermost-team-edition","registry":"https://registry.hub.docker.com","star_count":104},{"description":"Official vault docker images","downloads":71793758,"is_automated":false,"is_official":false,"name":"hashicorp/vault","registry":"https://registry.hub.docker.com","star_count":98},{"description":"Discontinued: please use the \"dart\" Docker Official Image.","downloads":2076951,"is_automated":false,"is_official":false,"name":"google/dart","registry":"https://registry.hub.docker.com","star_count":88},{"description":"The Official Docker Image of OpenSearch (https://opensearch.org/)","downloads":40821131,"is_automated":false,"is_official":false,"name":"opensearchproject/opensearch","registry":"https://registry.hub.docker.com","star_count":80},{"description":"Official Dockerfile frontend images that enable building Dockerfiles with BuildKit","downloads":274263887,"is_automated":false,"is_official":false,"name":"docker/dockerfile","registry":"https://registry.hub.docker.com","star_count":70},{"description":"Official Docker image for JetBrains Hub","downloads":17135321,"is_automated":false,"is_official":false,"name":"jetbrains/hub","registry":"https://registry.hub.docker.com","star_count":68},{"description":"The Official MongoDB Community Server","downloads":428773,"is_automated":false,"is_official":false,"name":"mongodb/mongodb-community-server","registry":"https://registry.hub.docker.com","star_count":40},{"description":"The Official Docker Image of OpenSearch Dashboards (https://opensearch.org/) ","downloads":6676789,"is_automated":false,"is_official":false,"name":"opensearchproject/opensearch-dashboards","registry":"https://registry.hub.docker.com","star_count":34},{"description":"Discontinued: please use the \"dart\" Docker Official Image.","downloads":97714,"is_automated":false,"is_official":false,"name":"google/dart-runtime","registry":"https://registry.hub.docker.com","star_count":32},{"description":"The official Docker image for Mattermost Enterprise Edition.","downloads":11573246,"is_automated":false,"is_official":false,"name":"mattermost/mattermost-enterprise-edition","registry":"https://registry.hub.docker.com","star_count":20},{"description":"Official Grafana Enterprise docker image","downloads":7007621,"is_automated":false,"is_official":false,"name":"grafana/grafana-enterprise","registry":"https://registry.hub.docker.com","star_count":19},{"description":"The Official Docker Image of Logstash with OpenSearch Output Plugin (https://opensearch.org/) ","downloads":2389385,"is_automated":false,"is_official":false,"name":"opensearchproject/logstash-oss-with-opensearch-output-plugin","registry":"https://registry.hub.docker.com","star_count":19},{"description":"The official and verified Cal.com Docker Image","downloads":326603,"is_automated":false,"is_official":false,"name":"calcom/cal.com","registry":"https://registry.hub.docker.com","star_count":16},{"description":"Official Nessus Scanner","downloads":73194,"is_automated":false,"is_official":false,"name":"tenable/nessus","registry":"https://registry.hub.docker.com","star_count":13},{"description":"RapidFort optimized, hardened image for PostgreSQL Official","downloads":140629,"is_automated":false,"is_official":false,"name":"rapidfort/postgresql-official","registry":"https://registry.hub.docker.com","star_count":12},{"description":"The Official Docker Image of OpenSearch Data Prepper (https://opensearch.org/) ","downloads":520237,"is_automated":false,"is_official":false,"name":"opensearchproject/data-prepper","registry":"https://registry.hub.docker.com","star_count":11},{"description":"RapidFort optimized, hardened image for MongoDB® Official","downloads":66879,"is_automated":false,"is_official":false,"name":"rapidfort/mongodb-official","registry":"https://registry.hub.docker.com","star_count":11},{"description":"nightly kong images. Official docker hub images can be found here https://hub.docker.com/_/kong","downloads":1015636,"is_automated":false,"is_official":false,"name":"kong/kong","registry":"https://registry.hub.docker.com","star_count":9},{"description":"Official vault enterprise docker images","downloads":6052416,"is_automated":false,"is_official":false,"name":"hashicorp/vault-enterprise","registry":"https://registry.hub.docker.com","star_count":9},{"description":"Official images for govmomi/govc","downloads":143610,"is_automated":false,"is_official":false,"name":"vmware/govc","registry":"https://registry.hub.docker.com","star_count":7},{"description":"Official images for govmomi/vcsim","downloads":342539,"is_automated":false,"is_official":false,"name":"vmware/vcsim","registry":"https://registry.hub.docker.com","star_count":5},{"description":"The Official MongoDB Enterprise Advanced Server.","downloads":98311,"is_automated":false,"is_official":false,"name":"mongodb/mongodb-enterprise-server","registry":"https://registry.hub.docker.com","star_count":4},{"description":"The Official LaunchDarkly Relay docker image (alpine based)","downloads":22899582,"is_automated":false,"is_official":false,"name":"launchdarkly/ld-relay","registry":"https://registry.hub.docker.com","star_count":3},{"description":"Official JetBrains Code With Me Relay server image.","downloads":84318,"is_automated":false,"is_official":false,"name":"jetbrains/code-with-me-relay","registry":"https://registry.hub.docker.com","star_count":2},{"description":"Base image for netdata official image","downloads":550834,"is_automated":false,"is_official":false,"name":"netdata/base","registry":"https://registry.hub.docker.com","star_count":0},{"description":"Base images used for creating official static builds of Netdata.","downloads":144472,"is_automated":false,"is_official":false,"name":"netdata/static-builder","registry":"https://registry.hub.docker.com","star_count":0},{"description":"Official Vault Enterprise - FIPS docker images","downloads":48347,"is_automated":false,"is_official":false,"name":"hashicorp/vault-enterprise-fips","registry":"https://registry.hub.docker.com","star_count":0}]
/// limit : 50
/// offset : 0
/// page_size : 50
/// total : 10000

class DockerRegistry {
  DockerRegistry({
    this.data,
    this.limit,
    this.offset,
    this.pageSize,
    this.total,
  });

  static Future<DockerRegistry> search({int page = 1, String keyword = "official"}) async {
    DsmResponse res = await Api.dsm.entry(
      "SYNO.Docker.Registry",
      "search",
      version: 1,
      parser: DockerRegistry.fromJson,
      data: {
        "limit": 50,
        "offset": (page - 1) * 50,
        "page_size": 50,
        "q": keyword,
      },
    );
    return res.data;
  }

  DockerRegistry.fromJson(dynamic json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(DockerRegistryData.fromJson(v));
      });
    }
    limit = json['limit'];
    offset = json['offset'];
    pageSize = json['page_size'];
    total = json['total'];
  }
  List<DockerRegistryData>? data;
  int? limit;
  int? offset;
  int? pageSize;
  int? total;
  DockerRegistry copyWith({
    List<DockerRegistryData>? data,
    int? limit,
    int? offset,
    int? pageSize,
    int? total,
  }) =>
      DockerRegistry(
        data: data ?? this.data,
        limit: limit ?? this.limit,
        offset: offset ?? this.offset,
        pageSize: pageSize ?? this.pageSize,
        total: total ?? this.total,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    map['limit'] = limit;
    map['offset'] = offset;
    map['page_size'] = pageSize;
    map['total'] = total;
    return map;
  }
}

/// description : "Official build of Nginx."
/// downloads : 8514367430
/// is_automated : false
/// is_official : true
/// name : "nginx"
/// registry : "https://registry.hub.docker.com"
/// star_count : 19093

class DockerRegistryData {
  DockerRegistryData({
    this.description,
    this.downloads,
    this.isAutomated,
    this.isOfficial,
    this.name,
    this.registry,
    this.starCount,
  });

  Future<DsmResponse> pullStart(String tag) async {
    DsmResponse res = await Api.dsm.entry(
      "SYNO.Docker.Image",
      "pull_start",
      version: 1,
      data: {
        "tag": '"$tag"',
        "repository": '"$name"',
      },
    );
    return res;
  }

  Future<DsmResponse> pullStatus(String taskId) async {
    DsmResponse res = await Api.dsm.entry(
      "SYNO.Docker.Image",
      "pull_status",
      version: 1,
      data: {
        "taskid": '"$taskId"',
      },
    );
    return res;
  }

  DockerRegistryData.fromJson(dynamic json) {
    description = json['description'];
    downloads = json['downloads'];
    isAutomated = json['is_automated'];
    isOfficial = json['is_official'];
    name = json['name'];
    registry = json['registry'];
    starCount = json['star_count'];
  }
  String? description;
  int? downloads;
  bool? isAutomated;
  bool? isOfficial;
  String? name;
  String? registry;
  int? starCount;
  DockerRegistryData copyWith({
    String? description,
    int? downloads,
    bool? isAutomated,
    bool? isOfficial,
    String? name,
    String? registry,
    int? starCount,
  }) =>
      DockerRegistryData(
        description: description ?? this.description,
        downloads: downloads ?? this.downloads,
        isAutomated: isAutomated ?? this.isAutomated,
        isOfficial: isOfficial ?? this.isOfficial,
        name: name ?? this.name,
        registry: registry ?? this.registry,
        starCount: starCount ?? this.starCount,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['description'] = description;
    map['downloads'] = downloads;
    map['is_automated'] = isAutomated;
    map['is_official'] = isOfficial;
    map['name'] = name;
    map['registry'] = registry;
    map['star_count'] = starCount;
    return map;
  }
}
