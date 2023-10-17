enum StoragePoolDeviceTypeEnum {
  basic(label: "Basic", protect: false),
  shr_without_disk_protect(label: "Synology Hybrid RAID (SHR) ", protect: false),
  shr(label: "Synology Hybrid RAID (SHR) ", protect: true),
  raid_0(label: "RAID 0", protect: true),
  raid_1(label: "RAID 1", protect: true),
  raid_5(label: "RAID 5", protect: true),
  raid_10(label: "RAID 10", protect: true),
  unknown(label: "未知", protect: false);

  const StoragePoolDeviceTypeEnum({required this.label, required this.protect});
  final String label;
  final bool protect;

  static StoragePoolDeviceTypeEnum fromValue(String value) {
    return StoragePoolDeviceTypeEnum.values.firstWhere((element) => element.name == value, orElse: () => StoragePoolDeviceTypeEnum.unknown);
  }
}
