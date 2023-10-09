import 'package:dsm_helper/models/base_model.dart';

/// enable_afp : false
/// enable_disconnect_quick : false
/// enable_umask : false
/// time_machine : ""

class Afp extends BaseModel {
  Afp({
    this.enableAfp,
    this.enableDisconnectQuick,
    this.enableUmask,
    this.timeMachine,
  });

  Afp.fromJson(dynamic json) {
    enableAfp = json['enable_afp'];
    enableDisconnectQuick = json['enable_disconnect_quick'];
    enableUmask = json['enable_umask'];
    timeMachine = json['time_machine'];
  }

  String? api = "SYNO.Core.FileServ.AFP";
  String? method = "get";
  int? version = 1;

  bool? enableAfp;
  bool? enableDisconnectQuick;
  bool? enableUmask;
  String? timeMachine;
  Afp copyWith({
    bool? enableAfp,
    bool? enableDisconnectQuick,
    bool? enableUmask,
    String? timeMachine,
  }) =>
      Afp(
        enableAfp: enableAfp ?? this.enableAfp,
        enableDisconnectQuick: enableDisconnectQuick ?? this.enableDisconnectQuick,
        enableUmask: enableUmask ?? this.enableUmask,
        timeMachine: timeMachine ?? this.timeMachine,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['enable_afp'] = enableAfp;
    map['enable_disconnect_quick'] = enableDisconnectQuick;
    map['enable_umask'] = enableUmask;
    map['time_machine'] = timeMachine;
    return map;
  }

  @override
  fromJson(json) {
    return Afp.fromJson(json);
  }
}
