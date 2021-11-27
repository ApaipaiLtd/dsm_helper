/// className : "SYNO.SDS.Docker.ContainerDetail.Instance"
/// icon : "images/docker_shortcut_{0}.png"
/// launchParams : {"打开状态页面":{"data":{"name":"firefox"}}}
/// needHide : false
/// needUpdate : false
/// param : {"data":{"name":"firefox"}}
/// title : "firefox"
/// type : "url"
/// url : "http://pan.fmtol.com:5083/vnc.html"

class ShortcutItemModel {
  ShortcutItemModel({
    this.className,
    this.icon,
    this.needHide,
    this.needUpdate,
    this.param,
    this.title,
    this.type,
    this.url,
  });
  static List<ShortcutItemModel> fromList(dynamic json) {
    if (json != null && json is List) {
      List list = json;
      return list.map((e) => ShortcutItemModel.fromJson(e)).toList();
    } else {
      return [];
    }
  }

  ShortcutItemModel.fromJson(dynamic json) {
    className = json['className'];
    icon = json['icon'];
    needHide = json['needHide'];
    needUpdate = json['needUpdate'];
    param = json['param'] != null ? Param.fromJson(json['param']) : null;
    title = json['title'];
    type = json['type'];
    url = json['url'];
  }
  String className;
  String icon;
  bool needHide;
  bool needUpdate;
  Param param;
  String title;
  String type;
  String url;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['className'] = className;
    map['icon'] = icon;
    map['needHide'] = needHide;
    map['needUpdate'] = needUpdate;
    if (param != null) {
      map['param'] = param.toJson();
    }
    map['title'] = title;
    map['type'] = type;
    map['url'] = url;
    return map;
  }
}

/// data : {"name":"firefox"}

class Param {
  Param({
    this.data,
  });

  Param.fromJson(dynamic json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  Data data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (data != null) {
      map['data'] = data.toJson();
    }
    return map;
  }
}

/// name : "firefox"

class Data {
  Data({
    this.name,
  });

  Data.fromJson(dynamic json) {
    name = json['name'];
  }
  String name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    return map;
  }
}
