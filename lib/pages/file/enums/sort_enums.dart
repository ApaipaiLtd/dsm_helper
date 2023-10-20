enum SortByEnum {
  name(label: "名称"),
  size(label: "大小"),
  type(label: "文件类型"),
  mtime(label: "修改日期"), //修改日期
  ctime(label: "创建日期"), //创建日期
  atime(label: "最近访问时间"), //最近访问时间
  posix(label: "权限"),
  user(label: "拥有者"),
  group(label: "群组");

  final String label;

  const SortByEnum({required this.label});

  static SortByEnum fromValue(String value) {
    return SortByEnum.values.firstWhere((element) => element.name == value, orElse: () => SortByEnum.name);
  }
}

enum SortDirectionEnum {
  ASC(label: "由小至大", icon: "assets/icons/sort_asc.png"),
  DESC(label: "由大至小", icon: "assets/icons/sort_desc.png");

  final String label;
  final String icon;

  const SortDirectionEnum({
    required this.label,
    required this.icon,
  });

  static SortDirectionEnum fromValue(String value) {
    return SortDirectionEnum.values.firstWhere((element) => element.name == value, orElse: () => SortDirectionEnum.ASC);
  }
}
