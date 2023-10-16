enum UsbDeviceClassEnum {
  hub(label: "USB集线器"),
  disk(label: "USB硬盘"),
  unknown(label: "-");

  const UsbDeviceClassEnum({required this.label});
  final String label;

  static UsbDeviceClassEnum fromValue(String value) {
    return UsbDeviceClassEnum.values.firstWhere((element) => element.name == value, orElse: () => UsbDeviceClassEnum.unknown);
  }
}
