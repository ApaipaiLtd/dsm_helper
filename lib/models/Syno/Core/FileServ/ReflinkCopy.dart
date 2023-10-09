/// reflink_copy_enable : false

class ReflinkCopy {
  ReflinkCopy({
    this.reflinkCopyEnable,
  });

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
}
