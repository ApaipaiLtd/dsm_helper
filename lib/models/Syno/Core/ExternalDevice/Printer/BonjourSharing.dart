/// enable_bonjour_support : false

class BonjourSharing {
  BonjourSharing({
    this.enableBonjourSupport,
  });

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
}
