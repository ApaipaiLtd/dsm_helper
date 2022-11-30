import 'dart:convert';

import 'package:dsm_helper/models/photos/access_permission_model.dart';
import 'package:dsm_helper/models/photos/thumbnail_model.dart';
import 'package:dsm_helper/util/function.dart';

import 'additional.dart';

/// additional : {"thumbnail":[{"cache_key":"611690_1665630858","m":"ready","preview":"broken","sm":"ready","unit_id":611690,"xl":"ready"},{"cache_key":"611689_1665630860","m":"ready","preview":"broken","sm":"ready","unit_id":611689,"xl":"ready"},{"cache_key":"611688_1665630855","m":"ready","preview":"broken","sm":"ready","unit_id":611688,"xl":"ready"},{"cache_key":"611687_1665630852","m":"ready","preview":"broken","sm":"ready","unit_id":611687,"xl":"ready"}]}
/// id : 14770
/// name : "/飞机航拍"
/// owner_user_id : 1
/// parent : 2
/// passphrase : ""
/// shared : false
/// sort_by : "default"
/// sort_direction : "default"

class FolderModel {
  FolderModel({
    this.additional,
    this.id,
    this.name,
    this.ownerUserId,
    this.parent,
    this.passphrase,
    this.shared,
    this.sortBy,
    this.sortDirection,
  });
  static Future<FolderModel> fetch({List<String> additional = const [], bool isTeam = false}) async {
    var res = await Util.post("entry.cgi", data: {
      "api": 'SYNO.Foto${isTeam ? 'Team' : ''}.Browse.Folder',
      "method": 'get',
      "version": 2,
      "_sid": Util.sid,
      "additional": jsonEncode(additional),
    });
    print(res);
    if (res['success']) {
      return FolderModel.fromJson(res['data']['folder']);
    } else {
      throw Exception();
    }
  }

  Future fetchFolders({List<String> additional = const [], bool isTeam = false}) async {
    var res = await Util.post("entry.cgi", data: {
      "id": id,
      "api": 'SYNO.Foto${isTeam ? 'Team' : ''}.Browse.Folder',
      "method": 'list',
      "version": 2,
      "_sid": Util.sid,
      "additional": jsonEncode(additional),
      "sort_by": "filename",
      "sort_direction": "asc",
      "offset": 0,
      "limit": 5000,
    });
    print(res);
    if (res['success']) {
      List list = res['data']['list'];
      folders = [];
      list.forEach((element) {
        folders.add(FolderModel.fromJson(element));
      });
      return folders;
    } else {
      throw Exception();
    }
  }

  FolderModel.fromJson(dynamic json) {
    additional = json['additional'] != null ? Additional.fromJson(json['additional']) : null;
    id = json['id'];
    name = json['name'];
    ownerUserId = json['owner_user_id'];
    parent = json['parent'];
    passphrase = json['passphrase'];
    shared = json['shared'];
    sortBy = json['sort_by'];
    sortDirection = json['sort_direction'];
  }
  Additional additional;
  num id;
  String name;
  String get lastName => name.split("/").last;
  num ownerUserId;
  num parent;
  String passphrase;
  bool shared;
  String sortBy;
  String sortDirection;
  List<FolderModel> folders;
  FolderModel copyWith({
    Additional additional,
    num id,
    String name,
    num ownerUserId,
    num parent,
    String passphrase,
    bool shared,
    String sortBy,
    String sortDirection,
  }) =>
      FolderModel(
        additional: additional ?? this.additional,
        id: id ?? this.id,
        name: name ?? this.name,
        ownerUserId: ownerUserId ?? this.ownerUserId,
        parent: parent ?? this.parent,
        passphrase: passphrase ?? this.passphrase,
        shared: shared ?? this.shared,
        sortBy: sortBy ?? this.sortBy,
        sortDirection: sortDirection ?? this.sortDirection,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (additional != null) {
      map['additional'] = additional.toJson();
    }
    map['id'] = id;
    map['name'] = name;
    map['owner_user_id'] = ownerUserId;
    map['parent'] = parent;
    map['passphrase'] = passphrase;
    map['shared'] = shared;
    map['sort_by'] = sortBy;
    map['sort_direction'] = sortDirection;
    return map;
  }
}
