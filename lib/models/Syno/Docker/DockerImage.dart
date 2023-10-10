import 'dart:convert';

import 'package:dsm_helper/apis/api.dart';

/// images : [{"created":1686711900,"description":"","id":"sha256:38eccdbf3ee0a10aec987d993f5776066ea85c481afde4eca13706193172a83d","repository":"allanpk716/chinesesubfinder","size":174037115,"tags":["latest"],"virtual_size":174037115},{"created":1683876141,"description":"","id":"sha256:4678b645b938305955f3f67d484a8b62c4cd63e8cf58b3ea97949169035dce93","repository":"challengerv/nas-tools-unlock","size":1127286214,"tags":["latest"],"virtual_size":1127286214},{"created":1675038033,"description":"","id":"sha256:f847e1adb570c2cc11d1e613cad97baf3cdfe83ddd3c1a29ada848cfbd4f7f3f","repository":"containrrr/watchtower","size":14592906,"tags":["latest"],"virtual_size":14592906},{"created":1692283647,"description":"A rule based proxy in Go.","id":"sha256:09508d094ad5c8eec96b8aeba128d4d86c55c741fbe189e5873befdd665eb159","repository":"dreamacro/clash","size":24584283,"tags":["latest"],"virtual_size":24584283},{"created":1682265424,"description":"","id":"sha256:b27de364af61892a0d4f2d51bd3f84d13a43a640854dc534cb33b14110529c8d","repository":"jellyfin/jellyfin","size":1022954901,"tags":["latest"],"virtual_size":1022954901},{"created":1690848817,"description":"","id":"sha256:f07128c52ada37774f02abdc75b71ce570faadc90159bebf23ad1b88b8563dd7","repository":"jxxghp/moviepilot","size":726524714,"tags":["latest"],"virtual_size":726524714},{"created":1690785483,"description":"","id":"sha256:d459446ff4e274cafa49f3dc2959ed9a3cb52091fae9d089a48975b8ace0e3e2","repository":"linuxserver/jackett","size":170707876,"tags":["latest"],"virtual_size":170707876},{"created":1692514689,"description":"","id":"sha256:3b04dcf0bf3652c1e32cd8b4bcbf9b3e685f26f105681e23132b4d81bf6f0328","repository":"linuxserver/qbittorrent","size":203171552,"tags":["latest"],"virtual_size":203171552},{"created":1690736385,"description":"","id":"sha256:f3ce1a53ea02380123c53e6be23f044db409519e68ad4bac52dac20e7717f432","repository":"linuxserver/radarr","size":195585150,"tags":["latest"],"virtual_size":195585150},{"created":1690756035,"description":"","id":"sha256:71608e1475d517c3ebf32727288997da76ee1a0bf9400702763d1a078fe1957a","repository":"linuxserver/sonarr","size":192687628,"tags":["4.0.0-develop"],"virtual_size":192687628},{"created":1690587218,"description":"","id":"sha256:146be78b446bfa803427c63a5cbbcfc9561bbb3e574cc5b9080af1f11c7acb04","repository":"linuxserver/sonarr","size":295876869,"tags":["latest"],"virtual_size":295876869},{"created":1685570057,"description":"","id":"sha256:54542bbcf0ee38dc59cbcea7ffba3b995d32caf0c182809cf0f115a6d4d11c66","repository":"lovechen/embyserver","size":568160849,"tags":["latest"],"virtual_size":568160849},{"created":1691995999,"description":"","id":"sha256:8dfecbf5131ed4389eaa1dd957afa69699f22a39b935d0e41cf010cbb6830565","repository":"pengzhile/pandora","size":259489640,"tags":["latest"],"virtual_size":259489640},{"created":1502372645,"description":"Web SSH Client using WebSSH2 (ssh2, socket.io, xterm.js) on Alpline.","id":"sha256:050c10ac61b108cf5c0dfd59b46fee7fbafffd8e6605e678bda6cd42b8b4d660","repository":"psharkey/webssh2","size":92563737,"tags":["latest"],"virtual_size":92563737},{"created":1681771863,"description":"Redis is an open source key-value store that functions as a data structure server.","id":"sha256:eca1379fe8b541831fd5ce4a252c263db0cef4efbfd428a94225dc020aaeb1af","repository":"redis","size":117112566,"tags":["latest"],"virtual_size":117112566},{"created":1673556045,"description":"","id":"sha256:a91632e9f0f58f913003bc0dd7915696836b23bb3808e21811aca69e4427794c","repository":"shellngn/pro","size":647250908,"tags":["latest"],"virtual_size":647250908},{"created":1682232647,"description":"原神QQ群机器人的docker部署版本，通过米游社接口，查询原神游戏信息，快速生成图片返回\n项目GitHub地址：https://github.com/Le-niao/Yunzai-Bot","id":"sha256:1e68c95f0aa6252584caac429aed647b889b0740709f30e8e922557f2883cdc6","repository":"sirly/yunzai-bot","size":1761629529,"tags":["latest"],"virtual_size":1761629529},{"created":1692629804,"description":"","id":"sha256:81e9ce5962e659eb490615c29754c7e077eb41556c5f20b30527e2a77e52c388","repository":"whyour/qinglong","size":274998806,"tags":["latest"],"virtual_size":274998806}]
/// limit : 18
/// offset : 0
/// total : 18

