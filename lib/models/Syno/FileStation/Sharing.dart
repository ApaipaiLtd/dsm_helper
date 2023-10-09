import 'dart:convert';

import 'package:dsm_helper/apis/api.dart';
import 'package:dsm_helper/pages/file/enums/share_link_status_enums.dart';
import 'package:dsm_helper/utils/utils.dart' hide Api;

/// links : [{"app":{"enable_upload":false,"is_folder":true},"date_available":"","date_expired":"","enable_upload":false,"expire_times":0,"has_password":false,"id":"EFNYhSJyD","isFolder":true,"limit_size":0,"link_owner":"yaoshuwei","name":"动漫","path":"/影视/动漫","project_name":"SYNO.SDS.App.FileStation3.Instance","protect_groups":[],"protect_type":"none","protect_users":[],"qrcode":"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAJMAAACTAQMAAACwK7lWAAAABlBMVEUAAAD///+l2Z/dAAAAAnRSTlP//8i138cAAAAJcEhZcwAACxIAAAsSAdLdfvwAAAIBSURBVEiJ3ZaxjfQgEIXHIiCzG0CiDTJashuw1w2sWyKjDSQasDMC5LnH7Z7+lf4LmPQsgt3PEmIeb+aZ+P+H/jQ7iZaYH86sZK9Ag4RdXBc2E9dR1yXir4QFswT78DQ7y5EWIVspP13mgP3kTBvS6ih8SBnXmdQV6+jM9q+2Lvatn3mvT007GJ4rqr1gP/txl30smFmjlLzHfFMdJOzU+Qh1Jd7ZDMVsIuYSwSklbSHf/u21TnYVdfo0FRpxdZx3CTt1Ip8fWGRvlxYJ42gh3hDaWoplCTu9mZ0ZAgoyo37feSe72ynq6mgI+JEPCbsizT4/PU3BkKuLjKmdFY5/unxqI2K3h7XhF5oJwr/uvJs5yI8iUH0a/Uu/XnZFMwW0CJHng9UuYdhvh01CGrBfc6uAXSGtVKcACfOtM4tYUQfDp3XDCryLGCqgSqSOAAl/NOhjqOOICkZbvRk4yxgZnGIptGEAw+8y1kbIVOzp+EFZxDA1V19nnWYMoZgmGUNAWSgxEkr50aWTYdZidEWETFqCkjFud3W1oFAc333ZzTB3UT3v0cz06o9e9upIDmkKFu8HCUPOrC1q8AbZaFnCkG9bwUFaU74Gg4C1PG9T8O1WKWvfERjYSHVmKSttjF0hn2QPEWN4TT01oTWHKGPf+iFU0Z0IyQ9NO9hv32t/l30BMYVcmi9DrzwAAAAASUVORK5CYII=","request_info":"","request_name":"","status":"valid","uid":1026,"url":"http://pan.apaipai.top:5000/sharing/EFNYhSJyD"}]
/// offset : 0
/// total : 1

class Sharing {
  Sharing({
    this.links,
    this.offset,
    this.total,
  });

  static Future<Sharing> list() async {
    DsmResponse res = await Api.dsm.entry(
      "SYNO.FileStation.Sharing",
      "list",
      version: 3,
      data: {
        "offset": 0,
        "limit": 50,
        "filter_type": "SYNO.SDS.App.FileStation3.Instance,SYNO.SDS.App.SharingUpload.Application",
      },
      parser: Sharing.fromJson,
    );
    return res.data;
  }

  static Future<bool?> clearInvalid() async {
    DsmResponse res = await Api.dsm.entry(
      "SYNO.FileStation.Sharing",
      "clear_invalid",
      version: 2,
    );
    return res.success;
  }

  static Future<Sharing> create({required List<String> paths, bool fileRequest = false, String? requestName, String? requestInfo}) async {
    Map<String, dynamic> data = {
      "path": jsonEncode(paths),
    };
    if (fileRequest) {
      data['file_request'] = true;
      data['request_name'] = requestName!;
      data['request_info'] = requestInfo!;
    }
    DsmResponse res = await Api.dsm.entry(
      "SYNO.FileStation.Sharing",
      "create",
      version: 3,
      data: data,
      parser: Sharing.fromJson,
    );
    return res.data;
  }

  Sharing.fromJson(dynamic json) {
    if (json['links'] != null) {
      links = [];
      json['links'].forEach((v) {
        links?.add(ShareLinks.fromJson(v));
      });
    }
    offset = json['offset'];
    total = json['total'];
  }
  List<ShareLinks>? links;
  num? offset;
  num? total;
  Sharing copyWith({
    List<ShareLinks>? links,
    num? offset,
    num? total,
  }) =>
      Sharing(
        links: links ?? this.links,
        offset: offset ?? this.offset,
        total: total ?? this.total,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (links != null) {
      map['links'] = links?.map((v) => v.toJson()).toList();
    }
    map['offset'] = offset;
    map['total'] = total;
    return map;
  }
}

