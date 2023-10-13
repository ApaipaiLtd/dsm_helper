import 'dart:convert';

import 'package:dsm_helper/apis/api.dart';
import 'package:dsm_helper/utils/utils.dart' hide Api;

/// files : [{"additional":{"description":{},"indexed":false,"mount_point_type":"","owner":{"gid":100,"group":"users","uid":1026,"user":"yaoshuwei"},"perm":{"acl":{"append":true,"del":true,"exec":true,"read":true,"write":true},"is_acl_mode":true,"posix":755},"real_path":"/volume3/docker/ChatGPT","size":8,"time":{"atime":1695479838,"crtime":1686887290,"ctime":1686887297,"mtime":1686887297},"type":""},"isdir":true,"name":"ChatGPT","path":"/docker/ChatGPT"},{"additional":{"description":{},"indexed":false,"mount_point_type":"","owner":{"gid":100,"group":"users","uid":1026,"user":"yaoshuwei"},"perm":{"acl":{"append":true,"del":true,"exec":true,"read":true,"write":true},"is_acl_mode":true,"posix":755},"real_path":"/volume3/docker/chinesesubfinder","size":12,"time":{"atime":1694428621,"crtime":1690942024,"ctime":1690942026,"mtime":1690942026},"type":""},"isdir":true,"name":"chinesesubfinder","path":"/docker/chinesesubfinder"},{"additional":{"description":{},"indexed":false,"mount_point_type":"","owner":{"gid":100,"group":"users","uid":1026,"user":"yaoshuwei"},"perm":{"acl":{"append":true,"del":true,"exec":true,"read":true,"write":true},"is_acl_mode":true,"posix":755},"real_path":"/volume3/docker/clash","size":12,"time":{"atime":1686540953,"crtime":1684305275,"ctime":1684305280,"mtime":1684305280},"type":""},"isdir":true,"name":"clash","path":"/docker/clash"},{"additional":{"description":{},"indexed":false,"mount_point_type":"","owner":{"gid":100,"group":"users","uid":1026,"user":"yaoshuwei"},"perm":{"acl":{"append":true,"del":true,"exec":true,"read":true,"write":true},"is_acl_mode":true,"posix":777},"real_path":"/volume3/docker/emby","size":12,"time":{"atime":1682760387,"crtime":1682759699,"ctime":1682760387,"mtime":1682759842},"type":""},"isdir":true,"name":"emby","path":"/docker/emby"},{"additional":{"description":{},"indexed":false,"mount_point_type":"","owner":{"gid":100,"group":"users","uid":1026,"user":"yaoshuwei"},"perm":{"acl":{"append":true,"del":true,"exec":true,"read":true,"write":true},"is_acl_mode":true,"posix":755},"real_path":"/volume3/docker/jackett","size":12,"time":{"atime":1690850798,"crtime":1690850795,"ctime":1690850798,"mtime":1690850798},"type":""},"isdir":true,"name":"jackett","path":"/docker/jackett"},{"additional":{"description":{},"indexed":false,"mount_point_type":"","owner":{"gid":100,"group":"users","uid":1026,"user":"yaoshuwei"},"perm":{"acl":{"append":true,"del":true,"exec":true,"read":true,"write":true},"is_acl_mode":true,"posix":755},"real_path":"/volume3/docker/jellyfin","size":12,"time":{"atime":1687160866,"crtime":1668168948,"ctime":1668168953,"mtime":1668168953},"type":""},"isdir":true,"name":"jellyfin","path":"/docker/jellyfin"},{"additional":{"description":{},"indexed":false,"mount_point_type":"","owner":{"gid":100,"group":"users","uid":1026,"user":"yaoshuwei"},"perm":{"acl":{"append":true,"del":true,"exec":true,"read":true,"write":true},"is_acl_mode":true,"posix":755},"real_path":"/volume3/docker/Joplin","size":23496,"time":{"atime":1694525423,"crtime":1694090506,"ctime":1694090671,"mtime":1694090671},"type":""},"isdir":true,"name":"Joplin","path":"/docker/Joplin"},{"additional":{"description":{},"indexed":false,"mount_point_type":"","owner":{"gid":100,"group":"users","uid":1026,"user":"yaoshuwei"},"perm":{"acl":{"append":true,"del":true,"exec":true,"read":true,"write":true},"is_acl_mode":true,"posix":755},"real_path":"/volume3/docker/login_translucent","size":116,"time":{"atime":1682751571,"crtime":1664547396,"ctime":1664547508,"mtime":1664547508},"type":""},"isdir":true,"name":"login_translucent","path":"/docker/login_translucent"},{"additional":{"description":{},"indexed":false,"mount_point_type":"","owner":{"gid":100,"group":"users","uid":1026,"user":"yaoshuwei"},"perm":{"acl":{"append":true,"del":true,"exec":true,"read":true,"write":true},"is_acl_mode":true,"posix":755},"real_path":"/volume3/docker/moviepilot","size":12,"time":{"atime":1690879299,"crtime":1690879295,"ctime":1690879299,"mtime":1690879299},"type":""},"isdir":true,"name":"moviepilot","path":"/docker/moviepilot"},{"additional":{"description":{},"indexed":false,"mount_point_type":"","owner":{"gid":100,"group":"users","uid":1026,"user":"yaoshuwei"},"perm":{"acl":{"append":true,"del":true,"exec":true,"read":true,"write":true},"is_acl_mode":true,"posix":755},"real_path":"/volume3/docker/nas-tools","size":12,"time":{"atime":1690853646,"crtime":1683530363,"ctime":1683530367,"mtime":1683530367},"type":""},"isdir":true,"name":"nas-tools","path":"/docker/nas-tools"},{"additional":{"description":{},"indexed":false,"mount_point_type":"","owner":{"gid":100,"group":"users","uid":1026,"user":"yaoshuwei"},"perm":{"acl":{"append":true,"del":true,"exec":true,"read":true,"write":true},"is_acl_mode":true,"posix":755},"real_path":"/volume3/docker/qbittorrent","size":30,"time":{"atime":1689218732,"crtime":1656305575,"ctime":1656305637,"mtime":1656305637},"type":""},"isdir":true,"name":"qbittorrent","path":"/docker/qbittorrent"},{"additional":{"description":{},"indexed":false,"mount_point_type":"","owner":{"gid":100,"group":"users","uid":1026,"user":"yaoshuwei"},"perm":{"acl":{"append":true,"del":true,"exec":true,"read":true,"write":true},"is_acl_mode":true,"posix":755},"real_path":"/volume3/docker/qinglong","size":8,"time":{"atime":1690266377,"crtime":1684158779,"ctime":1690266377,"mtime":1690266377},"type":""},"isdir":true,"name":"qinglong","path":"/docker/qinglong"},{"additional":{"description":{},"indexed":false,"mount_point_type":"","owner":{"gid":100,"group":"users","uid":1026,"user":"yaoshuwei"},"perm":{"acl":{"append":true,"del":true,"exec":true,"read":true,"write":true},"is_acl_mode":true,"posix":755},"real_path":"/volume3/docker/radarr","size":12,"time":{"atime":1690794613,"crtime":1690794608,"ctime":1690794613,"mtime":1690794613},"type":""},"isdir":true,"name":"radarr","path":"/docker/radarr"},{"additional":{"description":{},"indexed":false,"mount_point_type":"","owner":{"gid":100,"group":"users","uid":1026,"user":"yaoshuwei"},"perm":{"acl":{"append":true,"del":true,"exec":true,"read":true,"write":true},"is_acl_mode":true,"posix":755},"real_path":"/volume3/docker/redis","size":16,"time":{"atime":1682754581,"crtime":1678281856,"ctime":1678281979,"mtime":1678281979},"type":""},"isdir":true,"name":"redis","path":"/docker/redis"},{"additional":{"description":{},"indexed":false,"mount_point_type":"","owner":{"gid":100,"group":"users","uid":1026,"user":"yaoshuwei"},"perm":{"acl":{"append":true,"del":true,"exec":true,"read":true,"write":true},"is_acl_mode":true,"posix":755},"real_path":"/volume3/docker/shellngn","size":8,"time":{"atime":1687662489,"crtime":1687662484,"ctime":1687662489,"mtime":1687662489},"type":""},"isdir":true,"name":"shellngn","path":"/docker/shellngn"},{"additional":{"description":{},"indexed":false,"mount_point_type":"","owner":{"gid":100,"group":"users","uid":1026,"user":"yaoshuwei"},"perm":{"acl":{"append":true,"del":true,"exec":true,"read":true,"write":true},"is_acl_mode":true,"posix":755},"real_path":"/volume3/docker/sonarr","size":12,"time":{"atime":1690873312,"crtime":1690873307,"ctime":1690873312,"mtime":1690873312},"type":""},"isdir":true,"name":"sonarr","path":"/docker/sonarr"},{"additional":{"description":{},"indexed":false,"mount_point_type":"","owner":{"gid":100,"group":"users","uid":1026,"user":"yaoshuwei"},"perm":{"acl":{"append":true,"del":true,"exec":true,"read":true,"write":true},"is_acl_mode":true,"posix":755},"real_path":"/volume3/docker/yunzai-bot","size":60,"time":{"atime":1688454280,"crtime":1682752636,"ctime":1682753492,"mtime":1682753492},"type":""},"isdir":true,"name":"yunzai-bot","path":"/docker/yunzai-bot"}]
/// offset : 0
/// total : 17

