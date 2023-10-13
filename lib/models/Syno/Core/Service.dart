import 'dart:convert';

import 'package:dsm_helper/apis/api.dart';
import 'package:dsm_helper/models/Syno/Core/Security/Firewall/Rules/FirewallRulesServ.dart';
import 'package:dsm_helper/models/Syno/Core/Service/ServicePortInfo.dart';
import 'package:dsm_helper/models/base_model.dart';

/// service : [{"additional":{"active_status":"active"},"display_name_section_key":"helptoc:winmacnfs_mac","enable_status":"enabled","service_id":"atalk"},{"additional":{"active_status":"inactive"},"display_name_section_key":"network:bonjourPrinter_subject","enable_status":"disabled","service_id":"bonjour"},{"additional":{"active_status":"inactive"},"display_name_section_key":"service:cups_printer_daemon","enable_status":"static","service_id":"cupsd"},{"additional":{"active_status":"active"},"display_name_section_key":"tree:leaf_ftp","enable_status":"enabled","service_id":"ftp-pure"},{"additional":{"active_status":"active"},"display_name_section_key":"tree:leaf_ftpes","enable_status":"enabled","service_id":"ftp-ssl"},{"additional":{"active_status":"active"},"display_name_section_key":"nfs:nfs_title","enable_status":"enabled","service_id":"nfs-server"},{"additional":{"active_status":"active"},"display_name_section_key":"helptoc:ntp_service","enable_status":"enabled","service_id":"ntpd"},{"additional":{"active_status":"active"},"display_name_section_key":"tree:leaf_iscsi","enable_status":"static","service_id":"pkg-iscsi"},{"additional":{"active_status":"active"},"display_name_section_key":"helptoc:winmacnfs_win","enable_status":"enabled","service_id":"pkg-synosamba-smbd"},{"additional":{"active_status":"active"},"display_name_section_key":"service:wstransfer_title","enable_status":"enabled","service_id":"pkg-synosamba-wstransfer-genconf"},{"additional":{"active_status":"inactive"},"display_name_section_key":"service:service_rsync","enable_status":"disabled","service_id":"rsyncd"},{"additional":{"active_status":"inactive"},"display_name_section_key":"tree:leaf_sftp","enable_status":"disabled","service_id":"sftp"},{"additional":{"active_status":"active"},"display_name_section_key":"SNMP","enable_status":"static","service_id":"snmpd"},{"additional":{"active_status":"active"},"display_name_section_key":"firewall:firewall_service_opt_ssh","enable_status":"enabled","service_id":"ssh-shell"},{"additional":{"active_status":"active"},"display_name_section_key":"about:dsm","enable_status":"static","service_id":"synoscgi"},{"additional":{"active_status":"inactive"},"display_name_section_key":"firewall:firewall_service_opt_telnet","enable_status":"disabled","service_id":"telnetd"},{"additional":{"active_status":"inactive"},"display_name_section_key":"ftp:tftp_title","enable_status":"disabled","service_id":"tftp"},{"additional":{"active_status":"inactive"},"display_name_section_key":"helptoc:power_ups","enable_status":"disabled","service_id":"ups-net"},{"additional":{"active_status":"inactive"},"display_name_section_key":"helptoc:power_ups","enable_status":"static","service_id":"ups-usb"}]

class CoreService extends BaseModel {
  CoreService({
    this.service,
    List<String> additional = const ["active_status"],
  }) {
    super.data = {
      "additional": additional,
    };
  }

  String? api = "SYNO.Core.Service";
  String? method = "get";
  int? version = 3;

  static Future<CoreService> get({List<String> additional = const ["active_status"]}) async {
    DsmResponse res = await Api.dsm.entry("SYNO.Core.Service", "get", version: 3, parser: CoreService.fromJson, data: {
      "additional": jsonEncode(additional),
    });
    return res.data;
  }

  CoreService.fromJson(dynamic json) {
    if (json['service'] != null) {
      service = [];
      json['service'].forEach((v) {
        service?.add(Service.fromJson(v));
      });
    }
  }
  List<Service>? service;
  CoreService copyWith({
    List<Service>? service,
  }) =>
      CoreService(
        service: service ?? this.service,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (service != null) {
      map['service'] = service?.map((v) => v.toJson()).toList();
    }
    return map;
  }

  @override
  fromJson(json) {
    return CoreService.fromJson(json);
  }
}

/// additional : {"active_status":"active"}
/// display_name_section_key : "helptoc:winmacnfs_mac"
/// enable_status : "enabled"
/// service_id : "atalk"

class Service {
  Service({
    this.additional,
    this.displayNameSectionKey,
    this.enableStatus,
    this.serviceId,
  });

  Service.fromJson(dynamic json) {
    additional = json['additional'] != null ? Additional.fromJson(json['additional']) : null;
    displayNameSectionKey = json['display_name_section_key'];
    enableStatus = json['enable_status'];
    serviceId = json['service_id'];
  }
  Additional? additional;
  String? displayNameSectionKey;
  String? displayName;
  String? enableStatus;
  String? serviceId;
  List<PortInfo> portInfo = [];
  ServicePolicy? servicePolicy;
  Service copyWith({
    Additional? additional,
    String? displayNameSectionKey,
    String? enableStatus,
    String? serviceId,
  }) =>
      Service(
        additional: additional ?? this.additional,
        displayNameSectionKey: displayNameSectionKey ?? this.displayNameSectionKey,
        enableStatus: enableStatus ?? this.enableStatus,
        serviceId: serviceId ?? this.serviceId,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (additional != null) {
      map['additional'] = additional?.toJson();
    }
    map['display_name_section_key'] = displayNameSectionKey;
    map['enable_status'] = enableStatus;
    map['service_id'] = serviceId;
    return map;
  }
}

/// active_status : "active"

class Additional {
  Additional({
    this.activeStatus,
  });

  Additional.fromJson(dynamic json) {
    activeStatus = json['active_status'];
  }
  String? activeStatus;
  Additional copyWith({
    String? activeStatus,
  }) =>
      Additional(
        activeStatus: activeStatus ?? this.activeStatus,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['active_status'] = activeStatus;
    return map;
  }
}