/// app : {"enable_upload":false,"is_folder":true}
/// date_available : ""
/// date_expired : ""
/// enable_upload : false
/// expire_times : 0
/// has_password : false
/// id : "EFNYhSJyD"
/// isFolder : true
/// limit_size : 0
/// link_owner : "yaoshuwei"
/// name : "动漫"
/// path : "/影视/动漫"
/// project_name : "SYNO.SDS.App.FileStation3.Instance"
/// protect_groups : []
/// protect_type : "none"
/// protect_users : []
/// qrcode : "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAJMAAACTAQMAAACwK7lWAAAABlBMVEUAAAD///+l2Z/dAAAAAnRSTlP//8i138cAAAAJcEhZcwAACxIAAAsSAdLdfvwAAAIBSURBVEiJ3ZaxjfQgEIXHIiCzG0CiDTJashuw1w2sWyKjDSQasDMC5LnH7Z7+lf4LmPQsgt3PEmIeb+aZ+P+H/jQ7iZaYH86sZK9Ag4RdXBc2E9dR1yXir4QFswT78DQ7y5EWIVspP13mgP3kTBvS6ih8SBnXmdQV6+jM9q+2Lvatn3mvT007GJ4rqr1gP/txl30smFmjlLzHfFMdJOzU+Qh1Jd7ZDMVsIuYSwSklbSHf/u21TnYVdfo0FRpxdZx3CTt1Ip8fWGRvlxYJ42gh3hDaWoplCTu9mZ0ZAgoyo37feSe72ynq6mgI+JEPCbsizT4/PU3BkKuLjKmdFY5/unxqI2K3h7XhF5oJwr/uvJs5yI8iUH0a/Uu/XnZFMwW0CJHng9UuYdhvh01CGrBfc6uAXSGtVKcACfOtM4tYUQfDp3XDCryLGCqgSqSOAAl/NOhjqOOICkZbvRk4yxgZnGIptGEAw+8y1kbIVOzp+EFZxDA1V19nnWYMoZgmGUNAWSgxEkr50aWTYdZidEWETFqCkjFud3W1oFAc333ZzTB3UT3v0cz06o9e9upIDmkKFu8HCUPOrC1q8AbZaFnCkG9bwUFaU74Gg4C1PG9T8O1WKWvfERjYSHVmKSttjF0hn2QPEWN4TT01oTWHKGPf+iFU0Z0IyQ9NO9hv32t/l30BMYVcmi9DrzwAAAAASUVORK5CYII="
/// request_info : ""
/// request_name : ""
/// status : "valid"
/// uid : 1026
/// url : "http://pan.apaipai.top:5000/sharing/EFNYhSJyD"

class ShareLinks {
  ShareLinks({
    this.app,
    this.dateAvailable,
    this.dateExpired,
    this.enableUpload,
    this.expireTimes,
    this.hasPassword,
    this.id,
    this.isFolder,
    this.limitSize,
    this.linkOwner,
    this.name,
    this.path,
    this.projectName,
    this.protectGroups,
    this.protectType,
    this.protectUsers,
    this.qrcode,
    this.requestInfo,
    this.requestName,
    this.status,
    this.uid,
    this.url,
  });

  Future<bool?> edit({DateTime? dateExpired, DateTime? dateAvailable, String? expireTimes, String? requestName, String? requestInfo}) async {
    Map<String, dynamic> data = {
      "url": jsonEncode([url]),
      "protect_type_enable": '"false"',
      "start_at_enable": '"${dateAvailable == null}"',
      "expire_at_enable": '"${dateExpired == null}"',
      "expire_times_enable": '"${expireTimes!.isNotEmpty}"',
      "expire_times": expireTimes,
      "protect_type": "none",
      "app": "{}",
      "project_name": '""',
      "sharing_id": null,
      "redirect_type": null,
      "redirect_uri": null,
      "auto_gc": null,
      "enable_match_ip": null,
      "enabled": null,
      "path": jsonEncode([path]),
      "id": jsonEncode([id]),
      "date_expired": dateExpired == null ? "" : '"${dateExpired.format("Y-m-d H:i:s")}"',
      "date_available": dateAvailable == null ? "" : '"${dateAvailable.format("Y-m-d H:i:s")}"',
    };
    if (enableUpload == true) {
      data['file_request'] = true;
      data['request_name'] = requestName!;
      data['request_info'] = requestInfo!;
    }
    DsmResponse res = await Api.dsm.entry(
      "SYNO.FileStation.Sharing",
      "edit",
      version: 3,
      data: data,
    );
    return res.success;
  }

  Future<bool?> delete() async {
    DsmResponse res = await Api.dsm.entry(
      "SYNO.FileStation.Sharing",
      "delete",
      version: 3,
      data: {
        "id": jsonEncode([id]),
      },
    );
    return res.success;
  }

