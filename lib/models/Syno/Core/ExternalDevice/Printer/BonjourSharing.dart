import 'package:dsm_helper/models/base_model.dart';

/// enable_bonjour_support : false

class BonjourSharing extends BaseModel {
  BonjourSharing({
    this.enableBonjourSupport,
  });

  String? api = "SYNO.Core.ExternalDevice.Printer.BonjourSharing";
  String? method = "get";
  int? version = 1;

  BonjourSharing.fromJson(dynamic json) {
    enableBonjourSupport = json['enable_bonjour_support'];
  }
  bool? enableBonjourSupport;
  BonjourSharing copyWith({
    bool? enableBonjourSupport,
  }) =>
      BonjourSharing(
        enableBonjourSupport: enableBonjourSupport ?? this.enableBonjourSupport,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['enable_bonjour_support'] = enableBonjourSupport;
    return map;
  }

  @override
  fromJson(json) {
    return BonjourSharing.fromJson(json);
  }
}
