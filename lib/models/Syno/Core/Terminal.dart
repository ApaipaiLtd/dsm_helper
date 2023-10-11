import 'package:dsm_helper/apis/api.dart';
import 'package:dsm_helper/apis/dsm_api/dsm_response.dart';

/// enable_ssh : true
/// enable_telnet : false
/// forbid_console : false
/// ssh_cipher : [{"hardware_support":false,"in_use":false,"name":"3des-cbc","security_level":0},{"hardware_support":false,"in_use":false,"name":"aes128-cbc","security_level":0},{"hardware_support":false,"in_use":true,"name":"aes128-ctr","security_level":2},{"hardware_support":false,"in_use":true,"name":"aes128-gcm@openssh.com","security_level":2},{"hardware_support":false,"in_use":false,"name":"aes192-cbc","security_level":0},{"hardware_support":false,"in_use":true,"name":"aes192-ctr","security_level":2},{"hardware_support":false,"in_use":false,"name":"aes256-cbc","security_level":0},{"hardware_support":false,"in_use":true,"name":"aes256-ctr","security_level":2},{"hardware_support":false,"in_use":true,"name":"aes256-gcm@openssh.com","security_level":2},{"hardware_support":false,"in_use":true,"name":"chacha20-poly1305@openssh.com","security_level":2},{"hardware_support":false,"in_use":false,"name":"rijndael-cbc@lysator.liu.se","security_level":0}]
/// ssh_kex : [{"hardware_support":false,"in_use":true,"name":"curve25519-sha256","security_level":2},{"hardware_support":false,"in_use":true,"name":"curve25519-sha256@libssh.org","security_level":2},{"hardware_support":false,"in_use":false,"name":"diffie-hellman-group-exchange-sha1","security_level":0},{"hardware_support":false,"in_use":true,"name":"diffie-hellman-group-exchange-sha256","security_level":2},{"hardware_support":false,"in_use":false,"name":"diffie-hellman-group1-sha1","security_level":0},{"hardware_support":false,"in_use":false,"name":"diffie-hellman-group14-sha1","security_level":0},{"hardware_support":false,"in_use":true,"name":"diffie-hellman-group14-sha256","security_level":2},{"hardware_support":false,"in_use":true,"name":"diffie-hellman-group16-sha512","security_level":2},{"hardware_support":false,"in_use":true,"name":"diffie-hellman-group18-sha512","security_level":2},{"hardware_support":false,"in_use":true,"name":"ecdh-sha2-nistp256","security_level":1},{"hardware_support":false,"in_use":true,"name":"ecdh-sha2-nistp384","security_level":1},{"hardware_support":false,"in_use":true,"name":"ecdh-sha2-nistp521","security_level":1},{"hardware_support":false,"in_use":false,"name":"sntrup4591761x25519-sha512@tinyssh.org","security_level":0}]
/// ssh_mac : [{"hardware_support":false,"in_use":false,"name":"hmac-md5","security_level":0},{"hardware_support":false,"in_use":false,"name":"hmac-md5-96","security_level":0},{"hardware_support":false,"in_use":false,"name":"hmac-md5-96-etm@openssh.com","security_level":0},{"hardware_support":false,"in_use":false,"name":"hmac-md5-etm@openssh.com","security_level":0},{"hardware_support":false,"in_use":true,"name":"hmac-sha1","security_level":1},{"hardware_support":false,"in_use":false,"name":"hmac-sha1-96","security_level":0},{"hardware_support":false,"in_use":false,"name":"hmac-sha1-96-etm@openssh.com","security_level":0},{"hardware_support":false,"in_use":true,"name":"hmac-sha1-etm@openssh.com","security_level":1},{"hardware_support":false,"in_use":true,"name":"hmac-sha2-256","security_level":2},{"hardware_support":false,"in_use":true,"name":"hmac-sha2-256-etm@openssh.com","security_level":2},{"hardware_support":false,"in_use":true,"name":"hmac-sha2-512","security_level":2},{"hardware_support":false,"in_use":true,"name":"hmac-sha2-512-etm@openssh.com","security_level":2},{"hardware_support":false,"in_use":true,"name":"umac-128-etm@openssh.com","security_level":2},{"hardware_support":false,"in_use":true,"name":"umac-128@openssh.com","security_level":2},{"hardware_support":false,"in_use":true,"name":"umac-64-etm@openssh.com","security_level":1},{"hardware_support":false,"in_use":true,"name":"umac-64@openssh.com","security_level":1}]
/// ssh_port : 22