class FileStationList {
  FileStationList({
    this.files,
    this.offset,
    this.total,
  });

  static Future<FileStationList> shareList({List<String> additional = const ["perm", "time", "size"], String sortBy = "name", String sortDirection = "asc"}) async {
    DsmResponse res = await Api.dsm.entry(
      "SYNO.FileStation.List",
      '"list_share"',
      version: 2,
      data: {
        "offset": 0,
        "limit": 100,
        "sort_by": '"$sortBy"',
        "sort_direction": '"$sortDirection"',
        "additional": jsonEncode(additional),
      },
      parser: FileStationList.fromJson,
    );
    return res.data;
  }

  static Future<FileStationList> fileList({required String path, List<String> additional = const ["real_path", "size", "owner", "time", "perm", "type", "mount_point_type", "description", "indexed"], String sortBy = "name", String sortDirection = "asc"}) async {
    DsmResponse res = await Api.dsm.entry(
      "SYNO.FileStation.List",
      '"list"',
      version: 2,
      data: {
        "offset": 0,
        "limit": 100,
        "sort_by": '"$sortBy"',
        "sort_direction": '"$sortDirection"',
        "folder_path": path,
        "filetype": '"all"',
        "additional": jsonEncode(additional),
      },
      parser: FileStationList.fromJson,
    );
    return res.data;
  }

