import 'package:dsm_helper/models/base_model.dart';

/// enable : false

class Acl implements BaseModel {
  Acl({
    this.enable,
  });

  String? api = "SYNO.Core.ACL";
  String? method = "get_bypass_traverse";
  int? version = 1;

  Acl.fromJson(dynamic json) {
    enable = json['enable'];
  }
  bool? enable;
  Acl copyWith({
    bool? enable,
  }) =>
      Acl(
        enable: enable ?? this.enable,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['enable'] = enable;
    return map;
  }

  @override
  fromJson(json) {
    return Acl.fromJson(json);
  }

  @override
  Map<String, dynamic>? data;
}
