import 'dart:convert';

import 'package:dsm_helper/models/photos/access_permission_model.dart';
import 'package:dsm_helper/models/photos/photo_model.dart';
import 'package:dsm_helper/models/photos/thumbnail_model.dart';
import 'package:dsm_helper/util/function.dart';

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
    if (res['success']) {
      return FolderModel.fromJson(res['data']['folder']);
    } else {
      throw Exception();
    }
  }

  Future<List<FolderModel>> fetchFolders({List<String> additional = const [], bool isTeam = false}) async {
    Map<String, dynamic> data = {
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
    };
    var res = await Util.post("entry.cgi", data: data);
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

  Future<List<PhotoModel>> fetchPhotos({List<String> additional = const [], bool isTeam = false}) async {
    var res = await Util.post("entry.cgi", data: {
      "folder_id": id,
      "api": 'SYNO.Foto${isTeam ? 'Team' : ''}.Browse.Item',
      "method": 'list',
      "version": 1,
      "_sid": Util.sid,
      "additional": jsonEncode(additional),
      "sort_by": "takentime",
      "sort_direction": "asc",
      "offset": 0,
      "limit": 5000,
    });
    if (res['success']) {
      List list = res['data']['list'];
      photos = [];
      list.forEach((element) {
        photos.add(PhotoModel.fromJson(element));
      });
      return photos;
    } else {
      throw Exception();
    }
  }

  FolderModel.fromJson(dynamic json) {
    additional = json['additional'] != null ? FolderAdditional.fromJson(json['additional']) : null;
    id = json['id'];
    name = json['name'];
    ownerUserId = json['owner_user_id'];
    parent = json['parent'];
    passphrase = json['passphrase'];
    shared = json['shared'];
    sortBy = json['sort_by'];
    sortDirection = json['sort_direction'];
  }
  FolderAdditional additional;
  num id;
  String name;
  String get lastName {
    if (name == "/") {
      return "/";
    } else {
      return name.split("/").last;
    }
  }

  num ownerUserId;
  num parent;
  String passphrase;
  bool shared;
  String sortBy;
  String sortDirection;
  List<FolderModel> folders = [];
  List<PhotoModel> photos = [];
  FolderModel copyWith({
    FolderAdditional additional,
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

/// thumbnail : [{"cache_key":"611690_1665630858","m":"ready","preview":"broken","sm":"ready","unit_id":611690,"xl":"ready"},{"cache_key":"611689_1665630860","m":"ready","preview":"broken","sm":"ready","unit_id":611689,"xl":"ready"},{"cache_key":"611688_1665630855","m":"ready","preview":"broken","sm":"ready","unit_id":611688,"xl":"ready"},{"cache_key":"611687_1665630852","m":"ready","preview":"broken","sm":"ready","unit_id":611687,"xl":"ready"}]

class FolderAdditional {
  FolderAdditional({
    this.sharingInfo,
    this.thumbnail,
    this.accessPermission,
  });

  FolderAdditional.fromJson(dynamic json) {
    if (json['thumbnail'] != null) {
      thumbnail = [];
      json['thumbnail'].forEach((v) {
        thumbnail.add(ThumbnailModel.fromJson(v));
      });
    }
    if (json['access_permission'] != null) {
      accessPermission = AccessPermissionModel.fromJson(json['access_permission']);
    }
  }
  SharingInfo sharingInfo;
  List<ThumbnailModel> thumbnail;
  AccessPermissionModel accessPermission;
  FolderAdditional copyWith({
    SharingInfo sharingInfo,
    List<ThumbnailModel> thumbnail,
    AccessPermissionModel accessPermission,
  }) =>
      FolderAdditional(
        sharingInfo: sharingInfo ?? this.sharingInfo,
        thumbnail: thumbnail ?? this.thumbnail,
        accessPermission: thumbnail ?? this.accessPermission,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (sharingInfo != null) {
      map['sharing_info'] = sharingInfo.toJson();
    }
    if (thumbnail != null) {
      map['thumbnail'] = thumbnail.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// enable_password : false
/// expiration : 0
/// is_expired : false
/// mtime : 1666874109
/// owner : {"id":1,"name":"yaoshuwei"}
/// passphrase : "5kpICmfPs"
/// permission : []
/// privacy_type : "public-view"
/// sharing_link : "http://pan.apaipai.top:5000/mo/sharing/5kpICmfPs"
/// type : "album"

class SharingInfo {
  SharingInfo({
    this.enablePassword,
    this.expiration,
    this.isExpired,
    this.mtime,
    this.owner,
    this.passphrase,
    this.permission,
    this.privacyType,
    this.sharingLink,
    this.type,
  });

  SharingInfo.fromJson(dynamic json) {
    enablePassword = json['enable_password'];
    expiration = json['expiration'];
    isExpired = json['is_expired'];
    mtime = json['mtime'];
    owner = json['owner'] != null ? Owner.fromJson(json['owner']) : null;
    passphrase = json['passphrase'];
    if (json['permission'] != null) {
      permission = json['permission'];
      // json['permission'].forEach((v) {
      //   permission.add(Dynamic.fromJson(v));
      // });
    }
    privacyType = json['privacy_type'];
    sharingLink = json['sharing_link'];
    type = json['type'];
  }
  bool enablePassword;
  num expiration;
  bool isExpired;
  num mtime;
  Owner owner;
  String passphrase;
  List permission;
  String privacyType;
  String sharingLink;
  String type;
  SharingInfo copyWith({
    bool enablePassword,
    num expiration,
    bool isExpired,
    num mtime,
    Owner owner,
    String passphrase,
    List permission,
    String privacyType,
    String sharingLink,
    String type,
  }) =>
      SharingInfo(
        enablePassword: enablePassword ?? this.enablePassword,
        expiration: expiration ?? this.expiration,
        isExpired: isExpired ?? this.isExpired,
        mtime: mtime ?? this.mtime,
        owner: owner ?? this.owner,
        passphrase: passphrase ?? this.passphrase,
        permission: permission ?? this.permission,
        privacyType: privacyType ?? this.privacyType,
        sharingLink: sharingLink ?? this.sharingLink,
        type: type ?? this.type,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['enable_password'] = enablePassword;
    map['expiration'] = expiration;
    map['is_expired'] = isExpired;
    map['mtime'] = mtime;
    if (owner != null) {
      map['owner'] = owner.toJson();
    }
    map['passphrase'] = passphrase;
    if (permission != null) {
      map['permission'] = permission.map((v) => v.toJson()).toList();
    }
    map['privacy_type'] = privacyType;
    map['sharing_link'] = sharingLink;
    map['type'] = type;
    return map;
  }
}

/// id : 1
/// name : "yaoshuwei"

class Owner {
  Owner({
    this.id,
    this.name,
  });

  Owner.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
  }
  num id;
  String name;
  Owner copyWith({
    num id,
    String name,
  }) =>
      Owner(
        id: id ?? this.id,
        name: name ?? this.name,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    return map;
  }
}
