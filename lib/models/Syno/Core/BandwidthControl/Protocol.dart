/// policy : "disabled"
/// protocol : "FTP"
/// schedule_plan : "111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111"

class BandwidthProtocol {
  BandwidthProtocol({
    this.policy,
    this.protocol,
    this.schedulePlan,
  });

  BandwidthProtocol.fromJson(dynamic json) {
    policy = json['policy'];
    protocol = json['protocol'];
    schedulePlan = json['schedule_plan'];
  }
  String? policy;
  String? protocol;
  String? schedulePlan;
  BandwidthProtocol copyWith({
    String? policy,
    String? protocol,
    String? schedulePlan,
  }) =>
      BandwidthProtocol(
        policy: policy ?? this.policy,
        protocol: protocol ?? this.protocol,
        schedulePlan: schedulePlan ?? this.schedulePlan,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['policy'] = policy;
    map['protocol'] = protocol;
    map['schedule_plan'] = schedulePlan;
    return map;
  }
}
