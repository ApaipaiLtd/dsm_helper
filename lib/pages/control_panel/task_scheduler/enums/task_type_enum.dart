enum TaskTypeEnum {
  recycle(label: "回收站"),
  beep(label: "哔声控制"),
  service(label: "服务"),
  event_script(label: "用户定义的脚本"),
  script(label: "用户定义的脚本"),
  unknown(label: "用户定义的脚本");

  final String label;

  const TaskTypeEnum({
    required this.label,
  });

  static TaskTypeEnum fromValue(String value) {
    return TaskTypeEnum.values.firstWhere((element) => element.name == value, orElse: () => TaskTypeEnum.unknown);
  }
}
