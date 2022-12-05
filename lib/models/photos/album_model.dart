import 'dart:convert';

import 'package:dsm_helper/models/photos/photo_model.dart';
import 'package:dsm_helper/util/function.dart';

/// additional : {"sharing_info":{"enable_password":false,"expiration":0,"is_expired":false,"mtime":1666874109,"owner":{"id":1,"name":"yaoshuwei"},"passphrase":"5kpICmfPs","permission":[],"privacy_type":"public-view","sharing_link":"http://pan.apaipai.top:5000/mo/sharing/5kpICmfPs","type":"album"},"thumbnail":{"cache_key":"684382_1666619064","m":"ready","preview":"broken","sm":"ready","unit_id":684382,"xl":"ready"}}
/// cant_migrate_condition : {}
/// condition : {}
/// create_time : 1666873946
/// end_time : 1666427282
/// freeze_album : false
/// id : 1
/// item_count : 33
/// name : "姚瑾汐"
/// owner_user_id : 1
/// passphrase : "5kpICmfPs"
/// shared : true
/// sort_by : "default"
/// sort_direction : "default"
/// start_time : 1659888505
/// temporary_shared : false
/// type : "normal"
/// version : 2802700

class AlbumModel {
  AlbumModel({
    this.additional,
    this.cantMigrateCondition,
    this.condition,
    this.createTime,
    this.endTime,
    this.freezeAlbum,
    this.id,
    this.itemCount,
    this.name,
    this.ownerUserId,
    this.passphrase,
    this.shared,
    this.sortBy,
    this.sortDirection,
    this.startTime,
    this.temporaryShared,
    this.type,
    this.version,
  });

  static Future<List<AlbumModel>> fetch({
    bool isTeam: false,
    int offset: 0,
    int limit: 5000,
    String sortBy: "create_time",
    String sortDirection: "desc",
    bool shared: false,
    List<String> additional = const [],
  }) async {
    Map<String, dynamic> data = {
      "additional": jsonEncode(additional),
      "offset": offset,
      "limit": limit,
      // "shared": shared,
      "sort_by": '"$sortBy"',
      "sort_direction": '"$sortDirection"',
      "api": "SYNO.Foto${isTeam ? 'Team' : ''}.Browse.Album",
      "method": "list",
      "version": shared ? 2 : 1,
      "_sid": Util.sid,
    };
    if (shared) {
      data['category'] = '"shared"';
    }
    print(data);
    var res = await Util.post("entry.cgi", data: data);
    print(res);
    if (res['success']) {
      List<AlbumModel> albums = [];
      res['data']['list'].forEach((e) {
        albums.add(AlbumModel.fromJson(e));
      });
      return albums;
    } else {
      throw Exception();
    }
  }

  AlbumModel.fromJson(dynamic json) {
    additional = json['additional'] != null ? PhotoAdditional.fromJson(json['additional']) : null;
    cantMigrateCondition = json['cant_migrate_condition'];
    condition = json['condition'];
    createTime = json['create_time'];
    endTime = json['end_time'];
    freezeAlbum = json['freeze_album'];
    id = json['id'];
    itemCount = json['item_count'];
    name = json['name'];
    ownerUserId = json['owner_user_id'];
    passphrase = json['passphrase'];
    shared = json['shared'];
    sortBy = json['sort_by'];
    sortDirection = json['sort_direction'];
    startTime = json['start_time'];
    temporaryShared = json['temporary_shared'];
    type = json['type'];
    version = json['version'];
  }
  PhotoAdditional additional;
  dynamic cantMigrateCondition;
  dynamic condition;
  num createTime;
  num endTime;
  bool freezeAlbum;
  num id;
  num itemCount;
  String name;
  num ownerUserId;
  String passphrase;
  bool shared;
  String sortBy;
  String sortDirection;
  num startTime;
  bool temporaryShared;
  String type;
  num version;
  String get shareText {
    if (additional.sharingInfo.privacyType == 'public-view') {
      return '公开共享';
    } else {
      return '私人共享';
    }
  }

  AlbumModel copyWith({
    PhotoAdditional additional,
    dynamic cantMigrateCondition,
    dynamic condition,
    num createTime,
    num endTime,
    bool freezeAlbum,
    num id,
    num itemCount,
    String name,
    num ownerUserId,
    String passphrase,
    bool shared,
    String sortBy,
    String sortDirection,
    num startTime,
    bool temporaryShared,
    String type,
    num version,
  }) =>
      AlbumModel(
        additional: additional ?? this.additional,
        cantMigrateCondition: cantMigrateCondition ?? this.cantMigrateCondition,
        condition: condition ?? this.condition,
        createTime: createTime ?? this.createTime,
        endTime: endTime ?? this.endTime,
        freezeAlbum: freezeAlbum ?? this.freezeAlbum,
        id: id ?? this.id,
        itemCount: itemCount ?? this.itemCount,
        name: name ?? this.name,
        ownerUserId: ownerUserId ?? this.ownerUserId,
        passphrase: passphrase ?? this.passphrase,
        shared: shared ?? this.shared,
        sortBy: sortBy ?? this.sortBy,
        sortDirection: sortDirection ?? this.sortDirection,
        startTime: startTime ?? this.startTime,
        temporaryShared: temporaryShared ?? this.temporaryShared,
        type: type ?? this.type,
        version: version ?? this.version,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (additional != null) {
      map['additional'] = additional.toJson();
    }
    map['cant_migrate_condition'] = cantMigrateCondition;
    map['condition'] = condition;
    map['create_time'] = createTime;
    map['end_time'] = endTime;
    map['freeze_album'] = freezeAlbum;
    map['id'] = id;
    map['item_count'] = itemCount;
    map['name'] = name;
    map['owner_user_id'] = ownerUserId;
    map['passphrase'] = passphrase;
    map['shared'] = shared;
    map['sort_by'] = sortBy;
    map['sort_direction'] = sortDirection;
    map['start_time'] = startTime;
    map['temporary_shared'] = temporaryShared;
    map['type'] = type;
    map['version'] = version;
    return map;
  }
}
