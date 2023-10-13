import 'dart:convert';

import 'package:dsm_helper/apis/api.dart';
import 'package:dsm_helper/models/Syno/Core/Security/Firewall/Rules/FirewallRulesServ.dart';
import 'package:dsm_helper/models/Syno/Core/Service/ServicePortInfo.dart';
import 'package:dsm_helper/models/base_model.dart';

/// packages : [{"additional":{"autoupdate":false,"autoupdate_important":false,"beta":false,"ctl_uninstall":true,"dependent_packages":null,"description":"Active Insight 云服务可加速故障排除流程，提供更好的技术支持体验。在多台 Synology 主机上启用此服务时，您可通过性能监控和自动警告系统管理您部署在不同位置的这些设备。","description_enu":"","distributor":"","distributor_url":"","dsm_app_launch_name":"","dsm_app_page":"","dsm_apps":"SYNO.SDS.ActiveInsight.Instance ","install_type":"system","installed_info":{"is_brick":false,"is_broken":false,"path":"/usr/local/packages/@appstore/ActiveInsight"},"is_uninstall_pages":true,"maintainer":"Synology Inc.","maintainer_url":"","report_beta_url":"","silent_upgrade":true,"startable":false,"support_center":true,"support_url":"","updated_at":"2023/06/29","status":"status_description","status_code":0,"status_origin":"running"},"id":"ActiveInsight","name":"Active Insight","timestamp":1697094982290,"version":"2.1.0-2603"}]
/// total : 26

class Package extends BaseModel {
  Package({this.packages, this.total, List<String> additional = const ['status']}) {
    super.data = {
      "additional": additional,
    };
  }
  String? api = "SYNO.Core.Package";
  String? method = "list";
  int? version = 1;

  static Future<Package> list(
      {List<String> additional = const [
        "description",
        "description_enu",
        "dependent_packages",
        "beta",
        "distributor",
        "distributor_url",
        "maintainer",
        "maintainer_url",
        "dsm_apps",
        "dsm_app_page",
        "dsm_app_launch_name",
        "report_beta_url",
        "support_center",
        "startable",
        "installed_info",
        "support_url",
        "is_uninstall_pages",
        "install_type",
        "autoupdate",
        "silent_upgrade",
        "installing_progress",
        "ctl_uninstall",
        "updated_at"
      ]}) async {
    DsmResponse res = await Api.dsm.entry("SYNO.Core.Package", "list", version: 1, parser: Package.fromJson, data: {
      "additional": jsonEncode(additional),
    });
    return res.data;
  }

  Package.fromJson(dynamic json) {
    if (json['packages'] != null) {
      packages = [];
      json['packages'].forEach((v) {
        packages?.add(Packages.fromJson(v));
      });
    }
    total = json['total'];
  }
  List<Packages>? packages;
  num? total;
  Package copyWith({
    List<Packages>? packages,
    num? total,
  }) =>
      Package(
        packages: packages ?? this.packages,
        total: total ?? this.total,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (packages != null) {
      map['packages'] = packages?.map((v) => v.toJson()).toList();
    }
    map['total'] = total;
    return map;
  }

  @override
  fromJson(json) {
    return Package.fromJson(json);
  }
}

/// additional : {"autoupdate":false,"autoupdate_important":false,"beta":false,"ctl_uninstall":true,"dependent_packages":null,"description":"Active Insight 云服务可加速故障排除流程，提供更好的技术支持体验。在多台 Synology 主机上启用此服务时，您可通过性能监控和自动警告系统管理您部署在不同位置的这些设备。","description_enu":"","distributor":"","distributor_url":"","dsm_app_launch_name":"","dsm_app_page":"","dsm_apps":"SYNO.SDS.ActiveInsight.Instance ","install_type":"system","installed_info":{"is_brick":false,"is_broken":false,"path":"/usr/local/packages/@appstore/ActiveInsight"},"is_uninstall_pages":true,"maintainer":"Synology Inc.","maintainer_url":"","report_beta_url":"","silent_upgrade":true,"startable":false,"support_center":true,"support_url":"","updated_at":"2023/06/29","status":"status_description","status_code":0,"status_origin":"running"}
/// id : "ActiveInsight"
/// name : "Active Insight"
/// timestamp : 1697094982290
/// version : "2.1.0-2603"

class Packages {
  Packages({
    this.additional,
    this.id,
    this.name,
    this.timestamp,
    this.version,
  });

