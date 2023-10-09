/// enable : false
/// enable_custom_config : false
/// enable_rsync_account : false
/// rsync_sshd_port : "22"

class NetworkBackup {
  NetworkBackup({
    this.enable,
    this.enableCustomConfig,
    this.enableRsyncAccount,
    this.rsyncSshdPort,
  });

  NetworkBackup.fromJson(dynamic json) {
    enable = json['enable'];
    enableCustomConfig = json['enable_custom_config'];
    enableRsyncAccount = json['enable_rsync_account'];
    rsyncSshdPort = json['rsync_sshd_port'];
  }
  bool? enable;
  bool? enableCustomConfig;
  bool? enableRsyncAccount;
  String? rsyncSshdPort;
  NetworkBackup copyWith({
    bool? enable,
    bool? enableCustomConfig,
    bool? enableRsyncAccount,
    String? rsyncSshdPort,
  }) =>
      NetworkBackup(
        enable: enable ?? this.enable,
        enableCustomConfig: enableCustomConfig ?? this.enableCustomConfig,
        enableRsyncAccount: enableRsyncAccount ?? this.enableRsyncAccount,
        rsyncSshdPort: rsyncSshdPort ?? this.rsyncSshdPort,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['enable'] = enable;
    map['enable_custom_config'] = enableCustomConfig;
    map['enable_rsync_account'] = enableRsyncAccount;
    map['rsync_sshd_port'] = rsyncSshdPort;
    return map;
  }
}