  static Future<FileStationList> favoriteList({List<String> additional = const ["perm", "time", "size", "real_path"]}) async {
    DsmResponse res = await Api.dsm.entry(
      "SYNO.FileStation.Favorite",
      '"list"',
      version: 2,
      data: {
        "offset": 0,
        "limit": 1000,
        "additional": jsonEncode(additional),
      },
      parser: FileStationList.fromJson,
    );
    return res.data;
  }

  static Future<FileStationList> virtualFolder({required String type, required String node, List<String> additional = const ["real_path", "owner", "time", "perm", "mount_point_type"]}) async {
    DsmResponse res = await Api.dsm.entry(
      "SYNO.FileStation.VirtualFolder",
      '"list"',
      version: 2,
      data: {
        "sort_by": "name",
        "type": type,
        "node": node,
        "additional": jsonEncode(additional),
      },
      parser: FileStationList.fromJson,
    );
    return res.data;
  }

  FileStationList.fromJson(dynamic json) {
    if (json['files'] != null) {
      files = [];
      json['files'].forEach((v) {
        files?.add(FileItem.fromJson(v));
      });
    }
    if (json['shares'] != null) {
      files = [];
      json['shares'].forEach((v) {
        files?.add(FileItem.fromJson(v));
      });
    }

    if (json['favorites'] != null) {
      files = [];
      json['favorites'].forEach((v) {
        files?.add(FileItem.fromJson(v));
      });
    }
    if (json['folders'] != null) {
      files = [];
      json['folders'].forEach((v) {
        files?.add(FileItem.fromJson(v));
      });
    }
    offset = json['offset'];
    total = json['total'];
  }
  List<FileItem>? files;
  num? offset;
  num? total;
  FileStationList copyWith({
    List<FileItem>? files,
    num? offset,
    num? total,
  }) =>
      FileStationList(
        files: files ?? this.files,
        offset: offset ?? this.offset,
        total: total ?? this.total,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (files != null) {
      map['files'] = files?.map((v) => v.toJson()).toList();
    }
    map['offset'] = offset;
    map['total'] = total;
    return map;
  }
}

