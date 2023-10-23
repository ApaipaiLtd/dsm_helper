import 'package:dsm_helper/apis/api.dart';

/// cluster_status : "normal"
/// guest_summ : {"error":0,"healthy":1,"running":1,"warning":0}
/// host_summ : {"error":0,"healthy":1,"warning":0}
/// license_summ : {"error":0,"healthy":0,"warning":0}
/// reasons : [{"num":0,"status":"normal"}]
/// repo_summ : {"error":0,"healthy":1,"warning":0}

class ClusterSummary {
  ClusterSummary({
    this.clusterStatus,
    this.guestSumm,
    this.hostSumm,
    this.licenseSumm,
    this.reasons,
    this.repoSumm,
  });

  static Future<ClusterSummary> get() async {
    DsmResponse res = await Api.dsm.entry("SYNO.Virtualization.Cluster", "get", version: 1, parser: ClusterSummary.fromJson);
    return res.data;
  }

  ClusterSummary.fromJson(dynamic json) {
    clusterStatus = json['cluster_status'];
    guestSumm = json['guest_summ'] != null ? Summary.fromJson(json['guest_summ']) : null;
    hostSumm = json['host_summ'] != null ? Summary.fromJson(json['host_summ']) : null;
    licenseSumm = json['license_summ'] != null ? Summary.fromJson(json['license_summ']) : null;
    if (json['reasons'] != null) {
      reasons = [];
      json['reasons'].forEach((v) {
        reasons?.add(Reasons.fromJson(v));
      });
    }
    repoSumm = json['repo_summ'] != null ? Summary.fromJson(json['repo_summ']) : null;
  }
  String? clusterStatus;
  Summary? guestSumm;
  Summary? hostSumm;
  Summary? licenseSumm;
  List<Reasons>? reasons;
  Summary? repoSumm;
  ClusterSummary copyWith({
    String? clusterStatus,
    Summary? guestSumm,
    Summary? hostSumm,
    Summary? licenseSumm,
    List<Reasons>? reasons,
    Summary? repoSumm,
  }) =>
      ClusterSummary(
        clusterStatus: clusterStatus ?? this.clusterStatus,
        guestSumm: guestSumm ?? this.guestSumm,
        hostSumm: hostSumm ?? this.hostSumm,
        licenseSumm: licenseSumm ?? this.licenseSumm,
        reasons: reasons ?? this.reasons,
        repoSumm: repoSumm ?? this.repoSumm,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['cluster_status'] = clusterStatus;
    if (guestSumm != null) {
      map['guest_summ'] = guestSumm?.toJson();
    }
    if (hostSumm != null) {
      map['host_summ'] = hostSumm?.toJson();
    }
    if (licenseSumm != null) {
      map['license_summ'] = licenseSumm?.toJson();
    }
    if (reasons != null) {
      map['reasons'] = reasons?.map((v) => v.toJson()).toList();
    }
    if (repoSumm != null) {
      map['repo_summ'] = repoSumm?.toJson();
    }
    return map;
  }
}

/// num : 0
/// status : "normal"

class Reasons {
  Reasons({
    this.number,
    this.status,
  });

  Reasons.fromJson(dynamic json) {
    number = json['num'];
    status = json['status'];
  }
  num? number;
  String? status;
  Reasons copyWith({
    num? num,
    String? status,
  }) =>
      Reasons(
        number: num ?? this.number,
        status: status ?? this.status,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['num'] = number;
    map['status'] = status;
    return map;
  }
}

/// error : 0
/// healthy : 1
/// running : 1
/// warning : 0

class Summary {
  Summary({
    this.error,
    this.healthy,
    this.running,
    this.warning,
  });

  Summary.fromJson(dynamic json) {
    error = json['error'];
    healthy = json['healthy'];
    running = json['running'];
    warning = json['warning'];
  }
  num? error;
  num? healthy;
  num? running;
  num? warning;
  num get total => (error ?? 0) + (healthy ?? 0) + (running ?? 0) + (warning ?? 0);
  Summary copyWith({
    num? error,
    num? healthy,
    num? running,
    num? warning,
  }) =>
      Summary(
        error: error ?? this.error,
        healthy: healthy ?? this.healthy,
        running: running ?? this.running,
        warning: warning ?? this.warning,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['error'] = error;
    map['healthy'] = healthy;
    map['running'] = running;
    map['warning'] = warning;
    return map;
  }
}
