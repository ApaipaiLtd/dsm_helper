enum ApplicationEnum {
  controlPanel(name: "控制中心", packageName: "SYNO.SDS.AdminCenter.Application", icon: "control_panel"),
  packageCenter(name: "套件中心", packageName: "SYNO.SDS.PkgManApp.Instance", icon: "package_center"),
  resourceMonitor(name: "资源监控", packageName: "SYNO.SDS.ResourceMonitor.Instance", icon: "resource_monitor"),
  storageManager(name: "存储管理器", packageName: "SYNO.SDS.StorageManager.Instance", icon: "storage_manager"),
  logCenter(name: "日志中心", packageName: "SYNO.SDS.LogCenter.Instance", icon: "log_center"),
  securityScan(name: "安全顾问", packageName: "SYNO.SDS.SecurityScan.Instance", icon: "security_scan"),
  xunlei(name: "迅雷", packageName: "SYNO.SDS.XLPan.Application", icon: "xunlei", iconFolder: "/"),
  docker(name: "Docker", packageName: "SYNO.SDS.Docker.Application", icon: "docker", iconFolder: "/"),
  containerManager(name: "Container Manager", packageName: "SYNO.SDS.ContainerManager.Application", icon: "container_manager", iconFolder: "/"),
  downloadStation(name: "Download Station", packageName: "SYNO.SDS.DownloadStation.Application", icon: "download_station", iconFolder: '/'),
  moments(name: "Moments", packageName: "SYNO.Photo.AppInstance", icon: "moments"),
  photos(name: "Synology Photos", packageName: "SYNO.Foto.AppInstance", icon: "synology_photos"),
  virtualMachineManager(name: "Virtual Machine Manager", packageName: "SYNO.SDS.Virtualization.Application", icon: "virtual_machine"),
  unSupport(name: "", packageName: "", icon: "");

  final String name;
  final String packageName;
  final String icon;
  final String? iconFolder;
  const ApplicationEnum({
    required this.name,
    required this.packageName,
    required this.icon,
    this.iconFolder,
  });
  static ApplicationEnum formPackageName(String value) {
    return ApplicationEnum.values.firstWhere((element) => element.packageName == value, orElse: () => ApplicationEnum.unSupport);
  }
}
