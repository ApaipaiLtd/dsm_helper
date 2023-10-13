import 'package:dsm_helper/models/Syno/Core/Service/ServicePortInfo.dart';
import 'package:dsm_helper/models/base_model.dart';
import 'package:dsm_helper/pages/control_panel/info/enums/firewall_status_enum.dart';

/// service_policy : [{"interface_info":[{"adapter":"ovs_eth0","port_info":[{"port_id":"afp","status":"allow"}],"status":"allow"},{"adapter":"pppoe","port_info":[{"port_id":"afp","status":"allow"}],"status":"allow"}],"service_id":"atalk","status":"allow"},null]

class FirewallRulesServ extends BaseModel {
  FirewallRulesServ({this.servicePolicy, List<String> serviceId = const []}) {
    super.data = {
      "adapter": ["ovs_eth0", "pppoe"],
      "service_id": serviceId,
    };
  }

  String? api = "SYNO.Core.Security.Firewall.Rules.Serv";
  String? method = "policy_check";
  int? version = 1;

  FirewallRulesServ.fromJson(dynamic json) {
    if (json['service_policy'] != null) {
      servicePolicy = [];
      json['service_policy'].forEach((v) {
        servicePolicy?.add(ServicePolicy.fromJson(v));
      });
    }
  }
  List<ServicePolicy>? servicePolicy;
  FirewallRulesServ copyWith({
    List<ServicePolicy>? servicePolicy,
  }) =>
      FirewallRulesServ(
        servicePolicy: servicePolicy ?? this.servicePolicy,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (servicePolicy != null) {
      map['service_policy'] = servicePolicy?.map((v) => v.toJson()).toList();
    }
    return map;
  }

  @override
  fromJson(json) {
    return FirewallRulesServ.fromJson(json);
  }
}

/// interface_info : [{"adapter":"ovs_eth0","port_info":[{"port_id":"afp","status":"allow"}],"status":"allow"},{"adapter":"pppoe","port_info":[{"port_id":"afp","status":"allow"}],"status":"allow"}]
/// service_id : "atalk"
/// status : "allow"

class ServicePolicy {
  ServicePolicy({
    this.interfaceInfo,
    this.serviceId,
    this.status,
  });

  ServicePolicy.fromJson(dynamic json) {
    if (json['interface_info'] != null) {
      interfaceInfo = [];
      json['interface_info'].forEach((v) {
        interfaceInfo?.add(InterfaceInfo.fromJson(v));
      });
    }
    serviceId = json['service_id'];
    status = json['status'];
  }
  List<InterfaceInfo>? interfaceInfo;
  String? serviceId;
  String? status;
  FirewallStatusEnum get statusEnum => FirewallStatusEnum.fromValue(status ?? 'unknown');
  ServicePolicy copyWith({
    List<InterfaceInfo>? interfaceInfo,
    String? serviceId,
    String? status,
  }) =>
      ServicePolicy(
        interfaceInfo: interfaceInfo ?? this.interfaceInfo,
        serviceId: serviceId ?? this.serviceId,
        status: status ?? this.status,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (interfaceInfo != null) {
      map['interface_info'] = interfaceInfo?.map((v) => v.toJson()).toList();
    }
    map['service_id'] = serviceId;
    map['status'] = status;
    return map;
  }
}

/// adapter : "ovs_eth0"
/// port_info : [{"port_id":"afp","status":"allow"}]
/// status : "allow"

class InterfaceInfo {
  InterfaceInfo({
    this.adapter,
    this.portInfo,
    this.status,
  });

  InterfaceInfo.fromJson(dynamic json) {
    adapter = json['adapter'];
    if (json['port_info'] != null) {
      portInfo = [];
      json['port_info'].forEach((v) {
        portInfo?.add(PortInfo.fromJson(v));
      });
    }
    status = json['status'];
  }
  String? adapter;
  List<PortInfo>? portInfo;
  String? status;
  InterfaceInfo copyWith({
    String? adapter,
    List<PortInfo>? portInfo,
    String? status,
  }) =>
      InterfaceInfo(
        adapter: adapter ?? this.adapter,
        portInfo: portInfo ?? this.portInfo,
        status: status ?? this.status,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['adapter'] = adapter;
    if (portInfo != null) {
      map['port_info'] = portInfo?.map((v) => v.toJson()).toList();
    }
    map['status'] = status;
    return map;
  }
}
