enum ShareLinkStatusEnum {
  valid(
    label: "有效",
    value: "valid",
  ),
  expired(label: "过期", value: "valid"),
  inactive(label: "未生效", value: "inactive"),
  unknown(label: "未知", value: "unknown");

  final String label;
  final String value;
  const ShareLinkStatusEnum({required this.label, required this.value});

  static ShareLinkStatusEnum fromValue(String value) {
    return ShareLinkStatusEnum.values.firstWhere((element) => element.value == value, orElse: () => ShareLinkStatusEnum.unknown);
  }
}
