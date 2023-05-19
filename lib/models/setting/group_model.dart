import 'package:dsm_helper/util/function.dart';

/// id : 1
/// type : 1
/// name : ""
/// no : ""
/// key : ""
/// status : ""

class GroupsModel {
  GroupsModel({this.qq, this.wechat, this.channel});
  List<GroupModel> qq;
  List<GroupModel> wechat;
  List<GroupModel> channel;
  static Future<GroupsModel> fetch() async {
    var res = await Util.post("${Util.appUrl}/app/groups");
    if (res['code'] == 1) {
      List<GroupModel> qq = [];
      List<GroupModel> wechat = [];
      List<GroupModel> channel = [];
      res['data']['qq'].forEach((e) {
        qq.add(GroupModel.fromJson(e));
      });
      res['data']['wechat'].forEach((e) {
        wechat.add(GroupModel.fromJson(e));
      });
      res['data']['channel'].forEach((e) {
        channel.add(GroupModel.fromJson(e));
      });
      return GroupsModel(qq: qq, wechat: wechat, channel: channel);
    } else {
      throw Exception("加载失败");
    }
  }
}

class GroupModel {
  GroupModel({
    this.id,
    this.type,
    this.name,
    this.no,
    this.key,
    this.status,
  });

  GroupModel.fromJson(dynamic json) {
    id = json['id'];
    type = json['type'];
    name = json['name'];
    no = json['no'];
    key = json['key'];
    status = json['status'];
  }
  String get displayName => "$name${status.isNotBlank ? '($status)' : ''}";
  num id;
  num type;
  String name;
  String no;
  String key;
  String status;
  GroupModel copyWith({
    num id,
    num type,
    String name,
    String no,
    String key,
    String status,
  }) =>
      GroupModel(
        id: id ?? this.id,
        type: type ?? this.type,
        name: name ?? this.name,
        no: no ?? this.no,
        key: key ?? this.key,
        status: status ?? this.status,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['type'] = type;
    map['name'] = name;
    map['no'] = no;
    map['key'] = key;
    map['status'] = status;
    return map;
  }
}