class DockerImage {
  DockerImage({
    this.images,
    this.limit,
    this.offset,
    this.total,
  });

  static Future<DockerImage> list() async {
    DsmResponse res = await Api.dsm.entry(
      "SYNO.Docker.Image",
      "list",
      version: 1,
      parser: DockerImage.fromJson,
      data: {
        "limit": -1,
        "offset": 0,
        "show_dsm": false,
      },
    );
    return res.data;
  }

  DockerImage.fromJson(dynamic json) {
    if (json['images'] != null) {
      images = [];
      json['images'].forEach((v) {
        images?.add(Images.fromJson(v));
      });
    }
    limit = json['limit'];
    offset = json['offset'];
    total = json['total'];
  }
  List<Images>? images;
  int? limit;
  int? offset;
  int? total;
  DockerImage copyWith({
    List<Images>? images,
    int? limit,
    int? offset,
    int? total,
  }) =>
      DockerImage(
        images: images ?? this.images,
        limit: limit ?? this.limit,
        offset: offset ?? this.offset,
        total: total ?? this.total,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (images != null) {
      map['images'] = images?.map((v) => v.toJson()).toList();
    }
    map['limit'] = limit;
    map['offset'] = offset;
    map['total'] = total;
    return map;
  }
}

/// created : 1686711900
/// description : ""
/// id : "sha256:38eccdbf3ee0a10aec987d993f5776066ea85c481afde4eca13706193172a83d"
/// repository : "allanpk716/chinesesubfinder"
/// size : 174037115
/// tags : ["latest"]
/// virtual_size : 174037115

class Images {
  Images({
    this.created,
    this.description,
    this.id,
    this.repository,
    this.size,
    this.tags,
    this.virtualSize,
  });

  Future<DsmResponse> delete() async {
    DsmResponse res = await Api.dsm.entry(
      "SYNO.Docker.Image",
      "delete",
      version: 1,
      data: {
        "images": jsonEncode([this]),
      },
    );
    return res;
  }

  Images.fromJson(dynamic json) {
    created = json['created'];
    description = json['description'];
    id = json['id'];
    repository = json['repository'];
    size = json['size'];
    tags = json['tags'] != null ? json['tags'].cast<String>() : [];
    virtualSize = json['virtual_size'];
  }
  int? created;
  String? description;
  String? id;
  String? repository;
  int? size;
  List<String>? tags;
  int? virtualSize;
  Images copyWith({
    int? created,
    String? description,
    String? id,
    String? repository,
    int? size,
    List<String>? tags,
    int? virtualSize,
  }) =>
      Images(
        created: created ?? this.created,
        description: description ?? this.description,
        id: id ?? this.id,
        repository: repository ?? this.repository,
        size: size ?? this.size,
        tags: tags ?? this.tags,
        virtualSize: virtualSize ?? this.virtualSize,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['created'] = created;
    map['description'] = description;
    map['id'] = id;
    map['repository'] = repository;
    map['size'] = size;
    map['tags'] = tags;
    map['virtual_size'] = virtualSize;
    return map;
  }
}
