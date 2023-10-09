/// enable : false

class Acl {
  Acl({
    this.enable,
  });

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
}