class Terminal {
  Terminal({
    this.enableSsh,
    this.enableTelnet,
    this.forbidConsole,
    this.sshCipher,
    this.sshKex,
    this.sshMac,
    this.sshPort,
  });

  static Future<Terminal> get() async {
    DsmResponse res = await Api.dsm.entry("SYNO.Core.Terminal", "get", version: 1, parser: Terminal.fromJson);
    return res.data;
  }

  Future<bool?> set() async {
    DsmResponse res = await Api.dsm.entry("SYNO.Core.Terminal", "set", version: 1, data: {
      "enable_ssh": enableSsh,
      "enable_telnet": enableTelnet,
      "ssh_port": sshPort,
    });
    return res.success;
  }

  Terminal.fromJson(dynamic json) {
    enableSsh = json['enable_ssh'];
    enableTelnet = json['enable_telnet'];
    forbidConsole = json['forbid_console'];
    if (json['ssh_cipher'] != null) {
      sshCipher = [];
      json['ssh_cipher'].forEach((v) {
        sshCipher?.add(SshModule.fromJson(v));
      });
    }
    if (json['ssh_kex'] != null) {
      sshKex = [];
      json['ssh_kex'].forEach((v) {
        sshKex?.add(SshModule.fromJson(v));
      });
    }
    if (json['ssh_mac'] != null) {
      sshMac = [];
      json['ssh_mac'].forEach((v) {
        sshMac?.add(SshModule.fromJson(v));
      });
    }
    sshPort = json['ssh_port'];
  }
  bool? enableSsh;
  bool? enableTelnet;
  bool? forbidConsole;
  List<SshModule>? sshCipher;
  List<SshModule>? sshKex;
  List<SshModule>? sshMac;
  num? sshPort;
  Terminal copyWith({
    bool? enableSsh,
    bool? enableTelnet,
    bool? forbidConsole,
    List<SshModule>? sshCipher,
    List<SshModule>? sshKex,
    List<SshModule>? sshMac,
    num? sshPort,
  }) =>
      Terminal(
        enableSsh: enableSsh ?? this.enableSsh,
        enableTelnet: enableTelnet ?? this.enableTelnet,
        forbidConsole: forbidConsole ?? this.forbidConsole,
        sshCipher: sshCipher ?? this.sshCipher,
        sshKex: sshKex ?? this.sshKex,
        sshMac: sshMac ?? this.sshMac,
        sshPort: sshPort ?? this.sshPort,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['enable_ssh'] = enableSsh;
    map['enable_telnet'] = enableTelnet;
    map['forbid_console'] = forbidConsole;
    if (sshCipher != null) {
      map['ssh_cipher'] = sshCipher?.map((v) => v.toJson()).toList();
    }
    if (sshKex != null) {
      map['ssh_kex'] = sshKex?.map((v) => v.toJson()).toList();
    }
    if (sshMac != null) {
      map['ssh_mac'] = sshMac?.map((v) => v.toJson()).toList();
    }
    map['ssh_port'] = sshPort;
    return map;
  }
}

/// hardware_support : false
/// in_use : false
/// name : "hmac-md5"
/// security_level : 0

class SshModule {
  SshModule({
    this.hardwareSupport,
    this.inUse,
    this.name,
    this.securityLevel,
  });

  SshModule.fromJson(dynamic json) {
    hardwareSupport = json['hardware_support'];
    inUse = json['in_use'];
    name = json['name'];
    securityLevel = json['security_level'];
  }
  bool? hardwareSupport;
  bool? inUse;
  String? name;
  num? securityLevel;
  SshModule copyWith({
    bool? hardwareSupport,
    bool? inUse,
    String? name,
    num? securityLevel,
  }) =>
      SshModule(
        hardwareSupport: hardwareSupport ?? this.hardwareSupport,
        inUse: inUse ?? this.inUse,
        name: name ?? this.name,
        securityLevel: securityLevel ?? this.securityLevel,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['hardware_support'] = hardwareSupport;
    map['in_use'] = inUse;
    map['name'] = name;
    map['security_level'] = securityLevel;
    return map;
  }
}