/// additional : {"description":{},"indexed":false,"mount_point_type":"","owner":{"gid":100,"group":"users","uid":1026,"user":"yaoshuwei"},"perm":{"acl":{"append":true,"del":true,"exec":true,"read":true,"write":true},"is_acl_mode":true,"posix":755},"real_path":"/volume3/docker/ChatGPT","size":8,"time":{"atime":1695479838,"crtime":1686887290,"ctime":1686887297,"mtime":1686887297},"type":""}
/// isdir : true
/// name : "ChatGPT"
/// path : "/docker/ChatGPT"

class FileItem {
  FileItem({
    this.additional,
    this.isdir,
    this.name,
    this.path,
  });

  // 添加收藏
  Future<DsmResponse> addFavorite() async {
    DsmResponse res = await Api.dsm.entry("SYNO.FileStation.Favorite", "add", version: 2, data: {
      "name": "${name!} - ${path!.split("/")[1]}",
      "path": path!,
    });
    return res;
  }

  Future<DsmResponse> renameFavorite(String name) async {
    DsmResponse res = await Api.dsm.entry(
      "SYNO.FileStation.Favorite",
      '"edit"',
      version: 2,
      data: {
        "name": name,
        "path": path!,
      },
    );
    return res;
  }

  Future<bool?> deleteFavorite() async {
    DsmResponse res = await Api.dsm.entry(
      "SYNO.FileStation.Favorite",
      'delete',
      version: 2,
      data: {
        "path": path!,
      },
    );
    return res.success;
  }

  // 删除文件
  static Future<String> deleteFiles(List<FileItem> files) async {
    DsmResponse res = await Api.dsm.entry(
      "SYNO.FileStation.Delete",
      "start",
      version: 2,
      data: {
        "path": json.encode(files.map((e) => e.path!).toList()),
        "accurate_progress": "true",
      },
    );
    if (res.success!) {
      return res.data['taskid'];
    } else {
      return "";
    }
  }

  // 压缩文件

  static Future<String> compress(List<FileItem> files, {required String destFolderPath, String level = "normal", String mode = "replace", String format = "zip", String codepage = "chs", String? password}) async {
    DsmResponse res = await Api.dsm.entry(
      "SYNO.FileStation.Compress",
      "start",
      version: 2,
      data: {
        "path": json.encode(files.map((e) => e.path!).toList()),
        "dest_file_path": "$destFolderPath",
        "level": "$level",
        "mode": "$mode",
        "format": "$format",
        "password": password,
        "codepage": codepage,
      },
    );
    if (res.success!) {
      return res.data['taskid'];
    } else {
      return "";
    }
  }

  // 解压文件
  Future<String> extract({required String destFolderPath, bool createSubfolder = false}) async {
    DsmResponse res = await Api.dsm.entry(
      "SYNO.FileStation.Extract",
      "start",
      version: 2,
      data: {
        "overwrite": "false",
        "file_path": path,
        "dest_folder_path": destFolderPath,
        "keep_dir": "true",
        "create_subfolder": createSubfolder,
        "codepage": "chs",
      },
    );
    if (res.success!) {
      return res.data['taskid'];
    } else {
      return "";
    }
  }

  // 新建文件夹
  static Future<bool> createFolder(String path, String name) async {
    DsmResponse res = await Api.dsm.entry(
      "SYNO.FileStation.CreateFolder",
      "create",
      version: 2,
      data: {
        "force_parent": "false",
        "folder_path": '"$path"',
        "name": '"$name"',
        "_sid": Utils.sid,
      },
    );
    if (res.success == true) {
      return true;
    } else if (res.error != null) {
      if (res.error!['errors'] != null && res.error!['errors'].length > 0 && res.error!['errors'][0]['code'] == 414) {
        throw FormatException("新建文件夹失败：“${res.error!['errors'][0]['path']}”已存在");
      }
      throw FormatException("新建文件夹失败");
    } else {
      throw FormatException("新建文件夹失败");
    }
  }

  // 重命名
  Future<bool> rename(String path, String name) async {
    DsmResponse res = await Api.dsm.entry(
      "SYNO.FileStation.Rename",
      "rename",
      version: 2,
      data: {
        "path": '"$path"',
        "name": '"$name"',
        "_sid": Utils.sid,
      },
    );
    if (res.success == true) {
      return true;
    } else if (res.error != null) {
      if (res.error!['errors'] != null && res.error!['errors'].length > 0 && res.error!['errors'][0]['code'] == 414) {
        throw FormatException("重命名文件夹失败：“${res.error!['errors'][0]['path']}”已存在");
      }
      throw FormatException("重命名文件夹失败");
    } else {
      throw FormatException("重命名文件夹失败");
    }
  }