  Packages.fromJson(dynamic json) {
    additional = json['additional'] != null ? Additional.fromJson(json['additional']) : null;
    id = json['id'];
    name = json['name'];
    timestamp = json['timestamp'];
    version = json['version'];
  }
  Additional? additional;
  String? id;
  String? name;
  num? timestamp;
  String? version;
  List<PortInfo> portInfo = [];
  ServicePolicy? servicePolicy;
  Packages copyWith({
    Additional? additional,
    String? id,
    String? name,
    num? timestamp,
    String? version,
  }) =>
      Packages(
        additional: additional ?? this.additional,
        id: id ?? this.id,
        name: name ?? this.name,
        timestamp: timestamp ?? this.timestamp,
        version: version ?? this.version,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (additional != null) {
      map['additional'] = additional?.toJson();
    }
    map['id'] = id;
    map['name'] = name;
    map['timestamp'] = timestamp;
    map['version'] = version;
    return map;
  }
}

/// autoupdate : false
/// autoupdate_important : false
/// beta : false
/// ctl_uninstall : true
/// dependent_packages : null
/// description : "Active Insight 云服务可加速故障排除流程，提供更好的技术支持体验。在多台 Synology 主机上启用此服务时，您可通过性能监控和自动警告系统管理您部署在不同位置的这些设备。"
/// description_enu : ""
/// distributor : ""
/// distributor_url : ""
/// dsm_app_launch_name : ""
/// dsm_app_page : ""
/// dsm_apps : "SYNO.SDS.ActiveInsight.Instance "
/// install_type : "system"
/// installed_info : {"is_brick":false,"is_broken":false,"path":"/usr/local/packages/@appstore/ActiveInsight"}
/// is_uninstall_pages : true
/// maintainer : "Synology Inc."
/// maintainer_url : ""
/// report_beta_url : ""
/// silent_upgrade : true
/// startable : false
/// support_center : true
/// support_url : ""
/// updated_at : "2023/06/29"
/// status : "status_description"
/// status_code : 0
/// status_origin : "running"

class Additional {
  Additional({
    this.autoupdate,
    this.autoupdateImportant,
    this.beta,
    this.ctlUninstall,
    this.dependentPackages,
    this.description,
    this.descriptionEnu,
    this.distributor,
    this.distributorUrl,
    this.dsmAppLaunchName,
    this.dsmAppPage,
    this.dsmApps,
    this.installType,
    this.installedInfo,
    this.isUninstallPages,
    this.maintainer,
    this.maintainerUrl,
    this.reportBetaUrl,
    this.silentUpgrade,
    this.startable,
    this.supportCenter,
    this.supportUrl,
    this.updatedAt,
    this.status,
    this.statusCode,
    this.statusOrigin,
  });

