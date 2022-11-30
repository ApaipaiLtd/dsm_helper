import 'package:dsm_helper/models/photos/access_permission_model.dart';
import 'package:dsm_helper/models/photos/thumbnail_model.dart';

/// thumbnail : [{"cache_key":"611690_1665630858","m":"ready","preview":"broken","sm":"ready","unit_id":611690,"xl":"ready"},{"cache_key":"611689_1665630860","m":"ready","preview":"broken","sm":"ready","unit_id":611689,"xl":"ready"},{"cache_key":"611688_1665630855","m":"ready","preview":"broken","sm":"ready","unit_id":611688,"xl":"ready"},{"cache_key":"611687_1665630852","m":"ready","preview":"broken","sm":"ready","unit_id":611687,"xl":"ready"}]

class Additional {
  Additional({
    this.sharingInfo,
    this.thumbnail,
    this.accessPermission,
  });

  Additional.fromJson(dynamic json) {
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
  Additional copyWith({
    SharingInfo sharingInfo,
    List<ThumbnailModel> thumbnail,
    AccessPermissionModel accessPermission,
  }) =>
      Additional(
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
