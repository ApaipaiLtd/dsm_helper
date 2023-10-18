enum InterfaceTypeEnum {
  pppoe(label: "PPPoE"),
  ethernet(label: "局域网"),
  unknown(label: "未知");

  const InterfaceTypeEnum({required this.label});
  final String label;
  static InterfaceTypeEnum fromValue(String value) {
    return InterfaceTypeEnum.values.firstWhere((element) => element.name == value, orElse: () => InterfaceTypeEnum.unknown);
  }
}