  Additional.fromJson(dynamic json) {
    autoupdate = json['autoupdate'];
    autoupdateImportant = json['autoupdate_important'];
    beta = json['beta'];
    ctlUninstall = json['ctl_uninstall'];
    dependentPackages = json['dependent_packages'];
    description = json['description'];
    descriptionEnu = json['description_enu'];
    distributor = json['distributor'];
    distributorUrl = json['distributor_url'];
    dsmAppLaunchName = json['dsm_app_launch_name'];
    dsmAppPage = json['dsm_app_page'];
    dsmApps = json['dsm_apps'];
    installType = json['install_type'];
    installedInfo = json['installed_info'] != null ? InstalledInfo.fromJson(json['installed_info']) : null;
    isUninstallPages = json['is_uninstall_pages'];
    maintainer = json['maintainer'];
    maintainerUrl = json['maintainer_url'];
    reportBetaUrl = json['report_beta_url'];
    silentUpgrade = json['silent_upgrade'];
    startable = json['startable'];
    supportCenter = json['support_center'];
    supportUrl = json['support_url'];
    updatedAt = json['updated_at'];
    status = json['status'];
    statusCode = json['status_code'];
    statusOrigin = json['status_origin'];
  }
  bool? autoupdate;
  bool? autoupdateImportant;
  bool? beta;
  bool? ctlUninstall;
  dynamic dependentPackages;
  String? description;
  String? descriptionEnu;
  String? distributor;
  String? distributorUrl;
  String? dsmAppLaunchName;
  String? dsmAppPage;
  String? dsmApps;
  String? installType;
  InstalledInfo? installedInfo;
  bool? isUninstallPages;
  String? maintainer;
  String? maintainerUrl;
  String? reportBetaUrl;
  bool? silentUpgrade;
  bool? startable;
  bool? supportCenter;
  String? supportUrl;
  String? updatedAt;
  String? status;
  num? statusCode;
  String? statusOrigin;
  Additional copyWith({
    bool? autoupdate,
    bool? autoupdateImportant,
    bool? beta,
    bool? ctlUninstall,
    dynamic dependentPackages,
    String? description,
    String? descriptionEnu,
    String? distributor,
    String? distributorUrl,
    String? dsmAppLaunchName,
    String? dsmAppPage,
    String? dsmApps,
    String? installType,
    InstalledInfo? installedInfo,
    bool? isUninstallPages,
    String? maintainer,
    String? maintainerUrl,
    String? reportBetaUrl,
    bool? silentUpgrade,
    bool? startable,
    bool? supportCenter,
    String? supportUrl,
    String? updatedAt,
    String? status,
    num? statusCode,
    String? statusOrigin,
  }) =>
      Additional(
        autoupdate: autoupdate ?? this.autoupdate,
        autoupdateImportant: autoupdateImportant ?? this.autoupdateImportant,
        beta: beta ?? this.beta,
        ctlUninstall: ctlUninstall ?? this.ctlUninstall,
        dependentPackages: dependentPackages ?? this.dependentPackages,
        description: description ?? this.description,
        descriptionEnu: descriptionEnu ?? this.descriptionEnu,
        distributor: distributor ?? this.distributor,
        distributorUrl: distributorUrl ?? this.distributorUrl,
        dsmAppLaunchName: dsmAppLaunchName ?? this.dsmAppLaunchName,
        dsmAppPage: dsmAppPage ?? this.dsmAppPage,
        dsmApps: dsmApps ?? this.dsmApps,
        installType: installType ?? this.installType,
        installedInfo: installedInfo ?? this.installedInfo,
        isUninstallPages: isUninstallPages ?? this.isUninstallPages,
        maintainer: maintainer ?? this.maintainer,
        maintainerUrl: maintainerUrl ?? this.maintainerUrl,
        reportBetaUrl: reportBetaUrl ?? this.reportBetaUrl,
        silentUpgrade: silentUpgrade ?? this.silentUpgrade,
        startable: startable ?? this.startable,
        supportCenter: supportCenter ?? this.supportCenter,
        supportUrl: supportUrl ?? this.supportUrl,
        updatedAt: updatedAt ?? this.updatedAt,
        status: status ?? this.status,
        statusCode: statusCode ?? this.statusCode,
        statusOrigin: statusOrigin ?? this.statusOrigin,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['autoupdate'] = autoupdate;
    map['autoupdate_important'] = autoupdateImportant;
    map['beta'] = beta;
    map['ctl_uninstall'] = ctlUninstall;
    map['dependent_packages'] = dependentPackages;
    map['description'] = description;
    map['description_enu'] = descriptionEnu;
    map['distributor'] = distributor;
    map['distributor_url'] = distributorUrl;
    map['dsm_app_launch_name'] = dsmAppLaunchName;
    map['dsm_app_page'] = dsmAppPage;
    map['dsm_apps'] = dsmApps;
    map['install_type'] = installType;
    if (installedInfo != null) {
      map['installed_info'] = installedInfo?.toJson();
    }
    map['is_uninstall_pages'] = isUninstallPages;
    map['maintainer'] = maintainer;
    map['maintainer_url'] = maintainerUrl;
    map['report_beta_url'] = reportBetaUrl;
    map['silent_upgrade'] = silentUpgrade;
    map['startable'] = startable;
    map['support_center'] = supportCenter;
    map['support_url'] = supportUrl;
    map['updated_at'] = updatedAt;
    map['status'] = status;
    map['status_code'] = statusCode;
    map['status_origin'] = statusOrigin;
    return map;
  }
}

/// is_brick : false
/// is_broken : false
/// path : "/usr/local/packages/@appstore/ActiveInsight"

class InstalledInfo {
  InstalledInfo({
    this.isBrick,
    this.isBroken,
    this.path,
  });

  InstalledInfo.fromJson(dynamic json) {
    isBrick = json['is_brick'];
    isBroken = json['is_broken'];
    path = json['path'];
  }
  bool? isBrick;
  bool? isBroken;
  String? path;
  InstalledInfo copyWith({
    bool? isBrick,
    bool? isBroken,
    String? path,
  }) =>
      InstalledInfo(
        isBrick: isBrick ?? this.isBrick,
        isBroken: isBroken ?? this.isBroken,
        path: path ?? this.path,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['is_brick'] = isBrick;
    map['is_broken'] = isBroken;
    map['path'] = path;
    return map;
  }
}