  ShareLinks.fromJson(dynamic json) {
    app = json['app'] != null ? App.fromJson(json['app']) : null;
    dateAvailable = json['date_available'];
    dateExpired = json['date_expired'];
    enableUpload = json['enable_upload'];
    expireTimes = json['expire_times'];
    hasPassword = json['has_password'];
    id = json['id'];
    isFolder = json['isFolder'];
    limitSize = json['limit_size'];
    linkOwner = json['link_owner'];
    name = json['name'];
    path = json['path'];
    projectName = json['project_name'];
    if (json['protect_groups'] != null) {
      protectGroups = json['protect_groups'].cast<String>();
    }
    protectType = json['protect_type'];
    if (json['protect_users'] != null) {
      protectUsers = json['protect_users'].cast<String>();
    }
    qrcode = json['qrcode'];
    requestInfo = json['request_info'];
    requestName = json['request_name'];
    status = json['status'];
    uid = json['uid'];
    url = json['url'];
  }
  App? app;
  String? dateAvailable;
  String? dateExpired;
  bool? enableUpload;
  int? expireTimes;
  bool? hasPassword;
  String? id;
  bool? isFolder;
  int? limitSize;
  String? linkOwner;
  String? name;
  String? path;
  String? projectName;
  List<String>? protectGroups;
  String? protectType;
  List<String>? protectUsers;
  String? qrcode;
  String? requestInfo;
  String? requestName;
  String? status;
  int? uid;
  String? url;

  ShareLinkStatusEnum get statusEnum => ShareLinkStatusEnum.fromValue(status ?? 'unknown');

  FileTypeEnum get fileType {
    if (isFolder == true) {
      return FileTypeEnum.folder;
    } else {
      return Utils.fileType(path!);
    }
  }

  ShareLinks copyWith({
    App? app,
    String? dateAvailable,
    String? dateExpired,
    bool? enableUpload,
    int? expireTimes,
    bool? hasPassword,
    String? id,
    bool? isFolder,
    int? limitSize,
    String? linkOwner,
    String? name,
    String? path,
    String? projectName,
    List<String>? protectGroups,
    String? protectType,
    List<String>? protectUsers,
    String? qrcode,
    String? requestInfo,
    String? requestName,
    String? status,
    int? uid,
    String? url,
  }) =>
      ShareLinks(
        app: app ?? this.app,
        dateAvailable: dateAvailable ?? this.dateAvailable,
        dateExpired: dateExpired ?? this.dateExpired,
        enableUpload: enableUpload ?? this.enableUpload,
        expireTimes: expireTimes ?? this.expireTimes,
        hasPassword: hasPassword ?? this.hasPassword,
        id: id ?? this.id,
        isFolder: isFolder ?? this.isFolder,
        limitSize: limitSize ?? this.limitSize,
        linkOwner: linkOwner ?? this.linkOwner,
        name: name ?? this.name,
        path: path ?? this.path,
        projectName: projectName ?? this.projectName,
        protectGroups: protectGroups ?? this.protectGroups,
        protectType: protectType ?? this.protectType,
        protectUsers: protectUsers ?? this.protectUsers,
        qrcode: qrcode ?? this.qrcode,
        requestInfo: requestInfo ?? this.requestInfo,
        requestName: requestName ?? this.requestName,
        status: status ?? this.status,
        uid: uid ?? this.uid,
        url: url ?? this.url,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (app != null) {
      map['app'] = app?.toJson();
    }
    map['date_available'] = dateAvailable;
    map['date_expired'] = dateExpired;
    map['enable_upload'] = enableUpload;
    map['expire_times'] = expireTimes;
    map['has_password'] = hasPassword;
    map['id'] = id;
    map['isFolder'] = isFolder;
    map['limit_size'] = limitSize;
    map['link_owner'] = linkOwner;
    map['name'] = name;
    map['path'] = path;
    map['project_name'] = projectName;
    map['protect_groups'] = protectGroups;
    map['protect_type'] = protectType;
    map['protect_users'] = protectUsers;
    map['qrcode'] = qrcode;
    map['request_info'] = requestInfo;
    map['request_name'] = requestName;
    map['status'] = status;
    map['uid'] = uid;
    map['url'] = url;
    return map;
  }
}

/// enable_upload : false
/// is_folder : true

class App {
  App({
    this.enableUpload,
    this.isFolder,
  });

  App.fromJson(dynamic json) {
    enableUpload = json['enable_upload'];
    isFolder = json['is_folder'];
  }
  bool? enableUpload;
  bool? isFolder;
  App copyWith({
    bool? enableUpload,
    bool? isFolder,
  }) =>
      App(
        enableUpload: enableUpload ?? this.enableUpload,
        isFolder: isFolder ?? this.isFolder,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['enable_upload'] = enableUpload;
    map['is_folder'] = isFolder;
    return map;
  }
}
