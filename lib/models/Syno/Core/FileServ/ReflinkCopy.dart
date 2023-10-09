import 'package:dsm_helper/models/base_model.dart';

/// reflink_copy_enable : false

class ReflinkCopy extends BaseModel {
  ReflinkCopy({
    this.reflinkCopyEnable,
  });

  String? api = "SYNO.Core.FileServ.ReflinkCopy";
  String? method = "get";
  int? version = 1;

  ReflinkCopy.fromJson(dynamic json) {
    reflinkCopyEnable = json['reflink_copy_enable'];
  }
  bool? reflinkCopyEnable;
  ReflinkCopy copyWith({
    bool? reflinkCopyEnable,
  }) =>
      ReflinkCopy(
        reflinkCopyEnable: reflinkCopyEnable ?? this.reflinkCopyEnable,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['reflink_copy_enable'] = reflinkCopyEnable;
    return map;
  }

  @override
  fromJson(json) {
    return ReflinkCopy.fromJson(json);
  }
}
