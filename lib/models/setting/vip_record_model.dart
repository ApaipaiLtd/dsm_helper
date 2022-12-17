import 'package:dsm_helper/util/function.dart';

/// id : 1
/// user_id : 1
/// start_time : ""
/// end_time : ""
/// cost : ""
/// type : 1
/// create_time : ""

class VipRecordModel {
  VipRecordModel({
    this.id,
    this.userId,
    this.startTime,
    this.endTime,
    this.cost,
    this.type,
    this.createTime,
    this.isForever,
  });
  static Future<List<VipRecordModel>> fetch() async {
    String userToken = await Util.getStorage("user_token");
    var res = await Util.post("${Util.appUrl}/vip/record", data: {"token": userToken});
    if (res['code'] == 1) {
      List<VipRecordModel> records = [];
      res['data'].forEach((e) {
        records.add(VipRecordModel.fromJson(e));
      });
      return records;
    } else {
      throw Exception(res['msg']);
    }
  }

  VipRecordModel.fromJson(dynamic json) {
    id = json['id'];
    userId = json['user_id'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    cost = json['cost'];
    type = json['type'];
    createTime = json['create_time'];
    isForever = json['is_forever'];
  }
  num id;
  num userId;
  String startTime;
  String endTime;
  String cost;
  num type;
  num isForever;
  String createTime;
  VipRecordModel copyWith({
    num id,
    num userId,
    String startTime,
    String endTime,
    String cost,
    num type,
    String createTime,
  }) =>
      VipRecordModel(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        startTime: startTime ?? this.startTime,
        endTime: endTime ?? this.endTime,
        cost: cost ?? this.cost,
        type: type ?? this.type,
        createTime: createTime ?? this.createTime,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['user_id'] = userId;
    map['start_time'] = startTime;
    map['end_time'] = endTime;
    map['cost'] = cost;
    map['type'] = type;
    map['create_time'] = createTime;
    return map;
  }
}
