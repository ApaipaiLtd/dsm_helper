import 'package:dsm_helper/models/base_model.dart';

/// enable_avahi : true
/// enable_custom_domain : false
/// enable_hsts : false
/// enable_https_redirect : false
/// enable_max_connections : false
/// enable_reuseport : false
/// enable_server_header : true
/// enable_spdy : true
/// enable_ssdp : true
/// fqdn : null
/// http_port : 5000
/// https_port : 5001
/// max_connections : 2048
/// max_connections_limit : {"lower":2048,"upper":131070}
/// server_header : "nginx"
/// support_reuseport : true

class Dsm extends BaseModel {
  Dsm({
    this.enableAvahi,
    this.enableCustomDomain,
    this.enableHsts,
    this.enableHttpsRedirect,
    this.enableMaxConnections,
    this.enableReuseport,
    this.enableServerHeader,
    this.enableSpdy,
    this.enableSsdp,
    this.fqdn,
    this.httpPort,
    this.httpsPort,
    this.maxConnections,
    this.maxConnectionsLimit,
    this.serverHeader,
    this.supportReuseport,
  });

  String? api = "SYNO.Core.Web.DSM";
  String? method = "get";
  int? version = 2;

  Dsm.fromJson(dynamic json) {
    enableAvahi = json['enable_avahi'];
    enableCustomDomain = json['enable_custom_domain'];
    enableHsts = json['enable_hsts'];
    enableHttpsRedirect = json['enable_https_redirect'];
    enableMaxConnections = json['enable_max_connections'];
    enableReuseport = json['enable_reuseport'];
    enableServerHeader = json['enable_server_header'];
    enableSpdy = json['enable_spdy'];
    enableSsdp = json['enable_ssdp'];
    fqdn = json['fqdn'];
    httpPort = json['http_port'];
    httpsPort = json['https_port'];
    maxConnections = json['max_connections'];
    maxConnectionsLimit = json['max_connections_limit'] != null ? MaxConnectionsLimit.fromJson(json['max_connections_limit']) : null;
    serverHeader = json['server_header'];
    supportReuseport = json['support_reuseport'];
  }
  bool? enableAvahi;
  bool? enableCustomDomain;
  bool? enableHsts;
  bool? enableHttpsRedirect;
  bool? enableMaxConnections;
  bool? enableReuseport;
  bool? enableServerHeader;
  bool? enableSpdy;
  bool? enableSsdp;
  dynamic fqdn;
  int? httpPort;
  int? httpsPort;
  int? maxConnections;
  MaxConnectionsLimit? maxConnectionsLimit;
  String? serverHeader;
  bool? supportReuseport;
  Dsm copyWith({
    bool? enableAvahi,
    bool? enableCustomDomain,
    bool? enableHsts,
    bool? enableHttpsRedirect,
    bool? enableMaxConnections,
    bool? enableReuseport,
    bool? enableServerHeader,
    bool? enableSpdy,
    bool? enableSsdp,
    dynamic fqdn,
    int? httpPort,
    int? httpsPort,
    int? maxConnections,
    MaxConnectionsLimit? maxConnectionsLimit,
    String? serverHeader,
    bool? supportReuseport,
  }) =>
      Dsm(
        enableAvahi: enableAvahi ?? this.enableAvahi,
        enableCustomDomain: enableCustomDomain ?? this.enableCustomDomain,
        enableHsts: enableHsts ?? this.enableHsts,
        enableHttpsRedirect: enableHttpsRedirect ?? this.enableHttpsRedirect,
        enableMaxConnections: enableMaxConnections ?? this.enableMaxConnections,
        enableReuseport: enableReuseport ?? this.enableReuseport,
        enableServerHeader: enableServerHeader ?? this.enableServerHeader,
        enableSpdy: enableSpdy ?? this.enableSpdy,
        enableSsdp: enableSsdp ?? this.enableSsdp,
        fqdn: fqdn ?? this.fqdn,
        httpPort: httpPort ?? this.httpPort,
        httpsPort: httpsPort ?? this.httpsPort,
        maxConnections: maxConnections ?? this.maxConnections,
        maxConnectionsLimit: maxConnectionsLimit ?? this.maxConnectionsLimit,
        serverHeader: serverHeader ?? this.serverHeader,
        supportReuseport: supportReuseport ?? this.supportReuseport,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['enable_avahi'] = enableAvahi;
    map['enable_custom_domain'] = enableCustomDomain;
    map['enable_hsts'] = enableHsts;
    map['enable_https_redirect'] = enableHttpsRedirect;
    map['enable_max_connections'] = enableMaxConnections;
    map['enable_reuseport'] = enableReuseport;
    map['enable_server_header'] = enableServerHeader;
    map['enable_spdy'] = enableSpdy;
    map['enable_ssdp'] = enableSsdp;
    map['fqdn'] = fqdn;
    map['http_port'] = httpPort;
    map['https_port'] = httpsPort;
    map['max_connections'] = maxConnections;
    if (maxConnectionsLimit != null) {
      map['max_connections_limit'] = maxConnectionsLimit?.toJson();
    }
    map['server_header'] = serverHeader;
    map['support_reuseport'] = supportReuseport;
    return map;
  }

  @override
  fromJson(json) {
    return Dsm.fromJson(json);
  }
}

/// lower : 2048
/// upper : 131070

class MaxConnectionsLimit {
  MaxConnectionsLimit({
    this.lower,
    this.upper,
  });

  MaxConnectionsLimit.fromJson(dynamic json) {
    lower = json['lower'];
    upper = json['upper'];
  }
  int? lower;
  int? upper;
  MaxConnectionsLimit copyWith({
    int? lower,
    int? upper,
  }) =>
      MaxConnectionsLimit(
        lower: lower ?? this.lower,
        upper: upper ?? this.upper,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['lower'] = lower;
    map['upper'] = upper;
    return map;
  }
}
