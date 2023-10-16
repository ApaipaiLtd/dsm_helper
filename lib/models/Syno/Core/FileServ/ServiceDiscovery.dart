import 'package:dsm_helper/models/base_model.dart';

/// enable_afp_time_machine : false
/// enable_smb_time_machine : false
/// time_machine_disable_shares : []
/// time_machine_shares : []

class ServiceDiscovery implements BaseModel {
  ServiceDiscovery({
    this.enableAfpTimeMachine,
    this.enableSmbTimeMachine,
    this.timeMachineDisableShares,
    this.timeMachineShares,
  });

  String? api = "SYNO.Core.FileServ.ServiceDiscovery";
  String? method = "get";
  int? version = 1;

  ServiceDiscovery.fromJson(dynamic json) {
    enableAfpTimeMachine = json['enable_afp_time_machine'];
    enableSmbTimeMachine = json['enable_smb_time_machine'];
    if (json['time_machine_disable_shares'] != null) {
      timeMachineDisableShares = json['time_machine_disable_shares'].cast<String>();
      // json['time_machine_disable_shares'].forEach((v) {
      //   timeMachineDisableShares?.add(Dynamic.fromJson(v));
      // });
    }
    if (json['time_machine_shares'] != null) {
      timeMachineShares = json['time_machine_shares'].cast<String>();
      // json['time_machine_shares'].forEach((v) {
      //   timeMachineShares?.add(Dynamic.fromJson(v));
      // });
    }
  }
  bool? enableAfpTimeMachine;
  bool? enableSmbTimeMachine;
  List<dynamic>? timeMachineDisableShares;
  List<dynamic>? timeMachineShares;
  ServiceDiscovery copyWith({
    bool? enableAfpTimeMachine,
    bool? enableSmbTimeMachine,
    List<dynamic>? timeMachineDisableShares,
    List<dynamic>? timeMachineShares,
  }) =>
      ServiceDiscovery(
        enableAfpTimeMachine: enableAfpTimeMachine ?? this.enableAfpTimeMachine,
        enableSmbTimeMachine: enableSmbTimeMachine ?? this.enableSmbTimeMachine,
        timeMachineDisableShares: timeMachineDisableShares ?? this.timeMachineDisableShares,
        timeMachineShares: timeMachineShares ?? this.timeMachineShares,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['enable_afp_time_machine'] = enableAfpTimeMachine;
    map['enable_smb_time_machine'] = enableSmbTimeMachine;
    if (timeMachineDisableShares != null) {
      map['time_machine_disable_shares'] = timeMachineDisableShares?.map((v) => v.toJson()).toList();
    }
    if (timeMachineShares != null) {
      map['time_machine_shares'] = timeMachineShares?.map((v) => v.toJson()).toList();
    }
    return map;
  }

  @override
  fromJson(json) {
    return ServiceDiscovery.fromJson(json);
  }

  @override
  Map<String, dynamic>? data;
}