  // 获取文件夹大小
  Future<String> dirSize() async {
    DsmResponse res = await Api.dsm.entry(
      "SYNO.FileStation.DirSize",
      "start",
      version: 2,
      data: {
        "path": path!,
      },
    );
    if (res.success!) {
      return res.data['taskid'];
    } else {
      return "";
    }
  }

  // 获取文件MD5
  Future<String> md5() async {
    DsmResponse res = await Api.dsm.entry(
      "SYNO.FileStation.MD5",
      "start",
      version: 2,
      data: {
        "file_path": path!,
      },
    );
    if (res.success!) {
      return res.data['taskid'];
    } else {
      return "";
    }
  }

  // 获取文件磁盘大小
  Future<int?> diskSize() async {
    DsmResponse res = await Api.dsm.entry(
      "SYNO.FileStation.Property.CompressSize",
      "get",
      version: 1,
      data: {
        "file": additional?.realPath,
      },
    );
    if (res.success!) {
      return int.parse(res.data['diskSize']);
    } else {
      return null;
    }
  }

  FileItem.fromJson(dynamic json) {
    additional = json['additional'] != null ? FileAdditional.fromJson(json['additional']) : null;
    isdir = json['isdir'];
    name = json['name'];
    path = json['path'];
  }
  FileAdditional? additional;
  bool? isdir;
  String? name;
  String? path;
  String get ext {
    if (isdir == true) {
      return "";
    } else {
      List<String> names = name!.split(".");
      if (names.length > 1) {
        return names.last;
      } else {
        return "";
      }
    }
  }

  FileTypeEnum get fileType => isdir == true ? FileTypeEnum.folder : Utils.fileType(name!);
  String? get ownerPath {
    if (path == null) {
      return null;
    } else {
      List<String> paths = path!.split("/");
      return paths.sublist(0, paths.length - 1).join("/");
    }
  }

  String? get lastPath {
    if (path == null) {
      return null;
    } else {
      List<String> paths = path!.split("/");
      return paths.last;
    }
  }

  String? get fileName {
    if (name == null) {
      return null;
    } else if (isdir == true) {
      return name;
    } else {
      List<String> names = name!.split(".");
      return names.sublist(0, names.length - 1).join(".");
    }
  }

  FileItem copyWith({
    FileAdditional? additional,
    bool? isdir,
    String? name,
    String? path,
  }) =>
      FileItem(
        additional: additional ?? this.additional,
        isdir: isdir ?? this.isdir,
        name: name ?? this.name,
        path: path ?? this.path,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (additional != null) {
      map['additional'] = additional?.toJson();
    }
    map['isdir'] = isdir;
    map['name'] = name;
    map['path'] = path;
    return map;
  }
}

/// description : {}
/// indexed : false
/// mount_point_type : ""
/// owner : {"gid":100,"group":"users","uid":1026,"user":"yaoshuwei"}
/// perm : {"acl":{"append":true,"del":true,"exec":true,"read":true,"write":true},"is_acl_mode":true,"posix":755}
/// real_path : "/volume3/docker/ChatGPT"
/// size : 8
/// time : {"atime":1695479838,"crtime":1686887290,"ctime":1686887297,"mtime":1686887297}
/// type : ""

class FileAdditional {
  FileAdditional({
    this.description,
    this.indexed,
    this.mountPointType,
    this.owner,
    this.perm,
    this.realPath,
    this.size,
    this.time,
    this.type,
  });

  FileAdditional.fromJson(dynamic json) {
    description = json['description'];
    indexed = json['indexed'];
    mountPointType = json['mount_point_type'];
    owner = json['owner'] != null ? Owner.fromJson(json['owner']) : null;
    perm = json['perm'] != null ? Perm.fromJson(json['perm']) : null;
    realPath = json['real_path'];
    size = json['size'];
    time = json['time'] != null ? Time.fromJson(json['time']) : null;
    type = json['type'];
  }
  dynamic description;
  bool? indexed;
  String? mountPointType;
  Owner? owner;
  Perm? perm;
  String? realPath;
  num? size;
  Time? time;
  String? type;
  FileAdditional copyWith({
    dynamic description,
    bool? indexed,
    String? mountPointType,
    Owner? owner,
    Perm? perm,
    String? realPath,
    num? size,
    Time? time,
    String? type,
  }) =>
      FileAdditional(
        description: description ?? this.description,
        indexed: indexed ?? this.indexed,
        mountPointType: mountPointType ?? this.mountPointType,
        owner: owner ?? this.owner,
        perm: perm ?? this.perm,
        realPath: realPath ?? this.realPath,
        size: size ?? this.size,
        time: time ?? this.time,
        type: type ?? this.type,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['description'] = description;
    map['indexed'] = indexed;
    map['mount_point_type'] = mountPointType;
    if (owner != null) {
      map['owner'] = owner?.toJson();
    }
    if (perm != null) {
      map['perm'] = perm?.toJson();
    }
    map['real_path'] = realPath;
    map['size'] = size;
    if (time != null) {
      map['time'] = time?.toJson();
    }
    map['type'] = type;
    return map;
  }
}

