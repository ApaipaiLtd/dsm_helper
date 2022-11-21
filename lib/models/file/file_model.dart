/// additional : {"mount_point_type":"","perm":{"acl":{"append":true,"del":true,"exec":true,"read":true,"write":true},"is_acl_mode":true,"posix":0},"real_path":"/volume3/Downloads/#recycle","size":22,"time":{"atime":1665630332,"crtime":1608624866,"ctime":1608626351,"mtime":1608624866}}
/// isdir : true
/// name : "#recycle"
/// path : "/Downloads/#recycle"

class FileModel {
  FileModel({
    this.additional,
    this.isdir,
    this.name,
    this.path,
  });

  FileModel.fromJson(dynamic json) {
    additional = json['additional'] != null ? FileAdditional.fromJson(json['additional']) : null;
    isdir = json['isdir'];
    name = json['name'];
    path = json['path'];
  }
  FileAdditional additional;
  bool isdir;
  String name;
  String path;
  FileModel copyWith({
    FileAdditional additional,
    bool isdir,
    String name,
    String path,
  }) =>
      FileModel(
        additional: additional ?? this.additional,
        isdir: isdir ?? this.isdir,
        name: name ?? this.name,
        path: path ?? this.path,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (additional != null) {
      map['additional'] = additional.toJson();
    }
    map['isdir'] = isdir;
    map['name'] = name;
    map['path'] = path;
    return map;
  }
}

/// mount_point_type : ""
/// perm : {"acl":{"append":true,"del":true,"exec":true,"read":true,"write":true},"is_acl_mode":true,"posix":0}
/// real_path : "/volume3/Downloads/#recycle"
/// size : 22
/// time : {"atime":1665630332,"crtime":1608624866,"ctime":1608626351,"mtime":1608624866}

class FileAdditional {
  FileAdditional({
    this.mountPointType,
    this.perm,
    this.realPath,
    this.size,
    this.time,
  });

  FileAdditional.fromJson(dynamic json) {
    mountPointType = json['mount_point_type'];
    perm = json['perm'] != null ? FilePerm.fromJson(json['perm']) : null;
    realPath = json['real_path'];
    size = json['size'];
    time = json['time'] != null ? FileTime.fromJson(json['time']) : null;
  }
  String mountPointType;
  FilePerm perm;
  String realPath;
  num size;
  FileTime time;
  FileAdditional copyWith({
    String mountPointType,
    FilePerm perm,
    String realPath,
    num size,
    FileTime time,
  }) =>
      FileAdditional(
        mountPointType: mountPointType ?? this.mountPointType,
        perm: perm ?? this.perm,
        realPath: realPath ?? this.realPath,
        size: size ?? this.size,
        time: time ?? this.time,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['mount_point_type'] = mountPointType;
    if (perm != null) {
      map['perm'] = perm.toJson();
    }
    map['real_path'] = realPath;
    map['size'] = size;
    if (time != null) {
      map['time'] = time.toJson();
    }
    return map;
  }
}

/// atime : 1665630332
/// crtime : 1608624866
/// ctime : 1608626351
/// mtime : 1608624866

class FileTime {
  FileTime({
    this.atime,
    this.crtime,
    this.ctime,
    this.mtime,
  });

  FileTime.fromJson(dynamic json) {
    atime = json['atime'];
    crtime = json['crtime'];
    ctime = json['ctime'];
    mtime = json['mtime'];
  }
  num atime;
  num crtime;
  num ctime;
  num mtime;
  FileTime copyWith({
    num atime,
    num crtime,
    num ctime,
    num mtime,
  }) =>
      FileTime(
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
/// posix : 0

class FilePerm {
  FilePerm({
    this.acl,
    this.isAclMode,
    this.posix,
  });

  FilePerm.fromJson(dynamic json) {
    acl = json['acl'] != null ? Acl.fromJson(json['acl']) : null;
    isAclMode = json['is_acl_mode'];
    posix = json['posix'];
  }
  Acl acl;
  bool isAclMode;
  num posix;
  FilePerm copyWith({
    Acl acl,
    bool isAclMode,
    num posix,
  }) =>
      FilePerm(
        acl: acl ?? this.acl,
        isAclMode: isAclMode ?? this.isAclMode,
        posix: posix ?? this.posix,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (acl != null) {
      map['acl'] = acl.toJson();
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
  bool append;
  bool del;
  bool exec;
  bool read;
  bool write;
  Acl copyWith({
    bool append,
    bool del,
    bool exec,
    bool read,
    bool write,
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