/// atime : 1695479838
/// crtime : 1686887290
/// ctime : 1686887297
/// mtime : 1686887297

class Time {
  Time({
    this.atime,
    this.crtime,
    this.ctime,
    this.mtime,
  });

  Time.fromJson(dynamic json) {
    atime = json['atime'];
    crtime = json['crtime'];
    ctime = json['ctime'];
    mtime = json['mtime'];
  }
  int? atime;
  int? crtime;
  int? ctime;
  int? mtime;
  Time copyWith({
    int? atime,
    int? crtime,
    int? ctime,
    int? mtime,
  }) =>
      Time(
        atime: atime ?? this.atime,
        crtime: crtime ?? this.crtime,
        ctime: ctime ?? this.ctime,
        mtime: mtime ?? this.mtime,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['atime'] = atime;
    map['crtime'] = crtime;
    map['ctime'] = ctime;
    map['mtime'] = mtime;
    return map;
  }
}

/// acl : {"append":true,"del":true,"exec":true,"read":true,"write":true}
/// is_acl_mode : true
/// posix : 755

class Perm {
  Perm({
    this.acl,
    this.isAclMode,
    this.posix,
  });

  Perm.fromJson(dynamic json) {
    acl = json['acl'] != null ? Acl.fromJson(json['acl']) : null;
    isAclMode = json['is_acl_mode'];
    posix = json['posix'];
  }
  Acl? acl;
  bool? isAclMode;
  num? posix;
  Perm copyWith({
    Acl? acl,
    bool? isAclMode,
    num? posix,
  }) =>
      Perm(
        acl: acl ?? this.acl,
        isAclMode: isAclMode ?? this.isAclMode,
        posix: posix ?? this.posix,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (acl != null) {
      map['acl'] = acl?.toJson();
    }
    map['is_acl_mode'] = isAclMode;
    map['posix'] = posix;
    return map;
  }
}

/// append : true
/// del : true
/// exec : true
/// read : true
/// write : true

class Acl {
  Acl({
    this.append,
    this.del,
    this.exec,
    this.read,
    this.write,
  });

  Acl.fromJson(dynamic json) {
    append = json['append'];
    del = json['del'];
    exec = json['exec'];
    read = json['read'];
    write = json['write'];
  }
  bool? append;
  bool? del;
  bool? exec;
  bool? read;
  bool? write;
  Acl copyWith({
    bool? append,
    bool? del,
    bool? exec,
    bool? read,
    bool? write,
  }) =>
      Acl(
        append: append ?? this.append,
        del: del ?? this.del,
        exec: exec ?? this.exec,
        read: read ?? this.read,
        write: write ?? this.write,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['append'] = append;
    map['del'] = del;
    map['exec'] = exec;
    map['read'] = read;
    map['write'] = write;
    return map;
  }
}

/// gid : 100
/// group : "users"
/// uid : 1026
/// user : "yaoshuwei"

class Owner {
  Owner({
    this.gid,
    this.group,
    this.uid,
    this.user,
  });

  Owner.fromJson(dynamic json) {
    gid = json['gid'];
    group = json['group'];
    uid = json['uid'];
    user = json['user'];
  }
  num? gid;
  String? group;
  num? uid;
  String? user;
  Owner copyWith({
    num? gid,
    String? group,
    num? uid,
    String? user,
  }) =>
      Owner(
        gid: gid ?? this.gid,
        group: group ?? this.group,
        uid: uid ?? this.uid,
        user: user ?? this.user,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['gid'] = gid;
    map['group'] = group;
    map['uid'] = uid;
    map['user'] = user;
    return map;
  }
}
